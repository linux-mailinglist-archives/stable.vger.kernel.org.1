Return-Path: <stable+bounces-213067-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IecDKucgGl2/wIAu9opvQ
	(envelope-from <stable+bounces-213067-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 13:46:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75704CC75B
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 13:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16262303277E
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 12:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B2635CB63;
	Mon,  2 Feb 2026 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="PSAHUPqY"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D430FF37
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770036301; cv=pass; b=mwXbr/EMnSLWwdWLLzRbAA4n95mPGxu1bOv/8+pWuVEaeb+nVJeiLgNgLJSrAgJyUITN6tXbW7XqV8WyOikP1PFEM6iKEoobodfYaNAOSSggZbglRe7UE++5WHZFQWwGvh7P8NcjqQL3LzochPX02Ri9FAfsV01H7i6JOOY9vws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770036301; c=relaxed/simple;
	bh=tQSoxSnuQz8YfhPc3rcEDsrMSNKgNj6Tz1/4fwwzdP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxzA9ONkdH8Vzh9INFEfqGzfZmY9EfrDXX3E09fzwlfvG4yYUfUlcqcFTpuHU3TNfApN6b4MYRTUpOqrZbNkbXk2HhG0Wd29etUI3QmwOMxEEKmDWkJgP0VZ5ihfyvO1dYrd1Fr+An0KFzHxboQGE23wMcig6VOrj56bQABjvQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=PSAHUPqY; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-649bff225d4so945774d50.2
        for <stable@vger.kernel.org>; Mon, 02 Feb 2026 04:44:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770036298; cv=none;
        d=google.com; s=arc-20240605;
        b=jh9mnQdOOI165di+G5YPp12wtSHSZ4NddNP6ie6sjELVDpIJlZgspROGeD9iPQfxW4
         cB4rrx4J+r7yQ4Da08iZI4FqbplMGH8BFqHaT2IrEmHK+8Wz+D4AS2xe+rAzqRjGgnA0
         i+6g/94WgkrLMhWVZSIyIYFUrgyMZgSeG8KwUAeiwuQEcKfgnLbTsP85geev3sC9nMxY
         Y5u3a1HDVcda7HO8F0uRRcDEr1YAdGgiSx5/nS+vg0bn46lGqaa7PcXKBKSoTI8eHa5T
         vtIstrdq/YFD5/ypS36AtYvc9nVPiRQNTwonKgklwmBla4gpb3GzBWxMPmdaz/63y/jY
         x5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cd3ZADWHvFtHeHemiyPrlkf1w1DGp34lTmfV/FUGG0w=;
        fh=OOzAEcr9bmcEf9Zu5CJTk6SPPhFHxha6ToJvRuBFSl4=;
        b=VIKgutQVRyiKC8FjEdf95StXE90HlOne4ICjvIymuqYV+l+b25w6mqyqs8m07t3aqK
         pz4dtGFKJ8oikutrOI6qhQhNi12M9FZetNXX1BjB6QYUFKfi8vxrLL2dAISTtiF5Gou6
         mNMxuq2sV5gz4ETxsWXHbX/jD2B2WqOaWmqFS1pkUCX68eP/fIXSnE3NonPFN0ruv0j/
         gZIZ6Dk5IHOB1oFEbAXvZUv6tlvnLleLvqo9k97HsgGDWsGKJqCnnefApUsOhlSFToFJ
         GCFJneHJDfS65YnQGaVEh8A957UGdVwvOUjNPj6cNunreHDl0HPFnCUKEjpEdFMnE6Ja
         Nsow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770036298; x=1770641098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cd3ZADWHvFtHeHemiyPrlkf1w1DGp34lTmfV/FUGG0w=;
        b=PSAHUPqYbWW0JltpO2o4BKNnQjJDZ8suAdmu4epw8kQgIO5xdbgnshYJvThEznYpzc
         NIKGpxAMwb+AJXyO/aROQEurNbKzP8kYVspeZ3KaH5c1Ms5hhilNi4I/l7OgOZFeQ9MW
         e3NU+8J2GA/ihJZHgW0x9CnvCfnNlbuOVBVhwMY9p4pi/4HO9GnypjTQXXtKRaCzQWIn
         8BsLvYbsTu8E6ipCnnG22PLmD1SQ/nlLtmnWURqlydJMKMRtemoVePAscL3MfKmW+AFK
         yVPo9lXVKghxS5WTSZ2egulSKou/adjFNL1ycOtv6n6MGBdDS9pcm/hM8wWK8a6pJ9x+
         Uj4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770036298; x=1770641098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cd3ZADWHvFtHeHemiyPrlkf1w1DGp34lTmfV/FUGG0w=;
        b=YyOpZrsbKCQKGohZFRFQLMHYjngE0ih7ogRGoNOHntiYe3RzFvMpC2Xjn5pS5a2okY
         fIApPXgcWT0Awv5w6HXW5k3qMX7wwX8GpFpp6gqruZzarekIU0Hwo7/SvhN+gV6p5S7D
         sY2kisIsXSXivT0rBEqpf0CSQfY+vKD2WmNcfkYCQp2J786LYhH4Rbblw81WHz6TS4zv
         qeZLNghGF8KipulmLXAhDFjIKPgr9BgtEaRHyxDyxTGhq4c56lViLM6awJLcQPCATFkN
         gV5OEmbSJOrjUJ3WOJVduM6ebK1hLfwt0nYy9nNe7sGgkpj0qXgX5ShVbu4vxP8Amsf9
         U3ag==
X-Forwarded-Encrypted: i=1; AJvYcCUsQVcP45VJW58L/FHmwa+C48UQHxl3/2Ow0acfgkxZ5V9XQ5dD1fsXmdtQZljhXgbQQ0127Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRADd5acAVrqG0Ekg09iHnvkRORsFTN0abe18VyDT69PYiRVxN
	1SAR2ONZeCXCNNeo8OVBIZT17mNT8l1lb1grC7UwgL3XgHRjmTUEe2xL4O9IKhZWXbICTK0KLfE
	RoOCQR8JgHLHi64kvUGdeiZxN4X0S1JvAIGflhE60
X-Gm-Gg: AZuq6aJBwRbwLM5yemsxLsrSxP77IQHJHiQInItjUFQC577xwzX/ALQCjJLc2gKrCQT
	s40gA/SyAXR5QUHQd1r3ZteCQ2MVVmlpXq49Pw6CkvbHggM+tDTi198gqrSt3/A6mi2E8XJGvkD
	j6ExrBd8ac8JIUnLByobv7j1LBOsg2nxYUh5ABUmoSV+QhTKgeGtNlS4+vUCFLPUlqnTwJKCTsn
	EU5B7Xt/KSUoDMQ9kGemWL5v30wybzjoUVK/6nb4hiKrZtKHPLA4HG86rbwbY6E1rUahSRU9f+n
	4Ozi2ixRgg==
X-Received: by 2002:a05:690e:e8a:b0:649:d0ac:962a with SMTP id
 956f58d0204a3-649d0ac986bmr163583d50.46.1770036298595; Mon, 02 Feb 2026
 04:44:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-7-p@1g4.org>
 <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com> <412136f7-1d46-42ac-96f9-b6cc462204b2@mojatatu.com>
 <77q-JcImMG2fuQxj_GMUtYmaFAIuPrYMasj4I3aqIVID-Op24JIShBIPgt9kozLZgN4HvsGCS8Ez16mKq4Wq9juL1IOKydWUJwMwCYgHRMg=@1g4.org>
 <CA+NMeC-65UfJyq=34_K9tzf9J=-XFPJqDe1BxLNZv0mnjkxZEA@mail.gmail.com> <Pr4njxDDR8e9tElhovQfunuoyxlxUQdZqfdGBZg028rsKLPq4w1aYIUNKcAlF9EuqQHZjoj-9ocK2wEltjyQoRhUvsoKyZYveLK3oCAAd4k=@1g4.org>
In-Reply-To: <Pr4njxDDR8e9tElhovQfunuoyxlxUQdZqfdGBZg028rsKLPq4w1aYIUNKcAlF9EuqQHZjoj-9ocK2wEltjyQoRhUvsoKyZYveLK3oCAAd4k=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 2 Feb 2026 09:44:47 -0300
X-Gm-Features: AZwV_QgeJd9ZvG9ufUv8Hpm45B6AerrNBuED0AF7SqMRy0jxcb1zjHR0qlJx_0I
Message-ID: <CA+NMeC8HnFHgMFfx4xwwgbkyPMgkjy4jyVwJkoZReMkYGgXRWg@mail.gmail.com>
Subject: Re: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule list
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213067-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim,1g4.org:email]
X-Rspamd-Queue-Id: 75704CC75B
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 12:00=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> Ok, just to confirm the intended behavior changes compared to what is cur=
rently in the tree:
>
>   create missing entry list      FAIL (got -22, expected 0)
>   create empty entry list        FAIL (got -22, expected 0)
>   replace append entries         REPLACE append failed: expected 2 entrie=
s, got 1
>                                   FAIL (got -22, expected 0)
>
> - CREATE with missing or empty entry list now returns -EINVAL
>   Previously, CREATE could appear to succeed if cycle_time was
>   provided even with no entries, but it still left an
>   empty schedule and later called list_first_entry() at
>   net/sched/act_gate.c:552, which is unsafe. Returning -EINVAL here is th=
e
>   correct behavior fix.
>
> - REPLACE now replaces the schedule, it does not append
>   The old append behavior was an accident caused by reusing the same list=
 and
>   never clearing it. With the RCU snapshot change, a fresh schedule is bu=
ilt
>   and swapped atomically, so providing a new entry list on REPLACE replac=
es
>   the old one and avoids stale data.
>
> - REPLACE with an empty entry list keeps the old schedule

At first glance it looks ok.
However I can only be sure once you send it and I run some
tests. Just in case I am missing something.

cheers,
Victor

