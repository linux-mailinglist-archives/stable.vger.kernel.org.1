Return-Path: <stable+bounces-136966-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D60A9FB92
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 23:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D27B74665F7
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 21:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4963D2165E2;
	Mon, 28 Apr 2025 21:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/HhiYNJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34C215F7C;
	Mon, 28 Apr 2025 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874145; cv=none; b=nxP/2v8NujGJYoTrjXU6OyJRMup+HiBQPoeMn6irFmx0Mi3Ny0vmt6yPh3NFnHHkOzUEvKSmn24mqfR40xbA2KfgywJbgyzzAuHIQ8GmrjbZXMMxgQXozQsZaEwLBFIAOOE1uzHzQERynOEh7XCmYhIRtxNwfXK4EZ2t7j6W/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874145; c=relaxed/simple;
	bh=Itbp7clee2hvnWfOWGWjGxRJxSbIg8VzQq6yzzThnsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUgB63TJSGswHeZN85/a94/YnrYFron3oHvvaq/Unb6mXYWRkr6F0BCPW7W0F5F6ybvA2Q3+bkTLwLFbBV9ppFbU4FPV+kC93TPnb2kcw9K7ZlNimMjfoCANGSEJMP9VmxLYYaQQcBPUoBpsKQOzNuKVgcpTUteClPYmBMZhQAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/HhiYNJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so4590224b3a.2;
        Mon, 28 Apr 2025 14:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745874142; x=1746478942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hXXB00A+dPp6J1rZLZ3Xtsxe/hEjJz2VYrs1MOq8CDM=;
        b=Y/HhiYNJ9ZELl149/g3NsDz3LJcwL3jfFU1ZCeBn6FgyT/sePacU+qBXIcujPWgaQ5
         goxRw05nBGWQBlVlHwIaafnPzhjEykcqqRsMRvdjmVuXMRtm3GULQfJoRgpFtLjkl96s
         OsmiIxur/OryLntdgYhmKs/Uq/i2WcZjegwYHqoRC/F49hppS8GuSUpHbaHvKd4BnZ+k
         v8YcoIIWCioyk3TFBQ5xEjKnFgruFsxkxMezdIgnCO77pby3rokXSh1K8zaqSxOIH7cO
         kihB0l7ZwWWyBlVrD1K1L2f5co3494KUeLt2e7jYjGd6GzZkO+08nGX/b4olqt4y6emj
         LWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745874142; x=1746478942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXXB00A+dPp6J1rZLZ3Xtsxe/hEjJz2VYrs1MOq8CDM=;
        b=F36kJZxioCLJAE2dL/XuTshBhxpuJ4VmHTjQRDxzFWJMHymceSy/0yGvqRY6PtZVen
         /0kkpfY2hrFzkWZW7XBYVYOdmGdzjFV0QY4HMya7jn6rweyMXdnZfu+WUfRXU/Eal6TK
         RSTsFykYbk7caf5MUG334cZK4b8u0fKNRKMSGUifNY1IPBWZuj2YY6y4WT/td59Y6KEC
         FdylfzjOiNmxfoRYyRyopwxJoYZ2cS30dXDXkaxWUMUU4m2kTWvuij/uVIsM3we9PiIf
         337Vc4huc5SfnXl6AUZ8AI8iMl1kjA4daWYl3mriGN0lktC0mptXETGGVLkgpz8AXCLe
         WECg==
X-Forwarded-Encrypted: i=1; AJvYcCU6kNPN/qbEmrw/NFo4FqKW7Nn81wdB5pkQGx87QpRnQWiujM1VFiE7Pa0/BNm0qVT7A7Pb0lF2@vger.kernel.org, AJvYcCVzMHA3ZJ063mEK8DPJ2n7sHgE1zJAEth4+bnlLCQjxqxKWsDmT1CA1xmAVmtYijaG+b9VTPHW9r+FBsJg=@vger.kernel.org, AJvYcCW+5kMTcPxAqVnVAxW70IPQ+6G8DuwpWyULUHlz2VF/UeoWTZAC87JvGfXG0GIRI4/FiZKNcg2a@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn3KicfdSeRFfP1paiIeKdzL/jTLhn13nvnRv5MZxJwQY99Rny
	B3cZ5DUqGDCnwqCgxvwqzupICSax4XW7Xnz8IzY+sZt8fp/2uCtI
