Return-Path: <stable+bounces-212950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDnlHgszfmmTWQIAu9opvQ
	(envelope-from <stable+bounces-212950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 17:51:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F43C3145
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 17:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 740A630091CC
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D829341678;
	Sat, 31 Jan 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KfB8BQ1F"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A114E2D2491
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769878278; cv=pass; b=nbvfHasjScNpxtPCcz0FItyh+JeD9P7V6KxsrrNxmxLchbMm0Rv0py5FdoFiVVjwNC/aYTVL6gKlzNMKKMtQbIiEnW2NRzJB7UiXw0szpsN0f5qnKnFm2pHoA1O0KZ/vdwkR5u/tEMnSck5jva3N2qRh93Va/pX5URNPcZAAINo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769878278; c=relaxed/simple;
	bh=PlKDov0CfRrzdYPEAvA5RZPww3ErXc+h3pemJ8YZZU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PG21oog7BUYZ0RH3zAkdKx3uSo1QPZCuR+d/zeCdLMqp4e/dGYVbxB6IPc8EmjxlfAOyv04Y4G1UaLdpPr0EYiWGgep+XusZVHQNCUp7tXkXqLYJLOcaWz0JGVoqRiqcC2YXlpvH+ov7PfMHORcHJqgnUDtBjQeEH6lGq446NgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KfB8BQ1F; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a1022dda33so20258995ad.2
        for <stable@vger.kernel.org>; Sat, 31 Jan 2026 08:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769878276; cv=none;
        d=google.com; s=arc-20240605;
        b=XfBUpN54uHAmkBiI3D9RZMELVaNLz3KmDA7BwX4aEN4+rrBWDKFbDq2okJKOkT5OCz
         b/yAloUeRKq5YBzDD4j3EByymKhZEAkRDmo7r4En6N9xrIG2vPPUx3WBm4ryGHD7d+xn
         5rU7DHEEDgAhdy236ICCV2CN60Jz/qmyTbB68T7mJn/qdHhkskFKWemGOJnkmnuV6U4Z
         DBK7ErmKxoXEHxopQq/1S+jIkNpNiOVSUBJiTy6GhxRAgOC8J6UX76VWp+Grjvjwp5cq
         EK/sfHbq5yDCa4TryPgUfEcqFBIWcEc8fc+zMU7+erbc22QosWEIbkdu+9zWAB+ymGnF
         U9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TwOhp3zvds/DC2IPQt15OObsZRJJzyJCu2Sudhqgw2Q=;
        fh=qI151vpLEaC6e6PapYPIBnv6JUpn1hThqE7Rw1Ej/cQ=;
        b=BGIeOe8zRHmjelnAWjt7QGo2wVWKUaoJOOlNYP78Os7xU3fL8oI/oMEJ4uNZmVsv7n
         K16o89rNz3MbJ6tbKmtQMoi+02bkjuaW9HD2Mh5FeW1YMP3rgbdFfYli2PJUEoGhLKsc
         DJRK46DGudOtPzcvbUyfDWQPTUB2DfmCIVpFuTVkWp5PEvJ3tx26z2cXxRopkDvskJ+v
         kFnLADiVfB1jyH6T+Ja/2np1jhMs0i90xGktNP55sYFfZMjFXRRPtdEDqgFRpKlq2+7b
         DIjr/vy6ogksPJi3iYLGoZFa/OjqhK5Z3fiJ3ivEz3uh5/UW+y0AMdJbaAs+r9xTrVF6
         rlWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769878276; x=1770483076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwOhp3zvds/DC2IPQt15OObsZRJJzyJCu2Sudhqgw2Q=;
        b=KfB8BQ1FdaKteUXVdB5oznY4T7as0z96BWE8n2lRP4Nd+QNqHq16CDukhtve3gaBjM
         h2rkxofcP2YhIxlXon6/caU1o0nsJMpFxx+SQBkol+oWWZdp17ncUFNCPO6cUgTM1PSP
         JDb49s4uvoRoNKBlDkbJB4GP+TUNo93QC6ZJw/sodgJh5N1kCdJII1KgXzeIJCgq2hOx
         DV51KikrpEy1PDrQvSE58sqNkStAeMuNestUr5/+ET6QWn+CgpIxYWXF5MMRxchbavFI
         L6GFY+qGpnnIz6NLBxJEIcgHlzRk1oo0a6lQtxyDC1cjxK8z7mM5Jv4GAcnk6/WOZbO7
         aPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769878276; x=1770483076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TwOhp3zvds/DC2IPQt15OObsZRJJzyJCu2Sudhqgw2Q=;
        b=pXZ3b54g0QwZUZ91P/TRj7aUGjewwVBEh+zN9sPsFGUdlci82NeqGI9FkTpceRxnwu
         lcZg/qsbhX9MfkskquyG3XFz0P5eEmMce1lr7CRnNYOGKiwRhVFzXkH11K6RFQUm/rAW
         ymRxvQSd5UzAZkZ/0BSN8uILDJ2luOMQj2Fhra3uJI2YxgC0sIcFpJdpCllNKlX6jXbS
         nIV2T9ExqFFAaVZrqKYFrO+mxCP4F1ASsPd6GFdnk1Ei9IHOObRWToIiA8dvvGL0+LzR
         nGs7BL5flbT+CkTqiRv6zwOJ6XgOlih+jwnsIZWwRMFsMYaXGd07+4DX7Va6A2xby0rB
         PYMg==
X-Forwarded-Encrypted: i=1; AJvYcCU1+GlZxCbF55MYCJrFbT4icz316VxPyILfSN2BloNGTLKQrs1jRPH2JSFXayK56nxWmG+sNSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVFlDuY/PA9DkKJVgalDJDzY5RsxF3yRcpgqsA8Uwm29TsIxH
	KPhcY+Zy3hT4qRj3JIfU0HS+oL+Q9BWb+qm7/vxw6O9Av7vD8455mtqgnPYYrba2W0CQB73Wcre
	EZqR3eNpWu5HPPPZxq3oPsR8WoJzErTmHv0L/qLzP
X-Gm-Gg: AZuq6aKoSrRCApHRalxLyholN0ys8nW2oIzl+NsCAiCDFJSa+z1RpDFQQXupX/fFTi4
	T/93dL4AvRE1ST21cbq5lRB70qa8P+NZUtNSs8ltTJsUpXf97QZ8Fm+VX8BbAyB+xSF2/++ZeJe
	gCnifaQrE7GE/Wf19uGfRVP3YB9nCyoZrhIwmMKNNTgT0JiIm46JkIoJyiXVe79nirDYM6Lbn1E
	OEkdbQiMeuSwtOquJArnWMSMpEj2s0uc0aclGgiNgGqgKgzxrI7N3juYUzyDNSNmNxiW3Co8qiz
	9P0=
X-Received: by 2002:a17:903:2bcc:b0:2a7:ca82:c198 with SMTP id
 d9443c01a7336-2a8d9593256mr66751155ad.6.1769878275702; Sat, 31 Jan 2026
 08:51:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134220.305757-1-p@1g4.org> <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
 <Fkv_0Ju_R82Hh-rBUDW7uALCp8vjL8WZqAsQhreDrulXNad2A2PlNWkSO-95bSzYNai0wYDsZZZFtC2-YAr-B9ZWWtNg8iqafAMDUA0F7Pc=@1g4.org>
 <CAM0EoMmY-v0HWAkB5EgSYhpca8fXVX7SQ1SpVbUBcFpbvuTd1g@mail.gmail.com> <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org>
In-Reply-To: <pXV1wsavqcYDq5HfAVaW_gMoTITR9M0PBWKhnz9n6VHYxhW56DQU7qfCEoaYcCixz4iqrj31Mt9vL9bHqTNGygLK5pYvyw1z3san5ndlkkQ=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Jan 2026 11:51:04 -0500
X-Gm-Features: AZwV_QhbvdUGGDKHMSVrKRp__slOASeUl2cG-7KOOlKDJEhjhAF8ghls5VrtbvI
Message-ID: <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212950-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,1g4.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0F43C3145
X-Rspamd-Action: no action

.

On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> What version of act_gate.c are you currently testing?

I am running plain ubuntu on this machine using their shipped kernel 6.8.0.
But i did look at the latest kernel tree and the dumping code has not chang=
ed.
+Cc Po Liu who i believe added that code.

>Did you actually run the tests? =E2=80=9Clarge dump=E2=80=9D creates ONE a=
ction at base_index, with num_entries=3D100, then immediately does GETACTIO=
N. So =E2=80=9Ctc actions ls action gate | grep index | wc -l=E2=80=9D won=
=E2=80=99t exercise this, because it only counts actions. It doesn=E2=80=99=
t amplify the per action dump size (the entry list does). It uses libmnl (m=
nl_socket_sendto / mnl_socket_recvfrom) with MNL_SOCKET_BUFFER_SIZE. There =
is no custom netlink handling. The failure is returned by the kernel before=
 userspace parses anything. The dumps are transactional at the netlink leve=
l, but an individual action dump still has to fit in the skb backing that m=
essage.

Sorry - I am not running your code (didnt want to compile anything on
this machine), just plain tc and i have to admit I dont know much
about the mechanics or spec for gate, so my example is based on
something Po Liu posted, here's a script to add 100 entries:
---
for i in {1..100}; do
    echo "$i"
    tc actions add action gate clockid CLOCK_TAI sched-entry open
200000000 -1 8000000 sched-entry close 100000000 -1 -1
done
---

Then dumping:

$ sudo tc actions ls action gate | grep index
index 1 ref 1 bind 0
index 2 ref 1 bind 0
index 3 ref 1 bind 0
index 4 ref 1 bind 0
index 5 ref 1 bind 0
index 6 ref 1 bind 0
..
...
....
index 95 ref 1 bind 0
index 96 ref 1 bind 0
index 97 ref 1 bind 0
index 98 ref 1 bind 0
index 99 ref 1 bind 0
index 100 ref 1 bind 0
$


>
> look at af_netlink.c
>         /* NLMSG_GOODSIZE is small to avoid high order allocations being
>          * required, but it makes sense to _attempt_ a 32KiB allocation
>          * to reduce number of system calls on dump operations, if user
>          * ever provided a big enough buffer.
>          */
>          ...
>         /* Trim skb to allocated size. User is expected to provide buffer=
 as
>          * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
>          * netlink_recvmsg())). dump will pack as many smaller messages a=
s
>          * could fit within the allocated skb. skb is typically allocated
>          * with larger space than required (could be as much as near 2x t=
he
>          * requested size with align to next power of 2 approach). Allowi=
ng
>          * dump to use the excess space makes it difficult for a user to =
have a
>          * reasonable static buffer based on the expected largest dump of=
 a
>          * single netdev. The outcome is MSG_TRUNC error.
>          */
>
> This is where I am currently but I have seen these bugs appear throughout=
 all my iterations including what's in the tree currently, if you show me b=
etter alternatives that solve my problems, I'll gladly accept.
> https://github.com/torvalds/linux/compare/master...jopamo:linux:net-stabl=
e-upstream-v4
>

I dont see a problem with "dump" as you seem to be suggesting. I asked
earlier if it is possible that you can create some single entry - not
100 as shown above that will consume more than NLMSG_GOODSIZE? My
limited knowledge is not helping me see such a scenario.

I looked at the transaction of how the 100 entries are dumped and i
see the following:
$ sudo tc actions ls action gate | grep total
total acts 12
total acts 12
total acts 76

User space received batches of 12, 12, and last one was 76 before it
received an empty message with NLMSG_DONE.

cheers,
jamal

