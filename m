Return-Path: <stable+bounces-235581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKx+Ir+v2GljgwgAu9opvQ
	(envelope-from <stable+bounces-235581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:07:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D95DA3D3C43
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F05CB301588F
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202093537D5;
	Fri, 10 Apr 2026 08:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzjJQNU6"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAA39F162
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808105; cv=pass; b=dru4vlC8TSvea557DvxHHUy+umnlYayy+qAkjnkzz2Vzc+manbcw+Er32F4Uy+St4Hcw6NnAU8Gyt4+Kvlkd9cVcoaK90MeLeuyUIkFj2g2Zgp2VbVFoGpG4MDBZd7OS29S5NYm6qTEfTSL5Tj5xsR6BLTAM67v72U88hIpJyRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808105; c=relaxed/simple;
	bh=/Yc6vgah8TkpPGbCjR8i99D6TDxMyPvwt8bh/TWD1+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEk8tnIm8bBfPLr6bGerO5M4pIHlM61KwBZdWgWqA82SrTGxLkFGGAoALvOhZ+pAGw4g1J0YPqFM3EAPKfYwhNgjHeaHSUqvIisLww89YVQacrLJ/pjAnVmAdvzud8QrKdB4iC195ceDZAyqlC8KNs0aLoF8d3nPdJODKpaAFdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qzjJQNU6; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50d7e434c81so763981cf.1
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 01:01:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775808103; cv=none;
        d=google.com; s=arc-20240605;
        b=CzVfuhwc3A5pe2rOnUbEkg8GRzZHul7lDRlftmHCsxrEdc+ffM1NrTfYmQUdV4mqak
         JglF0dM8YBqCSyxiyDy6o1akAYqM0oUuGQMdPBvkv8U5uqg6LG+Cljbzf6vCoSHOtwQS
         YAdgxac2m2xGchEru4SrGBikefGq2dOsTj/lXncm/HfQgmqep9F6gQioKhXZAbh++Xri
         EcbjdAXzBp9S+KzSS7cDTth6S8Y8D2x3NzPhORktxrm0PbTbX8qJbB8M2NjvwzavgFUg
         orCRS4mfBpydlAVt1ISnDVFadivpAqrxx1lFIDrrOwBFQHOm6/OLPakdwqqf3G12EvCL
         f7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XHwAwZJ34fHwTUT86MVvAndeny4bZKfD64hDKUnMj/g=;
        fh=RWxImJRS9TWme97rYvVUJMzcbrKQKnZ8CMyG/e2RZVs=;
        b=hOYbW6C/0zgWAl8FfRE41+tCrrXzXP49Buf4pxiJDMOh/yj5YgVP1UJmOVsqXQOxlV
         4oRVapEaptvcvTCpfh8vcCNrzCLVfiuwb4uuUOqpxMpMeVqfO3fsjkGhTbvTJOBYGDzr
         8KH1pp+zSzJoGS8LhLIDQ2k1d1/HbqQcekL/sdPG5WaExqdFRFai8phiOjFpUoRIgzLm
         p1eb+tQespZvcvVAxCVpv107+ToDQ9gjFxOF83U0EwCGH4btdlJh1Vam6Ft91G/pCm/x
         SHcUevzUMGFGeqJkTyu1vzYMlcN7XjvVgPW9VM8C7BpYW2BwlOnQZSNhugl6CXJAtrcT
         9h9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775808103; x=1776412903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHwAwZJ34fHwTUT86MVvAndeny4bZKfD64hDKUnMj/g=;
        b=qzjJQNU6/dDqTSP9kDxOJloMv84sd1dy+Tvmy5tDPUf1HzyTFLpsX09Rx+DCpQgOzP
         RE/xHXsr4tFRook2JshzJ/EQ3L9aFUte0K+Qxddad9hSLX8u0hLFypvR24Cz6sjbEpuK
         dy7F6qF3T22sToWHI3D+//XO3nbJ16wUJIYkf6jgBcJp8ZmXdF6uoREGgu3AxGXXntWx
         YiPEuZQKV3zpYOgVDxKSEsIx6WdHFO5PU5kzcsgiNbk5/TtkWFNAR9r4zKub+FQi5Kxe
         vZLyYazkWnS7tntI7xl679vg3U7wTzGWLsZZ3TFCHffQPJAPqPmukfN2OJkPRsHdtA3S
         u+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808103; x=1776412903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XHwAwZJ34fHwTUT86MVvAndeny4bZKfD64hDKUnMj/g=;
        b=nVFh2d0KCxAm0PaYtzOpPBOcOTkyEELAoJ0nO+IAsRpswMipaEqcuzFPPriPI90SKc
         +NvAqIOCQiRKT+iWLcFVDvS9OwIojBi8KVNU6unuLYV0BrYo1SpopveERQaF+ywbqs7Z
         VqfYjIs0ifWbpK6HibdpDYl/vTfT/EtB/9LQ/XUBgP72fH/qGpwzGyFM6VzLCUxnt1vu
         xYxJoaXrztWNc6DwKKaWqDhkNJEZiGOFhB1sYB4DdOwMdc2bjR60vQ3ECu6inYQErMe9
         Vw118JiY5XRSgmz5He8tJm+DRiIudsolY1B9tXIUO2LRBTf3aiQOGPSAI/OfCD5oaUNs
         Cvhg==
X-Forwarded-Encrypted: i=1; AJvYcCXzlhu0dAjprHWiQ9hOEaVISx5RSb08nLhcsJVmzTaihwaZByvyOQY9NNsQoOiScDYR1ZdA5A4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAlsh7chqbsR1srjygi/GgGA/ScJ4INOqXgQ2s/PtpfSL3K37z
	l8O54JZ+IQcT9tQuD6bUdN1UT1RPrayY4hnXhbzac4+53JalZLIBNDn6r8KWZyVWs11hCPRxhk5
	vyM76883SiSNpP2JAr6/Q+i315n+iMQI=
X-Gm-Gg: AeBDies+xUAo3X6DOyd9eMrLju+qOeFR12NKlh4OuwibULi5Z/L197Uj4q60/rzSqci
	D5Ekdb2gJyV2clzSIzrLpo7XwbpJT7FfpIekPhAewFVJ8E3HvbYVxsTeFXKDbZwOMU5K5pqEQKn
	ssqqLEUZ0Pq9BQHy1Ib4YvnZ5nXwuym4UEyeW7FUvG29lZhZEKmMMWI6qdXEcXuK2lsbI5VZZzu
	TEYfaRjyZCBc5rYiWpLhEs3oHNW6UrPya1nvvBkg3PhZQo/Us1Z5mRltRrhlAqWYDTLcuebIPqc
	AlLpZYfetpBW86jHn63SF2g=
X-Received: by 2002:a05:622a:351:b0:50b:5286:f757 with SMTP id
 d75a77b69052e-50dd5cf408emr21488891cf.4.1775808103504; Fri, 10 Apr 2026
 01:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403035333.136824-1-tejas.bharambe@outlook.com>
 <20260403122947.2afc337b5333fb1990a78a65@linux-foundation.org>
 <JH0PR06MB66320ABCFAD8F239FE5112B2895CA@JH0PR06MB6632.apcprd06.prod.outlook.com>
 <20260404175040.40a746040ddb0cb5ce347fe3@linux-foundation.org>
 <JH0PR06MB6632F1A4381AB798FED980CE895BA@JH0PR06MB6632.apcprd06.prod.outlook.com>
 <20260408131225.a37cd581ca47b3512a4219bc@linux-foundation.org>
In-Reply-To: <20260408131225.a37cd581ca47b3512a4219bc@linux-foundation.org>
From: Tejas Bharambe <thbharam@gmail.com>
Date: Fri, 10 Apr 2026 01:01:31 -0700
X-Gm-Features: AQROBzC1i7kYsHHSDBDyr4hc1Srf620y6vG7I3HHQgVD_622ygA-RxpXMNdTIVE
Message-ID: <CAJL2up6TkQq1JXUDvhwC0MnwGyXMzr8hU8iCQoYzz8HwjHdd-A@mail.gmail.com>
Subject: Re: [PATCH v4] ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY
To: Andrew Morton <akpm@linux-foundation.org>
Cc: tejas bharambe <tejas.bharambe@outlook.com>, 
	"ocfs2-devel@lists.linux.dev" <ocfs2-devel@lists.linux.dev>, "mark@fasheh.com" <mark@fasheh.com>, 
	"jlbec@evilplan.org" <jlbec@evilplan.org>, 
	"joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com" <syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235581-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[outlook.com,lists.linux.dev,fasheh.com,evilplan.org,linux.alibaba.com,vger.kernel.org,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thbharam@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,a49010a0e8fcdeea075f];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sashiko.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fasheh.com:email,linux-foundation.org:email,evilplan.org:email]
