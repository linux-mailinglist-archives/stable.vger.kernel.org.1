Return-Path: <stable+bounces-107729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD91A02E03
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 17:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF463A269F
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E8E1DF263;
	Mon,  6 Jan 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3P7Ppa1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556441DF724;
	Mon,  6 Jan 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181720; cv=none; b=ioUHC6OHYpucJQUfNFx17o+I6FkWnA+de6JX/G4a6PA8IiA+5VRKk0x+HXT40o6jzcozz9udpYW97UXrjVRU1G+LLnFJ6Mr8Jrt4vk8ufvfrp3nOOyGtWIWcnt4wZZqKbfCg3klL7xRm40jjET4rJ8G3aSOSb9HkrtjbSBuRr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181720; c=relaxed/simple;
	bh=zAhW4qGEiM6YKlBRH2+uyuO431XV0Ri1PbiXYNzgoTs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nc/9x7TyQWD1OdMwAWds/DMPZMUHDn8mMux6+iQIQAkDtMQly2eopQhSbLApeERPKdxYRyliP5htVpU7YTPRF7Pm1DuH8E1XQgF0XyZwVPpFNJKPC8VlyMW/L+ab6g1QrZwSJmE0jcIBxCcFcQOKmJVmNtOxDYWmDwnd7HfOpQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3P7Ppa1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63C7C4CEDF;
	Mon,  6 Jan 2025 16:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181720;
	bh=zAhW4qGEiM6YKlBRH2+uyuO431XV0Ri1PbiXYNzgoTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3P7Ppa1qmLfmLdKx/agmCeihF8Drvd1M/uuHx3lXAe0cvR1ErK0HLonPiwXRvPD6
	 Yqbr8nBagn6FHJ7Vm3XZH/vJ/q6QFcdWvF0HYRPZTElgtxL6HoJimriScne50+0RLE
	 9Ex4Lq/kqbxf1j3dmRcB0KQuREp6J98TZCFiuYP9flM2+a6SuGb4PcoL7mFfGThI4S
	 hgrZEP239d2y73bs3QfyqDmtkoz7ofaNYeOc70NImfsLYSbwxLk5aEa8RfMF7+cLj9
	 TUk2ZmOmeH65FNXeF2rTi/UzNTMft9cENJnsd9JpDszbNNEms6GPpkEzau+ffyRkBG
	 kRc7GrAC+Xubg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Xi Xiao <1577912515@qq.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	alexbelm48@gmail.com,
	W_Armin@gmx.de,
	u.kleine-koenig@baylibre.com,
	aichao@kylinos.cn,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 6/8] platform/x86: hp-wmi: mark 8A15 board for timed OMEN thermal profile
Date: Mon,  6 Jan 2025 11:41:06 -0500
Message-Id: <20250106164138.1122164-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106164138.1122164-1-sashal@kernel.org>
References: <20250106164138.1122164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.8
Content-Transfer-Encoding: 8bit

From: Mingcong Bai <jeffbai@aosc.io>

[ Upstream commit 032fe9b0516702599c2dd990a4703f783d5716b8 ]

The HP OMEN 8 (2022), corresponding to a board ID of 8A15, supports OMEN
thermal profile and requires the timed profile quirk.

Upon adding this ID to both the omen_thermal_profile_boards and
omen_timed_thermal_profile_boards, significant bump in performance can be
observed. For instance, SilverBench (https://silver.urih.com/) results
improved from ~56,000 to ~69,000, as a result of higher power draws (and
thus core frequencies) whilst under load:

Package Power:

- Before the patch: ~65W (dropping to about 55W under sustained load).
- After the patch: ~115W (dropping to about 105W under sustained load).

Core Power:

- Before: ~60W (ditto above).
- After: ~108W (ditto above).

Add 8A15 to omen_thermal_profile_boards and
omen_timed_thermal_profile_boards to improve performance.

Signed-off-by: Xi Xiao <1577912515@qq.com>
Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
Link: https://lore.kernel.org/r/20241226062207.3352629-1-jeffbai@aosc.io
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 8c05e0dd2a21..3ba9c43d5516 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -64,7 +64,7 @@ static const char * const omen_thermal_profile_boards[] = {
 	"874A", "8603", "8604", "8748", "886B", "886C", "878A", "878B", "878C",
 	"88C8", "88CB", "8786", "8787", "8788", "88D1", "88D2", "88F4", "88FD",
 	"88F5", "88F6", "88F7", "88FE", "88FF", "8900", "8901", "8902", "8912",
-	"8917", "8918", "8949", "894A", "89EB", "8BAD", "8A42"
+	"8917", "8918", "8949", "894A", "89EB", "8BAD", "8A42", "8A15"
 };
 
 /* DMI Board names of Omen laptops that are specifically set to be thermal
@@ -80,7 +80,7 @@ static const char * const omen_thermal_profile_force_v0_boards[] = {
  * "balanced" when reaching zero.
  */
 static const char * const omen_timed_thermal_profile_boards[] = {
-	"8BAD", "8A42"
+	"8BAD", "8A42", "8A15"
 };
 
 /* DMI Board names of Victus laptops */
-- 
2.39.5


