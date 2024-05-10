Return-Path: <stable+bounces-43539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FA98C2816
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 17:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9D91F22689
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 15:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05408172763;
	Fri, 10 May 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDdpk37h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70437171647
	for <stable@vger.kernel.org>; Fri, 10 May 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355821; cv=none; b=e36lCITbVkPTKjBA9l2n81rNJtF+jdwNnCxlSWc6rfLHA/1MKlh59TZLYJ4ProEaZ4OaGrp3JphTaESReLPGRH9IqBAA4XtVJhML7/0xWApEjKUWmlp0hVQ/HsW+Q7ot8SaE+wVG1WKGqHaZnertM/pUGAW4AHFKO/yirNd3Rw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355821; c=relaxed/simple;
	bh=0BzR04qP+eOwhMtb6eedFbNSS0bhjEjPEKrMFwBWfXw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PErYTA6gPgWyqq7l/dr5yhNAHcbHLlHazp3uELmq3K8MKf853ZdAskmvGtLwT94WY3CBgaYGbth/Lyn/Eupyrt/8ltHHFV8061ta2n/LBDj/7CK/hqEXyZbvCQeUUHkrVRzbREj5WUFIc46I9f2ZbpE+1HsbCKypsRUBqwAm7YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mDdpk37h; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1ec896dae3cso21745005ad.0
        for <stable@vger.kernel.org>; Fri, 10 May 2024 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715355820; x=1715960620; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PowWN/MdR9+n0myfU6JLtOkdXF+FtST9oz4v7RSpF6E=;
        b=mDdpk37h88GfHsJebxBYphpwq9rd+sNCQh3rqXm/6TyTOQfpZkSt7MPk8XOIevGnjI
         B+9DP1nqyKQjHj4yUffaRtQPuvXG5NDlVPnP4+sVr+Af51inSmLuiWDYDM34j33BOKJx
         1prO850Fzuk+dMP5nZAu+pcr21qdzkRrDsmAmv5xOOVxXdMX7t8X2BKoBYrGP9DUsD5N
         rJmuRsD2ITJIv19XuJinZ0Aoh3/VAKhODPjqP0MFUsi2PKIvwiEngLQ2g/ttjU8mRqNe
         V2eNhexUehtYPXGrf6eKHPg2MF7A9h3lUO99tF2JsUK/6L7Tlf2rHYatDO4a6h393HwU
         xB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715355820; x=1715960620;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PowWN/MdR9+n0myfU6JLtOkdXF+FtST9oz4v7RSpF6E=;
        b=r1cvUebn2kw4RNBdUeOZCz0WtMOw2+kpW4xEa4cBlgxaol9wcaiHRNjxTdxC/uIH6y
         IRcyxsjvK3orZyWaiojFarLBg3tLMriCTnugkiNR5Ab83FixwCRxmQkmtsAq5PviDQza
         uCeK2ormjV8i2D5wz6E8NTia7xw9lrJ2M4RnO0D2xM+myhgRk292p+avQU77Ms73/Bge
         bKSY+lixmyEBd3Jm3wxGxHgukTCPEcPCLc3OcGay5b9gmWj6AMARO8IO5VkXhH5Q4Kj9
         BjH1+ZmqcPbwP8vMdCrZxnYnoTMRfQvGEbIB0ohfDJ0LtoJKUqCBQfhtKx5ckg5YNt1p
         NJsg==
X-Gm-Message-State: AOJu0YyoFVCT+Hdh0OUvpyACnB2C53b4NhDo6dkGW8O9NqZSyTNNGm4t
	VSwkGJ02G3yNeCE/9q2/OqdPPXqP0UFQH8i5CmvNuLCSPmUQrery40CAvRPRvDYy+EUNLQhOYnb
	EAw==
X-Google-Smtp-Source: AGHT+IE+chPgfRY78reUBcSObSng7rAJAttEkMl+DPmuVdDGEUggQhUVrO3KY1Cc/CDiTz2As6xjO7dv+mI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d50d:b0:1ec:2c80:8041 with SMTP id
 d9443c01a7336-1ef43f522c8mr2717955ad.13.1715355819603; Fri, 10 May 2024
 08:43:39 -0700 (PDT)
Date: Fri, 10 May 2024 08:43:38 -0700
In-Reply-To: <20240510131002.19689-1-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2023041134-curvature-campsite-e51b@gregkh> <20240510131002.19689-1-nsaenz@amazon.com>
Message-ID: <Zj5AqkmfuRv33yve@google.com>
Subject: Re: [PATCH 5.15.y] KVM: x86: Clear "has_error_code", not
 "error_code", for RM exception injection
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: stable@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 10, 2024, Nicolas Saenz Julienne wrote:
> From: Sean Christopherson <seanjc@google.com>
> 
> When injecting an exception into a vCPU in Real Mode, suppress the error
> code by clearing the flag that tracks whether the error code is valid, not
> by clearing the error code itself.  The "typo" was introduced by recent
> fix for SVM's funky Paged Real Mode.
> 
> Opportunistically hoist the logic above the tracepoint so that the trace
> is coherent with respect to what is actually injected (this was also the
> behavior prior to the buggy commit).
> 
> Fixes: b97f07458373 ("KVM: x86: determine if an exception has an error code only when injecting it.")
> Cc: stable@vger.kernel.org
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Message-Id: <20230322143300.2209476-2-seanjc@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> (cherry picked from commit 6c41468c7c12d74843bb414fc00307ea8a6318c3)
> [nsaenz: backport to 5.15.y]
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> 
> Conflicts:
> 	arch/x86/kvm/x86.c: Patch offsets had to be corrected.
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

