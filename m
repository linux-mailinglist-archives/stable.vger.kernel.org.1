Return-Path: <stable+bounces-118353-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C508A3CC18
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 23:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D748C3BAD26
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 22:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C53A2586ED;
	Wed, 19 Feb 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyNX/yC+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0FC22CBC7
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 22:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003007; cv=none; b=EEujp1Krvz7dUx6fE2lsghjMT/vXlykVGasPjIqp8NV8lZrD6nsWva+76TINAFDJPVTqBtljoUbGTxKVZ0jzgW32+oP+8nD+KiDy8swZkS8T7ovhnfCfqTRwcbuv2uWtt9Q7Bg1A5YmWVIy2Z7HHvLPSY3TREbUYvwccCqorgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003007; c=relaxed/simple;
	bh=ELbORdLioyqj6zQtiZLKpH0bx4fMcSbBP4SQ8JCxI9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oM2CBuulijCJpgCiYrDzAO6VUekw4pzkHBuYeETWUdZRKHSNikR2OzDWJGa/t4Mvvts3jaSP2IjXA0B6yTTy3IzL5/LHJQDdks5wMJ2K2TgE9Tdd5tOgRp6SXurbhbLZxefj67OZGNupxAR5vD++pPAoK6VJNWx+rwoIMybDchE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyNX/yC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2DBC4CED1;
	Wed, 19 Feb 2025 22:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740003006;
	bh=ELbORdLioyqj6zQtiZLKpH0bx4fMcSbBP4SQ8JCxI9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TyNX/yC+o5bVkCz4FWjJsBUTflVlsBI4kK7MJ5jOuVSGuzkJIwD/Lg2wv4LHOmPOE
	 PNncDPdZ1VA5YkBgcf41qSvgI/OzwSKFNpXIgs0AdvhtF+1dZAfzarZ5IZjbv1TNJy
	 DCmg+56BDNJBwI3t9lCXU6lVXFh/momtfSVSDNDyM6SCNbQR11qzlJxmFoZwagrtiA
	 MrXb5K16nyy4mpXsgfOl9lgKYgalsR/ARkqoUS5i3MehndjjwSPHO7BZY65Q+VsItv
	 o6nk9v3PPln9gqMIoS7PAOPDvS2RUVvnG4ZrQzP8FdjVdNr2Rqi/LMq1csPtpbicgu
	 UGI8jIioJdv8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	hoeppner@linux.ibm.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] s390/dasd: Use correct lock while counting channel queue length
Date: Wed, 19 Feb 2025 17:10:03 -0500
Message-Id: <20250219170838-78abb751cd3c74fb@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20230614100236.726123-1-hoeppner@linux.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
❌ Build failures detected
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: ccc45cb4e7271c74dbb27776ae8f73d84557f5c6


Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (different SHA1: 1e1e2ee0cf7f)

Note: The patch differs from the upstream commit:
---
Failed to apply patch cleanly.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Failed     |  N/A       |

Build Errors:
Patch failed to apply on stable/linux-5.4.y. Reject:

diff a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c	(rejected hunks)
@@ -516,10 +516,10 @@ static int dasd_ioctl_information(struct dasd_block *block,
 
 	memcpy(dasd_info->type, base->discipline->name, 4);
 
-	spin_lock_irqsave(&block->queue_lock, flags);
+	spin_lock_irqsave(get_ccwdev_lock(base->cdev), flags);
 	list_for_each(l, &base->ccw_queue)
 		dasd_info->chanq_len++;
-	spin_unlock_irqrestore(&block->queue_lock, flags);
+	spin_unlock_irqrestore(get_ccwdev_lock(base->cdev), flags);
 
 	rc = 0;
 	if (copy_to_user(argp, dasd_info,

