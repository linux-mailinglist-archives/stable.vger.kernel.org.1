Return-Path: <stable+bounces-258635-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFRJMGsrG2r//ggAu9opvQ
	(envelope-from <stable+bounces-258635-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:24:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B5A611AA0
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA54A30158BE
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF21233D9E;
	Sat, 30 May 2026 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TNrtlJ0x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F22F21E098;
	Sat, 30 May 2026 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165016; cv=none; b=dDgkOd5341sNAF4cemvD5p08Rw0V1vgh6tttqPuiKyOEAcpP9V8y4HDC0CcGo+TD4kdpiImO4zRtJc8DsiTTT+SBTck08k7Uk2yS3S55hpZtVZSaHM42RF0fcFdYMwi6v8ODIIaRuglLCjHrWPBGn08B/rl0IbPOMbBGlxz7kgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165016; c=relaxed/simple;
	bh=8XCTPGlaOcWgUJ4GryYQLVQpAtjN4AS9QU0jGobOIyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0O5uRVNFyUY1ml/sMfVyB8qV049LQ74K5JqWpp8IGrxVzqjVLDKp6jVZ9KAS/Z8d1NjBnbOCvR3U/VvarYHpavHBaeHADwFof0AzVGw0X6QYNpYdpPLfNiAMAmg9B4ucOGSfAkxsysByNeA3SJnyflls9V2Bnz++fvnKShPtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TNrtlJ0x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 024FB1F00893;
	Sat, 30 May 2026 18:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165015;
	bh=Np1kVJrDQdofNI4vb4SYB646+kqy8w85GUqFLp3JVnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TNrtlJ0x6vTpLlrPluf8eOxJTTBpCJ2aSKxyXi1gt13JOGqicxpWv2chrzL5kxPVn
	 9fcxWFu4yhjXnSIJVcN5U3UTWRS3sHfBiLZY6pBMhZdbQJ2XCp9SxYLItaIvaEO9nW
	 LUgjG8RWb4mH7EtgOX973FMhWOfWs9nm9MdhasJs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 726/776] firmware: arm_ffa: Skip free_pages on RX buffer alloc failure
Date: Sat, 30 May 2026 18:07:20 +0200
Message-ID: <20260530160258.583884743@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-258635-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 32B5A611AA0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@kernel.org>

[ Upstream commit 09527e2c534911619d7e098729711100290bc3e1 ]

If the RX buffer allocation fails in ffa_init(), the error path jumps to
free_pages even though no buffer has been allocated yet. Route that case
directly to free_drv_info so the cleanup path is only used after at
least one RX/TX buffer allocation has succeeded.

Fixes: 3bbfe9871005 ("firmware: arm_ffa: Add initial Arm FFA driver support")
Link: https://patch.msgid.link/20260428-ffa_fixes-v2-2-8595ae450034@kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index e4fb0c1ae4869..34351f8c4d6f3 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -687,7 +687,7 @@ static int __init ffa_init(void)
 	drv_info->rx_buffer = alloc_pages_exact(RXTX_BUFFER_SIZE, GFP_KERNEL);
 	if (!drv_info->rx_buffer) {
 		ret = -ENOMEM;
-		goto free_pages;
+		goto free_drv_info;
 	}
 
 	drv_info->tx_buffer = alloc_pages_exact(RXTX_BUFFER_SIZE, GFP_KERNEL);
-- 
2.53.0




