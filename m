Return-Path: <stable+bounces-214566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Cg5AEYMhWmj7gMAu9opvQ
	(envelope-from <stable+bounces-214566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:31:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 511AAF7B16
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 22:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B9B63032982
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 21:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E2C331A61;
	Thu,  5 Feb 2026 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LqbRVVyl"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5394A32B9B8
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770327018; cv=pass; b=LSXxjJMQ5ATKZafZZ/sySC8adTky7D91YUEPh26hfaOpnxnu4ZaKCgkDAOc8sEsCXASDRaBMWm/ZPkC7DoSbNfX7uHvv1izTSqZQ79cUXICbSfObUxkP8wRyje5VCZYVNHsmhYUs8VW6E7pk/w73zCiwz7bawhPqaZfCfbt0ENM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770327018; c=relaxed/simple;
	bh=r7bGCj1W8hBhVmk4jB8dAou6wKVjeSE7+bNLLFhv6kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMk8V3hRAn0E8+oQ2FyUH8kKPj3cpKTh3DXIl94AI1R88DnFq9tOMMq7xaKFQK0rlA4Vy6AOjkMHLJqBGpZccInw+7/oUFT3Jl0/Yv9FCNg0F8HY/peT7rnXFCqMLeutzaUV9tVc6tq9uYclD7g3UAQeBPAe+0AfUVXnRPi7qEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=LqbRVVyl; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-354a69b1455so22785a91.3
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 13:30:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770327017; cv=none;
        d=google.com; s=arc-20240605;
        b=BOSPo8PX5YqkCH0lXCVoyOEnHDmaJSDS24aedUuiMQNVWqv8wfuYuylTVsJAJe4Yhv
         u6Dxg0yuyaZbX6TQyeo0PibKZBrY1Os6zRi7xCJU9khHVI+Iq17vNqBwh59fSTPXL/kZ
         h7FDWhKQntgfQ+mnQTuyasXaMbUm8wVT6bwjhAIxz/rimQshxonLDtpU2KTVTXJTRc07
         +0DB9FBVO3fKj6i6o4Id2TFzlqStuzAgh7GRPRcybQrZh1dzmCjgo+v3rSa/fD1SOk4r
         aBFTmqdvRT1oaiLO25C29GbD8s4UOs2pY0Kl5Az2b3Wo1D5vVs9adaHwXpsveNgbR9n3
         8jEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AA/SWoAsk8If3f1GVrtJ2jpWP0mmLV4gNbmjoHfsI7s=;
        fh=53v9lrQcq+29RTgZ81BjX9LBVgfmOwTEmZcc/e22Rak=;
        b=JIqSdyGy/wGfsYsdNgLMJUtkYp1NGbNLKTAlj1D+yKNvr6cnizppfKtYWpG5meLA2P
         s3HKRnElONYgcoBUOO2OJLt6UpOfLWhYL7xflxHCAt3/9HkgXn2t/rof+c59gOb8ThG2
         ZdxwIKX+5NiZT4kd8OlW2NsuWxfKm1fBNdYog2xv/krU9FbrfPggWqbQNk6OSOe4cQiu
         uGsEtGKR9mUd0oJIsHq96WkgoomKsCDSzpI45SjtWt2WiTyQt8VXFTs9hCoccH/IGTlh
         Aheh82ecNFwXX853e0qgiU988kkCcSHa7jJHWj/OOykjzh9LNBJh392aItYjrWwOHsoM
         SIXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770327017; x=1770931817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AA/SWoAsk8If3f1GVrtJ2jpWP0mmLV4gNbmjoHfsI7s=;
        b=LqbRVVylJ39jj+7UvMpVJrvq7ee1VnONPFAIGuU3Axn/kTyitIBIxjh8DH6LzX4zml
         XOl+42vONlOAqr8EJ3SnNKE5q/5b8+U/c48zBybm5nVhczn/c4bF5Fo58jARLQw++dZ+
         7Xtyn6vcWtytDMSb4LwGyB/QT/aLFZc4CnanPtv1SRBHKH9apqJet6YeyUxf1IojcNS9
         6yUpL7Xg6p1p+/qgPWBpJGqmH77p37EBcYEOd/l2TD4V+rHXT8/Iz3XhbZHHjC4dKl6O
         NYOj/gZE8YhlgdRVEMgA3cd+XvlNlkpYhfZP3+t2ceab7RWqMqtHJmkrUxEw85OW7osJ
         wceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770327017; x=1770931817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AA/SWoAsk8If3f1GVrtJ2jpWP0mmLV4gNbmjoHfsI7s=;
        b=Q0zMZWdWO8k7iKIbSwG5AyLNbY8p4KRwnYQtlyrs5hfZn4YmLtJVTEA8TeI7zIzMg+
         oLYnVBPutl8MRyBfkG5nnTn0mJZw95gG4f1VsmCQG9pBFBwmHx91QX7izdzijGWCTyt3
         DU5HksSBqhGGqZmJizrjJq7Jl1LqkyBwOQSc16lsznjDa2gn/pSwLa6dmsJQxVJVAJ90
         vuHtHkXFU9kh8ANE2bBnYZZB+n/WW9akxcaXQqAxbFDN0uo+wAYYy6q0cpmRoJrHqRlc
         qxcV9yUKmqBX4itfAcVf3/LfpGW26iihMYH4n54kNtV2LDj6HCW/umRclNlF1nN8Wkh6
         g5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe1iazcDsRAHXSPhDyiWqR78tUn0a/T9XQV7GLZpZQ5fF7kYqKfL1WOVBDCJ6ckTWsHtzLzGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwW0wqX2YCFeAGnsYSpt1fW0iRLvbrVwOX6vQxG/oqdA8K4EAU
	d76x3v3/0S/BU3OrI8H1BzdtdYPlx9K93xb/qIniDgjuJ3CdqaDrh86mhZnDxf/cUeOihBjFVAK
	hwuag3zsth35wFWcXAG0aWy4BF9S+k5MalycPXRrQ
X-Gm-Gg: AZuq6aJxfE0WjMCbsG6chOqqlZZ39+pNAYS6k9jYej/3H6AS42vkEHFO7ERLiyC0Amu
	EE79tYkQiO+94wYVmwfu24kyU0ji3P/nvHn5NBYO7TlS0I087/im0uz/aCgb3J2k9fWcd88S6+n
	NYsN4zRX/UyekMVCr9z+41tUHmSiEEf5Ry5wA7zEiax6TmwzSXIX4stLAEY9OvuILN7rasWBgNt
	BjDDvtZX/+/TN85dsRsl1IJOawv51fF0RtEzih7LWVT3v9MqeDzvJbwaPD8PnFHBhndxIr4HWqR
	kIk=
X-Received: by 2002:a17:90b:55cf:b0:340:ec6f:5adb with SMTP id
 98e67ed59e1d1-354b3c373afmr333794a91.3.1770327017506; Thu, 05 Feb 2026
 13:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkBb+d_5dn6vdtSxPJ-HuUUL9uei65euSQfX3bXYm9RAw@mail.gmail.com>
 <CAM0EoMnseQw6H+a4wzhg7BkPJraFwN-=2x4FOSOUp5f7=XbyaQ@mail.gmail.com>
 <tuZof6471icLlkjecTuMCBxpZ5zJVhOeUv7lAK7MFwt3g7LfrH7ZFlbE5odrcbTFUukV6J8Dywy9daCrLI-kiY-_vpiABXStvdudLw-HXDI=@1g4.org>
 <CAM0EoMkD=3aRFq=tXijcop5tYsD4X_Ki0REcnj3x+w_C69MaFw@mail.gmail.com>
 <tRA-1eVt0Av_cRCmND6povnCqYiBpaOoilgpCM2qNbo3GIe6szAEIN1mI20gRjgf215ODBQJBfolBlBzyJ4en67AQVHhLt6QmtWlQUjLqfc=@1g4.org>
 <CAM0EoM=T4QiGB+_3jqWKYze_OrcsjYBy0UvckTiGtHkxSm6BDQ@mail.gmail.com>
 <JLZxnCN_V32FjW6UUERYLlLtbbzDCDUmB3LOJ8ovdzV5pbUuGMRKi8K7ebh1j2yDt1u3A0pc1y4Zjjsw6-c7zucKHasFnfvYjnZ7hvT7aR4=@1g4.org>
 <mFDC5blKe5Rmv7qtNQvSSWDJsCdSd_lgeq681gEcHlSg-i8Q3-ZJSDqZfQV4xWFou75jYXgndoO-OE_4-_JNxPtT8rOdAguM_Xwl-qX8B6A=@1g4.org>
 <CAM0EoMk75BJYQUXm7FDW=ZmRsUqib3L+9tEAL90q_+DreroeXQ@mail.gmail.com> <20260205203615.t3n3bbqmjscp2cnz@skbuf>
In-Reply-To: <20260205203615.t3n3bbqmjscp2cnz@skbuf>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 5 Feb 2026 16:30:06 -0500
X-Gm-Features: AZwV_Qi0-WMO_KjIzSot3J7ZKepE8M0R_NTfhdmsanPYETG3XS8OTYkeidI0mcc
Message-ID: <CAM0EoMnUm497YUZYbrYeqecF6JYzFbjauV8ACf-h8pjgOd2jdg@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Paul Moses <p@1g4.org>, netdev@vger.kernel.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Vinicius Costa Gomes <vinicius.gomes@intel.com>
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
	TAGGED_FROM(0.00)[bounces-214566-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[1g4.org,vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,intel.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim,mail.gmail.com:mid,nxp.com:email,1g4.org:email]
X-Rspamd-Queue-Id: 511AAF7B16
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 3:36=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> On Thu, Feb 05, 2026 at 02:23:00PM -0500, Jamal Hadi Salim wrote:
> > On Thu, Feb 5, 2026 at 10:13=C3=A2=E2=82=AC=C2=AFAM Paul Moses <p@1g4.o=
rg> wrote:
> > >
> > > Looks like pedit might also affected. Hopefully this makes it more cl=
ear. Going to wait on more input before doing anything else with this.
> > >
> > > NLMSG_GOODSIZE =3D SKB_WITH_OVERHEAD(min(PAGE_SIZE, 8192))
> > > SKB_WITH_OVERHEAD(X) =3D X - SKB_DATA_ALIGN(sizeof(struct skb_shared_=
info))
> > > nla_total_size(payload) =3D NLA_ALIGN(NLA_HDRLEN + payload), with NLA=
_HDRLEN =3D 4 and 4 byte alignment
> > >
> > > Per entry size for the gate list:
> > >
> > > Each entry is a nested TCA_GATE_ONE_ENTRY plus five attributes:
> > >
> > > TCA_GATE_ONE_ENTRY (nest, no payload) -> 4
> > > INDEX (u32) -> 8
> > > GATE (flag, no payload) -> 4
> > > INTERVAL (u32) -> 8
> > > MAX_OCTETS (s32) -> 8
> > > IPV (s32) -> 8
> > >
> > > So one entry is:
> > >
> > > entry_sz =3D 4 + 8 + 4 + 8 + 8 + 8 =3D 40 bytes
> > >
> > > Fixed overhead for one act_gate dump:
> > >
> > > 1. Action wrapper (RTM_GETACTION):
> > >
> > > NLMSG_HDRLEN + sizeof(struct tcamsg) + nla_total_size(0)
> > > =3D 16 + 4 + 4 =3D 24 bytes
> > >
> > > 2. Action shared attributes emitted by tcf_action_dump_1, baseline on=
ly
> > >    (no cookie, no HW stats, no flags):
> > >
> > > TCA_ACT_KIND (IFNAMSIZ) =3D 20
> > > TCA_ACT_STATS nest =3D 4
> > > TCA_STATS_BASIC =3D 20
> > > TCA_STATS_PKT64 =3D 12
> > > TCA_STATS_QUEUE =3D 24
> > > TCA_ACT_OPTIONS nest =3D 4
> > > TCA_GACT_TM =3D 36
> > > TCA_ACT_IN_HW_COUNT =3D 8
> > > action number nest =3D 4
> > >
> > > Total shared baseline =3D 156 bytes
> > >
> > > Optional shared attributes, only if present:
> > >
> > > TCA_ACT_HW_STATS =3D +12
> > > TCA_ACT_USED_HW_STATS =3D +12
> > > TCA_ACT_FLAGS =3D +12
> > > TCA_ACT_COOKIE =3D +nla_total_size(cookie_len)
> > >
> > > 3. Gate specific attributes inside options, fixed part including TM:
> > >
> > > TCA_GATE_PARMS =3D 24
> > > BASE_TIME =3D 12
> > > CYCLE_TIME =3D 12
> > > CYCLE_TIME_EXT =3D 12
> > > CLOCKID =3D 8
> > > FLAGS =3D 8
> > > PRIORITY =3D 8
> > > ENTRY_LIST nest =3D 4
> > > TCA_GATE_TM =3D 36
> > >
> > > Total gate baseline =3D 124 bytes
> > >
> > > 4. 64 bit alignment padding, only when
> > >    !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> > >
> > > There are 7 attributes that trigger the 64 bit padding:
> > > -three stats blocks, three time values and the gate TM
> > > -Each adds 4 bytes, so add 28 bytes in that case
> > >
> > > Putting it together:
> > >
> > > fixed =3D 24 (wrapper) + 156 (shared baseline) + 124 (gate baseline)
> > > fixed =3D 304 bytes
> > >
> > > opt =3D nla_total_size(cookie_len)
> > > + 12 for each of HW_STATS, USED_HW_STATS and FLAGS if present
> > > + 28 if unaligned access padding is required
> > >
> > > The maximum number of entries that fit in a single skb is:
> > >
> > > Nmax =3D floor((NLMSG_GOODSIZE - fixed - opt) / 40)
> > >
> > > If PAGE_SIZE =3D 4096 and sizeof(struct skb_shared_info) =3D 320:
> > >
> > > NLMSG_GOODSIZE =3D 4096 - 320 =3D 3776
> > > Nmax =3D floor((3776 - 304) / 40) =3D 86
> > >
> > > 8192:
> > >
> > > NLMSG_GOODSIZE =3D 8192 - 320 =3D 7872
> > > Nmax =3D floor((7872 - 304) / 40) =3D 189
> > >
> >
> > Seems arbitrary and I was hoping you dont have to change iproute2
> > which restricts the total size to 1KB.
> > Earlier, unless i misread, you said you are looking at IEEE - what
> > does the spec say?
> > If i am not mistaken, the spec is   IEEE 802.1Qbv which unfortunately
> > is behind a paywall.
> > The closest i could find was a vendor talking about it here:
> > https://onlinedocs.microchip.com/oxy/GUID-82119957-1E11-4B69-84AC-EF0EA=
08F5595-en-US-5/GUID-7E7509A4-351E-4D82-8266-967681BA2644.html
> >
> > And they seem to indicate you can only have _one_ off and one timer
> > per queue, for a max of 8 queues.
> > Since Po is AWOL, +Cc the taprio folks (Vinicius, Vladmir).
> >
> > cheers,
> > jamal
>
> Sorry, I haven't been following this thread, I don't know what the
> question to me is?
>
> The tc-gate action corresponds to a feature which can be identified by
> the "stream gate" keyword in standard IEEE 802.1Q (-2018 or later).
> It is a sub-function of clause 8.6.5.1 Per-stream filtering and policing
> (PSFP).
>
> This is different from what you reference above as taprio / IEEE 802.1Qbv
> (old/obsolete name for workgroup which later became merged into standard
> 802.1Q as clause 8.6.8.4 Enhancements for scheduled traffic).
>
> The tc-gate is not defined per queue, but rather a standalone object
> that streams (tc filters) point to. The schedule (or "gate control list")
> size, translatable into the number of TCA_GATE_ONE_ENTRY elements, is
> arbitrary as far as the standard is concerned.
>
> We at NXP have hardware today which supports up to 256 gates in a single
> stream gate control list.

Yes, this kinda answers the question: we are looking for something
that serves as an upper bound for the control list.
Does the standard explicitly specify that it is arbitrary - or is that
deduced by lack of mention of an upper bound.
Either way imo  we need to have a "reasonable" upper bound in the code.

cheers,
jamal


> I'm not sure I understand the reference to the [number of] timers.

