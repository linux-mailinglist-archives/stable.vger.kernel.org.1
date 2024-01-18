Return-Path: <stable+bounces-12108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA458317D0
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 12:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90681B25864
	for <lists+stable@lfdr.de>; Thu, 18 Jan 2024 11:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2E9241F6;
	Thu, 18 Jan 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="naq5qgOu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE723757;
	Thu, 18 Jan 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575629; cv=none; b=TbgS58pwf0a+cN1TVzW6E8X1LceQiO3YQgYsdGd38hhseG4bYP07cF7LRv33n1n/YG6J3UgVMcBKbWCaTsJNbhWqMiYxauqQ6mJTHxj/mjJl4umbCqatucjvViVyphwSEf62iGzsz4ucl9TLW4slVgx06Y++k8uTQd0alc+mqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575629; c=relaxed/simple;
	bh=I8lSrD/z3eqORiat5z67rJfX3rHJVwFVOuWlMp4XzNg=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:User-Agent:X-stable:
	 X-Patchwork-Hint:MIME-Version:Content-Transfer-Encoding; b=BV1ABqY6XHcXgZHmSziew69Tw5VFl23Mo7xv5thCBxLJ7rB6bSsDdF0X0lgGuu/MFuTyaMLuOgvNHgNZW4zuMA2kqNvPnCQG293W3+hMZDVR1RYVFeDmIqDmRyaRhvCN0uKbPDtrAKFbwUmmX6Q0TM6aL00+NDx3dBLM5ULHVa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=naq5qgOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29988C433C7;
	Thu, 18 Jan 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575629;
	bh=I8lSrD/z3eqORiat5z67rJfX3rHJVwFVOuWlMp4XzNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naq5qgOuHr3Cm6AfO3ajSbXMN1eBgqfLanm0XMb1ok2+cqVOavxU3bNmmMHKAf8P9
	 S8HAzMYMhkvcc3i9EMhNMO3oaKhzI+u5YXSGX3T8Lf1Xlrv0zLbmABsUUZNr1sY7jB
	 hDcM6jTzWGgJeg0jQI7NvnOQXl/lP6uBIegiMuZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 032/100] ASoC: ops: add correct range check for limiting volume
Date: Thu, 18 Jan 2024 11:48:40 +0100
Message-ID: <20240118104312.314169811@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118104310.892180084@linuxfoundation.org>
References: <20240118104310.892180084@linuxfoundation.org>
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

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit fb9ad24485087e0f00d84bee7a5914640b2b9024 ]

Volume can have ranges that start with negative values, ex: -84dB to
+40dB. Apply correct range check in snd_soc_limit_volume before setting
the platform_max. Without this patch, for example setting a 0dB limit on
a volume range of -84dB to +40dB would fail.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20231204124736.132185-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 55b009d3c681..2d25748ca706 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -661,7 +661,7 @@ int snd_soc_limit_volume(struct snd_soc_card *card,
 	kctl = snd_soc_card_get_kcontrol(card, name);
 	if (kctl) {
 		struct soc_mixer_control *mc = (struct soc_mixer_control *)kctl->private_value;
-		if (max <= mc->max) {
+		if (max <= mc->max - mc->min) {
 			mc->platform_max = max;
 			ret = 0;
 		}
-- 
2.43.0




