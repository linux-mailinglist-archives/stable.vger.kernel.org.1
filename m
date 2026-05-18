Return-Path: <stable+bounces-249207-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JukGPvCCmrP7gQAu9opvQ
	(envelope-from <stable+bounces-249207-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:42:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43380567FB6
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F0D39304D413
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E62A3E00BB;
	Mon, 18 May 2026 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX61KUrC"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66105326941
	for <stable@vger.kernel.org>; Mon, 18 May 2026 07:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779089721; cv=none; b=jK3LPhCaW7VZ4dDOmh2si36pxRhnh9AIoXNN2CMcyCepSZEctTZ05nnXLSOX4KYSLFbGWTDtCL97fG2Ne0ij3FrN6Gf7qNRJORBxJdPdgp20J7n7c76/91NPs+TGgsJwfB4TektZTUS4k35XuQQZw+tOOQB/J8/JIGSRY10IAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779089721; c=relaxed/simple;
	bh=xAxy7fO2YlpiPg7YUBfWrXYpsnJqHkDmbkTaqIyM1LM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R91Ex3CGnpnOZYuG3rIGZlCUZuzuvH66+uebOtlYhH02CavUDXzXgZyAkNe4o++SUsrqPZDLwvF+m6qweymTC/Z7EIMhKK8hXsdWXfSioO89Qk7y4/iHW2RovoklVrpfPZZ9E0ICjH1+2NnZg0I3p8Zb4p6/1ZEvwQvFye7vXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX61KUrC; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39393c1b5aaso18467011fa.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779089719; x=1779694519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWkpCpQ0FJ7/KTqsrEBZy/g0n+sB4k/74RUvdqaLZAk=;
        b=NX61KUrC1uZro1+RMrqjUnudB6XMDVmlpnlDTVMfCkW5Qeuw0Cz1lOdjnS/GkwSTJH
         jq0/621dHTbHSkA7biYG40w66nIKY1OIFQRxklHP64td0bzSq6nvtm5hKwz59baqtIP0
         oTvn09Poe02Ul4MPwp9xDoV0/iwu2lNPPtDxJFP+eRdes4RxKz+Gp6alJTWudRvN9POr
         K9E94ymI5P0N7vZJ3E7n2Z/j/b8m45NVzYBQjiUueJoGH6mbLS1JkcXDR4mYZT60YViz
         07O3f12+ncZzy4J6ofy80CfjxfFASjaPd0tOWRGvJWMRQVsdumc9OwuJFSX228qu3pLF
         QAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779089719; x=1779694519;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWkpCpQ0FJ7/KTqsrEBZy/g0n+sB4k/74RUvdqaLZAk=;
        b=G3LasezogboIKPaws039dUlDNq6E44pyqnZuJIWh57cLd58rSsmphJOYS+TKuOsvgM
         vFCHPxNV7gh0pHsNlwcdnGMFed4JOqx3yNTm9r60jnH2boqz+rCjhvZSYx3n2rfCmJ6h
         iLXuIupf8XQX+u7L6Rm4FnExWVDIkYpooqfy9eKz65krjSdv0meF52PzEExGSBb1FLGW
         qPAmYODd2D6C0zD+Exv58cKAnI4NwBunMKLd5PCi6IKYYVSgnl2v5TDrvfe9JqmIRpeh
         7R00wsLNApP1cUmIPcuSnVjC4qhyaOGTfLQ3ivw6NmSRyyw2xzju7gms2s0J96hynCKY
         8sAg==
X-Forwarded-Encrypted: i=1; AFNElJ//RulggH/iypDnhnJ+EHBvIa25XqmVY44XhnWr2rLGkrTQYfd5v7xnLcKwjs4TUgXMfX5OFEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQjA4IlMuCIpWGO6+yC1AhjjLkL2e+0p/dm+vEAal1R/iJkps
	uGW5krxKU+q+TNNPvPqcs4oXljM0JlNNnI+enQ8t96iZ4GQ/pml8QGnT
X-Gm-Gg: Acq92OHzD82Ex08vE5Wl9oDDjv4ZA2XE1z+BciQPhBCT+G5fTTrp1vXtQLdq7DRGCI4
	nm6ECz6NgBAIEDeUq9ofnX4lHg2GheJXDxvJvydEWzUnGwYj/daWhcv7IxwwhzmAtAqEMmzirob
	v/3TzeRw1vbeJsh3zUWPiNk6HGN9On8HvoAnqOesfAihXsUadbtDwhxIxo8W0EhN7mg0Xy9iwIk
	qEyq2z4VbrOPP71Z540qx7RtsqjeqOJlorjtRbbRqRvWlfWA4WySxUelGAy2bFHUQXuaymP+Q/6
	rxhMWBda8uBzYKiSBamkQQ0IKOqShH17c8x0DvoF6kZ/j79p1CGdCfMKRcnBI/2aAQJTZXAIjoM
	7cWVbN89Kj3baST7VX5VC7eXqSGAScLbeWOola6OWxRJ7gcRapfRB5e66aB7xGm2VZCG+jMI4jq
	7vITqnIX2hNELO09L/DamTsRoQ/47I7Off
X-Received: by 2002:a05:651c:1503:b0:393:bffa:d815 with SMTP id 38308e7fff4ca-39561fec6ebmr35018191fa.21.1779089718284;
        Mon, 18 May 2026 00:35:18 -0700 (PDT)
Received: from [10.38.18.54] ([213.255.186.37])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395887b4064sm9563661fa.33.2026.05.18.00.35.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 00:35:17 -0700 (PDT)
Message-ID: <11ce9c58-25ef-4c47-b3d6-7d189d3757c6@gmail.com>
Date: Mon, 18 May 2026 10:35:16 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: pressure: rohm-bm1390: notify trigger on all error
 paths
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>,
 Stepan Ionichev <sozdayvek@gmail.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260517160801.269-1-sozdayvek@gmail.com>
 <54ee1fba-3209-4192-82c3-674a1ae3ca8f@baylibre.com>
 <3cb30f12-8b4f-415f-9a1d-823d8ff8c33b@gmail.com>
 <agq4zER5Tv2LErZV@ashevche-desk.local>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <agq4zER5Tv2LErZV@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 43380567FB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[baylibre.com,gmail.com,kernel.org,analog.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-249207-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mazziesaccount@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 18/05/2026 09:59, Andy Shevchenko wrote:
> On Mon, May 18, 2026 at 08:21:17AM +0300, Matti Vaittinen wrote:
>> On 17/05/2026 20:12, David Lechner wrote:
>>> On 5/17/26 11:08 AM, Stepan Ionichev wrote:
> 
> ...
> 
>> Maybe it would be better to do something like:
>>
>> void iio_trigger_poll_nested(struct iio_trigger *trig)
>> {
>>          int i;
>>
>>          if (!atomic_read(&trig->use_count)) {
>>                  atomic_set(&trig->use_count,
>> CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> 
> Just in case somebody is going to do that, avoid doing atomic_read() followed
> by atomic_set(). This is typical TOCTOU issue. This should be something like
> atomic_xchg() or atomic_add_return() or something like this in a single atomic
> operation.

Well spotted Andy. This is existing code, so perhaps this should be 
fixed if the logic won't be altered after this discussion.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

