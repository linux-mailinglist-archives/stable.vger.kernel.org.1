Return-Path: <stable+bounces-140604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09440AAA9F8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655FD163AAA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF337B32C;
	Mon,  5 May 2025 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMbHx3Bf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF922C0306;
	Mon,  5 May 2025 22:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485339; cv=none; b=b/kY67OGTyhG5zMOPtldvTMJGNT3CDcYyMSOJZXWgWZmKBj8TdzDYZzr+cwE2jbIN9f9zjdO2RXTlVMZ1VDfJ+x05Z9PiSZgX6EsO5Vk5zsRgQYAdI2mT4I2kNfSRUcAIps2WMPoB7Rs8dUIkWWTC7UFBKXSX7lp9lYgwzbVPN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485339; c=relaxed/simple;
	bh=481MeWMj+cVJvQa2lmFDWC+y3q6Ng+pvrM0i1634QHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G8PNBA3rkTJDz2sV4azRAqvnGLx1W5Da683RXdi5TPJgCMcmS9io2uiUb7k5ja6rO0GvN7L+BAUXm0k0csGd9qxL1NqPXbOCElfUkkunwlnGrBqghJND1o/tSmGtZnAh8PxCCVOEiYOoBQIe4nu5dUE8hnlvbyYs5g4rtGy7wfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMbHx3Bf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EBDC4CEF1;
	Mon,  5 May 2025 22:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485338;
	bh=481MeWMj+cVJvQa2lmFDWC+y3q6Ng+pvrM0i1634QHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMbHx3BfoXcqdmk6hmfbud33gFVjGjKYz2A6pMDiH5Eb2vkFgBfUNJgNYIoM2xIfj
	 qAPY1caxYro9dTzypd1zsQqgaPPKB8mrTKizfuMxtGZbQZdtwUKcFiaK6kxu3OLxBy
	 DVkPWF2XXmHzXQwovXRLCjj/e0TpH5DxFnkSTKc+qc2w2Zz535yYBngYlqveRSR8UW
	 O9Mb4bnkCTYjRB+OdcvUOIN18k/lxG1unrVk+B1vIGZbm5eZdbVvE/nDAMgAbGtx5D
	 RnA7N84MlQGAcBMcXhjEC15z7gKaZ3BCVb76izoZ/TjqktqOwk4eHuj4hLbZ8TLEQv
	 KPhCY+eKsLaww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	lucas.demarchi@intel.com,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 275/486] drm/xe/oa: Ensure that polled read returns latest data
Date: Mon,  5 May 2025 18:35:51 -0400
Message-Id: <20250505223922.2682012-275-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>

[ Upstream commit 98c9d27ab30aa9c6451d3a34e6e297171f273e51 ]

In polled mode, user calls poll() for read data to be available before
performing a read(). In the duration between these 2 calls, there may be
new data available in the OA buffer. To ensure user reads all available
data, check for latest data in the OA buffer in polled read.

Signed-off-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250212010255.1423343-1-umesh.nerlige.ramappa@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_oa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 448766033690c..d306ed0a04434 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -535,6 +535,7 @@ static ssize_t xe_oa_read(struct file *file, char __user *buf,
 			mutex_unlock(&stream->stream_lock);
 		} while (!offset && !ret);
 	} else {
+		xe_oa_buffer_check_unlocked(stream);
 		mutex_lock(&stream->stream_lock);
 		ret = __xe_oa_read(stream, buf, count, &offset);
 		mutex_unlock(&stream->stream_lock);
-- 
2.39.5


