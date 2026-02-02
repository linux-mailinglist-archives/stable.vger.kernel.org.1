Return-Path: <stable+bounces-213073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDkKDly2gGl3AgMAu9opvQ
	(envelope-from <stable+bounces-213073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 15:36:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFA6CD701
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 15:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6414301A28D
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 14:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57B366547;
	Mon,  2 Feb 2026 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LzVbXI/J"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A78E201278
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042808; cv=pass; b=LnW5v2Nbbsjq7uO0sxQ2Q9+NBwv8RLDt6mv7ROTFmmS8LarzfOr9AITLuFhLGkbxIKz/FwikOTLXOqm5+DTbWpBvzOL/G+c/lI+aELVO+ZUe6Jb8Fu3EicOQVuPZea5bqA9OrhzmoskyWTIBTuew6CYcDAkzyvbY8+ONvavTic4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042808; c=relaxed/simple;
	bh=rttmNuWusH7qccVhVLCQ73bvX4CWnAQD22kmDWZRRek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpF9AuqW96UoSCcBZCM1yWkdZmV7/OMASXz4X4lMO0QoxvQtQxuV31lbq4EnhMYoCJORYqcQLBdIWMyp4223QJq+FSbRhoBAlSCQLl4HPRQap8wpAmUKaNLysm0WwD+tq8tQZDiN31samGnR/bZnNe1ZdxBkfvEEUSCWVTB/AtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LzVbXI/J; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a09757004cso36481295ad.3
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 06:33:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770042806; cv=none;
        d=google.com; s=arc-20240605;
        b=TKN5hRiJk3GSiIM/84r/naYxefV6XHwy6bwWLP3Cc1uqTzI/CCEpvUOzYkedlW7/rP
         Wjop+43GgmsfWnK7eutCEHmAYRi4allPPFS1/Bo0oF/5fG6xVwarNmxdl50HM3ziQAB8
         kmrdewhj7sHAJuR391EO7JmYxQZ58h/YOswddQWBh8Y9UMhAqYdCGrxYYiLO0UoE0WC0
         ZYSqumYkTzIxFBHwlIJUBGWRdT3MB0MS9duUXTbg8toqq5I3he9FvWbET2mtRNthh6aW
         8fAM+FSnZ0KKMEJejZwnn1EvH6v8HwV1T5h76E+JQICXfdTZvxYGoVFNkhoqruazS7aL
         LYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eYE0wZxxIpQtu5hng+JjsPotgJeCd9CVKo0jGF26qbc=;
        fh=zOHIp3X/Tm0d8DZ14odunIxDF+7u5JLhAhO/l3rULq0=;
        b=N0u/ROjJCL2bRAKBGyQaaQrPRKRWkeMTgJcyusNFxGp+rnmtGqEHG8GBgtHUtjpZFX
         hZlXPGL1mdDIpTW0MJQ5Rco1kCWiySC1XUklXWxfyYZhYLTIbhhQF6kkW3ghfTZckvqI
         hicFO7jtNm/i654F03wLJJ2gFmhkIWtCmdQ1MhQgmNVo/NBpUn4MmugeGYkxDOLktjJr
         DUCek5l0RYAjMu5xxQ0UD/DP3EOn0+HFfhrQV7wfRYd+4Dv5lUljhyyxkKpK8jtcutH3
         jukzCGhr65yxhFs+fTFuAHrnx6ZBgg2h5QKqSMpTFOi13NwhKKZfkVrQeD32m6HrSW+Y
         eHAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770042806; x=1770647606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYE0wZxxIpQtu5hng+JjsPotgJeCd9CVKo0jGF26qbc=;
        b=LzVbXI/JwMMW+E5dbC4PM15AQN5+JwrONxTaYxCMKzh3kA36jYBOZ9PRZb2DCI9+yu
         oYNxXSPrWohfbrAPLf0nl+4qNB1eweUi+MV0g0gmFyt0gzIh+fKGdxZLN7fwHteO8G9P
         5gpjcVyO1sQ8WorKuSlSjYBQbSUuy20o1xhjZZwrw/J6hOwd+Im9X6240UX9Blv0BNbm
         /5koUPH8G/ZGr67EFqIZC0GAyNW+jPKoF0Abb+PR7ScnqmGW3EZ28KbIRl+FM3v5QoGy
         vfZyJbWswz5R+ol6NQoK13RgHyu4mwx+bfwGJfm5IrfA7gqs/1QbCtLYuRWZYFH7yG+j
         AObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770042806; x=1770647606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eYE0wZxxIpQtu5hng+JjsPotgJeCd9CVKo0jGF26qbc=;
        b=KeTMd1i4Mnos44DLfl3Ub0qZcI/IRLgGntUUI2wgD/nkcxCkSj8VIICwKAQxPscIQi
         ErQnKTaHgmpnLzzyZM//e/UVaveP79cKHlaQ3pd8qbUke0pHQ6FZDLr9CSs53wZLiZf1
         4SZHLMGDXcfoSc8P76bWpvAV4mql9K1/QEoD+A3id+o2du+UDC+bNEQR9bYEvb7tO9L7
         xL6jWEHwwVx8dQlqzjzuibaSRPG+4ruceaTfKDsOpF/ouRgiWXkQI9y98yl/MSh0m7up
         kdEe5TXSHJ24Ts8NgOU+yTkeNs0fcKDNQDYCr4V+McphQ1LiThRimNMWZEVhWcYj5DFQ
         2Yyg==
X-Forwarded-Encrypted: i=1; AJvYcCVY2yzikBwIpDQCkuM+MeFxU5pqRzB3sOot+aDXyb8JhvGLqZ2uYonA3gWGeDTfqZAa8Ry38nE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfKXTltH0IkqhVUb1o5JrZOVgheIFRwxUE6WaeVRDBQOLcWgBK
	urty19xUbC3R9p4u62CHvgTKebjmOjc6AtNqTmQkTLbOX9ZhixC+Ij1M3m4iKwrDF4Hx/Ta+GPV
	Y4YIt4zs1+QQaZjOXG233uJrQ7k/D50Gxz60wmiQO
X-Gm-Gg: AZuq6aK4brTrlNZP0VdxdloUJHDRCuXLwmk3eoLSoVU3H1ClmgwKSUWgaxzMATExSWa
	mQRCWqCRdTe6LhhkNjwyzuNfGBihMw/Zol3f738sXFc84ou8pvDCo8ycNjvDIU4LKgcANhwFVa7
	cNm0Wi5mNa+a0FOTtFbENg3n3aVKe1RLZR2DKhjf4nlckA6qSs0BuL+7m7F9KxxsPpFgqwMBTs3
	HwTS9DyA2j6h9qvDSOLxYgvnHktvpPfVW0ErycCAFc38hpSW2Cm1KP46uZaGOqXRHttF2KXy9F9
	OUk=
X-Received: by 2002:a17:902:fc44:b0:2a1:4c31:335 with SMTP id
 d9443c01a7336-2a8d96bc4f1mr134666545ad.26.1770042805751; Mon, 02 Feb 2026
 06:33:25 -0800 (PST)
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
 <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com>
 <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org>
 <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com> <tRA-1eVt0Av_cRCmND6povnCqYiBpaOoilgpCM2qNbo3GIe6szAEIN1mI20gRjgf215ODBQJBfolBlBzyJ4en67AQVHhLt6QmtWlQUjLqfc=@1g4.org>
In-Reply-To: <tRA-1eVt0Av_cRCmND6povnCqYiBpaOoilgpCM2qNbo3GIe6szAEIN1mI20gRjgf215ODBQJBfolBlBzyJ4en67AQVHhLt6QmtWlQUjLqfc=@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 2 Feb 2026 09:33:14 -0500
X-Gm-Features: AZwV_QhE29Vcmz-NeP9u6YXNFwU06prsCGmPwM2Caylr8ibuAj73YXeHx6C4Ltw
Message-ID: <CAM0EoM=T4QiGB+_3jqWKYze_OrcsjYBy0UvckTiGtHkxSm6BDQ@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213073-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,1g4.org:email]
X-Rspamd-Queue-Id: 7FFA6CD701
X-Rspamd-Action: no action

