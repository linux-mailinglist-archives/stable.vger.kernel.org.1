Return-Path: <stable+bounces-244655-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG6nL25F/WlDZwAAu9opvQ
	(envelope-from <stable+bounces-244655-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 04:07:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4048F4F0B28
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 04:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 848BA301724F
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 02:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A6B2356BE;
	Fri,  8 May 2026 02:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ls3GuThc"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBF23EAB8
	for <stable@vger.kernel.org>; Fri,  8 May 2026 02:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778206059; cv=none; b=etoJORL8IXOooPPQ13Ss8m9w5meswyRZqi9aab4jwFJAkpkNvjZnk9C7wLB3mQABIx1hPfE5p6EDFuVf2wxY2wFrNUKeAzjWpwLPVMm4rTHarUmcFVNCVNG6BVTkMU17WuZEexNYsKxxpH/dvjH+v7i9VJ1bFgqDaBD7E9H5FFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778206059; c=relaxed/simple;
	bh=2VhgdgEm5IIGbyiErgKReSOhIxWfH+C205LBTk5826s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aj+Ar4W6YjRBS3jfGgCrbAnKd95UIxw2gSMjUPeKFXBY9eh73F8Q2NO4y2118f4SqUTNTPPcsJ51GwxaC0AsJcFjFUKcYjKNn9r3IzBWn4MzJI9EnH4zLua6YLzOQdh9naN3WyF9DFuKupSjIOG5t1NXbDDSn2FUbfK651jqR0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ls3GuThc; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso15900705e9.0
        for <stable@vger.kernel.org>; Thu, 07 May 2026 19:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778206056; x=1778810856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHjmy5FAd8VAh5s53VyTrTo3cYb25FfQ5d7Ek1Cjgc8=;
        b=ls3GuThcOGt6g81emH4BxqaWqis3O1q/ad6ssknmQbpS/ht2L96egIXm+xOr4FTDfA
         bYzo7YzxpF56Uxnnp4wiG0AgBVykYiSFT+nOc+3Ff/ekkn2A+N/L9ZsPuS0i3ZdbV5Oe
         8H/oy4FbxqatctTbUqcxcGJ7NZl3n41o2UyumU90Ik8m6C6NgQEdCC3iW6U0M5W8lhVq
         EWqrngRLPnAY958A1R6TfXKjJtx2ahrS1LxRGhd+zcElKadmOYWAJ+IkNtppKflrQRPR
         HN32nN9hCKYDxiaC+T4rjZxJAqH0Q8FNSdYv33kzNCD+pZQEWmqgTf0NkE1fHHsy/SIJ
         nnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778206056; x=1778810856;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHjmy5FAd8VAh5s53VyTrTo3cYb25FfQ5d7Ek1Cjgc8=;
        b=hpk08G9iAdmHGYsLMPFG85Giec8UiqqOIu+4Ahy9comlcMPJTiFwqdi8sQpWHp5Cj7
         KB8tPmtemfQ6My9ZDZ7dunZcy6Ejl8OP62jfiwBintrCYEvvh2JFpCdNYLqgxec0O0Vg
         yGu4QY+DffYWa5Zxm4O29aMz8LMY+IvPOcJst2NM79BlzQIEH02SaL+RdRR0VYuQHW9G
         vBVv+6sH6Nwcxb8pznvCq/3wEKfy+S6A2zdx8rg4XenVTqYgS/CjVAq0MMmeaQKAmbIb
         lnmrWlhBaeY44qwlelaos6jf6i8G3EF1DnXfC7iY+HfKxCOaZfE9MICsD40oMcMFOTLh
         1low==
X-Forwarded-Encrypted: i=1; AFNElJ/VUYjEH1DT5DQZLe3p96n9UtNS4OuW5hqbQJDB7vp9J/58CnOI5QRM4QU4o9/CgcuZZZ0NX4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJUqi7TJBwtrZxOiSVOKv6hb4EPuwBTcaxnb8uokrHvxNQ6sF
	ZgDeuPZkVgqD3YifnSyUD8CZT9SObKofIznNkN8ReBmZ9JG2L5rxZOhfJXsysQ==
X-Gm-Gg: AeBDietJAzzlZu5pgIbsDOJaQCVW39I0eLbyj8KiXJlExdTa7Ly0m09dHSoLrOY0yrM
	n01amrcgsnT362fp3Ilig3bm9KbQJ4Ur624IgGjmOhc0VYgopKWLpc8/s/EJqsvzKUY1rp4PWz1
	NaktWVBYtRIfrmlpQPELNpTLAEuWLTypfqaMzy86E4w9XxT6YAt152a+FOJeW54HXvSlmKSVz/a
	s6+sjxUMf0F8dxMep9N98cTQl0NHiRkw7omBVmC3vMCDiwYJzUt8VEyUy02lJZ3gbcvW5WQ8CnQ
	QsITByVxXWjL6wyhK5hIPVXEB4ybNIY9MxTbsTyHJlwGThv9uy8UlEsQ0fZC8a11q/aBDgMcH+z
	hzEF1QxyhWIuDJyZhWQE+waosjZos4Uc86oLjN2BbyDgdKu9QNmqiKn/usZXDfpK8eo9owvusTM
	+sTSfKTWVh7zsqMIyVOANAye7otrrk6dRo+/Uxx2+bF93vKWPJQrH4L8GCq4Eg0c4tx1p1i54CH
	dNnc52M9ef4SEIdso9Gs+hGsGsaaGSK
X-Received: by 2002:a05:600c:8011:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-48e51f3b589mr155773675e9.24.1778206056307;
        Thu, 07 May 2026 19:07:36 -0700 (PDT)
Received: from [172.29.5.173] ([31.45.242.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f43ba0sm120535e9.11.2026.05.07.19.07.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 19:07:35 -0700 (PDT)
Message-ID: <33d232bb-29be-4f6d-b148-3daae9df0776@gmail.com>
Date: Fri, 8 May 2026 03:07:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0.y,6.18.y 0/2] Backport io_uring commit to affected
To: Jens Axboe <axboe@kernel.dk>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org
References: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
 <5fed66f0-ea72-4f36-bf50-2d7c39c4fdeb@kernel.dk>
 <12c809f5-1326-4cd3-9d4d-2bfb011b23e4@kernel.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <12c809f5-1326-4cd3-9d4d-2bfb011b23e4@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4048F4F0B28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244655-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/26 23:46, Jens Axboe wrote:
> On 5/7/26 4:41 PM, Jens Axboe wrote:
>> On 5/7/26 6:42 AM, Harshit Mogalapalli wrote:
>>> Hi Jens and stable maintainers,
>>>
>>> The intent of this series is to backport commit: 770594e78c39
>>> ("io_uring/zcrx: warn on freelist violations") to 6.18.y and 7.0.y.
>>>
>>> This above commit likely is fixing commit: 34a3e60821ab ("io_uring/zcrx:
>>> implement zerocopy receive pp memory provider") in 6.18.y and 7.0.y.
>>>
>>> Pulled in a prerequisite to cleanly apply the fix. Only build tested.
>>
>> I don't think these are actually required, but at the same time it does
>> not hurt to add them. I'll leave that to Pavel to decide.
>>
>> In any case, thanks for doing the backports!
> 
> Adding Pavel, I had assumed he was already on the email, as he's the
> maintainer for that file.

What's motivation for this? I don't mind to have it (after review),
but it's not a fix, and I know people want it in stable to claim a
hallucinated CVE, and the CVE part is not going to happen.

-- 
Pavel Begunkov


