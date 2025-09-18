Return-Path: <stable+bounces-166121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4BAB197D4
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328997AABBF
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D011D5CC9;
	Mon,  4 Aug 2025 00:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2fY6TzT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E116818A6B0;
	Mon,  4 Aug 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267438; cv=none; b=QZqSdzJ3h7dBlYUryEkur5IMwx6y7gBlHBvGGbljzd4k46uhKvoSDrj+vAoxlxKMsE0rh+Op2aNMes9tCq1IOsBGhKLN51t4q1TcGBzi3k9wuM9xlQETuaHT05bo9vgl6bOLf+Ii85zG5wtvwHDjyUmBJmdbKeQ3TjsE/mEMimE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267438; c=relaxed/simple;
	bh=imkdxUPOVg4wwFj4YrTWxG6b+FGHfIW3uLVayqo+ddY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIwq4WVRq3HKaJDIK53R4NvPk85fIPhKdaX8UkSl/idr5gOmnOMeV/dPWYjnN3KmG1V284YcwOM69Mma3N8k5mFklQFTwDR/d4EQNBL+1D2TWWfOjmZm7fJA29hi9uI1CSkYmANDUc9p7UgZL07vAcDmcvkvSLbEpTh2aHOV+ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2fY6TzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A8FC4CEF0;
	Mon,  4 Aug 2025 00:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267437;
	bh=imkdxUPOVg4wwFj4YrTWxG6b+FGHfIW3uLVayqo+ddY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l2fY6TzTkhsesES53WpeuTWoAB+BFS6ErfDqLofgM7BiR6baL+rBDwqAESa/Yg1QU
	 ySuCIWuoHAglsJScx/skmmhX1sb6hnanEH/lbwQjya7zL6CPrGzz3UBxCM10+mYiZq
	 y+fUbRkWcRxLgZT0xKVAOwFYBjE+zcDdudtgpaah12F9CLmNbi/erV27lAQVJgX+m8
	 1TYEhSZpCT1wFqLpwNDowMz8M4XHlOfAnwp35F8eeDEvxDm93XGGvYbdIPUpsWpNkM
	 Vo4WEyv7k/Gn5oXf4sC0ZsIFJdYWED3Gz2EIIb/TawKFVowOXPlOPJYc7D3f5Qp7Uh
	 +/AHyXc+MDKAQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 65/80] ASoC: core: Check for rtd == NULL in snd_soc_remove_pcm_runtime()
Date: Sun,  3 Aug 2025 20:27:32 -0400
Message-Id: <20250804002747.3617039-65-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002747.3617039-1-sashal@kernel.org>
References: <20250804002747.3617039-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.9
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 2d91cb261cac6d885954b8f5da28b5c176c18131 ]

snd_soc_remove_pcm_runtime() might be called with rtd == NULL which will
leads to null pointer dereference.
This was reproduced with topology loading and marking a link as ignore
due to missing hardware component on the system.
On module removal the soc_tplg_remove_link() would call
snd_soc_remove_pcm_runtime() with rtd == NULL since the link was ignored,
no runtime was created.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20250619084222.559-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**YES**

This commit should be backported to stable kernel trees. The analysis
reveals this is a critical NULL pointer dereference fix that prevents
kernel crashes.

**Key reasons for backporting:**

1. **Fixes a Real Crash**: The commit adds a NULL check to prevent a
   kernel panic that occurs when `snd_soc_remove_pcm_runtime()` is
   called with `rtd == NULL`. The code change shows this clearly:
```c
+   if (!rtd)
+       return;
```
Without this check, the subsequent line
`snd_soc_card_remove_dai_link(card, rtd->dai_link)` would dereference
NULL.

2. **Minimal and Safe Fix**: The change is extremely small (3 lines) and
   defensive - it simply adds a NULL check with early return. This
   follows the stable kernel rule of minimal, contained fixes.

3. **Affects Production Systems**: The commit message indicates this
   occurs during topology loading when hardware components are missing -
   a real-world scenario. The issue manifests on module removal when
   `soc_tplg_remove_link()` calls the function with NULL.

4. **Well-Reviewed**: The commit has 5 Reviewed-by tags from Intel ASoC
   maintainers, indicating thorough review and consensus on the fix.

5. **No Side Effects**: The fix has no architectural changes or new
   features - it purely adds defensive programming to prevent crashes.
   The function already had EXPORT_SYMBOL_GPL, indicating it's part of
   the kernel API that could be called from various contexts.

This is exactly the type of commit stable trees want: a small, obvious
fix for a real crash scenario with no risk of regression.

 sound/soc/soc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3f97d1f132c6..0db6db16f28b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1139,6 +1139,9 @@ static int snd_soc_compensate_channel_connection_map(struct snd_soc_card *card,
 void snd_soc_remove_pcm_runtime(struct snd_soc_card *card,
 				struct snd_soc_pcm_runtime *rtd)
 {
+	if (!rtd)
+		return;
+
 	lockdep_assert_held(&client_mutex);
 
 	/*
-- 
2.39.5


