Return-Path: <stable+bounces-106188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B459FD08A
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 07:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 886611883719
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 06:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186F113665A;
	Fri, 27 Dec 2024 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VV+cojJs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94099A920
	for <stable@vger.kernel.org>; Fri, 27 Dec 2024 06:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735279496; cv=none; b=h6kOkALJyxL04Hx4J8KSZkY1IGhtupVBO4iDK29oOqqNoJLOQlfzjxBBBm9O6h2l45QwXTEMpIhJLTV/lfAy6lLMeCG87EpFAn1uYUEkVtQI2P10+bWVmuzhf5WQGS0oCSCjE1tZpZBNqqXtpbr0zrVmsPK+GfqHFYYwfQXZHVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735279496; c=relaxed/simple;
	bh=AdO57Eb+/OH1Jqy7XyKrh93bu7jBULPaFLlAS3i68Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lmhk0XAQoJ+mitqAX0lrwb2m+wtHca6FBugvouMfQ+3Rs3zDvUKhtX8Krm5BP8bo+9QqMvuW7jrRBz+ZBw+kpMD9j8MnxWPLvgWjkRD1GpcwbV1o+rZsolzEqIzV2G573BQuYKj05NFQQkG4EabXxFNyeOXOBXN0d2YzXECikzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VV+cojJs; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-38634c35129so5266092f8f.3
        for <stable@vger.kernel.org>; Thu, 26 Dec 2024 22:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1735279492; x=1735884292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tof9sSByTZObvtoB+8KvKcNBw0AWH/g1c1Q6ktkGJ2A=;
        b=VV+cojJst11CqSVpP5MehIRHmQJbOOC2lrQUwl5GtmIG2ZZxPfZtzSsbEzaoNw4qHa
         FFuWGELxxrZX/37MTgyYJVL+VPnn5KADEqQqJPiKjzkIPmXv85QfAhMRWBaH7ZxZqVtj
         LUhcaUFXqkeVHtKPw/GJN3jSzAYffS4pKJiyjGIt59KzsCSMGraCsBv/ajLQPLDALHvT
         ukT0d6OSr86Ue59zm7dh5lXP1e2402IMeG3Hs55eZ7YWgeylQmI58cUyMGT+a4JUSrDZ
         DLchgQ8Is6OV76I9+DhMG01zP1F+ns2tbJSZm15Amnf3wsna9M3P+/5nEnSh7khVZJef
         rBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735279492; x=1735884292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tof9sSByTZObvtoB+8KvKcNBw0AWH/g1c1Q6ktkGJ2A=;
        b=b4aYxxCLu101eblMumYrZ7VW2ka50LUXAvT9oyvARuqwJhZLIstf0OxqyBBTuFygjl
         tNNsJ4SDw35+24W7ZuopCWa+3Okt5zliCxBY3LAPsBwPcWE6hEyRe7ClA8UBtkWh+jmn
         lXEYh6cFGsT52agdoZhJhA5YQbjgwecTFtVpNgOYUs6+8qAVmmyvlC87qX1VH4Rtktmv
         uk5IZFsPxRHbIFVZoGLLRgIsLdueycbfHUw9rtP8uQVfdvTML9kuHo0uMKwY957F7TLd
         5G0OyrO3KrqP3PteKOqZ7La1lRv/NXu9uhgQDM38gEGYkA21OofTctkWdDONna6f3LMF
         wu0g==
X-Gm-Message-State: AOJu0YytWimocL2YnFBh3KXu2mOSDEHzq3B5JpuNvvhhqjIEO1aWE3cv
	YhnQV4uZYFxZf89iE5fG9EZl+F9ursZ9Ge8ajBJ5N2ay6ai/trYOlJ76h6rWZQGfR9SUfnGYE44
	JfYHZjxX5
X-Gm-Gg: ASbGncsqWFGpfK5ULQyPKZadbLr5W0/9KSKjtEyYoyuElcCu9S4NQt+nF1ZH2Ql16aJ
	2NIt43zRKyjHN7rZ69Lg23tbJgpYC0zfTkClU3KxSpOwNO0mZJHj+1fDGiWIhXcncZ//V8+iNkE
	ZDusVEARBGxHrVyd9P0YEo+ywk+cNcFqPi/D1OrHpbkzEGjJZ677g+bXingc3qWYS+MHtdkOdVF
	wpcF5UTUzQ7KS8UHwipN6GRAzcezQplq4n6v0uaW+m7siuGTPvMFNRuZtM=
X-Google-Smtp-Source: AGHT+IFhDOwNN5Dza4YElezOG3BvYzzasnokbhcKe+tKesDcWx0wJIed+vmWgfF5nEEfYaR6NL4ZBA==
X-Received: by 2002:a5d:64ec:0:b0:385:f00a:a45b with SMTP id ffacd0b85a97d-38a221eacb1mr19181886f8f.21.1735279492223;
        Thu, 26 Dec 2024 22:04:52 -0800 (PST)
Received: from localhost ([2401:e180:8862:8223:4bef:6d3c:dd70:aee4])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e537cc1e81fsm4413858276.15.2024.12.26.22.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2024 22:04:51 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: stable@vger.kernel.org
Cc: Hou Tao <houtao1@huawei.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH stable 6.1 5.15 5.10] bpf: Check validity of link->type in bpf_link_show_fdinfo()
Date: Fri, 27 Dec 2024 14:04:35 +0800
Message-ID: <20241227060437.76331-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hou Tao <houtao1@huawei.com>

commit 8421d4c8762bd022cb491f2f0f7019ef51b4f0a7 upstream.

If a newly-added link type doesn't invoke BPF_LINK_TYPE(), accessing
bpf_link_type_strs[link->type] may result in an out-of-bounds access.

To spot such missed invocations early in the future, checking the
validity of link->type in bpf_link_show_fdinfo() and emitting a warning
when such invocations are missed.

Signed-off-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241024013558.1135167-3-houtao@huaweicloud.com
[ shung-hsi.yu: break up existing seq_printf() call since commit 68b04864ca42
  ("bpf: Create links for BPF struct_ops maps.") is not present ]
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/syscall.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f9906e5ad2e5..6455f80099cd 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2816,16 +2816,21 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	const struct bpf_link *link = filp->private_data;
 	const struct bpf_prog *prog = link->prog;
+	enum bpf_link_type type = link->type;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 
+	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
+		seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
+	} else {
+		WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u\n", type);
+		seq_printf(m, "link_type:\t<%u>\n", type);
+	}
+	seq_printf(m, "link_id:\t%u\n", link->id);
+
 	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 	seq_printf(m,
-		   "link_type:\t%s\n"
-		   "link_id:\t%u\n"
 		   "prog_tag:\t%s\n"
 		   "prog_id:\t%u\n",
-		   bpf_link_type_strs[link->type],
-		   link->id,
 		   prog_tag,
 		   prog->aux->id);
 	if (link->ops->show_fdinfo)
-- 
2.47.1


