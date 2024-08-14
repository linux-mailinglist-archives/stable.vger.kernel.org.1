Return-Path: <stable+bounces-67569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A09511EE
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 04:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA6B1F24034
	for <lists+stable@lfdr.de>; Wed, 14 Aug 2024 02:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3AC2E3E8;
	Wed, 14 Aug 2024 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT0v6k2e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5231D28DB3;
	Wed, 14 Aug 2024 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601697; cv=none; b=OFyw5wCGTIT7ZHaFmnybUY9hADpXDWxBVG5Or+Zo645i3z7qeQ6hhG773IgqDtVLsphTvpkwzLj2huGgq/lQDFzrvrRoBALoDGfYRAXBZbjKW+qdAqNRXXBIjYG+xPymmjAHx3JyC0PN5dn7KPbL2fN3nC0wIhZeymR56jkHVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601697; c=relaxed/simple;
	bh=PkhGL8RZitGHdjEjDrMoW+Y9f3CCmQ6R105nxkrwP8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJvirw1eg/Vd8EZ93o1kgfRJOg1E+MFgd0VXetQIXmcE0jI20OXWQgEnkbz5PfZG9kdP4lGC4WQge7WcNXOMYmgcfsG9itdWPEp3FeQe2ww/ggCFyGcRaBuuYsP5rp7CkN+JTom2nzvvkK3M7XgcfDywlqnO/TDQBsGTJDTY0SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT0v6k2e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032CDC4AF10;
	Wed, 14 Aug 2024 02:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723601696;
	bh=PkhGL8RZitGHdjEjDrMoW+Y9f3CCmQ6R105nxkrwP8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BT0v6k2eRoDtKHZqZ+AOnG80xyAu6HRU26ctDqEFIxYWRCLZc4DVuePrv/4WNENOT
	 43f2Ow5HS+r3E89diSvqfTlvuaRZFIXJuNN382q3yTXnR2rxdMdAv/mN1nuy5JvWxG
	 qWDe7lAu74K9b5EJpL/9lbhtACKMmvKOYENStWveLwLJKURT4y5QO0JFWP/pa0oVXR
	 +CpnLfQXxdk1ry76yMzF859qwdhYWYigBPPoCW039HdV3iLgTCeFlQoX8W62h4J1IP
	 0mwpqh5aNKYBWqPQjAqtS6K8fy3MwpCQG2Q0axJIHhdXwQA0JHueJojHQL1yy8YS+q
	 A1aSCyJ553WbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Luke D. Jones" <luke@ljones.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	Shyam-sundar.S-k@amd.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 03/13] platform/x86/amd: pmf: Add quirk for ROG Ally X
Date: Tue, 13 Aug 2024 22:14:34 -0400
Message-ID: <20240814021451.4129952-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814021451.4129952-1-sashal@kernel.org>
References: <20240814021451.4129952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.4
Content-Transfer-Encoding: 8bit

From: "Luke D. Jones" <luke@ljones.dev>

[ Upstream commit 4c83ee4bf32ea8e57ae2321906c067d69ad7c41b ]

The ASUS ROG Ally X has the same issue as the G14 where it advertises
SPS support but doesn't use it.

Signed-off-by: Luke D. Jones <luke@ljones.dev>
Link: https://lore.kernel.org/r/20240729020831.28117-1-luke@ljones.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/pmf-quirks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
index 0b2eb0ae85feb..460444cda1b29 100644
--- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
+++ b/drivers/platform/x86/amd/pmf/pmf-quirks.c
@@ -29,6 +29,14 @@ static const struct dmi_system_id fwbug_list[] = {
 		},
 		.driver_data = &quirk_no_sps_bug,
 	},
+	{
+		.ident = "ROG Ally X",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "RC72LA"),
+		},
+		.driver_data = &quirk_no_sps_bug,
+	},
 	{}
 };
 
@@ -48,4 +56,3 @@ void amd_pmf_quirks_init(struct amd_pmf_dev *dev)
 			dmi_id->ident);
 	}
 }
-
-- 
2.43.0


