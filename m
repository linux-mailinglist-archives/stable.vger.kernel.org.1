Return-Path: <stable+bounces-87899-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211919ACD10
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67D02816DA
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2D020F5D4;
	Wed, 23 Oct 2024 14:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0sJDPCr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7B20F5B3;
	Wed, 23 Oct 2024 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693940; cv=none; b=YxFOBmeSx6nLopVvYzqhJRQVTjvX1H7hd19brMz+2qyF5jV0yrBBYXBgKHhjqm+JPLo2ivB06Q+ggXdurCJuK6UZF69guHzSMaXGEGVYUmwNI0Yx0zW3hYNeY0dGIM56uRkGvXUDzYq0Vno+dTS6MPROrvOoA+hYdxQpUkE0zQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693940; c=relaxed/simple;
	bh=bpqZtY02fDUMvDyXaFg08PofO2GL4buz9Y4mnDRaI0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mWWabgVJqtU3J8m/HK9LVPO+HGKAwRfd39dfln2C9UbCvS5/KkYfeokqD+y7Al959w+Bz5Jp0PiYB46FWdqynKFJv8CVygpFjbQStPjyEr/whJYCSpVaFhS+RcFCVE0E3te5npnvFMj5bmdBvFg+YidfB2tipmiTXfa94Ilx3cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0sJDPCr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC215C4CEC6;
	Wed, 23 Oct 2024 14:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693939;
	bh=bpqZtY02fDUMvDyXaFg08PofO2GL4buz9Y4mnDRaI0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t0sJDPCrxKrhD01zqGvhWzLEcub1OU6t+PDP2YNgjlKzxpf3QLEnFQbN6yJ6/UNjz
	 lMNIHjgMcrHhjc6auEALk7s3h6BEW9ILqr3OVFyOAvjL15Mkrz1IuMgcxjr+OtszW+
	 IUCJ7pB6a52TpdQzqSq05+Xj+JjRS/ysEOG3XEdnIVQtsReNfQQmUHCVC5AwZfGLGU
	 MCjaK/X9kUie1AWh+ntuod9JACJ5V48qHDFEgyiPYnLiD8unDtxyug5f8koLrq25sv
	 JLjbrl7doftR0KM+YmzrADid96wF5ISqjn0Ky27Iv9lDVAhFrnoFT7tM2WMX9wmsTo
	 tCHllmqSbDGUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Julian Vetter <jvetter@kalrayinc.com>,
	Yann Sionneau <ysionneau@kalrayinc.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/17] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML
Date: Wed, 23 Oct 2024 10:31:50 -0400
Message-ID: <20241023143202.2981992-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143202.2981992-1-sashal@kernel.org>
References: <20241023143202.2981992-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.114
Content-Transfer-Encoding: 8bit

From: Julian Vetter <jvetter@kalrayinc.com>

[ Upstream commit ad6639f143a0b42d7fb110ad14f5949f7c218890 ]

When building for the UM arch and neither INDIRECT_IOMEM=y, nor
HAS_IOMEM=y is selected, it will fall back to the implementations from
asm-generic/io.h for IO memcpy. But these fall-back functions just do a
memcpy. So, instead of depending on UML, add dependency on 'HAS_IOMEM ||
INDIRECT_IOMEM'.

Reviewed-by: Yann Sionneau <ysionneau@kalrayinc.com>
Signed-off-by: Julian Vetter <jvetter@kalrayinc.com>
Link: https://patch.msgid.link/20241010124601.700528-1-jvetter@kalrayinc.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/Kconfig b/sound/Kconfig
index 1903c35d799e1..5848eedcc3c9f 100644
--- a/sound/Kconfig
+++ b/sound/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig SOUND
 	tristate "Sound card support"
-	depends on HAS_IOMEM || UML
+	depends on HAS_IOMEM || INDIRECT_IOMEM
 	help
 	  If you have a sound card in your computer, i.e. if it can say more
 	  than an occasional beep, say Y.
-- 
2.43.0


