Return-Path: <stable+bounces-253375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKWDNVonDmpq6gUAu9opvQ
	(envelope-from <stable+bounces-253375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:27:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D824459AE31
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F3DF3189260
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6AF3537CE;
	Wed, 20 May 2026 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Dxf59BCA"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EF3546E6
	for <stable@vger.kernel.org>; Wed, 20 May 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779306026; cv=none; b=XHcq13ZiOv74iCGW9Drlqy4mcJjIsU+IP82EmNi48c4J4Tz563DdBLOkwNfewiJEUNFGhq+jaeFUgq+Up2J6fAgkpszoMrrhaCAgrWoHSe0OWfjcUwR8zcJqloO1TpSI3CxbNTxS8+qG7gWbqlMCfUg+0hLnUCZCdWDdIyqU6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779306026; c=relaxed/simple;
	bh=gD9FvkX53JUVKNkxLtMwVrYMxYM+/fehb1JKmOS+44k=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=U+y2wjsajposZrTO58b5tP0EA8LAcbFhR4K38N2E6Cu1g4RkkRMRKxAAtEIY3G7XvkT/lRLyfxK2pkRJ8yJ5Ij2t3FHmppL0iO3UsCVQvDNhsh+VgCoknBFj472b16xp0tTHjDesyUvBkcHq47WH7aPVs/Ydl8ZysGB6bs5cjFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Dxf59BCA; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1329fc4bf77so1205156c88.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779306023; x=1779910823; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4Z6auHD47mpoadC6kfYBTYbgxuz8kIYh8F1YtTA+WM=;
        b=Dxf59BCAl0XpbIGF1c/lwwesAU9E8b2K1YxMXU2qiof8xPs2rtb1NaYAUAlCgFxZQe
         /lFnFv+hJgGM8/ZZ4OgswZAJ6KqG/TTirNvb2Huc2RxB5gDP8YiDVl1A/i0/sU3yY7Dz
         5h7hSw/bpXcseF4/9d0aTRG4o7WsI449/uHOetL2igOnwmbOETCIEvumQ+twJWEzjdmt
         5rBfAMZltD2LZBZZLn2j09h1YPJCu1+d0H/yRqXMztcCidRH3zibMs5Plr5lDBTcLBbG
         z7A/ExEcg3Bh7tV15/bDJhMkgg6KJKyYAZ80EwzG+7mgvgxhazJ+1FxkTuKl9tVo85J2
         lbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779306023; x=1779910823;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4Z6auHD47mpoadC6kfYBTYbgxuz8kIYh8F1YtTA+WM=;
        b=IoKtcvcbAjt9AC5reAeKtvdxki/qiI2AaLijq2pTVTWvWe8tMneLA+nYtgsmSd4Eaz
         tC42VZWBc4vgkeqVJy4ZtNO0iLu0/TVZm1UJhLZZrYCQ6+/gd9uCY2bK0kKixGMvpI+n
         2EkHolFzhtJzMhfhHxytulOYVRf02Gllyku+j85DaksYdyUOtVaOLVe52xW83VPgVU3g
         qXHK/X/TdGeznen/wNXYy0o029S9wksawVppwwQbZXltGXj/phZyIcKsuXUbMY427mbL
         t7TNv1kUTQvYXoyjnGhhjiHbnXc36VGABjZPzkRR1x3CfDeUMFjC/9dCOoxPb2jlYpeP
         vPdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/TLBbNLbQ7suj80/3cwkOc87DWEy2n7ilK2TNve7CE7o81VQY/PZjF6jpDP46xpXA8R4SUPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCZqIVsqcrK21vdlJi2fDf7FzcoR+58Y7L2Tc+am3ZpLcijpVy
	r9MSdLmIyStvahla75NQz/1pyC3d1zMj8i+p0UAeSayFmoN3BsuNp5dGpP0VGdGd4ccTNU8C1Ex
	M0AvpY1I=
X-Gm-Gg: Acq92OEBAPTyQbdsPfOFCn8lTcIv9tVheQiR55CLbbgLigDdQjh2DBl8IJEHOKFebI8
	9vozUZ1CXcfBf2fxfUMGj++kP0sPtUbkx6hXunxSJMt0LINRigMUiHbRRGsh1SWXY6socj96OCc
	7JvggYWqfQjS2/W2jHEawbXs5mnPFTLCc3ZnDnCoddG8Xc+xMnONo3VJk0z/zmOmZmLTj+vY4il
	gqUkcRKrMJ+/VQBVcrOK1sWdr96v7xAD/fRl8kU+lMwZgMSxRlcWt5gXriIuED/JA+uv+vMTYIS
	C0QwB34963QJ/KYxfrR9YOzWz92av7T3+9m8q2zXnd4uIlng7TV05V2xhZsbdHf9O1SXpzEMEtl
	mtBh/+6K/YeHTcto8IPifrK6fQjcPBVFFk8NJGxuiHUkqIz4T0Dl2blKRTCXrrIOvPugQMIb3d5
	xLFPqv6wLSI3EW/d26saoi1sRhaB8sFOzdOg==
X-Received: by 2002:a05:7022:311:b0:128:d34a:320f with SMTP id a92af1059eb24-13504625a7fmr12415188c88.12.1779306022775;
        Wed, 20 May 2026 12:40:22 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdce9fasm22637332c88.4.2026.05.20.12.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 12:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 12:40:21 -0700
Message-Id: <DINRCDZ0SHS3.1X4T3VVLSL36E@nexthop.ai>
To: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>, "Guenter Roeck"
 <linux@roeck-us.net>, "Alexandru Tachici" <alexandru.tachici@analog.com>
Cc: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Guenter Roeck" <groeck7@gmail.com>
Subject: Re: [PATCH v4 0/3] hwmon: (pmbus/adm1266) add clear_blackbox and
 powerup_counter debugfs entries
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
X-Mailer: aerc 0.21.0
References: <20260516-adm1266-v4-0-1f8df4797258@nexthop.ai>
 <da0fbce2-788e-4419-8ca1-975311951ce3@roeck-us.net>
 <DINO5GQHP6VK.ZBC2D5ENBYKW@nexthop.ai>
In-Reply-To: <DINO5GQHP6VK.ZBC2D5ENBYKW@nexthop.ai>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253375-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abdurrahman@nexthop.ai,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim]
X-Rspamd-Queue-Id: D824459AE31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed May 20, 2026 at 10:10 AM PDT, Abdurrahman Hussain wrote:
> On Wed May 20, 2026 at 7:10 AM PDT, Guenter Roeck wrote:
>> Hi,
>>
>> On 5/16/26 18:18, Abdurrahman Hussain wrote:
>>> This is what remains of the v3 series after Guenter applied patches
>>> 1/5 (firmware_revision) and 5/5 (GPIO line label) to hwmon-next, and
>>> asked for patch 4/5 (rtc_class) to be dropped.
>>>=20
>>> Patch 1 adds a write-only clear_blackbox debugfs file. Devices
>>> configured for single-recording mode (BLACKBOX_CONFIG[0] =3D 0) need
>>> an explicit clear once the 32-record buffer fills; the documented
>>> sub-command ({0xFE, 0x00} block-write to 0xDE) wasn't reachable
>>> from userspace. The patch also acquires pmbus_lock at the
>>> adm1266_nvmem_read() callback boundary so the memset of
>>> data->dev_mem, the blackbox refill, and the memcpy to userspace run
>>> as a single critical section -- the nvmem core does not serialize
>>> concurrent reg_read calls.
>>>=20
>>> Patch 2 exposes the non-volatile POWERUP_COUNTER (0xE4) via debugfs.
>>> The same value is embedded in every blackbox record, so the live
>>> value lets userspace match a captured record back to the boot it
>>> came from when correlating logs. The block-read is taken under
>>> pmbus_lock to serialise against any pmbus_core PAGE+register
>>> sequence on the device.
>>>=20
>>> Patch 3 takes pmbus_lock in adm1266_state_read() (the pre-existing
>>> sequencer_state debugfs handler) for the same defensive-locking
>>> reason that motivates the new debugfs files in patches 1 and 2:
>>> any direct device access from outside pmbus_core should be ordered
>>> with respect to pmbus_core's own PAGE+register sequences.
>>>=20
>>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>
>> The series no longer applies after applying the bug fix series.
>> Please rebase it on top of the hwmon-next branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
>> and resubmit.
>>
>> Sorry for the trouble, and thanks a lot for fixing all the problems
>> with the driver.
>>
>> Guenter
>
> Will do, thank you for your support!
>
> Abdurrahman

