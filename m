Return-Path: <stable+bounces-57370-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59649925C33
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A11C20AEC
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798A917C207;
	Wed,  3 Jul 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YIIJWVJV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E713B280;
	Wed,  3 Jul 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004673; cv=none; b=kL2qLae4cCg8S2yLOKPdQBwbKFXyA7ef2KoLU5GZMyi7kmrC1oUgn6jvm8hGp2NwOwUMmqsMoU/P4bYz+HweMwdlN1JlYd7DcIsCugeE5uJOvTNn0w57ZyQZctE9ZuLidfHSaX0sAmxrH2Qtl3DgNB8YfvnC49hd5pMl/XRjYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004673; c=relaxed/simple;
	bh=KKj+AIItvLYyxDPKqI3KnMsOhjdM8/G9xTHrJyPvzhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O63LK/ghRzWzs9nua82fM80i9KlL+x9to4j8wYbRL3alyaplNoma5M9Te2xR21tz0mFutpsNVgghZIvdEkO94Hgb7MkuVe/8sr5SZir9GOcn0wMXb0NBqGV1tanvKFoMYUjWDjn/sNiMQwB1Dj2lbhVRJNQKJHW7dqbqiDepsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YIIJWVJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF37AC2BD10;
	Wed,  3 Jul 2024 11:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004673;
	bh=KKj+AIItvLYyxDPKqI3KnMsOhjdM8/G9xTHrJyPvzhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIIJWVJVoNAPDpEUIQx3jYC1ahy+XO8WPLHrQ4kGILSxich3B1ZV+WRW0cUP/zg8P
	 UYaWisTU5Yqtl9c+9s+FhsTO8KGHJQlMKMUdvvaxAqxtdDSkuAIB2DXUUOoa6/E4mk
	 JwzEvSW3G4who6b1UboovjZH4QfUtHNxl3wv/zYE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Takashi Iwai <tiwai@suse.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 119/290] ACPI: video: Add backlight=native quirk for Lenovo Slim 7 16ARH7
Date: Wed,  3 Jul 2024 12:38:20 +0200
Message-ID: <20240703102908.685890539@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit c901f63dc142c48326931f164f787dfff69273d9 ]

Lenovo Slim 7 16ARH7 is a machine with switchable graphics between AMD
and Nvidia, and the backlight can't be adjusted properly unless
acpi_backlight=native is passed.  Although nvidia-wmi-backlight is
present and loaded, this doesn't work as expected at all.

For making it working as default, add the corresponding quirk entry
with a DMI matching "LENOVO" "82UX".

Link: https://bugzilla.suse.com/show_bug.cgi?id=1217750
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index a5cb9e1d48bcc..338e1f44906a9 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -341,6 +341,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Lenovo Slim 7 16ARH7 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "82UX"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Lenovo ThinkPad X131e (3371 AMD version) */
-- 
2.43.0




