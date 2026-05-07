Return-Path: <stable+bounces-244648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xpyPDmoW/WlIXgAAu9opvQ
	(envelope-from <stable+bounces-244648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 00:47:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5F14EFE34
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 00:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1822B3015A6A
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872F2F8EBC;
	Thu,  7 May 2026 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="LisTNqiy"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B22F8E9F
	for <stable@vger.kernel.org>; Thu,  7 May 2026 22:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778194020; cv=none; b=T+fgZ5taubD512tbB5Velz6evF4PWBdZwKajscPuYOdNlo8XhIyZwgUFDcOSVb2/4q7C2lM6sMQcWtLieIrSH8hdzarwkH/VR9lx9oSqebZ7zF5Aww+aAIwu/w7AuqgcTUW8cYDtQypRz6EpRbQCR+l2L47tV0UfCq/aBkWFvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778194020; c=relaxed/simple;
	bh=cpcPTjjL0ESeQFPwTRJDxYElHlN+DxG+yqPzFRlnCd8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=kTLsDn4ws4aAM7fZnMUq+xBWXuDjaof8At/netPkHDK3egHNA1G8mNpSp/DNnCcOw6n+AM6sNhYgv/RqeJhstjlrxK0BPoVKdFpld+moVsNOKAFqZ/LOl1XVaeCF4HxGzmew7LdWkBXyBroEx3r+GN6nEv8M4sQp167rGsOwzmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=LisTNqiy; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7dcd89701acso1304921a34.1
        for <stable@vger.kernel.org>; Thu, 07 May 2026 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1778194017; x=1778798817; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kiQ3P2gC1LTtnG/iehLF6LhZJqZTTIucvfOy611uss4=;
        b=LisTNqiya44q6P3Oqc6+F/2jXUBbYcszC3RDSnqyDgME8s3ejhn/MZowYVgxD4uoYJ
         04I528RrXssS11CxOW9eaUFGwxUFmZcm4+DHEqV+sv8GbjHf4DYP4kduksuK05hPphqQ
         ScmeJjO4H7/WPvGjjQ4KlWnegDUkfHbpiYua5cOv90vTCDs/kcEcGwN4A9MOeX7WhYFS
         Va5waV8xTQfTDx9o9RuM3gCsrrLmyVYQsU6OFX2darrzgkr6o9/OsBFDg4GjIZvCU6l2
         gH8xCrWt76YzDYVSapy7rso9VHMbXprJHi9GW8E+rHgvR2zCZ/o58oIGzoU+jb1S9wNu
         BlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778194017; x=1778798817;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kiQ3P2gC1LTtnG/iehLF6LhZJqZTTIucvfOy611uss4=;
        b=r01Yt1Vc8+NMz31MSDvlFv10RB7MTSSdPXtZGz0AyyHtL3k5KpfaqFqcBBnRTRQRrQ
         lNIsNudik9u99hVFMFAfGWXXgoy8goTzdoY8tiYQpd5R2YYcs8wdL+DqLT4QbyrrZ1PH
         RLObB8ZEvREPK1rOh3IVFkbD5QgvTyYHTs0hlEx9C8ZG0bhrtiPtLv17D4w2o6plyToL
         QmFvKQ6oyDHS72AQY7kKw2W9oa15kZeqxF89YNuKLTjRKCttKJOJt3ckOPOBTnjHMs6v
         mRQViOtYIiBbJCIyWCp5qbnk+LXgB/hJ8zFOYc9Euuv+ykrhVbt8gXzkpLh+fQcg40QG
         oU1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+nDnUzwQDFXFq37LBdQDI/7BUp+XFRSMtda0vQky5ISWNhnn7SpnSa3ZpXIM70HSMVQy9vwkU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ODm4V84VtfA8FlmYjtpVfu9USi7zrQ5uEC6BFXfU4XcnEnKP
	xlisnUqPXUywEXslv2G4n2AeY77FRo6IBsiPLiInznVPj7HEN9sUXblF4cFROsTEfuJkVOyN/5k
	kNTtnLQkQ8Q==
X-Gm-Gg: AeBDieuhKfZpXwEoGLYJvmA5Lmxeke4B5R4IY2WnTedbxVUE0ub81XI1k2hvxUhPLIl
	0WoHgqV8+TykXA6s7Rf8RKfBxByRJioM83ass1Zf2nxqPDV8jiz5LceIcITnwytHPvN4vQz2fNt
	IOGJH8kJt7KRMR6kxHkvkv2yKwNC8rR/RBhWGpFD3mb37oSAcRutcDvmAgvlYX6mMYiKTOOUma6
	u0xUXH13YxR7bvv6/uxu5VbYQ+EUsYH/BqwTB9euIsvBSBsM+GOPnchbOhkjHQaPGlrSlFAa2rH
	pEoQvaIEPouUMs6ro/Wu/XqMPQd6+fTB8HIJ0NZOhawKs4VeKDDSqF22Syu3vubEHWkSodGznrK
	y92rkJr/7PGqFh2lxx9eFSqI7oL7uka3qNu0VARJNL11AXUInPU6TP3WqrNDF7yXz4bdHBsFoqJ
	Z0/pg93iQwQEQzfPZpSIH3mQaAHX5Y7aiA8iyHlEYNXawbFh2zreFTS+wUMK4IWGYpbj3hCmSBt
	hcE/HbTiaayTlaocIbO
X-Received: by 2002:a05:6830:4992:b0:7dc:e45a:adda with SMTP id 46e09a7af769-7e1df0bae0bmr6007868a34.19.1778194017680;
        Thu, 07 May 2026 15:46:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d9d788sm6924a34.24.2026.05.07.15.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 15:46:57 -0700 (PDT)
Message-ID: <12c809f5-1326-4cd3-9d4d-2bfb011b23e4@kernel.dk>
Date: Thu, 7 May 2026 16:46:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0.y,6.18.y 0/2] Backport io_uring commit to affected
From: Jens Axboe <axboe@kernel.dk>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
References: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
 <5fed66f0-ea72-4f36-bf50-2d7c39c4fdeb@kernel.dk>
Content-Language: en-US
In-Reply-To: <5fed66f0-ea72-4f36-bf50-2d7c39c4fdeb@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A5F14EFE34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244648-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernel.dk:mid]
X-Rspamd-Action: no action

On 5/7/26 4:41 PM, Jens Axboe wrote:
> On 5/7/26 6:42 AM, Harshit Mogalapalli wrote:
>> Hi Jens and stable maintainers,
>>
>> The intent of this series is to backport commit: 770594e78c39
>> ("io_uring/zcrx: warn on freelist violations") to 6.18.y and 7.0.y.
>>
>> This above commit likely is fixing commit: 34a3e60821ab ("io_uring/zcrx:
>> implement zerocopy receive pp memory provider") in 6.18.y and 7.0.y.
>>
>> Pulled in a prerequisite to cleanly apply the fix. Only build tested.
> 
> I don't think these are actually required, but at the same time it does
> not hurt to add them. I'll leave that to Pavel to decide.
> 
> In any case, thanks for doing the backports!

Adding Pavel, I had assumed he was already on the email, as he's the
maintainer for that file.

-- 
Jens Axboe


