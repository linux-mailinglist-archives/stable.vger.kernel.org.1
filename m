Return-Path: <stable+bounces-40222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 223CF8AA5AC
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 01:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4801C21357
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B708F6A025;
	Thu, 18 Apr 2024 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLXUflGh"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DD4EB2B
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 23:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482426; cv=none; b=Ft7HJk/BsutxkKd+MH4lsSGbo6ptFnXMKPyCF+OOOQVtl2K7LqbdXLwZUY5pS1TsGGeX4IF9PGBHR8LwKM1dcbnu/S3tFSs77M+vOFa1xVP5YjacXTL4gZVSKUlMeurzrzqXGk2GS4qPk9jSOfD4oiS8nvk3v0kgRwPbmWC2/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482426; c=relaxed/simple;
	bh=h4Z5MLdi8J9t3gzna+fG2ThqFUoIZcOZaNd46qMwcq4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WKavZ67AC4CXF7vYjWmdEyj4Ja4tNakhRxA5HZ2kNI2w9/uSEUS6lX2A9jMr+JGk9llDTYU7NCX5gO5hbmb3igQn4JNkM8y2z+UrBLPaRhL3wmX/3mthlsmN3Zi5TWG3vkwlgUbYGi/RaCLrHxxK20bbpM81nbRGn3PMPIDhPNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLXUflGh; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ed2f4e685bso1540056b3a.0
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 16:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713482425; x=1714087225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=26meAcCrC16s/TSKv+80D/MrO7azFsmm58EfNKygcv8=;
        b=qLXUflGhzThS1SFZeMcN/ybDAUijfn0ZdWaM7+lZJo1kVCMqI8u5KZ8qk3YSqDymBS
         haCbDZivU8Mg2UF/mpoAjZSvmTQ52CC36sgOL05PXxHGLRnqQGqvoaGyNjfC7Gcr7jcE
         e6tvDY5rNbRGQVqvNf22Rmk4XRsiB9xn6WtUQqqookXHtSKkt+3cZQLQwqlCdNBzbcfC
         +OdYPZ8xKujbtQBFbH10qEKZbLCLbXRaQmbjbWe0ngqcaYKo+OhEE/S4D5DiYuVYbk5N
         S42FpAAYxzHLTeG5bkKXE5936j8vvpdTxTFl9u47ISQL39xkm0+CmjtGFn/KQpQqBbOz
         +yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482425; x=1714087225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26meAcCrC16s/TSKv+80D/MrO7azFsmm58EfNKygcv8=;
        b=o4pEf2AYGkSlrBkmFXPHOZHMkPflEBkQCVFBb3VcG5Yf6Vg1hb1sg0ug2skPeLKKh6
         8h0SCtA/gXS/nawgdXEZz1VfevQBlrRglaR8CPiH4coxJo20YnUC1pNEE2wQm/A89n+h
         HGrLIjE99j1J9h+KH1dsXyqqebVEH/H/ANEn3vZnqeqdqq58G8L45KqH6L2PmgbMyzzZ
         K7vEVXf8TzS0uMbg486YBoquwcQszsO/5sgHx+V6rbsf2EicyKS8NuK9bmu3s9hKamka
         +YAlFGvAnw9MiSYCvRc4S9rUCGEt9qqT9kMwD//C/+S3SSiurNM7e7mqQiYeJ6yxZXgH
         Ce1Q==
X-Gm-Message-State: AOJu0Yx7dn2HFWKozW2B6uM+zQJoefIsBZ9xLpy39HwflFUc0CjWpZKC
	+euCWCRLr0U9RIm84PzFFAw95U5hej7H1Cb5EO3WZ/DgZYqDVeO/9ZtPjaufZYInM8gQVQaRrbb
	1n6wWvQccFkZHwH8fkEJwfl4QZypi+TW+nxUP1+yBrkg4O5/BLJ/9m8u6TMrymcb/qsiVAetY2w
	Bm1huOzlU1AxoREPr2VeOITmw+zoErT0fs
X-Google-Smtp-Source: AGHT+IFCT+LD8L7Ydyey8ugQxfC4hQL7hz4SeRVez+Chgb/ZmrwQpoWBky8hs4o0JI2AHzcCAT53BPCTo9c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3998:b0:6ea:f425:dba2 with SMTP id
 fi24-20020a056a00399800b006eaf425dba2mr50612pfb.0.1713482424349; Thu, 18 Apr
 2024 16:20:24 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:19:46 +0000
In-Reply-To: <16430256912363@kroah.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418232005.34244-1-edliaw@google.com>
Subject: [PATCH 5.15.y v3 0/5] Backport bounds checks for bpf
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

These backports fix CVE-2021-4204, CVE-2022-23222 for 5.15.y.

This includes a conflict resolution with 45ce4b4f9009 ("bpf: Fix crash
due to out of bounds access into reg2btf_ids.") which was cherry-picked
previously.
Link: https://lore.kernel.org/all/20220428235751.103203-11-haoluo@google.com/

They were tested on 5.15.156 to pass LTP test bpf_prog06 with no
regressions in test_verifier in bpf selftests.

v2:
Made a mistake of not including the out of bounds reg2btf_ids fix
v3:
Merged in prog_type fix from f858c2b2ca04 ("bpf: Fix calling global
functions from BPF_PROG_TYPE_EXT programs") and rebased to 5.15.156


Daniel Borkmann (4):
  bpf: Generalize check_ctx_reg for reuse with other types
  bpf: Generally fix helper register offset check
  bpf: Fix out of bounds access for ringbuf helpers
  bpf: Fix ringbuf memory type confusion when passing to helpers

Edward Liaw (1):
  bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support

 include/linux/bpf.h          |  9 +++-
 include/linux/bpf_verifier.h |  4 +-
 kernel/bpf/btf.c             | 93 ++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c        | 66 +++++++++++++++++--------
 4 files changed, 129 insertions(+), 43 deletions(-)

--
2.44.0.769.g3c40516874-goog