X-Gm-Gg: ASbGnctfxX1m5hqS/Cz1CvLcHKZ5DfWK8FMPCNKX8kKSWtHvUdrqFnozZR6MyBk1U2G
	5Nqjm+8n8NTXQcjpKGgyCQQV5mXiSARVBbdFog40MuksLPFM2RhcO5ue6QJDg0Vi4i1fX1QnmB9
	KMeAa9W2sJCo6re/oRrDf4ySkTAoKExY3+rluP6k1m8+08LSbRZV5uCPR7usv093WuvMTwOpgvT
	8ICrJnMsZl4z2fTGvDi75gOvX+y0yvB2/dVfFIZQL35XKgLRqFMqHo3zoGz9fyqIWU4YrdcJlCt
	52TRVx5mcgIiJuPs5hSyRgpdbtfAFy/b23RJLzj/iWQw
X-Google-Smtp-Source: AGHT+IGQzTQOkq544Fxw04oa9VgEQc7AcWpngUxeHCjtqSAJ/vTs9P8Z2id3ozh+5cNJhu5851lR7w==
X-Received: by 2002:a05:6a20:7f87:b0:1f5:8072:d7f3 with SMTP id adf61e73a8af0-2093e724297mr1426828637.30.1745874141571;
        Mon, 28 Apr 2025 14:02:21 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca62csm8484928b3a.167.2025.04.28.14.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 14:02:21 -0700 (PDT)
Date: Mon, 28 Apr 2025 14:02:20 -0700
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
Message-ID: <aA/s3GBuDc5t1nY5@pop-os.localdomain>
References: <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
 <aAf/K7F9TmCJIT+N@pop-os.localdomain>
 <20250422214716.5e181523@frodo.int.wylie.me.uk>
 <aAgO59L0ccXl6kUs@pop-os.localdomain>
 <20250423105131.7ab46a47@frodo.int.wylie.me.uk>
 <aAlAakEUu4XSEdXF@pop-os.localdomain>
 <20250424135331.02511131@frodo.int.wylie.me.uk>
 <aA6BcLENWhE4pQCa@pop-os.localdomain>
 <20250427204254.6ae5cd4a@frodo.int.wylie.me.uk>
 <20250427213548.73efc7b9@frodo.int.wylie.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427213548.73efc7b9@frodo.int.wylie.me.uk>

On Sun, Apr 27, 2025 at 09:35:48PM +0100, Alan J. Wylie wrote:
> On Sun, 27 Apr 2025 20:42:54 +0100
> "Alan J. Wylie" <alan@wylie.me.uk> wrote:
> 
> > That would be https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/ ?
> > 
> > I've just cloned that. I'll do a build and a test.
> 
> $ uname -r
> 6.15.0-rc3-00109-gf73f05c6f711
> 
> It's crashed. Same place as usual. I tried again, same thing.
> 
>  htb_dequeue+0x42e/0x610 [sch_htb]
> 
> Rather than a ping flood, I was running a Speedtest. Both times it
> crashed during the upload test, not the download.
> 
> https://www.speedtest.net/
> 
> Could running an iptables firewall perhaps have anything to do with it?

I doubt it is related to iptables. I will try some TCP traffic on my
side later, but I suspect this is related to the type of packets.

Meanwhile, since I still can't reproduce it here, do you mind applying
both of my patches on top of -net and test again?

For your convenience, below is the combined patch of the previous two
patches, which can be applied on -net.

Thanks!

----->

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index 4b9a639b642e..9d88fff120bc 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
  */
 static inline void htb_next_rb_node(struct rb_node **n)
 {
-	*n = rb_next(*n);
+	if (*n)
+		*n = rb_next(*n);
 }
 
 /**
@@ -1487,7 +1488,8 @@ static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)
 
 	if (!cl->prio_activity)
 		return;
-	htb_deactivate(qdisc_priv(sch), cl);
+	if (!cl->leaf.q->q.qlen)
+		htb_deactivate(qdisc_priv(sch), cl);
 }
 
 static inline int htb_parent_last_child(struct htb_class *cl)

