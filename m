Return-Path: <stable+bounces-257792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FLnCX0fG2rO/QgAu9opvQ
	(envelope-from <stable+bounces-257792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:33:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A7160FEE5
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5563305D5A8
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8997340298;
	Sat, 30 May 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wsC/oYv+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1357342CA7;
	Sat, 30 May 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780162186; cv=none; b=bR8k3lw6uZE7GZOhhq6qthA4fOS0QJO23sJ27MfRFkyc//J0SowvH0FckL29e/mbqxRtTNYR29sy7O/WHYFL3kHiCYpHnAPB3mmsge2jwiK15WoMLnov0YPLJgafZHDMbuTxRixNQQpcjVGEtmHf6CMDVz+LhNlX38HIofeD+Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780162186; c=relaxed/simple;
	bh=+retFB05BuwKyc76TnmUj0SBP4ZvRMjoRyYVxFPyjT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rrm8oCbsl2OlqtK87wEMBCfOfgSmlNaokt/s+G8bIo4+xrIDyR0IdZNuWaWc8bJC5KIHeOyoWxL1qr6FilIiy1XUqvif/C/Qc9vhc16NX23qdazmKKUE6L7TU6ROypHvBhBz1I4QGq+30B+ZS+Ln4E50q04iWLcj8PIc8bEbC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wsC/oYv+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116A71F00893;
	Sat, 30 May 2026 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780162185;
	bh=ssk0lapLN50ke+3He4OMiK3HESF8wocws1O7w86AVYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wsC/oYv+93kNJZUpk5kRPYH9Gu0vDTiAkRE3t4J7i0Tyiu+xyXr1XegNO3DOUFaGR
	 Tt7OEGl6YLEtr2hfLuSAYYPjTgpjg933sT5NhfZTnHfRGDIer7ZgsEYY30YR6r2RDI
	 rlWH4LwfAlGNh+HROpXT3Ig+YWkGoe+2lV5KzJrM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jann Horn <jannh@google.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 6.1 846/969] Bluetooth: bnep: Fix UAF read of dev->name
Date: Sat, 30 May 2026 18:06:10 +0200
Message-ID: <20260530160324.022896781@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257792-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 93A7160FEE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 59e932ded949fa6f0340bf7c6d7818f962fa4fd2 upstream.

bnep_add_connection() needs to keep holding the bnep_session_sem while
reading dev->name (just like bnep_get_connlist() does); otherwise the
bnep_session() thread can concurrently free the net_device, which can for
example be triggered by a concurrent bnep_del_connection().

(This UAF is fairly uninteresting from a security perspective;
calling bnep_add_connection() requires passing a capable(CAP_NET_ADMIN)
check. It also requires completely tearing down a netdev during a fairly
tight race window.)

Cc: stable@vger.kernel.org
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/bnep/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -638,8 +638,8 @@ int bnep_add_connection(struct bnep_conn
 		goto failed;
 	}
 
-	up_write(&bnep_session_sem);
 	strcpy(req->device, dev->name);
+	up_write(&bnep_session_sem);
 	return 0;
 
 failed:



