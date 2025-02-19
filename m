Return-Path: <stable+bounces-118249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38852A3BDD3
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 13:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E149E3A7E45
	for <lists+stable@lfdr.de>; Wed, 19 Feb 2025 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2A11CF5E2;
	Wed, 19 Feb 2025 12:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7MrmYvl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4FF1BEF75
	for <stable@vger.kernel.org>; Wed, 19 Feb 2025 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967170; cv=none; b=kySTpnhBoKv499et8DwwiqRUfeKQTlqmzcFeWBsbCLY0uq/T04jfGJbKYooETlANE66/g+tD67uw40iwT3lBMBeL7Z6zteWumHlqH8LEjb++tUexbs6Y5Ff0+dfDYuntAtIwtKJr98AQLApBmXEeBYyEkXQpoMWk8RI6GF9d4CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967170; c=relaxed/simple;
	bh=ZV1Mu/4JnGjawx649b6S+Kvo/ot2A1voDsH6TNAZNqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZi+M8t5FLKubVQx4Ofdx7fJgExhsnaCizZNwoeHK/dE/q9RlXGOzrJjV36S3UB61hg30rKYHwsHRJ7DE0ISxSmMHrFbMAhh83ugoQz3U2NLWBiQDQj7XwG3QeRVNCX1nXx3rrNmYymjsV7VyYMeOeFNOp4boHWdTqO/8/9/WDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7MrmYvl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so7314261f8f.0
        for <stable@vger.kernel.org>; Wed, 19 Feb 2025 04:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739967167; x=1740571967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aRap/+wtbzBBvj/Oq3kcOcN0gvl/NE+wgoVj4vRH6cQ=;
        b=Z7MrmYvliznJNMoJSMvpBbGUlfqOhLaT5/jiqh80r6CwNxJYFf7bV0A+0+DWXU6IHu
         Zf/I3hSrfaYyGHR/AFlhGVBEByILkRX9fL/EaHrDy4g5zDSq3r9R6I5L+ewiXjwl+b6h
         EJpgiX3eLFwkkyVaMiznZlBYac4PTwCmZQsbEBps7/+p11qbj7E5ecWJCvDxgg1driUh
         GYbHDLlgcbBTX8CsFlCVwC/0HZ0xMpJIqlgiKCg7GYJkcGq6MG+qIZ7RgEf5xRwypktX
         ZFYjc7f+3lOy70S0Ls0ibKswbKkkqRZWgPOt5TKlFOY/ppqcuW642r/dbbJIOV7NRa8z
         eqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739967167; x=1740571967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aRap/+wtbzBBvj/Oq3kcOcN0gvl/NE+wgoVj4vRH6cQ=;
        b=MAx1nQvaI11LyNPOoPrvC4WY7vZZAnZVUW55Y5j5bcSkf0Y5ht/SFGaBQffrGeC0EQ
         bs4JLH7tX0rTravMPDyedPUQs+IGakAoSb4u/P4ka3HuudeThKOCndPq4v5yWDBJpfKQ
         FHDluEWnKAvFH3s0TQjGgGPdi4hkYSHxqHucSK/arMRs87RldVVNQ2bs8RDll1zDWtJ3
         DhLqeUW4xXyE9tVcumwpHIRQTrcmA1GhxajI+LW7xM541IyC4sZyGG8I1crnOX8k8tZm
         Y5GDQfmKMnrXe0IY+s/iObmC5OKFFHxPd2LtKdUSKsMEU7UnS0eG3fX68SNpnG5AeViZ
         6+cQ==
X-Gm-Message-State: AOJu0Yzzyxa14NrS01d0nYyc5xtASaGdA5GMTqNy44AjRU7trtBxBvLk
	Et3fKj8fOW20PoQTbMLRfrw3J6vl8El7+iyCCnCibC3JmGDrsSytEdR1/A==
X-Gm-Gg: ASbGncsN6mmKNYz3RbTQETIbue1tvGdaGH7qp/tud9GZnwizVpMOiYHZoENv8c0naBD
	+xwGyRLHf+2kaxQfSic+aUqKT7YUD28BCEmce3qj4LaNpBWH9k63u6kkUw1ofEY4NU8yWM+0SV0
	QtChelX3usQO09I8M5pr8rJ1o7x0sg7DLFfebb+9VP4ACUiXYXlZtZEGyRNEkXTOyScpriySDie
	on0zZ0bFsX+Ul10q8N42zgPGpB59JXYqGxeuC+a59bkcGBDabrBmGanQ9TXSW9W+/LVg7G6EBig
	YYElX/shTNJ9cDi+DQs7l5L6l4w8p12OWpXf1+k++Ug5PGVe
X-Google-Smtp-Source: AGHT+IEVv+E502vjz4E5BYTvtvhk71Tt1E9fxL4bryO5XBjYLGaeTgcIHGTSGBITpwIYG15h3Ak9nA==
X-Received: by 2002:a05:6000:1f87:b0:38d:d8fb:e91a with SMTP id ffacd0b85a97d-38f33f35862mr17858406f8f.27.1739967167008;
        Wed, 19 Feb 2025 04:12:47 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:cfff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53232282sm1270067266b.12.2025.02.19.04.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 04:12:46 -0800 (PST)
Message-ID: <f2f9e3ba-07fd-4fb0-ad05-893ef41a1a3f@gmail.com>
Date: Wed, 19 Feb 2025 12:13:52 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y 6.13.y] io_uring/kbuf: reallocate buf lists on
 upgrade
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Pumpkin Chang <pumpkin@devco.re>
References: <2025021855-snugly-hacked-a8fa@gregkh>
 <df02f3ce337d92947f14bdd4617b769265098e29.1739926925.git.asml.silence@gmail.com>
 <de75fce7-a3ba-4bf9-bd06-c5713eb84fcb@gmail.com>
 <2025021941-getaway-polish-00a9@gregkh>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <2025021941-getaway-polish-00a9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/25 05:53, Greg KH wrote:
> On Wed, Feb 19, 2025 at 01:30:04AM +0000, Pavel Begunkov wrote:
>> On 2/19/25 01:28, Pavel Begunkov wrote:
>>> [ upstream commit 8802766324e1f5d414a81ac43365c20142e85603 ]
>>>
>>> IORING_REGISTER_PBUF_RING can reuse an old struct io_buffer_list if it
>>> was created for legacy selected buffer and has been emptied. It violates
>>> the requirement that most of the field should stay stable after publish.
>>> Always reallocate it instead.
>>
>> Just a note that it should apply to 6.13 and 6.12, can you
>> pick it for both of them?
> 
> Now done, thanks!

Great, thanks

-- 
Pavel Begunkov


