Return-Path: <stable+bounces-240459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC7DGm/96WmeqwIAu9opvQ
	(envelope-from <stable+bounces-240459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:07:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B7B451161
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15B1E30254F5
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C043CEB8C;
	Thu, 23 Apr 2026 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="WneiHKWi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D043C4569
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 11:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942379; cv=none; b=BkiJyAoSXGHWeMhtfo1lG2YmHozti0dKSMSPzVJs0KOcOSe7M57w91gsR+IvLyxY4Cp/muhe5SqVI85LcARGK+VO58+irpIQQroNPPfDKa/8LXAebbAZhhPJdpIuk7JmmYHH4xDGQDIQgUxhXkTrvj/u1HSxvtwHgKtqC/6E/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942379; c=relaxed/simple;
	bh=WuGbQUl6upA5vm2V0Qt0E3v6mLBMgPg026w2N5bkFJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZpG3IGSEuhlhiQQEtU5RZnAAqjdz1mKFmebcJ3t4iEieagyr+q54RkJ6RWMmjJdkgUdVOfZxcT0QQKZH0AtLDn4QjZ4o3JLWaJgd7sZsycXD5seQfpPPeDVGBKvDIxdzZdOyX7kvGPuWkkkFqyVLcw28mLxEVQyZwB2CeOt/tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=WneiHKWi; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7dcd17e19b6so2028113a34.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776942377; x=1777547177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R7TrFCQcg8Ms6iW9sdur5t8Q93cQEF3dtFZPdGVKIQY=;
        b=WneiHKWijiXnQLcboKFHNqqAykDgBCKTTLryL0VxNmRBU3ZurbUtBWKZJQTiTP6sGF
         Ru+uxeXyaeQCAKZ4d/wQ324UHHB7K3RFzFResHZaA1JKu1zeRFLJkzfmMP3FUL6JXq+d
         uWe40uiPp+6C3mpyE27MS0zAdPYNDZn+q/EPkNoJYd21PFj2QihSqhlRDpTgUuceC4Dv
         S442OTa/BUbI8eGDhIJWZR4ZrHUdPGTEL3aYkZCLFuxMuDDrRNErrSAVqny0A5IPjaPY
         h1D77+NtgE8Vt1CIhRoUVL73iOoO6DK6egp3XMmjNg7Kp7hq9ozkQQI4zg3Ep7OpgJ0E
         JrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776942377; x=1777547177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7TrFCQcg8Ms6iW9sdur5t8Q93cQEF3dtFZPdGVKIQY=;
        b=ES7EOLCF6MMeSTSL7KoLy+mLIPfz+mtyuxVt1oItN7qDSKGygZcMW6cQFhYtHvtDY1
         7BjtEWvJpuVgYCpOlIo3qgr5nSfwRdKYfbGnwqXQTZuo9gOfHIZgumKbRQMCrugie90C
         9+4u/cJefySEG5zda7zfhB/NUvylUT0OlO/2kW9HhSLvzsUJBDe3OjM18Xz23Fpa/eI1
         9vcTn5BchOCqUzre2jD8cahCCmCIHNX/JBO3YxlkKbLqE9UN02aIv2ATDSlnrWJPicEW
         /5mUD3xOPjJE+VvRrfM3mFg1NeV1eWEeEskxmit7gPkyAzYEi8cIcIK82+ksUsYOwcLB
         nKzg==
X-Gm-Message-State: AOJu0Yzm9ddzQlV8WFMH+/dQi6Gb2MGA4iacOYp7Zp57YIYZamUqLDm5
	4JL3qBDceKKLneJkv3+AEoEhiyrYUUKS86f2wGkw5g6kr2hLrBEeueRmxW3SCWROtFKbLINkupk
	844uWNho=
X-Gm-Gg: AeBDiesYo5gyydKfHEGZCNEzmZ9mdig2h+5hPDgTd2scqFxZ1olhBQZPwSpHGpDfla0
	5S1MtdYzZczOQ7LajkubRPTgvZbKse3WbHqlpKIMW1k5DbKGZKagbb3E5ewhpijJE9Fs4CPClW/
	DO0wSfPLE2abSmrInbmF0mrQ0sx7phN2PO6lS8TIKtMFiCu2y1CVwu/J2aJiX9EnkW1WTYGzjCD
	NYYvvf95jmffU9t6Qx3qtsnriCHuPwYtFY9htmqPg5nW03iDv1omTfau6k9bi450iFF/SclzV2O
	k1t5t0GvFkvct8c7RrXSFj3i5ofJ23Erl267CRarSLR+Xf6ohPnc8ZRalr2KT7k9H5a7rP78leO
	9MXzhBP+wDucmv7zYnKdr+xlDX6mIsuFeZWT2eDfRBZ1UE+ww89xBUbAirox4TzuSquXKlzH2sQ
	/GSER7Tv5hvzHfKeEKeqwUrA942ksKJbCtUT6hKXVNApYecoys6lNdv4CeWLFl7YIUQIArMyc6/
	Cup6DiScsGBWqzEQwSipogUnCWMSj8=
X-Received: by 2002:a05:6830:67db:b0:7de:4a4f:1b02 with SMTP id 46e09a7af769-7de4a4f22efmr1163965a34.0.1776942376760;
        Thu, 23 Apr 2026 04:06:16 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcd5408b5asm7232533a34.11.2026.04.23.04.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 04:06:16 -0700 (PDT)
Message-ID: <f661cf47-18bb-44f2-8764-c9f0b4fb68b1@kernel.dk>
Date: Thu, 23 Apr 2026 05:06:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] floppy: fix reference leak on
 platform_device_register() failure
To: Jiri Slaby <jirislaby@kernel.org>, Denis Efremov <efremov@linux.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
References: <20260415145708.3331818-1-lgs201920130244@gmail.com>
 <177645836617.906013.5675762942401997007.b4-ty@b4>
 <897f442d-4e04-4b70-b716-38fd10b8af36@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <897f442d-4e04-4b70-b716-38fd10b8af36@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240459-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.com,suse.de,vger.kernel.org,gmail.com];
	DMARC_NA(0.00)[kernel.dk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:server fail];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:mid]
X-Rspamd-Queue-Id: E3B7B451161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/22/26 11:11 PM, Jiri Slaby wrote:
> On 17. 04. 26, 22:39, Jens Axboe wrote:
>>
>> On Wed, 15 Apr 2026 22:57:08 +0800, Guangshuo Li wrote:
>>> When platform_device_register() fails in do_floppy_init(), the embedded
>>> struct device in floppy_device[drive] has already been initialized by
>>> device_initialize(), but the failure path jumps to out_remove_drives
>>> without dropping the device reference for the current drive.
>>>
>>> Previously registered floppy devices are cleaned up in out_remove_drives,
>>> but the device for the drive that fails registration is not, leading to
>>> a reference leak.
>>>
>>> [...]
>>
>> Applied, thanks!
>>
>> [1/1] floppy: fix reference leak on platform_device_register() failure
>>        commit: e784f2ea0b4fd0e7b70028ff8218f22456c5dcf8
> 
> The patch is likely wrong. Given the pdev is static, the struct device
> has no ->release, so releasing it will trigger a warning. AFAIR, the
> consensus was to fix platform_device_register() proper.

Thanks for letting me know, I'll revert this change for now.

-- 
Jens Axboe

