Return-Path: <stable+bounces-200256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0039CAABAE
	for <lists+stable@lfdr.de>; Sat, 06 Dec 2025 18:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE7E930125CF
	for <lists+stable@lfdr.de>; Sat,  6 Dec 2025 17:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B32BF013;
	Sat,  6 Dec 2025 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb/kOMn1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB2292B54
	for <stable@vger.kernel.org>; Sat,  6 Dec 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765043918; cv=none; b=pAZg05MSEnnDYuFmOyJShwEYooYy6aOSHoUBfZMpfVPMcHKEXbBGRVD+Qvx4rKuUr+L/KoESaqxNh5PwnobDrY+4pXRejPH62IRte/yY4pzoVeIluSb7AEIpROzRb3Nt5yGQrkIZxPHnsfu+vGf5RLdkmD9GDUiN6gcT+bHIIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765043918; c=relaxed/simple;
	bh=oTH1lLnt4ePEcC+na2p8OocmrnPuPlc+msmUsBywGM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i1SUQoTup8AFo4vaNcJnk5PsSAz8yLVf9RYDx6tC45va5P/a5NTkm+H6eZdwVnpdCV/Gcn6XEnJobUIN+LppoIRtNvqeLr/SlDN04EkWq68SUiw6yBy9gNBCwmPHLvxackON9xOdnwyliLYahOib0SM1MXEK1F5gl4IR85KJ5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb/kOMn1; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c750b10e14so1445885a34.2
        for <stable@vger.kernel.org>; Sat, 06 Dec 2025 09:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765043913; x=1765648713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndXm3Qn/OsGO81rziqfjrS+2oqoVZi3ZmGOqkEVkigA=;
        b=Mb/kOMn1Skfu2d8M3SaojMO/PHLQGjsH3xCaxP4/mEwNMnQixR5AG2DD5jg5qfdazI
         tRr+bunZhuS+zl44sX9GFbGJRstENyz1KDlcAv3/TtN1uYpIfqWKMuO9NLSPP6rIdLBQ
         qBIPl7xPh2K8T0aV6Zm8YhRSZ8hpFBrjxS4UjRNyE11qNLGUQEg8cdyWE07+DsqzP1kt
         n00I20/MzhPBYYY1FANaKYYcfpwWUF1DXdHhV3MB0NVwHJgLfOroqa7sYn1It8B3w4VR
         QIDVdzWu0EMvgMfrUV3Y1fyOh4HwRyF7xitL0u8YHdrWRpwmxdki4R8RJUnL1ZRem36g
         jzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765043913; x=1765648713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndXm3Qn/OsGO81rziqfjrS+2oqoVZi3ZmGOqkEVkigA=;
        b=KwRORqtfvQbfaIqzaicLYUYJEPR5f3LpF5OkkXvPZTEOIpYy4b51ub9m26YnvuAAwt
         YZd7aWy/pQKGLlZOURBVaabyWbNzPXhwbSeVBAtr0kBPr3VBhe+QY4FZV8IpNI2if2GL
         pca5p6/mRHFMXr2VSBC4RCMirgjdqsAnkTays4qbguH/0xM4/fKRAVXlJDPA7U5P8YFU
         glF0wMRVz2ax2/K0r1TTawlZFitocNqQIb+grDIsdWHEfpR4GId7xrn2gEQh9/rVX2F9
         1Q08jsM3PTQn0rYJFCb3zrd0x1FDy1lXP5waUz5tbnfM+WHPwBf27xt9MZOunSxAKIJz
         z0Ag==
X-Forwarded-Encrypted: i=1; AJvYcCV/v8EnlALfHFI/ddL52tLCa+ktocOueizLX1PuIwExkk5QQGGCeqU5XnkKDTyZUtgWEw6wZQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnq4oPCQh+U/iof/7XsXdNStZR2zOj990lR/jMlw817WEe269F
	i4VxA3oCJaWnyVtZ1xf/yeKrrV0HKSDg72TdD9SoCsjPB/Nsca2ZxT5+
