Return-Path: <stable+bounces-16205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E1C83F1A8
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A7A285AD3
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D68C200A0;
	Sat, 27 Jan 2024 23:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="krQIvjdh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48A61B80B
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397182; cv=none; b=tDW/O6sGsqyeCPJ2PxL3XAygAfFsFnazTk4zWrO1ot5u5A3vyLqXqB9K2K7lyPxVJUsluSvLD2oY2ucu8yO4jvwEkdJUciwUPlPYB7Ww1zcIUUaziLh7CbpGyt+7u+dFzlK3e/2gXi+0igMbg0l427PUxYDk+xKiexQMwruVO3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397182; c=relaxed/simple;
	bh=2apC3o7s4jN7s/qASSlr1qZ7Lnl1G0EyUg6NWpw7KKs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SyXySVEfHx5WqgHkGujPDK+NMgfJ2qsWhzM94HJINRJhERMCgE5yAHelFz8WQwGxXAwMGTci4wzyY/s5IqbkMo9Fz5mOnMHMkVKj1H27Zhqae9+lvvCV1n1/8BWbxkDYapCld9vahxreyudz5psTF4lh3UzkdVFsbs8/SpH6LOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=krQIvjdh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD5FC433F1;
	Sat, 27 Jan 2024 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397182;
	bh=2apC3o7s4jN7s/qASSlr1qZ7Lnl1G0EyUg6NWpw7KKs=;
	h=Subject:To:Cc:From:Date:From;
	b=krQIvjdh1iR2P4TBtimLieMSqUYMWHwixNA5XkU7pnVw9O6nXil06lAZQEicPUBqP
	 o+mmO4HQzyIbTaPRXCyDljK2M7v+oPt/1hYM83iqOKfC2YgzqYnfQ3X902fKD/Minu
	 93pWEvAJ8xEsYRWdz8CLgqm1cCOhGysm7zwxei3o=
Subject: FAILED: patch "[PATCH] drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name" failed to apply to 6.7-stable tree
To: hsinyi@chromium.org,dianders@chromium.org,mripard@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:13:01 -0800
Message-ID: <2024012701-urchin-shredding-d8c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.7.y
git checkout FETCH_HEAD
git cherry-pick -x 962845c090c4f85fa4f6872a5b6c89ee61f53cc0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012701-urchin-shredding-d8c1@gregkh' --subject-prefix 'PATCH 6.7.y' HEAD^..

Possible dependencies:

962845c090c4 ("drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name")
fc6e76792965 ("drm/panel-edp: drm/panel-edp: Fix AUO B116XAK01 name and timing")
3db2420422a5 ("drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,836X2, NV116WHM-N49 V8.0")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 962845c090c4f85fa4f6872a5b6c89ee61f53cc0 Mon Sep 17 00:00:00 2001
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 7 Nov 2023 12:41:52 -0800
Subject: [PATCH] drm/panel-edp: drm/panel-edp: Fix AUO B116XTN02 name

Rename AUO 0x235c B116XTN02 to B116XTN02.3 according to decoding edid.

Fixes: 3db2420422a5 ("drm/panel-edp: Add AUO B116XTN02, BOE NT116WHM-N21,836X2, NV116WHM-N49 V8.0")
Cc: stable@vger.kernel.org
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20231107204611.3082200-3-hsinyi@chromium.org

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 2fba7c1f49ce..d41d205f7f5b 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1871,7 +1871,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
-	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02.3"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),


