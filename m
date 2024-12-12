Return-Path: <stable+bounces-102262-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D789EF26C
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F037171660
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEE0237FFA;
	Thu, 12 Dec 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xpzSGnAF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B51237FEB;
	Thu, 12 Dec 2024 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020586; cv=none; b=gUVpBeqi9pJ5gYjOn0oBHHwwfY3+spdSa16HkJFWEsyuedFmq4wuIL6Ezb8dE1hcpsIh6mHrmQVi3rM+wRxkTyNYZk3iy4S/5lz+6463T/oMY8m2x5hct6QsVlyw4SD5cvWdi9qe6cy4LHoHw6ZndjZpGYUHvbMDsNLDnI3c7W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020586; c=relaxed/simple;
	bh=KYyFhGgciaFQF+9vTjGS3KvaMPfvwN8Sj/tiwmzggAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBjPys1N/9jY/2kHmZYShwxAfgUZ9PxLlO4BPt/aeMZ4Kl+SCJXjG7MXxJS6rkT7KLZb0WKw63m21rsuSETSeydJ8BXD60nhwaWc+1/icfml4HBnwPywPGOuEuG1aEUIpBtpxGzEWlvJT0ZDb2LcG6XSiY4hYgNUqMoFIR1dYqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xpzSGnAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FFCC4CECE;
	Thu, 12 Dec 2024 16:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020586;
	bh=KYyFhGgciaFQF+9vTjGS3KvaMPfvwN8Sj/tiwmzggAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xpzSGnAFlzZpRdD391m+L8O4QGka12GqY9LdbzrunwrLEsvpfKBtR1FYKsRo7ljN0
	 K9V4+Dmygp9eCrnCG8wFMwLc1YpTGE2++OfGfkbcEuLJULUlhJjKqXAtNhCiQOkZvH
	 dxgqdGUs//qaNZ1yzJ9rVRomUKvJ6Xzs3VEmQXzI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Umio Yasuno <coelacanth_dream@protonmail.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 506/772] drm/amd/pm: update current_socclk and current_uclk in gpu_metrics on smu v13.0.7
Date: Thu, 12 Dec 2024 15:57:31 +0100
Message-ID: <20241212144410.864626782@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Umio Yasuno <coelacanth_dream@protonmail.com>

commit 2abf2f7032df4c4e7f6cf7906da59d0e614897d6 upstream.

These were missed before.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3751
Signed-off-by: Umio Yasuno <coelacanth_dream@protonmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1314,6 +1314,8 @@ static ssize_t smu_v13_0_7_get_gpu_metri
 	gpu_metrics->average_dclk1_frequency = metrics->AverageDclk1Frequency;
 
 	gpu_metrics->current_gfxclk = metrics->CurrClock[PPCLK_GFXCLK];
+	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
 	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
 	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
 	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_1];



