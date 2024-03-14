Return-Path: <stable+bounces-28128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FEF87BA5B
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 10:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 179DC287200
	for <lists+stable@lfdr.de>; Thu, 14 Mar 2024 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9A6CDCF;
	Thu, 14 Mar 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d8Ddl84k"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF46CDD4
	for <stable@vger.kernel.org>; Thu, 14 Mar 2024 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408347; cv=none; b=RHnPIT7WFjTEf0zOyP2CMqWA4t1sWentRKMowyGOVbZEN9jjSeLuz9rFdkwAgi1CmHeqdZrOpcPRUG3sTr4RyF0O44HIml1TY2cx0QtAFUOdXzgy4AfXjzAi4aKwrGsBqsNxbn+IAECwo13VjRrPbugCjj1nFzmnNqiptnjJ2SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408347; c=relaxed/simple;
	bh=zAq7B127SJlJg80NOehyDIikyu1/dR36D90cGWogZtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FL8XT+0NOdfalzVb2XH0BJtvoroFViqUdtMkyUi7ge3iqRd74+2Dh0zCcK/s1/Jm5kS3xvm8HOTW7MSlSRQZ9Kt5AP+mBBUgjiH7EDNi1fEL5hnFls3qcgNTabSg3ZRY5qBTEXb1hEH8begf3tO/uq/ggv/JfSbalkapzQ+rcyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d8Ddl84k; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710408344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rl/H4MWGLgmEqfgbk+kWHokXGlfem4Ht/IF+GTQnQp4=;
	b=d8Ddl84k5J1BmnlY2kK1d+OX4izryqGA8auStABY7L50u9XL2kVbhiumAmuUGnwsxN17Up
	h7N2ecnkj1B50G6iPamC1ZeP03wKgWcv0TXVNnaiddO2Dd0KTztqV0j+0h8oxQOdV1Rse6
	gPnv0wmtS4TN3JpiQpdNv+2ISjDEFkc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-F8nAEvtDN9-6nEACVPDXzQ-1; Thu, 14 Mar 2024 05:25:42 -0400
X-MC-Unique: F8nAEvtDN9-6nEACVPDXzQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36678ae539dso2670895ab.1
        for <stable@vger.kernel.org>; Thu, 14 Mar 2024 02:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408342; x=1711013142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rl/H4MWGLgmEqfgbk+kWHokXGlfem4Ht/IF+GTQnQp4=;
        b=TStS1hbD6Xi2kEsLODFHmwpTjcVnRv9tQX7ECTr/52G9Yue0EPS4hYsboR6J/vP+R2
         Dfe+yrTenOn4sInUT5bKxESv+94qzVFEfLSKW243bl7vgYSEFSYNX6csZhzYAKw93h72
         0qonSOyoYXY2ylcfn1ZuSG0ePlMMqJW4N2PHvYZq1DiwGO5boFyXBlafVy6D9kH+yICJ
         zjKQ+Zb9o+4MOm5QLiBXqs/RGRvoO9hw9E+og6Uuwy40K7jGyQihzP31b1EyUeQf9OoK
         wCdNyj+PF1FcefN+1XKKHyz5KVhxskhSFU/TFjYsIireYjIT1I0k4vWtRcRZp0UyDlTH
         JIQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYcD9DiGHuxEW66VEmUAKzeGgnAOVNIuFbmLGqtwoIn5pUPMlc1lC/dlz2jU43/+sAbYIOyFNJbSzs8TlrU8UZpAt2jo2x
X-Gm-Message-State: AOJu0YzWSvGBk4hdV9aIhxkkibNuTddbqpUIHRXY/9dsAIXJLCv5nNfE
	hCThNTlPw9iTHpTinn39bEmLHKHzEVHiyFHde7KzQ7fKujrCFGkKykA07hz5H1/sd3umb6ozMbR
	PIOmehsMflV662cDi6I0Ctg9Qni16GhU5COEkoeUGiltzLFVtfUiLZl2oetqmBpPasBo7vqwKUI
	zSvqYUuxlnXNy108iL0krdX+uECGp7
