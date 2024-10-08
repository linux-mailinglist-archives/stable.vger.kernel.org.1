Return-Path: <stable+bounces-81543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4749943FB
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 11:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968CA1F22D35
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 09:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E760155747;
	Tue,  8 Oct 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bm088VYT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556E51422A8
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728379128; cv=none; b=KvAToQLt2shMkj9G4WC7ryOwZX7nw48c2Rdw0opUy2WFhGuDzEXN0o+xFHvPjCQSL0G/sZSPnAAqMgO4lhLDT1rmSdJo7iL13m/XifWsc/C+LPHpSGKm8WVYzNzK5g5dBZyd2ou6yp1wkO/tkFjLZc3MGzNthv9q7kWG4b1vWRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728379128; c=relaxed/simple;
	bh=OIRlOrxwo/R4qbdQrqs5zYSfc3FFuXtgPd5mGOLJp64=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ihMr1NZa6INvGSQlswn7ROPnCrl/qGlGkTLoPrXgreOD8PLOcaWLHx3udgbkfCyi1bOsVPd1fBQX88RsBhVV5YRMRxULBnzVN0I54qJrgvidGeOjrxn9rVzJLBtrxy0gzAI91GtaSsQf2kcmbLc76337lSpX+ZsjtDXNga237gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bm088VYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72F00C4CECC;
	Tue,  8 Oct 2024 09:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728379127;
	bh=OIRlOrxwo/R4qbdQrqs5zYSfc3FFuXtgPd5mGOLJp64=;
	h=Subject:To:Cc:From:Date:From;
	b=Bm088VYT7JhKPuK38VNs1UMXLj+LCCb6Ivf3vbQ61q8IGQb40NQYbJDr93RZH4R/g
	 R2FJJWyYYcb5HDuxSAtXiemYJ745+4uDTW7rBjwX2YHeVTzoUt7OegPZm5ttMupLTY
	 9fpDFGMyg27DruTNVXZJL+a+aQSuJGprLYNeq1sY=
Subject: FAILED: patch "[PATCH] drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066" failed to apply to 6.1-stable tree
To: val@packett.cool,heiko@sntech.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 11:18:44 +0200
Message-ID: <2024100844-wireless-suction-3d40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6ed51ba95e27221ce87979bd2ad5926033b9e1b9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100844-wireless-suction-3d40@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

6ed51ba95e27 ("drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066")
8e140cb60270 ("drm/rockchip: vop: limit maximum resolution to hardware capabilities")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ed51ba95e27221ce87979bd2ad5926033b9e1b9 Mon Sep 17 00:00:00 2001
From: Val Packett <val@packett.cool>
Date: Mon, 24 Jun 2024 17:40:49 -0300
Subject: [PATCH] drm/rockchip: vop: enable VOP_FEATURE_INTERNAL_RGB on RK3066

The RK3066 does have RGB display output, so it should be marked as such.

Fixes: f4a6de855eae ("drm: rockchip: vop: add rk3066 vop definitions")
Cc: stable@vger.kernel.org
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20240624204054.5524-3-val@packett.cool

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 9bcb40a640af..e2c6ba26f437 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -515,6 +515,7 @@ static const struct vop_data rk3066_vop = {
 	.output = &rk3066_output,
 	.win = rk3066_vop_win_data,
 	.win_size = ARRAY_SIZE(rk3066_vop_win_data),
+	.feature = VOP_FEATURE_INTERNAL_RGB,
 	.max_output = { 1920, 1080 },
 };
 


