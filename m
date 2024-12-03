Return-Path: <stable+bounces-96751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9C9E2154
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A57016A2B5
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22361F76BB;
	Tue,  3 Dec 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K/4jhs/R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61D1F76B6;
	Tue,  3 Dec 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733238488; cv=none; b=kJhiJoIsAiL7CADS4FSTncl4L1PoChBSUEK/BIVmol+D22iDKfik2wRHZoUqMk7aIKyWF6iiwybjoV8ZEPC3o1vCWrnOEyvISdziL7KaO5jCud4+FSq/wVTY2xoJ2ps5dyj5mswZiedd8zDXntPKZS+2vOWQYVFwAh51a7+Iqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733238488; c=relaxed/simple;
	bh=WG2Xq6pn5Ar0RD9H62OaGpEAfT2Wa1B81PVl/G2XCtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJkb4zgVXSfE37PQ8u408URJOxEKBNYKPKAANpbA1B3yy8fEMOOfaFUXNzFgMqyd1AXgD7LJgcAm7X0UTiKmjC6fQjawuhUnb1kOqsEmWvfQmFtB4NIkx4nW+zOnkNtGL14+tY4+1yxG31Sz4gbeYT57OQmCcW/JQKVsTX3+B0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K/4jhs/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24672C4CECF;
	Tue,  3 Dec 2024 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733238488;
	bh=WG2Xq6pn5Ar0RD9H62OaGpEAfT2Wa1B81PVl/G2XCtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/4jhs/RVJI+A9SFi0DWxJaFVRFw8sY6Z8QbbJcV25YZqWP3bU1COsz/KGwTrWeaa
	 CC6u7AJSOABdmbUDSzU6PWBBWH+DyA1oV+ucGfedSieS+B/w/Hle0SruOD3VsE1vEt
	 3P5iqFXoCwJgLhnfYz+RZw5Miyo4rmmRCagMPDRg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 294/817] drm/panfrost: Remove unused id_mask from struct panfrost_model
Date: Tue,  3 Dec 2024 15:37:46 +0100
Message-ID: <20241203144007.293014689@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steven Price <steven.price@arm.com>

[ Upstream commit 581d1f8248550f2b67847e6d84f29fbe3751ea0a ]

The id_mask field of struct panfrost_model has never been used.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Signed-off-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241025140008.385081-1-steven.price@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_gpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
index fd8e44992184f..b52dd510e0367 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
@@ -177,7 +177,6 @@ static void panfrost_gpu_init_quirks(struct panfrost_device *pfdev)
 struct panfrost_model {
 	const char *name;
 	u32 id;
-	u32 id_mask;
 	u64 features;
 	u64 issues;
 	struct {
-- 
2.43.0




