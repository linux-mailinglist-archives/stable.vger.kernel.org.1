Return-Path: <stable+bounces-76438-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A7B97A1C1
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBE51C21623
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB90155300;
	Mon, 16 Sep 2024 12:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cODtbPpE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8796B146A79;
	Mon, 16 Sep 2024 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488594; cv=none; b=Iveg1ChNdq6oNt+D7YY8QSAXEmAGTYiSa2bo0TAtjKdNgloFDB3Fe6WXUXNpMouWlSE85R0eCntjr4hUnirh76FzzlygvbRzasv3TborOqQh6JKxNZLdxXEYi/CbG7CBefyCNQFm/j/CiIVPpG+8OIvA+eEvLKRhytoU6hu0KlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488594; c=relaxed/simple;
	bh=Jgnahe5DAJGyCHW8g28uUE2HTtMpqII0WMp8tq7VOnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcTkxlWvHH3XiJQ08DeXxTZT0TA82OeWud8NwGZzP5fM8rz2drbdSflXlzaVqcKWMha49e8aUv3cdJXzFcHouWwWLm1cnrErihCUgc2VOnqo7YD8Cz8ll+721OxvVvLBuD8oQT+kaRitV7SKQzRJUK/9rBm1QJcNWwYYIJUHJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cODtbPpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2FFDC4CEC4;
	Mon, 16 Sep 2024 12:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488593;
	bh=Jgnahe5DAJGyCHW8g28uUE2HTtMpqII0WMp8tq7VOnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cODtbPpEd9jcI5DxwC/MNgHCcOtIhGJRVGdC6MD9JJrSUY+GHaWN52wLUjD36i/lm
	 fmEALwWfV2sHuixhqZJD+mo4aOtGgoyZeLZvgAMdkPFKXXmd/dyjAeo8H5sm6m2loZ
	 Zn9oNVgBUtI3x7++7r8lDDj3WjbOS5Jw6uQg/aMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bouke Sybren Haarsma <boukehaarsma23@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 18/91] drm: panel-orientation-quirks: Add quirk for Ayn Loki Max
Date: Mon, 16 Sep 2024 13:43:54 +0200
Message-ID: <20240916114225.125609369@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
References: <20240916114224.509743970@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 79ccf4959df4..5b2506c65e95 100644
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




