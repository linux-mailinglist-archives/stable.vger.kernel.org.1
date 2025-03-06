Return-Path: <stable+bounces-121147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9144CA541EB
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 06:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20623A4E08
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 05:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D0019ADB0;
	Thu,  6 Mar 2025 05:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b="ndX1E7Su"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D217E9
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 05:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741237677; cv=none; b=Lj45Q+R+lykkRhshs/zyU6KJkDN2MbkoAHgM5FvKV0qr7HzCVQQ+p1023af86OvXUFMIwIXhjw4YPjGrG0uZXirSwjXljjFVmfsqAy8pqceutvMyDZDSvnA0D9BRovDwKZvC8b5G8ZkjnfFbURbylVW/qh8HRougqk9SDnHt2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741237677; c=relaxed/simple;
	bh=r4cqq92u4QrOP26bPzQzQ44NQlShBXBS0KDKN4ZO3aE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDXzkECJY+dfG9uafPhyoA4bGVAOhKr0xu2zeBi+Ys68DrNt9zhPzg/hNTT7iX/bGQq5hUYM6IAMhp6vg0XtW7ovNCAVqEtTyr3wDFwS266Wt7v1x2/8EG2Aj873NLAPWvuELQYJyaL+UCaXsy3i8AFSnF8OqOSMeAbNXldydNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org; spf=none smtp.mailfrom=deepin.org; dkim=pass (1024-bit key) header.d=deepin.org header.i=@deepin.org header.b=ndX1E7Su; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepin.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deepin.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deepin.org;
	s=ukjg2408; t=1741237658;
	bh=gXGZGJxxTGiGEquhpVC2RxsSuokp9eU5juqlOjiyPCg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=ndX1E7SuZW4RUlk++cHEMPl42bx139MSeeUl/QPGuCpe5oYTVmvmeL5dRXvFsaRWM
	 exfjdh1+SPwdF+AgOZN1PlAovTKvQaWnBejuYFx/TRIWD6Qt3iBTtYQ0DvheKOqnLU
	 NyGw3w6QFp+dCPvHfZASC1gLx5oyq3MoS1f5e91Y=
X-QQ-mid: bizesmtp88t1741237654ti749i3s
X-QQ-Originating-IP: eUplNXEW/+zR+b+IrjvomDkK5HrJhM4U3n06ZpEZ/So=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Mar 2025 13:07:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6009695757988680814
From: Chen Linxuan <chenlinxuan@deepin.org>
To: Sasha Levin <sashal@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Jann Horn <jannh@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Chen Linxuan <chenlinxuan@deepin.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] lib/buildid: Handle memfd_secret() files in build_id_parse()
Date: Thu,  6 Mar 2025 13:06:58 +0800
Message-ID: <0E394E84CB1C5456+20250306050701.314895-1-chenlinxuan@deepin.org>
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
X-QQ-XMAILINFO: N/EN6P+BmEaflzFIEy8wHCQvXXx6xem6MI9Lbp9cPvUYiIY05jhh4Npx
	O42m7SvSX9mDlI3U0upvlamRkNvhs2firZLYdRgkWOUWT9W2q0VQk8meW6pRzqMbg7jREKk
	xLQK7EuiUCd6+HQ/XpWUAle+J/4cAO3nzx25rKk/d7tlDjcbyeO1FpWZIyzvKhEBLi73jWD
	Dvtxd8XTent/sQVgame+FDoqxlqnxdo+6NL4fjp4VwhlFV4uZdp3Rc1+XKDJ2E1Bs8f428j
	eQi1EwF7sh5GtPyn7BnQx/cB5NEUx8BfF9XJxth9D7QTRmMKSMHpf3lDPPBHfuVVu4JzoPI
	eE1aqz0hmT4GB68V7rkiFrYfPtlmIOBqh4HhVxznifg280cSrytxJxNFmofBfQ+jqxw3OYQ
	GaFKf6g3BSV4MCUUQ21/hVtBRtkn9CGOWpOk5E0BG7YuFsVxYx95K5UMERgpRtnSZTRkzgO
	uuUrD0XjSYkBKTKHG1mXn8v22LhBi89QF/+NUKEr6dMPz9EByHO5XYJ6Ymsm7xj0NQzbYiE
	k37eDrbtlQZlDWuwYqHjhydNhS5QHiutLGODR8aX5rY8Zf5hdB98G50Vz7qzELo2ZeFZKkq
	6i9+sOHDth57x/5IzgdG6DZ1x6dlEZCWBMOeg/99WEepD+Ntt8jq1U9q5YbCXuN5kxhEevu
	FZPRkFekZgDBsud6rCzV3GIexF6BO/QDlhoBPxbLrl0Q0S5mbILGWKgxBxEzVJQ6zTySdON
	QxfnlGCaCQQpbsz1JSKPlql9FEilaocOe9LFfDxFHrUM8HaY/31aGsjq+LSigwFlcq7M53F
	iFO4IF3tynTGqwz0RDl3mBxzYm5TrRK8RhLBOaEuLNkmvP2u1jaiJMXAXl1yw89ZDA4ew4l
	o2ZpbhZrjyixHfoS6QLP8Md/uV4flBBW10P1Jdt7mWRTCooKIg+/vn4JpFSZsdDx/U2ovtH
	I022o1IbvjViX+hQO3rhUquokJWiFyMfMF1BXNh6e0WWkmA==
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
 lib/buildid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index 9fc46366597e..b78d119ed1f7 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -157,6 +157,12 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
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