Hi Guenter,

Before I send v5 of the adm1266 series, I'd like to revisit the
SET_RTC exposure question from your v3 review [1].

The use case I keep landing on is the one the datasheet itself
recommends: a userspace agent (chrony hook, systemd-timesyncd
script, or a small periodic daemon) keeps the chip's seconds
counter aligned with wall-clock so the value embedded in each
blackbox record stays correct across long uptimes.  The probe-
time ktime_get_real_seconds() seed (now in hwmon-next) only fixes
this at boot; the chip's counter drifts after that.

You ruled out rtc_class and called a kernel-side periodic timer
"a bit excessive", which I agree, it is.  That leaves a
userspace-triggered sync.  Two debugfs shapes I'd consider, both under
pmbus/<hwmon>/adm1266/ (alongside the clear_blackbox,
powerup_counter, and sequencer_state entries v5 already adds):

  A. RW since_epoch -- mirrors /sys/class/rtc/<dev>/since_epoch.
     Read returns the chip's SET_RTC seconds counter, write sets
     it.  The read has the useful side benefit of letting
     userspace measure host-vs-chip drift without writing.

  B. Write-only set_rtc -- writing anything to the file makes
     the driver read ktime_get_real_seconds() itself and push it
     to SET_RTC.  Simpler interface (kernel owns the time
     source; userspace just triggers the sync), no payload to
     parse, no way for userspace to pass in a wrong value.

Do either of these look right to you, or would you rather I just
leave the driver at "probe-time seed only" and skip a SET_RTC
interface entirely?  v5 as it stands has no such interface and
is ready to send; a SET_RTC patch can follow separately later if
you'd like one.

[1] https://lore.kernel.org/r/20260512-adm1266-v3-0-a81a479b0bb0@nexthop.ai

Thanks,
Abdurrahman


