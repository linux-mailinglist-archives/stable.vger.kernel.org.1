Return-Path: <stable+bounces-70018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD2695CF46
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 16:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 525BB1C20C74
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAFE19EEB7;
	Fri, 23 Aug 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mxttx7aA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53219EEA8;
	Fri, 23 Aug 2024 14:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724421884; cv=none; b=BZuIjRQsAEIC1H+k4Q+920gqT7OcSyoa1B9DzQtBRGxiD9IHAgS8xiw2gK5PGgFk65b+DNKuRULlJ8QjCr/djgzmgXjoAjQP6cme8lIIQR1+IkRcuEH4l5JQVRwPdAXqMX9zJ3uzBKsitREi+XHFuZukYx6iEz1HROEkgbJb9PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724421884; c=relaxed/simple;
	bh=a15rdXWBom+EVLMzVNGaBrVj+vIfKEsnXYhppLf8LRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX01goxR9rX9QhBXBkiOIeeZ9V8+aCwecYcaMuQgGHII3pyh9kVrBjLwYkWsBC8PJX+iReEhJGdTJUH894fZoCx8Gr444mhE/NAKfNykB9OOqZudKM4Mjx9q5H4wjH2U2KllKwaP6M3R2O98DJNiiTfz/LOxZu8PLMZS+WsrIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mxttx7aA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B063CC4AF0B;
	Fri, 23 Aug 2024 14:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724421883;
	bh=a15rdXWBom+EVLMzVNGaBrVj+vIfKEsnXYhppLf8LRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mxttx7aAcmUcWs8pLPCg2VHCciSLd+IszQbrAw84Ewk4dqtjDhaML4T4digo+t6An
	 rD+URmhHmD8ls8Eaak5A1dcMTHcO6iN+k+Fqb1FRLZG0P5pMq1qOcq+r/S9OWGR4lX
	 0+XfAKkUDjHA+a8xj0KOehfqEXQVRzPzcC4qSZn6tMzmXXqkReJc0wkvIyZYjxq0mf
	 /GDerZzVyfg0jsQS2zdMZOztN9hqRyiaU6xSyTRKaoO1U8YG646FSlXjTolxnqUQ8g
	 1oUuwUtWLrcuRs4fVzZ/whwTzBYW2/Bw68Jo16IviiBhMwyXbhoqMLh+kI4tiF2Pb1
	 BnBk3QQR9+7xA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 07/13] drm: panel-orientation-quirks: Add quirk for Ayn Loki Max
Date: Fri, 23 Aug 2024 10:03:56 -0400
Message-ID: <20240823140425.1975208-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823140425.1975208-1-sashal@kernel.org>
References: <20240823140425.1975208-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.106
Content-Transfer-Encoding: 8bit

From: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>

[ Upstream commit 2c71c8459c8ca66bd8f597effaac892ee8448a9f ]

Add quirk orientation for Ayn Loki Max model.

This has been tested by JELOS team that uses their
own patched kernel for a while now and confirmed by
users in the ChimeraOS discord servers.

Signed-off-by: Bouke Sybren Haarsma <boukehaarsma23@gmail.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240728124731.168452-3-boukehaarsma23@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 21f2f3abf90f0..df402f6c5dc98 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -208,6 +208,12 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_MATCH(DMI_BOARD_NAME, "KUN"),
 		},
 		.driver_data = (void *)&lcd1600x2560_rightside_up,
+	}, {    /* AYN Loki Max */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Loki Max"),
+		},
+		.driver_data = (void *)&lcd1080x1920_leftside_up,
 	}, {	/* AYN Loki Zero */
 		.matches = {
 			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ayn"),
-- 
2.43.0


