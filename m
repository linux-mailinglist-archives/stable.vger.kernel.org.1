Return-Path: <stable+bounces-178465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43063B47EC6
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF60717E828
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9285020E005;
	Sun,  7 Sep 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q3kRnEz/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5517BB21;
	Sun,  7 Sep 2025 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276921; cv=none; b=AsxCBuUxS+sLgkB8H+rVD2POww3NoGJGhYBRXrSIb/QhjZ0cz42hdpVMltxpQ00dtW+YVr+ut3k0aBu2JKcdcy+hymOPkcHQUJzuTKtjwUF1Ki/XhPUwefUmu0I0FkrZYY1KmGUS6OfUP+FTswtSRCr0IyWwlv8vCfuRJWlZhxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276921; c=relaxed/simple;
	bh=h9YNm9cvX7+AkoisrVedqj4YTsq23xhBLwfOIYgy+HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i53xAfWLnxt0qqMjOFkYyWCok00lkA+/xy5TQE/Yt+gnD0ns2asJqcLhA3AuoGfZ9a8BFJaSU85KTY0f5jpXv/h/N/fNU3BCoRbbXYJEDqbce1z3ZANPqwQ9T6AIwRYhHZUHkC22JTd3xe2Za9gJQwkNoOJUQ1ryQcbc8ENCTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q3kRnEz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A10C4CEF0;
	Sun,  7 Sep 2025 20:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276921;
	bh=h9YNm9cvX7+AkoisrVedqj4YTsq23xhBLwfOIYgy+HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3kRnEz/cPzY+8LnWcCXOWAt+qaPn7NGD31vFrD15O7YOcevKPj9UWSyW/M4fcJL8
	 u0hdtlgEKIeKA+8ld9XTfTBn4ym5ZyFg2rzNIdSPqfq0A98vCDOFqybvkRQS7Ath2t
	 IX93t69Pym9Yv79F2SfmKQhmAOwShL2UW3zP1W3Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 003/175] bpf: Move cgroup iterator helpers to bpf.h
Date: Sun,  7 Sep 2025 21:56:38 +0200
Message-ID: <20250907195614.971674669@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195614.892725141@linuxfoundation.org>
References: <20250907195614.892725141@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 9621e60f59eae87eb9ffe88d90f24f391a1ef0f0 ]

Move them into bpf.h given we also need them in core code.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20250730234733.530041-3-daniel@iogearbox.net
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Stable-dep-of: abad3d0bad72 ("bpf: Fix oob access in cgroup local storage")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf-cgroup.h |  5 -----
 include/linux/bpf.h        | 22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 7e029c82ae45f..26ee360c345fa 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -77,9 +77,6 @@ to_cgroup_bpf_attach_type(enum bpf_attach_type attach_type)
 extern struct static_key_false cgroup_bpf_enabled_key[MAX_CGROUP_BPF_ATTACH_TYPE];
 #define cgroup_bpf_enabled(atype) static_branch_unlikely(&cgroup_bpf_enabled_key[atype])
 
-#define for_each_cgroup_storage_type(stype) \
-	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
-
 struct bpf_cgroup_storage_map;
 
 struct bpf_storage_buffer {
@@ -518,8 +515,6 @@ static inline int bpf_percpu_cgroup_storage_update(struct bpf_map *map,
 #define BPF_CGROUP_RUN_PROG_SETSOCKOPT(sock, level, optname, optval, optlen, \
 				       kernel_optval) ({ 0; })
 
-#define for_each_cgroup_storage_type(stype) for (; false; )
-
 #endif /* CONFIG_CGROUP_BPF */
 
 #endif /* _BPF_CGROUP_H */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index cf3ca7b7f4487..fa79393e41f82 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -205,6 +205,20 @@ enum btf_field_type {
 	BPF_WORKQUEUE  = (1 << 10),
 };
 
+enum bpf_cgroup_storage_type {
+	BPF_CGROUP_STORAGE_SHARED,
+	BPF_CGROUP_STORAGE_PERCPU,
+	__BPF_CGROUP_STORAGE_MAX
+#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
+};
+
+#ifdef CONFIG_CGROUP_BPF
+# define for_each_cgroup_storage_type(stype) \
+	for (stype = 0; stype < MAX_BPF_CGROUP_STORAGE_TYPE; stype++)
+#else
+# define for_each_cgroup_storage_type(stype) for (; false; )
+#endif /* CONFIG_CGROUP_BPF */
+
 typedef void (*btf_dtor_kfunc_t)(void *);
 
 struct btf_field_kptr {
@@ -1028,14 +1042,6 @@ struct bpf_prog_offload {
 	u32			jited_len;
 };
 
-enum bpf_cgroup_storage_type {
-	BPF_CGROUP_STORAGE_SHARED,
-	BPF_CGROUP_STORAGE_PERCPU,
-	__BPF_CGROUP_STORAGE_MAX
-};
-
-#define MAX_BPF_CGROUP_STORAGE_TYPE __BPF_CGROUP_STORAGE_MAX
-
 /* The longest tracepoint has 12 args.
  * See include/trace/bpf_probe.h
  */
-- 
2.50.1




