Return-Path: <stable+bounces-141527-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3DAAAB429
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 07:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 260A5172FDD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B3474742;
	Tue,  6 May 2025 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6uCztHb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D05A2EEBD0;
	Mon,  5 May 2025 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486603; cv=none; b=Ve6kscJCw9EN06Pl2UVLvkj+2FAkUT9vpu7Elol7Wu0JCC/cvuC9lOvLyLYReOkyRl3f4sPBQje9ylNwuLfPda7e36Y+MVZfQ7Hl5l1AlbWe+jAYq9rOQW/LzU4f0gwkv6i4polWPEA92SWYnfqdg3E4/RKLrSdL+jIxsModOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486603; c=relaxed/simple;
	bh=eRSeHeY46tLQcIFe1Mri11VeNHQat5CRun0NZB+R5wI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tmvULKYHn7xDLKN7pdKfRV6B5nQ5mwFXbD+YnD9wzkeUTjKjXsnxM116kFh6HLjEea0lSKEj6Y0itwSksycbx3mcQGAhN+XQZYtlzqNIPS7eZPA3KHLh4r8MazV4BaDRy8bHymNDMxvjL0r4Xp1uhsFvIxicyEgzPJoucHhBcqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6uCztHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96314C4CEF3;
	Mon,  5 May 2025 23:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486603;
	bh=eRSeHeY46tLQcIFe1Mri11VeNHQat5CRun0NZB+R5wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O6uCztHbxoT+Ca2S3iWsq3ZiowefJiPMyjLFlF0wgGpZp63q4XXQynaL2VCGgtjLq
	 PrtMAsvupNf4vBU1Ny0NHbJSqJ+TwFJQsRh3hELhtDfIS5QtT+FO9WHbirgauMB2iS
	 hX8ozZuN+aeAk6u1Dr4qj9v7Th3bQDGS8HJ1cVAHolMSbK8d7MbV8YqntUWc0Ka2N7
	 p/0NXgfzWlApAdAAzJeVb+d+TZqb/bnddzvgRfZ+LXU/fh/keWs3A0NvjInY0EQXg1
	 uolmen/cOuxPZRlvxK5gpMlyC7y7nS180tOGJvXcP9QfeEyTS2O46zU2buURzDfnEe
	 4CCEalrzL30aw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 113/212] firmware: arm_ffa: Set dma_mask for ffa devices
Date: Mon,  5 May 2025 19:04:45 -0400
Message-Id: <20250505230624.2692522-113-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit cc0aac7ca17e0ea3ca84b552fc79f3e86fd07f53 ]

Set dma_mask for FFA devices, otherwise DMA allocation using the device pointer
lead to following warning:

WARNING: CPU: 1 PID: 1 at kernel/dma/mapping.c:597 dma_alloc_attrs+0xe0/0x124

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Message-Id: <e3dd8042ac680bd74b6580c25df855d092079c18.1737107520.git.viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index 248594b59c64d..5bda5d7ade42d 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -191,6 +191,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
 	dev = &ffa_dev->dev;
 	dev->bus = &ffa_bus_type;
 	dev->release = ffa_release_device;
+	dev->dma_mask = &dev->coherent_dma_mask;
 	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
 
 	ffa_dev->id = id;
-- 
2.39.5


