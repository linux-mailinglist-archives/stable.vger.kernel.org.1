Return-Path: <stable+bounces-95738-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2EC9DBB05
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 17:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95879282109
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 16:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329CE1BD9E3;
	Thu, 28 Nov 2024 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpSiXgor"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F81BBBFC;
	Thu, 28 Nov 2024 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810134; cv=none; b=HCTiXqsKWh+/gLxpZSPu/UjIyVBAMNOjR8EAMLtLRY5FgTUMa6OdTIP/17Q+eFWWLKHi0lNffVmcmjX1FG0IwVxvsawEFqnNi/Q33uuAry7LGDG5UEsDU6q1llvd82wMNhfM+oa16AcsfRj0R/GL/hMYXqEtgKXJKZCVpduFV1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810134; c=relaxed/simple;
	bh=cHvhH9W6PIpl43TfXtdJRjy7sDy3NHgdYsKGq5MC2II=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7G4d38nhqaYM7qB4ucGQ9o3B0zEXUVFLh5KonjQiYpbziAbw/qzs+r42vP+DSzdqJ1VWR5df/T26MTwFAbMTfy3/Ik8hlRR2mQRJSGaD+YyHuHBgAksY+vx/OaMEg9avlRDgy99VEaLf26ZL2xJN1uIqwEVpt6syuiyC0qQGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpSiXgor; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b1601e853eso72226985a.2;
        Thu, 28 Nov 2024 08:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732810131; x=1733414931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHvhH9W6PIpl43TfXtdJRjy7sDy3NHgdYsKGq5MC2II=;
        b=UpSiXgorgHaNaVs/P85+FplCuD9q4LGTn+zI6Efld27yLBdbrMesMuEor4vuyBDsxQ
         n458ated+C/jDuCLOmM1H/BdHR8rCOgExJv+HHvTefL81vENoAr0gg64HaYlOqpzwHyZ
         syiNM+BjzxKqQHnk6w1CaqmEZDgeWthQDwvdEXYFE8xbevq2axkTY9oCOcjQkGjwq0EF
         zGezBWUfOGkUGA/hTNPigYRQ9JGDn44LJeMrpYgGUSKdlo7BKxcb4qwPYpeenK+gKTx5
         X+re77AfIU9eMJfVINFNPlZPZ22g7leZrsv32hnXrlnrKHpCPKdX1VmM1lFXxrz67LfS
         YHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732810131; x=1733414931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHvhH9W6PIpl43TfXtdJRjy7sDy3NHgdYsKGq5MC2II=;
        b=ZJiGRcvuw7zQz9JdaYW24IekknlhJYb971znu4MfA9iWPi/TDqwfxhbSACCqa0Ghn9
         +tIuxJfZYQozMbsFWJ3OKux7xLF48TSYKlyIVB5AeZHA/uf7PGiUvDprCyahA4y/qRbq
         a7WN/OCjn8VaJDHZafyxUzhJnviL05UjzPNvUJhBwJxHMdNnuKOODhDqUOedQj89BMlv
         ulTOn2KYi8HE4WCWA7vmaO9JkSjjh1v9dQF/5GfhWGlSCiuThvOh8oV/tBWR6XzB0nam
         Qp6mXuDw+pmE6RFnwc/9lg86VttHeenF+Uig3E7SqAWSZw1+Jn7SerxpVO9Swpc64X6N
         9q2A==
X-Forwarded-Encrypted: i=1; AJvYcCUleVL7IDpXte2o81I+rEVBmOdMru/ccaf2lz+t4Kno8iZUcy9HMmPYObYp3d72giyyHquuB7jp@vger.kernel.org, AJvYcCXW13NJ2ngeaHJf2BXwgN3wPKi0FMdLrdDM2BVdL2B2yoYO+6QqVyX+jrlod68KwpVN195oiEgmx/G6Lyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+kT957ibJPxS7q/57OdNU78lBeYeHxOxqi9fHZ6lgdKKVaEZ
	z+LkA+H6Mgq7PZAF0saKEPBMYtGy1dUJnDFh4kqS/znVm+g5EgYwosvA6gwVM0APL+xC5ZRylGf
	vVB7iByaYJ/1r7l14TAVNgGtg5ME=
X-Gm-Gg: ASbGncuCRThB8KZhB6oDrD8D+KNaWMpCdGZzFzg/+Dzpz2hgTi/DJyz6p3crgcwlqj7
	XUtPCrZZichRnGeV9D+uK+E5diOMEJcFNm8pxmFYcrW34uWE3oCHr7rCoF7+e+wk=
X-Google-Smtp-Source: AGHT+IFDn0sg78d2K5Y8L/ks5X4Mv0VXCbUDL/EGaXlZiyLyMZaCnWCK645fWj82LBjriY2fbz0RV3sPH4HA0CftzNI=
X-Received: by 2002:a05:620a:4508:b0:7b6:66d0:5ab6 with SMTP id
 af79cd13be357-7b67c463addmr802630985a.51.1732810131251; Thu, 28 Nov 2024
 08:08:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115232718.209642-1-sashal@kernel.org> <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local> <Z0iRzPpGvpeYzA4H@sashalap>
In-Reply-To: <Z0iRzPpGvpeYzA4H@sashalap>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Thu, 28 Nov 2024 17:08:40 +0100
Message-ID: <CAL2JzuzTnQkKGkVQ9HwCHsVAtCk9Z=iniXm0uMgi3ZnODyfC3A@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
To: Sasha Levin <sashal@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com, 
	x86@kernel.org, puwen@hygon.cn, seanjc@google.com, kim.phillips@amd.com, 
	jmattson@google.com, babu.moger@amd.com, peterz@infradead.org, 
	rick.p.edgecombe@intel.com, brgerst@gmail.com, ashok.raj@intel.com, 
	mjguzik@gmail.com, jpoimboe@kernel.org, nik.borisov@suse.com, aik@amd.com, 
	vegard.nossum@oracle.com, daniel.sneddon@linux.intel.com, acdunlap@google.com, 
	pavel@denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

But it was backported on 6.6 and the performance impact is pretty high
on some workloads.
As this patch is only providing a perf benefit and to keep consistency
with other stable kernels, would it be possible to get it merged ?

Le jeu. 28 nov. 2024 =C3=A0 16:52, Sasha Levin <sashal@kernel.org> a =C3=A9=
crit :
>
> On Thu, Nov 28, 2024 at 12:59:24PM +0100, Borislav Petkov wrote:
> >Hey folks,
> >
> >On Mon, Jan 15, 2024 at 06:26:56PM -0500, Sasha Levin wrote:
> >> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> >>
> >> [ Upstream commit 04c3024560d3a14acd18d0a51a1d0a89d29b7eb5 ]
> >>
> >> AMD does not have the requirement for a synchronization barrier when
> >> acccessing a certain group of MSRs. Do not incur that unnecessary
> >> penalty there.
> >
> >Erwan just mentioned that this one is not in 6.1 and in 5.15. And I have=
 mails
> >about it getting picked up by AUTOSEL.
> >
> >Did the AI reconsider in the meantime?
>
> You've missed the 5.10 mail :)
>
> Pavel objected to it so I've dropped it: https://lore.kernel.org/all/Zbli=
7QIGVFT8EtO4@sashalap/
>
> --
> Thanks,
> Sasha

