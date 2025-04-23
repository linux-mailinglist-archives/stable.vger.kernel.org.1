Return-Path: <stable+bounces-136475-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 182A1A99886
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 21:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6CF33BD942
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 19:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8830293B42;
	Wed, 23 Apr 2025 19:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6OObWSo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AFB293471;
	Wed, 23 Apr 2025 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745436782; cv=none; b=FENzhPQKeq2vi24i5q2V97e0pCbDA6H1lvijNpsKZeMCy/6B+OOl1MRs8Ajl+7r21F8Tqyzvdui2KlZUV53W/F4hHbW9UdUv4ZdIScfZuTTKs9/7lp5CgTuhamDcuJMC+30DqQslfXjdfiFz6jZ1fQAiAxzJu6ubSbwOyQ2kEy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745436782; c=relaxed/simple;
	bh=qeXaEOZxb709KPbgIWs4cj6m9zaoicIroOb1v3e0D38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CthRZKd88FMoLO+UkujMd+uNO+OLS6RyNH0xGBEYxYm31KBCLegcUHPCNlV36hg8QnpQmXmkQvYKHxwZSSRfL7cT6NK4P+BYxXNIYVyr2yfFSfVJW7ALF0OombShBRGO4IKLdnwDk1G/qkgc2ekbhsS5pyrOxx2AdZ78senHeE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6OObWSo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22c33e4fdb8so1914005ad.2;
        Wed, 23 Apr 2025 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745436780; x=1746041580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TWawy/oO2koF169FCbsai+IajiXPIwWUAaxyA1lZrk=;
        b=T6OObWSoyjLfGNeKZZI692OwBdfvG0Cr/tu+jL7l3+I4Tn7fRcs4VxzJzqbyDf1JOb
         bZTyjlbgkatxWkRBuK9TcRU+aSFucd88RU0gLHK0HKq6QkooTjVdM176uSFQ6dG2ZIMt
         PI9AjvnULsLvBXX18umqufxRZv5EnwesFYlUhbeD5Zg4JlNXdDucqrSVHs+0Zfi/mZSG
         J4zGBAR221/eEPVKcKh+Wn69SyFNNXds9Lhecn09WeurRR0zlv57mrHNp8cxNAvO266y
         jcA4T3PB3KJkgHx9Wbnkvfti3goBbEXFicA08aBHm2CDxEEaSIJmSFmmsnblVGsjTcKN
         x/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745436780; x=1746041580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TWawy/oO2koF169FCbsai+IajiXPIwWUAaxyA1lZrk=;
        b=LOzMZRGxuufmnA0UmehSm+stTINdMZzN5z4OUXYlrAkFzk/RB5yWFWrBm+pQYGY6G3
         sG+xJ9VgsgREl0cX521jnXtvzAuIE9tSsgciEYMoXkA0Bd22dYbwRrbf9xhbujAh6mU2
         pbe9htcqW+Yh3ka0pTH1BtJUTt/sJZWwciuIddnRi6UQyV7J4CLuaLnmSJ35q3CWO/NB
         GiqxBOz6SVGFeJWai/zcRGWrs5WRlIJ6P5Eh8rMHevFWRL5YvkW970RU08c8qBFCrLrd
         4NaybmQ9bvPvlhJ99T8gIjQE1nxpY+xwtMME+m908yq1rvbJ8+lSZmORB5e6Dq5HN1Xp
         gpxw==
X-Forwarded-Encrypted: i=1; AJvYcCV8JM5jJ5bsUY1aTV1eC9u1YyByOW5R0yV9nLKmcC+UWrmTpbXnzxIhgXtQWTfE2ZrYHTidPQuqssH571k=@vger.kernel.org, AJvYcCVdpQ527Q5WpGiPwYf9r1bSW9hBbLn0e4dOGb/okdlWhwZT/5xqQ4rrQTLlDyi2zhIH+Z0X6ntK@vger.kernel.org, AJvYcCXcWUvwuticsw/mRhd3TnkQB82MdV7sKxonEFIM4u7byWlVxB9uHuh/sIHt21+GDLNDj/S7CzIe@vger.kernel.org
X-Gm-Message-State: AOJu0YxLTibhI7Si7lMssZh2tAbu8QmhU2RTQQ+n+U9K+rOOG2GJBnhv
	YqYzeyVEemNEs7Tp+KTnb1xzrw5+8Tx6v1141VmWOCZ9Tw1iz3nu
X-Gm-Gg: ASbGncsfSPJzMaWM5m/BN5gmwmmvT70HqcAA+X+tnTqR9BPBcOpekqJB+JWmmD/6Uxh
	FGqfA+PuwGu7sfAWZHR0H4pxoBc1mZz/BwL8WfguJ2N5KztXyKtJsYeZv5Q+PajpacQlV5CR7h2
	RTW2pKuPx0t2L9bOv+JbnHhoN++5aaIT48+yfECNmMPG0oRTYt/jWESjMm+0mz7FIpEA3Wyg5Oe
	Ayp7HreHqrfaOaY3cjrYDq4J+BLvrGeIYU1bvcRDNnVVgcZKbKrFA1xtKUe/O7jqt/b1Cox6JDY
	mbZcMU6l3VvcaYpFynU20rZMocgQ6PqO50mZEVG0h9Sb
X-Google-Smtp-Source: AGHT+IEWT0wZBmAOH0PSIjsDQw7UecOVeWgSLRwG+BXz/ugDANFWFinATMDNMWo+M4dyODERvpT75A==
X-Received: by 2002:a17:902:e5cc:b0:223:3630:cd32 with SMTP id d9443c01a7336-22c5365eaefmr309410525ad.53.1745436780172;
        Wed, 23 Apr 2025 12:33:00 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf52cesm108249605ad.65.2025.04.23.12.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 12:32:59 -0700 (PDT)
Date: Wed, 23 Apr 2025 12:32:58 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "Alan J. Wylie" <alan@wylie.me.uk>
Cc: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <aAlAakEUu4XSEdXF@pop-os.localdomain>
References: <20250421131000.6299a8e0@frodo.int.wylie.me.uk>
 <20250421200601.5b2e28de@frodo.int.wylie.me.uk>
 <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
 <20250421210927.50d6a355@frodo.int.wylie.me.uk>
 <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
 <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
 <aAf/K7F9TmCJIT+N@pop-os.localdomain>
 <20250422214716.5e181523@frodo.int.wylie.me.uk>
 <aAgO59L0ccXl6kUs@pop-os.localdomain>
 <20250423105131.7ab46a47@frodo.int.wylie.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423105131.7ab46a47@frodo.int.wylie.me.uk>

On Wed, Apr 23, 2025 at 10:51:49AM +0100, Alan J. Wylie wrote:
> On Tue, 22 Apr 2025 14:49:27 -0700
> Cong Wang <xiyou.wangcong@gmail.com> wrote:
> 
> > Although I am still trying to understand the NULL pointer, which seems
> > likely from:
> > 
> >  478                         if (p->inner.clprio[prio].ptr == cl->node + prio) {
> >  479                                 /* we are removing child which is pointed to from
> >  480                                  * parent feed - forget the pointer but remember
> >  481                                  * classid
> >  482                                  */
> >  483                                 p->inner.clprio[prio].last_ptr_id = cl->common.classid;
> >  484                                 p->inner.clprio[prio].ptr = NULL;
> >  485                         }
> > 
> > Does the following patch work? I mean not just fixing the crash, but
> > also not causing any other problem.
> 
> > ---
> > 
> > diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
> > index 4b9a639b642e..0cdc778fddef 100644
> > --- a/net/sched/sch_htb.c
> > +++ b/net/sched/sch_htb.c
> > @@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
> >   */
> >  static inline void htb_next_rb_node(struct rb_node **n)
> >  {
> > -	*n = rb_next(*n);
> > +	if (*n)
> > +		*n = rb_next(*n);
> >  }
> >  
> >  /**
> 
> There's been three of these: 
> 
> Apr 23 08:08:32 bilbo kernel: WARNING: CPU: 0 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
> Apr 23 08:08:32 bilbo kernel: WARNING: CPU: 0 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
> Apr 23 10:41:36 bilbo kernel: WARNING: CPU: 1 PID: 0 at htb_deactivate+0xd/0x30 [sch_htb]
> 
> But no panic.
> 
> I've run scripts/decode.sh on the last one.
> 

Thanks a lot for testing! This helped a lot to verify how far we can go
beyond the panic and what I still missed. To me it looks a bit
complicated for -stable if we make everything idempotent along the path.

Do you mind testing the following one instead? Please revert the
above one for htb_next_rb_node(). I think maybe this is the safest fix
we could have for -stable.

Thanks!

--------->

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 4b9a639b642e..3786abbdc4c3 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1487,7 +1487,8 @@ static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)
 
 	if (!cl->prio_activity)
 		return;
-	htb_deactivate(qdisc_priv(sch), cl);
+	if (!cl->leaf.q->q.qlen)
+		htb_deactivate(qdisc_priv(sch), cl);
 }
 
 static inline int htb_parent_last_child(struct htb_class *cl)

