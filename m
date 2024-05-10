Return-Path: <stable+bounces-43538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7C38C280C
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 17:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7713928269D
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846BF172762;
	Fri, 10 May 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SM1nf2rL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98C717165E
	for <stable@vger.kernel.org>; Fri, 10 May 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715355777; cv=none; b=O/nnVzWwSqUEWEChZiYJg4taI3HQKFHXpAsIzQrCZ9UvCb/vf/S62PDyWqoFkWsg/Oebtk5ROLy3vJ1YhrW94gujXoUr9YOijaIhhLvtcnCTaw3bGWVUHo+7MY+N/IWiDYHP80grFYRxve8K6WmpoOqHC46UliSB1HzUQKrrFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715355777; c=relaxed/simple;
	bh=pLGY3yzsuloN9wfwBtbR9vs6GAz0xb2GGtOYdXp7ICc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CcakUPpikeZ2H+sd8jSDMmQgeoPva30qu6RAkiwQWdy6PxlvLlGNKSZuiJjaLShqUjxotOzw01ymg/wOPP59BfKXUy8LYHij4kG3OrHsWHJqVzm9BWLzqRTjk/bCPnT7z5nLzpLt4KN4zVH1b4iurheZ5ME5MsnZT4Qo7wUXHnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SM1nf2rL; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so2060057a12.2
        for <stable@vger.kernel.org>; Fri, 10 May 2024 08:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715355775; x=1715960575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTM8EaUNQ5d0XVcRDHMaMfYQxy8Yw1/VPPH/uN08RdE=;
        b=SM1nf2rLlAyHzf2VD8Yy5/i6bp2QDDlNASNfnSNN+l9RNjzyYoNXSlcrULIlTxT8hO
         6VuCy68jOmK7+D0OBHDrDg3Un9l+c3KTJkhkzi6Oud/hwBIb9EaDPikshm+5i4oxHek/
         nwzaHB6dPWsti4JeIxN7VNJ9boPNz5680m/S61rsHI3/ToJ1izD1+xWCetq4iUS7G+ip
         s0ef8d15ltfRFZ4HMN2uPWKt/H65huTzdkRT5W0EQ+qk7lEN+pxMkfntV8YwQsHcgWVt
         l9f1BiDbVxWlSKJy7nsm+6cjBaXXjQeoc0mfuyCOYsUx33GrAJDXA81Sed+peXWt+enz
         D9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715355775; x=1715960575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTM8EaUNQ5d0XVcRDHMaMfYQxy8Yw1/VPPH/uN08RdE=;
        b=vcble7/0zoPbwS4qnC986AZ9uzJQ4EQewpZKfcAAGR/8RDarxYPp7Ny1G/qEmuU+RO
         +zh1BgoYLCERHxw9ssOcz1E908qX7mEJFxWccleN+XLW76KSyeDwrFohguOlxPi1fbja
         NmcJRAo5XN5J7NRVBXZGzSZrv1LBr9yQkvNLWOFCI4IG8xOpl5t5ALtO3pku6dvEFh9q
         TTD4xhikjlC54EUvoz3rDQ5JBxQMgPxoM5fzE4dm7jB6EvG3hsa95Rlu32NTbA4Q1COr
         9tGcklncXAdYEx5pfZtybLiEg4bkAVbbcGMZCBpusxmNnLiWQwx6EN+kXGrulHqK+zQ6
         KPEg==
X-Gm-Message-State: AOJu0YwZCswpdoIF/0ZMlD8xr2yrc1xF/47WJljlamIJSisyaroXsfxV
	PQgNdACJan2bzWrHMf+N1zBancz9WOyYMvqdD9QSbksSn18PgyVH07EFG4V2LMNQ+VxDSX0Y57J
	riQ==
X-Google-Smtp-Source: AGHT+IE/eLuKZfakx8IfdanAN1mzyD5LoN2wrsPR2lg4HnOZhYex3YDv6VGWi0anLQjbABBnZUl+zR/a3s4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:d14a:b0:2b3:90eb:7b46 with SMTP id
 98e67ed59e1d1-2b6ccfec240mr7093a91.7.1715355774145; Fri, 10 May 2024 08:42:54
 -0700 (PDT)
Date: Fri, 10 May 2024 08:42:52 -0700
In-Reply-To: <20240510131213.21633-1-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2023041135-yippee-shabby-b9ad@gregkh> <20240510131213.21633-1-nsaenz@amazon.com>
Message-ID: <Zj5AfN-kdz9UmccT@google.com>
Subject: Re: [PATCH 5.10.y] KVM: x86: Clear "has_error_code", not
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
> [nsaenz: backport to 5.10.y]
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> 
> Conflicts:
> 	arch/x86/kvm/x86.c: Patch offsets had to be corrected.
> ---
> Testing: Kernel build and VM launch with KVM.
> Unfortunately I don't have a repro for the issue this solves, but the
> patch is straightforward, so I believe the testing above is good enough.

LOL, famous last words.

Acked-by: Sean Christopherson <seanjc@google.com>

