Return-Path: <stable+bounces-166425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BABAB1999B
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F6A17A117C
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704311E9B3F;
	Mon,  4 Aug 2025 00:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIVNV5GW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC5A1CEAA3;
	Mon,  4 Aug 2025 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268213; cv=none; b=pqwwP43R/niQs8Ho5EeJTzD3oWajrPJNu/LXOwv71od1POlWyCHy/4vL5Kx74ZT9ixdH4IO0uC4jqoeGnijEwSiJjVUxmI40dJIYY6xziMfR2UdgsOx3WsiWCvgdJBmcu1hL45HVSVLG91I6Es9a98aRAT3LuqDNoA/8adRIcM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268213; c=relaxed/simple;
	bh=ALpX4jsdWf4Bjq8syEbb959ztdpip4zYOMyTgRPjR+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WwqpveT4lP+FQrZuzOPQ0ad+I0I6iq9RKqvf/9hQAClqxiLDFmDCSmDW8wwShEeQMkhgjYPycmE3lKPgWniZaR2kLmPTd4Uxq6yWkdIVWlpbl7nwo13EnLae0t3dTJ+8pF1YMq1EY/Ch2nuJ0I3WSD92g5Q3Nzm+huPpECVi7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIVNV5GW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0E1C4CEF0;
	Mon,  4 Aug 2025 00:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268212;
	bh=ALpX4jsdWf4Bjq8syEbb959ztdpip4zYOMyTgRPjR+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIVNV5GWmH12Xu2YwKsIbwE2jDTiKhyH0msKMVKAYG7ZFcBmJSVBb7rXz8RcjV/al
	 Av6/7u1wTZrzR/H7pqLeoxaGBPtd2yqyON7XY77PFB4cq03dPpswwr3qy+xtbVqhXm
	 Exi6wDRLHw7wCI92/pO0mkJ5b9cQqAxcDeFbrwzhrUxR0dNdB8WgRnNO6CYcUv8Pn2
	 GuGts6lMvcvl1FDRKfqDQVv2pTtodVWxUJqZW61pEkbKBxE50OwLlkFrmLTf2xFhY/
	 vS0wG5Mdgbd56XJleQrqm/foz14tjAYrze2ufgeapEOQ9yEDWkZNKst1ycpoPpSWpU
	 ugPOFSkSAYE9Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lucy Thrun <lucy.thrun@digital-rabbithole.de>,
	kernel test robot <lkp@intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	rf@opensource.cirrus.com
Subject: [PATCH AUTOSEL 5.4 26/28] ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control
Date: Sun,  3 Aug 2025 20:42:25 -0400
Message-Id: <20250804004227.3630243-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804004227.3630243-1-sashal@kernel.org>
References: <20250804004227.3630243-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.296
Content-Transfer-Encoding: 8bit

From: Lucy Thrun <lucy.thrun@digital-rabbithole.de>

[ Upstream commit a409c60111e6bb98fcabab2aeaa069daa9434ca0 ]

The 'sprintf' call in 'add_tuning_control' may exceed the 44-byte
buffer if either string argument is too long. This triggers a compiler
warning.
Replaced 'sprintf' with 'snprintf' to limit string lengths to prevent
overflow.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202506100642.95jpuMY1-lkp@intel.com/
Signed-off-by: Lucy Thrun <lucy.thrun@digital-rabbithole.de>
Link: https://patch.msgid.link/20250610175012.918-3-lucy.thrun@digital-rabbithole.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a real security vulnerability**: The commit fixes a buffer
   overflow vulnerability in the `add_tuning_control` function. The
   sprintf call could overflow the 44-byte `namestr` buffer (defined as
   `char namestr[SNDRV_CTL_ELEM_ID_NAME_MAXLEN]` where
   `SNDRV_CTL_ELEM_ID_NAME_MAXLEN` is 44).

2. **Long-standing bug**: The vulnerable code was introduced in 2012
   (commit 44f0c9782cc6a), meaning this buffer overflow has existed in
   the kernel for over a decade, affecting many stable kernel versions.

3. **Simple and contained fix**: The fix is minimal - it simply replaces
   `sprintf` with `snprintf` on a single line:
  ```c
   - sprintf(namestr, "%s %s Volume", name, dirstr[dir]);
   + snprintf(namestr, sizeof(namestr), "%s %s Volume", name,
dirstr[dir]);
   ```

4. **Low risk of regression**: The change is straightforward and only
   adds bounds checking. It doesn't change any logic or behavior when
   strings fit within the buffer.

5. **Detected by automated testing**: The issue was caught by the kernel
   test robot, indicating it's a real compiler warning that should be
   addressed.

6. **Potential for exploitation**: While the tuning control names like
   "Wedge Angle", "SVM Level", and "EQ Band0-9" are relatively short,
   combined with "Playback" or "Capture" and " Volume", they could
   theoretically overflow the 44-byte buffer. For example: "EQ Band9"
   (8) + " " (1) + "Playback" (8) + " Volume" (7) = 24 bytes, which is
   safe, but the vulnerability exists if longer names were added in the
   future.

7. **Affects user-facing functionality**: This is in the ALSA HD Audio
   driver for Creative CA0132 sound cards, which are used by end users,
   making it important to fix in stable kernels.

The fix follows stable kernel rules perfectly: it's a minimal change
that fixes an important bug without introducing new features or
architectural changes.

 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 40f50571ad63..dee38dd872b5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4014,7 +4014,7 @@ static int add_tuning_control(struct hda_codec *codec,
 	}
 	knew.private_value =
 		HDA_COMPOSE_AMP_VAL(nid, 1, 0, type);
-	sprintf(namestr, "%s %s Volume", name, dirstr[dir]);
+	snprintf(namestr, sizeof(namestr), "%s %s Volume", name, dirstr[dir]);
 	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
 }
 
-- 
2.39.5


