Return-Path: <stable+bounces-202501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13289CC3285
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D19E3006D9F
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9163314AC;
	Tue, 16 Dec 2025 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0BhwBpLi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4CF314A74;
	Tue, 16 Dec 2025 12:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888104; cv=none; b=Zw6v54+Xaa40fTkaajzrgervul92ZzaTqqS8qwBn9O+AWNBzIAg/NoPy4WJJZRzqnylBy8VJ6yKhrk4J26hD+HcKxOLgKi4mH+CGpzoRgmlGtvWX34STEYDOjMQ0+Zc2BoFS7YV94iqhybW0S+QnNxbKmzW8opBBcMUnvFSr7D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888104; c=relaxed/simple;
	bh=xkcnf5IE1R+362j4q5qy3NywqS8VcXd593LXtOTfqDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7T3CrdglQuivxK9Qdxgei7/+o6nOyruo3Sr2qZaM9nDENPS3lQ3s9W9EyG/xETmeOgXXTWXo6dBQwKozlGjuIKbfuWQPlto13hsReESnM0WPlLNH44nEUaRKhlN66EvE5Xay0ETmu92B1VGhZV0DER7xRSK3ecWVbe9QnyOJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0BhwBpLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6CAC4CEF1;
	Tue, 16 Dec 2025 12:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765888104;
	bh=xkcnf5IE1R+362j4q5qy3NywqS8VcXd593LXtOTfqDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0BhwBpLiJBaMHWK88yifpk86igBMRHKndranGhjsJH5Xe7I8GD8eWB27G1/WJKle1
	 EraqutYS56b7/wm9lg68Nblx5Fcu8xi71NIYmEkoh0f+Y7ATpVONnz2xiO/Dt+sdDy
	 Y1k4Qgl9gVF1YHZ271jyRoXBW2gehi0h/uuY+K48=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Marc Zyngier <maz@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 434/614] clocksource/drivers/arm_arch_timer_mmio: Prevent driver unbind
Date: Tue, 16 Dec 2025 12:13:21 +0100
Message-ID: <20251216111417.098130728@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 6aa10f0e2ef9eba1955be6a9d0a8eaecf6bdb7ae ]

Clockevents cannot be deregistered so suppress the bind attributes to
prevent the driver from being unbound and releasing the underlying
resources after registration.

Fixes: 4891f01527bb ("clocksource/drivers/arm_arch_timer: Add standalone MMIO driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://patch.msgid.link/20251111153226.579-2-johan@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clocksource/arm_arch_timer_mmio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer_mmio.c b/drivers/clocksource/arm_arch_timer_mmio.c
index ebe1987d651eb..d10362692fdd3 100644
--- a/drivers/clocksource/arm_arch_timer_mmio.c
+++ b/drivers/clocksource/arm_arch_timer_mmio.c
@@ -426,6 +426,7 @@ static struct platform_driver arch_timer_mmio_drv = {
 	.driver	= {
 		.name = "arch-timer-mmio",
 		.of_match_table	= arch_timer_mmio_of_table,
+		.suppress_bind_attrs = true,
 	},
 	.probe	= arch_timer_mmio_probe,
 };
@@ -434,6 +435,7 @@ builtin_platform_driver(arch_timer_mmio_drv);
 static struct platform_driver arch_timer_mmio_acpi_drv = {
 	.driver	= {
 		.name = "gtdt-arm-mmio-timer",
+		.suppress_bind_attrs = true,
 	},
 	.probe	= arch_timer_mmio_probe,
 };
-- 
2.51.0




