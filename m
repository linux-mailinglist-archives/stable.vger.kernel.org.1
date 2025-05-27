Return-Path: <stable+bounces-147493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D0AC57E5
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74B7B16F078
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E7027F16D;
	Tue, 27 May 2025 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nMKek73K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2827CB35;
	Tue, 27 May 2025 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367508; cv=none; b=IKQqDKONCDRHr3oa/cYmE/k610A01XoaJcKVobkiFNWvWSkz59LVJAybyJD0OcLPNZNwV57lBUpDzYgfiFhmaUpbL0KFi9iC47RByO6N5yCWZ2i2duAUU2DHeno+SQE9XkVNg06scUhJGw+msCot9NIFV6KxR054iIL+L6W1I2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367508; c=relaxed/simple;
	bh=JTb5xKkpE0IiOhJ1revtWnWrZIJ2wAExzT01UJN6ajo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xrqm4/+7NV2qW3IWiUrCPH92MHUsKrMQcJufqJdb8QHhuMOk4PPF36L7GXXvkJJwrkIVOpYU7xw3I4IWe4jAXJkvOMRHn74XgZz7cF9Jktt8VBO6/t/JJsX2qj9UaseLdFsyZkr5xsrh5QfX3ctWzFVpCICG4tDcYoGcbQ+DEEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nMKek73K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D93C4CEE9;
	Tue, 27 May 2025 17:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367507;
	bh=JTb5xKkpE0IiOhJ1revtWnWrZIJ2wAExzT01UJN6ajo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nMKek73KErvcq1ducr8gTQEGIEZS1R9+EjyYV9FUqQwiWBWtVUoNJQKxpHWxxyIDx
	 mXM9WV9BnuHKVfi+thDQya07VKyT2x1flY39ZQjQcI8QPxMkPtUdn2PYx2XjN+ZMMF
	 dnz30UXJzkNm9OqbmOkz1tCHYYJTbiAOzu7nYF2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lijo Lazar <lijo.lazar@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 409/783] drm/amd/pm: Fetch current power limit from PMFW
Date: Tue, 27 May 2025 18:23:26 +0200
Message-ID: <20250527162529.756776750@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit b2a9e562dfa156bd53e62ce571f3f8f65d243f14 ]

On SMU v13.0.12, always query the firmware to get the current power
limit as it could be updated through other means also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index ed9dac00ebfb1..f3f5b7dd15ccc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2802,6 +2802,7 @@ int smu_get_power_limit(void *handle,
 			switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
 			case IP_VERSION(13, 0, 2):
 			case IP_VERSION(13, 0, 6):
+			case IP_VERSION(13, 0, 12):
 			case IP_VERSION(13, 0, 14):
 			case IP_VERSION(11, 0, 7):
 			case IP_VERSION(11, 0, 11):
-- 
2.39.5




