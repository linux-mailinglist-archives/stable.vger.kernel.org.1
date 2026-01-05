Return-Path: <stable+bounces-204616-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DE3CF2C26
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 10:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D10AA300B699
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 09:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F70A31A551;
	Mon,  5 Jan 2026 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IGhF0yTA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27685315D45
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 09:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767605395; cv=none; b=Dvb/HFVZOD9n6Zzr6dsejz9IrxDkgpqAEZMQDpFTe1j0i82P1z/8PnG8Dg9AqgLsymHALl7KUE0yqoUhZxAyNQ5HmeGxYgwqMaIzPO+413h0AiQQzY4tfci3/lc+13RY5zyX+2Q+7qzNaZLa7wFbc9yQ+H62gYYKfY2/gP6TUYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767605395; c=relaxed/simple;
	bh=v1ySIaY6l+eolS4zn1Od2GAyXSuEYALjDm7U2bh41Ic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FL1cm3h0/TOezyGwdK8Y+8SHAtq5uvfJpgW3ZMUykfP7yJenBKrh6+wWkjtPtFZhUjAWl1+XFMIjxowbEu5VOfLyAx1dBIIr76j2DC+tqSjBJOQYSUkrnBP3qMlAciPCpCJ9MasNqqr0XTLF/SH9LIRwoyMOWqG/+/O6Sv9IpYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IGhF0yTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F4BC116D0;
	Mon,  5 Jan 2026 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767605394;
	bh=v1ySIaY6l+eolS4zn1Od2GAyXSuEYALjDm7U2bh41Ic=;
	h=Subject:To:Cc:From:Date:From;
	b=IGhF0yTAjllkvUlHbUk9TKW8NDdw5oAgXowi1EyRnnxG+HV5PyC/w54lYBw6bzQha
	 lWuRjVPYsdrdlzlFuNW/N9xi8bSDuwRFQSD/N7TQT9O2Sk3/JwOOcR0klLV62Xjak8
	 FHZwJ7iJoUzUl2FVKU9n10E5hU8kGpHMQ6HORGA4=
Subject: FAILED: patch "[PATCH] iommu/tegra: fix device leak on probe_device()" failed to apply to 5.10-stable tree
To: johan@kernel.org,joerg.roedel@amd.com,linmq006@gmail.com,robin.murphy@arm.com,treding@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 10:29:46 +0100
Message-ID: <2026010546-tannery-spinning-db08@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c08934a61201db8f1d1c66fcc63fb2eb526b656d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010546-tannery-spinning-db08@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c08934a61201db8f1d1c66fcc63fb2eb526b656d Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 20 Oct 2025 06:53:18 +0200
Subject: [PATCH] iommu/tegra: fix device leak on probe_device()

Make sure to drop the reference taken to the iommu platform device when
looking up its driver data during probe_device().

Note that commit 9826e393e4a8 ("iommu/tegra-smmu: Fix missing
put_device() call in tegra_smmu_find") fixed the leak in an error path,
but the reference is still leaking on success.

Fixes: 891846516317 ("memory: Add NVIDIA Tegra memory controller support")
Cc: stable@vger.kernel.org	# 3.19: 9826e393e4a8
Cc: Miaoqian Lin <linmq006@gmail.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 336e0a3ff41f..c391e7f2cde6 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -830,10 +830,9 @@ static struct tegra_smmu *tegra_smmu_find(struct device_node *np)
 		return NULL;
 
 	mc = platform_get_drvdata(pdev);
-	if (!mc) {
-		put_device(&pdev->dev);
+	put_device(&pdev->dev);
+	if (!mc)
 		return NULL;
-	}
 
 	return mc->smmu;
 }


