Return-Path: <stable+bounces-186333-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC08BE938C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 16:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B86D94F4A28
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83B2225762;
	Fri, 17 Oct 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JB2dXUEA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F163396F2
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711531; cv=none; b=eISvaOPnsBhGsKClO6atzHtomVIMU7wsuIBjP2Oge+eWJj3G2xPp4D12vWU/NyzYjF6tFdbZfFNrT9B/k1gIri/Rm3UdDkP2KYmmtassCnhtKOdfzIMOy+XN9TSqo5V64rYZC3GwDYj36ekKju8C1Lk7JP3s16PSwCtXHF28uQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711531; c=relaxed/simple;
	bh=xNECdUme27H/FyO/lLP84doY+ketMceeue/7rtyHpl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/dl9Dj4TcImKqFbt1dT5X8qlM2uPxwgVICgbl59KOgo9tr6Ldzpdlc5uaJM3/D7VDqZvxDjWfe1yNG5cqW3vsRjhvrM1zssSYz2yK0SnTq5Oo11a7ZEmH+Jk1nrvlcETc93fL5msLv9Y1M/E6QCeRgk9w2iLguz2tThoPoRFVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JB2dXUEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402D8C4CEE7;
	Fri, 17 Oct 2025 14:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760711530;
	bh=xNECdUme27H/FyO/lLP84doY+ketMceeue/7rtyHpl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JB2dXUEAzKB2uNbPH7tN/vgwA281fXJu8cvSAlYGSYKNxqLV1ebQs22p8uQp6zPIK
	 7hDPNPsE3uJOIdiyf8Cuz6azHU5Kl+KWVuWvPJ90FbfYkHllUgT5zKrDF5wBGa6h9I
	 2CFcZ9jEGRDoexHl7UNXJTs+sLuQbxxGLyD8ny1lT/qHQtaZdXfL0+0LuD/OgmC+U8
	 fV8hVSUPVW+hm+RUtuiiXmN83kcrJc7Kz5bPJFOS8EY30wnlOFKeKtQ05S8Uw+Fn+f
	 MorpvSove0KnwAB9USAusZ2FH6QrskCdG3X0nwoX10sQZcFwC9Lk4VYNjbYsHnAXvA
	 caxrsvxfpJAOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Aakarsh Jain <aakarsh.jain@samsung.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] media: s5p-mfc: constify fw_name strings
Date: Fri, 17 Oct 2025 10:32:04 -0400
Message-ID: <20251017143208.3997488-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101646-unfunded-bootlace-0264@gregkh>
References: <2025101646-unfunded-bootlace-0264@gregkh>
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


