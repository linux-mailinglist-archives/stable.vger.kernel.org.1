Return-Path: <stable+bounces-210499-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC9xFJEhcGlRVwAAu9opvQ
	(envelope-from <stable+bounces-210499-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:45:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C134EA6C
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 01:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 58FEE661A96
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D723C3ECBE0;
	Tue, 20 Jan 2026 12:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MfO4/tth"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5A42669D
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768910655; cv=none; b=n6Ybme119aL8JraOIgPHHbyDeZ2fDKjNaVOWsVjSziFtTpXcwjPF6LIC8czH/KOt/Hudr1+rr+794Feg/Eh4LaSpOVndWrafnLhCoQcxPOKY9cRzABOaSCglutkfCR3YYB89VKaBUy0hO3C1spsFxEjs3Jvvgh1j6jT/Z+FsD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768910655; c=relaxed/simple;
	bh=N5V/193EphN1/dy/Da4Wf3eE2aKK1lzEAiTEDPjaRgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GExRvv8yTi6W6eXzhNH8Vv7j7Th3CHNBVQnMgGgJV/5km8f58275p1RTZaqQQ50a1KHcrFlBEoG+ugs3WLVta76lh2uU6EftwxotoGmpgZj0duyUAi/YPnfNODOKDEnUezaZFCAXXm4JPj/X/xDvEmAW2Br4f2ZD2zUUGkY0mVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MfO4/tth; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7cfcbf34124so3464906a34.0
        for <stable@vger.kernel.org>; Tue, 20 Jan 2026 04:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1768910652; x=1769515452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vul17wrC6MbwDzM3wl7ZegOxGyDJJHAhPHQeTyTGhs4=;
        b=MfO4/tth8y9dh7pxTOPmHF/BayucmzwncBPiJwMCjJcx0FDhdLlXvwCuNd8wQB+1sp
         zKc87L2zUsHryD9cr0ULpW5rfpiUBMUHc1X1LM4kqPzprpga9FNs74rIV3n4W29utpx/
         rUk27c0kaSSOSxeqdya2jUbqqYicTowy9DJ1fi4ciPxh3LfjtstWc+i5IfizEWv7QWWR
         W+clwyABC8gXVF3/AmMbsVBpxA8ubvEqVeJtcMHohtJmctZxW3gNctSoWnTC36e8JDMi
         nPrBp1yzY+VAAfqvsqFTeU0XAOwEvre8GeiuYb/bhKJyN5evbtJuJR6y9gXQ/frDMUi9
         C16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768910652; x=1769515452;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vul17wrC6MbwDzM3wl7ZegOxGyDJJHAhPHQeTyTGhs4=;
        b=f+Y6b7DAfeFbAWl9FfeygZwczGisKLGRYGBSJmzVw6aKGceQugO3ErCVR93xM+Cv4R
         30/a5DzMTL4UeU+iI7Z1fjnlbEi4pK6+iwBYyi/DuAzgzPD8gDUuPBDzDEcGPxZmMm7S
         LCW7c4Gb/jllqMwT+pbba8gmsulqFmN3Vsb24w0VZZj9acQVDKdVlrGy1s5oEeYMQ3Ay
         lalioUKDArXvk8emV9yK7mRLZnK/a3b5XZxU68ws/Di1AUzpdJZF+Z/D7o7t3NzTfA5I
         hOEkXXB5zsx3anh6zBZOZLhRXHh0Iio+qTr+aRuBZVmdc0ejY5TAUhtPMcKWF/upCYu9
         T4wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcuDyNo359ppwLhir3CP9ZqF1Fj9UwhbkrTqIno6C8WNosp5jagaSV4O4b4x8cmB4V0UiOg8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YypxEjJfkLaV0ef6xOqSEycJKaBP+Gm35wcmAMuH/6bsEk86tQe
	1dE5kaBQ7vR5ATqlWuEUUSGmcD1ka3sQiVpE6woIJTbeJw0uI3vRbwpODDOE4Bu81Yc=
X-Gm-Gg: AY/fxX7i4mg/ffCyNuVNW56eOCzgWKYUoQ84NpdXD1KTHQgc0WVPN9VEvSKVlXK2PtL
	kwf5NMk6Rhq/gWyhYXvuZ3pdtkQ7dAnmZlsxR9TC4p+2M5DKZ9UjKmFW9asiDCGZ/0WqDh3bqFT
	wxmHzOzdT3WCs5O+0BykSkEbN6YL2AChbp7WvnHxjMsmSsVF+8wjZ21t5wQVZR8dPLnXjb+GvMk
	kCCeFMySQb0k7Y3Fieo37i7VYEYDQPOMwO2jHQexlFgZ+w49E/bpdigQFMGLqu1gWtuY2wxpep5
	qrGSlLz5ABm0bLagQzcwdj9pwiJpKTzDCULS6rJWOkKrBj089UJ5Xm+SoAAUMinlKPj0nNbJyvH
	B//A/Xct0OFPeQdRlpgXbOua91WSq8BBJWLr4sW5kFVQNqF1Ch38UwZCBnkZMy+mk71mQ75s7Zz
	hcZ5JeLW0tiIPVIzpdfyNSolmI9Ok/ERmV6HVlntIUz07NVdPwtoa9luKuS15bddfOALeNPuMQO
	N/Zuvak
X-Received: by 2002:a05:6830:67d5:b0:7cf:cc2c:1d9f with SMTP id 46e09a7af769-7cfdee6326dmr6316522a34.32.1768910652662;
        Tue, 20 Jan 2026 04:04:12 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2b5a74sm8318908a34.29.2026.01.20.04.04.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 04:04:11 -0800 (PST)
Message-ID: <c019c249-ae7c-4034-9d1a-e4b9e200453a@kernel.dk>
Date: Tue, 20 Jan 2026 05:04:10 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] io_uring/rsrc: fix RLIMIT_MEMLOCK bypass by removing
 cross-buffer accounting
