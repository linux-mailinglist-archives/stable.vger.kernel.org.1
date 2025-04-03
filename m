Return-Path: <stable+bounces-127960-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D23BA7ADA2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C41189BBFB
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D170B25D208;
	Thu,  3 Apr 2025 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f01DyL7t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5B025D200;
	Thu,  3 Apr 2025 19:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707607; cv=none; b=SaipCft33yk6HdG8GKe0YhVNPKfOBCdZmz4ErQXmHGhU6MXbaRF1KkKhVBmy6i6ugGbRHePmuIIeQyPqyFvusPclYN0Wcbx8cBZqyEBS6CsnJqasNdsQlHYBBYoOSePti12JHwU1w7hUf4/ZkQ5OO0g25SctdHnf2JnyZZbZvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707607; c=relaxed/simple;
	bh=SRyFvLMMRGesH6dLXsN6I9az/EgLLJC2UoRs9dEt4/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=maFbnyBLdrw0tu14Ibq10PPgt1FVEAvdFEJllB9APb2IhIUHkgXin4d2UryIacWi5DWvlu9iqLxAQmfHP8VrcAUR8xphixjZ7FZgai1Hub/9BlvEEpaS+NrRAUFZcsd+JY9bGJrReqxQJBnZJxl20aDNJI+nkla7mxjMPBe0vns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f01DyL7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CADDC4CEE8;
	Thu,  3 Apr 2025 19:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707607;
	bh=SRyFvLMMRGesH6dLXsN6I9az/EgLLJC2UoRs9dEt4/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f01DyL7tHh2c8wjXu2kjpZJRCzgga4H3rWtjvrx3IDdDn++wc2+EQwKJ/6rlRcrY0
	 DBnE2p6klBpf+z4+qohF9Ej4hBPf77v5CbcQjJv/WeED9d6G5j5lrp/XGX9ghNjI8f
	 oy1L6nYIhRRtse6TVrJg+m/T2GNUmsTmMV/eFvL/scwTqClaQTomiv/yL95eUJ03Dd
	 gF6Bbo3RU7l0ff2+el45anRZc+5/lJw2l2GijuUWrEtt/QhsZgWhqGweY1BXgQBsqG
	 uQlmEhSV27tkC4ZHIzDNR+Pli1s61+vdLds2BbYe9H7vt2VbcojZPTlAiVwNYJR1Vf
	 zXjuhv0c/RAGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Atwood <matthew.s.atwood@intel.com>,
	Clint Taylor <Clinton.A.Taylor@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.14 05/44] drm/xe/ptl: Update the PTL pci id table
Date: Thu,  3 Apr 2025 15:12:34 -0400
Message-Id: <20250403191313.2679091-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191313.2679091-1-sashal@kernel.org>
References: <20250403191313.2679091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Matt Atwood <matthew.s.atwood@intel.com>

[ Upstream commit 16016ade13f691da315fac7b23ebf1ab7b28b7ab ]

Update to current bspec table.

Bspec: 72574

Signed-off-by: Matt Atwood <matthew.s.atwood@intel.com>
Reviewed-by: Clint Taylor <Clinton.A.Taylor@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250128175102.45797-1-matthew.s.atwood@intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/drm/intel/pciids.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/drm/intel/pciids.h b/include/drm/intel/pciids.h
index 4035e215c962a..f9d3e85142ea8 100644
--- a/include/drm/intel/pciids.h
+++ b/include/drm/intel/pciids.h
@@ -856,12 +856,10 @@
 	MACRO__(0xB080, ## __VA_ARGS__), \
 	MACRO__(0xB081, ## __VA_ARGS__), \
 	MACRO__(0xB082, ## __VA_ARGS__), \
+	MACRO__(0xB083, ## __VA_ARGS__), \
+	MACRO__(0xB08F, ## __VA_ARGS__), \
 	MACRO__(0xB090, ## __VA_ARGS__), \
-	MACRO__(0xB091, ## __VA_ARGS__), \
-	MACRO__(0xB092, ## __VA_ARGS__), \
 	MACRO__(0xB0A0, ## __VA_ARGS__), \
-	MACRO__(0xB0A1, ## __VA_ARGS__), \
-	MACRO__(0xB0A2, ## __VA_ARGS__), \
 	MACRO__(0xB0B0, ## __VA_ARGS__)
 
 #endif /* __PCIIDS_H__ */
-- 
2.39.5


