Return-Path: <stable+bounces-212952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBNDE3A4fmnwWQIAu9opvQ
	(envelope-from <stable+bounces-212952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 18:14:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0503C3241
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 18:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 988813028EE6
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 17:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35668343D7A;
	Sat, 31 Jan 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ac6AQ+HE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A333F8D6
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769879655; cv=pass; b=aWg+zCWAvrYrKxOdoSDEX2ypjjSf4EIoR5U9HMWPRMwzWnYLjZYERQ+YODIJBpgzMhEaHhg711c3XX2Cpq9sJkCsqylEVIH8Hq3G3mXuSUvYDyUyBfitr2dKqVASBtX7WycReAjrDThVm65MJUdLonEVp0l6qvLsYdIjaOYnToQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769879655; c=relaxed/simple;
	bh=r+vwDs7BuZngUPxeijC/0bcS3Gi48Tqn+Nl4riVXyC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=khszUkgmTs6/nO86aMYMaimO1htFUYnwy+lvP64tfLS+rVHUpYbU+qjGS3xReMkSgQ/mUswNVsT/NERrp1bYenXdq8JPS3goW9iOxNKHhMtWc2x/2F3AVcHM6P17kxk7KCzNfk/6vlaftk+zSl2CSHKECVUZWjUAOdzlcx6Sq5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=ac6AQ+HE; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f4dfa82edso1737518b3a.0
        for <stable@vger.kernel.org>; Sat, 31 Jan 2026 09:14:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769879653; cv=none;
        d=google.com; s=arc-20240605;
        b=a4crSTeiwp069E87jSHWivY4U7pzvBDUwUvZm3YgoeJb7fZayhSOiaVUWTc2eGzprn
         LIQVyE7vv1s3Zq1Kyt0oDFX6yy3ylv9OxUCwAFHGr5tjAzE3ETdd/Tee+9eEc+Hvfcbd
         kHeeQcGYBT+3LHdCKBR6JAJQYjfxc8dcmKoSzE/roHIIrouqfYiyBfT9ejrpg0XDpW5Z
         Fbu6AhB2rg8gzXDDN6cH6GnWYw7cOvrL4TP9cg0rtO3k1D/oVssRDczooFBOIeXsohRF
         hNy9QfXwDI054PBGnLDa/GqHZtsI8Q/aRjSdvUrEUiNmUxsqTZAaZ8XiS0n2WDF34trh
         QK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C+DEJkDZ8t1gSzphKTb6gNVdppljsyPu97cg1FwdVG0=;
        fh=5bJRyAO8RxGzg3nCEw5nL5pZ9A9z4+h/d+bn7Pw3QGs=;
        b=MX/QQ1GPRSah31Z/xp7lFe+vmmxyeLb3SX4owq6BiQV7HJ4EAEtjt/mf/EvICgjPSf
         /ZN9ihjYysnseE9gFJiGzUODqQWhFDr1b8uIt1aH+irRXmepm6NkwsAgcKc6rzWWp6N/
         DeDFAVEfWJ6b1yn5DsZOHbSTfv9ngiXM3IKH8jQSNJSfLOTV91adregvT/0Bta6/387o
         7MwxYYEshozIKO+Wx6eKZzc+w8bMY85DA71D0alui7SJpnq+hMZVGsqmKgUDbF8TPiBh
         Rmr9HXKYeHaQrNE8D3XT3zDRJZrwlli3Z2youQnudeDQQyvIOxI0Lyagm9juy8Xn7J3Z
         PyZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769879653; x=1770484453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+DEJkDZ8t1gSzphKTb6gNVdppljsyPu97cg1FwdVG0=;
        b=ac6AQ+HE0jew4ccZ88RekymdsiPy9dXnI44jQeu9ZwFnxtp+Rz0KfAepDoPHxfMcfD
         Z5J8Z3+fiC+MHbTB3SGktoSpk8T0di9Qzt2iEn3S2j9+zpif0yLPQIh47GWyiZBssch1
         P3SpG2KCKv5/32x5wTjlduggC3wxqTG0UNs3rIddwOLTa25i7nehxlTjIw/bfjBHirqx
         rrDKq2/hMchede6vcDXCO9xkGGVU2fo+8sNSwMbSBLpahv+mxmCYBA7XffnOosHkzZsV
         J9EPlk1h1teGnn4sI+5lwlyuU6LKrnedw74LTqMm4j9HWamu7jf5mAPH+GAP72kZr6Jb
         9HZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769879653; x=1770484453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+DEJkDZ8t1gSzphKTb6gNVdppljsyPu97cg1FwdVG0=;
        b=AAzocYyLtT74EEL9o0E8cMEXZqiRAZXYRraktgN5j2x6C2EbVj6Wb9DK/4KvmMzDX2
         aO6+h3lfMHh/qwcL+3hwiDag8xDrISCeFZuF/gyPMRoCJFsu2atMH4/+9TkrCgiwYjNh
         R0Heoss4NQEhaaXPac2sqGmhfKumrROCQx1Z0tZ0bbuzXyjakr/xMLrz3IZAgqt2iJJb
         HKFp4U8cvWMp9UlRjy3StoThZIM78f+RBn8O5LUm26RX7Z3mL5bXsZnslGLvJE21Vuf5
         yMvQCxNvCECqWfJpSGCRX8vh6RCIQ7QsKOOLOxTtBdULvig2EVbSRaKSrzsHLr8nzQks
         Rn9g==
X-Forwarded-Encrypted: i=1; AJvYcCVKA73+9QaQpY9sFlBOtHUenHkNy63m8EVUUoxuUS72HJt26rgbPo2C6z9Ixi90/KzzrhmL+PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+mGeZV/c8gs4HPSxIvUjad40kxgYEU4WDGxHax0MW0rqZnaS
	jYecs7+k+VAXPzytxmlCmgzekiUmAc4+kpBjj3U3SozHVb58EB8iXrFjuHKdXVvBNJSjpH4Eomm
	XNegmKR9rxw4n/EZFPITLo+y5QsfoITqhoCG5RB0N
X-Gm-Gg: AZuq6aLMOqPBnW3MrKiA4JXnuE9BNvBzwZ+3tr179mMcEJYdO3FKRY5XSBrRwyIxDQ3
	l+6+2Y1/CTTW/dCY4w5N69lYGOzKSjSGJQKdUdL5E2ZiwrW6B+EQkMECT1a40+TDDOr+1Bq67YX
	UJVIrpTCtHh555qzZ0W+0NjzUGzktMX/VZBScDWONRS3+j/GdVlMUTiMMd6LyZ4NxidnM1tkeUI
	c2aiIqDWzkeaxwi3k9ACRJk+Wvg1LmrWcJrsUA+Yp+CHac/fOixmhcpxQtC4ma208G+wbyLv0Uf
	z3Q=
X-Received: by 2002:a05:6a21:730e:b0:38d:e9e8:25e0 with SMTP id
 adf61e73a8af0-392e0051edemr6582546637.20.1769879652878; Sat, 31 Jan 2026
 09:14:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
 <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org>
 <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com>
 <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org>
 <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com>
In-Reply-To: <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Jan 2026 12:14:01 -0500
X-Gm-Features: AZwV_Qgs08CtqhIcbX8IL2co-VDwAiZD2ridaHVUhIq8MI3H4zkSvLzNniTVE_E
Message-ID: <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Po Liu <Po.Liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212952-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,nxp.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1g4.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim,mojatatu.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B0503C3241
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:51=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> .
>
> On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
> >
> > What version of act_gate.c are you currently testing?
>
> I am running plain ubuntu on this machine using their shipped kernel 6.8.=
0.
> But i did look at the latest kernel tree and the dumping code has not cha=
nged.
> +Cc Po Liu who i believe added that code.
>
> >Did you actually run the tests? =E2=80=9Clarge dump=E2=80=9D creates ONE=
 action at base_index, with num_entries=3D100, then immediately does GETACT=
ION. So =E2=80=9Ctc actions ls action gate | grep index | wc -l=E2=80=9D wo=
n=E2=80=99t exercise this, because it only counts actions. It doesn=E2=80=
=99t amplify the per action dump size (the entry list does). It uses libmnl=
 (mnl_socket_sendto / mnl_socket_recvfrom) with MNL_SOCKET_BUFFER_SIZE. The=
re is no custom netlink handling. The failure is returned by the kernel bef=
ore userspace parses anything. The dumps are transactional at the netlink l=
evel, but an individual action dump still has to fit in the skb backing tha=
t message.
>
> Sorry - I am not running your code (didnt want to compile anything on
> this machine), just plain tc and i have to admit I dont know much
> about the mechanics or spec for gate, so my example is based on
> something Po Liu posted, here's a script to add 100 entries:
> ---
> for i in {1..100}; do
>     echo "$i"
>     tc actions add action gate clockid CLOCK_TAI sched-entry open
> 200000000 -1 8000000 sched-entry close 100000000 -1 -1
> done
> ---
>
> Then dumping:
>
> $ sudo tc actions ls action gate | grep index
> index 1 ref 1 bind 0
> index 2 ref 1 bind 0
> index 3 ref 1 bind 0
> index 4 ref 1 bind 0
> index 5 ref 1 bind 0
> index 6 ref 1 bind 0
> ..
> ...
> ....
> index 95 ref 1 bind 0
> index 96 ref 1 bind 0
> index 97 ref 1 bind 0
> index 98 ref 1 bind 0
> index 99 ref 1 bind 0
> index 100 ref 1 bind 0
> $
>
>
> >
> > look at af_netlink.c
> >         /* NLMSG_GOODSIZE is small to avoid high order allocations bein=
g
> >          * required, but it makes sense to _attempt_ a 32KiB allocation
> >          * to reduce number of system calls on dump operations, if user
> >          * ever provided a big enough buffer.
> >          */
> >          ...
> >         /* Trim skb to allocated size. User is expected to provide buff=
er as
> >          * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped a=
t
> >          * netlink_recvmsg())). dump will pack as many smaller messages=
 as
> >          * could fit within the allocated skb. skb is typically allocat=
ed
> >          * with larger space than required (could be as much as near 2x=
 the
> >          * requested size with align to next power of 2 approach). Allo=
wing
> >          * dump to use the excess space makes it difficult for a user t=
o have a
> >          * reasonable static buffer based on the expected largest dump =
of a
> >          * single netdev. The outcome is MSG_TRUNC error.
> >          */
> >
> > This is where I am currently but I have seen these bugs appear througho=
ut all my iterations including what's in the tree currently, if you show me=
 better alternatives that solve my problems, I'll gladly accept.
> > https://github.com/torvalds/linux/compare/master...jopamo:linux:net-sta=
ble-upstream-v4
> >
>
> I dont see a problem with "dump" as you seem to be suggesting. I asked
> earlier if it is possible that you can create some single entry - not
> 100 as shown above that will consume more than NLMSG_GOODSIZE? My
> limited knowledge is not helping me see such a scenario.

Aha. I think there is a terminology mixup ;->
"dump" (a very unfortunate use of that word in the netlink world ;->)
is a very special word. So when you take a dump in this world you are
GETing a whole table. In this case all the gate actions.

If i am not mistaken in your case this is not a dump - rather, you are
CREATing a single entry which is bigger than NLMSG_GOODSIZE as i
suspected. I dont believe iproute2 will allow you to do that.
What's happening then is that the generated netlink event notification
for that single entry is too big to fit in NLMSG_GOODSIZE.
Let me try to craft something for that...

cheers,
jamal

