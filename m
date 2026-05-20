Return-Path: <stable+bounces-251121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIduIp0XDmpT6AUAu9opvQ
	(envelope-from <stable+bounces-251121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:20:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDE2599788
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B11A303DA9A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356923F44EA;
	Wed, 20 May 2026 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="11lAVWlq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C823F39D7;
	Wed, 20 May 2026 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297152; cv=none; b=rgXtyvFFwpcuK82oXt/Vj3ly46akoWQXMrDETALk/imEmSawa3Jx9hdCRf6/zUqqwy22SuxuxfIFLMw4k+sUQwJRVEFLOuczumSlh6phoPMZxPeKIw78nsvV1JeowL5dCMNJ8YoJSNPyrch2bzYEFVXNoDeI2xqZNk4ckwzo7oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297152; c=relaxed/simple;
	bh=gjGmxZb129nCov9wmKDhJOBAzOeQ+SD0bHJ5ap7oUwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EbJM07DO83fkdbdiWzOx8RlKIlB6VrsGhJyYbdH4lpzyEsfIOvEbPURkCA/mFzqrkVu0/Iuv5EH3SaS9z1Ll/Pi+TuypBF2uStZBLOOHAmz4gDmL9Ghn+hmFm0ykc4bGvIdlhj1kfNuSnd33Xn6c7Gdm0nhpDyQ+gChQh3QbI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=11lAVWlq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551361F000E9;
	Wed, 20 May 2026 17:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779297151;
	bh=G5KAOXNXaYbF1oy7Nj3XitwCT9yrcsY1Yc33icSyyDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=11lAVWlq+F86lpjH6oT50557E+LL6vivfkQVcl612vXdDfTaCE4XIaCCelrQAdFQu
	 WuaLkmWZo9zXC+zPAgL/zc2kw1amKXW1fTRfSJaT4fwAVP62P3MM4IozBW3vH2sPfe
	 yk8yqF8JO1kTUrhCY1Bktu7Zo2/irYrhs18aTSBI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuriy Havrylyuk <yhavry@gmail.com>,
	Sven Peter <sven@kernel.org>,
	Nick Chan <towinchenmi@gmail.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 7.0 1070/1146] nvme-apple: Reset q->sq_tail during queue init
Date: Wed, 20 May 2026 18:22:00 +0200
Message-ID: <20260520162212.447891265@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251121-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6EDE2599788
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nick Chan <towinchenmi@gmail.com>

commit a6ab75639e23169a741b0b2e12191fd8acb32c73 upstream.

Fixes a "duplicate tag error for tag 0" firmware crash during controller
reset while setting up a  queue on Apple A11 / T8015 caused by stale
entries in the submission queue due to an invalid sq_tail offset after
reset.

Fixes: 04d8ecf37b5e ("nvme: apple: Add Apple A11 support")
Cc: stable@vger.kernel.org
Suggested-by: Yuriy Havrylyuk <yhavry@gmail.com>
Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/apple.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1009,6 +1009,7 @@ static void apple_nvme_init_queue(struct
 	unsigned int depth = apple_nvme_queue_depth(q);
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
 
+	q->sq_tail = 0;
 	q->cq_head = 0;
 	q->cq_phase = 1;
 	if (anv->hw->has_lsq_nvmmu)



