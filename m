Return-Path: <stable+bounces-142993-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2922AB0CBF
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 10:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1721BA33A0
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18C02741CF;
	Fri,  9 May 2025 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bh4dgFjA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9042741A2
	for <stable@vger.kernel.org>; Fri,  9 May 2025 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778257; cv=none; b=tNVuMDBfnDhdBZdvxdqC5r8oNA/Rp7BPR3rVWR0tIPSTecTZghIz7EWRlIthw72JNBPalWdLTDLl/9wIUeLVoyAY+vMX5bXdvrT09vg3X3+BSC7p9IvsdOxZ2NSaWy84zfUg+AH02UgO6TBkUNu6IHsvEGZjzWXwy1qfQa4PzzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778257; c=relaxed/simple;
	bh=AcCaQKXu+f/HBKffFYS1J06GOOZ53v2j6Hp0oG661I4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EA1lBoBTAcFzedSaLHEyQj9cr5zeFitfhbJe9Hiq9YWGjX++jIdHsCZalxu+LoQdA8hB3u+IRo/55PBmFma4wEj3ygFHUO/ps+xDfEO8B52oTBg/ccLRzoRCpFnNrqw1TjGpphg43MGSdm1kVj8NcfPRaOyWPrKvmlhYUFCEvE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bh4dgFjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7043DC4CEE4;
	Fri,  9 May 2025 08:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746778256;
	bh=AcCaQKXu+f/HBKffFYS1J06GOOZ53v2j6Hp0oG661I4=;
	h=Subject:To:Cc:From:Date:From;
	b=bh4dgFjA4elt9iHDsbX994O4H+bJxeGJi384grP5KZvdzsuFP/9GyuCO23IpMC5ai
	 TJoqpKO5el4kwWF+B61vULseHquE2raQECPFHa6d0thC6UJU6BVVYrPOPsugjJc7yR
	 TjUKg3ffP7RgVoD2CdhvbbTStxMtekpOXWyX4VSo=
Subject: FAILED: patch "[PATCH] dm: add missing unlock on in dm_keyslot_evict()" failed to apply to 5.12-stable tree
To: dan.carpenter@linaro.org,mpatocka@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 09 May 2025 10:10:54 +0200
Message-ID: <2025050954-excretion-yonder-4e95@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.12.y
git checkout FETCH_HEAD
git cherry-pick -x 650266ac4c7230c89bcd1307acf5c9c92cfa85e2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025050954-excretion-yonder-4e95@gregkh' --subject-prefix 'PATCH 5.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 650266ac4c7230c89bcd1307acf5c9c92cfa85e2 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@linaro.org>
Date: Wed, 30 Apr 2025 11:05:54 +0300
Subject: [PATCH] dm: add missing unlock on in dm_keyslot_evict()

We need to call dm_put_live_table() even if dm_get_live_table() returns
NULL.

Fixes: 9355a9eb21a5 ("dm: support key eviction from keyslot managers of underlying devices")
Cc: stable@vger.kernel.org	# v5.12+
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 9e175c5e0634..31d67a1a91dd 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1173,7 +1173,7 @@ static int dm_keyslot_evict(struct blk_crypto_profile *profile,
 
 	t = dm_get_live_table(md, &srcu_idx);
 	if (!t)
-		return 0;
+		goto put_live_table;
 
 	for (unsigned int i = 0; i < t->num_targets; i++) {
 		struct dm_target *ti = dm_table_get_target(t, i);
@@ -1184,6 +1184,7 @@ static int dm_keyslot_evict(struct blk_crypto_profile *profile,
 					  (void *)key);
 	}
 
+put_live_table:
 	dm_put_live_table(md, srcu_idx);
 	return 0;
 }


