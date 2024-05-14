Return-Path: <stable+bounces-44420-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDA18C52C8
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC417B22313
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A44012FF6D;
	Tue, 14 May 2024 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJmDRwmJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97B1CAA4;
	Tue, 14 May 2024 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686111; cv=none; b=c/y/alJ70e3b8XbcvdM0JdRCy1xA8p2R2fSHg+I7/JeqldyP5drS4xFQnpGZhqSH7n6MpfUCBX7Sp7ccz/klalq39APhj8fkzYqZ2Cx/Mpk3CYuo5mQkW/wkj23ifS4HDWxCPOzdsGUgGUCnFg6iyR4KpqpY2c9sLHGcYxpCGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686111; c=relaxed/simple;
	bh=ij1Q0++qCc8jvqdJnt0qD+xt0rdLnkh1thoz1T7zDOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXrlsDgncgboGlAKLtWbsORPlGygX+sGg27LsDJL/jTCdkIwVy7aJXy+oqP8WspmsPCuZhdDVqwKYgdNPJiw7vA0xyIFweXuBwUzb0a+7uNrrfnRE4KUtjaQa17T/M2jzC6JF5o8swUQGAbzFdRkbdXD8x5hJ4+4AvOZLyDH8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJmDRwmJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628DAC2BD10;
	Tue, 14 May 2024 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686110;
	bh=ij1Q0++qCc8jvqdJnt0qD+xt0rdLnkh1thoz1T7zDOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bJmDRwmJz07e0ZcO73mUtDGn+FU6YRS9QVPBPNv/rRqtgwyvN3jOmnMEv9C/rz9Zz
	 9Lj/l7gj2I1haopJw188tfI8E1K8ibQqhAClTrqEjcOO2raxjwuS9JxlOzMlia96o4
	 +KC5dUoWVNJftN2nn9wOV/Qd5DJ316OYigub3Z44=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 025/236] pinctrl: mediatek: paris: Fix PIN_CONFIG_INPUT_SCHMITT_ENABLE readback
Date: Tue, 14 May 2024 12:16:27 +0200
Message-ID: <20240514101021.289280845@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101020.320785513@linuxfoundation.org>
References: <20240514101020.320785513@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chen-Yu Tsai <wenst@chromium.org>

[ Upstream commit 08f66a8edd08f6f7cfa769c81634b29a2b123908 ]

In the generic pin config library, readback of some options are handled
differently compared to the setting of those options: the argument value
is used to convey enable/disable of an option in the set path, but
success or -EINVAL is used to convey if an option is enabled or disabled
in the debugfs readback path.

PIN_CONFIG_INPUT_SCHMITT_ENABLE is one such option. Fix the readback of
the option in the mediatek-paris library, so that the debugfs dump is
not showing "input schmitt enabled" for pins that don't have it enabled.

Fixes: 1bea6afbc842 ("pinctrl: mediatek: Refine mtk_pinconf_get()")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <20240327091336.3434141-2-wenst@chromium.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-paris.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index ad873bd051b68..3f2297ee2b765 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -188,6 +188,8 @@ static int mtk_pinconf_get(struct pinctrl_dev *pctldev,
 		}
 
 		err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_SMT, &ret);
+		if (!ret)
+			err = -EINVAL;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		if (!hw->soc->drive_get)
-- 
2.43.0




