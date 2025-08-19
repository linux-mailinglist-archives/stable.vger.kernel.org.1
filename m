Return-Path: <stable+bounces-171761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0861AB2BED2
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD2CD580AAE
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489173451D2;
	Tue, 19 Aug 2025 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="tmWlCzrD"
X-Original-To: stable@vger.kernel.org
Received: from fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com [35.158.23.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77761990C7
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.158.23.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598926; cv=none; b=MXu+74NfgUiWCxW3zlyCY6IEH8b3Zm9q7VqiYHBgEpWMm6DmLel8JFBBpPVg+zZdtCDgmjWGhsrCNNtNfHJqFjCHbfkx76pHoMe1Hii3DMGnfidwlBcxKHuoINw/ftsb0icVZIkaP3FTLpDb1jw/HDHRv4wHepxKNFpYr4JQ/Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598926; c=relaxed/simple;
	bh=H3fbdn0WdQ8v+DSmTMpZgyYyuUWlc0KwtUfiWqboR4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TC0s/D1+/ZjR5zCGUIkbCwCWCgS8CtoB4Hxvau3jaObDKJ1KCW0zURfavgc0b9mcOx6EYrk80qEuMl3rUPJjvTJC1ucjt2Tuaf/4XPXtrwZqZoOl9T/VJG7r0beHn2uM/u+mU1KwASBLUDad7sWrT2fIAvb2paC4ngoMpudu1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=tmWlCzrD; arc=none smtp.client-ip=35.158.23.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazoncorp2; t=1755598920; x=1787134920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4PCZDD3jiTlv1z2RcA2+TmPPfqE8eMPgF2O4m90zJHw=;
  b=tmWlCzrDz00HTaPymPjRKkzVc6lEKiq/M6oUrJ22mFZsBIPJVdmQRGry
   S+5SvNWk30yazvZKvAYNeG4r0OUUPFvWDKZaitwNvSXTIO7XMBdLR5BpC
   E+I7VFrP0g7g6NfC6LL1SpHqNzSNMuP4IiTutHuuNf1K94YxzZa1laj4w
   Y47Bpd6SwMe84krkvLIbG31Bt2zR2Lj1pPUoj/GyTw5Ql9GL/jmYQr1PE
   Lpa0GI23RozCYRTOBGcPaSnsDVHh2kcXlc+kwLGa7TssF5SeieT/oR5Uy
   rSWUJjK8g3f5JXcLtQbUsxooDvkr9S1fy3vcwgmXCaloQNNlj3r+ExmBO
   A==;
X-CSE-ConnectionGUID: /IRzR/SARNuW5QZ7S5FVXw==
X-CSE-MsgGUID: Vx/P34bxSteibQWYQ6fFAw==
X-IronPort-AV: E=Sophos;i="6.17,300,1747699200"; 
   d="scan'208";a="921280"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-west-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-008.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 10:21:49 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:38088]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.38.98:2525] with esmtp (Farcaster)
 id 5318b917-0210-4206-b71b-a4a5cc1d0a4c; Tue, 19 Aug 2025 10:21:49 +0000 (UTC)
X-Farcaster-Flow-ID: 5318b917-0210-4206-b71b-a4a5cc1d0a4c
Received: from EX19D015EUB003.ant.amazon.com (10.252.51.113) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 19 Aug 2025 10:21:47 +0000
Received: from EX19D015EUB004.ant.amazon.com (10.252.51.13) by
 EX19D015EUB003.ant.amazon.com (10.252.51.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 19 Aug 2025 10:21:46 +0000
Received: from EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a]) by
 EX19D015EUB004.ant.amazon.com ([fe80::2dc9:7aa9:9cd3:fc8a%3]) with mapi id
 15.02.2562.017; Tue, 19 Aug 2025 10:21:46 +0000
From: "Roy, Patrick" <roypat@amazon.co.uk>
To: "Roy, Patrick" <roypat@amazon.co.uk>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "tangnianyao@huawei.com"
	<tangnianyao@huawei.com>
Subject: Re: [PATCH 6.1.y] arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits
 in ID_AA64MMFR1 register
Thread-Topic: [PATCH 6.1.y] arm64/cpufeatures/kvm: Add ARMv8.9 FEAT_ECBHB bits
 in ID_AA64MMFR1 register
Thread-Index: AQHcAUBONQXj/76f20GQvs41XuzDE7Rp45+A
Date: Tue, 19 Aug 2025 10:21:46 +0000
Message-ID: <20250819102145.10768-1-roypat@amazon.co.uk>
References: <20250730105417.18254-1-roypat@amazon.co.uk>
In-Reply-To: <20250730105417.18254-1-roypat@amazon.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-30 at 11:54 +0100, "Roy, Patrick" wrote:=0A=
> From: Nianyao Tang <tangnianyao@huawei.com>=0A=
> =0A=
> [ upstream commit e8cde32f111f7f5681a7bad3ec747e9e697569a9 ]=0A=
> =0A=
> Enable ECBHB bits in ID_AA64MMFR1 register as per ARM DDI 0487K.a=0A=
> specification.=0A=
> =0A=
> When guest OS read ID_AA64MMFR1_EL1, kvm emulate this reg using=0A=
> ftr_id_aa64mmfr1 and always return ID_AA64MMFR1_EL1.ECBHB=3D0 to guest.=
=0A=
> It results in guest syscall jump to tramp ventry, which is not needed=0A=
> in implementation with ID_AA64MMFR1_EL1.ECBHB=3D1.=0A=
> Let's make the guest syscall process the same as the host.=0A=
> =0A=
> This fixes performance regressions introduced by commit a53b3599d9bf=0A=
> ("arm64: errata: Add newer ARM cores to the spectre_bhb_loop_affected()=
=0A=
> lists") for guests running on neoverse v2 hardware, which supports=0A=
> ECBHB.=0A=
> =0A=
> Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>=0A=
> Link: https://lore.kernel.org/r/20240611122049.2758600-1-tangnianyao@huaw=
ei.com=0A=
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>=0A=
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>=0A=
> ---=0A=
>  arch/arm64/kernel/cpufeature.c | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeatur=
e.c=0A=
> index 840cc48b5147..5d2322eeee47 100644=0A=
> --- a/arch/arm64/kernel/cpufeature.c=0A=
> +++ b/arch/arm64/kernel/cpufeature.c=0A=
> @@ -343,6 +343,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr0[]=
 =3D {=0A=
>  };=0A=
>  =0A=
>  static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] =3D {=0A=
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1=
_ECBHB_SHIFT, 4, 0),=0A=
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_=
EL1_TIDCP1_SHIFT, 4, 0),=0A=
>  	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL=
1_AFP_SHIFT, 4, 0),=0A=
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_EL1=
_ETS_SHIFT, 4, 0),=0A=
=0A=
Hi Greg,=0A=
=0A=
Friendly ping on this one? I saw 6.1.148 got released but this didn't get=
=0A=
picked up (but you grabbed the 6.6 backport of the same commit during the l=
ast=0A=
cycle). Did I mess something up with the backport process?=0A=
=0A=
Best,=0A=
Patrick=0A=

