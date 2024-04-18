Return-Path: <stable+bounces-40226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C781B8AA5BB
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 01:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CDED1F22ACA
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 23:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220B37E78E;
	Thu, 18 Apr 2024 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2WSGbe+l"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0D7E59A
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 23:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713482442; cv=none; b=WLxElvCgs/nZRWQIkyzkn4aBy+Vt6LDbTIgezN7NwuV3zkjAViiwPSjwNwgJytb7MPBwIc39qbplmY5lpE00L8mm8dhhB0+PX+gFWFKQVdZYr0YMFY4kO6WSE5AiPxWGNz3ZpMqZyi5PeKEbxmGV2l7Dbgz9VAvGg6qADkdwiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713482442; c=relaxed/simple;
	bh=Q+72qrXtm3Xqm1QYlQ/ARcpBQmoPZPgK3ApUYdbDx7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R9jxBbxjMU6eq3UnFYLx7pQCCdjOJfiSj1U9Xu3VPWVML4TKvUZ4hZd2OiBo4F7q4M7zgnJWNLd2Hl35/s9KWmn4zLszO/ZgxOWQumJH1uL7R+HAXW/faw62K8BA5VA4Esdr1FelLHijwFgjzB7o94+yhWTDAmXbZCntzIYNH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2WSGbe+l; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61892d91207so25956407b3.3
        for <stable@vger.kernel.org>; Thu, 18 Apr 2024 16:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713482440; x=1714087240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K9HSeHzPuGtWyHVXG0SBH6UyvQOr79hE7Vg79sXvjgU=;
        b=2WSGbe+lgquQp/VFNauRnLmTTFiykoWFbsEvN+waloQqhnLNwhTtv3BW8m7p01mHc6
         qrZMi8sTe0gHcP5yJLjJmUK+l3teVVlKkaxqIk3FaN/Q2CyImGqm8HKNsVlPnFUr0/GO
         p1SYqqOkZ/DH+zELOqjK9988QGyDtb109H7gZZrOErLmqZEmvolgix0+dwNCXZlK7+1e
         OhIVoZFMd40HoPYXmC53bm8UTLsu2GB4AdkcBw+tU9KIJ+odi49mvS0hzrhJYa2twhvP
         u/arTdaX/rsMpnTbubG/pi2SdL5Zx/RSOY98YIFt48nrZ1UajoTEMua7wonnhf938YZd
         48sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713482440; x=1714087240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9HSeHzPuGtWyHVXG0SBH6UyvQOr79hE7Vg79sXvjgU=;
        b=VOcfSRxi1EYMoEN6ZjbQEK+YRUPEgzhHJIJqfWsPuAknmo/I3/h78JpMO6mCow9R0r
         FOaFO/fnCsFVpnYVO73RSYphk3XpMxUEBZ23yQczKKlTWK3F9uhdOmybV9hQ+ZKCZ0hU
         wBi42sWRQn7Y1SMHzwiaq8ikSpSmIEbPCfnu5MVWKptIHu5bT1Oqc2pKIBiWsVaExVHf
         duNT+TQWmel3n2axDvxAOSdgcVQQMgtAN1yYIkC0qI7W+T4mQ7CnT0BPIXhKsYQjSQc7
         /hJcx0PVnyIEeRFNFUOPacYb1DqsjyILEKUXRU9vKjA951gy0q+8x4BhczVBmDE1usqX
         pLXg==
X-Gm-Message-State: AOJu0Yx8NnPUihZm7ihb20X3MJUiUk/dHQ0jZ+8pYRsQjU65vs57Rg7y
	/qjIILL3gclDfMTywnU4BnK0sH6I/8Zc/Q57ZVUwlxVt9XezAZiUBEV6L8UIcYLaWmABHgnG2we
	UrdJsDoP8g/+wMEcnsFlN3dTTG8duulZevkC5UbZbG/0Wd7XjHbdh7ahAp5wGVm71S50QfiZzXh
	I4+dW5mh0ojWYmkH+PwuWewsHXTs6CT4fC
X-Google-Smtp-Source: AGHT+IFVENWOQrhyE9ZFDpAXDlThECm3CQcbnYXp2g9WsRBiAe+oNdRYITno5N/z+Nt1e8YR6fxhOoF7uMs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:52c6:0:b0:61b:3a8:330f with SMTP id
 g189-20020a8152c6000000b0061b03a8330fmr112441ywb.5.1713482440230; Thu, 18 Apr
 2024 16:20:40 -0700 (PDT)
Date: Thu, 18 Apr 2024 23:19:50 +0000
In-Reply-To: <20240418232005.34244-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com> <20240418232005.34244-1-edliaw@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418232005.34244-5-edliaw@google.com>
Subject: [PATCH 5.15.y v3 4/5] bpf: Fix out of bounds access for ringbuf helpers
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org, 
	tr3e.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"

From: Daniel Borkmann <daniel@iogearbox.net>

Both bpf_ringbuf_submit() and bpf_ringbuf_discard() have ARG_PTR_TO_ALLOC_MEM
in their bpf_func_proto definition as their first argument. They both expect
the result from a prior bpf_ringbuf_reserve() call which has a return type of
RET_PTR_TO_ALLOC_MEM_OR_NULL.

Meaning, after a NULL check in the code, the verifier will promote the register
type in the non-NULL branch to a PTR_TO_MEM and in the NULL branch to a known
zero scalar. Generally, pointer arithmetic on PTR_TO_MEM is allowed, so the
latter could have an offset.

The ARG_PTR_TO_ALLOC_MEM expects a PTR_TO_MEM register type. However, the non-
zero result from bpf_ringbuf_reserve() must be fed into either bpf_ringbuf_submit()
or bpf_ringbuf_discard() but with the original offset given it will then read
out the struct bpf_ringbuf_hdr mapping.

The verifier missed to enforce a zero offset, so that out of bounds access
can be triggered which could be used to escalate privileges if unprivileged
BPF was enabled (disabled by default in kernel).

Fixes: 457f44363a88 ("bpf: Implement BPF ring buffer and verifier support for it")
Reported-by: <tr3e.wang@gmail.com> (SecCoder Security Lab)
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
(cherry picked from commit 64620e0a1e712a778095bd35cbb277dc2259281f)
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8cd265d1df34..33fb379b9f58 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5340,9 +5340,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 	case PTR_TO_BUF:
 	case PTR_TO_BUF | MEM_RDONLY:
 	case PTR_TO_STACK:
+		/* Some of the argument types nevertheless require a
+		 * zero register offset.
+		 */
+		if (arg_type == ARG_PTR_TO_ALLOC_MEM)
+			goto force_off_check;
 		break;
 	/* All the rest must be rejected: */
 	default:
+force_off_check:
 		err = __check_ptr_off_reg(env, reg, regno,
 					  type == PTR_TO_BTF_ID);
 		if (err < 0)
-- 
2.44.0.769.g3c40516874-goog


