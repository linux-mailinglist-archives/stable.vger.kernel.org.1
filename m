Return-Path: <stable+bounces-242541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP5GMGwp9WmkJAIAu9opvQ
	(envelope-from <stable+bounces-242541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:30:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6394B0070
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 00:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F132301BF60
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 22:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D2F37B019;
	Fri,  1 May 2026 22:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vM1IBnDL"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873D37B012
	for <stable@vger.kernel.org>; Fri,  1 May 2026 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777674600; cv=none; b=BZCCUZ7DJ2TeZF8OawtOKQR/ysIq7EaAtMRqO7Mi1dLObi7eH6ys0tqi3y2RXanPtwJeGf5axq74kVCUVL6iOaLF6Q7Frk+kisj0SAdkqumtA4QfYNF7Zos0JD4bDeELMW7ipZcPebUVtGcXrgEdWjTxo0RNPWImAF7QgS2s8S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777674600; c=relaxed/simple;
	bh=Z3j5m16RyC3CmIGajJ+/IS7X3Sf+kvHFHVY1AUGZqKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l71oGscGfqOBHrluDqqT4QIFst1I4+MPeyUEGhOW34zzh2zrZGKtit1cS3/xAKgF18bh+ktknR1053aHWuv2CwBhvefFc4iJFo1799GROtEALDwt1B870Q+Ukt75HrQ29P4/NESTwsfpjdNpzzpkpJuSjt9+pXP0Z09CuDHbJ2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vM1IBnDL; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4670464029eso1300131b6e.2
        for <stable@vger.kernel.org>; Fri, 01 May 2026 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777674597; x=1778279397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8v4XgkEv5i+0WUPhCFMBoQrOJeR7PhB+65tYSb0JbY8=;
        b=vM1IBnDLn825qjDyEmKHN/aKOX+qIm8n5Z6NhM4VNrbVKqJKtgeN0Iv56sa+aveM3J
         GqIDY27sOCzrvgzEAcRq4ighpOZME1RNxQ/QXru0EJIB/LJo1bPY+JeIMbObsIPMvNsv
         1DMS+jLr5xunn6W9iRbYWy6bcZWvf9+6V8cBlviFd4MrV1p3a73BLTpcs1kEQ9GYP/Ya
         IrYf+E6hSPemYHgUF/4kpuZmx0BUzLTDSmNmNcC7aZDmaVBut4RcWV1N+6rNehRcE2M6
         uB+RU+pqU0KoxRWv+c7IblJnZ2SEzwYZqC5qzWYrIgi+wwQHnqwFG3ognMFJvyJbI0xh
         2fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777674597; x=1778279397;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8v4XgkEv5i+0WUPhCFMBoQrOJeR7PhB+65tYSb0JbY8=;
        b=B4OvOizQNx5JLcZxMYTsf3XQZyiVt7RWjHmwZ1F2VLL09cX6GYtwei1jf2+aeXZhf8
         47oizgSehc0LVLvboiFVPH+IBAqv8Isy3JXtOu4wsTiHoNplCUPWNmiUlOhBFJ5xsrHz
         EbAufXknXefwxJxx48zO8aCPcmxHp1RhFsiRNvIfRJOE3kuVb9dW8EUGbZdbkGArcbGU
         qKDHgKO1Ffoucp+H/xnsioSinF+kQlS5xZUWY33NViPYSRVV9mNd/OehE6UY9ZyAJ5xv
         6uVuTpwaXSR5uSCe5UzRiL0LJZiuaqtjle8jdSYCDzk+xXInRCMAkv0pR2aXRKtdZumX
         Bmig==
X-Forwarded-Encrypted: i=1; AFNElJ+BRl1+e2KV3gvOTs2SqNWnEQ44GwMJU+tOfe18VkMCJIp5woUbI0JuWk+fN5NA1D6FRv4pYFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCW9LdTYGoHu3/bbqGy5jMT0dl+YK42oVCCpAhT6bl6KS9TjM
	1TsUir7jqrKCMQU1EWSK9KYSLz59XPpbyeN3y+9CjtezS8XrZq3dPzrjSd8kOZsFs9U=
X-Gm-Gg: AeBDiet12XvCetR7u4P1oRJHzI2DsXWXgcWuOa4WcS/ORcI5BE9rJjoJW6kQ7gq/Nuh
	G9C2IS8KIG4kPob61EDuAn49ZSErtet/oZFV2uYlluJLlopp+YAddBJ7KbKgaUZ7q33kJz1Ffhp
	Nw2CLlV+7fDBA0ncm0WleF50AwkGS9gi0aeaPEwCUqhioBCeWD6Gpd4kjwZ3UMJvK1BJ3Ta7eHr
	/q7ubwRlf9r83NcfrSrDQNQCDb9jS1oYYMgJPllrLGOJLg4IZ5zxaJ/u84Poj6cMOuYQZxNoRou
	IIjluaJL79xU3TnosPUgAI171JTPAT8a3VGusWupOcjrEM8j1bf5JuKt1mJH9c/EYdt0oV8QAiV
	CnWqTFagu7wwWE0WyPWlxgT+BPlK+MKVvlmaKetKnPmd9kn9ooUfsjEJKjIRKp8GueP/09SxvI0
	nifSH+XfzoNUJw1YWMihP/n63sVBnI9NjUMNiQElQUp+ryrNHdwZUtHjpvelhFXpFXUFmlLULEE
	SLQ9ByvsWzYJ6sYeu4h
X-Received: by 2002:a05:6808:2e4f:b0:479:fca7:4663 with SMTP id 5614622812f47-47c88fb014bmr860868b6e.9.1777674597608;
        Fri, 01 May 2026 15:29:57 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76935904sm2049268b6e.11.2026.05.01.15.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 15:29:56 -0700 (PDT)
Message-ID: <5794c5cd-ff76-428a-830b-6aaff9d36089@kernel.dk>
Date: Fri, 1 May 2026 16:29:54 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 491/491] io_uring/poll: correctly handle
 io_poll_add() return value on update
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Ben Hutchings <ben@decadent.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev,
 syzbot+641eec6b7af1f62f2b99@syzkaller.appspotmail.com,
 lvc-project@linuxtesting.org
References: <20260501111233-b371eac52cd006bfddfbd9e5-pchelkin@ispras>
 <58103791-4c19-441c-9d4f-7ae5f9c6151a@kernel.dk>
 <20260502003658-e04f382bc8ed201a99b573e0-pchelkin@ispras>
 <20260502005417-671675fb5906578c85c3fb4f-pchelkin@ispras>
 <fb26a75a-cb2c-4ee6-92b9-4c488a2c7ba5@kernel.dk>
 <20260502011444-849ff2d3f8fe48b07f48d496-pchelkin@ispras>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260502011444-849ff2d3f8fe48b07f48d496-pchelkin@ispras>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1D6394B0070
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	TAGGED_FROM(0.00)[bounces-242541-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,641eec6b7af1f62f2b99];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]

On 5/1/26 4:26 PM, Fedor Pchelkin wrote:
>> @@ -6188,7 +6184,7 @@ static int io_poll_update(struct io_kiocb *req, unsigned int issue_flags)
>>  		preq->result = ret2;
>>  
>>  	}
>> -	if (preq->result < 0)
>> +	if (ret2 < 0)
>>  		req_set_fail(preq);
>>  	io_req_complete(preq, preq->result);
>>  out:
> 
> I'm really uncomfortable to raise this but - ret2 should be initialized in
> beginning of the function io_poll_update().

It's your second version... I'll send out a new set.

-- 
Jens Axboe

