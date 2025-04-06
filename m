Return-Path: <stable+bounces-128415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3648EA7CD84
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 11:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DAC174F18
	for <lists+stable@lfdr.de>; Sun,  6 Apr 2025 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63319D07C;
	Sun,  6 Apr 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqcACIBK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6214D2A0;
	Sun,  6 Apr 2025 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743932816; cv=none; b=gJoY2Il8T7QARXcEHUjkgunMri1CCUYchpRpnb0be9nmQifSs0Gtc0r5LesfQY516zVymEuuoVWE009MVMYPjzYuWzBP6Ueteme+mFwDKPOtrGi+DsAF7xGr/+yyxjcqYSTMrOOJxVHicTlDGPHUkhrEJCURxeY0OJM7K9FhH6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743932816; c=relaxed/simple;
	bh=MzU98WVndeQLX8uu0mheW8QCkJcKR2vzd4DXiU4pRMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVneeX0sN/iKuYUwK75KJx5BjhUpJRtl2rg07jVxblwbGHutIz1oSPWVCg/AeR2XZ1J9InBs/PZAs/hX6/DERTd9UTpLWIiFNt6l5Svtxe+M/WD2WjfV22jB/fZ1ab77tiKB0BVpumDdWfgJszHoOA4LssDplzY/LAP+pOPzV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqcACIBK; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac298c8fa50so573556766b.1;
        Sun, 06 Apr 2025 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743932813; x=1744537613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQ5KcV6b2T7SBZC70etncna4BQfvzILzKvR1JLokorg=;
        b=CqcACIBKupnKZpNInFvalZ7JXt3BjCwH94yHoR/h/NBWr3caOVj/Mzl9kyse3pjt7j
         VaiGS0gQi7eQIGYpqUL7iUhuYMqtf7ayfiPqc2FHd+tVJCmd51DgWDU5C00t5tiy2ihj
         8YyrlfbMd7PmMXO7xZkYHHztZ/5Wu59wKuU2kPugyjufb5LC5QL+5/dndfVRGhVb+ARk
         1YsWT4vmFjKGJshW930aRGUifZtuRtyjX1hxhfzngn/ZxnS/1fNWMS4Yjiug0RoG6g6+
         p8UFBplCi/QV8dyPMZtzZYmBkn4IBVN4BA6qVFN1ZjeNpdpeT+d3xRsOi7/93YUQXn/m
         QDJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743932813; x=1744537613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQ5KcV6b2T7SBZC70etncna4BQfvzILzKvR1JLokorg=;
        b=Lc1L8rVRw+dOj5BDuHDrB/ptNkFq1r6aYuGwpDtvwmOVloj0FqqnDXeyMJMRjym7Ru
         Z955l9o98h8JL3eYKaYq7bxB1FwLzRcSq4KEgmMh8BXuTtf37maT1Hu5oXepuIVw7lve
         gX7IRdTvnPtxFXjd1dKhot0d9iRXtJbCYAEt9Fbxkdk+Nq+n44T18PBb+3w+EEPkwUv3
         r5jWfj6YjQBTN4Ca/fhwrdNgbsWOyiREKbv6KFcJSWW12ynBFbXNJRm+pvBVo4c3t7Ey
         iP0JOuqXv8zahGXQUThEtczM3RgYXd+pqj3qAtOXqBpbmziBDOuBWz6RZ9bGGsEeCDdJ
         YcOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQv4FFrR+Qxnkc2bntSsxMkxXgS5SAljV7IikUVcX74zF3i3MdRMdBkzo95Ha8DmDhDCuNb407/HNtK7Y=@vger.kernel.org, AJvYcCVRK08AvfPxR1b8uSpn16W3eRt9O1CidJXbzZPP4+Wjf8t1l695TOhxBYpNPPi79RSqWTUzKuOx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7sFlrFP9k4nhIFmwHd/si0doEsh6j9+zhMKHJZLC/GVMD3cY5
	A1lYGqNgCJqCu4X7cU76D8cAuo3R1/Gqvio+LX4+UdlfXiYkiHo7Rddaa32BsyQlP5LS44NIk46
	cgZQGHrvfGvUrKme31Qb8EG1aLKE=
X-Gm-Gg: ASbGncvpBHMTp0eji6fFGlJnSj6UhoD2i2UuJqRGoEHaEKmpVTHxeTVC9CPm9TWjMX9
	Pw2/DA5pJgsh23XPSXqpNfWfXTB//PUx996EkkX5Tr0zoVUMc7zTLU0+wr3DyMxa8nTWH5MXaYQ
	1AWcCKgk0RyxgjaP0kwVaOszYLB/fg
X-Google-Smtp-Source: AGHT+IE+eHm4l67vCbDvHozk2ou/wNvkCdLxpPfZsBIEdy3dp+Diuf52eSKNj4usIndB9jkEHkYtCvUenVFfy7BkPwY=
X-Received: by 2002:a17:907:988:b0:ac7:31a4:d4e9 with SMTP id
 a640c23a62f3a-ac7d16bc089mr941079866b.4.1743932812879; Sun, 06 Apr 2025
 02:46:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402092500.514305-1-chenhuacai@loongson.cn> <87jz81uty3.ffs@tglx>
In-Reply-To: <87jz81uty3.ffs@tglx>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Sun, 6 Apr 2025 17:46:45 +0800
X-Gm-Features: ATxdqUEX8mja4RttrRUq-FhWIoVMgkwqM61JDoRBejrnMEqRJw0aI0NuPgefasI
Message-ID: <CAAhV-H5sO0x1EkWks5QZ8ah-stB7JbDk6eFFeeonXD6JT9fHAw@mail.gmail.com>
Subject: Re: [PATCH] irqchip/loongson-liointc: Support to set IRQ_TYPE_EDGE_BOTH
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Huacai Chen <chenhuacai@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org, 
	Yinbo Zhu <zhuyinbo@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Thomas,

On Thu, Apr 3, 2025 at 11:48=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Wed, Apr 02 2025 at 17:25, Huacai Chen wrote:
> > Some peripheral subsystems request IRQ_TYPE_EDGE_BOTH interrupt type an=
d
> > report request failures on LIOINTC. To avoid such failures we support t=
o
> > set IRQ_TYPE_EDGE_BOTH type on LIOINTC, by setting LIOINTC_REG_INTC_EDG=
E
> > to true and keep LIOINTC_REG_INTC_POL as is.
>
> That's broken because it will either trigger on the rising or the
> falling edge depending on the setting of LIOINTC_REG_INTC_POL.
Yes, this patch does exactly this.

>
> But it won't trigger on both. So no, you cannot claim that this fixes
> anything.
Yes, it won't trigger on both (not perfect), but it allows drivers
that request "both" work (better than fail to request), and there are
other irqchip drivers that do similar things.

For example,

drivers/irqchip/irq-mips-gic.c
        case IRQ_TYPE_EDGE_BOTH:
                pol =3D 0; /* Doesn't matter */
                trig =3D GIC_TRIG_EDGE;
                dual =3D GIC_DUAL_DUAL;
                break;

drivers/irqchip/irq-qcom-mpm.c
        if (type & IRQ_TYPE_EDGE_BOTH)
                type =3D IRQ_TYPE_EDGE_RISING;

 Huacai

>
> Thanks,
>
>         tglx

