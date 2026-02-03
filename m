Return-Path: <stable+bounces-213153-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECiDOj5ggWnfFwMAu9opvQ
	(envelope-from <stable+bounces-213153-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:41:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 725AED3D17
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 03:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 138DE30214D5
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 02:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614703101C2;
	Tue,  3 Feb 2026 02:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9I6rN3C"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00DB2FBDF2
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086457; cv=none; b=BnF43EnbNd+BsB7DF77lb+zN+nj0RmZyMhLYyHqlYSlHCmpDC8Sa/Mfoc/FER6L9/N1h1D1V1peFXq/3Humgo3yiSF72OIEUcYJejJThCOvtfQTLegh0StV3uGSG/EKKSkkychplfuv0mbow+5NbW0XzkfEOhs8wd2E7F+2qWsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086457; c=relaxed/simple;
	bh=ndaXLIpsmF2vxSgB6X+oRj8aKFBYdVhhWSbAd6S4LNI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Jl3tj4diYnJ2OgnMh9ejUf4JKevEirsaz0FSuAveOx02mT2pm+A2zIKSA6gTAsVtlFje8PVhCN+hfDL9b0PviBnLlViQSXBCMxEmL3FWHwCTzQgNLtfTQ+yGCiomaFiP3cil3zrsK41F5kX1aeJIZGK+l5O24pEzw/6KR3mLej4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9I6rN3C; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-560227999d2so1937686e0c.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 18:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770086455; x=1770691255; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsqYKO57kcaexHTzdufWdg6k5lDbRhwfeK1kutGLUV8=;
        b=N9I6rN3C+xdyq9S8fRz+kcx8LJWyskEpmJmDVr1pqvBVRzJsbJcxk7GdDAbrtUD2Eb
         mmLqviafH55lgh2SpiyMqSADR5MUOGEet0iHFtQFHznrBvoU3k+hLaQLhPnns7VeBl8j
         NZ8kpJBUTo7A5H0ovqBTL1ZQ2MfFHBqXWCu/mE2sbQ+AyWxnRGZsYuDNhPX8QOj6WDuw
         9puM8coAabY2Yzh7mGrae9xs38AUlJbfb0NDM43Tj8qKYa6erotQrPUgAz8KBJe3xg1L
         xXnylNwdfn7D/5tOC3HeiTAN1cAX7VetWOU7WoAA9KK6c6bm5yryqKmNC7UODbid7ij1
         q9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770086455; x=1770691255;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KsqYKO57kcaexHTzdufWdg6k5lDbRhwfeK1kutGLUV8=;
        b=LykxmPTHh5+mu1+fojcNYC0J4A2mqcp1HL0RfWMWSRKHOuq2u4d8YJb/ZtMIpmNNkp
         pzcPUvvGiRQHUHWh9NeNWu4RIiSnwxy/Uzcmuw1srVrXbSKfhRlh+5YdFAZswIPI1Opd
         SRs+X7yLUQYdCHu+1Z5m8+GErun/BeqtR7xvoHZiQsiIGqwlPIyPgfG1MCwCkK/l/8yb
         VcI9klUqqxhps+Lv8/jWJH1J6Ufwpj590uPxXtRc5ejvo++KjEU8n6JNJmLrQIKwMLcB
         iU9KIn/NsPlqIVaRniC+J5bM8ujUJRdYeowXahgjXm2PnqTc+bzbeJmruTYc5GOpUp64
         qqkg==
X-Forwarded-Encrypted: i=1; AJvYcCUf5Am7/hzhrl4C/+JgKP00uWK70Kg1i8Fr8ayohPyYQqNpeWowF5HYodpnZuKj9EIMhW/itbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXWb4cWTKXT6DE7S7NbbdEeeWdyOTEOsOaqNk38hbubKyyeiGX
	mQ6l8uVJ6nS6p0KjbCQDcusKvq2XjaIbXIK2fIUCca38pt6hSnS8Ss7h
X-Gm-Gg: AZuq6aKKL9I20S5RCC+E945TVGhA5CoHzXhGX5QJn4J08nIv3IUm5ryQHb67aWos3BV
	kcoTlG3log5DLZSsOxBiu8XZO5VGZAaaJz7jJMSetWkzp6b4KqF889kEE8H9AqR5J059bUQO0eV
	5r+6M40aFHtuQrYO6vigjxS+VFTEnfuxoT+af+ghFn5HZEDlxBZtKs+ccpWIVGgmyL1drXL7Fn8
	NpK4Uc0Fb95hWBJhzlOUGqSvD0MTkACmo6N5fwovG+GV+og51D6RHuoJovl6j3BREnlNcls0ioM
	XgIvzBDShbHual36COw7dDLLH5ejylCBxBolle+Uon7nzocoXkpPJn3e9a4GJrQOVZuewUgOcNI
	wRvqQ8NVqT00LRaeFbVzzM9nv2eEdVTuWpQiS75izweYsfOcNx8PSuW7RjYYqdxcfVIwRNgiAvJ
	A2OQ==
X-Received: by 2002:a05:6122:1692:b0:563:702b:e2a7 with SMTP id 71dfb90a1353d-566a01437b9mr3665059e0c.19.1770086454761;
        Mon, 02 Feb 2026 18:40:54 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685b015e5sm5611567e0c.3.2026.02.02.18.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 18:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 21:40:47 -0500
Message-Id: <DG4ZA0AFOSQI.J5EJQMPYPV7K@gmail.com>
Subject: Re: [PATCH] platform/x86: dell-wmi: Add audio/mic mute key codes
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Kurt Borja"
 <kuurtb@gmail.com>
Cc: "Matthew Garrett" <mjg59@srcf.ucam.org>, "Hans de Goede"
 <hansg@kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, <platform-driver-x86@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Olexa Bilaniuk"
 <obilaniu@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260201-mute-keys-v1-1-825e786732fc@gmail.com>
 <20260202081247.vpvbsapdrynr7vtf@pali>
 <DG4NNLOA8MJI.35V2HGOFN3RM8@gmail.com>
 <20260202174322.x6fr4atrx5vulxt7@pali>
In-Reply-To: <20260202174322.x6fr4atrx5vulxt7@pali>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213153-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[srcf.ucam.org,kernel.org,linux.intel.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuurtb@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 725AED3D17
X-Rspamd-Action: no action

On Mon Feb 2, 2026 at 12:43 PM -05, Pali Roh=C3=A1r wrote:
> On Monday 02 February 2026 12:34:19 Kurt Borja wrote:
>> On Mon Feb 2, 2026 at 3:12 AM -05, Pali Roh=C3=A1r wrote:
>> > On Sunday 01 February 2026 23:37:37 Kurt Borja wrote:
>> >> Add audio/mic mute key codes found in some Alienware devices.
>> >>=20
>> >> Cc: stable@vger.kernel.org
>> >> Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
>> >> Suggested-by: Olexa Bilaniuk <obilaniu@gmail.com>
>> >> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> >> ---
>> >>  drivers/platform/x86/dell/dell-wmi-base.c | 3 +++
>> >>  1 file changed, 3 insertions(+)
>> >>=20
>> >> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/plat=
form/x86/dell/dell-wmi-base.c
>> >> index 28076929d6af..62cf28d1fe19 100644
>> >> --- a/drivers/platform/x86/dell/dell-wmi-base.c
>> >> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
>> >> @@ -86,6 +86,9 @@ static const struct key_entry dell_wmi_keymap_type_=
0000[] =3D {
>> >>  	/* Meta key unlock */
>> >>  	{ KE_IGNORE, 0xe001, { KEY_RIGHTMETA } },
>> >> =20
>> >> +	{ KE_KEY,    0x0109, { KEY_MUTE } },
>> >> +	{ KE_KEY,    0x0150, { KEY_MICMUTE } },
>> >
>> > Hello, please keep codes in the array sorted.
>>=20
>> Hi Pali,
>>=20
>> I thought I sorted it... I'll fix it, thanks!
>
> Before is value 0xe001 and your new values are 0x01xx. Most of values
> are 0xeXXX, so it is quite unusual that Dell allocated values with
> different pattern.

It is a bit unusual but it corresponds with the user report

	dell_wmi: Unknown key with type 0x0000 and code 0x0109 pressed
	dell_wmi: Unknown key with type 0x0000 and code 0x0150 pressed

and I also checked the acpidump.

>
> Also, could you please include into commit message for which Alienware
> devices is change needed? It would help to detect devices which will be
> fixed by your change.

Sure, the model is Alienware m18 r1 AMD.

I said "some" in the commit message because it's very likely other
Alienware models also use these codes.

>
> And please add some comment into source file above those two new codes
> for which are needed, in similar way how we have commented/documented
> other key codes.

Ack.

--=20
Thanks,
 ~ Kurt

