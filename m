Return-Path: <stable+bounces-127243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14722A76A55
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 17:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FA216527A
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 15:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69C424C09F;
	Mon, 31 Mar 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFPKHJM1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521DA24DFEE;
	Mon, 31 Mar 2025 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433023; cv=none; b=an9zUzx42OA5LHC+rhyIcXQHObKdPa83FgeC338pZXnQo6vL0xIZB4ZK1OuHkd9oeYbog7HAGzFiutELHRkLvrFqnWNnbSUWz3Bt7HLe9zT0tl412xdY4k3db/prDu+W84jsFmESZoiczGFIq0WTch7sYL+jGzGtJF94c3Qii3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433023; c=relaxed/simple;
	bh=Wfb8J2KSjUtt5pwuabWUnt4kRz03uWQmEPmHGs5CXWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UE1qQa3chh9HX0kO7ZLrTSkNDU0gMXzR7L5ohxMPDLi5cHilxg5YwrUB3vmP8FjvdcUinrHlGrd6syJrEBASjpMHbfmsR3CUMTCcPH10QkHevK2mLwrWRAgTf56d/JfUxJR0AvrwquQoAcx5613qOpMZKcUZyYzpBjTuKHOKBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFPKHJM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E604C4CEE3;
	Mon, 31 Mar 2025 14:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743433022;
	bh=Wfb8J2KSjUtt5pwuabWUnt4kRz03uWQmEPmHGs5CXWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CFPKHJM1m9bDEdvFZwnMOifQNp5UTLVoooRMORP9XM6FNFyEHyz0SDtsKv7upz/z3
	 xYqxh94RMGN3XoLX0YhPYQtCF5eBwU7bO9F5a0Ub/9JwGGhKcu0SFdWiKwrlqsr8GW
	 llSMQ1S3EwOmI+u10hzO0bA/Hb1GZdS5TRvdE86l5WY90n3X3cErYuv5eAvCospZwP
	 dq+SnxdsdOp3/YLR0LFWqwE4rEyUbuTI3zJc1CsiltgbH2yAsclHqTmrcBfapZSt+4
	 W5GC8VFnFhctxyoDvz/D9d0xT5QP2QUB+fhB+k/0McNm3wH5fm0bG5j08Jm4vqvy0U
	 pupbkz8JvtskQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: keenplify <keenplify@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	venkataprasad.potturu@amd.com,
	end.to.start@mail.ru,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 9/9] ASoC: amd: Add DMI quirk for ACP6X mic support
Date: Mon, 31 Mar 2025 10:56:42 -0400
Message-Id: <20250331145642.1706037-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145642.1706037-1-sashal@kernel.org>
References: <20250331145642.1706037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
Content-Transfer-Encoding: 8bit

From: keenplify <keenplify@gmail.com>

[ Upstream commit 309b367eafc8e162603cd29189da6db770411fea ]

Some AMD laptops with ACP6X do not expose the DMIC properly on Linux.
Adding a DMI quirk enables mic functionality.

Similar to Bugzilla #218402, this issue affects multiple users.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219853
Signed-off-by: keenplify <keenplify@gmail.com>
Link: https://patch.msgid.link/20250315111617.12194-1-keenplify@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index b45ff8f65f5e2..8ade29e491c51 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -472,6 +472,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "pang13"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Bravo 15 C7UCX"),
+		}
+	},
 	{}
 };
 
-- 
2.39.5


