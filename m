Return-Path: <stable+bounces-40227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AA18AA5BF
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 01:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F0E2855F7
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 23:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A754C4AED6;
	Thu, 18 Apr 2024 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="koaBsHNr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A2A7EF1E
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 23:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482447; cv=none; b=PjT5rKr4+Vv3JFfTcZ92J0NfTJv0WVWfqJFq8I1NBYffd2t0CNiwzTIzDdXZ8o/8OPds2C8phmP8rqCcN8T/VcQh2mSUKpOelB2eyXyisyOdKB9yiEYXFvQBqBViHUaQVREYPtnv+WmLq8NjwgllUnjEsvJ5D1Re4iHrTaNffSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482447; c=relaxed/simple;
	bh=zL0IOoCobZDTZUsmgY7nEkobUjMzIyGPYXzHlOIP8G0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ix2ozU2Nx4n/GnMkPyDhktDWwrVOvdvjN0yhWWMnhZ4+zT3lvmvxTj8rM/BAd9ozdL+MiM4Q2YY0StX4HI9X6nAyBCsCwE/LSOVDAyLSg1sNCY3UyL/wT7y13z0tSQ0knq4ywsSyTCFdXMKP02bBYPMJTU+VJjY3QHTV5ajVRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=koaBsHNr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a5066ddd4cso1609148a91.0
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 16:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713482445; x=1714087245; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kPcj1Y72oL0YYRAb0yR7vLtHAgm/BnGjHu6ktOeso8Y=;
        b=koaBsHNrYSBt01wMnhjZzOomSPzo/bFkh1Mq47Jr406ZU0RHI012dOZGeHRZUoDA/N
         OP7YfGqVjAKAwed/s4sd6TWiyImAMMW2Z0j5RKGAqaeQOCY18FzsiH75gWVhW00yyBUF
         E9wOuMqUeOAeBFrnSzbiVGqIxXuT/Ff6R+fBO0sEYwxin6p3VxoRGtjJ9yHib9BbDOBg
         oObdFJTj4XHzv7OA+6H5xX07iMutMTcyfn55DOrVqZWHbsYHervxC11BAzK9mxrn55dT
         fkWQ6hKgaC3qp+HuBCIIKNzt0sMbkSPqjnFJEg236gnqOGgArEChwLeIabNW1HJydCTM
         BR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482445; x=1714087245;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kPcj1Y72oL0YYRAb0yR7vLtHAgm/BnGjHu6ktOeso8Y=;
        b=PgWa/W9fhquzcyY4GfSy7Ifp6z6OHTxhrPOchylTQqQQLAUvfKvM/V2h0wQUFSW42a
         ex0Js0pUK92NygEgzWsTJJJG0Sj9Of/ObdXugRrgxih/rABY3MflXSI79I9zm6boxggi
         ZIvPv0BdHE4jfIwQAxACBND2+tSP0FKDb9aaxL+jVhyA3NpzI7Kg9soUe/dxD3XqL7hx
         30dGJ1OKG/uI/UY+ukMps7TqYOTRibYEwLkAmpD5mTolwveVDxZ/088BjVVf5Bwr8J1p
         rjSHlK4TvmAkl4yiytSvPIw8aUqiW0M01B8GqqCuM7Sv4MPMSNH+VJmTWnSwCHpt1ahC
         SEcA==
X-Gm-Message-State: AOJu0YyYLK8HJZTNCwUCJEAJo/7n7ILJZD8qyJZ3eBTw1jlsBtnlCBGJ
	NTRtuHbt+EHrzma9+9xbflflBPMC9afv7Sw6cSJJ1pO8U3tnveqraWpE0JZXhVfEvgSliu6kTof
	T5pvg488IdwSKtlamLQ4Hcpg9u5GGcmLSlSUTVqBtvL5RAtCa3Xog1aSx24SFPhgv8TUtExEnLV
	wjtZtRGWgf3AdqVUaOEOu5XIDJzcGJn26/
X-Google-Smtp-Source: AGHT+IEEzy9e5oCLBFWlB6Une2LnpsXUA9NbXktsIkQ6j7clNh0qpXI1n6gnG31DeYQV8W7REduewhCPvyA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:46c8:b0:2ab:e1ae:d4c4 with SMTP id
 x8-20020a17090a46c800b002abe1aed4c4mr2052pjg.5.1713482444029; Thu, 18 Apr
 2024 16:20:44 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:19:51 +0000
In-Reply-To: <20240418232005.34244-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418232005.34244-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418232005.34244-6-edliaw@google.com>
Subject: [PATCH 5.15.y v3 5/5] bpf: Fix ringbuf memory type confusion when
 passing to helpers
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

