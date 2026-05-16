Return-Path: <stable+bounces-249032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mK2hDcnBCGph4AMAu9opvQ
	(envelope-from <stable+bounces-249032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:13:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 983ED55D787
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 21:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B26663010ED7
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 19:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78FD361DD9;
	Sat, 16 May 2026 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Iuma67aS"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F230DECC
	for <stable@vger.kernel.org>; Sat, 16 May 2026 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778958789; cv=none; b=q1ufaLrWsl6DffIR7SsqgJhxlOuwrYMZP3rp4092htWK32Fj6Prqy6FZ/rvC1W6iaCOkDPyprU2oNcKFsZfKFc9pu2Y7usdSE3rTnBfmrYyXY3l4Km32ZylMNYBeqLvcBuQpf+fFORq9nl2tr+XTrCrkYyn8AKYZPoZn3CGVecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778958789; c=relaxed/simple;
	bh=gn2uMmGVqz7bX9M35WbIy51eFSYt1rl4hYvMtRDztHc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=sWSkcbYpZAm7rS+B3VamVXRcWPyzh1b0oNNcSxcO46C0gYj9TEezJIz3kAOZ5c7lLhf5bA6u3JNs5kb3ttBMb3ZT/pPEcY254oa/SD0Wfh3kYHpib3hn5MIW5KtGoakGar8dtJndQXrN37L+ZIBx3P/SbBJlX58oyT5UjAgVyyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Iuma67aS; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1330d6bb78dso797962c88.1
        for <stable@vger.kernel.org>; Sat, 16 May 2026 12:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1778958786; x=1779563586; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8MJvVWg0F0H0jEwe7ABZnubh9KyrgWaVRhp78yyYlk=;
        b=Iuma67aSVt8qMWqkGW0rkta/GCsnMGN9BZte5OBOnScGEBGHP8nxDgEPHKlZnczilY
         bd/ojji4yWFZL+AlnXBN+2SzNznUYFvRnl9ySdRM3xPpz6NzNm75z4tIGbyyneCoXvro
         uWm/fLq0ity/QT5EL0wi5Jss/hZmwUJp8ZqUgVnF4oadatY6BKhA52bAMWnYbgbYC4OS
         xNy7ggWNBAagSm2/p9NRwGF6wMM0879RNlMeM83IPJktPaK5BehUMgY7F4cDYubqzikz
         0g5AAAMYY+lxI3tfGF9KlxNgRxVge47PknLY71RVA2JyjITNvQ1zVTew/RNkn7FYxskq
         dSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778958786; x=1779563586;
        h=in-reply-to:references:content-transfer-encoding:mime-version:to
         :from:subject:cc:message-id:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e8MJvVWg0F0H0jEwe7ABZnubh9KyrgWaVRhp78yyYlk=;
        b=nMSqrUR4G4Lo1oCa+YvwCTWiNiBdVsH4BWYIBVdgfV2PAVw3TAeV4c2o9ksoSjWGAC
         VrI9FhdoTlQWkBMXAmbFgFAaQ5wzK1DAYnNqcC+L/zU7LC5uzx6ZxR8li2422EXOYXnr
         k2kDediEsA9jbP8/LNPsk9AOmZlPHOkDBRY6KMVLSc1npYNlAAwU8CQ+aw7khhLHzUM0
         Yg7DHjJc6Xcnk88SaiFz0v8fLad7BEwScUog2AQSswfp/gjrlbgOnQV681GEyCWBk7Gw
         9XcpKguJM9TX/V/X7Xq/GLyGujMZjkAF+QlBm8bIYz1vXVmZE3FXeh1EgveU3GUA2bIc
         Z/pw==
X-Forwarded-Encrypted: i=1; AFNElJ9W04d4CjPXq40Mdu//x+pnYVvn8CPNc9NmkkUvep8hh+Z2ynHSugPpTmnwpFcf7ZtpViw/YMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQWCAjSAAy2hTtobca/rYj4BvoJQdlF+gUc2o4P9DnIy/PC7Vu
	M0skkvI3jrdVmNtQBYzTYH3wKP12lQFfJ/t/RBaaEJkTQS5gas0+ps2t21QZ7D0bQOw=
X-Gm-Gg: Acq92OGc199fyFC42AbGOEgrlmaOFBJB9shKbB04GJLCpEtp6BBubHzGWnDr6qU1wj/
	OnccwIM4Tac2H1IHQQdJ76CfmhIrVDgCicVJdmgDBf46AU+n3SB7EjHb7zt+p5qtkERwhse2JP6
	KglKRkVRfy8hvmySue/oNy9fc4i5+S3m9Bn2XHaaxS9Llr1VOmBS61ZaPS6B2hMSI6LiwrA3fAe
	oYboyFgmBQu1nz7pC8CpWefL7N0sxTBaRqZDuaudtYGo2PoaIfOTjTS/4DjPiIkMfuzzCMNZVR9
	a2F+wWmyMgirquKlsOhrCI0XRXBYT5DwED4htx3ohCtirUxvd5AK4VimqVON8kgxzKcDu/uqn17
	KtZLeJzTXJ1RxMra8obtRN1ACdTYtC+MP0K3Yz3SG99bbBFndw7P8Po6/qQeX7uqnIa8BPOSFpE
	F0WbaIgHCrDtgUrQJqDHnknjhiJdtKRlbk5Q==
X-Received: by 2002:a05:7022:922:b0:132:7ab5:6cb8 with SMTP id a92af1059eb24-13504311c97mr4432138c88.2.1778958786004;
        Sat, 16 May 2026 12:13:06 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm15046942c88.0.2026.05.16.12.13.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 12:13:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 May 2026 12:13:04 -0700
Message-Id: <DIKC9BK2GTDE.3L5O0LAIZAGH@nexthop.ai>
Cc: "Jean Delvare" <jdelvare@suse.com>, <linux-hwmon@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, "Guenter Roeck"
 <groeck7@gmail.com>
Subject: Re: [PATCH 0/5] hwmon: (pmbus/adm1266) buffer-bound and timestamp
 fixes
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Guenter Roeck" <linux@roeck-us.net>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>, "Alexandru Tachici"
 <alexandru.tachici@analog.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260515-adm1266-fixes-v1-0-1c1ea1349cfe@nexthop.ai>
 <2a3c5a65-e2b7-4159-9d3c-eb6a8a600b37@roeck-us.net>
In-Reply-To: <2a3c5a65-e2b7-4159-9d3c-eb6a8a600b37@roeck-us.net>
X-Rspamd-Queue-Id: 983ED55D787
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249032-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sat May 16, 2026 at 8:23 AM PDT, Guenter Roeck wrote:
> On 5/15/26 15:11, Abdurrahman Hussain wrote:
>> This series fixes five pre-existing bugs in adm1266.c that were
>> surfaced by automated review of an in-flight feature series for the
>> same driver [1].  None of them are introduced by that feature work --
>> they are all reachable on the existing driver as it sits in mainline.
>> Sending them standalone first, with Fixes: tags and Cc: stable, so
>> the feature respin (v5) can rebase on top.
>>=20
>> Patch 1 fixes a CLOCK_MONOTONIC vs CLOCK_REALTIME confusion in
>> adm1266_set_rtc(): the chip's SET_RTC register is documented to hold
>> wall-clock seconds, but the driver currently seeds it from
>> ktime_get_seconds(), giving blackbox records timestamps that reset
>> to small values on every host reboot.
>>=20
>> Patches 2 and 3 fix two ways the blackbox-info path can be driven
>> out of bounds by a misbehaving slave: a 5-byte stack buffer that
>> i2c_smbus_read_block_data() will memcpy() up to 32 bytes into, and
>> a record_count loop bound taken directly from the device with no
>> upper clamp against the 32-record dev_mem allocation.
>>=20
>> Patches 4 and 5 fix the two ways adm1266_pmbus_block_xfer() can
>> write past the end of a buffer: an off-by-one on the helper's own
>> read_buf (sized for the length+payload but missing the PEC byte the
>> i2c_msg length already accounts for), and a caller-side bug where
>> adm1266_nvmem_read_blackbox() advances its destination pointer in
>> 64-byte strides while the helper is willing to write up to 255
>> bytes per call.
>>=20
>> [1] https://lore.kernel.org/r/20260512-adm1266-v3-0-a81a479b0bb0@nexthop=
.ai
>>=20
>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>> ---
>> Abdurrahman Hussain (5):
>>        hwmon: (pmbus/adm1266) seed timestamp from the real-time clock
>>        hwmon: (pmbus/adm1266) widen blackbox-info buffer to I2C_SMBUS_BL=
OCK_MAX
>>        hwmon: (pmbus/adm1266) reject implausible blackbox record_count
>>        hwmon: (pmbus/adm1266) include PEC byte in pmbus_block_xfer read =
buffer
>>        hwmon: (pmbus/adm1266) bounce blackbox records through a protocol=
-sized buffer
>>=20
>>   drivers/hwmon/pmbus/adm1266.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>> ---
>> base-commit: 1f63dd8ca0dc05a8272bb8155f643c691d29bb11
>> change-id: 20260514-adm1266-fixes-853003a0fad4
>>=20
>> Best regards,
>> --
>> Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>=20
>
> Sashiko identified several issues with the driver as part of the review.
> Most if not all of them seem valid, but were not introduced with this
> series. I'll apply the series as is. Any fixes can come later.
>
> Thanks,
> Guenter

Thanks Guenter!

I will address the issues in a follow up series.

Best regards,
Abdurrahman

