Return-Path: <stable+bounces-197031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FACC8A7B4
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 15:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE173A6F96
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 14:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6163309EE8;
	Wed, 26 Nov 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpGprtZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0CD305044;
	Wed, 26 Nov 2025 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168850; cv=none; b=NqPIT7Yb4p2rXXgkwVckMaPi+t6zPVY8hbhN499xEQv0RJ5TIo+6ndd/o4mAd6W7QnVKEPtNUVRnnxS/hGhS4zb6d9a0iHoLnlekI0iNKoQPPjxc8kHG1RFg7Hur8A8KTC9NeOemgrRPmakoF9f/9uOsEetlU6Gvo7pPQPb0OJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168850; c=relaxed/simple;
	bh=/HqO8CnY5UMV9Gl7Pn58ZWgYc8wXVab/JhcP9CSjlqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9fWzbJS/KxOMTPUUPGt68G/VEkbkvv1Gq3nfJ63uzv6+fV7I9QWR2svIkQoUvJyJoadJqFrMfnqlb2pFVbaXu8QM8Yoqzb7v9WNXjRWTdLFdgsNaypXd/I+Xr1vBe7O+p/3/oVoKsdcFJ3jVzcpGm+37nqg/kwLR4ejlGVDC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpGprtZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DD5C113D0;
	Wed, 26 Nov 2025 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764168849;
	bh=/HqO8CnY5UMV9Gl7Pn58ZWgYc8wXVab/JhcP9CSjlqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpGprtZftYmevyQTc8OzK4vDcRmBrZDkOItw+AF2LcSqO/5G5PGgBFfi2bhf+Ug90
	 2Tai28k3+M/ff3OXnz9VkGAdvCow02vKGBpnsn2YuZIiXzRfvC4gLH2OqRvCkgWj93
	 xIGgysnGZTIURdFDrKNat2a6/uaWFNE+H1kMnR69xlj78AVAbg7Emo8r7xQEsDyf/M
	 9zQJa67Pn+iB1ZxIyeE/kn+7I/2/oRIJ2AnZX1nPxwzLNVlplmiGwSuPmIyKeUPlpt
	 ka//p9xcNzhKmBvd99OqDvXysrVnw8Ui9prUgPXG3A7AyhYdp0JDFy2rnagkLl3Iji
	 pTcHqFH/1vhFw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vOGuJ-000000001K0-1xsb;
	Wed, 26 Nov 2025 15:54:11 +0100
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/6] slimbus: core: fix runtime PM imbalance on report present
Date: Wed, 26 Nov 2025 15:53:25 +0100
Message-ID: <20251126145329.5022-3-johan@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126145329.5022-1-johan@kernel.org>
References: <20251126145329.5022-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to balance the runtime PM usage count in case slimbus device
or address allocation fails on report present, which would otherwise
prevent the controller from suspending.

Fixes: 4b14e62ad3c9 ("slimbus: Add support for 'clock-pause' feature")
Cc: stable@vger.kernel.org	# 4.16
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/slimbus/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index c808233692ee..9f85c4280171 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -489,21 +489,23 @@ int slim_device_report_present(struct slim_controller *ctrl,
 	if (ctrl->sched.clk_state != SLIM_CLK_ACTIVE) {
 		dev_err(ctrl->dev, "slim ctrl not active,state:%d, ret:%d\n",
 				    ctrl->sched.clk_state, ret);
-		goto slimbus_not_active;
+		goto out_put_rpm;
 	}
 
 	sbdev = slim_get_device(ctrl, e_addr);
-	if (IS_ERR(sbdev))
-		return -ENODEV;
+	if (IS_ERR(sbdev)) {
+		ret = -ENODEV;
+		goto out_put_rpm;
+	}
 
 	if (sbdev->is_laddr_valid) {
 		*laddr = sbdev->laddr;
-		return 0;
+		ret = 0;
+	} else {
+		ret = slim_device_alloc_laddr(sbdev, true);
 	}
 
-	ret = slim_device_alloc_laddr(sbdev, true);
-
-slimbus_not_active:
+out_put_rpm:
 	pm_runtime_mark_last_busy(ctrl->dev);
 	pm_runtime_put_autosuspend(ctrl->dev);
 	return ret;
-- 
2.51.2


