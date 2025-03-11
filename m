Return-Path: <stable+bounces-123181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C760A5BD37
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B641B166D07
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 10:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1B31EDA3B;
	Tue, 11 Mar 2025 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="mJHetd+m"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8056F9CB
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687623; cv=none; b=haz3s2cxUacpi/xUiWrdBBCoYzjrJDjW+xAjAuMXMFRPVR3EkMxOVCvFncieaYzOZzw0Kw3yscqNGsy8cNU72ke669OgtzrqzttAf46kjRM71ld6fmsazggZWaomccEns+9nwnU52EBj3I6C9qo347vn+gZ1oLb/3PizISgbqjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687623; c=relaxed/simple;
	bh=/YEgTke/EWVA4zV2VvPzaZU3/mXdRxciFkmCnDilfvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDj+sfU165xyhSh88dd8jGyoA7fKJ7lIJNXIy7WVdhIK7ydrPlNMy8bvjrveinBfnbP1oNG2LYpadeUfjNoXCN71mytrrhbWAV+93ZOVYlU5SCxa2m+zFaxz5h3YXiZmPt7w+uq6R0z4oc3jfFxLMUMF9Id1EPoVW2wrB8/ChW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=mJHetd+m; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741687614;
	bh=zMkGsEOhRrQJoE7b/qjicmm9MOJ2PvmNyE4ve+8Rljo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mJHetd+mBxcrxJ06LouSb2ESRZy/9rSSN1e9kfuNZJZLxXrsFH0CtqxqtZjj4E9/E
	 ywy2oHlLBs8VIP0O6vE/sUy9nerfD8zZEjJcLdpwumqOyB1qZx/CJnrgVNTj4QLYg9
	 cu5Qc3m0MqOpJw+ds2pOofRd3D83inDH3/tzVKCA=
X-QQ-mid: bizesmtpsz6t1741687609t6fhxcq
X-QQ-Originating-IP: gZ5N7ZadqohAjtcrwNj1tBMumWLqxssqEM+Ec67h4RI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 18:06:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6920947092459425178
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: stable@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 5.15] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Tue, 11 Mar 2025 18:06:38 +0800
Message-ID: <31488F4A9095C9D0+20250311100639.311087-1-chenlinxuan@deepin.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: ONMinSPvVgZRrPSbJ1iO8X4TMH2mRtT9kDA2pJ9xTpwFnC4I/nX9sCrW
	HwTMBiYLwfshjukF67FaJpRV5rw95Li3nHBya6rRTme1wi+RluQZLpq/pZNuU+MpRd/EhCv
	QWn0aj9gFSPRevKoujQ2ySWStzgsfEBSEsTjME51uB70hRCk8Akc/Dprh52WCjRfMbAetFb
	NNQGbCAF5ixlF06CjJSQ649ozCvmoS5/APrMrF1SCLzNliNX7POGmWqIJuGnKufm1wP+14d
	0BM6mlqpTfmr6tQaZxnb86CN3AkGYXd4b5xHedJQyuqOQvn9gyF4rMFN1K7hGFqa9jBFBdo
	Sb+V/JyXgnhc+bTaHda3FLNC2/G3YVdjTqwjEjCrN3AjLM7RHGePW05c0k4yK5yq6T6PXxf
	E9bHr2j/hx4fO2rtCYjiO5P/vAqgY+Gt+T1aQSkLTKC0U3tI1G6oemKUp/JhNcjUZmgU0/B
	5DVNnUxV18jmBSUnLUzrGWC9esvsphPtqTybcJjtdImlHwzr8q9FIgAMWdDwoZuqMIT+cRV
	22hP/GgMekOvrx2W6pEQx/4T/SgugTT4aF3pZJ/aEmAB6M3uFre1+yg7VtJNbRVomAg3Zpy
	0fiBHCAktgQfpM3KKfMXvVB7GJD/C5xNPIX45G93Sark6L1NjNXRDCgcdUCfDYk94ltzZKF
	5h0l+M2iApaXSfduZ+nUdFeBHJSZ0d7aPpVxzqup35yxzFZr1zl7YzaXLLIaGMnt1oupQvZ
	TC0CEG3kgZbN6QspcgXASehXfVIBkgMIrgRHvZjU5a2/3x706TL1ZYHjeKCVkpjAxXpOJrS
	fG5pWH8tr+kKhjAfcqVQVh0DEl73EDcApcX7lO3hOvnlXXBVoXq6H+DP8BZe0e33lynW98D
	vbjp/HabHpXy1ABuGhQStQiCYEyDL98TcpGfzxxI0W6B9rdzd7oIpzfAhKsu4IVxv1NaMGG
	n6qTy9Bhc2LnvBpSb2+0I12GtiNKTYjdr/aOhGEduQq9IL4XGkJOm10w/f1/nZfBS5qQX+P
	QaFxCyTzL2F7VjkkJtLzSPceShlS4=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Backport of a similar change from commit 5ac9b4e935df ("lib/buildid:
Handle memfd_secret() files in build_id_parse()") to address an issue
where accessing secret memfd contents through build_id_parse() would
trigger faults.

Original report and repro can be found in [0].

  [0] https://lore.kernel.org/bpf/ZwyG8Uro%2FSyTXAni@ly-workstation/

This repro will cause BUG: unable to handle kernel paging request in
build_id_parse in 5.15/6.1/6.6.

Some other discussions can be found in [1].

  [1] https://lore.kernel.org/bpf/20241104175256.2327164-1-jolsa@kernel.org/T/#u

Cc: stable@vger.kernel.org
Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
Signed-off-by: Chen Linxuan <chenlinxuan@deepin.org>
---
 lib/buildid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 9fc46366597e..9db35305f257 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -5,6 +5,7 @@
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/pagemap.h>
+#include <linux/secretmem.h>
 
 #define BUILD_ID 3
 
@@ -157,6 +158,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	if (!vma->vm_file)
 		return -EINVAL;
 
+#ifdef CONFIG_SECRETMEM
+	/* reject secretmem folios created with memfd_secret() */
+	if (vma->vm_file->f_mapping->a_ops == &secretmem_aops)
+		return -EFAULT;
+#endif
+
 	page = find_get_page(vma->vm_file->f_mapping, 0);
 	if (!page)
 		return -EFAULT;	/* page not mapped */
-- 
2.48.1


