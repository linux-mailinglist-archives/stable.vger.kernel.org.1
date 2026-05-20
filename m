Return-Path: <stable+bounces-253388-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePbdNQEmDmr26QUAu9opvQ
	(envelope-from <stable+bounces-253388-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:22:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBF259AC12
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41F9E30725D4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00E937C0ED;
	Wed, 20 May 2026 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="Yf8PAX5P"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D63E37AA78
	for <stable@vger.kernel.org>; Wed, 20 May 2026 21:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779311903; cv=none; b=ODmvcxqjucD9ZL5E8MH3iCaxJM/xjQcIhiZUqBBt/68JjaDAmQr3TvyeTb8MkvPqADvD8WlseZa5fHLjlRTi+yJBe/SbfEcWLOMo4aHl/poIDFgP243MZw9NvV/P5g+o+rtUrFjDD3BGgwNvl1JHDa8aeGzsCz/mz5LHVBhy0QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779311903; c=relaxed/simple;
	bh=2qBAJakZ99cnOL/2UwFpo8VxRhNqhAyyDd3DXmJ7Fcc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EBcID0WBR1dhTTnvLUIqY7aLuP5+glB/k7UNfb9XabpdwsVVo4A6ny7cZIemTjFvtvPQgPCHgCoHDKU+ydX/PFeiuf4phW1tpJ9N04EoqnJ1VZpA9heXMidYK7tYjH7qs5i16SwXVjxYW4YZUSxps2VkDk9F9OJpmhyVj/7gYUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=Yf8PAX5P; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1332772f6b3so7020895c88.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 14:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1779311900; x=1779916700; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Tf2Xd147xJ0sNfv/d8vxtKV4pEk11pNA8lNnJlbJZM=;
        b=Yf8PAX5PGIAB+58vF1DTGHYBfhfzNuCxJkKOhA/X4nILwk5+ll+fuR0YF+64WfTHkr
         3l9cAhZzeMxMMladx+FkF5vtnWfn6cOW7YqCt6ficI3TVA6CrwkHUEQ0biO6f7qV3GkP
         9L7Xg96mtLUmjB9GnHgZM6jBHg6/hHCD6/wIdldxHNLckT7t1onOlxf7w0kzc5wFudIY
         bX55Xgqks/9Oj/MA3orWI1LBpVAWVoHHuWysODNRKUJtugUA81+XD6FL8JhH7JgCcKJM
         VG4VmkjVrAXzrRT0TjMRkoPA8HWfs2JwMbqXffqoHZ8q03JywRcXJWinMoz2nAZ6yp3R
         ro+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779311900; x=1779916700;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Tf2Xd147xJ0sNfv/d8vxtKV4pEk11pNA8lNnJlbJZM=;
        b=SuxUsca6LvWih9EhxJfrJwdWWM8hNSoTnLXEqN9p1ibBqYoBLUB4frqxXJRhZgxjQi
         HAurdn1PQ1Wj9f0kGgxe7MPFIHRZWDKm2G++cf0BBopZmowr/XD0yawKUnI6ye7NAfyO
         nbQUlMUROgHabF+xEg5fLVvN2MCA2UWlU3TriSLHFB6wf1t7m6cvNq/MRA/JohchIiIh
         DlWf2dOxOTApRuADnFlFQb6zNLNSz/hpO1TlCTJJPKREUHO+ZKDM2rzPwzfqgwIwuf9I
         B+U1ZnVrduOcF0UFDAfwk9QdG6UbxdkzirVwOHoxEwQOdl5s8aUpi25+LgR0IZ/aXPv3
         1T9A==
X-Forwarded-Encrypted: i=1; AFNElJ/GFEbXUnA9X1fwjI1ihDa4Clw5pY3qZkGjIbSMOgRwqjHA585KYhqwRvKLE7o4IQ2xzQKz4CE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0YjMPVUfm6/ckcNIOzKIhg7fp9Fl+UQY35A5OLMjzSShMcrsq
	JZnTtcCrTFmK4ZuH2THyKsuWY4xRSa0bvua/hzgUE+yd53xuFYoEA/8AGHYaWxu0LmN5+ylA/9A
	KcIizhds=
X-Gm-Gg: Acq92OFDpNzTBJJSOyHH78wQioF2doYFtW/UpQqrsmuaidwVDDUkiOzEIyGk2XV+ma0
	WUBBwOk2plRQdLuTIdNIMPD9OQiKdr9lEGDs6lOvZq9RjcluYj0I0bl5mOFJbw7yUaOTD4tpXz/
	gvtATXTi9nIDgUUWD6RjsuTAJ8VIExE1bcqjqjRtRPAb8WHHXVw6TLUUqY8EgFetDfIjQAHhfKh
	vLdZbydTGuQYZF3Y0K2cnsF/0ifnj/qmPe9/CEHTektB/T3NCU0/Onw/k2DxxLr0uweb6a+HEaG
	jKNZmQAORvvF0JcHQyhdpnzoDiREu/Eb8liiNnL1/GIV5hb9oAldHk/QX/xxSs9ZsyZkxk4KdrO
	W5NOObmMXmlcMeIwW8UNXOjNxOngofQ21jnVPd+NvJNtcmmzE4nOhGxqq+7oXWFbM5CSP7uqJRx
	XcCtXum6PfhXjlvl2sRyCtyrA=
X-Received: by 2002:a05:7023:b10:b0:12a:8ea4:252 with SMTP id a92af1059eb24-136327f23d5mr182452c88.4.1779311900270;
        Wed, 20 May 2026 14:18:20 -0700 (PDT)
Received: from localhost ([50.145.100.174])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a67csm26481338c88.13.2026.05.20.14.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 14:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 May 2026 14:18:18 -0700
Message-Id: <DINTFDZ1H8B4.FZ50CYI6WTVI@nexthop.ai>
Cc: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Guenter Roeck" <groeck7@gmail.com>
Subject: Re: [PATCH v4 0/3] hwmon: (pmbus/adm1266) add clear_blackbox and
 powerup_counter debugfs entries
From: "Abdurrahman Hussain" <abdurrahman@nexthop.ai>
To: "Guenter Roeck" <linux@roeck-us.net>, "Abdurrahman Hussain"
 <abdurrahman@nexthop.ai>, "Alexandru Tachici"
 <alexandru.tachici@analog.com>
X-Mailer: aerc 0.21.0
References: <20260516-adm1266-v4-0-1f8df4797258@nexthop.ai>
 <da0fbce2-788e-4419-8ca1-975311951ce3@roeck-us.net>
 <DINO5GQHP6VK.ZBC2D5ENBYKW@nexthop.ai>
 <DINRCDZ0SHS3.1X4T3VVLSL36E@nexthop.ai>
 <1783d74e-6acc-40d2-bdff-9bacbb04032c@roeck-us.net>
In-Reply-To: <1783d74e-6acc-40d2-bdff-9bacbb04032c@roeck-us.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nexthop.ai,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nexthop.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253388-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nexthop.ai:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nexthop.ai:email,nexthop.ai:mid,nexthop.ai:dkim]
X-Rspamd-Queue-Id: 9CBF259AC12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed May 20, 2026 at 1:59 PM PDT, Guenter Roeck wrote:
> On 5/20/26 12:40, Abdurrahman Hussain wrote:
>> On Wed May 20, 2026 at 10:10 AM PDT, Abdurrahman Hussain wrote:
>>> On Wed May 20, 2026 at 7:10 AM PDT, Guenter Roeck wrote:
>>>> Hi,
>>>>
>>>> On 5/16/26 18:18, Abdurrahman Hussain wrote:
>>>>> This is what remains of the v3 series after Guenter applied patches
>>>>> 1/5 (firmware_revision) and 5/5 (GPIO line label) to hwmon-next, and
>>>>> asked for patch 4/5 (rtc_class) to be dropped.
>>>>>
>>>>> Patch 1 adds a write-only clear_blackbox debugfs file. Devices
>>>>> configured for single-recording mode (BLACKBOX_CONFIG[0] =3D 0) need
>>>>> an explicit clear once the 32-record buffer fills; the documented
>>>>> sub-command ({0xFE, 0x00} block-write to 0xDE) wasn't reachable
>>>>> from userspace. The patch also acquires pmbus_lock at the
>>>>> adm1266_nvmem_read() callback boundary so the memset of
>>>>> data->dev_mem, the blackbox refill, and the memcpy to userspace run
>>>>> as a single critical section -- the nvmem core does not serialize
>>>>> concurrent reg_read calls.
>>>>>
>>>>> Patch 2 exposes the non-volatile POWERUP_COUNTER (0xE4) via debugfs.
>>>>> The same value is embedded in every blackbox record, so the live
>>>>> value lets userspace match a captured record back to the boot it
>>>>> came from when correlating logs. The block-read is taken under
>>>>> pmbus_lock to serialise against any pmbus_core PAGE+register
>>>>> sequence on the device.
>>>>>
>>>>> Patch 3 takes pmbus_lock in adm1266_state_read() (the pre-existing
>>>>> sequencer_state debugfs handler) for the same defensive-locking
>>>>> reason that motivates the new debugfs files in patches 1 and 2:
>>>>> any direct device access from outside pmbus_core should be ordered
>>>>> with respect to pmbus_core's own PAGE+register sequences.
>>>>>
>>>>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>>>
>>>> The series no longer applies after applying the bug fix series.
>>>> Please rebase it on top of the hwmon-next branch of
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
>>>> and resubmit.
>>>>
>>>> Sorry for the trouble, and thanks a lot for fixing all the problems
>>>> with the driver.
>>>>
>>>> Guenter
>>>
>>> Will do, thank you for your support!
>>>
>>> Abdurrahman
>>=20
>> Hi Guenter,
>>=20
>> Before I send v5 of the adm1266 series, I'd like to revisit the
>> SET_RTC exposure question from your v3 review [1].
>>=20
>> The use case I keep landing on is the one the datasheet itself
>> recommends: a userspace agent (chrony hook, systemd-timesyncd
>> script, or a small periodic daemon) keeps the chip's seconds
>> counter aligned with wall-clock so the value embedded in each
>> blackbox record stays correct across long uptimes.  The probe-
>> time ktime_get_real_seconds() seed (now in hwmon-next) only fixes
>> this at boot; the chip's counter drifts after that.
>>=20
>> You ruled out rtc_class and called a kernel-side periodic timer
>> "a bit excessive", which I agree, it is.  That leaves a
>> userspace-triggered sync.  Two debugfs shapes I'd consider, both under
>> pmbus/<hwmon>/adm1266/ (alongside the clear_blackbox,
>> powerup_counter, and sequencer_state entries v5 already adds):
>>=20
>>    A. RW since_epoch -- mirrors /sys/class/rtc/<dev>/since_epoch.
>>       Read returns the chip's SET_RTC seconds counter, write sets
>>       it.  The read has the useful side benefit of letting
>>       userspace measure host-vs-chip drift without writing.
>>=20
>>    B. Write-only set_rtc -- writing anything to the file makes
>>       the driver read ktime_get_real_seconds() itself and push it
>>       to SET_RTC.  Simpler interface (kernel owns the time
>>       source; userspace just triggers the sync), no payload to
>>       parse, no way for userspace to pass in a wrong value.
>>=20
>
> How about a combination ? read returns the current value, anything
> written synchronizes with the kernel rtc.
>

Going with that for v5.  One naming question before I send:

  - set_rtc -- matches the PMBus command name (SET_RTC =3D 0xDF), but
    "set" reads as write-only at first glance, which is a bit
    misleading for an RW file.
  - since_epoch -- mirrors /sys/class/rtc/<dev>/since_epoch, but
    that one is read-only in the RTC subsystem so the dual
    semantic might surprise users coming from there.
  - rtc_sync -- describes the write semantic directly, but leaves
    the read side unnamed.
  - rtc -- shortest and most neutral; doesn't bias toward either
    operation.

Any preference, or should I just pick?

Thanks,
Abdurrahman


