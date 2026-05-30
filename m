Return-Path: <stable+bounces-257788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AKZHQEgG2qu/QgAu9opvQ
	(envelope-from <stable+bounces-257788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:36:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE42C60FFF2
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B475A3052B55
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF65E33B6C4;
	Sat, 30 May 2026 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ry4gMGyL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFE30148B;
	Sat, 30 May 2026 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162173; cv=none; b=FLY+awBObhTyUpk61M6YkIAXxoTdixCr+Dp3MI9x+6Ly5tICXT0k3G90j3wD2bvSREmkybUaGElPknuPA69lVVKbQzDUn0lQCjWHwMAq7a4ggzvFC2wP3mVAFAytzesRSqlyfYPttmiQsoIZyvzwjre90mV/35RtSOOKGr1sdJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162173; c=relaxed/simple;
	bh=eqwCpnsioG2JQfAK8owim8ofqXfMHbpzrQTl0891PbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aadzHvgcMpeMruxIvREczA+vhG93iqqsYR8p0wDhRUjPmAq6CwFcrTuBMF4D4c60S0M6Pqzil7oHrKfjmnSDViLI1QggNtmHsagSZ9NLpLbAynWUh0pqfAah4q0KXNM+wtn+VgeTjUPwZ5oJq4d73SblCQ7gKa9HyX5YPGEBTqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ry4gMGyL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D59B01F00893;
	Sat, 30 May 2026 17:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162172;
	bh=D5z/JS1zN/FTZHE4fMD3NSNnb6GQDoWrhGUI647R99Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ry4gMGyLk4HL7ZLBhpW8NI2YaMRZE2Bdgm1FloRS00ucqzuDAsW5NFVPqZnD4STUx
	 d1IonjP3mLLtDxoxEkXe0siyt6xmrjCAD3mPBF82001JlYQTHk6+lI4g2VmmyPSSIB
	 uW23iDEFB7YLkmswVuSOd9pvtHbTZYCYM1GNdQrY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 843/969] net: wwan: iosm: fix potential memory leaks in ipc_imem_init()
Date: Sat, 30 May 2026 18:06:07 +0200
Message-ID: <20260530160323.933833707@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257788-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iitm.ac.in:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CE42C60FFF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

commit c5d93b2c40355e999715262a824965aac025a427 upstream.

The memory allocated in ipc_protocol_init() is not freed on the error
paths that follow in ipc_imem_init(). Fix that by calling the
corresponding release function ipc_protocol_deinit() in the error path.

Fixes: 3670970dd8c6 ("net: iosm: shared memory IPC interface")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Link: https://patch.msgid.link/20260519062815.55545-1-nihaal@cse.iitm.ac.in
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wwan/iosm/iosm_ipc_imem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1423,6 +1423,8 @@ imem_config_fail:
 protocol_init_fail:
 	cancel_work_sync(&ipc_imem->run_state_worker);
 	ipc_task_deinit(ipc_imem->ipc_task);
+	if (ipc_imem->ipc_protocol)
+		ipc_protocol_deinit(ipc_imem->ipc_protocol);
 ipc_task_init_fail:
 	kfree(ipc_imem->ipc_task);
 ipc_task_fail:



