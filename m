Return-Path: <stable+bounces-27272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E980D878314
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 16:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3EAB230E1
	for <lists+stable@lfdr.de>; Mon, 11 Mar 2024 15:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620E456B96;
	Mon, 11 Mar 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nagn15C+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58056B88;
	Mon, 11 Mar 2024 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169981; cv=none; b=ZvLZtC78lMZt9/y8w2TRaM6nGhYvssyPCIC/NNrKlTeqYNpbjY5RTgOlYPDtvXDc8K+SLPVZBYbx1iHR29+sLyGCprhpkZmguv+0ITjV1l4zcb5SPPO0fUWbppY+8oioFP4AYdWpzJ6KRVxlyrY4lkA1SAXGj+AV+c4h7Omns80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169981; c=relaxed/simple;
	bh=yxJXJBt2rnE90+EW1MbwMjyYjD3W0qZ618LNmt+sM4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkRDM1UG/USwT3CJ4emtL78xOMpxNohxSC+7NOutZpZLhRpzYsdI9JYPovdpphcaMlA1t43x8DcOTRgalfsE2hXzrIdqJUye/I7oWEKw+DyiLY+sYHxPPHGVsnpArCK347yu3F5/Ba51E4ZG+gDvFMkQ227CHP45jro43YwWI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nagn15C+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A802AC433C7;
	Mon, 11 Mar 2024 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169981;
	bh=yxJXJBt2rnE90+EW1MbwMjyYjD3W0qZ618LNmt+sM4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nagn15C+eWmbtXRRAIsxUMaHRO8RJ0CGDOSbLMQJxXFZ/A5ePSnHa3E0/ecPr9r8M
	 B8FhM+yzT1Nbi5MZXtChzTrgZ/IL5GmJ92asPCco87XspCgb1b4lc3e46Nd0+HxGmK
	 Ix3a8GHyHAyLsodCOkM/PDjPDr4RouLNIulUBo+aLlDdRlACLQY03Rj0biXzHjfDrV
	 xfUfngjAJeN82e4zMRYJMBcaY+g/EQGNSs33zeQ0JLrrSyH0eLTmuJf1k4/Lyzsa5V
	 1hZqWGw2DT0R8QCgGoUAZ9pCbKcw1fbWdANa57lAy5esfilEg+hJWX5g0dOQo/jWAX
	 UeAW37efDN+xw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	jeremy@system76.com,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 19/23] ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2
Date: Mon, 11 Mar 2024 11:11:59 -0400
Message-ID: <20240311151217.317068-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Jiawei Wang <me@jwang.link>

[ Upstream commit ed00a6945dc32462c2d3744a3518d2316da66fcc ]

Like many other models, the Lenovo 21J2 (ThinkBook 16 G5+ APO)
needs a quirk entry for the internal microphone to function.

Signed-off-by: Jiawei Wang <me@jwang.link>
Link: https://msgid.link/r/20240228073914.232204-2-me@jwang.link
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 17c8ff7558694..de0d399eae8c4 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -199,6 +199,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J2"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


