Return-Path: <stable+bounces-226889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKplD9mnuWkhLwIAu9opvQ
	(envelope-from <stable+bounces-226889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:13:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD12B1643
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 20:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2E01306D8E5
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F4F26463A;
	Tue, 17 Mar 2026 19:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfXId05t"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F73F880C
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774799; cv=pass; b=h97FOUbXtyeiiPLQN3uAOp0ze9qL7z3A//tmTiDsmDLw73FfhF6aWgzFAMuzHf1g/u8DxV6nRntbAUt4NPLZZDehwn35WCfef2hbS42d/rv9Waqy4PqcTZn+/z+hBAfmAc7dTp+USxRVBAYVVV54/CRpbmqZzQnvmUoqixVzV18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774799; c=relaxed/simple;
	bh=JC3f9lB8/LjpJm9zQETEG5UdDrX51WYqap7UJguFQJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik+aDxHt856bXcD/x8KHo6JQeO97eV35OND/Ais5JIRt5lgHkZGGQYNff1kD5HxUy8l9Y5zQUj0nIY3k8qGLx3JKbj3HPBZhJjH1l1poVsyqKWseDnHTkx0QoPZ2fo5DYWBqvGbYL6BCZDJgdx1jg+Y/MFgDxorkaVscAcd3+iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfXId05t; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486b96760easo11298445e9.2
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773774796; cv=none;
        d=google.com; s=arc-20240605;
        b=IK1y0m1GO5JOu+nF52QiFsi9+SBUNY5P4eMjsDehs5gc9Xp48+QOlOEFuvIn1jgUwq
         01oMkozWbXuQAEVQaL0ElplmquMQBo/sbH4uHzkJnpueQrbdUa1KD8VO2uWaKj7hSBlY
         iUzXmmXWWFrYAhrwWoa4FGD5vUnVFT7ld9hl6vEEw+KdQ07YHtK0q+9TpffsvfAng0sm
         xVatAP7a3vQItJV/pu1333d4jtukKxMVDtq9UaZe9PKqmBBloQ5hz0Z8L2Hjr8VPMAEB
         DXzmh28SELS/pUJGnGripGwibpiDU2R6UU0dWaB+6prVJSpEwhmGtcDMAVqDRsfJYRWp
         +J+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2k4s6/CmkjZ75LYxsdScXZSeV9lyVeFo9dEaaWin0XM=;
        fh=4qJBpwUj0EGDLyNWpHf2YF7fbmoDCcUyWDY/2zffRzY=;
        b=UeSKjk1CLkf6wu588P3e4dSiQBq4Ek1mRZk+RD93xpjrkAzDzAvVRxfFTEwD31s1o/
         z1yOwNVmolTsHAO/Xr2reHox0lycDl7KY4SqOCqMM7w3ySrLsmgkmc+evL0AOhOHhMm7
         3QMMMeMjP+EDq6tCdZhmCyJSIzgjRg0Rlj0ZlqRB8U7dRnkEzZKE0e+0sVKaMPCPQTpU
         yxbgPp2vaR8UMCexUOP2Kp2mWtyDzIm5E0SwR0Sba0BfkZq7g5fRELc6X6RCyLXJxvKm
         M8Jc+uylMYSoNKA1DsjqOA8Y1jP01olEw2Fi31D9WHqBZSRsYTc2wk6XMLXezWRuLQ3j
         PPBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773774796; x=1774379596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k4s6/CmkjZ75LYxsdScXZSeV9lyVeFo9dEaaWin0XM=;
        b=dfXId05tBjwD1wSCnk/2eS1YCI4YiFyAaEICpmckVISmJGFdtRJT8kuw4UyGfctwn2
         0jHzrn5zbmSlYHyuaG6I3OYL+ok4LopCTKgD2eO70vCPTmZYyxvaZrwOmhLU5Z9X4s6q
         i7UmfL29AjWOpqY8v8jFkVcE+dG038VzqqMJ1r/TD9BiphWLFwiJ+dGFK/MC8ZqVXTJ8
         0w0XY37OqQwcDH30mw5CzBCIPD8iqEJYC/nxC4fkBrQekn2/kYsdxnv8O1i9AQ3U9l3j
         vTH2Er/C+WYWmn4YiuE0zxQ9ykvHl8YajUbCU2H9BFzcStOvi6R1dMXGLsKBC35Nie6K
         K3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773774796; x=1774379596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2k4s6/CmkjZ75LYxsdScXZSeV9lyVeFo9dEaaWin0XM=;
        b=CRUqdIYM/kcCAQvPccU9BEbW9bIKl205R6sCAUpzCAbkge9nM4TVJNz7/6RLJfBaSq
         7lue0eFbcXaKekitqxb14OLMO5Bzb9rP84PAdkRp2jMP0Hzz7ZpO8bXMt1HabwZec6bq
         ji3JGQtBoRxdiReEalLcDguwZw/xjh4mzyIjDPsQRDhkt+Cvix/saGmjFsjLFW2wbr4k
         Rhyr4Knh7ehrH+SSIpz/WqdqgcHgwOipz7/8mINmqnkBeSF//+gV/PA7XkD5ZzLKvLG+
         WS/QmDqzof96E427RzPZ4676CkAAOLcGR/DnwBkyR9MwdajCI7nhrjWlIFHcSRDYpFJR
         Zaaw==
X-Forwarded-Encrypted: i=1; AJvYcCUFXElP/P2RjXyLStRlSd7l6mZf2hcwm+WEHQ7X/pQ+Go962MnF70TKqe//01KrZB5imDLUCzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDM69bYP885GKJRSI55huheJtyYHqEJBKbY7Kdb4ueUTSn3zX
	fOvbqUprpxbyPbzqG81CrYW73kWSO4wyLjvYKqyeZajjAugIGfkZgjaNr8YVWCUK+t/Tlq6VBr3
	lWIrfi91RorTH0krtMJa0iibwzBzJbLo=
X-Gm-Gg: ATEYQzyYXJb6O1v8JLY9LEedMxNUUF7Y3vzW6WpvRNwQomKJVUhjGkMDBQ44qKu7YwU
	V6B3ezvfH4+KaxbCdH9vskgD6lKS4MeDVg89+bcml8pUvcBvHFvVqaNHdNMBlNJUiw6RnfUumqP
	RoiSmS5/BVQy8DexuUOa3T//qn+ZllQBIQ9aPdG3D0zHgBFIqP5YJcmETrQkD4qg22shvkkdmlb
	59t6Zcl0ls3jcnG1M2pcHExnA7820yOlwfncYBrXp18+cBdwDAOpTqp1MxBzYqf0rD/lo+U7kjk
	vrm4UWB2jWs6EaK6SlEVS3Ppn8+cmwc=
X-Received: by 2002:a05:600c:b8a:b0:485:a4de:f4f9 with SMTP id
 5b1f17b1804b1-486f456fdb7mr12311325e9.27.1773774795851; Tue, 17 Mar 2026
 12:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315232500.251088-1-CFSworks@gmail.com> <bbc55ded3e226cee35e04a071400981e2069eb3e.camel@ibm.com>
 <CAH5Ym4j6gPCR9UhM1ywkDmvcDAccNrL72LFLy468T4PfPTxU7Q@mail.gmail.com> <cebd075d8e2e7e926fbcb56b19ec43fe7dec6ef1.camel@ibm.com>
In-Reply-To: <cebd075d8e2e7e926fbcb56b19ec43fe7dec6ef1.camel@ibm.com>
From: Sam Edwards <cfsworks@gmail.com>
Date: Tue, 17 Mar 2026 12:13:02 -0700
X-Gm-Features: AaiRm52lMPb1yDfUF-9yK0AWVPwFZVXbgUkp4HGLVQdzn1TsQzW879X02HrYKMI
Message-ID: <CAH5Ym4hjSxtVG1v58Yd83FYeU+8+S_1M2_5pPJmMs=_fHb7orA@mail.gmail.com>
Subject: Re: [REGRESSION] [PATCH] ceph: fix num_ops OBOE when crypto
 allocation fails
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Xiubo Li <xiubli@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Markuze <amarkuze@redhat.com>, 
	"jlayton@kernel.org" <jlayton@kernel.org>, Milind Changire <mchangir@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226889-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,dubeyko.com,vger.kernel.org,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B5BD12B1643
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:51=E2=80=AFAM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
> > If this is just a general question about the patch, then I don't know
> > of a way to trigger the issue in a short timeframe, but something like
> > this ought to work:
> > 1. Create a reasonably-sized (e.g. 4GiB) fscrypt-protected file in Ceph=
FS
> > 2. Put the CephFS client system under heavy memory pressure, so that
> > bounce page allocation is more likely to fail
> > 3. Repeatedly write to the file in a 4KiB-written/4KiB-skipped
> > pattern, starting over upon getting to the end of the file
> > 4. Wait for the system to panic, gradually ramping up the memory
> > pressure until it does
> >
> > I run a workload that performs fairly random I/O atop CephFS+fscrypt.
> > Before this patch, I'd get a panic after about a day. After this
> > patch, I've been running for 4+ days without this particular issue
> > reappearing.
> >
>
> I think this is good enough description how the issue can be triggered. A=
nd I
> believe that the commit message deserve to have this description.

Very well, I'll try to condense it in a way that makes it clear to
those trying to repro the crash without being overly verbose.

> Frankly speaking, I am trying to reproduce the issue [1]. Do you think th=
at it
> could be the same issue?

Please double-check; the link you sent is to bug #74156, reported last
year. This regression was only introduced last month, so it couldn't
be the same issue. Did you send the wrong link?

> > > >     BUG_ON(ceph_wbc->op_idx + 1 !=3D req->r_num_ops);
>
> I believe that it will be great to have the link to the particular locati=
on of
> this code in the commit message.

I strongly disagree: The location of the code changes with every
commit that adds/removes lines above it (including this patch) so such
a link would be rendered stale immediately. What is your reason for
believing the link is useful?

> > > I don't quite follow. We decrement ceph_wbc->num_ops but BUG_ON() ope=
rates by
> > > req->r_num_ops. How req->r_num_ops receives the value of ceph_wbc->nu=
m_ops?
> >
> > ceph_submit_write() passes ceph_wbc->num_ops to ceph_osdc_new_request()=
...
>
> I think it makes sense to mention it in the commit message.

NACK, that relationship is already memorialized in addr.c. But again
I'm interested to learn your reasoning.

> I think that it makes sense to create the issue in Ceph tracker and to ad=
d
> Closes to the fix.

I don't currently have a Ceph tracker account and don't think I can
add anything of substance to an issue report. Feel free to create the
issue on my behalf if it's important for Ceph's processes, and I can
Closes: tag it in v2.

Cheers,
Sam

