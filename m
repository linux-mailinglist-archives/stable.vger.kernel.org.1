Return-Path: <stable+bounces-253398-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMBxDzwvDmoK7wUAu9opvQ
	(envelope-from <stable+bounces-253398-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:01:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F23B959B9BC
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 00:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CE983064899
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FE33A7842;
	Wed, 20 May 2026 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSEbJw1a"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C468E3A758F
	for <stable@vger.kernel.org>; Wed, 20 May 2026 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314307; cv=none; b=nyWhBc/04CyqisNN/m/BtiX1IuYodPEU0VffydcE1htQfPz1aT+hrdD0sL1r6MsyQrHBKtFs8dzIloOUJzJB3e5XW0RjwRjF/BhzcL7EJOmOCY1AmGnrDgOJNTqASesse57wCHPjQg5zmuCGxfH+lntunXjE89NrB2wVEvuPFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314307; c=relaxed/simple;
	bh=ZJKCNJx/5IZ/imrwcqhHUrotj+Eo0tiqecZnQykyYOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIfaPJtrHRGkzklDCQDrPmbE8b+6sEMV9SRW5Ymc6X7zXmXsMZHe88zSmh+/t2zn3WM1+m4mcAYp2SzImv8LpfoPjlA68AzB60T2U54JepQVw5DCCzLkvqPEgIhCiQNf7lFfFzChsrS7wPKPRTec989R7fB9fTmrxGFUNjEz8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSEbJw1a; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bc763e2ba8so25963125ad.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779314302; x=1779919102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=J81DA5Ki03IoGYOcCJh6J9dCQ0EPDVhxT9au4TbcbO0=;
        b=QSEbJw1a+VZ/sKYE33oaSZRwDAu/4S4mZtFTs3U0udssAcEqAJ4X+K/Od7q6jMPVjw
         pQY9wP6kLoeSgTWmiiSxxovrT9UeoA8xwq7f5YTcM7TENPjYssv0PoeOb0cWuWX1U89h
         2TJsL+rugIqnop6Zh+1xskS/oD8nqr0dqO4kfYAG6qDWtu2EEZCvj8GIJL4fAKe9Atwd
         nIwpn6h8ht3xQDp30B3+392466blVxtM74ar2BRJgOnpMQhMciY0EsAAGrtH4W0qy6Ht
         nPil5j744XYcJDots5xYBwaJYpCXe7VhqNps8tIFMIr8/hc7k8Rd4GE/irekdAgQE9K4
         W5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779314302; x=1779919102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J81DA5Ki03IoGYOcCJh6J9dCQ0EPDVhxT9au4TbcbO0=;
        b=knGECU+havWq9O27tCqL0rtETuJKBOPnWZo7Nd485SjBhift7pDvLVgeMvQtiboW9G
         cpSCmFcK/CinniOGBSanWfI3HH6nEbgK1S3Fo2BeU6BAmccS/OgHRRC4ThgmjnBMIchk
         k4udaM8x+zC/3W1sRssPeAFiTKl0H1RHhGWK9o0O77xwJ3HL9WSof6e1c3EZzYAflnS0
         NBNriuhWHThwHgC6PgAz0T24FEniWMOtV4WF/2zmtBrQb20sw5BapvhjX4R+pL1lcYwv
         aielxIsae8J0qrB1ZjN9k5H9SPHoxhrrN0Veq9YcX4wZjonEpMCr0ZlxE2wGE8EOlLKQ
         DlIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+t5xqpHyNeKvCagfsc+m8IMzEnC7o1bpPfUHDX/MSWvKiBlT4JagiO7kA1mm32x8vcsH0IgGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7hZjV0mNRDHBP2H7KLNyLVFxmG85FWvGI84at2rwdmsK3k/LW
	AC4bWwgnb8B9sphITLzeUQHCaJVxC+GKS8SFj6ppegrHy6NnqBVPC6ny
X-Gm-Gg: Acq92OEeHikEmWExfC4YSS8MlabZ7qcRfHFc8o7F6PJwLDK+6i6dkJNj+cmV26Y9sOJ
	/kjmH99Le/snBcl4TPu2A881YNbAKptm6pcv1h93+MyMTTKfYgX/DTJshiWJCAZY6V58xgHLER/
	tK/7Jdqh8q5SKw71SqnXjYy6+vtYnJSfRr5WZccZiHh8M+EBm6F0UBvfk7AwdY/5GnuAKCNO9K2
	YmITOi86eRfZLECNV3ZAGuP2LdpJJTIpSpb6riTih2xHvc/YTfrv/AYNwUw5wq2+tOoaehlnQCg
	cnmC8aN6ysMgvshl8G/Z8NnyMAuJIwj67lI5HZ6oMSgbarWyNVnCPd7stY+QdPxf8uhxJFsKZWJ
	nk0M3Dh1lghFICHcIJgrE7bpd+ZtfW8ViJjXHaJxcK9SI6cdrxYYs7N7VgjBwNegWsk+53XXcJ4
	AjxuiKwOEjLW09TW8muxE2/v9wTeqveEHanTacENLt7er+kzZWiTTrPPeJNXQwWxUzIl99HVQna
	Scr6q/JUWe2tQ==
X-Received: by 2002:a17:90b:528a:b0:368:147f:bd27 with SMTP id 98e67ed59e1d1-36a45758617mr266709a91.23.1779314302401;
        Wed, 20 May 2026 14:58:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3d0d847dsm563006a91.10.2026.05.20.14.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 14:58:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6cae33e8-410a-4ffe-a44f-642f2239323a@roeck-us.net>
Date: Wed, 20 May 2026 14:58:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] hwmon: (pmbus/adm1266) add clear_blackbox and
 powerup_counter debugfs entries
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Guenter Roeck <linux@roeck-us.net>,
 Alexandru Tachici <alexandru.tachici@analog.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Guenter Roeck <groeck7@gmail.com>
