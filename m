Return-Path: <stable+bounces-101034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2029C9EEA37
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48FDA16AAA7
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E21215795;
	Thu, 12 Dec 2024 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w/PZI206"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5230215764;
	Thu, 12 Dec 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016027; cv=none; b=RO96KvZ3LCGdE6wAYJ0CUlkzKVGkPUXbhnSHCUvwb1gquNaiN6PeGTPhufY+tLvJFiAdRK4GwareUDUn8dTCbo0xv8YYFOPyBVpbzb8Ue58rn+qfVhccKTknQQsbTbkSxEiOvJ8icHnx6Y3gOxaPvyPqAQzT6F1jGY0tZQ/N124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016027; c=relaxed/simple;
	bh=sVQvCDNye3u6crr3EocavLBYHvi/QHvVVgkD+WACR30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MJHD7kiq8MOMyQk92w7WHiwxpBCNPTybLDfbLC3IJfkIem/kl03jMLcwS+p501b0ucn+0nD/OaXtwQ9FzsttSjaqvkBeVQnRZ4hEgj7FFOwtmK8quFsL3MvK7nCfhlzMk+nuZgkARJR8bs2+Tc2UXrCFIo0ea7mWNOFFUcclOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w/PZI206; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33573C4CECE;
	Thu, 12 Dec 2024 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734016027;
	bh=sVQvCDNye3u6crr3EocavLBYHvi/QHvVVgkD+WACR30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=w/PZI206EhUYVXAPn5eZ3JBgE10VIEXLyTkc7t0gh9wIOGCpLtW/POyAYkJCgsDEv
	 6ji7GVS4kJmY7CkAH1HMUYPl3/49adzSQTXO2PoAsSpwR8bqKMCpy4P+ctKYpZ+SbO
	 c/iSpCeQImaWY8hiAVTMgNd7yFw+8yd75eDYb9gI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 111/466] drm/v3d: Enable Performance Counters before clearing them
Date: Thu, 12 Dec 2024 15:54:40 +0100
Message-ID: <20241212144311.203032828@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144306.641051666@linuxfoundation.org>
References: <20241212144306.641051666@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit c98b10496b2f3c4f576af3482c71aadcfcbf765e ]

On the Raspberry Pi 5, performance counters are not being cleared
when `v3d_perfmon_start()` is called, even though we write to the
CLR register. As a result, their values accumulate until they
overflow.

The expected behavior is for performance counters to reset to zero
at the start of a job. When the job finishes and the perfmon is
stopped, the counters should accurately reflect the values for that
specific job.

To ensure this behavior, the performance counters are now enabled
before being cleared. This allows the CLR register to function as
intended, zeroing the counter values when the job begins.

Fixes: 26a4dc29b74a ("drm/v3d: Expose performance counters to userspace")
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241204122831.17015-1-mcanal@igalia.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_perfmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/v3d/v3d_perfmon.c b/drivers/gpu/drm/v3d/v3d_perfmon.c
index 00cd081d78732..6ee56cbd3f1bf 100644
--- a/drivers/gpu/drm/v3d/v3d_perfmon.c
+++ b/drivers/gpu/drm/v3d/v3d_perfmon.c
@@ -254,9 +254,9 @@ void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon *perfmon)
 		V3D_CORE_WRITE(0, V3D_V4_PCTR_0_SRC_X(source), channel);
 	}
 
+	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, mask);
 	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_CLR, mask);
 	V3D_CORE_WRITE(0, V3D_PCTR_0_OVERFLOW, mask);
-	V3D_CORE_WRITE(0, V3D_V4_PCTR_0_EN, mask);
 
 	v3d->active_perfmon = perfmon;
 }
-- 
2.43.0




