Return-Path: <stable+bounces-44467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8658C52F9
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED211C21960
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECADF1386C6;
	Tue, 14 May 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JWl300zp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A986C84D26;
	Tue, 14 May 2024 11:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686246; cv=none; b=vBz0G8mtcQ+mh0wNEUXIueqTpUrFvU/lbrDkbi0ayXbKiaPOEZQlX8VVvF9n9+fLhQYu2wEaKezD3IEY8wwqZ/PdTFtPS12K1FcltWOOyjR6m3m2g6JhRcFWZmr1clrhw8m47VwJum34qLpTcQ7ixDV85mjU5jCHI3tHclNSzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686246; c=relaxed/simple;
	bh=QR/5oZjAWio5zv1TydfH9gE9jrAosc4A+PJOvPeYNpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7rjAKkt/hO5E2LKcq53gp0RZSXVFLqf0mvA+gggJ4WhxaNtVsO5wrmxyAdRca6xIHDkDz2mDqpr+Ajm3B5WOi0VR5jSty3JyPO6xh20OZkHbruOi8ZPvYDQVaAYcwM75t+xaXg+z1Akpv9EMe6UG8ac+cAPexxYrurulrjyNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JWl300zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CAFC2BD10;
	Tue, 14 May 2024 11:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715686246;
	bh=QR/5oZjAWio5zv1TydfH9gE9jrAosc4A+PJOvPeYNpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JWl300zpBp1oDLl3NKqrPrGAU21w9ia4Piy2wijv4WppmBfce3U6AgQs8YsCOlo8f
	 03rHrFXx8GpjrG5bangVkLCjKYQDlfCAkm0/5I6vBYFLwrgjI9aXX/U3JwICpyxjr0
	 +3zV5P3LheieKIzexQQltrWFBOlTtOqZwHFvbGu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 071/236] ASoC: meson: cards: select SND_DYNAMIC_MINORS
Date: Tue, 14 May 2024 12:17:13 +0200
Message-ID: <20240514101023.066798401@linuxfoundation.org>
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

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 6db26f9ea4edd8a17d39ab3c20111e3ccd704aef ]

Amlogic sound cards do create a lot of pcm interfaces, possibly more than
8. Some pcm interfaces are internal (like DPCM backends and c2c) and not
exposed to userspace.

Those interfaces still increase the number passed to snd_find_free_minor(),
which eventually exceeds 8 causing -EBUSY error on card registration if
CONFIG_SND_DYNAMIC_MINORS=n and the interface is exposed to userspace.

select CONFIG_SND_DYNAMIC_MINORS for Amlogic cards to avoid the problem.

Fixes: 7864a79f37b5 ("ASoC: meson: add axg sound card support")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Link: https://lore.kernel.org/r/20240426134150.3053741-1-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index b93ea33739f29..6458d5dc4902f 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -99,6 +99,7 @@ config SND_MESON_AXG_PDM
 
 config SND_MESON_CARD_UTILS
 	tristate
+	select SND_DYNAMIC_MINORS
 
 config SND_MESON_CODEC_GLUE
 	tristate
-- 
2.43.0




