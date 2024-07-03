Return-Path: <stable+bounces-57279-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92963925BE7
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9051F22ADC
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6EC194A6F;
	Wed,  3 Jul 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zVcU3sLo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EBC174EFE;
	Wed,  3 Jul 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004401; cv=none; b=p2Nbar+uYr/Jv5Rj/YKkhg5jyLCdcTHtTzlD0ukmIF3JBErRaPDd/0kIEjUqztON5tZ6Ci7G/IA1Quz6gx7X/y6JSNb5xjkGxqJG/JCnc5/Jxw7+keWCZdOTtzOJSTm7vwVkF6g0PZVnBZ09vzjHSiNOfk9X0cBjgpg9B5CbfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004401; c=relaxed/simple;
	bh=f1dkN0lsppzRwY3RDD7Yl7GgYwChzuPfKIZ2cVvjlWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFgRV3m7m+qUeBL+WnKo5N/CCLYXj5Z8CF25Q6h3WWL+Q0dD5GDTpKDLFbRSd9uDj3/yTrNhiohnMzVX+uFRyr43eyq4w4uAb1O9OlJ4DeSMsY5fwcQ+Hyhb7emXiBjf3q64b5PBpBgkUMoEYhIg6IujpdN6yvaEmW/ITFxe91w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zVcU3sLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F919C2BD10;
	Wed,  3 Jul 2024 11:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004400;
	bh=f1dkN0lsppzRwY3RDD7Yl7GgYwChzuPfKIZ2cVvjlWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zVcU3sLoWN3BrHNUJZ3/b5sB5qQ6VH7xV9aUpSCxllE+q4Mo9vJknbv/SfqifaeZI
	 /hthYcsZeV4uOO4Vjxbyf/jVFiBdOC1u4Pgl9jbYr0sm/XYuXymm3Ccymry61BCd35
	 m+tFUW2Vvbj3IVrI3lgwhC55cHEUMBJDfmBj5FPU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Wenjing Liu <wenjing.liu@amd.com>,
	Anson Jacob <Anson.Jacob@amd.com>,
	George Shen <george.shen@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 030/290] drm/amd/display: Handle Y carry-over in VCP X.Y calculation
Date: Wed,  3 Jul 2024 12:36:51 +0200
Message-ID: <20240703102905.334208768@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: George Shen <george.shen@amd.com>

[ Upstream commit 3626a6aebe62ce7067cdc460c0c644e9445386bb ]

[Why/How]
Theoretically rare corner case where ceil(Y) results in rounding
up to an integer. If this happens, the 1 should be carried over to
the X value.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index f70fcadf1ee55..a4a6b99bddbaf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -633,6 +633,12 @@ void enc1_stream_encoder_set_throttled_vcp_size(
 				x),
 			26));
 
+	// If y rounds up to integer, carry it over to x.
+	if (y >> 26) {
+		x += 1;
+		y = 0;
+	}
+
 	REG_SET_2(DP_MSE_RATE_CNTL, 0,
 		DP_MSE_RATE_X, x,
 		DP_MSE_RATE_Y, y);
-- 
2.43.0




