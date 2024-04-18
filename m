Return-Path: <stable+bounces-40141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EF68A9046
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 03:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1667D281E49
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 01:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51B78C11;
	Thu, 18 Apr 2024 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBa+j+UK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C126138
	for <stable@vger.kernel.org>; Thu, 18 Apr 2024 01:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402449; cv=none; b=qLUEz2VQotqTeNxA766nqEqKcKi4BDRzfqxn/5rcY18t45pdw0b3h80v8rawbYxLBgnGg3yurm95GLwNzNZFMypuKwGUS/xl9diVeMckxKPe7HeFuHlordUI4eZfbSU/ler0rWk9Iad7D3+Aszh7yz7V4FB7tvKl+K0dhd4Lx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402449; c=relaxed/simple;
	bh=ugT74PoHd8kn03j1TJX7vb14OkXu1n5AwTPK5v5aCCg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ws9fpDLUzXt5I/UHxOeGNNb1mthSsnwV2BuMSWZukfFQiHhrK0Rdek+ZgEZWe9ljhtze0aU31Lg9BB2y9rZzSfvGyk1n/77mANbH1RX7BKHFpa6hJvGhI7P0ZXWHyBmVzu/DP7iYfECwdCQTgVV9KvRIObZewOrYjfY8z5oe4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBa+j+UK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de465caa098so372453276.2
        for <stable@vger.kernel.org>; Wed, 17 Apr 2024 18:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713402447; x=1714007247; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MdSRxrDWVrTdyXc/SZ7hHOG18QRAIlMKQeP4juS8/a4=;
        b=kBa+j+UK+HWRBJ9/niVM1IkKzufdWENk2OTzPkrxfusFWS52FjKQBFTctggsUGy8+y
         RPdQxh3ysy41ZfOxpBhffN22Q85RPTQv5kP0Vsq8jBknXLs/LL0Rn0cWvYBgmeL88Qrl
         8NG8mgGI2l+scF3D/polu8NsfNR3LEsJPhpOGURv1PWX8ghaS9XGMGfTGRG0WfK5oMhD
         sRGTs+JrqpI/m0dyUZyaUK5B32rmMIQdAmB/zAa9aCtD8aS3qh2n4OyX86+QCnY25icw
         3CAgCK3K96hMYbClx4HwGqDG0eNzdPp3ePYi4hGUkzWeri2SKatVZtcoDOeqCjbq2oMj
         SqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713402447; x=1714007247;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MdSRxrDWVrTdyXc/SZ7hHOG18QRAIlMKQeP4juS8/a4=;
        b=LToPf2zuewNDJAmEMWv5+hGBvMdul5e9zgSAsWTHU9UZ8BrIiFUcjv6a6h+4vViewc
         wN0Dg/3RTU4ZYoD3L8tV58CwcYBdU7OY23AK+orkfla6ngW+4b/PWvx92GjZeGXDl8vS
         PCbMkuijxB4BOcA1fXV4Kxs9PRNcKicB8/jwAQuPylFJKbEIzBT7r7URNC7iioztFp8K
         QLZ03anRXnTl4ETilYlzOFvwPaYKwxukzgZvcmz1kqrDgJpJYlGNY4BmYVn7+8bKwGEz
         oH6AuQS0kaOvEubRemZIHx/XWnM45alOyDHfasWxYY903pj0SqgHkMMbQhKbdCAqBlts
         Ct6A==
X-Gm-Message-State: AOJu0YxQZV2lK13eS919bXGVl6NM+9c0aeKIhdjDWCil9cZQMhFfV840
	9W0a49KOYEiXGF2bwCNU+nNzffolQjtA+zJ81POYszfPgHRM6afuHsL6S0NK7CXHCftWjwH2nc6
	UOtTQkXEv356z8dt2irXAlO10a9GR+4bQlgrulXhi6+oePvd1cRIRnnj8enigB17R0S1N3SCL+V
	S60rW9LssfJnf+VFwUZsA4bpJQy5Gyw1T/
X-Google-Smtp-Source: AGHT+IG38wIupQEk9EdfJseXhTp62aHkse9umTarR8j0kkObuskwYS0w1aDzglzbg09ZRXU2Ys2DSXgm74o=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:18cc:b0:dc6:b982:cfa2 with SMTP id
 ck12-20020a05690218cc00b00dc6b982cfa2mr116831ybb.8.1713402446546; Wed, 17 Apr
 2024 18:07:26 -0700 (PDT)
Date: Thu, 18 Apr 2024 01:07:09 +0000
In-Reply-To: <16430256912363@kroah.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240418010723.3069001-1-edliaw@google.com>
Subject: [PATCH 5.15.y v2 0/5] Backport bounds checks for bpf
From: Edward Liaw <edliaw@google.com>
To: stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

These backports fix CVE-2021-4204, CVE-2022-23222 for 5.15.y.

This includes a conflict resolution with 45ce4b4f9009 ("bpf: Fix crash
due to out of bounds access into reg2btf_ids.") which was cherry-picked
previously.
Link: https://lore.kernel.org/all/20220428235751.103203-11-haoluo@google.com/

They were tested on 5.15.94 to pass LTP test bpf_prog06 with no
regressions from the bpf selftests.

v2:
Made a mistake of not including the out of bounds reg2btf_ids fix

Daniel Borkmann (4):
  bpf: Generalize check_ctx_reg for reuse with other types
  bpf: Generally fix helper register offset check
  bpf: Fix out of bounds access for ringbuf helpers
  bpf: Fix ringbuf memory type confusion when passing to helpers

Kumar Kartikeya Dwivedi (1):
  bpf: Extend kfunc with PTR_TO_CTX, PTR_TO_MEM argument support

 include/linux/bpf.h          |  9 +++-
 include/linux/bpf_verifier.h |  4 +-
 kernel/bpf/btf.c             | 93 ++++++++++++++++++++++++++++--------
 kernel/bpf/verifier.c        | 66 +++++++++++++++++--------
 4 files changed, 129 insertions(+), 43 deletions(-)

--
2.44.0.769.g3c40516874-goog