References: <20260516-adm1266-v4-0-1f8df4797258@nexthop.ai>
 <da0fbce2-788e-4419-8ca1-975311951ce3@roeck-us.net>
 <DINO5GQHP6VK.ZBC2D5ENBYKW@nexthop.ai>
 <DINRCDZ0SHS3.1X4T3VVLSL36E@nexthop.ai>
 <1783d74e-6acc-40d2-bdff-9bacbb04032c@roeck-us.net>
 <DINTFDZ1H8B4.FZ50CYI6WTVI@nexthop.ai>
Content-Language: en-US
From: Guenter Roeck <guenter@roeck-us.net>
In-Reply-To: <DINTFDZ1H8B4.FZ50CYI6WTVI@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-253398-lists,stable=lfdr.de];
	DMARC_NA(0.00)[roeck-us.net];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guenter@roeck-us.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nexthop.ai:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F23B959B9BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 14:18, Abdurrahman Hussain wrote:
> On Wed May 20, 2026 at 1:59 PM PDT, Guenter Roeck wrote:
>> On 5/20/26 12:40, Abdurrahman Hussain wrote:
>>> On Wed May 20, 2026 at 10:10 AM PDT, Abdurrahman Hussain wrote:
>>>> On Wed May 20, 2026 at 7:10 AM PDT, Guenter Roeck wrote:
>>>>> Hi,
>>>>>
>>>>> On 5/16/26 18:18, Abdurrahman Hussain wrote:
>>>>>> This is what remains of the v3 series after Guenter applied patches
>>>>>> 1/5 (firmware_revision) and 5/5 (GPIO line label) to hwmon-next, and
>>>>>> asked for patch 4/5 (rtc_class) to be dropped.
>>>>>>
>>>>>> Patch 1 adds a write-only clear_blackbox debugfs file. Devices
>>>>>> configured for single-recording mode (BLACKBOX_CONFIG[0] = 0) need
>>>>>> an explicit clear once the 32-record buffer fills; the documented
>>>>>> sub-command ({0xFE, 0x00} block-write to 0xDE) wasn't reachable
>>>>>> from userspace. The patch also acquires pmbus_lock at the
>>>>>> adm1266_nvmem_read() callback boundary so the memset of
>>>>>> data->dev_mem, the blackbox refill, and the memcpy to userspace run
>>>>>> as a single critical section -- the nvmem core does not serialize
>>>>>> concurrent reg_read calls.
>>>>>>
>>>>>> Patch 2 exposes the non-volatile POWERUP_COUNTER (0xE4) via debugfs.
>>>>>> The same value is embedded in every blackbox record, so the live
>>>>>> value lets userspace match a captured record back to the boot it
>>>>>> came from when correlating logs. The block-read is taken under
>>>>>> pmbus_lock to serialise against any pmbus_core PAGE+register
>>>>>> sequence on the device.
>>>>>>
>>>>>> Patch 3 takes pmbus_lock in adm1266_state_read() (the pre-existing
>>>>>> sequencer_state debugfs handler) for the same defensive-locking
>>>>>> reason that motivates the new debugfs files in patches 1 and 2:
>>>>>> any direct device access from outside pmbus_core should be ordered
>>>>>> with respect to pmbus_core's own PAGE+register sequences.
>>>>>>
>>>>>> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
>>>>> The series no longer applies after applying the bug fix series.
>>>>> Please rebase it on top of the hwmon-next branch of
>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
>>>>> and resubmit.
>>>>>
>>>>> Sorry for the trouble, and thanks a lot for fixing all the problems
>>>>> with the driver.
>>>>>
>>>>> Guenter
>>>> Will do, thank you for your support!
>>>>
>>>> Abdurrahman
>>> Hi Guenter,
>>>
>>> Before I send v5 of the adm1266 series, I'd like to revisit the
>>> SET_RTC exposure question from your v3 review [1].
>>>
>>> The use case I keep landing on is the one the datasheet itself
>>> recommends: a userspace agent (chrony hook, systemd-timesyncd
>>> script, or a small periodic daemon) keeps the chip's seconds
>>> counter aligned with wall-clock so the value embedded in each
>>> blackbox record stays correct across long uptimes.  The probe-
>>> time ktime_get_real_seconds() seed (now in hwmon-next) only fixes
>>> this at boot; the chip's counter drifts after that.
>>>
>>> You ruled out rtc_class and called a kernel-side periodic timer
>>> "a bit excessive", which I agree, it is.  That leaves a
>>> userspace-triggered sync.  Two debugfs shapes I'd consider, both under
>>> pmbus/<hwmon>/adm1266/ (alongside the clear_blackbox,
>>> powerup_counter, and sequencer_state entries v5 already adds):
>>>
>>>     A. RW since_epoch -- mirrors /sys/class/rtc/<dev>/since_epoch.
>>>        Read returns the chip's SET_RTC seconds counter, write sets
>>>        it.  The read has the useful side benefit of letting
>>>        userspace measure host-vs-chip drift without writing.
>>>
>>>     B. Write-only set_rtc -- writing anything to the file makes
>>>        the driver read ktime_get_real_seconds() itself and push it
>>>        to SET_RTC.  Simpler interface (kernel owns the time
>>>        source; userspace just triggers the sync), no payload to
>>>        parse, no way for userspace to pass in a wrong value.
>>>
>> How about a combination ? read returns the current value, anything
>> written synchronizes with the kernel rtc.
>>
> Going with that for v5.  One naming question before I send:
>
>    - set_rtc -- matches the PMBus command name (SET_RTC = 0xDF), but
>      "set" reads as write-only at first glance, which is a bit
>      misleading for an RW file.
>    - since_epoch -- mirrors /sys/class/rtc/<dev>/since_epoch, but
>      that one is read-only in the RTC subsystem so the dual
>      semantic might surprise users coming from there.
>    - rtc_sync -- describes the write semantic directly, but leaves
>      the read side unnamed.
>    - rtc -- shortest and most neutral; doesn't bias toward either
>      operation.
>
> Any preference, or should I just pick?

I like rtc_sync the best, but I'll accept your choice.

Thanks,

Guenter



