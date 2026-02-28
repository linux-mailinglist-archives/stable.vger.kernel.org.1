Return-Path: <stable+bounces-220026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAvbMmo/ommq1AQAu9opvQ
	(envelope-from <stable+bounces-220026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:05:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F57C1BF9D3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 02:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78A5C306A135
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 01:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A32D23B9;
	Sat, 28 Feb 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyPxNJ2T"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF452D46B2
	for <stable@vger.kernel.org>; Sat, 28 Feb 2026 01:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772240739; cv=none; b=e0rIFriFhAM7GTXUCQI9eQgV4rfpNMT6EyupyNrbdIzt6+SNuixH718+2GPqVOT9X1l9f3IosDprCGhvhHBL1joBV2SNtSK13VNUvYotxwCL06gUMVXiVn0JCNgk3TGSQtVtT4hqd3t0ldyk81Cyb/bTEhcss5WxY8Dtlg74OQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772240739; c=relaxed/simple;
	bh=1zUnvMi3DhR4TRKA6QhomrBPmg9vrIoA4cSt9CrQaQI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R38CQZFlqb+uS4Co48US7r8zvSS4TlY5qN/HauvcyJCGzjdXoZ6EhHqC52/qA8EJH3Cmoi1pgaHZFwgWUJXqQp47wPDS7/xzi4mDyuoz0natOZ/7LfeubLtfu0j7XXiCvLb1NAYJOdRAPCpNtn9QwxM3d2yKgYJs/riz7oiBB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YyPxNJ2T; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aaeafeadbcso28260215ad.1
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 17:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772240736; x=1772845536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7Xd6qG6AlycAVEj6etoW+v6AvuZE8R530E1vnavVsw=;
        b=YyPxNJ2TMH3jPTC5RkOuLBQJ4Mp2ZVYb03RHjjvm/VSP7qPu/ZD8NFCFKlG7J13HCp
         hUaHiPfftAxHbmWFYhIyJDcf3q2puidCfLuIVeAcquJ2izdjTD4BWyCYSBZB83iG5I9E
         4zGTEsytwPXPtB7mA1BJ4EZfyUQbht4LQPptc6ET/tsT6aFb2s52eq/WoocmQ+sybqIl
         Ve4e/YdTCj9fnwJ8jhZy5Ltdag1QapoU0XgcL8uOd0wj8EoNf/XMI5r5ganatL0lipxo
         +kVivj3MnBhbfmlLRICat1+ZnoPdXVUq+t3ry3KyWYLqaDAo31JkxgFSyLSILVZbQ8jr
         QsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772240736; x=1772845536;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D7Xd6qG6AlycAVEj6etoW+v6AvuZE8R530E1vnavVsw=;
        b=svsUGLjOrE6SCCZ2OTm+EcLlomsasGE45ITs1Ez/Owz0ypkzjbHyI33THqLNOALVeU
         QMentJiD5ENdTiGPohvSEZNTWyxqv+Up94HGHdAkASNrCTeZ15ZFAUSOWif7PfZ5Lvsy
         rHqmCqTwRiZBF9LJVFNBIAKK8E2bE5LPJN8A4pJaz0hDoGz1H95ZQDwYnmMObOVIVwLt
         sCJITHKJO5+dC0UX40qlLyAacO0WRTVMolPLpPPYATye5LbKwM59pg1KSliou/P/GWBq
         Vlfy7IUvpAojcP+IysziLCvNOjd85/rOcLyZS1lPfyViv1IAB97LXG97Hp2A9ScfArGg
         TuVA==
X-Forwarded-Encrypted: i=1; AJvYcCW/DlCp1iNdoh1bxRAKEIuv5OywZ9vsPWmxpM1T6QiltlDwjsyMrocI/CVlEsFDO3FPlH+zOck=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvMGyp9cH1Eba7/sCj1/zoUU4BiPPJAm0rse0GsA7XId57Zmt2
	zI+V7CvkkLjQs3QS3vNKj2exAWZb/1S3QM6hfzPKpneXRs1aWWiXUYdmUKrmnCjrJHuXHIeb1Jc
	MqVE2HA==
X-Received: from pjha10.prod.google.com ([2002:a17:90a:480a:b0:356:5127:89c6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:d817:b0:392:e5eb:f0d
 with SMTP id adf61e73a8af0-395c3b193bcmr4323896637.66.1772240735482; Fri, 27
 Feb 2026 17:05:35 -0800 (PST)
Date: Fri, 27 Feb 2026 17:05:34 -0800
In-Reply-To: <CAO9r8zMRkFfxm_zs88uc_ijARrU4XxHQQZAQFmC_t0H9qdbM-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260224223405.3270433-1-yosry@kernel.org> <20260224223405.3270433-17-yosry@kernel.org>
 <aaIxtBYRNCHdEvsV@google.com> <CAO9r8zMRkFfxm_zs88uc_ijARrU4XxHQQZAQFmC_t0H9qdbM-A@mail.gmail.com>
Message-ID: <aaI_XogE98GvJjAU@google.com>
Subject: Re: [PATCH v6 16/31] KVM: nSVM: Unify handling of VMRUN failures with
 proper cleanup
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220026-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 6F57C1BF9D3
X-Rspamd-Action: no action

On Fri, Feb 27, 2026, Yosry Ahmed wrote:
> On Fri, Feb 27, 2026 at 4:07=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > So after staring at this for some time, us having gone through multiple=
 attempts
> > to get things right, and this being tagged for stable@, unless I'm miss=
ing some
> > massive simplification this provides down the road, I am strongly again=
st refactoring
> > this code, and 100% against reworking things to "fix" SMM.
>=20
> For context, this patch (and others you quoted below) were a direct
> result of this discussion in v2:
> https://lore.kernel.org/kvm/aThIQzni6fC1qdgj@google.com/. I didn't
> look too closely into the SMM bug tbh I just copy/pasted that verbatim
> into the changelog.

Well fudge.  I'm sorry.  I obviously got a bit hasty with the whole svm_lea=
ve_smm()
thing.  *sigh*

> As for refactoring the code, I didn't really do it for SMM, but I
> think the code is generally cleaner with the single VMRUN failure
> path.

Except for the minor detail of being wrong :-)

And while I agree it's probably "cleaner", I think it's actually harder for
readers to understand, especially for readers that are familiar with nVMX. =
 E.g.
having a separate #VMEXIT path for consistency checks can actually be helpf=
ul,
because it highlights things that happen on #VMEXIT even when KVM hasn't st=
arted
loading L2 state.

> That being said..
>=20
> > And so for the stable@ patches, I'm also opposed to all of these:
> >
> >   KVM: nSVM: Refactor minimal #VMEXIT handling out of nested_svm_vmexit=
()
> >   KVM: nSVM: Call nested_svm_init_mmu_context() before switching to VMC=
B02
> >   KVM: nSVM: Call nested_svm_merge_msrpm() from enter_svm_guest_mode()
> >   KVM: nSVM: Make nested_svm_merge_msrpm() return an errno
> >   KVM: nSVM: Call enter_guest_mode() before switching to VMCB02
> >   KVM: nSVM: Drop nested_vmcb_check_{save/control}() wrappers
> >
> > unless they're *needed* by some later commit (I didn't look super close=
ly).
> >
> > For stable@, just fix the GIF case and move on.
>=20
> .. I am not sure if you mean dropping them completely, or dropping
> them from stable@.

My preference is to completely drop these:

  KVM: nSVM: Unify handling of VMRUN failures with proper cleanup
  KVM: nSVM: Refactor minimal #VMEXIT handling out of nested_svm_vmexit()
  KVM: nSVM: Call nested_svm_init_mmu_context() before switching to VMCB02
  KVM: nSVM: Call nested_svm_merge_msrpm() from enter_svm_guest_mode()
  KVM: nSVM: Call enter_guest_mode() before switching to VMCB02

> I am fine with dropping the stable@ tag from everything from this
> point onward, or re-ordering the patches to keep it for the missing
> consistency checks.

And then moving these to the end of the series (or at least, beyond the sta=
ble@
patches):

  KVM: nSVM: Make nested_svm_merge_msrpm() return an errno
  KVM: nSVM: Drop nested_vmcb_check_{save/control}() wrappers

> If you mean drop them completely, it's a bit of a shame because I
> think the code ends up looking much better, but I also understand
> given all the back-and-forth, and the new problem I reported recently
> that will need further refactoring to address (see my other reply to
> the same patch).

After paging more of this stuff back in (it's been a while since I looked a=
t the
equivalent nVMX flow in depth), I'm quite opposed to aiming for a unified #=
VMEXIT
path for VMRUN.  Although it might seem otherwise at times, nVMX and nSVM d=
idn't
end up with nested_vmx_load_cr3() buried toward the end of their flows pure=
ly to
make the code harder to read, there are real dependencies that need to be t=
aken
into account.

And there's also value in having similar flows for nVMX and nSVM, e.g. wher=
e most
consistency checks occur before KVM starts loading L2 state.  VMX just happ=
ens to
architecturally _require_ that, whereas with SVM it was a naturally consequ=
ence
of writing the code.

Without the unification, a minimal #VMEXIT helper doesn't make any sense, a=
nd
I don't see any strong justification for shuffling around the order.

