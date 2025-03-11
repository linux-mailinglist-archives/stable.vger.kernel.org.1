Return-Path: <stable+bounces-123180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32505A5BD35
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 11:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF48418952DD
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CAC42065;
	Tue, 11 Mar 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="iniPSoik"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6467022577E
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687595; cv=none; b=BhLA7eVkuOiqNiiAmGX2O0riM+32u8WXtlORDBnbq4Gi9RN9hRT/bQx+LsbNjfNwBnWNQtDL8Nr7X1J2/RvkLMbt0ea6lVvpYI5JzKpXAf5wtYqoPlvGbL6l5Ne8BV1MKY5zulCoWC/kTHLbAVomX/9RHYrtkq3U1fkrJawPMZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687595; c=relaxed/simple;
	bh=/YEgTke/EWVA4zV2VvPzaZU3/mXdRxciFkmCnDilfvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJP2yOamAquBXIw8YzoAeSPITi6/FsJqFrOt7xH7od5NTAf3F1AWNjkWT7kEMGuDMSi4UwbOK0rvuiPnhAlEcKvzXNxEYjD9rRhHgMPKuMomPsyf75J0Nt6Ll7F/LbT0NlkHXq2coWDP1bcQpA3doSQ1UFyqJXw5QIDUZJen6Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=pass smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=iniPSoik; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741687579;
	bh=zMkGsEOhRrQJoE7b/qjicmm9MOJ2PvmNyE4ve+8Rljo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iniPSoikJYhj4lqZklFfc1OuVuTh00x61yB3A6O9snXfcQk9ohgDU/bLKZKQcxzVR
	 bLrB+zwEx9mLTwZFUmdAcu0SWr49Ak/CRcLqvoto5ETN7yVuKZ1WMK45yA8uJl9LIi
	 xkuJ/fVf5PhqeBHAqeSRI/FOllzC3c322X6es+3A=
X-QQ-mid: bizesmtp78t1741687576tbd9r1h4
X-QQ-Originating-IP: I5QyNztvaL4Hpsa+XWzIzqTavcUHPCv5hPoG9fF/GAg=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Mar 2025 18:06:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17129962958386938985
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	Jann Horn <jannh@google.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>
Cc: stable@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH stable 6.6] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Tue, 11 Mar 2025 18:05:55 +0800
Message-ID: <05D0A9F7DE394601+20250311100555.310788-2-chenlinxuan@deepin.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:deepin.org:qybglogicsvrgz:qybglogicsvrgz7a-0
X-QQ-XMAILINFO: N90SrNLg0QeiZgB7LkchNlrlH9H8kSdobDycuX/daLfxnfPzGCii4QlV
	VDYEqbvBetZ2TZrtNoKkZKldeETorJCZ4lD/TXNn7lXmikgjn9PHbVonnytO9t7PRCylYon
	xwWcOKoKD0Airhb+xiAokSqvHqijIm++0Ujp5q0bQ5f4Qi4V/UT0mqWDYchtzY8UyNhChCI
	Josg38mfT8oe+ROlZ5Abm+jiCzXRDP9cOTqU8/k8WdoyIm3HYTgkPptnmoOYgKdC3GCr6Yp
	gdWIq5rAN1lyobXlSnmsiv66vgikpNBQWoNqWq1tjXt9m3bzdFh9UK9Mn89Sa/D/CZIKh/Z
	r3EiHLFzuTyTCaJDf1dvJ17olydcxz0WCr3TuSAKl3BUEwIYjtsD3Lc7HxMUJ557+EvrDyZ
	Op7Eh972dLx9eBTRnv4BmVkHEsqeCTM14kJjQC1YtXOiw5zfmmlk7TZWGHSUnAEydNNSzG5
	GHjmdwoEp9z7JZmhp33pNUhaEKtfFatdqn7UiAS6+OCKcD1RDHsjufv/0iAEFwjFtt9AaA9
	McFFjNSMqKDnrz5zn1v66PmMnz+P3HcD+rauQkCC4JuUB5VU6KEMnwTjWnzBGCB9WHWK7mc
	PJmXQLdXmARvXy74eaedZFyLgwTcqtKO4/ZKiQvJRU8Ni6a1RD6/2y6lo4HV/hfSBHIHMr5
	jzzn57N1ju4AI91/x2KMp1vziOl0ABVSVyCkt46Wa+q57AolXnLmH1KMBO3+8GbSNhzhKM0
	VFRSCHPtuH+HLXpwsmO+YVL42BsFTiz2+BXrh1TxFztfdwJe6xHglIgOJij7stjMZsEBWBN
	Y+kjQ7QlLvyUmPWyME9VRDE4fHhKzZRWVUd1cybPF0FUtmZH1u8npWCkxcCtdpe9DJ+odX0
	QkDLKHb4hpzpF0X97wr6pRPOENPcgjIV5vJd5j5bQaJs9S/PwYCNSo9Asv4PziX0P4mC4X0
	xihc7FmR/N/FpwQ==
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


