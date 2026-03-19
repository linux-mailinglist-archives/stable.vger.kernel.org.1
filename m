Return-Path: <stable+bounces-227274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAahM3Thu2lXpQIAu9opvQ
	(envelope-from <stable+bounces-227274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:43:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 919572CA81F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C464830517D2
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 11:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678C03CA48C;
	Thu, 19 Mar 2026 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxcZG1Q3"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435E63B5843
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920429; cv=pass; b=SaBd6I24KGKG91164jpYscqB+wwSpykaU4W4Q3tXGbrRrgQVdOs5HVn5Cl3i9EOJbtJTK/t4fpkhu6pN2Z9FTBFkRa29Etve4MqLPeJZUfckuDtaXAllKzfPrdqHBtqRZPEu+aVQqzYyCPUmBygDUnN9WvOnHRII4p4oOOvl3F4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920429; c=relaxed/simple;
	bh=3/5Vancu7oJ7a2Bfgue/3hShdNPOTBO/0PVlj+TLhqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyfmrpYUY3z0atJcyRoMR3I78XHVAikhJpnsiEy8bTf6/oDZ2F0mR9OGd/7OiIy5AVP+zbrQyNIt63BJIXl3cBKkt5Pb7EtafVRnUmgnnmPUomHUsbAkjFpCZrd7nqFSIkwCeRenf+6zuanHx8eSrgsE9U6oPw5rgKsCzmjKJf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxcZG1Q3; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-464bba3a9easo370640b6e.0
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 04:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773920418; cv=none;
        d=google.com; s=arc-20240605;
        b=YDA0/MPZ4CJRNOs6ULhFqQPEZKN+s5/WBMuo4AvRQUzVZZiuJXewaugvptN953jSW2
         1oByl8w6W7GmyvEj4tv9jh+dRoukqxe7WwURRl3hD8/l8vA0gDuyM+qeu3W0cq0QU2Sl
         GC2v32qMzlVvIxhRL1t8lqebOMO8v1r8GmJQey5jBhj3sr+STOXnd2FvixaDFosWno15
         NSlp0eIhtgwVg7ye1az2frcybUyFiU3JJIzkItKGyH/gznLpdelZWdyXpgGCDVeeIf2k
         tyrmVJt3yR33EiRaa93lzATd8jcIHyA5DEmmXockDnbX+Dn/S4N8+6x1vwjIf4Ucw7N1
         mAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjjJebcMF91/YYCQdLO1MHdk0/Hn82SANES86u5k7io=;
        fh=pdYPHBmq4SktFTujdEKEDvuMyZnNXHAwzDvSclDHp7M=;
        b=ZzFk6wAkP1sVx4YXWRLccSPNiQo2iHojybpkHxJH1rPz6vxHxprxROViEJwwDncsoz
         qxEG2+l85r9hHoMUeTmuU2JkTF8EGB92wvdcgBmtj8PqM/40tqsNb9oS6jBIS8SH7LzC
         jF3QFKMsl+M/Mbphkxk584wpu4C1Awvb3XBkbRh9n3fLJrurSs0hUtnSEVw4qHt9/Lca
         ZGf0E3J+eKpLR8rmi8eaq9fEBGc2gt5bXEH8HZdwgF0i73XY3QHEOGj22z0J+dyxutf3
         H7rOTM5wli/fyVcGmokJ9+c6Hn43DkptAWwLO8RXBbL3DMOkPuP/NXi1xEsrcILauX/S
         ozPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773920418; x=1774525218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjjJebcMF91/YYCQdLO1MHdk0/Hn82SANES86u5k7io=;
        b=HxcZG1Q3QeW2iEdzRjJEKj/OxCgqKL9cgrqj+BCqH1vgGt1/P910BTSokwmvhk0UlF
         l5xzUxatKTMc7vBRiH9MdC4GWiKcVVDmrQsi0i94kmxEkhw4t3gpvsoUboeNqKNyqlLy
         g8vFKv59lNc0IJCTxm+pUKY2rZcuZCSqBZEffrVbS8UPq5E8S3uhdh1kZN06mzRh6tmD
         X+RLL+iORUpMnWpHaOiwEAcBWtrLo2jNCa/pCBdNenM4/4Rf7DfNu+z6LvAaB3ZlgkES
         BDsGURv9cUvksq09VCX5ePtKyr5fT5GtDzqEmsSMuXJPpaxYs+XeFnqjJTv/Swomka3j
         enIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773920418; x=1774525218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjjJebcMF91/YYCQdLO1MHdk0/Hn82SANES86u5k7io=;
        b=mRfED8X7MbORGk5griZtCdeV+y2PIEGXaKD30Jw4TfLDCre3bgGQgd9pkEtWFjUmv2
         DzjQ5ypHRDf/V+j9T6jZLa8VhXhAd+6JBhWX+CdUscGNiiffJI/iDBnSQ064ZDCKxYXr
         14AOC5mgct7ZY4cpedQSomhJSnrcs5vP8fza42/boXt/w9sPxzut1j65yy9NDWaUST3A
         /UwF6PwLSbkyzxde3jKJskFAxKfruQh5FrzVk3bDzfjOcxinLw086q+zQ1sPBWdIe+Xq
         nEY+ZgmcxHNJkCoNydmjOMHF/uZlaT3Uhq0CzvTiEl040O7qPcmgcKB5SaO8kDIxF+QR
         TesA==
X-Forwarded-Encrypted: i=1; AJvYcCV0zvPh9jjYQcTl/OSRB6afBCx9kq8urkU8HIJfNmm/5R3rKqdxTXG9RA1T5nkoelyNQ2Ooh8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM+mJWeXbj42n9Qnlwdqe3XwkjvbmGSbBOYl9c9CVxYTMU/zp2
	VtuwAh8FII4xMab1doCRBay9XyiBCC6JIf1rwBdpNmFDPj/mZ97G6MaZBuK/5qdukHlH2Z1rwkn
	NR+DxnZG13xRKFWRTRHb/ri3lgoxjuzI=
X-Gm-Gg: ATEYQzzUoCGvXLZ5HdsI++gadh1aKZj7bfJmHcuJJ2Mwyuy/RVx8ayJ+xqmauneQBIC
	VlKWParjnECFlTckcWXfO/knyO9XNSg2IFDbB9HvaKrHudp4KHlIE22G/jLGv3buui5mZptt35X
	CqQmYISf8qWZ2FZPJDSdunbnbqtoTYRunPToxQqH/f0FuDAr78vDzXBqFgYSir1ydYf34AjxqGW
	CdOZzc8O2SPZUN0x7IgrkP9XxNq3SCQDxvMwrTTBR0ky8jcS1oah+ENpu9S7fJUFCqrOMQhI/or
	BT91IO27
X-Received: by 2002:a05:6808:c16b:b0:45c:a040:e53c with SMTP id
 5614622812f47-467ba295f23mr3879428b6e.32.1773920417623; Thu, 19 Mar 2026
 04:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309104559.22252-1-fjhhz1997@gmail.com> <71acefb76084d5a82f9ce4536e270942cffc64e3.camel@sipsolutions.net>
 <CA+bbHrX+xby2_drzo0457raoz-kgQ6eTCCHU91pR5BkvzMiq_A@mail.gmail.com>
In-Reply-To: <CA+bbHrX+xby2_drzo0457raoz-kgQ6eTCCHU91pR5BkvzMiq_A@mail.gmail.com>
From: =?UTF-8?B?w5NzY2FyIEFsZm9uc28gRMOtYXo=?= <oscar.alfonso.diaz@gmail.com>
Date: Thu, 19 Mar 2026 12:40:06 +0100
X-Gm-Features: AaiRm52KxikdEjl2svUPcyIgRKORrqdkgyRVOqkzn8IgXGbFFTa0hojvjD8LpgQ
Message-ID: <CA+bbHrW0C9+Pz5TOUgM_oodhfJnoO7P0YiEdp85D08h=hLPF5A@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: fix monitor mode frame capture for real
 chanctx drivers
To: Johannes Berg <johannes@sipsolutions.net>
Cc: =?UTF-8?B?5YKF57un5pmX?= <fjhhz1997@gmail.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.57 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227274-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscaralfonsodiaz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 919572CA81F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi, I've sent earlier an email to show on screenshots the results of
my testing but it was rejected as the email distribution lists just
support plaintext emails. So I'm sending it again this time explaining
the results without the visual proof.

 I was testing this patch using Mediatek MT7921U chipset:

https://lore.kernel.org/linux-wireless/20260308164510.5927-1-fjhhz1997@gmai=
l.com/raw

It didn't work properly. The test consisted in split the Mediatek
adapter into two adapters (enabling VIF), and then try injection using
a test aireplay command:

iw phy phy3 interface add mon0 type monitor
ip link set mon0 up
aireplay-ng -9

Apart of that test, I also tested it creating an Evil Twin attack
using VIF feature and trying DoS at the same time as creating an AP.
On Mediatek, with the patched kernel, the test resulted in a totally
hang of the Kali VM

Let me know if I can help further or test another patch.

Thanks and regards.
--
Oscar

OpenPGP Key: DA9C60E9 ||
https://pgp.mit.edu/pks/lookup?op=3Dget&search=3D0x79B17260DA9C60E9
4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
--


El jue, 19 mar 2026 a las 12:30, =C3=93scar Alfonso D=C3=ADaz
(<oscar.alfonso.diaz@gmail.com>) escribi=C3=B3:
>
> Hello, I was testing this patch using Mediatek MT7921U chipset:
>
> https://lore.kernel.org/linux-wireless/20260308164510.5927-1-fjhhz1997@gm=
ail.com/raw
>
> It didn't work properly:
>
>
>
> As you know, expected result is like this:
>
>
>
> Note the difference from the first screenshot, kernel is custom compiled =
6.18.12 and the second one is the default kali linux 6.18.12 (6.18.12+kali-=
amd64) and using a non-Mediatek chipset to show that how it should be when =
it works correctly.
>
> Apart of the test of the screenshots, I also tested it creating an Evil T=
win attack using VIF feature and trying DoS at the same time as creating an=
 AP. On Mediatek, with the patched kernel, the test resulted in a totally h=
ang of the Kali VM
>
> Let me know if I can help further or test another patch.
>
> Thanks and regards.
> --
> Oscar
>
> OpenPGP Key: DA9C60E9 || https://pgp.mit.edu/pks/lookup?op=3Dget&search=
=3D0x79B17260DA9C60E9
> 4F74 B302 354D 817D DE38 0A43 79B1 7260 DA9C 60E9
> --
>
>
> El lun, 16 mar 2026 a las 11:38, Johannes Berg (<johannes@sipsolutions.ne=
t>) escribi=C3=B3:
>>
>> On Mon, 2026-03-09 at 10:45 +0000, =E5=82=85=E7=BB=A7=E6=99=97 wrote:
>> >
>> > I see the key difference between our approaches: your v2 iterates
>> > the chanctx_list and only proceeds when there is exactly one entry
>> > (going to fail_rcu if more than one exists), while mine blindly takes
>> > the first entry via list_first_entry_or_null(). Your approach is
>> > clearly safer -- in a multi-chanctx scenario, there is no way to know
>> > which channel the user intends to inject on, so refusing is the
>> > correct behaviour.
>>
>> Oh, right, I hadn't even realised that at first.
>>
>> > I have tested my patch on an MT7921AU (mt76, USB) adapter across
>> > v6.13, v6.19, and v7.0-rc2 with managed + monitor coexistence, and
>> > have not observed any crashes. However, my testing was limited to a
>> > single-chanctx scenario (one managed interface + one monitor
>> > interface), so it does not rule out crashes in multi-chanctx
>> > configurations.
>>
>> Maybe =C3=93scar can comment on which device/version he tested and got t=
he
>> crash with? I just would like to avoid having crashes because of this,
>> but generally think that - perhaps optionally - we could have code like
>> this, since people _do_ want injection to work.
>>
>> > Could you share some details about the crashes that were reported
>> > with your v2? For example, which devices/drivers were affected and
>> > what the crash signature looked like? That would help me understand
>> > whether the issue was specific to multi-chanctx usage or something
>> > more fundamental with accessing the chanctx_list in this code path.
>>
>> No, it was specific to some driver implementation, but I don't have any
>> more information now.
>>
>> > If you agree, I would like to send a v2 that combines both approaches:
>> > use list_first_entry_or_null() for simplicity, but add a
>> > list_is_singular() guard so we only proceed when there is exactly one
>> > chanctx -- matching the safety constraint from your v2:
>> >
>> > --- a/net/mac80211/tx.c
>> > +++ b/net/mac80211/tx.c
>> > @@ -2399,10 +2399,24 @@
>> > -     if (chanctx_conf)
>> > +     if (chanctx_conf) {
>> >               chandef =3D &chanctx_conf->def;
>> > -     else if (local->emulate_chanctx)
>> > +     } else if (local->emulate_chanctx) {
>> >               chandef =3D &local->hw.conf.chandef;
>> > -     else
>> > -             goto fail_rcu;
>> > +     } else {
>> > +             struct ieee80211_chanctx *ctx;
>> > +
>> > +             ctx =3D list_first_entry_or_null(&local->chanctx_list,
>> > +                                            struct ieee80211_chanctx,
>> > +                                            list);
>> > +             if (ctx && list_is_singular(&local->chanctx_list))
>> > +                     chandef =3D &ctx->conf.def;
>> > +             else
>> > +                     goto fail_rcu;
>> > +     }
>> >
>> > This avoids the ambiguity of picking an arbitrary chanctx in
>> > multi-chanctx scenarios while still fixing the common single-chanctx
>> > case (e.g. one managed + one monitor interface).
>>
>> Seems reasonable, I think we could even drop the "if (emulate) part
>> (since in that case the list should always be singular). Just like I
>> said above - would like to understand the issue that had appeared with
>> it.
>>
>> johannes

