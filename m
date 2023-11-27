Return-Path: <stable+bounces-2808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEE67FAABF
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 20:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C70281981
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041B45966;
	Mon, 27 Nov 2023 19:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: stable@vger.kernel.org
Received: from smtp.livemail.co.uk (smtp-out-60.livemail.co.uk [213.171.216.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2337D64;
	Mon, 27 Nov 2023 11:59:01 -0800 (PST)
Received: from laptop (host-78-146-56-151.as13285.net [78.146.56.151])
	(Authenticated sender: malcolm@5harts.com)
	by smtp.livemail.co.uk (Postfix) with ESMTPSA id 97496C5A59;
	Mon, 27 Nov 2023 19:58:58 +0000 (GMT)
User-agent: mu4e 1.8.15; emacs 29.1
From: Malcolm Hart <malcolm@5harts.com>
To: Mark Brown <broonie@kernel.org>
Cc: Sven Frotscher <sven.frotscher@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, stable@vger.kernel.org
Subject:  [PATCH] sound: soc: amd: yc: Fix non-functional mic on ASUS E1504FA
Date: Mon, 27 Nov 2023 19:42:30 +0000
Message-ID: <875y1nt1bx.fsf@5harts.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


This patch adds ASUSTeK COMPUTER INC  "E1504FA" to the quirks file acp6x-mach.c
to enable microphone array on ASUS Vivobook GO 15.
I have this laptop and can confirm that the patch succeeds in enabling the
microphone array.

Signed-off-by: Malcolm Hart <malcolm@5harts.com>

---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 15a864dcd7bd3a..3babb17a56bb55 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -283,6 +283,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "M6500RC"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {

