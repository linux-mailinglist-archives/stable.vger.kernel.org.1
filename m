Return-Path: <stable+bounces-135193-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DCFA977D5
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 22:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5316A7ADA06
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934B529899B;
	Tue, 22 Apr 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhqJns9B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F2242D9D;
	Tue, 22 Apr 2025 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745354543; cv=none; b=pOuFWrKOnHc3JwcW2uOOqi/UyavjPKZcJAqNPxC3VUHXPHcsHBJe1mzuleT10GYk7KnwFdYNEGxp+kyrmYHzWsbqlQnON7HKXqgCc10Mg9Jweldh7cG1XVhxRZ3AM2drEwiEQpmqLH8FWGujFXUZIujkupTVzbZ+wkNF053E1rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745354543; c=relaxed/simple;
	bh=iykaHhBnl9JNM7hxvi+qM8kwPweNLcLOO2zElA+Pdjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB04spbu04sHivPUNNR+gbrwn+tXztPii9PXBuaxCvxsLjdw+4XY7n6C6Ih2Zg5sKHGeyLenXLm447QexEEJ3aaDCNDu9F5DntGRnZBrxyjpc5gROI3YVPwJCGFSdvzjVoQvmFwfo/x1Dji1mgbFiDLpEwnGahsTbONbe20zVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhqJns9B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224019ad9edso80352925ad.1;
        Tue, 22 Apr 2025 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745354541; x=1745959341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CaIOmdrt13KU/miHWyqAdd2EpE7lQ4kV1HkCuMBXWOk=;
        b=ZhqJns9BvWvcgVJUHiHR2pDfWn99+MVKQW3GZw5CS4WVG0tDPdhxbjprPn0KIUvm1L
         ZhWW50MVbOkURzWsd20Mzt38p9EDwV+R84dNHXNdwawwyPqCUpBsenzNOFTBS5vQs4mn
         8a6z4Cyq88VfluTaOlIkxc5frL5vHr5VobFm8Xqx4rVCrvfLjFTdY9XxPGJMuVkaOoD3
         eQvb/le/2ajXDj+f+InBEpckhXg7hqm909hat4WFsQr2W1lFj7VmJZL5rSRr3Ye1cKaH
         KaEEDpHQvXYgoWPxEvWi35wwNO7Drxhs1NS38HpSPWWSJ4tC9shHPhln/Z9xxKy1+R83
         KSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745354541; x=1745959341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaIOmdrt13KU/miHWyqAdd2EpE7lQ4kV1HkCuMBXWOk=;
        b=fA+63ZEuJRoE2fy46OIlidppAsp5pphN4In+F3EkKxg1gcgPxLtmlU3kOiS2Wblr0C
         pwy4hOssMez3XJDFb0Tv2Vbu7PlSHV21UbohPQGDiLXfRkvmn0R8Bm6vB8Js2Ayvj+cN
         bKgP4hd8cHDh7cUyPZo+37vWQC+j+sEK4Rb2hSm/YiEE8STOFBjl+ORj1R6z6nuMze9Q
         4UC9n6dk4qTP8JYFEXWhnhRNsotMhawGfnIsRzpsUh+uusPbJh19MEOvKQdRoQT3Hvwf
         6BpCsqKaLx0ACrh+zIFhT7rSA2iNTPp2YXS33G7C5REApR5Q2NqdJS8cr4KOhUqYT7GP
         PrmA==
X-Forwarded-Encrypted: i=1; AJvYcCUMftQYY0bJxdZt9bWur6uyFBHMAqMhHOxKX/D30Zn648+1w7tHKi3AUINTlS/emdHUhQsk4Vc0@vger.kernel.org, AJvYcCV+vL80nZfJ+Hn1GE5Q7iZyEPuk07TwRffeKRQLgDPc4CxdAkyHfH1MYT3dXZZWWlonmgWr3Qt/@vger.kernel.org, AJvYcCXi6oPuP1+399821BdRD288fattxu4BZxLFFzV/zCdAAfcBDzsbbtE5Moljd2H+6WVmOZt3Meo0/snABi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOwuO+kHMeIs5JohL5ObLFStg71LCD2QF2peXJTHAj54WhqBs
	WLed6ZFmouWpyYBSPdtcd9bG/vXVVLk7+E2QzeVbPK7ZEsMlGWVQ
