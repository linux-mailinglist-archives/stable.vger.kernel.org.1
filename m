Return-Path: <stable+bounces-213093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IK5fLIXggGleCAMAu9opvQ
	(envelope-from <stable+bounces-213093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 18:36:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5E8CFA6D
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 18:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76C2A304F342
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 17:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B7A387591;
	Mon,  2 Feb 2026 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnC5xOKw"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02903385ED7
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053669; cv=none; b=BrEguVbs3ehNQyVYnp6+O2WswsJ+ouduIaVLIbdPE7sun5RdxWXhgKi0Ci4Wuf+QmJEJVMeUjgZx0d/JVZnHVtUtTtMoRJ9axFcd8ctaacvhiy4hvr8Zo22WJsd7WaQwwCoSqhMqgsIzXmew5GCr5+1wUBWeJ/QdGYRvFRZN3MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053669; c=relaxed/simple;
	bh=IRPny+KD9aBOapHWvHXo9KZ5VJ/7trQk/97xlFN9m/Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oPfWQiGBq1yKwD7p3jG0tjl3PpyrjzQIb8h6bQRh2ezDxUJbJmSAi1H2NNFZaNw6JbReMhxUKgnFTZRXkn/gonIVT08X0WM6/MQIFXgPE89bjI4foGzyUwUPhTvhHbaV3DZlI73trMzWzUucSLKsSVGOUUlbDvvvu5n8hASxIho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnC5xOKw; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5664340e14fso1412457e0c.1
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 09:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770053667; x=1770658467; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6yAip77KwQwTJuiBtKCAzTsaGz+3iPu2gulKxWl9fbU=;
        b=RnC5xOKwRTWZ8BtoLAGea5a0U7sDPqCGnYCrO3QfbnajuU32d6+bnsFJ8dCFSo3GAS
         nWxT0N6umJP+q/ReqX9kjjSwIfWR2DvM3t9DG/DDSWcO3ZyaGy9DUFakCZptzDJF40OS
         3aZSBUz/mUgziMfOqwXfevGPlcKVbGnut9p6mCbZe+LQzLFyisb9I/U3GmEh+WTj4e8q
         jPKbm0a46EFhJ3XgZc6OGlC1pjdTHJo1EHhyjbIH7QlJcXhmw1RRqbWii/rZQz50cb9Q
         nGHz65uLuKN63s6tkSkr/Qk6AkfWMDEQbRtrRbWr/7a3nkN/1IufWOMc0ZWJbpVRqqc9
         DLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770053667; x=1770658467;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6yAip77KwQwTJuiBtKCAzTsaGz+3iPu2gulKxWl9fbU=;
        b=ky+mBAp9TDA2/LtXspyFme6y9nP7jFnCsjvIAFuAtAfHIu+ZPVJct2wT0W8nguhEWc
         rX4LOEDFRiIPM5MXzeAeoJ7nFwtqANPAkJOtVojM3ve3Iz0Hff0AhF+eDfzKPEA6TUI5
         MCykP/oKAqGQ5TTDIVsdPAhbSMoWm0cJv3TM9LSD1tati+gWsfzJyI67cWjvsiKWmoZY
         p7cCb2F7VAgrLX+V2konD0DW+C8SYM86OXDEKvdX+1purUGmJLxzS4t3wLm8IR+VbA4v
         oLmtG2bzZAB1tKzb5/1UMLhol0NE0ZhmsHSWkIEDCyGLdumfP26v6TZl/waGicZBgqW5
         N6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7d90f357RRg5WJOqxFU/aMgGNfLEGSddQGv8rTUintGNbp9U2QrwT15Od2x4U+QvFWhMVm4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5N9mB6rc5xnVm1NvgRmDLZd+lwY3K6yAKdEF9FpLOFAVrfU0B
	drfLkl+B1WSJq7w72vuk0wq9xbalwquYuQj4fxSr+txW7+8i6AipALtn
X-Gm-Gg: AZuq6aKUkZ7J0igRIzQQg9sYgl0w3Tbf/cYcWAz54ed9hU/eYyTeErhhxu7Sgc2y4YL
	MEceXm+9ZENzViraDF7w8/1TD8IWkeAeWwF3t6JNJtdRp9a0Ic09G9PY1BgTBMKZXEyezmZzc67
	RvPFwSeQw8r0ktIvlZX6kNjYfGDpG6bIu+ml44balcpjeN97MeQ7Hw7c4bucYGfY5ccjFURhG9w
	nFlQwj6RnyZtBtgBmFP8wZprm374z/+WAqtq5BE7U29RumtLnHGdVOEkXNNsnPs0lSoYEE1BGNe
	Zzvny/YRVSoIHe33zordvkBtmTzzhln/UStHfs2HesgQDlfj/cQssw/b3q+G0CQgn4rbFW6GOYt
	c1uVRe5Ib4tFWkBldtSBywlGiFkmpUvY8fVXwsCGsSunVOs6+auklTp0TABV8CZ+5cE1RO3q3kJ
	+5HFG8SAexnzKf
X-Received: by 2002:a05:6122:c155:b0:55b:305b:4e3e with SMTP id 71dfb90a1353d-566a014b651mr2712864e0c.20.1770053667039;
        Mon, 02 Feb 2026 09:34:27 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56685becfc4sm5388725e0c.12.2026.02.02.09.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 09:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 12:34:19 -0500
Message-Id: <DG4NNLOA8MJI.35V2HGOFN3RM8@gmail.com>
Cc: "Matthew Garrett" <mjg59@srcf.ucam.org>, "Hans de Goede"
 <hansg@kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, <platform-driver-x86@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Olexa Bilaniuk"
 <obilaniu@gmail.com>
Subject: Re: [PATCH] platform/x86: dell-wmi: Add audio/mic mute key codes
From: "Kurt Borja" <kuurtb@gmail.com>
To: =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, "Kurt Borja"
 <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260201-mute-keys-v1-1-825e786732fc@gmail.com>
 <20260202081247.vpvbsapdrynr7vtf@pali>
In-Reply-To: <20260202081247.vpvbsapdrynr7vtf@pali>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213093-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[srcf.ucam.org,kernel.org,linux.intel.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 0A5E8CFA6D
X-Rspamd-Action: no action

On Mon Feb 2, 2026 at 3:12 AM -05, Pali Roh=C3=A1r wrote:
> On Sunday 01 February 2026 23:37:37 Kurt Borja wrote:
>> Add audio/mic mute key codes found in some Alienware devices.
>>=20
>> Cc: stable@vger.kernel.org
>> Tested-by: Olexa Bilaniuk <obilaniu@gmail.com>
>> Suggested-by: Olexa Bilaniuk <obilaniu@gmail.com>
>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>> ---
>>  drivers/platform/x86/dell/dell-wmi-base.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/drivers/platform/x86/dell/dell-wmi-base.c b/drivers/platfor=
m/x86/dell/dell-wmi-base.c
>> index 28076929d6af..62cf28d1fe19 100644
>> --- a/drivers/platform/x86/dell/dell-wmi-base.c
>> +++ b/drivers/platform/x86/dell/dell-wmi-base.c
>> @@ -86,6 +86,9 @@ static const struct key_entry dell_wmi_keymap_type_000=
0[] =3D {
>>  	/* Meta key unlock */
>>  	{ KE_IGNORE, 0xe001, { KEY_RIGHTMETA } },
>> =20
>> +	{ KE_KEY,    0x0109, { KEY_MUTE } },
>> +	{ KE_KEY,    0x0150, { KEY_MICMUTE } },
>
> Hello, please keep codes in the array sorted.

Hi Pali,

I thought I sorted it... I'll fix it, thanks!

>
>> +
>>  	/* Key code is followed by brightness level */
>>  	{ KE_KEY,    0xe005, { KEY_BRIGHTNESSDOWN } },
>>  	{ KE_KEY,    0xe006, { KEY_BRIGHTNESSUP } },
>>=20
>> ---
>> base-commit: 008bec8ffe6e7746588d1e12c5b3865fa478fc91
>> change-id: 20260126-mute-keys-7f8a27cd317f
>>=20
>> --=20
>>  ~ Kurt
>>=20

--=20
Thanks,
 ~ Kurt