The bpf_ringbuf_submit() and bpf_ringbuf_discard() have ARG_PTR_TO_ALLOC_MEM
in their bpf_func_proto definition as their first argument, and thus both expect
the result from a prior bpf_ringbuf_reserve() call which has a return type of
RET_PTR_TO_ALLOC_MEM_OR_NULL.

While the non-NULL memory from bpf_ringbuf_reserve() can be passed to other
helpers, the two sinks (bpf_ringbuf_submit(), bpf_ringbuf_discard()) right now
only enforce a register type of PTR_TO_MEM.

This can lead to potential type confusion since it would allow other PTR_TO_MEM
memory to be passed into the two sinks which did not come from bpf_ringbuf_reserve().

Add a new MEM_ALLOC composable type attribute for PTR_TO_MEM, and enforce that:

 - bpf_ringbuf_reserve() returns NULL or PTR_TO_MEM | MEM_ALLOC
 - bpf_ringbuf_submit() and bpf_ringbuf_discard() only take PTR_TO_MEM | MEM_ALLOC
   but not plain PTR_TO_MEM arguments via ARG_PTR_TO_ALLOC_MEM
 - however, other helpers might treat PTR_TO_MEM | MEM_ALLOC as plain PTR_TO_MEM
   to populate the memory area when they use ARG_PTR_TO_{UNINIT_,}MEM in their
   func proto description

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit a672b2e36a648afb04ad3bda93b6bda947a479a5)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/linux/bpf.h   | 9 +++++++--
 kernel/bpf/verifier.c | 6 +++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index df15d4d445dd..74a26cabc084 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -321,7 +321,12 @@ enum bpf_type_flag {
 	 */
 	MEM_RDONLY		= BIT(1 + BPF_BASE_TYPE_BITS),
 
-	__BPF_TYPE_LAST_FLAG	= MEM_RDONLY,
+	/* MEM was "allocated" from a different helper, and cannot be mixed
+	 * with regular non-MEM_ALLOC'ed MEM types.
+	 */
+	MEM_ALLOC		= BIT(2 + BPF_BASE_TYPE_BITS),
+
+	__BPF_TYPE_LAST_FLAG	= MEM_ALLOC,
 };
 
 /* Max number of base types. */
@@ -405,7 +410,7 @@ enum bpf_return_type {
 	RET_PTR_TO_SOCKET_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCKET,
 	RET_PTR_TO_TCP_SOCK_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_TCP_SOCK,
 	RET_PTR_TO_SOCK_COMMON_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_SOCK_COMMON,
-	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_ALLOC_MEM,
+	RET_PTR_TO_ALLOC_MEM_OR_NULL	= PTR_MAYBE_NULL | MEM_ALLOC | RET_PTR_TO_ALLOC_MEM,
 	RET_PTR_TO_BTF_ID_OR_NULL	= PTR_MAYBE_NULL | RET_PTR_TO_BTF_ID,
 
 	/* This must be the last entry. Its purpose is to ensure the enum is
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 33fb379b9f58..67b325427022 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -573,6 +573,8 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
 
 	if (type & MEM_RDONLY)
 		strncpy(prefix, "rdonly_", 16);
+	if (type & MEM_ALLOC)
+		strncpy(prefix, "alloc_", 16);
 
 	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
 		 prefix, str[base_type(type)], postfix);
@@ -5157,6 +5159,7 @@ static const struct bpf_reg_types mem_types = {
 		PTR_TO_MAP_KEY,
 		PTR_TO_MAP_VALUE,
 		PTR_TO_MEM,
+		PTR_TO_MEM | MEM_ALLOC,
 		PTR_TO_BUF,
 	},
 };
@@ -5174,7 +5177,7 @@ static const struct bpf_reg_types int_ptr_types = {
 static const struct bpf_reg_types fullsock_types = { .types = { PTR_TO_SOCKET } };
 static const struct bpf_reg_types scalar_types = { .types = { SCALAR_VALUE } };
 static const struct bpf_reg_types context_types = { .types = { PTR_TO_CTX } };
-static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM } };
+static const struct bpf_reg_types alloc_mem_types = { .types = { PTR_TO_MEM | MEM_ALLOC } };
 static const struct bpf_reg_types const_map_ptr_types = { .types = { CONST_PTR_TO_MAP } };
 static const struct bpf_reg_types btf_ptr_types = { .types = { PTR_TO_BTF_ID } };
 static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALUE } };
@@ -5337,6 +5340,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	case PTR_TO_MAP_VALUE:
 	case PTR_TO_MEM:
 	case PTR_TO_MEM | MEM_RDONLY:
+	case PTR_TO_MEM | MEM_ALLOC:
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case PTR_TO_STACK:
-- 
2.44.0.769.g3c40516874-goog


