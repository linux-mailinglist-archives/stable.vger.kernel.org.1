Return-Path: <stable+bounces-246829-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBcjCuxnBGpVIAIAu9opvQ
	(envelope-from <stable+bounces-246829-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:00:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 270EA532AB6
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB1B53022AB4
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C77D3FF8AF;
	Wed, 13 May 2026 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="KYBhXU6S"
X-Original-To: stable@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7D938F94C;
	Wed, 13 May 2026 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673596; cv=none; b=rt5+e8IrWPAv2WS+G1iBhaV12pGAogHmokBhzdaQyqWBiZ3IlKlrWunOOP81b/+NlrBtW6eX8bc58Ied0NiECjIC7JVCUpaCwL1PZyZ8yJcTBOmPUHfGVViAgN2rS3EYx8eL31IoWezKX5KZL+KXsv/YzNikdn6YC5Wop3R/uHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673596; c=relaxed/simple;
	bh=763pFe1J8vID9eAOLiyYmWwQJg6mRSiyJJD/9SABoV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8WE7N1GGHTqEOGd3VpCae3PIr1qDYIjg2yYHuXIwz5gw0rBh0odcp8JL8cv0Gjw6iSbmFVeilZVTryWoqQKFEZv705zXV3gtyTHYPLbdPiApf8bVr/sa++uHhhXRAKuE5eymWsbhRn+ATP2IWnCkhkOh2ZeaNjN9thEdRSa7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=KYBhXU6S; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778673572;
	bh=xEH2z8WCWcgrophkMiTtUC2J3DxjG4vcq5q2behA75Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=KYBhXU6SYQ/HPkrbyis/SBstMxVHmeTRIdCwJcD3ufr+8U9ysu07zm9ZZEheoTN76
	 NQjOSnNF2/m3OZSF9/lVacVPdNAOfaebysynHDAfiI0ddsJb6C5jcawGYIZ73jW9eC
	 PkR78N+oMYTLbRSQENFTuIX6ZFuPbmhwei+sd5ow=
X-QQ-mid: zesmtpip4t1778673570t776de1df
X-QQ-Originating-IP: viOzyJ1fnQCzw4A7aaGWbCFEU/bkgfmroHrcN7wPcDI=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 May 2026 19:59:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 842056211250941492
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: chenhuacai@kernel.org,
	chenhuacai@loongson.cn,
	dave.hansen@linux.intel.com,
	kvm@vger.kernel.org,
	lixianglai@loongson.cn,
	loongarch@lists.linux.dev,
	maobibo@loongson.cn,
	ojeda@kernel.org,
	patches@lists.linux.dev,
	seanjc@google.com,
	stable@vger.kernel.org,
	zhaotianrui@loongson.cn
Subject: Re: Re: [PATCH 6.18 091/270] LoongArch: KVM: Compile switch.S directly into the kernel
Date: Wed, 13 May 2026 19:58:10 +0800
Message-Id: <20260513115810.338478-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026051319-lazily-machine-5ab3@gregkh>
References: <2026051319-lazily-machine-5ab3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N9ponxXGLTJpF01jxHgfic02HtxrEHLD4oQNYB9Dp0AZcW8oEk3+6ksn
	PjlJO2YiyLYkqdGd49R8o8JGfZQE3pgqGO+ke0d7VG8ZggfIwj4dnFtU2/nFTNGR8+mhmSf
	Y4DbCZiL3UKovPn8eISrGNfGRaxbuxzODdhMbO2Xzu8iMUNceWRGRgrJQzNLt+USbLta0IV
	iTctFuia/DaJjQgcX1gfHBMPeNh1ve4MBC47mm8t4UQs+w6v+fRwKhbZcq/Erg7PbIOXWwD
	U6Cdo6s3GCGKUED9Joh6scffUlpbzAKpOH+hEHZaG3vcUtg36DXC4ah2AeziaeRv11r1fdm
	lj+ZQbp+KuBlZXQ/kNJIQGjsrSstA4DxseFu059yumGPGWjKZMGEbRqTbbJFRaWsM9EG15q
	/5fO4vuP51FY5n8SEtwQLy036KiQD4LTJaJyWzTqa1a3Sn70c0nZa2FEKQZKgbEUIn+q7hH
	WgtVnGoS16WJsLubQtfcukm6jDn6/N69rqmoMNY7ov3VAJob5ygOdFmelWiLgjf8yH4QFe2
	Ts7nHCc8go1VIofWr856r5fR1J0EppElxNzTXkl5Z3d0VDMktvDwN4dnB99FaTWdiWX7QAe
	1vW8Vhe7d3Hmm2p2mH/gu3x1VF9qkZUoeuOgwsxuE+oq8Ybvh/HZVIejbX85p8vuVGXxwFo
	g/m/8utDm9L9OKmBVVC1+pqoqZkR9pATZIRZOUKBek01YR+2P6oQV+3+9ALMKb89/rpj0yP
	W/eFt+fSTw8kTT/tpTkurL2luL6DkhNTjKx4gnf9c5OxjStbyg+AvFCE6DCapxE8EIfDzsk
	ITsYC+rj3VYrQPqzax/jSTYoeFhmC1fJ43L6nTBqSVoM/ENvww/DLvOv4iDPcltmPsqWRAW
	CSuR3xfQR9scM1A1ob5DuMjPItc6dsLtlRxoOwbEkMPtQ0kJuYXoEnr+mI/BIVu9urIzDFK
	UKfiku/qTTBULU2sZxR09SqP9hDy+b1xcrlmobg2zjMRpkt/nQ9nkxX59iu/Jn6tV9oq38L
	WFBt6htv4I3Hzo5jypDB5U8+wIJ/0tmkM2VR+9VjFY4kCiTFFqq0yplyq6dk/YgJdBS/L4P
	w==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 270EA532AB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246829-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[uniontech.com:query timed out];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uniontech.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[seanjc.google.com:query timed out,lixianglai.loongson.cn:query timed out,stable-commits.vger.kernel.org:query timed out];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

Hello,

> On Wed, May 13, 2026 at 11:06:20AM +0800, Huacai Chen wrote:
> > On Wed, May 13, 2026 at 5:53 AM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Tue, May 12, 2026, Miguel Ojeda wrote:
> > > > On Tue, 12 May 2026 19:38:12 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > 6.18-stable review patch.  If anyone has any objections, please let me know.
> > > > >
> > > > > ------------------
> > > > >
> > > > > From: Xianglai Li <lixianglai@loongson.cn>
> > > > >
> > > > > commit 5203012fa6045aac4b69d4e7c212e16dcf38ef10 upstream.
> > > > >
> > > > > If we directly compile the switch.S file into the kernel, the address of
> > > > > the kvm_exc_entry function will definitely be within the DMW memory area.
> > > > > Therefore, we will no longer need to perform a copy relocation of the
> > > > > kvm_exc_entry.
> > > > >
> > > > > So this patch compiles switch.S directly into the kernel, and then remove
> > > > > the copy relocation execution logic for the kvm_exc_entry function.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > > > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > For loongarch64, I am seeing a bunch of errors like:
> > > >
> > > >     arch/loongarch/kvm/switch.S:201:1: error: unrecognized instruction mnemonic
> > > >     EXPORT_SYMBOL_FOR_KVM(kvm_exc_entry)
> > > >     ^
> > > >
> > > > `EXPORT_SYMBOL_FOR_KVM` does not exist in 6.18. Does this need a subset
> > > > of commit 6276c67f2bc4 ("x86: Restrict KVM-induced symbol exports to KVM
> > > > modules where obvious/possible")?
> > >
> > > Either that or just convert EXPORT_SYMBOL_FOR_KVM() => EXPORT_SYMBOL_GPL().  If
> > > that's somewhat scriptable for ongoing LTS backports, that's probably the best
> > > option.  EXPORT_SYMBOL_FOR_KVM() will only work for 6.18, and the list of backports
> > > needed to get EXPORT_SYMBOL_FOR_MODULES() working on older LTS kernels looks to
> > > be non-trivial
> > >
> > > If we do end up backporting EXPORT_SYMBOL_FOR_KVM() and others, we might as well
> > > also grab a subset of 01122b89361e ("perf: Use EXPORT_SYMBOL_FOR_KVM() for the
> > > mediated APIs") to ensure a kvm_types.h stub is present on all archs.  That way
> > > EXPORT_SYMBOL_FOR_KVM() usage in arch-neutral code will also work.
> > I have already noticed Greg about this before.
> 
> You did?  Where?

Small problem, I guess where he means is 'stable-commits@vger.kernel.org', is a
not public maillist? I want to find it in 'lore.kernel.org' but not found... 

BRs
Wentao Guan