X-Rspamd-Queue-Id: D95DA3D3C43
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I see the concern on using ihold/iput on performance. I find Jospeh's
suggestion valuable. Let me send in a new patch, I will just save
ip_blkno as a plain integer, that should be zero overhead


On Wed, Apr 8, 2026 at 1:12=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed, 8 Apr 2026 03:50:17 +0000 tejas bharambe <tejas.bharambe@outlook.=
com> wrote:
>
> > Hi Andrew,
> >
> > You're right, I missed that scenario.
> >
> > The inode can be freed if the file descriptor is closed after mmap() an=
d munmap() races with the fault handler.
> >
> > I can do one of the following:
> > 1. I can skip the trace firing when VM_FAULT_RETRY is set as I did in v=
1. It was changed to v4 after Joseph's suggestion to keep traces.
> > 2. If we want to keep traces, we can use ihold()/iput() as shown below:
> >
> > ihold(inode);   //pin inode
> > ret =3D filemap_fault(vmf);
> > trace_ocfs2_fault(OCFS2_I(inode)->ip_blkno, ...);  // safe, refcount he=
ld
> > iput(inode);  //release inode
> >
> >
> > Which approach do you prefer?
>
> Well, that's down to the ocfs2 maintiners.  Me, omitting traces doesn't
> sound good.
>
> But we should consider performance implications - this is a fairly hot
> path and iget/iput are a little costly.  Perhaps there's a way to avoid
> the iget/iput if tracing isn't enabled.  As long as we handle the case
> where tracing get enabled immediately after we've done the
>
>         if (tracing enabled)
>                 iget()
>
>
> > Thanks,
> > Tejas
> > ________________________________________
> > From: Andrew Morton <akpm@linux-foundation.org>
> > Sent: Saturday, April 4, 2026 5:50 PM
> > To: tejas bharambe <tejas.bharambe@outlook.com>
> > Cc: Tejas Bharambe <thbharam@gmail.com>; ocfs2-devel@lists.linux.dev <o=
cfs2-devel@lists.linux.dev>; mark@fasheh.com <mark@fasheh.com>; jlbec@evilp=
lan.org <jlbec@evilplan.org>; joseph.qi@linux.alibaba.com <joseph.qi@linux.=
alibaba.com>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; =
syzbot+a49010a0e8fcdeea075f@syzkaller.appspotmail.com <syzbot+a49010a0e8fcd=
eea075f@syzkaller.appspotmail.com>; stable@vger.kernel.org <stable@vger.ker=
nel.org>
> > Subject: Re: [PATCH v4] ocfs2: fix use-after-free in ocfs2_fault() when=
 VM_FAULT_RETRY
> >
> > On Sun, 5 Apr 2026 00:30:14 +0000 tejas bharambe <tejas.bharambe@outloo=
k.com> wrote:
> >
> > > Following is my response for question posted on https://sashiko.dev/#=
/patchset/20260403035333.136824-1-tejas.bharambe%40outlook.com
> > >
> > >
> > > No. For ocfs2_fault() to be executing, the file must be open and
> > > the process holds an active file descriptor. The inode's lifetime
> > > is tied to the file's reference count, which remains held by the
> > > file descriptor for the duration of the fault handler. munmap()
> > > can free the VMA (decrementing vm_file's refcount) but cannot
> > > free the inode as long as the file descriptor is open. The faulting
> > > thread cannot call close() while it is inside the fault handler,
> > > so the inode is guaranteed to outlive the trace call.
> >
> > I don't think that's the scenario which Sashiko is suggesting.
> >
> > Suppose userspace does
> >
> >         fd =3D open(...);
> >         p =3D mmap(fd, ...);
> >         close(fd);
> >
> > Now, that mmap is the only ref against fd.
> >
> > Now, suppose that userspace does munmap() while another thread is in
> > the fault handler.

