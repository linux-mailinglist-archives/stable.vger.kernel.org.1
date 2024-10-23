Return-Path: <stable+bounces-87925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 576E39ACD56
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EAB280CAC
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3222D2178E9;
	Wed, 23 Oct 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQyqkDro"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12732170CF;
	Wed, 23 Oct 2024 14:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693998; cv=none; b=mm/Y96CGeBRQNy4Z/qxTOgO1kUkXcguJ7zA1CaWMDsAA3IoHgyIsPkjJPFYq+gE2pgfGJyM2wR2DvEX5jfOs4BQCB/G9Jy3JZYlopMYT1i+4hXtUWbP5wrTNrj1BT6nOdkJP6diy0d7cdGQ/LBX6Uv7uc13mejsnF9Ta2vb1lSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693998; c=relaxed/simple;
	bh=NAPVcUUPYvToBWjxwxWJNBTwqvqNI3h1+1+Ik+rH11A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYFcb2ZRnH+6/Q78E15xvSUG7mYJ59gdE3U8aX/ocp21wIDNYi4GRGI3L1sdG4+FyEd2Qggbp5+3DoxLM4kYRebuDZq57gHHSjkYryFw0U3DIxFHokj3z2Znvf0yetwb0hSul6IMt0HOXgUG/Hnj9mgvox+cabso2TFotJo7liM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQyqkDro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7574BC4CEC6;
	Wed, 23 Oct 2024 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693997;
	bh=NAPVcUUPYvToBWjxwxWJNBTwqvqNI3h1+1+Ik+rH11A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PQyqkDroduz6aRw8F2kV4KrlVzldFgU21z9wsPqYodd3qlSxhUCs25MYNE5Wm08in
	 oNaXjoaGu/E8WbeX//c2NWitBJv6DdZc/atkShqUYYg1J5lK9ocNlLz/kfV9KABNfu
	 vtskMqxhPLwiwmBWOjVv0j0hsyf0KhkNse0T/zUXgYK5JW4CHjq2tNMWnnDHVoIj+C
	 4/tFc3HVDzfszxvC6suC4s5IW1jIrlCbhTsQYQc8QAL4yP+yrcWGS+tQom9buavoIF
	 55fBw6Ln6AZB/GOZJCvNocY0u2xQx6qDG8vx6RNnQjUmHLC4CUStF6JrPNgwmvfXgv
	 AotU8TA2pRN3Q==
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
Subject: [PATCH AUTOSEL 5.4 4/5] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML
Date: Wed, 23 Oct 2024 10:33:07 -0400
Message-ID: <20241023143310.2982725-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143310.2982725-1-sashal@kernel.org>
References: <20241023143310.2982725-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.284
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
index aaf2022ffc57d..cb4cb0d5b9591 100644
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


