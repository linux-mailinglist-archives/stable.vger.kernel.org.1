Return-Path: <stable+bounces-228829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEROEZBUwWkYSQQAu9opvQ
	(envelope-from <stable+bounces-228829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:56:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7432F5760
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBA9830B2405
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DFF23C4FF;
	Mon, 23 Mar 2026 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="giHaf6U4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB831A5B84;
	Mon, 23 Mar 2026 14:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277248; cv=none; b=YxXszVqdDs/v/+7tr9E5ZkcAWezjhWPukPznTZ36By8iAYFsp1EdFzO94/n94qHR+cQ+oDv8YL0rHfAp2SzTbti3MXCvYmbezTeGSWb3OO14YAxGQ/OeBCZnJriInaKAtYSLxLNwvHJU+WzsjHNLZ7+ckFiNk6uxCe83eaAVuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277248; c=relaxed/simple;
	bh=3Z4xaFDWhsIOF+VurN1BF2aBY78FX2NIzYXZ+8sLFOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZwRrou6R2cL+Y0oSlD6E0UMM9DheA12tNd85jRe3dIXYBUwSTTnwcVPhKAxSjDRjjj/RpitGRmG0f6Y2FlMjyAMaFfOjYu7ToEGBZA6V/VKQMSCqJYlcc3o5QXDIeNnlWuOyoAbDuK4aZwBCbM04It0gVVdjdEkVhawpzIgIb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=giHaf6U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612A9C4CEF7;
	Mon, 23 Mar 2026 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277248;
	bh=3Z4xaFDWhsIOF+VurN1BF2aBY78FX2NIzYXZ+8sLFOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=giHaf6U4Kvf8McI4kFv4yRwey1GQykWMnrtz6YkTlLz0iK4QQfVTfxOnYk4VDk3/f
	 FMiHzQ6TVmSDxNPS9nXRaYra9geGYpdf+mccB8xeC7164h6ka7I+pISNrg+hawHuuV
	 eR3UiPgSXY82WdpsYscHThJ8sHUer/W2W6Fl3i94=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 369/460] cache: starfive: fix device node leak in starlink_cache_init()
Date: Mon, 23 Mar 2026 14:46:05 +0100
Message-ID: <20260323134535.632107525@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134526.647552166@linuxfoundation.org>
References: <20260323134526.647552166@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,huawei.com,microchip.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228829-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.932];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CB7432F5760
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit 3c85234b979af71cb9db5eb976ea08a468415767 ]

of_find_matching_node() returns a device_node with refcount incremented.

Use __free(device_node) attribute to automatically call of_node_put()
when the variable goes out of scope, preventing the refcount leak.

Fixes: cabff60ca77d ("cache: Add StarFive StarLink cache management")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cache/starfive_starlink_cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cache/starfive_starlink_cache.c b/drivers/cache/starfive_starlink_cache.c
index 24c7d078ca227..3a25d2d7c70ca 100644
--- a/drivers/cache/starfive_starlink_cache.c
+++ b/drivers/cache/starfive_starlink_cache.c
@@ -102,11 +102,11 @@ static const struct of_device_id starlink_cache_ids[] = {
 
 static int __init starlink_cache_init(void)
 {
-	struct device_node *np;
 	u32 block_size;
 	int ret;
 
-	np = of_find_matching_node(NULL, starlink_cache_ids);
+	struct device_node *np __free(device_node) =
+		of_find_matching_node(NULL, starlink_cache_ids);
 	if (!of_device_is_available(np))
 		return -ENODEV;
 
-- 
2.51.0




