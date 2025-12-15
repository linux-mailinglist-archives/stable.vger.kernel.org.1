Return-Path: <stable+bounces-201100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1FFCBF90F
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 20:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64BDC3014A17
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695DC224B15;
	Mon, 15 Dec 2025 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4FFU6wXB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BD1DF75B
	for <stable@vger.kernel.org>; Mon, 15 Dec 2025 19:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765827484; cv=none; b=XhuvOeVTxBrNeuYd2dRJX593LhjHO9LYpCGTsa+/Fofwvll+KOoxGrL8bK7TPS4YmGGuBAdrrg+13AbN7zrG9jP5GDVke9DxejMeW+CGh0Q68oPQ1f7OzLI9jALkQD0OjkgXspZNOTcMChbzFg1GPbGjUhgPwbq+PGFSGCOqrYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765827484; c=relaxed/simple;
	bh=QSVCuDZHeXlv5qRq1cwLUzWtmhl9PphTRk/SWKQ108E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+6m/8wZ7BPTgq1+z7GjI2iVvaqjCvFUJIoON9ViRMzL7VcV5+mr65Bmg9JR0Uih/pcwz3B1x8g9Gn23o5+25FdpWxvackG99b1syxd16M24rAMTIYCDNtk7mG3OHS5QILYySJ/Q7t+0F7tMsxA4fJ4K3aQgsoiF6aPtMKkrTAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4FFU6wXB; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-34c38781efcso4273241a91.2
        for <stable@vger.kernel.org>; Mon, 15 Dec 2025 11:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765827482; x=1766432282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DKjoJyRjos7coqbgkgOB5Xmzn+82ea4/Olyic+3yMeI=;
        b=4FFU6wXB4mYlu0wU1D8pd5JZ8XrF6QZa65bb+Dps9aKVxdC30MfOfu8tXtsW/bnpHU
         xxH1uOx2Sf/Gfv1JRa7E5z3BZFZVOKsCyWd1LSc5WZHr+jkuxyAByoBmbsZRWxmlyJyn
         bYbvkUxzQ5AZ/ABrZ7T8+wSiTvGvxPZm/sI0u1KAHwa9sGELfXSRJDBvRVQe37Q8NpzF
         DJc5jkh8Kl9dNSgIB9ZgbX0G+E+Kk2mlNIxC+LM5adB93w+38lzYactfDgxB70fWfx5N
         g6GUbIHSqB6R7D0LJGuCRlKvA+obXPUF6aM2oRpW3v1JhifHEOo/t1d7R3UtIf5f6jd/
         UliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765827482; x=1766432282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DKjoJyRjos7coqbgkgOB5Xmzn+82ea4/Olyic+3yMeI=;
        b=pP5o153ZZT+wzndv6Ne9m2MKvlweBAedQw5B3rJOJsGBMTzk1qky9IzGWm+Yifrz6X
         PykkU2JoWfYu1vuiS+BIAsn8voP7oQGHaLrt2mEHQxP4dOpI03k1xHQOoFsBWKZKQphR
         23swa9h8wGVJZXZYyzP9tgj7nO4oabizMbnkyimoH432Eygh9a4Q17DMca+EK26qrNr6
         GI5VJOGeaJhOzkooN5P33TWKH9lxwVa8kk7teR7wW83W5SCstJrmMKFMv1wY3b2gC732
         g0obDK4HcmBtXhjrEGGjZcWND9VW9dFizhwcPcoy4XolGQ64N7g9lbnoENf1FifydXqY
         zFdw==
X-Forwarded-Encrypted: i=1; AJvYcCV4/tdKL8Qefg9defRJ9Ga0hN+rrvvTV+Fp0CDHDPwOJB0sSFjMsE24RcTe5Bdgg29AZXvS3zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQIxdNx1Q/KumYrGZA7f2WM9dBkWWLPFPlu1fUhG10eBUBm2HO
	dPE2E7oji5a72gCSO8WDOCmjUhPt48khIkVebAsnpK0xQqK1FXjGbJPgkvQhTsiDtC5LyM3XXLF
	DU9iSCA==
X-Google-Smtp-Source: AGHT+IHit10ZHn9UY8WNy/CzbinoH55sfpFrNDcKrt3yEBE1gwmZXOnkKtIYr9huTvRfD3JmRO8fKHX4RDM=
X-Received: from pjbqc2.prod.google.com ([2002:a17:90b:2882:b0:34c:489a:f4c9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2684:b0:340:bde5:c9e3
 with SMTP id 98e67ed59e1d1-34abe478030mr11650081a91.23.1765827482112; Mon, 15
 Dec 2025 11:38:02 -0800 (PST)
Date: Mon, 15 Dec 2025 11:38:00 -0800
In-Reply-To: <3rdy3n6phleyz2eltr5fkbsavlpfncgrnee7kep2jkh2air66c@euczg54kpt47>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251215192722.3654335-1-yosry.ahmed@linux.dev> <3rdy3n6phleyz2eltr5fkbsavlpfncgrnee7kep2jkh2air66c@euczg54kpt47>
Message-ID: <aUBjmHBHx1jsIcWJ@google.com>
Subject: Re: [PATCH] KVM: SVM: Fix redundant updates of LBR MSR intercepts
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 15, 2025, Yosry Ahmed wrote:
> On Mon, Dec 15, 2025 at 07:26:54PM +0000, Yosry Ahmed wrote:
> > svm_update_lbrv() always updates LBR MSRs intercepts, even when they are
> > already set correctly. This results in force_msr_bitmap_recalc always
> > being set to true on every nested transition, essentially undoing the
> > hyperv optimization in nested_svm_merge_msrpm().
> > 
> > Fix it by keeping track of whether LBR MSRs are intercepted or not and
> > only doing the update if needed, similar to x2avic_msrs_intercepted.
> > 
> > Avoid using svm_test_msr_bitmap_*() to check the status of the
> > intercepts, as an arbitrary MSR will need to be chosen as a
> > representative of all LBR MSRs, and this could theoretically break if
> > some of the MSRs intercepts are handled differently from the rest.
> > 
> > Also, using svm_test_msr_bitmap_*() makes backports difficult as it was
> > only recently introduced with no direct alternatives in older kernels.
> > 
> > Fixes: fbe5e5f030c2 ("KVM: nSVM: Always recalculate LBR MSR intercepts in svm_update_lbrv()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> 
> Sigh.. I had this patch file in my working directory and it was sent by
> mistake with the series, as the cover letter nonetheless. Sorry about
> that. Let me know if I should resend.

Eh, it's fine for now.  The important part is clarfying that this patch should
be ignored, which you've already done.