X-Gm-Gg: ASbGncvf9dpVvVl84T9ePPSOaUxrsFVsCpGzAhUFBsY+I96QmppQ7tv9sjguvcIfrWZ
	XvAH5rycO05mu8GzWaxJx71wL7/58tR49c3uVKzVSF21g/b+c4r3JW8X159aF1uBx5qR/v2hW78
	hF3ezK3HCYRxYZf5K7jQwdfh1ZSrDoVDWulQX594Txm9CNslnccvl8oDITmd++abn7u9cKIykgU
	zwGtJ/QaiU3g6+ORITktCnP3hu+9/k2AawbPUXnwqPL0YXI2/wMw+Rc/8pCAZ+Kwoa6xsD9/cwU
	Y5klX2HZfa7OrYPeuEnKxlNT2kKCy19zGWUGfzh8IZFg
X-Google-Smtp-Source: AGHT+IGBlLoRB1xhv3Q/YgrhOc0DfgkasA/12Oe3DR29IJaqjESvijQ/+eEb2nRJAHl8NBi8VItuGw==
X-Received: by 2002:a17:903:2f88:b0:223:65a9:ab86 with SMTP id d9443c01a7336-22c535a4b55mr257118285ad.12.1745354541235;
        Tue, 22 Apr 2025 13:42:21 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50fdbf00sm89438705ad.225.2025.04.22.13.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 13:42:20 -0700 (PDT)
Date: Tue, 22 Apr 2025 13:42:19 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>
Cc: "Alan J. Wylie" <alan@wylie.me.uk>, Jamal Hadi Salim <jhs@mojatatu.com>,
	regressions@lists.linux.dev, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Octavian Purdila <tavip@google.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <aAf/K7F9TmCJIT+N@pop-os.localdomain>
References: <20250421104019.7880108d@frodo.int.wylie.me.uk>
 <6fa68b02-cf82-aeca-56e6-e3b8565b22f4@applied-asynchrony.com>
 <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
 <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
 <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
 <20250421210927.50d6a355@frodo.int.wylie.me.uk>
 <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
 <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>

On Tue, Apr 22, 2025 at 07:20:24PM +0200, Holger Hoffstätte wrote:
> (cc: Greg KH)
> 
> On 2025-04-22 18:51, Alan J. Wylie wrote:
> > On Mon, 21 Apr 2025 21:09:27 +0100
> > "Alan J. Wylie" <alan@wylie.me.uk> wrote:
> > 
> > > On Mon, 21 Apr 2025 21:47:44 +0200
> > > Holger Hoffstätte <holger@applied-asynchrony.com> wrote:
> > > 
> > > > > I'm afraid that didn't help. Same panic.
> > > > 
> > > > Bummer :-(
> > > > 
> > > > Might be something else missing then - so for now the only other
> > > > thing I'd suggest is to revert the removal of the qlen check in
> > > > fq_codel.
> > > 
> > > Like this?
> > > 
> > > $ git diff  sch_fq_codel.c
> > > diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
> > > index 6c9029f71e88..4fdf317b82ec 100644
> > > --- a/net/sched/sch_fq_codel.c
> > > +++ b/net/sched/sch_fq_codel.c
> > > @@ -316,7 +316,7 @@ static struct sk_buff *fq_codel_dequeue(struct
> > > Qdisc *sch) qdisc_bstats_update(sch, skb);
> > >          flow->deficit -= qdisc_pkt_len(skb);
> > > -       if (q->cstats.drop_count) {
> > > +       if (q->cstats.drop_count && sch->q.qlen) {
> > >                  qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
> > >                                            q->cstats.drop_len);
> > >                  q->cstats.drop_count = 0;
> > > $
> > > 
> > 
> > It's been about 21 hours and no crash yet. I had an excellent day down
> > a cave, so there's not been as much Internet traffic as usual, but
> > there's a good chance the above patch as at least worked around, if not
> > fixed the issue.
> 
> Thought so .. \o/
> 
> I guess now the question is what to do about it. IIUC the fix series [1]
> addressed some kind of UAF problem, but obviously was not applied
> correctly or is missing follow-ups. It's also a bit mysterious why
> adding the HTB patch didn't work.
> 
> Maybe Cong Wang can advise what to do here?

I guess my patch caused some regression, I am still decoding the crashes
reported here.

Meanwhile, if you could provide a reliable (and ideally minimum)
reproducer, it would help me a lot to debug.

Thanks!

