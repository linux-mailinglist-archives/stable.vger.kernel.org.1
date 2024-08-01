Return-Path: <stable+bounces-65151-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB35943F2C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 03:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2CA282A39
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 01:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD11E09D1;
	Thu,  1 Aug 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwkT86bE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171481E09C8;
	Thu,  1 Aug 2024 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472668; cv=none; b=ivLkeyTHW4YKlHZ9zcmx+vCkkZjlOHotRFJLT97CpNMJVYnL9c/Ia4HULNuurYp7Ula0QeW7crK9EtCCUyFVREPpG0cQeKeAw82xKDQrzYHl7Lql3WToZpocYib2mFktp6i7idIVXTWei6elKtjK2G8caGHlB+5m7Lyc5DNYMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472668; c=relaxed/simple;
	bh=/TJO27vsNKgNcS2i3huSkC6KKLh0ladBKB8pVWogTbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RntbMLLKbSgCbkEXm3kCSuNiUkew3cB5Q/my2pbQjpnrsTqgoUVV6lhY2mPn5zCitno+XpYR/b/UUYwx6NUpa4+H9nGGtTvgVOyQN6JxopTwY4xWD+ltCNvePN3FtPAR9c+Wk5ErVHwZsTGk/Noe/fsohB94QsaIFtqGw7hG8GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwkT86bE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3C7C4AF0C;
	Thu,  1 Aug 2024 00:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472667;
	bh=/TJO27vsNKgNcS2i3huSkC6KKLh0ladBKB8pVWogTbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FwkT86bESd+t9ct/HNYl4JkeL0ZkUB6S47jIWpppt7Q8NfYH5QgI8hJYjgXwBWMhv
	 whWLTRy0TseqK61wuqFPKejaWtFPd+BX+THJnJQXBnUKCFokIpOFmOWYKGsb7lSHPW
	 fEJsJJ63XHvCJEaS4MdiCLiJVW13Ihf0TKTd2qz0/aaERnYrOwzrfcHdjFkIPYNRL1
	 7/7ApJEgn96w0RexhKpeymEvxb8Ck/h+s2lnYjuVv5Qoa2YXZdMqHaU6lL9tD+0Otm
	 Hvt99NWR2VZ07fb3tAb5QCsTdrvpB0FV5n5TImr9OBoNXVGm4BMyjAMXD/Quhb2vS7
	 U0kfkdvWc54Ow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Huang <Tim.Huang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Hawking.Zhang@amd.com,
	lijo.lazar@amd.com,
	electrodeyt@gmail.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 14/38] drm/amdgpu: fix mc_data out-of-bounds read warning
Date: Wed, 31 Jul 2024 20:35:20 -0400
Message-ID: <20240801003643.3938534-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801003643.3938534-1-sashal@kernel.org>
References: <20240801003643.3938534-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Tim Huang <Tim.Huang@amd.com>

[ Upstream commit 51dfc0a4d609fe700750a62f41447f01b8c9ea50 ]

Clear warning that read mc_data[i-1] may out-of-bounds.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 469352e2d6ecf..436d436b2ea23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -1626,6 +1626,8 @@ int amdgpu_atombios_init_mc_reg_table(struct amdgpu_device *adev,
 										(u32)le32_to_cpu(*((u32 *)reg_data + j));
 									j++;
 								} else if ((reg_table->mc_reg_address[i].pre_reg_data & LOW_NIBBLE_MASK) == DATA_EQU_PREV) {
+									if (i == 0)
+										continue;
 									reg_table->mc_reg_table_entry[num_ranges].mc_data[i] =
 										reg_table->mc_reg_table_entry[num_ranges].mc_data[i - 1];
 								}
-- 
2.43.0


