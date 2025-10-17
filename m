Return-Path: <stable+bounces-186343-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D50BBE9554
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00C44267E9
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C81D3370F8;
	Fri, 17 Oct 2025 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBEz+5pH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7463370E8
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712544; cv=none; b=cCih24ZBhu039R42l2kbadpal59HB34TN2utyjrfsEtc60h1zDso7O2rsbUHLC8ICKFls6LDjv45rYC9MacgL5f+IScbvshrPcj5n+cqDwnKsp+w9hvC85mSif3/GqQRbU/2eN2jZmkGpVpNJtcvQAwLq0rvO9F73gRVnjDsdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712544; c=relaxed/simple;
	bh=xNECdUme27H/FyO/lLP84doY+ketMceeue/7rtyHpl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GqNfX7vmPXUlLHe2+Gv4O9beG865nUcOVzSduqRXygfmDKEEllAZFEQoLNxF7KqCSkLdB/t/954hnoYbih4YfbkJuGaIlIS3++cbL/x+mDI5i1OWskXC6yXd5l31SW0I8zxTQdCqIQxnhZjOHBeTN1wL298/Dx2bkdlizYwlsw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBEz+5pH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981F9C4CEE7;
	Fri, 17 Oct 2025 14:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760712543;
	bh=xNECdUme27H/FyO/lLP84doY+ketMceeue/7rtyHpl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBEz+5pHNBKudPGKpguqxsXsQ3tCjeGAC9ZF7kcIyk2rKDWK/x9/ocbc24o/qLs01
	 RCJI7vXfFlygTbngtK7attFp4O6cddPMfa87AiKNWwbrq8tycCtl70vYddjbAo/mks
	 tak/q0Pioa1GVByQUV3ids6LOfJ6bk9GjtYacQXNVsTj8BmCTIHcmQxl+/qNKFuZG0
	 BT+K27v26txRPZIQG9QpMGKjZyKvtGXuRRstZtD6TMTB/iK96PbH6HS8gwJ3YKrdpU
	 FUU4tdW1O+/GcsAIYuUr53qQSLSA5RoAF+6uk6hkJSDKsG1qWU7J4B4npM6Ob9jaOL
	 /1njPJf2Nnm9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] media: s5p-mfc: constify fw_name strings
Date: Fri, 17 Oct 2025 10:48:56 -0400
Message-ID: <20251017144900.4007781-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101646-overtake-starch-c0ab@gregkh>
References: <2025101646-overtake-starch-c0ab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit dd761d3cf4d518db197c8e03e3447ddfdccdb27e ]

Constify stored pointers to firmware names for code safety.  These are
not modified by the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Aakarsh Jain <aakarsh.jain@samsung.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: 7fa37ba25a1d ("media: s5p-mfc: remove an unused/uninitialized variable")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
index 5304f42c8c721..f33a755327ef0 100644
--- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
+++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_common.h
@@ -227,7 +227,7 @@ struct s5p_mfc_variant {
 	unsigned int port_num;
 	u32 version_bit;
 	struct s5p_mfc_buf_size *buf_size;
-	char	*fw_name[MFC_FW_MAX_VERSIONS];
+	const char	*fw_name[MFC_FW_MAX_VERSIONS];
 	const char	*clk_names[MFC_MAX_CLOCKS];
 	int		num_clocks;
 	bool		use_clock_gating;
-- 
2.51.0


