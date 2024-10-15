Return-Path: <stable+bounces-85855-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B5099EA85
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 14:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D7C1C227B3
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902A01AF0B7;
	Tue, 15 Oct 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BaH87+1c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CB1C07DD;
	Tue, 15 Oct 2024 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728996916; cv=none; b=thEyO3e7Q8rJ8x27Hce04FSTgGNU5gHIDam5TQOfgtKk/Rmkc88AAXmWOQ2cIbMo965wArVJ9dQpI+31qXU+8vRYPWwvFM5Wqh9jqQi8/pue9RSZOy3x/TVKkf7kUHx1XAAMTVqxx5as7XMlmezwFfT7VB0xzzjfXhUS8OSFS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728996916; c=relaxed/simple;
	bh=NJFTUemeaPyjvQj0IIL/4D8yzLv1XGkf3qBq3FIex68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2jMquw8011A0S/00NCfGBpzepmseIL4N84FfPQyO5v1JdWzAC+KgWfo61uys6If5/wliyNH0EaPKkpOKHvgfx5ZjV3FJ8xOsnNZJxFgNe4pYzZ0yddFhb9GzB72Ha+xNh2s9tAy4LZc+qFfp8Hxdn3YEFrkVBC16efW40zHLJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BaH87+1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2FCC4CEC6;
	Tue, 15 Oct 2024 12:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728996916;
	bh=NJFTUemeaPyjvQj0IIL/4D8yzLv1XGkf3qBq3FIex68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaH87+1c80qYPUljepDQ/SQejJNqj/hWiWRls+rVzhsv5W0bGHDjRZREMK/mc68Eq
	 j9e85FapXSdSGD8pYhsKnwXHGHN4YPsHQ3RxcY5rZSNtLH6c03S5WHdXc89eCJrn4F
	 dVkHuYCr2K02p3IIOc6sDG3WzIjJ6geCKrAVExpw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongbo Li <lihongbo22@huawei.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 029/518] ASoC: allow module autoloading for table db1200_pids
Date: Tue, 15 Oct 2024 14:38:53 +0200
Message-ID: <20241015123918.131585189@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hongbo Li <lihongbo22@huawei.com>

[ Upstream commit 0e9fdab1e8df490354562187cdbb8dec643eae2c ]

Add MODULE_DEVICE_TABLE(), so modules could be properly
autoloaded based on the alias from platform_device_id table.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
Link: https://patch.msgid.link/20240821061955.2273782-2-lihongbo22@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/au1x/db1200.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 5f8baad37a401..48243164b7ac8 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -44,6 +44,7 @@ static const struct platform_device_id db1200_pids[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(platform, db1200_pids);
 
 /*-------------------------  AC97 PART  ---------------------------*/
 
-- 
2.43.0




