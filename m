Return-Path: <stable+bounces-194880-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C7C619BA
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 18:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90E4D36258A
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 17:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1732D22D9ED;
	Sun, 16 Nov 2025 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS5K8gwm"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4452C2F2916
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 17:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763314413; cv=none; b=IWwipus8QJq1Mx78lJUlcmXSHZZ6f8yD53YCGm1h0NVF/95w5CJMZ+wt8Evkl2R4234BAH7z2hs7YW/tQoTZgYWyhNKesyt3uGtF+DKX0viZnngYD6koLmCuBxMfT6HUxPIzzIjmNq+5a8UU5rETGfi0KcWnSXY+gthFAPwbqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763314413; c=relaxed/simple;
	bh=TBTqoeDXcvJ3bbiLCSTi0XnX7ex/g3HE6/Tiz5jRE0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p87bARGi6J7ti3UphIqWmtYP5mZe7qghwz97/iQFGPvx3Nt6XgD5qryV0Qr9wt2yqdawWHFm4EqBncjw+k/yfuHRy6SyisVzwKanm0Vx2yzbZx6fFuUrDjssIgYNcGEvzYIehgMV+ftnjuQGfWs1Bfe7pAQye0iawH2Nn8Roy2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS5K8gwm; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-882475d8851so37929436d6.2
        for <stable@vger.kernel.org>; Sun, 16 Nov 2025 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763314411; x=1763919211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aTNaqpV1M9Ei1511bJGHTwkA7seKFEx3WsZoUY+KXHg=;
        b=fS5K8gwmXWrinRDl+gOMzzVTZp6ney1rRoWrm6PdcoFYbLnonvYNXiZThHXDJfVNsU
         VGx4Rt8ApprLiYG2sLCpabzlt27CZH9O+Q1uXbpdDbsRcbB6XTGYw6/pzsx7ceDAC1Xi
         5NOBgU2z1312a2k1YKXDcNURXJSb60npyw5TZh2UZNw5Wd71Ca6KPlrvgJog0gZKsIOZ
         8HGZqCs4O4KluHdISytPyOTA79OP79FtZf0LqKAdGJwzoGNBT6a9Y/swaQgc1xaG6lS0
         YWtT81ZjBHaWzx97mzL/x61ttmSomKHdrHVU1NeDOemdq4xrO63yJYuDlUvNQe5q9OAf
         yn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763314411; x=1763919211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTNaqpV1M9Ei1511bJGHTwkA7seKFEx3WsZoUY+KXHg=;
        b=B+tvKjRL+DXm961AfUhX4jPxLs0CxErxQ4zMrtevdFKla8z81lwYwJDx1VUathSLD9
         9AEEdr38PGm5RLGBu6Wj1GhUIIuDiztDc0i7gFmAvbA/D3TGj4xQgJLf/CuHsIJ8lTt/
         9PY0g6Tt5ctqEd2sCuYq5FXUaj33q/jl6RBq38QsXAtPDePOvPtak/D+B+tj5Y5IQS4m
         2LCkEU+1hZ62E8hVp9NckhrmxFIbKmy9BlRIj2f5TjeEpcoQhbV8Di9AStHVIE9BYliC
         zDt3KCq35PEEbGQZv9pn1GLyAwb45xt7DU9f2iq8F4uLwoHNWv1IBYjlwNCJggaPXvsJ
         lj6A==
X-Forwarded-Encrypted: i=1; AJvYcCUMcbM8mb2wTeNzP+AY886R5EEBtiWcwPljPMsUbR7EBIC0Tthy1THvPUIWd5gfJ0/eUelu5qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3mhe1tT8yN+YxSHRuAlzvA21S5WfgirifSmz7uZyurqMoSJvr
	MVw03y1oZcSgue4l65nSiDc7GG7hr3WpzZCUlF8zT/+lMBWoLBHfrS5kH26oay2jo8Q=
X-Gm-Gg: ASbGncv8ohUgcRqG15ZgsPl09T02TLpGA3JFMB3AHdvgmERQjP7O6HyUF+wDPEmwJj1
	j4c/uIUiP5HwKnHriNlZhnZIMBQeZnagVLfyhzcAfmrJ7L8g4ypKsqTB1YtVUXsPPFH63RutoS2
	M8lBSLcZAmvjhW8bfgvvn61kxwwYFfZpt7PsRqdaMuqs6meKu6UFLevz1lyXJ3wSu84g21b3MPb
	0qsOVg/CKVShpig2oMuPgFlDN1E/Gny8a1hqD52yVmOTkt1DyOWUnDoUvbc3gXA3RoEUkvbCpYd
	SGpcY7nUByD2n0jRIacEk3rcCzX02HkqfpRnllQgklEHgTsF/eEu8bsIL5vfPswR54R7BHnqjJN
	rq2RGElp4U6bdGd7pJFe3gV+6DDc+0emZDxGKvJEj8iq5phGNeA5Gnama3TVM+vfRjfRGnJcZKf
	h4dhC0ud7kKO3BCBXKehJ4LtjnnZ321ZoXJ+YUtP26bCRMYQVoxZ5TXy9SWVVcHRJ82QNArNWtj
	2WzV+mUgIwOpA==
X-Google-Smtp-Source: AGHT+IHSnTQS24UuUH9rl7UnvsBNdDPlTMJarcl0yOTKBLb5q+jffZsOwrLpkrusLbtn4nUdL1luew==
X-Received: by 2002:a05:6214:1d2d:b0:882:7571:c012 with SMTP id 6a1803df08f44-8829273c0c8mr143960626d6.55.1763314410878;
        Sun, 16 Nov 2025 09:33:30 -0800 (PST)
Received: from namdlewifi.mynetworksettings.com (pool-108-18-100-114.washdc.fios.verizon.net. [108.18.100.114])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286313d85sm73664596d6.23.2025.11.16.09.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:33:30 -0800 (PST)
From: Robert McClinton <rbmccav@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Robert McClinton <rbmccav@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/radeon: delete radeon_fence_process in is_signaled, no deadlock
Date: Sun, 16 Nov 2025 12:33:21 -0500
Message-ID: <20251116173321.4831-1-rbmccav@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delete the attempt to progress the queue when checking if fence is
signaled. This avoids deadlock.

dma-fence_ops::signaled can be called with the fence lock in unknown
state. For radeon, the fence lock is also the wait queue lock. This can
cause a self deadlock when signaled() tries to make forward progress on
the wait queue. But advancing the queue is unneeded because incorrectly
returning false from signaled() is perfectly acceptable.

Link: https://github.com/brave/brave-browser/issues/49182

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4641

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Robert McClinton <rbmccav@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_fence.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 5b5b54e876d4..167d6f122b8e 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -360,13 +360,6 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
 	if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
 		return true;
 
-	if (down_read_trylock(&rdev->exclusive_lock)) {
-		radeon_fence_process(rdev, ring);
-		up_read(&rdev->exclusive_lock);
-
-		if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
-			return true;
-	}
 	return false;
 }
 
-- 
2.51.2