X-Gm-Gg: ASbGncuJ1EFIkRK8vmybDe2c3M7DOgZtpJF8DI43xL538H4KUhrrB+GccVC29dfPMX3
	nZ0t5DcrOp7NWaZmsmoOkd8mkCws3Yf1ofg8Rmx6XQAqEuXMfQLRekL2SSREJ3VcXB2Z9VxEsbh
	1CFFkf3ksRzWiKu2TUyIzrWW6zkVP9/p69UaHyyVgq+YU6rWrRuStVl66iH/igGnwV4g5kobA8U
	CWpqoMXYYf7uDcgUOJTDDMRmE2dC4xvhAXhAXEBeQXu5jCPkKfLS9GN8q3VH2mHU5B/u1kpa1QK
	U+p/I96aRS0p94hxgEywja6C6553+dB7kVepbjcrTQIuHfy7k1Ous7vElefDr3D16FnyRc5S6vJ
	PsqvQ7z7J93swhduDUaBC5W87Q4Qi7GZLz+LlxsD2lEPQV73fz7g/FAkAFq8YU+G5yprxmPyG73
	gg/OYTNvvVKNWyuYKfKdIOuN0USh1CaujAawSgLXMTtAOK2NMSZV6xBfT6mmbJCS1ehskIDT0Op
	4EwOepk2kAN/8CK5sbmzdX6vdJxpQmnkXvbwNM=
X-Google-Smtp-Source: AGHT+IFIWED3uQzX/seC5IXNBJh7DeKjOKVTT2ma7XA8fASm3D5ShSB8BPB71NDBWxDFvLk9L8iynQ==
X-Received: by 2002:a05:6830:442b:b0:7c7:6bb4:1197 with SMTP id 46e09a7af769-7c9708124b4mr1575504a34.24.1765043912850;
        Sat, 06 Dec 2025 09:58:32 -0800 (PST)
Received: from nukework.lan (c-98-57-15-22.hsd1.tx.comcast.net. [98.57.15.22])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c95acadb16sm6372782a34.21.2025.12.06.09.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 09:58:32 -0800 (PST)
From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
To: jjohnson@kernel.org,
	ath11k@lists.infradead.org,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	stable@vger.kernel.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: [PATCH] wifi: ath11k: fix qmi memory allocation logic for CALDB region
Date: Sat,  6 Dec 2025 11:58:29 -0600
Message-ID: <20251206175829.2573256-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory region assignment in ath11k_qmi_assign_target_mem_chunk()
assumes that:
  1. firmware will make a HOST_DDR_REGION_TYPE request, and
  2. this request is processed before CALDB_MEM_REGION_TYPE

In this case CALDB_MEM_REGION_TYPE, can safely be assigned immediately
after the host region.

However, if the HOST_DDR_REGION_TYPE request is not made, or the
reserved-memory node is not present, then res.start and res.end are 0,
and host_ddr_sz remains uninitialized. The physical address should
fall back to ATH11K_QMI_CALDB_ADDRESS. That doesn't happen:

resource_size(&res) returns 1 for an empty resource, and thus the if
clause never takes the fallback path. ab->qmi.target_mem[idx].paddr
is assigned the uninitialized value of host_ddr_sz + 0 (res.start).

Use "if (res.end > res.start)" for the predicate, which correctly
falls back to ATH11K_QMI_CALDB_ADDRESS.

Fixes: 900730dc4705 ("wifi: ath: Use of_reserved_mem_region_to_resource() for "memory-region"")

Cc: stable@vger.kernel.org # v6.18
Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index aea56c38bf8f3..6cc26d1c1e2a4 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2054,7 +2054,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 				return ret;
 			}
 
-			if (res.end - res.start + 1 < ab->qmi.target_mem[i].size) {
+			if (resource_size(&res) < ab->qmi.target_mem[i].size) {
 				ath11k_dbg(ab, ATH11K_DBG_QMI,
 					   "fail to assign memory of sz\n");
 				return -EINVAL;
@@ -2086,7 +2086,7 @@ static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
 			}
 
 			if (ath11k_core_coldboot_cal_support(ab)) {
-				if (resource_size(&res)) {
+				if (res.end > res.start) {
 					ab->qmi.target_mem[idx].paddr =
 							res.start + host_ddr_sz;
 					ab->qmi.target_mem[idx].iaddr =
-- 
2.45.1


