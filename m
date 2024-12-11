Return-Path: <stable+bounces-100792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452DB9ED634
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154821658B4
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908623693E;
	Wed, 11 Dec 2024 18:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rn3B1KOZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VAq7PtWK"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D75236927;
	Wed, 11 Dec 2024 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943584; cv=none; b=PTbrsscnASvqMwjhWjvYRZlXLlBlo5ls5OTfewVIjuLHkcUScu0LirgyGczFeOYKW3gbGMzBiRNDci5xZ9MFOf/voq8LYlJvkShzlNuzSUTP0gfmRg7WwpTIfQ6YYcqXDoVj4Lk6pluecvCCtOZigbrkfiujh75zRhHaG0dvO0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943584; c=relaxed/simple;
	bh=HBGgbM8icO6CAyzdVJJZetFH0dvUvZ8noQl1USj1uFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KYEJ9sQD/B/Zn0c4E52uw7o6BSTP7tFBs1d5vSaPjraRFP/JIgIsXZ03O0GlFRa6bWBEzjrdgbTWmWKzX2EUs15ZtREcoxfS8b1vMeFLaDkvQOJy/IMEdi7WT2O5kLaB29zo9BCsnCM8gVMNco8+X06CG6FNH8q3p/JH5UvhQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rn3B1KOZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VAq7PtWK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733943581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPVFrgcrgC5NwjQ+LkxVSbLkmIl+chJ0CwBPvS6TMS4=;
	b=rn3B1KOZqyXTW2wJk2djnsMsqFD2HKM4hlWNByXqEQSNgIJ9fG7bRBoR4oeNcEkC9p4/Uf
	7mLC8TL5hEePVf675Nt24D10aXC7REmmjx3Yi7SWlechrUT3Hzyj/LbZ3sveoXgsFDWAS/
	dUBoY/2Qju36vwkaKd59nuKPnf85hFQVHRLKH3+F/eheXCDlhJWJfDqrT8gyMofyGXPWp3
	zw/1K6io5jYF1001KxdYcwwYyjdcrUreCv+RBuTefq4OTjFS+bRvxKMi1ryDLPFJig+AnR
	1dDUbCNI9rHNl/guFyGD/85z4sLcv/HfCZzA+Orqe0G+wJWX7yjxK/kv8jJMYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733943581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LPVFrgcrgC5NwjQ+LkxVSbLkmIl+chJ0CwBPvS6TMS4=;
	b=VAq7PtWKoxdM18EtckESCJKDM9tXYL7rioGYBfsmeTre2TzXDzmy/SUCxdGV2JOdNvHWu1
	jb6UoiAtedv99mDw==
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Jassi Brar <jassisinghbrar@gmail.com>, Mark
 Rutland <mark.rutland@arm.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>
Subject: Re: Patch "irqchip: Convert all platform MSI users to the new API"
 has been added to the 6.6-stable tree
In-Reply-To: <20241211183912.3808112-1-sashal@kernel.org>
References: <20241211183912.3808112-1-sashal@kernel.org>
Date: Wed, 11 Dec 2024 19:59:40 +0100
Message-ID: <878qsmavvn.ffs@tglx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Dec 11 2024 at 13:39, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>
>     irqchip: Convert all platform MSI users to the new API
>
> to the 6.6-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      irqchip-convert-all-platform-msi-users-to-the-new-ap.patch
> and it can be found in the queue-6.6 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
>
> commit 5df23ec861a0208ef524a27e44c694ca2decb7ea
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Sat Jan 27 21:47:34 2024 +0530
>
>     irqchip: Convert all platform MSI users to the new API
>     
>     [ Upstream commit 14fd06c776b5289a43c91cdc64bac3bdbc7b397e ]
>     
>     Switch all the users of the platform MSI domain over to invoke the new
>     interfaces which branch to the original platform MSI functions when the
>     irqdomain associated to the caller device does not yet provide MSI parent
>     functionality.
>     
>     No functional change.
>     
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>     Link: https://lore.kernel.org/r/20240127161753.114685-7-apatel@ventanamicro.com
>     Stable-dep-of: 64506b3d23a3 ("scsi: ufs: qcom: Only free platform MSIs when ESI is enabled")

This commit makes the invocation of

	platform_msi_domain_free_irqs_all(hba->dev);

conditional on

        if (host->esi_enabled)

The original code before 5df23ec861a0208ef524a27e44c694ca2decb7ea was:

        platform_msi_domain_free_irqs(hba->dev);

> @@ -1926,7 +1926,7 @@ static void ufs_qcom_remove(struct platform_device *pdev)
>  
>  	pm_runtime_get_sync(&(pdev)->dev);
>  	ufshcd_remove(hba);
> -	platform_msi_domain_free_irqs(hba->dev);
> +	platform_device_msi_free_irqs_all(hba->dev);
>  }

which means the whole backport is not required and just commit
64506b3d23a3 needs to be adjusted for pre 5df23ec861:

-	platform_msi_domain_free_irqs(hba->dev);
+	if (host->esi_enabled)
+		platform_msi_domain_free_irqs(hba->dev);

Thanks,

        tglx

