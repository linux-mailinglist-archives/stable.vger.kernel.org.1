Return-Path: <stable+bounces-180429-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1F7B814AD
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 20:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28433623582
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 18:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A482FF64B;
	Wed, 17 Sep 2025 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AcF2qaJR"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7343B2F9DA1
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132233; cv=none; b=aK4FtPWDsiyNn3LmSPgATLzjWurX0frPTTywth4Y4vPLLZ8YK7Wmr/ObtRjQ4vFUkJmqKiKUozslQApdjAnyyc60uHDi/6tv2NjAp95L8KaEuwSUK4NDyBkqhcRGlVMhjOfBVykHE+XHFhyBemoBWASa17HRcN4vFDSdfZjJxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132233; c=relaxed/simple;
	bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXgGZkQDcVnTKrGaGrF8/MH9UmRjxDeFEalE/3hcigl8xJc6GQlPSReUcdoc7+mVjCnXeUoumJd0trCLDJN8QoC5QnwxlQLbcMFp67VHfjSYP5DQgilW6Evnd2OFUFc8YT/pC7iN0d/9RtGbQTbElfNIOdqIp5t2ArobE6U88lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AcF2qaJR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78e9f48da30so881406d6.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 11:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758132230; x=1758737030; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
        b=AcF2qaJRmIFva6vSJx8CiYocTs+0gZGpFcswLaGxddDob2spa+FFOuJcZL/GqZnapT
         kC9kS/5HAMZ5ONne+4OQAFtGzVBPpVZI3CJpdiiEAlhIR0zCa04tzybroA8GxKGKLeGB
         ZNvcAjhkwNh+Fq6HFHbC9N2egX8bT9V4FEC9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132230; x=1758737030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dl8/1xbvll9SNNPORV5wD3aLW8Yo2wXdT32MfHewHgw=;
        b=v3y6vgnHp5B3QFJsjnL1RI1syr0bIFJg78S6Dvk3gHMrOFmOVwl1sJU5o1prtKUph8
         nnrvkXfAwf4GNk75qmwgECBbBeh72DxthHoaLXQ0xNlDIe8afBLplR+ND7NmNcRbwC8l
         0QJSnQWTA6Cc8yqlnOWzLqpWUuQZ2X2jwTHtOTrnjevcu4QbDZ3TXiZMxb/fJp5qLexG
         LOqBRT937MPEcnkO4YRoLYp35MZg0w99Dr0MCOUJ/LOv6JYaSppXHN9va6Lw0QL3TwxP
         n/JwupD+UrWTVExaBAqfUzRMoIiAzOllf86MCvZjdbJvncvNzMLC0iHFHXDGaqvcyZAT
         MLEA==
X-Forwarded-Encrypted: i=1; AJvYcCUqSyyxP8XSMOWQpKV4rBa5+GR0RviUvg8OqPURGMueNNpIQsFfnM/ZyF8H0SHqCQuAvGW6/sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSiIkovJiCrA/kovX3BTNVJMXO0SHUenxOI+fKMlQyv+UDyGxM
	BVj8xjK0LJcisaup6YQy+BepRXRSPqQp9WRSvr2OvoKI90+0M3c0KTwUCDKWQUvwiFSwpuSdJWe
	eJXoPRA==
X-Gm-Gg: ASbGncuv0mA0IalMXswBD/Bbj6iWUUnidBsSjY1PeovetsoNyYqZ1XXoJOyxqzzzX79
	BUzg+e2UdwMHh7X1OuS8YAS9V3SsfxqVIsbzUWgpx00bFfhMl/1MT2ccVqG/DgTpo3AEBRbMtxM
	AyLb+Lg8Z1JEYG/HRQuObmfXVfvYriIoD+2ZPJU/mnVaAxYCTqgaobp+Jtz0m3TTMSYoGH4K9iJ
	fkuyD5YclR2Dik0fPlyXKEqkM/2fio2cP+XyfDCahhfobZPxPdE87MRxMhls+9K2cOF5bLSrm/n
	MGnaF3khayukdvFe0m2jGvc2t5NBVISyYKm9IR0Zn66dOlmTFu2L+vgtIydlIFG1pZStABlxLks
	lDOI3feBzFEmdmMOSOSYXAxBo/36zkrSgd+BFZcdaZzI59xntvoa2Or5ZaL3BNhE=
X-Google-Smtp-Source: AGHT+IE0ZQzeaLfH/xsQknQz8e8AzPq1miHQsqbhfIDka59etdkJFL9Q6czDmwOv2ExMH4Jpkz82MA==
X-Received: by 2002:a05:6214:5011:b0:782:3caf:668e with SMTP id 6a1803df08f44-78ece559018mr32870926d6.40.1758132229704;
        Wed, 17 Sep 2025 11:03:49 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com. [209.85.160.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79346d05c93sm102556d6.19.2025.09.17.11.03.48
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 11:03:48 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b796ff6d45so30641cf.1
        for <stable@vger.kernel.org>; Wed, 17 Sep 2025 11:03:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8/yDohjc0GdrFAZ4NoCpK9Mxn+KVUHDol9qLh19tA1+TgUzksVL5t2zCUpk07zJYmvznCE48=@vger.kernel.org
X-Received: by 2002:ac8:7f91:0:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4b9dd3c17d4mr9004781cf.8.1758132227600; Wed, 17 Sep 2025
 11:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
 <87zfat19i7.fsf@yellow.woof> <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
 <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
In-Reply-To: <CAGudoHE=iaZp66pTBYTpgcqis25rU--wFJecJP-fq78hmPViCg@mail.gmail.com>
From: Khazhy Kumykov <khazhy@chromium.org>
Date: Wed, 17 Sep 2025 11:03:35 -0700
X-Gmail-Original-Message-ID: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
X-Gm-Features: AS18NWBTH_B8R-w_buHc5fkH54TOh_tt5uj3eXyk2xndepoDoKd89R4ajv-MBKE
Message-ID: <CACGdZYKcQmJtEVt8xoO9Gk53Rq1nmdginH4o5CmS4Kp3yVyM-Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I think the justification for the original comment is: epoll_wait
returns either when events are available, or the timeout is hit -> and
if the timeout is hit, "event is available" is undefined (or another
way: it would be incorrect to interpret a timeout being hit as "no
events available"). So one could justify this missed event that way,
but it does feel against the spirit of the API, especially since the
event may have existed for an infinite amount of time, and still be
missed.

Glancing again at this code, ep_events_available() should return true
if rdllist is not empty, is actively being modified, or if ovflist is
not EP_UNACTIVE_PTR.

One ordering thing that sticks out to me is ep_start_scan first
splices out rdllist, *then* clears ovflist (from EP_UNACTIVE_PTR ->
NULL). This creates a short condition where rdllist is empty, not
being modified, but ovflist is still EP_UNACTIVE_PTR -> which we
interpret as "no events available" - even though a local txlist may
have some events. It seems like, for this lockless check to remain
accurate, we should need to reverse the order of these two operations,
*and* ensure the order remains observable. (and for users using the
lock, there should be no observable difference with this change)

