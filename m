Return-Path: <stable+bounces-253945-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALzxH2C4EWpupAYAu9opvQ
	(envelope-from <stable+bounces-253945-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:23:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74C5BF56E
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15E8E301571B
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 14:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB13A63E4;
	Sat, 23 May 2026 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="x6e1YTwZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581E3A5E9C
	for <stable@vger.kernel.org>; Sat, 23 May 2026 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779546197; cv=none; b=PL03MLdYD9/ZiZsjmmFGf/AoyEPhYv1atpp2VrUgdG41oNL/kXzBixZLRiXvrIYNqzDjGy/yhGcSR3qsv4P+Z4DEWpw75DkEoFHUUHmxGsRlS7Bwbx6KVII1BSedGTb/M+m56UwI6R4oRhGZf6bC0FgYg3Ax+9l76HRa3vAV83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779546197; c=relaxed/simple;
	bh=B1SkOVQybuYZKnQkgQqnT8euq6KxNqLE/BvgDc/1ZEs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=g4YD7XTDOrlVb212zd/hmufa3xOX/CuU7vCKYASyYSuf+0+OjHQlw1rX4915+eabnOBipkDfBntfwLuctCpsP3gm1lmmKiDXpeSA2j5J+DOI5lsgroBQnVSBoCTH3ZoeOy4xe+ZbmxLi9KLfJDxe24ayC5n/d+r8DtyAGU6N/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=x6e1YTwZ; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e61f8d3cbfso221716a34.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779546195; x=1780150995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cy9jYvmsFlyJHrWwIX2opm2bPqsw1+AmzdT1aGicVEs=;
        b=x6e1YTwZZFODjvh/zrZ2CQFX0aWQVybALCwEQbDWPXNhaKRclL0l4hxbwSsPil2jLZ
         f0/J3xFVU891nMWJPA+zNeViSDXiuhg6L1kf7pC3KwxrQkWYLJhJr3gnmECtzZH50yTK
         DKyDoKnc/OCFNy3aXINw1Q1DnnVOAav86mRCAT0B65pu6zPevXlcKJHnzZC94Z/T9t2a
         MfKS16xz3EAD/tdS92aFsgQiaUTqOKlJ6jeE5Es5IrFyOfnal1rOXjOzDavKreJCEa1n
         qlCHzlUHNEfTjxwB8R12ToLGH2bQaPsYevmtJt6ZVyIm23TSOngQQmbqYLvcsk0OT9og
         R8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779546195; x=1780150995;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cy9jYvmsFlyJHrWwIX2opm2bPqsw1+AmzdT1aGicVEs=;
        b=VRcuNbV+icG0mafbPJ2+AtBJugG7JmL6rkD9Qbh4dPODeovQntTweym88xGBDM6sBJ
         euNwhzR3Bi9JdFNSJuGebjHtutqJ/pgi+xiNE9pLnx1Ua0/zJai8BtG4iCFTNZNL3naN
         s3mK9g+RAfND5yinkGqqAvw33lwDa4J7BQcFnPATwdq509zqYYDMSSufI6dnvKH7bheU
         d4wRRF8O86LKJofF0QRlyP5wNi3wCUWvShHESR3MPCY5oHFFbnPbNop/NIuPpMahSe9Q
         oz0SGnizIB7VSX4xjXQk4JTISlNOPD2433yxxOI5cP51JmuBaFf+N8Mlb3SYNjicdZhP
         +wwg==
X-Forwarded-Encrypted: i=1; AFNElJ8KAXbe1BQ2XJJU6I7mtMqLmdFPcyBqHrNJP1AV6x+lBW4ar2CPt6meZmggSm5rQx0fPhfgSNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMovx9oSksrfJx0m66vF5iO6uvZvdcLT7d9L+2WDiKrOfZDlc
	IbXgm7h1s2u+8e70j8a//YWQQOlKxfxuQOQbLrqx/Uwy27PSIh8+0VvR7Ygd4NqMuHE=
X-Gm-Gg: Acq92OGZFfOHYtEM7/vi/2BiOlaFsmp6mU7QIWbl7Bbbdc4QujeQQMcg0FxDZGtM6AD
	23wwxA4QhH9tA/HEuW/xqqqZXKPFJXhaKU8lpUgdS9oJ1caaYeoo0f+/XwYHqRtg83eJ7L+BCmf
	9dYVWLP+cJ4lV74wax3FTWMHZ+72eRneUDhSgl7Z+vlP1/x7UJA9O8iLYIl5EP/exCThiqkWH4+
	3QXsLjaQzSD9aL972NgirtUVUaB2uGIVwMLs5r8KubymAwawwqNLOuZ2I+sOQmQc/xLbUqgQXxu
	dksWDc9u0A0xRGsU+M2bl5LrSG8GpRO7YW3jg12sU97+lKKio3WT0oBPogzSbTP3K4EZBVq7HyR
	T83nl1kmam/LTjzJF050bueiQVgqpEGMztKDDCFkuWpKSEvTTjpPFVbKVyEXr+612sH3LG+wuk/
	xumZHTtOMxRPNOCm8Y57vl5rQKRHDI/Nys0MQLbU14KOoTNNXK+y0VzBqcWLf2Ix1i7yXFxDBeo
	jH/DvV/ig==
X-Received: by 2002:a05:6830:6285:b0:7df:5fc:3fd8 with SMTP id 46e09a7af769-7e5fed0ab9cmr4772009a34.1.1779546194811;
        Sat, 23 May 2026 07:23:14 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606459dadsm3299655a34.4.2026.05.23.07.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2026 07:23:14 -0700 (PDT)
Message-ID: <8e853555-604e-46e5-8e25-a5f80b88e51c@kernel.dk>
Date: Sat, 23 May 2026 08:23:13 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH AUTOSEL 7.0] io_uring/wait: honour caller's time namespace
 for IORING_ENTER_ABS_TIMER
From: Jens Axboe <axboe@kernel.dk>
To: Sasha Levin <sashal@kernel.org>, patches@lists.linux.dev,
 stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260520111944.3424570-1-sashal@kernel.org>
 <20260520111944.3424570-26-sashal@kernel.org>
 <5a50c3f5-a5ef-4b2b-821c-5858d8b1ac13@kernel.dk>
Content-Language: en-US
In-Reply-To: <5a50c3f5-a5ef-4b2b-821c-5858d8b1ac13@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,ntu.edu.sg,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253945-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1B74C5BF56E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 5:40 AM, Jens Axboe wrote:
> On 5/20/26 5:18 AM, Sasha Levin wrote:
>> From: Maoyi Xie <maoyixie.tju@gmail.com>
>>
>> [ Upstream commit 45d2b37a37ab98484693533496395c610a2cab96 ]
>>
>> io_uring_enter() with IORING_ENTER_ABS_TIMER takes an absolute
>> timespec from the caller via ext_arg->ts. It arms an ABS mode
>> hrtimer in __io_cqring_wait_schedule(). The conversion path in
>> io_uring/wait.c parses ext_arg->ts inline rather than going
>> through io_parse_user_time(). It therefore does not pick up the
>> time namespace conversion added by the previous patch.
> 
> Once again - If you auto-pick this one, please also do the other one in
> the series, 9cc6bac1bebf8310d2950d1411a91479e86d69a1. Makes no sense to
> do just one of them.

And once again, no reply. What is going on with stable these days?

-- 
Jens Axboe


