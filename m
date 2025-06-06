Return-Path: <stable+bounces-151580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601BEACFC43
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 07:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADFC11893221
	for <lists+stable@lfdr.de>; Fri,  6 Jun 2025 05:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D72E1E412A;
	Fri,  6 Jun 2025 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XxOvmFZm"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8875A4683
	for <stable@vger.kernel.org>; Fri,  6 Jun 2025 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749188292; cv=none; b=r1+4j9v5vjqZQ9b8V/fUeB2ucexTfDKdEYgGVOizAzXPboIVG3vc5iSX02BltAqlYCu7C9LtTQKooZUujkIktYymwkCOqVW1ROH5aFMq1uvfKOH/kVgDXmwaiPoCXUOmhOa6TSps5rIp2vZDjblH7xjratL1k4Hq+Nks7blnk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749188292; c=relaxed/simple;
	bh=D1qVR2rPayReMgS7NuJBE2UqOfY1+vud49wAOQyN/PM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=BJMlL4XD8ia/YuGI7wIu84BijryEwD1yH6ugMGIYDXuopaUoUfWSEjPoAh3w9aWLGREFOOJqQoW0tvlU700s93nAAVBgPKsgay0b2OA43oWUhgW1ve+VHgPnfxY1dcaTGtE0oX2NPJHNiEu640K1KdPvA4ARqujshXNF+0sW/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XxOvmFZm; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e81b1def6c9so160376276.2
        for <stable@vger.kernel.org>; Thu, 05 Jun 2025 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749188289; x=1749793089; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6e8z1Y0PM6ePVKE7akB6cAIu/1nUvlhiiiW5g/fTl7g=;
        b=XxOvmFZmkyvXXM5HPZVYYOZOigbgPLy0WvllSrC1no/0ls2nPRqoBIYeQdIfHheQiT
         ufHOma0j6SWjHeZPRGCYaNl8rdNzek5PpLBSmx4Gu22I+Plxd3AveP0q2RlQG7hDzVHD
         2nZLkTiJDd5PjZAkqeV+abNhRScSlAu+wSFrMbJ/wasgVUna7EYP2GeCEEYzk3IaO5N8
         yG0iFXolvH6NTtxX/+SbPYWHDHJ2hneLJjaXKwWvgnH9Sk6/tUx5G/Hr3de4mqkE6Jj2
         rQYmez+B02HFI1K4qStzk5seSLJz5rOtoLKZ1SCaIAIVxTcmGBxjPe3cuLljZR4NLdLo
         NZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749188289; x=1749793089;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6e8z1Y0PM6ePVKE7akB6cAIu/1nUvlhiiiW5g/fTl7g=;
        b=sqRv/Qf5Bne0G4r7ukiIMAqj6IWN/qO51trRbNdrYojErVCJKCBVaNVHyxGEilFKym
         htHXAZen3IkOwiSWA2excwwbFM55PGe3rucPI1v7tFGFd+7kgf6QMpGPKC+MSm3xwcuR
         wG+rzMQGokxKDmNDecVzNKqTrWZrHYqGLyBBjRdXJXz+uS37+VBzBc4+e/+E6GWtUUu/
         xpVnol0RqASJddLsHGwWG7GgCG/fZxI86pFN6dMo+2oXUHv0VncVEhK9WykChVkVMHjH
         DAe/1X3wG+SVP+0Sbk6A3kcUODgpNkg2Ebp0wxoSDKzpqctpAV0aXsjvTyR+Ke+D190Q
         Vlqw==
X-Forwarded-Encrypted: i=1; AJvYcCWFHByaLbuqkEf7DIPgC7hVvPTa2HM5IAS0XIvMFnSR9QsEP2jgffpfpsARHMEMmMAxgDlfwLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycLgivE1BtYIYsWcBV4xm1A+WYn6+6mEt2Vq6eCJi45Rbqiy09
	W0CZy10wwbQN071LcF5Ybzw4wGN4kSMXbkoII78he/uDY1T+VK6dcDzlmXlauD8i1I7gy2kcD4P
	tjpQFiasI0RdGpQ==
X-Google-Smtp-Source: AGHT+IFS+GD65k0hSub3v9ULn9x30VGz/G+3YfG6wahC/QEoNt85ySmK2qp8MyMrEf3ggnp2Rl7EW06pkn5awA==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:b09c:3d84:6735:a65])
 (user=suleiman job=sendgmr) by 2002:a25:a44:0:b0:e7d:c44b:a4a6 with SMTP id
 3f1490d57ef6-e81a25deabbmr3028276.8.1749188289448; Thu, 05 Jun 2025 22:38:09
 -0700 (PDT)
Date: Fri,  6 Jun 2025 14:36:50 +0900
In-Reply-To: <20250606052301.810338-1-suleiman@google.com>
Message-Id: <20250606053650.863215-1-suleiman@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250606052301.810338-1-suleiman@google.com>
X-Mailer: git-send-email 2.50.0.rc0.642.g800a2b2222-goog
Subject: [RESEND][PATCH] tools/resolve_btfids: Fix build when cross compiling
 kernel with clang.
From: Suleiman Souhlal <suleiman@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, Ian Rogers <irogers@google.com>, 
	ssouhlal@freebsd.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Suleiman Souhlal <suleiman@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When cross compiling the kernel with clang, we need to override
CLANG_CROSS_FLAGS when preparing the step libraries for
resolve_btfids.

Prior to commit d1d096312176 ("tools: fix annoying "mkdir -p ..." logs
when building tools in parallel"), MAKEFLAGS would have been set to a
value that wouldn't set a value for CLANG_CROSS_FLAGS, hiding the
fact that we weren't properly overriding it.

Cc: stable@vger.kernel.org
Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
 tools/bpf/resolve_btfids/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index afbddea3a39c..ce1b556dfa90 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -17,7 +17,7 @@ endif
 
 # Overrides for the prepare step libraries.
 HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  CROSS_COMPILE="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
+		  CROSS_COMPILE="" CLANG_CROSS_FLAGS="" EXTRA_CFLAGS="$(HOSTCFLAGS)"
 
 RM      ?= rm
 HOSTCC  ?= gcc
-- 
2.50.0.rc0.642.g800a2b2222-goog


