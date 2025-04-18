Return-Path: <stable+bounces-134555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5D2A9362F
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 12:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC0316EE9F
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 10:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294B26FD91;
	Fri, 18 Apr 2025 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fQ2PBD1B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A2820B1FC
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 10:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744973630; cv=none; b=miujpeh7WcgdQmven5hacUTLzs7RO1+sVweHq0B98436jM2wTvSNlqzQ1vdqM6ruTXUuHu8I1wJPSOfQSeg8P0MrOfJQJ4uyLL8Wf4sara2PgzTmlSpv9PTU5vGW4/0cKP7qLfsXGMB7XAsLKLyh+M3h4fIvW2a9BJC4wjl0SVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744973630; c=relaxed/simple;
	bh=3lJknUMNBvYZmsVMXZOeHgMpz/DYUD2spEJ9PCJp15Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fJK5UCGOpRejLX0iSH8zwws7ldhAD7BGTB+cjTDk5dxybjmXMb3h2kQwlFjbCpLnWe2GESakGKSu0B+AV+tyzd2k24ZIQFMlHYG5k+Qvwipej8TUrh0ERg819z7EmxWvCW3X0u1hssSgHyzeHsMvpYpqQs99RZs45bUPQVRadSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fQ2PBD1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AC2C4CEE2;
	Fri, 18 Apr 2025 10:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744973629;
	bh=3lJknUMNBvYZmsVMXZOeHgMpz/DYUD2spEJ9PCJp15Y=;
	h=Subject:To:Cc:From:Date:From;
	b=fQ2PBD1BwDEz/x7z7ka8o9SVlf7qKKDpL/x6CjfItLl1kAMKYshSeAK+GNC8Ips++
	 a+39UWnqhdNKq1h+4LP/w7owODUaND9f9Kmwr1zpFwrCQ1Vfh86CRiydqG4sjtByS0
	 sjqbTkPTuGQyJB5cUYypb7COAW+qzN8UmKyLlnug=
Subject: FAILED: patch "[PATCH] scsi: ufs: qcom: fix dev reference leaked through" failed to apply to 6.13-stable tree
To: tudor.ambarus@linaro.org,abel.vesa@linaro.org,andersson@kernel.org,krzysztof.kozlowski@linaro.org,manivannan.sadhasivam@linaro.org,martin.petersen@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 18 Apr 2025 12:53:38 +0200
Message-ID: <2025041838-fruit-gaming-0562@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.13-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.13.y
git checkout FETCH_HEAD
git cherry-pick -x ded40f32b55f7f2f4ed9627dd3c37a1fe89ed8c6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041838-fruit-gaming-0562@gregkh' --subject-prefix 'PATCH 6.13.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ded40f32b55f7f2f4ed9627dd3c37a1fe89ed8c6 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 17 Jan 2025 14:18:52 +0000
Subject: [PATCH] scsi: ufs: qcom: fix dev reference leaked through
 of_qcom_ice_get

The driver leaks the device reference taken with
of_find_device_by_node(). Fix the leak by using devm_of_qcom_ice_get().

Fixes: 56541c7c4468 ("scsi: ufs: ufs-qcom: Switch to the new ICE API")
Cc: stable@vger.kernel.org
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com> # SCSI
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/20250117-qcom-ice-fix-dev-leak-v2-3-1ffa5b6884cb@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 23b9f6efa047..a455a95f65fc 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -125,7 +125,7 @@ static int ufs_qcom_ice_init(struct ufs_qcom_host *host)
 	int err;
 	int i;
 
-	ice = of_qcom_ice_get(dev);
+	ice = devm_of_qcom_ice_get(dev);
 	if (ice == ERR_PTR(-EOPNOTSUPP)) {
 		dev_warn(dev, "Disabling inline encryption support\n");
 		ice = NULL;


