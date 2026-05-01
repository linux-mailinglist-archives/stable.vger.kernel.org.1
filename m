Return-Path: <stable+bounces-242550-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDJiFaAv9WlaJQIAu9opvQ
	(envelope-from <stable+bounces-242550-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:56:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F06224B01FE
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AD773010B88
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7345E37D120;
	Fri,  1 May 2026 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="bNiUm6zU"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB580371D0A
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777676182; cv=none; b=I7BZPNglFFdwLSBUkMDIyfyuVGiCkOF/8pbTwUqBxKkBJVOpFHq9ChIvlTdHlCNMlSkSPlFZ4z3fMGKoz1UXyVZy+NHu7mNkM4zwOa03VS2mbM184obZwAqDwJ7bOHXfqbrEsgHTvch5AOaKAHIA+vCZ1OnaeotQwWsb5xlN4ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777676182; c=relaxed/simple;
	bh=Owr5h3gzlY/Xiqy7mXJ2kR/F19ZgaYQwIpoq3SHk7jM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F16a03n3fM3kfdiBhFuOxsMEEH5BFPjIbDnkx46cLd8Aaxc1RYTHvi4+xNg5wjhvX5gTTfeWrrZd/4RfAYahyr9pVTfdjaveHt5QduhaWEYOFSIt74iPH02S64y6F/C5aAKUaxWPBz9fc7dRdBti/vffSSUAXzTdFAkzmQN0jis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=bNiUm6zU; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-40ea36b56b7so1910315fac.3
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777676180; x=1778280980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Me/g3PMG3J7omC4T2W3PlajfSg9iKUkl73mok83FKA4=;
        b=bNiUm6zUENQ9yA0NmV31fpqNXsFLqkdVPUlaSq5EUZ7KsWLD+4+OFoaQr3F3Hlo/fu
         9HCFlHDhaNuKfFKtyFv2izAvmx2SlZV09MBY1mTTyMK8upLCET++PNiUTt5eUZihsK2Y
         KOIxfrETzrZhRlw48ziAQbdIsgMT9OP0pV2CY1qv4ALnGh2DORm/h7ujuNMBvjH4bQpv
         Gm0vUH6VpZIHNYVU0quOiAO80+m4Jn71JunTC1cvM7QTG9D0O6Y2JQQOKTk/6kpBVYO5
         j2AUwrOBAMcdEQAXfQem1zLkwf2U/Fo7QRHlXzR3Xk9CyaoH3RBaap/4jWPZ24hugsNL
         G62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777676180; x=1778280980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Me/g3PMG3J7omC4T2W3PlajfSg9iKUkl73mok83FKA4=;
        b=EtvyGr+8iOyRK0fqjvdUbrbw2zLP4GrXs6Ypuq547hTHIpae73ltyYnh14HDZJ7mL5
         cl62idHhq37Gfq4m4Qz/IBWig2GWrwvlnnoSyS2l0utcq6K+q6at3t/xYPFmhEtFL5g5
         ctSdE6a1qCs3N+EC+nnADfHxQLiZh69qqgMCWU2CDx+QhyqC3zCtQo7YVk9L2qZ++vsW
         zLFy5BzAZi4iz2/sKlG/u5vg89SQJCEzou+ybdk+V48fPPjtj//aADSY9X14by+8RlwH
         16L9HQ+z+CgPbhu5S23c21l4cW4OpMRygSvlpg1tcga2Y0IgtnMThOTbwBIuCP1eKyJJ
         P0UQ==
X-Forwarded-Encrypted: i=1; AFNElJ81srTi5MDryAkVRKA9h4sqG+BQU1xB6yv8UEj9WGjBTuHIbiOFiAZsJiZP6ML9IZqHOqx3xR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaEe23n5YH9q+2rgqZZK4UnHc1/L0eiNKLZGf8qNC+F4XGTyQT
	JbmGUZTbAs2kKX5FupTHv1OUnbnCn0lr6LVfRKQxVkom+me+j532myPO0QqrUpmDz44=
X-Gm-Gg: AeBDies5bAR9BOlFdLgNSwrm8I3+MuNyo/brHFAp4L3259gk/aMfuZ8elNhePc3tfs7
	ufXgujXPIb9S27sO/lH7hQH0CsPRUXRqEvYjlDuvysh3QEjVL3pSyvLklJiovqXBJrTa+Ts2nzA
	5wt2G/1/xfYLxk0rRpZIV5jHZsp9wF/skcO3MoJ48p6ah2pkYC/8GKm56edztmoHkRqaTLmiuQv
	+vjS5WhbkmmVrNO1nguLKNmq38QHvJcEmyRNOS/JRy/is18InAk0OSeT+kXeWmnbpUsqAlAPoY5
	67pSqCmWGHnV4duZlsu6BYjo95rSt91g8KYpZST+gcRqyqXhmFOtyA8NjadegL/ptpLaiRAEzUJ
	OM8ZpyaQTm11qzEC56nB+8deYevwHlmnuDSKQgc+b0FAx6aOlNuF+YlpdLyYeXIYubyhTKTC2KU
	2yaanjAEcnZuS67HYQTzPSKnLxrC5izkcMTq3dgjr6Ac+mPhx/7KeZjbiH4zQL1dCp+2mPZntEA
	Qf4si2sELDnMoNOAPJaGyuceOSOmiQ=
X-Received: by 2002:a05:6808:1787:b0:467:2a6e:adb3 with SMTP id 5614622812f47-47c892314ddmr754162b6e.23.1777676179890;
        Fri, 01 May 2026 15:56:19 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b2ef3sm2178246b6e.2.2026.05.01.15.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 15:56:19 -0700 (PDT)
Message-ID: <3f1b30e7-d6a4-4e77-a05c-6d041f93824e@kernel.dk>
Date: Fri, 1 May 2026 16:56:18 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable] io_uring/poll: ensure EPOLL_ONESHOT is propagated
 for EPOLL_URING_WAKE
To: Kai Aizen <kai.aizen.dev@gmail.com>, stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, io-uring@vger.kernel.org
References: <20260501225250.90152-1-kai.aizen.dev@gmail.com>
 <20260501225250.90152-4-kai.aizen.dev@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260501225250.90152-4-kai.aizen.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F06224B01FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242550-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel-dk.20251104.gappssmtp.com:dkim,kernel.dk:mid,kernel.dk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 5/1/26 4:51 PM, Kai Aizen wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> [ Upstream commit 1967f0b1cafdde37aa9e08e6021c14bcc484b7a5 ]
> 
> Commit aacf2f9f382c ("io_uring: fix req->apoll_events") addressed
> synchronization issues between poll->events and req->apoll_events.
> However, a subsequent commit failed to maintain this consistency in the
> EPOLL_URING_WAKE code path.
> 
> The patch ensures that when EPOLLONESHOT is set during regular
> EPOLL_URING_WAKE handling, it's applied to both poll->events and
> req->apoll_events. This prevents a condition where "IORING_CQE_F_MORE
> is set in the previous CQE, while no more CQEs will be generated for
> this request."
> 
> Backport notes:
>   This patch applies cleanly and identically to linux-6.18.y,
>   linux-6.12.y, linux-6.6.y, and linux-6.1.y.  The io_poll_wake()
>   EPOLL_URING_WAKE branch is byte-identical to the upstream pre-patch
>   state across all four trees.

OK with me, thanks.

-- 
Jens Axboe


