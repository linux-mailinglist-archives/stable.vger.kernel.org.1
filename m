Return-Path: <stable+bounces-222832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO/RJLyipmmvSAAAu9opvQ
	(envelope-from <stable+bounces-222832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:58:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CB31EB596
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 854E13016AEB
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD2382F04;
	Tue,  3 Mar 2026 08:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrcXgZWq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF8231C91
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772528308; cv=none; b=ZMOCJZJHlBaftMLKpsQEGxVpr8iYJwcI8hjxDuY9zH+Mp+qxCTxQQK8LJOwKyFw5dFSAws9LF1tLpzTnQMlaXfUkXlsLW55jJq+j8h5aLxThbR+4wJbPCUqjZlSba5VPDrTzzTSqGACgGcxVe3p1Q3+LBtF0hmWtQRI6ffqyPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772528308; c=relaxed/simple;
	bh=1WVbFhutD27rrb03/52SLt7Lb/PY8lkcXPFWCUYrHz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z/luhpShi6EbLMRbTsAy5MdqIMaYO9hYiwjpcNr6uOQjBiQUrSmnhWD4y/DGuCTv+bSt3sm/ToifTbgXEmKXSNMGpuTTfhFVBSzqhMQFBEzTF4v7EswazvtG1CkbzgrlMJaUYosne+k5gkWjCc2uGGcHZqJff0FXzYQ57Y1Vwh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrcXgZWq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so61762175e9.2
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 00:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772528305; x=1773133105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wa1rSUI3Fn0xYaTgce3G21N32tpHZUVjSkWm6M/ojnM=;
        b=SrcXgZWq7hfRzNF+ke81E4uqBAPXVQbjdFFgH628AO5NckUP/6yMGdTvtR3rIFKNbQ
         /JYV/PYVaucTHOfVSWCsNd4PWCe1eF4Eu1+y7XagAjDF0hVtOrIdglNlS8QbDcBg1ZEl
         JdAZWcWsp+N++zY5d5GnAU6JoNeHBjZFQuaAcM+goBPGjWesit50L81QgUzgWoKUBisl
         UxDPU6ujSa7Nus8VS/+cwmHTkdNNi02OWhMN+7fIQahF/FEvpPv7zK6WZBc3Fwe6Xh1C
         saYlf0IOKx+39966/YVsx1oJTRQpfmuYs0vtXD1J7XtpDOVSDRmZf8E+PiB4ScBaSZFS
         PDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772528305; x=1773133105;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wa1rSUI3Fn0xYaTgce3G21N32tpHZUVjSkWm6M/ojnM=;
        b=waylHRCc6gTIFJFwh7W1wchodGNGd+JbKVtWwBKWCX2+vNqzxyd1n9UZrS6MXF9CgF
         A7CkiXqUfWMwDh+tmpn+XJg1Fhq5x1Hj4u2nugZ7y57hcqCVlMBGMg4QPhvAioLLnYuy
         stiHlpj8Ak+Rpcq9DvMaR1fO1SwL8S1A7T7kdrw9Tj/CmkWaIQRMEh/XATainfcYniYw
         uRYkQxI+mTZEBeRmE4TTWoDpLiAuJ4iRwlyzywFu/9Ak4usDsyVy4SWnTWcJ05kTL6C5
         VFsJQ2h0q3NShekWy56DTwOhDm4NgVC/L+0AtKTHnxOvCjUQGx68x1WqsERFnLPSFJy6
         vVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0zVpj16mB9XZRGteWx3So8Ot1q8+Ot9Qln9pN+OR2L3uqlwIpQO2qCD9T6Tf1HITI7pPY7VY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTn9eZXnysvP0pvFk5Kkk33AS8/RF1QP3y75zTSDcjRcvAYM1m
	XauBvRd4wXOppMW4XaSUwdJd4anjYl8f6kDB/VqUzFXc+tzOunhiZdqZ
X-Gm-Gg: ATEYQzyctsy9M9y6OXFs1zqQgXV42tCcx0ib8RkW7YNazP1IBJBYDzn1b5ZjJUMKhm+
	jSIBMVi9+Tm/dj4bLeHOp8zG3p4f+8towAVtWie9DSeuc7JJlMvEvzS92VeqJP8qz1brhLYpm3Z
	lWCilm2CwW5KalQ6LFqdA9LAchMGcMnT3/zo663W5WieJQ+Gc3BTLB7NBWQVipfgUSjwURlY37J
	D341M88OegFRrnUBVrWwzj2yFd3WA7dslOwypRbLO7tYggySyqqyHQMOKZ28BJJ54GfozHP+QL3
	9cGFPBNW63Y7BXY2GOC+ZtED9cCnnpK6Pj1iYFYMtRfc95ZsJ0QDNTMCrEHHgobkE0XEx+XBNnb
	7e0GneOaRBIz1wZgrjK1CK1BuxZkzOmDe63plpaKHD7SqmduSCbcxaKwNj2qwHYpfEe8G8xrRLU
	9nK45J0Z3KmoigF0/AvYck4KIWtrh6QLVX/Y4wdhV0vkbjsdzYN+xEY/LPAveN24r6RrW/RcXIb
	tFl9D//4h02shJQSwK0c2f2u+Pc9NPvuXH6n//IYfDrX8UR/Ll8MlreMlbXq0QtT7nV5yqTmxm7
	mA==
X-Received: by 2002:a05:600c:8b12:b0:483:71f7:2794 with SMTP id 5b1f17b1804b1-483c9bbbe39mr280778065e9.15.1772528304472;
        Tue, 03 Mar 2026 00:58:24 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485135d0676sm13620685e9.29.2026.03.03.00.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 00:58:23 -0800 (PST)
Message-ID: <83689510-1ca6-4429-968c-656031cd1675@gmail.com>
Date: Tue, 3 Mar 2026 08:58:21 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring/zcrx: fix post open error handling
To: Greg KH <gregkh@linuxfoundation.org>
Cc: io-uring@vger.kernel.org, axboe@kernel.dk, netdev@vger.kernel.org,
 stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
References: <ae4f2296e2c33bb65ef2a1487b120033879e493f.1772489730.git.asml.silence@gmail.com>
 <2026030215-appetite-drastic-5894@gregkh>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <2026030215-appetite-drastic-5894@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 35CB31EB596
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222832-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/3/26 01:47, Greg KH wrote:
> On Mon, Mar 02, 2026 at 10:15:43PM +0000, Pavel Begunkov wrote:
>> [ upstream commit 5d540e4508950c674d6feef1d95463d039bbf4f5 ]
>>
>> 5d540e4508950 ("io_uring/zcrx: fix post open error handling") fixes some
>> post queue open problems. Instead of picking all dependencies for that
>> patch just move post open error handling out of the way, so once a queue
>> is open we can always report a success.
>>
>> Move copy_to_user earlier before open,  and xa_store() should already
>> never fail as the slot is explicitly pre-allocated.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>   io_uring/zcrx.c | 20 +++++++++-----------
>>   1 file changed, 9 insertions(+), 11 deletions(-)
> 
> What stable kernel(s) is this for?

6.18 please

-- 
Pavel Begunkov


