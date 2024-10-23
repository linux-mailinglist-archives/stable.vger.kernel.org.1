Return-Path: <stable+bounces-87913-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE469ACD35
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 16:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0F9280E99
	for <lists+stable@lfdr.de>; Wed, 23 Oct 2024 14:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E14E2141CE;
	Wed, 23 Oct 2024 14:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kscZg0Di"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95CD2141BD;
	Wed, 23 Oct 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693969; cv=none; b=akRzbcYb+Pg4u561ipABS2dm0IRGapqkrmFH7qi+Dt5kKoz5VybTxWboUUcQk0s/+vlhZfIvwZDOvrpD8rPjrk4Fp4LYChCfMSSK0FwnZmzbV8iZIwbUaUL9rBpqHQt4q/k8rat/Lv1kGqqkW3/mHiuj9YhNRTRNbOiQpFl0WSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693969; c=relaxed/simple;
	bh=bpqZtY02fDUMvDyXaFg08PofO2GL4buz9Y4mnDRaI0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7Jomu81qVGVZWaTiD1MhEINAO3D/8+U2ilV+Kx51A3oR7SzRrQ6fKJApWRXDNsuB6SCOPds0yVhnPpsb8Xin4D4snYSMDd7fFrImeUoGeyZ3xtSXn7itOrDcGEOaH9b0l+O6Gj58UolK9ySXVK1MIyQOIvFatPu0VFOfJAMWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kscZg0Di; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1967FC4CEE5;
	Wed, 23 Oct 2024 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693969;
	bh=bpqZtY02fDUMvDyXaFg08PofO2GL4buz9Y4mnDRaI0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kscZg0DiC7gf+FkNGuToY9FX8ljyIPU8KRE2RKyDOuhQT2+geCCuIG0LCNoY9ixIf
	 LuQRuA1Q43dnPGehwoTtTQiptII/f9HR3muyEviCCt2OMPQvQecHgU/VJYabhSU+8S
	 VreKGqauYUohyKa8zP7stwJrp4ABLpkCCEjDNqrXOka1V908UmSaNtTHsKOMXIMr0Z
	 DW+8zaZV4DQvFVDk8FQ2kh9scJvaS7aJVmsunV9JFKNzYFTqrsqDJx5i1vDcWQKidp
	 eTcNR78rJv0Q8Ttyxu4MOG5irsnKrR1ruvpsI5UbEgTmciAW4xjspuqTa2DSFJR6Pe
	 qWlj3EpDVHU/g==
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
Subject: [PATCH AUTOSEL 5.15 08/10] sound: Make CONFIG_SND depend on INDIRECT_IOMEM instead of UML
Date: Wed, 23 Oct 2024 10:32:29 -0400
Message-ID: <20241023143235.2982363-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143235.2982363-1-sashal@kernel.org>
References: <20241023143235.2982363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.169
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


