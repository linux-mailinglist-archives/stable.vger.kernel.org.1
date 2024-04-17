Return-Path: <stable+bounces-40134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB78A8F6C
	for <lists+stable@lfdr.de>; Thu, 18 Apr 2024 01:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3761C20C9B
	for <lists+stable@lfdr.de>; Wed, 17 Apr 2024 23:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD51148318;
	Wed, 17 Apr 2024 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yYXc1+BO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D914E133981
	for <stable@vger.kernel.org>; Wed, 17 Apr 2024 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396959; cv=none; b=GNmfgims3PSA3laCL2//pHM5Z4LtY2o5lUbqeP7BKaWA2fqwUE3WBZS6mQTbw9vDPUY6SA0Kju73NHbNBcqt0UeeL5qpWD8c9LVYfJELxZ+YwBaRRdash0R9Swy01V43RXQCs8UlhcmRN5Uc9n2G6A9lf1IGU//gaWJq4TaNjxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396959; c=relaxed/simple;
	bh=wvWcGs6xPteYiNkneq2pnXvtLThrV3P28wEAG4lJmWk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GmcZppnfzH7xIi///pexACbr/uvXpwGOcMEhBlKcbgpUivFflHcY6ywhPYiaQ4zeEM/FG4W2Sy38dWOGbJmoSiOLTGXsIXLxuv4BohNfR+N+6G2Y+hRD4dNh1iZwcnFj8oE4QvoKgn5PloCfVp8J1rUlyGTRqcKoIYePhF2LfMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yYXc1+BO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de45d510553so516365276.2
        for <stable@vger.kernel.org>; Wed, 17 Apr 2024 16:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713396957; x=1714001757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3z9SggHDBHR47UgbLQGuJMnhn0kcj9pVDDXn/yYf9o=;
        b=yYXc1+BO8pN3ZGbtWBN1BCdOpXp4bYd14RfcUw6FYRW13dv8/LKAWgIOcK2wYjtiKS
         1qrZC6QA53CmAk8bElaxc4atrm/JkUXFHjKoHAM+Yhg8rlRj+vA993UpAvnr62Gt1uIw
         xQHEMgxepEx+UkMAhO9AW3Iq2mGVRCAQFvNtoDLPTWsa6ze3C5tSJjLbcGdOwadIHY5X
         yHTCOMYS6WzDBDffKNwgIR/k9jGbgaEFCnJEjITTG0IOEhUNaw/5ah04aU9xWmlZDcAy
         y08ylTdIDyGc9U8YxHKx/uAyW1PMoz2prwmoj6IdpM6O0OMGb8UtO4SWu8QQyiJTgvi2
         POJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713396957; x=1714001757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3z9SggHDBHR47UgbLQGuJMnhn0kcj9pVDDXn/yYf9o=;
        b=UJZVpWIVGK/xZ6sNDGG5LHtoIV3BJE4xrHc2KLazdqDLdvL6MzInvIGodq1OUzcOVq
         GWKJ6B8+ZuSCTOxrf+LTQV1QPfZJvw6HkCgEHPmxR8yPjaDh4hNk2uVx+qa10qyTs6NQ
         76zXRdSGDwn5WCoPlQr1sP0bLY1P2Cl+V0TsqtPKZbskc2IYLSCGS7duramAF9a5LHBF
         Nfzt3v3fVOsmu3Pkk0oGhVei9/xxPxe6ZNAOY/KjwZ0hd3ehVKq8FmgdR+mK3CbePcaB
         DYHIsFg1w6ynDIOAJvtp/8E26kgartplbiPznLpXAFbbdo5qNOK7Z/Fc6MffoE8lHqwx
         cHmg==
X-Gm-Message-State: AOJu0Yzuqi2jyEKtyvuUMWMbGDVH4XB2Lk7IYTM9ju2Kmxqj8oR9lbcT
	145TnizPP301oTBN3I1V5oOcHtDmsqE8fIhFBsPNp6PBTcSml37x/IEY8bTOZlJW4ygYyDS1zXc
	lSg0wu0wzxaasSRiqbj+De0QKkCTD5HWoaPRr4Xvkc0ouVJ6CFcv0rQU+ijN2iQXEoDc3Rr3Sjx
	GSKP+7V9pEGnbnA8L3KtWWGEznOZuc8LEI
X-Google-Smtp-Source: AGHT+IHfFq+aF8xYM7GSWrh8v3NuRbJUzyiS8iRdxL1PjY2Je4Ddh58E6RfgKeq4JS0EktYEYAj6DG8R/nw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1005:b0:dcb:fb69:eadc with SMTP id
 w5-20020a056902100500b00dcbfb69eadcmr117528ybt.6.1713396956811; Wed, 17 Apr
 2024 16:35:56 -0700 (PDT)
Date: Wed, 17 Apr 2024 23:35:02 +0000
In-Reply-To: <16430256912363@kroah.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <16430256912363@kroah.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240417233517.3044316-1-edliaw@google.com>
Subject: [PATCH 5.15.y 0/5] Backport bounds checks for bpf
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