X-Received: by 2002:a92:de44:0:b0:365:4e45:33ad with SMTP id e4-20020a92de44000000b003654e4533admr935896ilr.1.1710408342158;
        Thu, 14 Mar 2024 02:25:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW8ilRYhJOkTU999SkD7mYGv+S2pTq79uG4Gtss8uUESu2wfnl2F8tti+O0WDSOfuRxxW4k70RHgq5g5PMV/g=
X-Received: by 2002:a92:de44:0:b0:365:4e45:33ad with SMTP id
 e4-20020a92de44000000b003654e4533admr935892ilr.1.1710408341845; Thu, 14 Mar
 2024 02:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJbxNHe3EJ88ABB1aZ8bYZq=a36F0TFST1Fqu4fkugvyU_fjhw@mail.gmail.com>
 <ZensTNC72DJeaYMo@swahl-home.5wahls.com> <CAJbxNHfPHpbzRwfuFw6j7SxR1OsgBH2VJFPnchBHTtRueJna4A@mail.gmail.com>
 <ZfBxIykq3LwPq34M@swahl-home.5wahls.com> <42e3e931-2883-4faf-8a15-2d7660120381@pavinjoseph.com>
 <ZfDQ3j6lOf9xgC04@swahl-home.5wahls.com> <87cyryxr6w.fsf@email.froward.int.ebiederm.org>
 <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
In-Reply-To: <ZfHRsL4XYrBQctdu@swahl-home.5wahls.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 14 Mar 2024 17:25:52 +0800
Message-ID: <CALu+AoSZhUm_JuHf-KuhoQp-S31XFE=GfKUe6jR8MuPy4oQiFw@mail.gmail.com>
Subject: Re: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
To: Steve Wahl <steve.wahl@hpe.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Pavin Joseph <me@pavinjoseph.com>, 
	Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, 
	Eric Hagberg <ehagberg@gmail.com>, dave.hansen@linux.intel.com, 
	regressions@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 00:18, Steve Wahl <steve.wahl@hpe.com> wrote:
>
> On Wed, Mar 13, 2024 at 07:16:23AM -0500, Eric W. Biederman wrote:
> >
> > Kexec happens on identity mapped page tables.
> >
> > The files of interest are machine_kexec_64.c and relocate_kernel_64.S
> >
> > I suspect either the building of the identity mappged page table in
> > machine_kexec_prepare, or the switching to the page table in
> > identity_mapped in relocate_kernel_64.S is where something goes wrong.
> >
> > Probably in kernel_ident_mapping_init as that code is directly used
> > to build the identity mapped page tables.
> >
> > Hmm.
> >
> > Your change is commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only
> > where full GB page should be mapped.")
>
> Yeah, sorry, I accidentally used the stable cherry-pick commit id that
> Pavin Joseph found with his bisect results.
>
> > Given the simplicity of that change itself my guess is that somewhere in
> > the first 1Gb there are pages that needed to be mapped like the idt at 0
> > that are not getting mapped.
>
> ...
>
> > It might be worth setting up early printk on some of these systems
> > and seeing if the failure is in early boot up of the new kernel (that is
> > using kexec supplied identity mapped pages) rather than in kexec per-se.
> >
> > But that is just my guess at the moment.
>
> Thanks for the input.  I was thinking in terms of running out of
> memory somewhere because we're using more page table entries than we
> used to.  But you've got me thinking that maybe some necessary region
> is not explicitly requested to be placed in the identity map, but is
> by luck included in the rounding errors when we use gbpages.

Yes, it is possible. Here is an example case:
http://lists.infradead.org/pipermail/kexec/2023-June/027301.html
Final change was to avoid doing AMD things on Intel platform, but the
mapping code is still not fixed in a good way.

>
> At any rate, since I am still unable to reproduce this for myself, I
> am going to contact Pavin Joseph off-list and see if he's willing to
> do a few debugging kernel steps for me and send me the results, to see
> if I can get this figured out.  (I believe trimming the CC list and/or
> going private is usually frowned upon for the LKML, but I think this
> is appropriate as it only adds noise for the rest.  Let me know if I'm
> wrong.)
>
> Thank you.
>
> --> Steve Wahl
>
> --
> Steve Wahl, Hewlett Packard Enterprise
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


