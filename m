Return-Path: <stable+bounces-224702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOxbKKiGsWmjCwAAu9opvQ
	(envelope-from <stable+bounces-224702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:13:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E36B2662F5
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A91F3025E31
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 15:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C43E0229;
	Wed, 11 Mar 2026 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wQcj484q"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825573DCD97
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241982; cv=none; b=B8ybkma6ShhntASnWu26iRocrNj9LC//MpdaLtFEmrrgLIuLAj/sJcGH58hreVMZHV4WfZ0QbCJMT2GsQYtvN6kqT1A+ng2IgOZ37vYDUHa4bX2Qz9FYbI8NWMCzJ3piz7cpxvNuJJCIwKSAXNvwLNcrDkCIxcupQKJozF1Va6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241982; c=relaxed/simple;
	bh=5DuFyHHqEMjIoFGEOiSxVJ/igeUI7XA532Umf+smAG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+i1CFBCCLz4OjIjWA9lakhJ51RHxjKNDOcCSy2h+kRGVuDOZ6HftXWa6DuLS/YAmIGHJx9cU5bUjSWO5QdLblS1d+qmS8EzKfV9OpiuN3Fij8URapVALuMpBqI7PglqwWpFxcqeEr+3ikPX1DU9TQ6nMTSxSbofRq/Dzy06A4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wQcj484q; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4671cbce2feso921771b6e.3
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1773241978; x=1773846778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StVXwXUiwmDhCD4t1rrg/FzYEdaFBzAlLdNdaIIhxwE=;
        b=wQcj484q3MdoF38hyzp4bV56fOsZ/IMIXIyrpw1z1mRuaNQn/pymLSERxo1TT2C5z2
         C21APQVfLIOCCO5ucTgkdHrdxxJJ0Y4xTx8tHbEmXdebzYGyxVugvB9RcAaYxPccCBk8
         ybTS1wgNBb1832+jRTs8P/vuxagNHWd/eofM7klpz8CGQzNNE+aT+nMH8eMLW3ZC1DO8
         KqrYp5lX43ZzJ17xwX7/sogGHd9n+/7t5zO1nXRju2poEv38PMtEzZug9BuaVoYc3Nb/
         V5fZb9SYr5Danf93HlEjHZskBNkQEntduSFjlyzgAb4zHNU1Y2oEgdgwziMJlvw0fCVP
         lwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773241978; x=1773846778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StVXwXUiwmDhCD4t1rrg/FzYEdaFBzAlLdNdaIIhxwE=;
        b=mwN2u1/Yi7hzokZcbfZTJ6FE2MuLQH/dOxNAiTRKdlrW2mrozGkv1h5dvKcK3euyCc
         RV5Artd7bSNBrKwQ+2rH8G35+DIIGO/G/o6SMpr+dYdjWtBOEdBj3j03acPswdmthC3m
         bq4ZkCADt5bb1HS/cUafAvdjnHUViw61r3MnNm9ZmxV7HaT7Wn6imujOzbb6ZD4rrdfL
         B1YDj8/V5LliSpGeLo7LUNKmfpZa5YNJXhU3c1oLBzxnOG5vl2Wm66Vsr5qspcZo6jVJ
         XmiEWGw/DgynQ9nBnC7jTbLoT1VWnHavQuBGDQ09eydy37I2r7vJoYCBO3/sAnNklNfL
         TUBA==
X-Forwarded-Encrypted: i=1; AJvYcCWeRVGqT2O+uyXfTFBR75wvZxu5Pa26Nec8TrdVnUlaubSgsZ1klHVABIv+irfuGXqnnT6DxKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyer6tqIj3BsJdB5kD7gYyUBqrXbFOFSCw5B5Z6cAtcAnCV7yTO
	X9U93meQgpPhiV1mQcZYNp9HaX5/OaNfGD0zH6GmbY5x4ZwtmqVsrt5QTvD73ipwRbE=
X-Gm-Gg: ATEYQzw8+/nsXAsfTo8C14q5vBm+Suq1wU6Wmv4O5TtL3yGXA3zu2V+wMKA+o43/QPX
	lh01G8f5Kd89XzevTQCblo9CY5lE6kC7LSN/AawdsTNzIS507tP+3/4si3H9JTHRGVoklfhfdl8
	boekCmWhksX+a0xgSip1JJv386Dy3TlerG+7rbRub2MTliGQsAQ7EgFEweRKPSajQ7PepMPIqSG
	NWAM0XYcxg8AgixIsP/HP3vaHdQDXbHiFQtG9Q+RjPmjn/dtbhD4riaH9qvq6npMpzsm83EgFqM
	twv6Acjwa5lHTvz/3Y4Wn50rSWDOWVf9Rglw9Ppqndftvy6+s2qZdtFFKTimpRfobuXTlrHL9Nr
	ZVD+utawB3FZ2jsnw0guzLG1a3CXrWjNg1EHp8NC+2xKShIqs3BjFdbGYRyEmPQmokLxaFqnPrk
	MH9U/F0/sziC30jHeVlX9h0SPB85ad7L2bTC5s9yM3K1CgCLzk6KFyr3DxrB2Au1ZBy4i22piWb
	g3dlQfpdg==
X-Received: by 2002:a05:6808:17a8:b0:467:697:7bc0 with SMTP id 5614622812f47-46733603692mr1435825b6e.61.1773241978095;
        Wed, 11 Mar 2026 08:12:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6c7885sm2267891fac.17.2026.03.11.08.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 08:12:57 -0700 (PDT)
Message-ID: <002add9f-6cde-4263-92b5-dd74f04f8b10@kernel.dk>
Date: Wed, 11 Mar 2026 09:12:56 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] io_uring: ensure ctx->rings is stable for task work
 flags manipulation
To: Keith Busch <kbusch@kernel.org>
Cc: io-uring@vger.kernel.org, asml.silence@gmail.com, naup96721@gmail.com,
 stable@vger.kernel.org
References: <20260311131336.197028-1-axboe@kernel.dk>
 <20260311131336.197028-2-axboe@kernel.dk> <abGE_CLo4vW_-Tkh@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <abGE_CLo4vW_-Tkh@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224702-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,kernel-dk.20230601.gappssmtp.com:dkim,kernel.dk:mid]
X-Rspamd-Queue-Id: 4E36B2662F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/11/26 9:06 AM, Keith Busch wrote:
> On Wed, Mar 11, 2026 at 07:11:55AM -0600, Jens Axboe wrote:
>> +/*
>> + * Sets IORING_SQ_TASKRUN in the sq_flags shared with userspace, using the
>> + * RCU protected rings pointer to be safe against concurrent ring resizing.
>> + * Must be called inside an RCU read-side critical section.
> 
> You can make the rcu requirement explicit in the code with:
> 
> 	ASSERT(rcu_read_lock_held());
> 
> And debug kernels will catch misuse, too.

We have lockdep_assert_in_rcu_read_lock(), that should do it. Did ponder
that, and then I could also kill the comment as it's self documenting
by that point.

-- 
Jens Axboe


