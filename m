Return-Path: <stable+bounces-98461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FF89E442B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 20:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95E88BA3355
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A05228D7B;
	Wed,  4 Dec 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j40MpG6R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B02185B0;
	Wed,  4 Dec 2024 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331815; cv=none; b=cqYvzbJcxzoYInfzL4ETb3+aPpbwZW7fBv5JbBAZb+a6D2Z8TIdc1Nl/yoL+J2lfMJX71LBCrqAUWtQrFh84FyFTGcfZ4V4Egtrd9eVUf/iSdfFvTjkcpzAorrXRjunjbjd4bEXOEPErDATs7wuqVP9WZhEDepkeaBUBI5GuPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331815; c=relaxed/simple;
	bh=GQwkmtzDG4M/BuzglZ+qdMVuDdlWQTz5IghIPtF2h4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gs6GX0bcMcCaJTi+wdF2pIqPvq39uwHpvj92yrIF3SzivEiBhOIQJcbhCyQAEiIW2fkycXk4/K9BoGaCPVsbfYw1cjblyBxb0U0eZzC6KmCELqB15bQvPFE8jkazh7F273gnppJiRsVs3Yr54p2HC+Quns4SsEhrOCq0k8yEeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j40MpG6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1F2C4CED1;
	Wed,  4 Dec 2024 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331815;
	bh=GQwkmtzDG4M/BuzglZ+qdMVuDdlWQTz5IghIPtF2h4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j40MpG6Ra6EXtlTdiSXlWI3MpM4th9HCRhSftNNTyg2FgdHvbYoelo2XS6+ig46Zv
	 oRfJyMgT3embeTpxsQ2ZZM6yDyV28HnksrmwQs2tNw6hvf/kmbj2hOryjgP4TrEsHV
	 KEA98K0IBRx8VVzFNhxypW+OEoWLGIcT9DSCJ1qvGIklhReymsABmTAP/NSctI7+K4
	 Dviv9KtdFIjJpfSuW1eHjrZNx5iTaB0audSG9EbBDWJUbCuS693sTLovqfqf66bupV
	 j08MqlcHV1VPVeAXlBoEl/rt4bpBlWWeEGaMjdkO6OzVrbcmkqJJobXTbh9T/aqY3N
	 bCyjxJjoQZJsQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andre Przywara <andre.przywara@arm.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 2/7] mfd: axp20x: Allow multiple regulators
Date: Wed,  4 Dec 2024 10:52:07 -0500
Message-ID: <20241204155213.2215170-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155213.2215170-1-sashal@kernel.org>
References: <20241204155213.2215170-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit e37ec32188701efa01455b9be42a392adab06ce4 ]

At the moment trying to register a second AXP chip makes the probe fail,
as some sysfs registration fails due to a duplicate name:

...
[    3.688215] axp20x-i2c 0-0035: AXP20X driver loaded
[    3.695610] axp20x-i2c 0-0036: AXP20x variant AXP323 found
[    3.706151] sysfs: cannot create duplicate filename '/bus/platform/devices/axp20x-regulator'
[    3.714718] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc1-00026-g50bf2e2c079d-dirty #192
[    3.724020] Hardware name: Avaota A1 (DT)
[    3.728029] Call trace:
[    3.730477]  dump_backtrace+0x94/0xec
[    3.734146]  show_stack+0x18/0x24
[    3.737462]  dump_stack_lvl+0x80/0xf4
[    3.741128]  dump_stack+0x18/0x24
[    3.744444]  sysfs_warn_dup+0x64/0x80
[    3.748109]  sysfs_do_create_link_sd+0xf0/0xf8
[    3.752553]  sysfs_create_link+0x20/0x40
[    3.756476]  bus_add_device+0x64/0x104
[    3.760229]  device_add+0x310/0x760
[    3.763717]  platform_device_add+0x10c/0x238
[    3.767990]  mfd_add_device+0x4ec/0x5c8
[    3.771829]  mfd_add_devices+0x88/0x11c
[    3.775666]  axp20x_device_probe+0x70/0x184
[    3.779851]  axp20x_i2c_probe+0x9c/0xd8
...

This is because we use PLATFORM_DEVID_NONE for the mfd_add_devices()
call, which would number the child devices in the same 0-based way, even
for the second (or any other) instance.

Use PLATFORM_DEVID_AUTO instead, which automatically assigns
non-conflicting device numbers.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Link: https://lore.kernel.org/r/20241007001408.27249-4-andre.przywara@arm.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 9db1000944c34..a61e4383d9136 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -968,7 +968,7 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 		return ret;
 	}
 
-	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
+	ret = mfd_add_devices(axp20x->dev, PLATFORM_DEVID_AUTO, axp20x->cells,
 			      axp20x->nr_cells, NULL, 0, NULL);
 
 	if (ret) {
-- 
2.43.0


