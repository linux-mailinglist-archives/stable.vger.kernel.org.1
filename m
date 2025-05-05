Return-Path: <stable+bounces-140188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F42AAAA5EC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF3F4A066F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2EB72601;
	Mon,  5 May 2025 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUo/5T3S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757A28E5E5;
	Mon,  5 May 2025 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484295; cv=none; b=Oub82FdiSPmkhzKMBoD6b8uA3tmHqOygzcjZiNl4Xtn6Pi1zxbeSLCPKrJEcVK/9L5rmPe0qvKMhfDJoxz5Wq+H4XiaEAJL8uZFaPFiaAR8tIwrQwDAhh4XSZsU2JY8pM/L3iph3gsBGzcSiPa72FwCR4f6jkorBsA1AUZyxxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484295; c=relaxed/simple;
	bh=/XviaWuuRCkEJe3Qn1xC+r9oxfkBTCfyMpPOiM9mVG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KCvuM5f3c6MR0MgvgE7ab969h4SvmTezebvlVkwyVCRCcPjJq4tQ5AerQj+Z7a4y3yD6ewIBsNlhPvZIWV+X75cLeqtGloECtvnVVfnS1aWpBEXHnWvwfOapqF8xapwWPYJ936eJqJx4RcIiiqBYhvfUn/4QqF7nukRA+d1rdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUo/5T3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A23C4CEED;
	Mon,  5 May 2025 22:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484295;
	bh=/XviaWuuRCkEJe3Qn1xC+r9oxfkBTCfyMpPOiM9mVG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CUo/5T3Sh1msZLSBxNF1R78e11cQcOo4h7q/rhXmEX1znE9Jx7JXsKiGm1FE6d9ZJ
	 e5qt28M26p0F8XTHliIi34kfHVYMeR7bqz7HwlBByI8/gcSw1kvvjJO1x5VcROw5D8
	 URvd/+JmKnsGu2ZMdk/Mqhjo+IvWugdKkBez1Z065y6c3Ure4QGchDyEsrmuvngYIE
	 MG9dMV3y1uG44HkOTFwQ/Aq13lxbg6lDKURWzghV1wS5MNIzjdGHEJ7SdgafsDFGsU
	 /ie8Bh98dVzrHI41hWU/HMj63GKUo6XtnGLFYehPZtSECCEfH4aR5c2Le1lzPOvbGf
	 2Q3mnUd7ks4kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xin Wang <x.wang@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Fei Yang <fei.yang@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 441/642] drm/xe/debugfs: fixed the return value of wedged_mode_set
Date: Mon,  5 May 2025 18:10:57 -0400
Message-Id: <20250505221419.2672473-441-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Xin Wang <x.wang@intel.com>

[ Upstream commit 6884d2051011f4db9e2f0b85709c79a8ced13bd6 ]

It is generally expected that the write() function should return a
positive value indicating the number of bytes written or a negative
error code if an error occurs. Returning 0 is unusual and can lead
to unexpected behavior.

When the user program writes the same value to wedged_mode twice in
a row, a lockup will occur, because the value expected to be
returned by the write() function inside the program should be equal
to the actual written value instead of 0.

To reproduce the issue:
echo 1 > /sys/kernel/debug/dri/0/wedged_mode
echo 1 > /sys/kernel/debug/dri/0/wedged_mode   <- lockup here

Signed-off-by: Xin Wang <x.wang@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Fei Yang <fei.yang@intel.com>
Cc: Shuicheng Lin <shuicheng.lin@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250213223615.2327367-1-x.wang@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 492b4877433f1..6bfdd3a9913fd 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -166,7 +166,7 @@ static ssize_t wedged_mode_set(struct file *f, const char __user *ubuf,
 		return -EINVAL;
 
 	if (xe->wedged.mode == wedged_mode)
-		return 0;
+		return size;
 
 	xe->wedged.mode = wedged_mode;
 
-- 
2.39.5


