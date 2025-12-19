Return-Path: <stable+bounces-203123-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC59CD22EE
	for <lists+stable@lfdr.de>; Sat, 20 Dec 2025 00:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EDAB302CB85
	for <lists+stable@lfdr.de>; Fri, 19 Dec 2025 23:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17CC21CC44;
	Fri, 19 Dec 2025 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTimUv/g"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134851E230E
	for <stable@vger.kernel.org>; Fri, 19 Dec 2025 23:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766186954; cv=none; b=olutUX2A2tfSyyJpkVsEDatRtB0kmeE0FwOu5OZMlLmiPdPJ2wt9V+4zJgcRdMbIhT2r8mHl3VF6kzER10FOlRPSZd/c291oBmCiLrpwXx6eVval1Z3R21mywEzD6elcMTmElLafjZcfgh1earrNJerfKgW3ThjxQF/m+IbUgXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766186954; c=relaxed/simple;
	bh=adFXeQNI4vqiMPvngz8td20WYTVAoPMdUUs9n4pXOpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JLQdoxUsSlLYxLXye4r9q1/0cJjLu3d7agQ8sMz/hfl8EhR4m8Ul+URu0NUjl6h0WALaO607Dxe2tzji1rW/Gk8/a6qPo7fzD3aQ7lV+Nk7bh7U5905IyFPEzhRrI9Mcec8UFo/NTuOFbsD+p+1GW/gSYHY8KO/fZJclNKC8iDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTimUv/g; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0fe77d141so24506555ad.1
        for <stable@vger.kernel.org>; Fri, 19 Dec 2025 15:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766186952; x=1766791752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ErjFuEJhPVnB4S+GRnbOY1fFSnoTGmemqnk+wlSyH5w=;
        b=kTimUv/gQ2tHQECxE8ZyaasVUYss1vEXec11ZHABfFafGpgllD0Aqt99JA7JkhG7nz
         Vac0y4vmfkyj4NKdYYNGOOFskN1Z3dGx5LLMqKd2LGsKBiIDR7o3ojvE+syYpzxzU1Qd
         hIjgBQ3WKB0g6XhOSiNGuN+2m/EfEDGAFaNpyYf+jqOiSCJPGputrzXhqrx05ZhkAP+U
         JEbpeVhfPiZizYdqS3UnbnjgxmIBObR/fq+E/10J/AAp5jf3xJTLNQixcPaZP6xIlNSc
         S6OXvInWDcCXTRlcrOCY8ezs765S6j1NVO4gevBRczb13DARXcUK5o/8tkBph98LOB26
         /yAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766186952; x=1766791752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErjFuEJhPVnB4S+GRnbOY1fFSnoTGmemqnk+wlSyH5w=;
        b=PivqTx7cXL5oqIrfU0CdCoI/KpYzQ+X79sWX3VEOB0LGsuj8OmiLDrEvgFiWalhiuU
         BSJLcO+8MVnjC+GorRUMzJocSY0IODe3p8ansAwML7IhsdhBHKgyCKNj2kdxOkfWemIC
         STJlKHwKkPbJe9dRhPf97U4lx/Kf0HNObhWC37iD9APlK42z76t7g7VqS4STGQ8+694o
         wl9chZtP29kI2SXOlWSJqERQS0zowYMNtkIgOdH43u/piLS4e7mOGXwVF3wS1fruo8Z/
         VREl2WFdPT4YNtZ0rgAaTNz2mNhOywakM5TEmeda+pmmmEDDcpHG/Ucwa36P7cdegnBO
         jyjw==
X-Forwarded-Encrypted: i=1; AJvYcCWnm2KECXkxpC7AhOvyvykpQBEjnyCxNkr5y+JyhXza+BNeaWZ1uV4MF66hPwCEo+Ss65udso4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0VgDf1Dk3KYYI1oICbPs07PskvfF/PaAZyklmFktXh0l1jDZ
	9zSG3NkXC5rOQBWZfSznQ1Zk/JNsEIlQ/6o5EYTd6SNgP4pE6Wvb3pgo
