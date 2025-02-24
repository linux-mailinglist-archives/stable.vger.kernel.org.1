Return-Path: <stable+bounces-119237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB34A4253C
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D881B3AB18B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E869A1519A5;
	Mon, 24 Feb 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XYYjhzQQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51722571C3;
	Mon, 24 Feb 2025 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408786; cv=none; b=uVcN63WNqkiqL12pMo/86l3gg8TfDzKUCJpDcwSzrkOoDZB05jS3XhiC/KQBYb0SJwrgM66du78wsjB0TESXsWGBh0mx//8gg1qek6wuw3ZuKnrwmk8qFUTqrUNsfAbGGwKQMqlzR7YnJ20Y/25TazqvfxKERvZXt48jNRbLNEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408786; c=relaxed/simple;
	bh=U8DX4dHlNSrr9CMiHbX9UNVAwqz388wqdgPCNLz3XIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pA9HKfl64CrjoU3kQ1axW/AVQBvRpabf/GGYok09xwTG25CbbVKD7OQ+UmAi29PVxwJWWYZXwpzVbB6/5lGikBcwft4PaCr/ACvW4oz/H4vAqxOFtfNm8QpCVXrBJmMyyrO7C1p3wa5Mfh64D5WA/VT0hUR+hErxmUn0IIUaujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XYYjhzQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDEEC4CED6;
	Mon, 24 Feb 2025 14:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408785;
	bh=U8DX4dHlNSrr9CMiHbX9UNVAwqz388wqdgPCNLz3XIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYYjhzQQyilchBDHlVfpPoviWBx7Nj0+anBi6otYpAtYThNlOjKhDlJYkO6m8Z8C3
	 MO4iCWLGLjfxq+tRCjlauLvfLnq0FmIkE1dCoao6BGuJ7nSNz8hkzOOFS6+AvsMXe8
	 eY/mzbyAkbC7+0VN4g31tuw0txWMKanBFl4CcEXY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.12 130/154] ASoC: fsl_micfil: Enable default case in micfil_set_quality()
Date: Mon, 24 Feb 2025 15:35:29 +0100
Message-ID: <20250224142612.138518247@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142607.058226288@linuxfoundation.org>
References: <20250224142607.058226288@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

commit a8c9a453387640dbe45761970f41301a6985e7fa upstream.

If 'micfil->quality' received from micfil_quality_set() somehow ends
up with an unpredictable value, switch() operator will fail to
initialize local variable qsel before regmap_update_bits() tries
to utilize it.

While it is unlikely, play it safe and enable a default case that
returns -EINVAL error.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: bea1d61d5892 ("ASoC: fsl_micfil: rework quality setting")
Cc: stable@vger.kernel.org
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Link: https://patch.msgid.link/20250116142436.22389-1-n.zhandarovich@fintech.ru
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/fsl/fsl_micfil.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -156,6 +156,8 @@ static int micfil_set_quality(struct fsl
 	case QUALITY_VLOW2:
 		qsel = MICFIL_QSEL_VLOW2_QUALITY;
 		break;
+	default:
+		return -EINVAL;
 	}
 
 	return regmap_update_bits(micfil->regmap, REG_MICFIL_CTRL2,



