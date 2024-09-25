Return-Path: <stable+bounces-77269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8AA985B4A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599FC286AA5
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCE01BC068;
	Wed, 25 Sep 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvAxzPMv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684991922F9;
	Wed, 25 Sep 2024 11:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264886; cv=none; b=Ux36C0kVb6WlqIEhKFsZqXFqTJj2mcA9CCNymDUmfRmVStIL/yTORWA8zFSfRHVyQ2qmq7HF/JD/NCRUca5woHAqMt679hPxHubPBb+WcCq9aviErhbz0SvZaIRVSUg8OSvsE4d/s6f7HqoQTUmmxMGFusWBMmOBwdwW5LGWE9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264886; c=relaxed/simple;
	bh=/jogK1MMdwj6REs5/GO1TXbIHyYfWZbcYxgds7txnm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kzaEnQMzE7ALBnao2f98tRbl71F1oQy1ZBMm+zimPjUjB2hMRgdrIEuYQCpwjFAvm3r+3iI2TcsSgWZard3HEmkHVYjCoUXo9srLJoBvXU+2Q0o6wh1+dFEAOEjTdOs04h2BGEFX9LeASYV71jRZhq4DD8E+H1zsxZkmd8I1PNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvAxzPMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01539C4CECD;
	Wed, 25 Sep 2024 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264885;
	bh=/jogK1MMdwj6REs5/GO1TXbIHyYfWZbcYxgds7txnm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PvAxzPMvCTFlv00J5mRi9GWjhpVrUW9stqktEZSYyZrBU6o10TLl3A2Alk+ogGJQA
	 kGEGZHPcJGFcWnCHvQph3UwvrqOxu3vqdF41Hzjo4WAFH+bLrhPBocHKnZ+2vvjIc1
	 KWjTOzOENOY6v9B4A2+aT2bnmsUzopJ2IKVP8BQum2CvXI+y2zboi6cBiFG2fUHFZ1
	 SUuZtle5TjqVgzaKy0TeEGqsmq95kijVE4IQYJmZE3/ReXZaqXW/sVIf24k0vhpvK/
	 00Q2LxMseCV6L3C/Y+Q9ozcNkilIx7MUQw+DSlpTBj0eowd5OU0utVfH/U7G06ZvLY
	 waQV6wk9pl2JQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peng Liu <liupeng01@kylinos.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	sunil.khatri@amd.com,
	Prike.Liang@amd.com,
	Tim.Huang@amd.com,
	kevinyang.wang@amd.com,
	pierre-eric.pelloux-prayer@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 171/244] drm/amdgpu: enable gfxoff quirk on HP 705G4
Date: Wed, 25 Sep 2024 07:26:32 -0400
Message-ID: <20240925113641.1297102-171-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Peng Liu <liupeng01@kylinos.cn>

[ Upstream commit 2c7795e245d993bcba2f716a8c93a5891ef910c9 ]

Enabling gfxoff quirk results in perfectly usable
graphical user interface on HP 705G4 DM with R5 2400G.

Without the quirk, X server is completely unusable as
every few seconds there is gpu reset due to ring gfx timeout.

Signed-off-by: Peng Liu <liupeng01@kylinos.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 9360a4425c4ae..fc4153a87f947 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1303,6 +1303,8 @@ static const struct amdgpu_gfxoff_quirk amdgpu_gfxoff_quirk_list[] = {
 	{ 0x1002, 0x69af, 0x106b, 0x019a, 0xc0 },
 	/* https://bbs.openkylin.top/t/topic/171497 */
 	{ 0x1002, 0x15d8, 0x19e5, 0x3e14, 0xc2 },
+	/* HP 705G4 DM with R5 2400G */
+	{ 0x1002, 0x15dd, 0x103c, 0x8464, 0xd6 },
 	{ 0, 0, 0, 0, 0 },
 };
 
-- 
2.43.0


