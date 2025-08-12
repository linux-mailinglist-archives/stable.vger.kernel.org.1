Return-Path: <stable+bounces-168787-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B69B2369F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A91172254
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1329E2F8BC3;
	Tue, 12 Aug 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MDv1GvlQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62FC27604E;
	Tue, 12 Aug 2025 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025328; cv=none; b=DroUZMSMJ2b6iUsWHXxU750z4kDZVjjMg2Ge3Py8R/Es+3UCNLQqVmv2iA6vldfOJqHzaLySQNs/+fMUjIsTGtEXCAYtn8ZkMq6fXZf5amDZDLEuvH5GHVG0CBknLu0x7+1TibNmGxg4MsLUcikSRfG+3ZnFovw96Bsd2ORR0w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025328; c=relaxed/simple;
	bh=FZ+qlO7s3TV4ztPbOvWzeg2orEY3pxyp4N5lnSHSATw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UV/K9mOno44ajdol3GWO0lG5eT6eyBnoISeyVV/CIZBorZHRv1FFmzsiUaGWWCRjEqFN5hEfCg1HAnyhbgWVgO6dGI7acA5uZtpErvqQl1K8XvUP/7a4CX6F8aS5q2EcxrDSvkPAdiEwYhSADw0gpCANZiyoPThb4AsV4POCZPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MDv1GvlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D705BC4CEF0;
	Tue, 12 Aug 2025 19:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755025328;
	bh=FZ+qlO7s3TV4ztPbOvWzeg2orEY3pxyp4N5lnSHSATw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDv1GvlQ9WS1Yj518Fi6zjJfsvpvwZPO1ILS3GDSee8pEJevOMf/hsTc/lMDRP3jr
	 TqqKspSnRHe1MNEaIU/ogUUB8jznVhAg+pUhQwWde7/C8Z2OE1QWwQAn24hfPqisap
	 l8ZYOAjX/SJcklEj8qUk8rNYbvMbnB4wN3u8UaoU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lane Odenbach <laodenbach@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 002/480] ASoC: amd: yc: Add DMI quirk for HP Laptop 17 cp-2033dx
Date: Tue, 12 Aug 2025 19:43:30 +0200
Message-ID: <20250812174357.396103562@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
References: <20250812174357.281828096@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lane Odenbach <laodenbach@gmail.com>

[ Upstream commit 7bab1bd9fdf15b9fa7e6a4b0151deab93df3c80d ]

This fixes the internal microphone in the stated device

Signed-off-by: Lane Odenbach <laodenbach@gmail.com>
Link: https://patch.msgid.link/20250715182038.10048-1-laodenbach@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1689b6b22598..42d123cb8b4c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -577,6 +577,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8A7F"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A81"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.5




