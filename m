Return-Path: <stable+bounces-222736-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBQJEuMTpmnlJgAAu9opvQ
	(envelope-from <stable+bounces-222736-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:49:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CABB1E5EA8
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 23:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32E4C304A12D
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935002D7D2E;
	Mon,  2 Mar 2026 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+Cgq56G"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF9F282F1F
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489862; cv=none; b=ql4h5xa5pdOjQwacw3TVkkjhT7o9R+J/7XnWu6BhNUWV42Y/WlMlSu+zdR9pXDPw8ypdB3YoFVGwg9JRZPFqOEQMjuPiJkim2/VVBrLTweha19B6LKFUewR7JDgJPrcy3+q9x437xbveAZ5J2JsTFZr9uvKXhdtwVfpg8//5EG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489862; c=relaxed/simple;
	bh=e5cz2bIVLbsU+cAPQA9qjkP/tzkHzHpAi6s7NlZ4zYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSbW12s4BQVTlrIS/J/5+YboJjqKc/jpRdHNoaKA1UjiJpVrba5E7AF8kDOtRSqVyEF0sUkRuqJcGXxGut7BCEGUYg45fozQ9Z5cAm+6MYK7ZdbbyMijulcOd5FR7YRyXBzZg4/BLj5VNdbT1Xb9TWOPTBVn8Wvgi5opGZ9TVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+Cgq56G; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439ac15f35fso2205481f8f.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 14:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772489860; x=1773094660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20ZBvw+8A17JrzKBL3m55KShBJ8EWIYwmxPjaH7SOVY=;
        b=g+Cgq56GKNXjRgcpH+R3pudFJZol/HdQb7EjXM+tstBiGT18Pp6c41cSgku7oDllCz
         +Ld+BcEgylUkgHnVSlg1JYMtF71szWuapD1ierRfTTHCUgemsd2jTkF9ije+d0NC0AfB
         O3a0MnOmaC8sDt+/Bh3nlTT2vKVAhTB/5ptTLhHjAWiGPF9vFiok3QUJkjbPZHCx598N
         h4JfOC1LCsISTtOyBUT/cly2k/WdnZs/Bqp+v52qjHlFAZj+lCseSkBQR1E502MWw2UM
         NP0jnIkchYlt5PoXAV5mFlkjeGPq+10Z3cRxQuE/tiYkeYtV/ux5aIR5Kp0LA9OyhG2o
         7Rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772489860; x=1773094660;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20ZBvw+8A17JrzKBL3m55KShBJ8EWIYwmxPjaH7SOVY=;
        b=ckZtPtchVTf7C2+WlAjvKE5MCtgQnFQvD+RtG0EwIAwUFxOJtcQDlIreEJngUS3Ttv
         r4LBXFahZUmB+wxiQpo6J9jHadtPpzl2EzHLuspx/dRfsUAl3Asl6CdjFVhvAIhf5/rs
         tqllN7u49uTCIvt+v4a0eABWcwPRpT/BsUOYGFO3PrdKtrNFJABVA25ydEsJMRNzrbUw
         HRVPA0Fz+g9SS8fuY9ticnNL5T37OVWr0DOsaiVzH18u6zO6TK3qnqWAMH0fuJlu43CS
         MA5joI3lxFy1Cn19KnexBKSAJslYV7wZY9zLZKbRTK5Nb+d/+qucg9twUnZH0/50q9Fs
         GRRw==
X-Forwarded-Encrypted: i=1; AJvYcCWflhWJX17VW2rC4X0puRCjQjwp3Ml2iOxdIBBm0e1WglPmdHScrALWjFUQaQH4YE1puflFOoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5nT75m4M0VXjRc4O35m0OLYC/SvJnVKnWlIqxgCvVcAri2dpo
	rJsatBvDADy26xxlsXQMt1l3pKn1PE2smn286unkDSScko2Ss+kzRBJbobrMnw==
X-Gm-Gg: ATEYQzzONvKsQ4RqPTMBW4na6Jye1zGQY5u7dTBBJo3qx5CVoxnmpiuypAV/lhp31nc
	suFTkd83+nX971sb4HaOrP1kjz1aer1+EyJIR7viNgqhPx+E0JL2CWdYiuc/wc8WH2oS0ZUwGLE
	SGHRMCGBaI02wpw9cjPnzSwNmrzS514ho3hUUi6E8+6+aSPMhHXMacOXkk8mtlFXclx+Rxs33I+
	5TbJ6wEMDrKHGmVknieGMgnICeUSOoRDQj/i1Y44l+Fhhc7+uVzmY3a2lrTpCCLxakacAofq9E8
	qkQnhvRN1azuCtnA3zTAq3tDvMiaIFMs3CIvhLAYu3JO/C66eyTgQwrhVOlQcbZAiC2SL4rBnW2
	atHdwXqpxOUwApW9cFxS3YssjnYrfRgZ0VMFFtGLqHottSnoSA+34vQqcZ/1QNSzOq0HkXEKvvM
	hOKE7b6yKnLf/CJPyPhqNDaR8PJqQtSUIvHxcTSLMwi3hvyvlAxHCd6gduZj5BGC0QoQ4uGDteZ
	/p5tPkbh05/DOd1gghiarauk4zJ3D7wWA3+PZZGYN0BZmnxWyVRCZ9/7hkBjMzqWz5cAM1UKJYx
	8g==
X-Received: by 2002:a05:6000:3106:b0:439:8f32:8674 with SMTP id ffacd0b85a97d-4399de3e2b8mr25504482f8f.53.1772489859516;
        Mon, 02 Mar 2026 14:17:39 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439ac9f3e5bsm21544589f8f.37.2026.03.02.14.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 14:17:39 -0800 (PST)
Message-ID: <0350d0fd-3037-4c04-b9ae-31bdb1913ada@gmail.com>
Date: Mon, 2 Mar 2026 22:17:35 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] io_uring/zcrx: fix post open error handling
To: io-uring@vger.kernel.org
Cc: axboe@kernel.dk, netdev@vger.kernel.org, stable@vger.kernel.org,
 Sasha Levin <sashal@kernel.org>
References: <ae4f2296e2c33bb65ef2a1487b120033879e493f.1772489730.git.asml.silence@gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ae4f2296e2c33bb65ef2a1487b120033879e493f.1772489730.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4CABB1E5EA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222736-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/2/26 22:15, Pavel Begunkov wrote:
> [ upstream commit 5d540e4508950c674d6feef1d95463d039bbf4f5 ]
> 
> 5d540e4508950 ("io_uring/zcrx: fix post open error handling") fixes some
> post queue open problems. Instead of picking all dependencies for that
> patch just move post open error handling out of the way, so once a queue
> is open we can always report a success.
> 
> Move copy_to_user earlier before open,  and xa_store() should already
> never fail as the slot is explicitly pre-allocated.

I somehow lost a stable-6.18 label in the process

-- 
Pavel Begunkov


