Return-Path: <stable+bounces-140100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ACCAAA4F6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501E97A1C40
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E673098D5;
	Mon,  5 May 2025 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdRGGGmf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71543098CE;
	Mon,  5 May 2025 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484105; cv=none; b=ifiLFBX3+CT6RRbHqCpfbBcNXTYcOo04Mf1E2h5/Zk1kDQa21vEElZsAiHJ9OjFSJhlQ6gJ+hGkvE7whZQGXSdSPI39SeqxiQXpJ0XkHkGfHt7xbBvxRRzqxPTWY6pdwuRqahaIq0mgBmDwpdKGSR1oGo2DZKgPAkcHyvB3lnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484105; c=relaxed/simple;
	bh=Ll43ZrLxMWFfQomfOHOy+yuEDnhCPlWPzmZhmBroXsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6Kf2Mzg1Vj1Q7/HhfAKqNRuw0AT2r80ZActgqwuCvvba9M2C2JHT7VNh4aqj7PwyycKcbsR65jNu61b3akq5ZxlMuRag2/TN0+xJ32DRkRINHvMtPwnuxMcP86Mwd1sKdYr5gD3jJP940M5GJ6PmL6RTXYFEOLcfgQVi9DeTIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdRGGGmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE67C4CEE4;
	Mon,  5 May 2025 22:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484105;
	bh=Ll43ZrLxMWFfQomfOHOy+yuEDnhCPlWPzmZhmBroXsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UdRGGGmfkwWW90/gxxcOO1LNhJNb+ieDWvxuRfsY/7MAeqKGO8t+sHYQSgHh+onBi
	 L9DjSNVg/6t3SqE2FLEJeIi87dihni+81IjOEjeNn7FrUaeCy9eEfo+Bq3HrW4Edj4
	 ob5TqYJvAxwejj4gxmMucf16cMjUEMiTjMzR6kq971V2mhMql9OVpWYQlsdma4BcQ0
	 TeRIItR9dkQTpVlY46Fgc3hDqXdyJMlPBLnI9Ruxc49UT9tsYDQkdDLk4o+EY8tivv
	 kOshOSYejiz5XXOCCpFTSgTeNyuKjiz6VOCm03wZpmUKdblGpx6c/6+djU/RDDuETM
	 0RGIUuXnAJMUg==
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
Subject: [PATCH AUTOSEL 6.14 353/642] drm/xe/oa: Ensure that polled read returns latest data
Date: Mon,  5 May 2025 18:09:29 -0400
Message-Id: <20250505221419.2672473-353-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index eb6cd91e1e226..abf37d9ab2212 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -548,6 +548,7 @@ static ssize_t xe_oa_read(struct file *file, char __user *buf,
 			mutex_unlock(&stream->stream_lock);
 		} while (!offset && !ret);
 	} else {
+		xe_oa_buffer_check_unlocked(stream);
 		mutex_lock(&stream->stream_lock);
 		ret = __xe_oa_read(stream, buf, count, &offset);
 		mutex_unlock(&stream->stream_lock);
-- 
2.39.5