To: Yuhao Jiang <danisjiang@gmail.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260119071039.2113739-1-danisjiang@gmail.com>
 <bc2e8ec1-8809-4603-9519-788cfff2ae12@kernel.dk>
 <CAHYQsXTHfRKBuTDYWus9r5jDLO2WLBeopt4_bGH_vVm=0z7mWw@mail.gmail.com>
 <2919f3c5-2510-4e97-ab7f-c9eef1c76a69@kernel.dk>
 <CAHYQsXQK4nKu+fcni71__=V241RN=QxUHrvNQMQtPMzeL_z=BA@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHYQsXQK4nKu+fcni71__=V241RN=QxUHrvNQMQtPMzeL_z=BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210499-lists,stable=lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,kernel-dk.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D2C134EA6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 12:05 AM, Yuhao Jiang wrote:
> Hi Jens,
> 
> On Mon, Jan 19, 2026 at 5:40 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 1/19/26 4:34 PM, Yuhao Jiang wrote:
>>> On Mon, Jan 19, 2026 at 11:03 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>>
>>>> On 1/19/26 12:10 AM, Yuhao Jiang wrote:
>>>>> The trade-off is that memory accounting may be overestimated when
>>>>> multiple buffers share compound pages, but this is safe and prevents
>>>>> the security issue.
>>>>
>>>> I'd be worried that this would break existing setups. We obviously need
>>>> to get the unmap accounting correct, but in terms of practicality, any
>>>> user of registered buffers will have had to bump distro limits manually
>>>> anyway, and in that case it's usually just set very high. Otherwise
>>>> there's very little you can do with it.
>>>>
>>>> How about something else entirely - just track the accounted pages on
>>>> the side. If we ref those, then we can ensure that if a huge page is
>>>> accounted, it's only unaccounted when all existing "users" of it have
>>>> gone away. That means if you drop parts of it, it'll remain accounted.
>>>>
>>>> Something totally untested like the below... Yes it's not a trivial
>>>> amount of code, but it is actually fairly trivial code.
>>>
>>> Thanks, this approach makes sense. I'll send a v3 based on this.
>>
>> Great, thanks! I think the key is tracking this on the side, and then
>> a ref to tell when it's safe to unaccount it. The rest is just
>> implementation details.
>>
>> --
>> Jens Axboe
>>
> 
> I've been implementing the xarray-based ref tracking approach for v3.
> While working on it, I discovered an issue with buffer cloning.
> 
> If ctx1 has two buffers sharing a huge page, ctx1->hpage_acct[page] = 2.
> Clone to ctx2, now both have a refcount of 2. On cleanup both hit zero
> and unaccount, so we double-unaccount and user->locked_vm goes negative.
> 
> The per-context xarray can't coordinate across clones - each context
> tracks its own refcount independently. I think we either need a global
> xarray (shared across all contexts), or just go back to v2. What do
> you think?

Ah right, yes that is obviously true. Honestly having a shared xarray
for this is probably even better, rather than one per ctx. Should not
change the code very much over the existing test patch. And it won't
consume memory on a per-ring basis. Downside is of course the need
to synchronize updates, but should not be a big deal as accounting
isn't a fast path. IMHO, just go that route.

-- 
Jens Axboe


