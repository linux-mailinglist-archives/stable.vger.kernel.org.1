Return-Path: <stable+bounces-146129-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF69EAC15E5
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 23:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F161C01ED7
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A69255E44;
	Thu, 22 May 2025 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cSPTsnH5"
X-Original-To: stable@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDCB22D788;
	Thu, 22 May 2025 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747949354; cv=none; b=EFXWnYO8KUlxCL5imNNwXJc5Zu9XsZTCd0hdpTTaCiSPuh1Ui08+nuMHfHgldOtwVlIKigj+Kw8z/csYhDw7lGrCNs5GHMvyHlYSrPwlvD/uY/0PZWV50PNRnilsjftFxKATE7JPBelRwo1Wzbcjdc96B/UnsWOUGPW47lvpUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747949354; c=relaxed/simple;
	bh=zdPxR06ppayegAssCii2AxEnkx2Hak7nMSIuogt/s+0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Xs2b4c1tEaQauhJLApaWfJhLMIAYF1uOH00N6Bc/S77C6Kn1g4bFkNPDtVXzBUbqzy8ygsFDUgg/iWghDCTPq+fmUiYC8JKYvBAWiprIi7fVxw5F9//uCB1Y6cb5idjdErjhNI677RL403DodcUkDMM/x+5bdoBiO4tOEHL1bPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=cSPTsnH5; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 54MLSaqD3162460
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 22 May 2025 14:28:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 54MLSaqD3162460
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025042001; t=1747949317;
	bh=zdPxR06ppayegAssCii2AxEnkx2Hak7nMSIuogt/s+0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=cSPTsnH5mvjPqEqTQb0UyVDTQGXW2XDF667XtVmGL+CdoU+ESrqAJbOwB0L0LW79G
	 IsaRO9PQqo/bb7Umizhhx/aCPH1qvhUmbbzR8CMRcN+my1rE5j9EUHc3+Oz/fQOP+l
	 NsAs/jRYS8HsYAYIH5+lcZpJQ/CQ/fh4X3Yd5MJaEkXvuqkK4bnxs+4IR/Owk19VFA
	 PyTluQrqPz8go68aETiFVSlroGH9dXWL+wNIJYxrRIqj9S36WyN273/rw04nitoisD
	 ke7f1xxkXQMuUU0Z00qeTzZ9sZzdbmrlt2sNpalS9PStaWTrUcN9H3QOtFhedfrWRQ
	 8LwS4DroGMj8Q==
Date: Thu, 22 May 2025 14:28:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        Dave Hansen <dave.hansen@intel.com>, "Xin Li (Intel)" <xin@zytor.com>,
        linux-kernel@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, peterz@infradead.org,
        stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/1=5D_x86/fred/signal=3A_Pr?=
 =?US-ASCII?Q?event_single-step_upon_ERETU_completion?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ad8d3a12-25f3-4d57-8f34-950b7967f92b@citrix.com>
References: <20250522171754.3082061-1-xin@zytor.com> <e4f1120b-0bff-4f01-8fe7-5e394a254020@intel.com> <ad8d3a12-25f3-4d57-8f34-950b7967f92b@citrix.com>
Message-ID: <3D4D48D6-D6E7-4391-8DCF-6B9D307FE2E2@zytor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 22, 2025 10:53:16 AM PDT, Andrew Cooper <andrew=2Ecooper3@citrix=2Ec=
om> wrote:
>On 22/05/2025 6:22 pm, Dave Hansen wrote:
>> On 5/22/25 10:17, Xin Li (Intel) wrote:
>>> Clear the software event flag in the augmented SS to prevent infinite
>>> SIGTRAP handler loop if TF is used without an external debugger=2E
>> Do you have a test case for this? It seems like the kind of thing we'd
>> want in selftests/=2E
>
>Hmm=2E
>
>This was a behaviour intentionally changed in FRED so traps wouldn't get
>lost if an exception where to occur=2E
>
>What precise case is triggering this?
>
>~Andrew

SIGTRAP =E2=86=92 sigreturn=2E Basically, we have to uplevel the suppressi=
on behavior to the kernel (where it belongs) instead of doing it at the ISA=
 level=2E=20

