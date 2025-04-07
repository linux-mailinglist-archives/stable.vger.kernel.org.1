Return-Path: <stable+bounces-128693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF3BA7EAEA
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 20:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769003BDBDE
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 18:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02252676F5;
	Mon,  7 Apr 2025 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsGUEMF9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701792676E5;
	Mon,  7 Apr 2025 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744049684; cv=none; b=ukSNTDVRSIc6TOptQTv+qVo1rdSfrM6MNqnnXXzkhs9DtvgLSttx5ld0MeCsarZD/mRa++udNFKrc7sznCu/dBFa/0TjjK9alUf9+KuPMrIIYMy4bCu6kTenJLnBSyMU/86yrV5ppzu2xC5qFiYulgsSnJ4k5fWXl3xlafxr2dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744049684; c=relaxed/simple;
	bh=fgghXRHxICYRfWfR11Fy5RSMrY1Ht4qKHe+dnFNEUjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gui+biQn29VjCdETyTDb+ZO/ksFrnh1kUD54qF5wglX+rX+guF6x4SG43CqX5CUoH46nWG9FriIKKnGy84Gd40CANqaOFrdf/gZjKOy/mZ7N1K4SCBzCIowHjXUmMOfNmEmxv4m0P24/RTaOAAFI1ij/eA610+tU+8hqfLJZoYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsGUEMF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC01C4CEE7;
	Mon,  7 Apr 2025 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744049683;
	bh=fgghXRHxICYRfWfR11Fy5RSMrY1Ht4qKHe+dnFNEUjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BsGUEMF91FYmQMcmZWDleNy0jnn9HN/Rk8IhbA8pmVjMk9yhruvoP7n06xJ3KcsNX
	 Cc8UFjoS8BPvY0t7LVYEmxyH+dUBhRuxy10/ftJ84mU3ioMEiHxtubP8+zO/O1UbDS
	 NZtVkFwT58R0MtOCBJbwBN228Ad9sgUKrg1BMJ4hWMPsVBu33OQzfNOixlO4T71Y5a
	 y47TwOD22a1Etni1pTOrIlMH52RuBgF9ia2S5cZ0ZXD2Os3y+UQNlybVd6mHiPtmMc
	 kJjN0eLXQOd/Iv8vyGUga48GjYkGZxk+V6rPd7NNDBA/Bs0GDo3xkxVtQ5m1Eb3c8V
	 McSe/Tzn1EjWA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	nathan@kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 13/15] objtool, ASoC: codecs: wcd934x: Remove potential undefined behavior in wcd934x_slim_irq_handler()
Date: Mon,  7 Apr 2025 14:14:13 -0400
Message-Id: <20250407181417.3183475-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250407181417.3183475-1-sashal@kernel.org>
References: <20250407181417.3183475-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.86
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 060aed9c0093b341480770457093449771cf1496 ]

If 'port_id' is negative, the shift counts in wcd934x_slim_irq_handler()
also become negative, resulting in undefined behavior due to shift out
of bounds.

If I'm reading the code correctly, that appears to be not possible, but
with KCOV enabled, Clang's range analysis isn't always able to determine
that and generates undefined behavior.

As a result the code generation isn't optimal, and undefined behavior
should be avoided regardless.  Improve code generation and remove the
undefined behavior by converting the signed variables to unsigned.

Fixes the following warning with UBSAN:

  sound/soc/codecs/snd-soc-wcd934x.o: warning: objtool: .text.wcd934x_slim_irq_handler: unexpected end of section

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/7e863839ec7301bf9c0f429a03873d44e484c31c.1742852847.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503180044.oH9gyPeg-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 1b6e376f3833c..fe222c4b74c00 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -2281,7 +2281,7 @@ static irqreturn_t wcd934x_slim_irq_handler(int irq, void *data)
 {
 	struct wcd934x_codec *wcd = data;
 	unsigned long status = 0;
-	int i, j, port_id;
+	unsigned int i, j, port_id;
 	unsigned int val, int_val = 0;
 	irqreturn_t ret = IRQ_NONE;
 	bool tx;
-- 
2.39.5