On Sun, Feb 1, 2026 at 4:57=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> The hardware manufacturers impose their own limits based on design constr=
aints, it's not based on the spec. iproute2's value seems arbitrary, 1024 c=
omes out to be about 32 entries, based on the message length of 3112 at 100=
 entries (this isn't counting overhead). Is page size ever less than 4k? Ma=
y as well see what can safely fit into NLMSG_GOODSIZE at it's lowest possib=
le value.
>
> With 4k page size, the failure point appears to be 93 entries:
>   large dump                     DEBUG: large dump msg_len=3D2904 cap=3D1=
2288 entries=3D93 cycle_time=3D9304278
>
> So bounding it at 64 entries or so(for now at least) would be a safe choi=
ce to maintain a margin and not impose arbitrarily low values.
>

Why dont we pick some value that doesnt require changes to iproute2? Exampl=
e 32.

> Yes, I've wanted to talk to Po for a while now. :)
>

There has to be someone else, vendor, etc who is invested in this..
That looks like magic valves to me that open/close - not sure why you
want to do it more than once.

cheers,
jamal

> Thanks,
> Paul
>
> On Saturday, January 31st, 2026 at 11:34 AM, Jamal Hadi Salim <jhs@mojata=
tu.com> wrote:
>
> >
> >
> > On Sat, Jan 31, 2026 at 12:18=E2=80=AFPM Paul Moses p@1g4.org wrote:
> >
> > > 1. Your script creates 100 separate gate actions, not one gate action=
 with a large schedule.
> > > 2. Each =E2=80=9Ctc actions add =E2=80=A6 gate =E2=80=A6=E2=80=9D cal=
l creates a new action, so you end up with 100 small actions.
> > > 3. The issue I am reporting needs one single gate action that contain=
s many sched-entry objects.
> > > 4. Because of that, your test only exercises the dump path with many =
small actions.
> > > 5. The failure I see is in the GETACTION notify path, not in the gene=
ric dump batching logic.
> > > 6. In that path, tcf_get_notify() allocates a fixed-size skb using NL=
MSG_GOODSIZE.
> > > 7. The kernel then tries to serialize one action into that skb.
> > > 8. If a single action contains a large gate schedule, tca_get_fill() =
runs out of tailroom and fails, and the kernel returns -EINVAL.
> > > 9. A single sched-entry does not exceed NLMSG_GOODSIZE.
> > > 10. The problem is one action with many sched-entries, because the en=
tire entry list is serialized into the payload of that one action.
> > > 11. The =E2=80=9Ctotal acts 12 / 12 / 76=E2=80=9D output only shows h=
ow many small actions were packed into each dump batch.
> > > 12. It does not reflect the size of an individual action dump, and in=
 your test each action is small.
> > > 13. To reproduce with tc, you need one tc invocation that adds many s=
ched-entry attributes to the same gate action, and then run =E2=80=9Ctc act=
ions get action gate index <idx>=E2=80=9D on that action.
> > > 14. tc has it's own limit at 1024 apparently "addattr_l ERROR: messag=
e exceeded bound of 1024"
> >
> >
> > Yes, thats the same error i was getting (with script below).
> > ---
> > ENTRY=3D"sched-entry open 200000000 -1 8000000 sched-entry close 100000=
000 -1 -1 "
> > SCHEDULE=3D$(printf "$ENTRY%.0s" {1..100})
> > #SCHEDULE=3D$(printf "$ENTRY%.0s" {1..10})
> >
> > for i in {1..2}; do
> > echo "Iteration: $i"
> > tc actions add action gate clockid CLOCK_TAI $SCHEDULE
> > done
> > ----
> >
> > I know of no other action that exceeds this limit with all its params
> > batched, and of course tc in userspace truncates it to about 32.
> > Addition does succeed at 32 of those things per action.
> > I have no idea if above is legal but it is allowed by the system.
> >
> > > I'm not opposed to gate being clamped instead of adding support for l=
arge schedule sizes, but I wanted to thoroughly document why it's not possi=
ble so the next person isn't chasing a cryptic -EINVAL like I did.
> >
> >
> > We cant have it to be infinite for sure - we will need to put an upper
> > bound in parse_gate_list().
> > Are you knowledgeable about this spec? I was Ccing Po Liu but his
> > email is bouncing (so i removed him).
> >
> > So back to your first post: I agree we have an issue here. Your
> > solution will solve the event notifications but then we will need an
> > upper bound check. We will also need to check that same upper bound in
> > user space iproute2 code so we dont allow arbitrary values. Current
> > number of 16 seems to work just fine - if we agree that is a "good"
> > number (or if the specs dicate it is) then you can simply provide that
> > fix..
> >
> > cheers,
> > jamal
> >
> > > Thanks
> > > Paul
> > >
> > > On Saturday, January 31st, 2026 at 11:14 AM, Jamal Hadi Salim jhs@moj=
atatu.com wrote:
> > >
> > > > On Sat, Jan 31, 2026 at 11:51=E2=80=AFAM Jamal Hadi Salim jhs@mojat=
atu.com wrote:
> > > >
> > > > > .
> > > > >
> > > > > On Fri, Jan 30, 2026 at 3:48=E2=80=AFPM Paul Moses p@1g4.org wrot=
e:
> > > > >
> > > > > > What version of act_gate.c are you currently testing?
> > > > >
> > > > > I am running plain ubuntu on this machine using their shipped ker=
nel 6.8.0.
> > > > > But i did look at the latest kernel tree and the dumping code has=
 not changed.
> > > > > +Cc Po Liu who i believe added that code.
> > > > >
> > > > > > Did you actually run the tests? =E2=80=9Clarge dump=E2=80=9D cr=
eates ONE action at base_index, with num_entries=3D100, then immediately do=
es GETACTION. So =E2=80=9Ctc actions ls action gate | grep index | wc -l=E2=
=80=9D won=E2=80=99t exercise this, because it only counts actions. It does=
n=E2=80=99t amplify the per action dump size (the entry list does). It uses=
 libmnl (mnl_socket_sendto / mnl_socket_recvfrom) with MNL_SOCKET_BUFFER_SI=
ZE. There is no custom netlink handling. The failure is returned by the ker=
nel before userspace parses anything. The dumps are transactional at the ne=
tlink level, but an individual action dump still has to fit in the skb back=
ing that message.
> > > > >
> > > > > Sorry - I am not running your code (didnt want to compile anythin=
g on
> > > > > this machine), just plain tc and i have to admit I dont know much
> > > > > about the mechanics or spec for gate, so my example is based on
> > > > > something Po Liu posted, here's a script to add 100 entries:
> > > > > ---
> > > > > for i in {1..100}; do
> > > > > echo "$i"
> > > > > tc actions add action gate clockid CLOCK_TAI sched-entry open
> > > > > 200000000 -1 8000000 sched-entry close 100000000 -1 -1
> > > > > done
> > > > > ---
> > > > >
> > > > > Then dumping:
> > > > >
> > > > > $ sudo tc actions ls action gate | grep index
> > > > > index 1 ref 1 bind 0
> > > > > index 2 ref 1 bind 0
> > > > > index 3 ref 1 bind 0
> > > > > index 4 ref 1 bind 0
> > > > > index 5 ref 1 bind 0
> > > > > index 6 ref 1 bind 0
> > > > > ..
> > > > > ...
> > > > > ....
> > > > > index 95 ref 1 bind 0
> > > > > index 96 ref 1 bind 0
> > > > > index 97 ref 1 bind 0
> > > > > index 98 ref 1 bind 0
> > > > > index 99 ref 1 bind 0
> > > > > index 100 ref 1 bind 0
> > > > > $
> > > > >
> > > > > > look at af_netlink.c
> > > > > > /* NLMSG_GOODSIZE is small to avoid high order allocations bein=
g
> > > > > > * required, but it makes sense to attempt a 32KiB allocation
> > > > > > * to reduce number of system calls on dump operations, if user
> > > > > > * ever provided a big enough buffer.
> > > > > > /
> > > > > > ...
> > > > > > / Trim skb to allocated size. User is expected to provide buffe=
r as
> > > > > > * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
> > > > > > * netlink_recvmsg())). dump will pack as many smaller messages =
as
> > > > > > * could fit within the allocated skb. skb is typically allocate=
d
> > > > > > * with larger space than required (could be as much as near 2x =
the
> > > > > > * requested size with align to next power of 2 approach). Allow=
ing
> > > > > > * dump to use the excess space makes it difficult for a user to=
 have a
> > > > > > * reasonable static buffer based on the expected largest dump o=
f a
> > > > > > * single netdev. The outcome is MSG_TRUNC error.
> > > > > > */
> > > > > >
> > > > > > This is where I am currently but I have seen these bugs appear =
throughout all my iterations including what's in the tree currently, if you=
 show me better alternatives that solve my problems, I'll gladly accept.
> > > > > > https://github.com/torvalds/linux/compare/master...jopamo:linux=
:net-stable-upstream-v4
> > > > >
> > > > > I dont see a problem with "dump" as you seem to be suggesting. I =
asked
> > > > > earlier if it is possible that you can create some single entry -=
 not
> > > > > 100 as shown above that will consume more than NLMSG_GOODSIZE? My
> > > > > limited knowledge is not helping me see such a scenario.
> > > >
> > > > Aha. I think there is a terminology mixup ;->
> > > >
> > > > "dump" (a very unfortunate use of that word in the netlink world ;-=
>)
> > > >
> > > > is a very special word. So when you take a dump in this world you a=
re
> > > > GETing a whole table. In this case all the gate actions.
> > > >
> > > > If i am not mistaken in your case this is not a dump - rather, you =
are
> > > > CREATing a single entry which is bigger than NLMSG_GOODSIZE as i
> > > > suspected. I dont believe iproute2 will allow you to do that.
> > > > What's happening then is that the generated netlink event notificat=
ion
> > > > for that single entry is too big to fit in NLMSG_GOODSIZE.
> > > > Let me try to craft something for that...
> > > >
> > > > cheers,
> > > > jamal

