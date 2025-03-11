Return-Path: <stable+bounces-123182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4349A5BD38
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F03A7CBA
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 10:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8038F22B8BC;
	Tue, 11 Mar 2025 10:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="kQFDom5J"
X-Original-To: stable@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8A442065
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687624; cv=none; b=PyCj2yRDEqD7Y6vL9hccWKcu9N3cA/Fe/wgRZU/ULKBo76VFy6W7OH1iBUPoJFS5IZt4Upq6FJWrgKZRlX7PtddspUeakBdRwRMmS6XgRFDErtiTC0aI0A4073rER4GgYRvJ7JPfII5BDWdfetVe1daUkQzc6RCtiArsSMWgqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687624; c=relaxed/simple;
	bh=/YEgTke/EWVA4zV2VvPzaZU3/mXdRxciFkmCnDilfvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a2gqpn2jfUjNchxwLC2MrCYQIvkj2s9Uy5JLAHpJeQDsRkq7kxzLHZStaesLUMiMw7oOSvYZDpnz2GxgLWpryWCBvNbCKnzWPAOcnVI2dhlEn1T1TN0dflEZiagEcyDVP4vTRag2X61JFE9cO+q/mnpq/AhKr9dFq5A5qn4Qk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=kQFDom5J; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741687596;
	bh=zMkGsEOhRrQJoE7b/qjicmm9MOJ2PvmNyE4ve+8Rljo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kQFDom5JpT7+YbXmmzLuHQSdxmLxv9wAo2O3mcp9BVcwhINoN5X396N4IQykO/XCa
	 ZpAgND8wo49gSQECYM2ZmJaD4fYUtRJmSrfuy58xiWEuLg5hZVui7H4NbcP4tZSABz
	 YIPU29CnNg8+uNLjI4J9jo6w/u/Y34rpa2rrLvlY=
X-QQ-mid: bizesmtpsz9t1741687593tbq18dz
X-QQ-Originating-IP: kX9y4Fcsu0iy1+sU5FRsf9m+pbG5rAfE84obBpFpOyY=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 18:06:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1712328354969147816
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Sasha Levin <sashal@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.1] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Tue, 11 Mar 2025 18:06:23 +0800
Message-ID: <98CE17BE6E190CAE+20250311100624.310951-1-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: Mw3/skGyA4U5zB2g2Spi+AJR89lOeUVzXEDFctvbIFmLwyTW0PJjfIov
	2fE4hKsLnaEbG/lNAHCP97l5DXvVNt6ezQIglR+ZL48L/i6THjJdxh+SdQyaixsRpZa7/61
	4Wmg1IjKo5SukgDO/Ee/72P8QUjYYBww1NYjF2XZVXLAKKDazto+GA3qkPNVz2s5uqi0wGG
	09+khttdIYj4TQuyHIHrOJkuzY2KLrp/xL/YnFIYYenffGD06Mo/mEFiAhVasmGiRshVgOI
	qEv60D8pMglK60Pc8cVlK54nZr+FHE0BzfoOPlUYqplA6HmOr2LWRWqsf4456mPIVxTABwQ
	+jg2n7zCPXZFz87KeMw2RRLW76/zW44uBcJXmSLTyF5s4X3bTaKc/Lq/O5y8dGLivhNDgc7
	+fIL8CToJ7eBe1Z9oXM/eq9aNSDivQ2ND5vjQFymcxxCOmb69/UOe25yuj63FZhBA01d9p8
	XcpHE8fGhLrZx/NZBAv1/FntMviQRkE/MKDPsotwQ0Y/Tdnjh3wlawy0dUl+mfdM1vTqRzW
	4uPvANtoAtOqZ6JOtYb0wobuGhIxkaJ+Vd3JPwDrRq2M4V1qK3pXfI4jQG47CvZ2Rl/s0dA
	dSXUUHCx87tzZRqs9ECqW9jmDIY2ClzLnFT6cdnEc88fZXzzDoEM2AR2gcruGyvTop+4IQm
	I7aMsyWOcFJBptBq4p1NfES7RFMTzMRdG5KW7/3JCyFNDNYaxc3rAtmnaiNnWnnEtFd/iXP
	N4OQ8zfIVGBZusWIuQ4szm1Svy1ByAAiLkktKXkmQvrqML1OfE9rGW7YxHIWvlFsqjfGluO
	jyb0UrjecO4Z31qdwdzV84/2iCcyjC+fVzQZsACC/b/rLWFUjKcfMt8QC3NgrE0Pj0mkcQt
	C+3TjuovVINv8NrtN0n8EaK/kvsJgMrhrYBl0f0GUX5EZMkgyiz0cOmu7H5VpIfpiVpjIuZ
	YwLIL2NIDTla9l/gpdMT9WYjSmOEeqxMvxKkHRaWd9luMzYQoc2JmTYPLC5VotwEFlyYsow
	0zJsymgUoNGt9q6vj4DYgGBE/w/qcY6Tq/fG3snCZqr2Pe8zp2
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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