X-Gm-Gg: AY/fxX4ugsmxiQLP2iT6rHV7PPtcKtby7SHBw0jH2PpcMMq5fmWiu8UTmQfs4fiayw1
	V557KiNcfnDLIP3UCfXe8Q3bDWio2AOknN1KTqyZISOwHVBlnYrumOquXxtysq8z6miC1s4Nf3E
	rCV33JjR2A9WaR+ondmvuNq8Yf0V/0ZdhRCzCJLwEXNghb6ii+VG2nBdLVoPna9LpNy2d19qraq
	RqEyL9Mmc9G4mCwY9Q4MSmnukUFBih6qmKtqcBhAgb6DZFuTeR5ygWLVmkLAOQwhZjt0+hmKwcW
	GFv+bG1n19BjGW69SzUauLfp5boz97m088D3TkIEHWsvFlfnUCJ7aMK45Nm8Qj4NFKMAwKSIw1o
	gURuzKSmnTwffZpG2EePljrqOpXA8n0Ig/yOfIhstNGthjkEz7srhB6tEXyGcLhttD2NvW3zjDi
	g2+N98F5vXSODRgoioHDg6BUNoPfi6fENuI51kvDAQQVs44KI=
X-Google-Smtp-Source: AGHT+IFBamXzou/oh7mGxZfRc6PCq8nbVOl9oxyNqBD1zmlXSfuI/gIlWD5JXgOfYVY0WlEzZGORsw==
X-Received: by 2002:a05:7022:1a81:b0:11b:9386:a3cc with SMTP id a92af1059eb24-12172310afemr4232239c88.45.1766186952099;
        Fri, 19 Dec 2025 15:29:12 -0800 (PST)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05fe99410sm11055685eec.2.2025.12.19.15.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 15:29:11 -0800 (PST)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: will@kernel.org,
	robin.murphy@arm.com,
	joro@8bytes.org,
	robin.clark@oss.qualcomm.com
Cc: linux-arm-kernel@lists.infradead.org,
	kch@nvidia.com,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iommu/io-pgtable-arm: fix size_t signedness bug in unmap path
Date: Fri, 19 Dec 2025 15:28:58 -0800
Message-Id: <20251219232858.51902-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__arm_lpae_unmap() returns size_t but was returning -ENOENT (negative
error code) when encountering an unmapped PTE. Since size_t is unsigned,
-ENOENT (typically -2) becomes a huge positive value (0xFFFFFFFFFFFFFFFE
on 64-bit systems).

This corrupted value propagates through the call chain:
  __arm_lpae_unmap() returns -ENOENT as size_t
  -> arm_lpae_unmap_pages() returns it
  -> __iommu_unmap() adds it to iova address
  -> iommu_pgsize() triggers BUG_ON due to corrupted iova

This can cause IOVA address overflow in __iommu_unmap() loop and
trigger BUG_ON in iommu_pgsize() from invalid address alignment.

Fix by returning 0 instead of -ENOENT. The WARN_ON already signals
the error condition, and returning 0 (meaning "nothing unmapped")
is the correct semantic for size_t return type. This matches the
behavior of other io-pgtable implementations (io-pgtable-arm-v7s,
io-pgtable-dart) which return 0 on error conditions.

Fixes: 3318f7b5cefb ("iommu/io-pgtable-arm: Add quirk to quiet WARN_ON()")
Cc: stable@vger.kernel.org
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 drivers/iommu/io-pgtable-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e6626004b323..05d63fe92e43 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -637,7 +637,7 @@ static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
 	pte = READ_ONCE(*ptep);
 	if (!pte) {
 		WARN_ON(!(data->iop.cfg.quirks & IO_PGTABLE_QUIRK_NO_WARN));
-		return -ENOENT;
+		return 0;
 	}
 
 	/* If the size matches this level, we're in the right place */
-- 
2.40.0


