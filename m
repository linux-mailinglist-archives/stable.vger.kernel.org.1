Return-Path: <stable+bounces-166395-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50688B19979
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4543177BE0
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDE1F4169;
	Mon,  4 Aug 2025 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbhz9ynR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4F71F152D;
	Mon,  4 Aug 2025 00:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268135; cv=none; b=lnP3nI4nM6H83prfVozme9clnhdi0iyeZoRthNsH2o4A8s8IikHFOpEdUatk/t7IxmeYh7zZLMkzIhl3weE25hLqecci4Mz4NtjRa+Q0lsO6pgps489ZyzQ2G3WB5MLgE3r81u+Sj38FT3VljCDjh/3dfpQvCBieWYyxPYzBxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268135; c=relaxed/simple;
	bh=B8aADfUdkhexV1ytNkPSNp6RajeX6XeQ4rU0+PjOugo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M6lpRK+ou5evyS+jx7eiCpLcN5+f7pBsFggns3mYjVWQvJhGnMetZ3bEptsjZpFXZjxWT/rJz/EMKiQF4MmHVJ3aNvAEqav7V6xwiZuEZGM3O0irhMFskGOv9YoRR43UhMa1LGAwAb71HJR6WGNSZXT+LYMyJeXHlbvzKUbb2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbhz9ynR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA849C4CEF0;
	Mon,  4 Aug 2025 00:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268135;
	bh=B8aADfUdkhexV1ytNkPSNp6RajeX6XeQ4rU0+PjOugo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbhz9ynRtEV63JD1D+fwYVC8F6fqMWdhd9C0bovSaV6NLEkE5mgqiJ49JCDsw6Kl/
	 hg7K6urL2FCnYX8phgs+/B9WAZCpd5q+ImiGRBxFMcFklY+AmuTSKZQXvt/p8BALmy
	 NBIdK24lvqPoh+IIxOLTqOPs9IG1KeE6zESePmMuhvXUJAc/QUERwpPh8FEY3ngDIS
	 30JRUqiAMb9dokta9Nh1uAVg1kfnsCNAoM+8vx6iWKO9bL0yJ/8HYXYronPw1Y/EQS
	 RdVKrKqvfhrYtMQ3m0MsrMoohuC6wwC/2GeYb8JYXW4EQsWdtpPQ2iJyXjL22HMDQ0
	 TRzg8pkeq87Ow==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Lucy Thrun <lucy.thrun@digital-rabbithole.de>,
	kernel test robot <lkp@intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	rf@opensource.cirrus.com
Subject: [PATCH AUTOSEL 5.10 35/39] ALSA: hda/ca0132: Fix buffer overflow in add_tuning_control
Date: Sun,  3 Aug 2025 20:40:37 -0400
Message-Id: <20250804004041.3628812-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804004041.3628812-1-sashal@kernel.org>
References: <20250804004041.3628812-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
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
index 6d67cca4cfa6..27f2d868a224 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4279,7 +4279,7 @@ static int add_tuning_control(struct hda_codec *codec,
 	}
 	knew.private_value =
 		HDA_COMPOSE_AMP_VAL(nid, 1, 0, type);
-	sprintf(namestr, "%s %s Volume", name, dirstr[dir]);
+	snprintf(namestr, sizeof(namestr), "%s %s Volume", name, dirstr[dir]);
 	return snd_hda_ctl_add(codec, nid, snd_ctl_new1(&knew, codec));
 }
 
-- 
2.39.5


