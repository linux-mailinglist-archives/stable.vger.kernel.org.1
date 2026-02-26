Return-Path: <stable+bounces-219801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBoWGYE/oGmrhAQAu9opvQ
	(envelope-from <stable+bounces-219801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:41:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0E81A5D31
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 13:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BCB431550D9
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEF0337B95;
	Thu, 26 Feb 2026 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nIABarLH"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B283815F6
	for <stable@vger.kernel.org>; Thu, 26 Feb 2026 12:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772109440; cv=none; b=cYHxnupbl+rhVFxY+XiI3rrqODoBIhlDhFIDzzrzlVGSGiPBQ3VbmbTmKJZzGAPqv168UHBFBK16YRjoAKCq1P1uacO1IQUYI5QFeIXWzuGoJpYoB/KZ9Vtbp7pxuFzTgvKipSYdQE6OIrEadd6R74jSx1jYjaDJ1tHVh2PCuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772109440; c=relaxed/simple;
	bh=+1Uxs4sCFCr/De/3z06l+Ih/M148pK/yQchnDWWBtxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NEdVHo6G6fTHyaBlul2BsAbYe0SyG773R9XJX5VvVr94Tl/OwFGOrOT/5pBZ9I+NmNn5PMkEt2FXqKPeLfK+iIBf8+au8MW+oMJCsGK2Zc2xGw1SfxHW6HX9aEvrd3CerGrilcvPXc/GdSeAZEtQaLPt0B/T6aTC5anwIsHqQ6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nIABarLH; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-45f0c1f1b54so606272b6e.1
        for <stable@vger.kernel.org>; Thu, 26 Feb 2026 04:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772109438; x=1772714238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOVykxEneTCF5yLl6mpMyii6tbNiavNGxREq+wigW4Y=;
        b=nIABarLHx4dhK+3Y/PYmngIn4ALX3Wyz/QFdvYk9EvoxAPGqYQxgySL6gFHTKU22+6
         ltXTAnRAiYhzRKyuZbuiXDPyOkQ8owwe4vcKkLbKt5qayrlw5elvb9xdYwvDYWQ/8HvK
         sJVVtptkzgQNZ8bZV5oQZ9ojOV/hDwV1wYUBoY4Of88aFDetVeMfK1wJykG9WaJ4GSL0
         s+zBIwCW0A3kS1Vlz1AJh8IDGQngs6WnheOeaR1kilH0AE+vAM7VZrzhJQUWKLqF5Nnx
         KvQV7wPxZfeAhhwRG9tH9bO8DQ1xqdkU4WNXABcer0lPxc3tdNERr80OIbl7n9/lucN8
         oXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772109438; x=1772714238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZOVykxEneTCF5yLl6mpMyii6tbNiavNGxREq+wigW4Y=;
        b=EXNOdYeEEmuwA7olMiCUf2FooLn2KVWA2O6dohfXK6+RocWpJg2GLJ7BHiJcFiCzKC
         FSYMNcno4alFgIpURTBxJV3NLZovyKQ+0HypnfTkWl3RmnP7KjM0OovFs/xTZVx/XIEx
         WLJgL5vAoxxWscV3TvJFvbLhMNjSSSep65cjQqt3T+J64vL9n/T+ioV9/xC1L3QXWFPB
         7ldReQHNZzkzMB0nxI/3R582sWfALTSA2anV5hfUjUNerbWkXolQ9W5Ocvlh4QGymptL
         pNlB0sDHw/qKWv1QqLf2mosyaEERZLv2gAxWE+RgYEFHic5xCkPCs3DbtKjdEyGV+7uH
         FC1A==
X-Forwarded-Encrypted: i=1; AJvYcCX0UqQeUUONeOz/LxPSM+vAxXuN2MDRjLPuYl8DdU7ogHHheBKqfjqhDJnRX3Ly+vHPw39t78U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+EfbRH4Inm6speOVgWGUByVfck2qtuzdtiRXt+zSltoK56Aj
	EfOXWJji3DndyRJwtntlLaMAk4SR2kLHhu2qKV8iFRaCg+bOceoOYnMF/5hNklkZFeY=
X-Gm-Gg: ATEYQzxgs31MuxM0yWPY3zblTgzj5aIZveiWsdxRdwEc8NN7KuVDmz6rwr0WH5YaFeA
	jCv6VBuEARU+oDe6kICntwJja2FfPFAtccsWLQVY1F11WZCieJHX4YfMK+3j0FytLtiRMCJIDEc
	yFFN/Q5kLBdQJHAoa1JrY2OkFXWt0CaHT28zeAAZ0uX/XNX1XgdmYs//GD9k3NaqxCMT/bCIXeK
	BOZHrfOuGaPLGnG9YWuEInA5CnIKOa0nX1nsl1J7jJEZNLh/Mi3TyhdISBvXSJNRjvV1IPxA9ez
	ESr5BCglYzflRGCrIaNGLnEkkawVvIfXz0xNYmPmWYfTl2jAVDgigGhhHtvTyc4V11l7KZk6Ih8
	eLT1h9KvNi4QrgCtI37TmC6jUBd3tildlVZxNgkD58nEFpEbR8REkvFO3SFULyBdxfdQX6GnBym
	EvN2ttsCMtitxZn7UHkMtV0Hu4c89O09AGk3pL+c3wQ64gpSF98LVE2kDBsLoMp4ELqVGbcuqhU
	CQ86KadMg==
X-Received: by 2002:a05:6820:606:b0:679:953c:746e with SMTP id 006d021491bc7-679c44e34ffmr9357523eaf.41.1772109437836;
        Thu, 26 Feb 2026 04:37:17 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2bcbf22sm1424436eaf.2.2026.02.26.04.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 04:37:16 -0800 (PST)
Message-ID: <dc3079cf-15ac-416f-993c-9b81dafebeef@kernel.dk>
Date: Thu, 26 Feb 2026 05:37:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15.y] io_uring/io-wq: check IO_WQ_BIT_EXIT inside work
 run loop
To: Jianqiang kang <jianqkang@sina.cn>, gregkh@linuxfoundation.org,
 stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 asml.silence@gmail.com, io-uring@vger.kernel.org
References: <20260226062711.426301-1-jianqkang@sina.cn>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260226062711.426301-1-jianqkang@sina.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219801-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[sina.cn,linuxfoundation.org,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:mid,kernel.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA0E81A5D31
X-Rspamd-Action: no action

On 2/25/26 11:27 PM, Jianqiang kang wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> [ Upstream commit 10dc959398175736e495f71c771f8641e1ca1907 ]

This, and the one for 6.1 is fine to be applied for stable, but if you
add this one for 5.15 then please also add it for 5.10 as well. Those
two codebases are the same in terms of io_uring, and hence any io_uring/
patch applied either should also go to the other.

-- 
Jens Axboe

