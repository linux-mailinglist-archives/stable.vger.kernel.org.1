Return-Path: <stable+bounces-233521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D7iJCjC1GmWwwcAu9opvQ
	(envelope-from <stable+bounces-233521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:36:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ECE3AB6E2
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 289513014C74
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F4139934C;
	Tue,  7 Apr 2026 08:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcrAyvSx"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598413382E8
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 08:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551010; cv=none; b=l5qVdgJ3T+ZrKwypm2bsC/K/IHwuNo6tvQyhJTyzMZMlWlXVeyQdOXL8NSWajfctaykPjM0bur0xePvk4u+smVkMjDyUO1gL2PLCCs6o/m9CKee2vZ5hKAN33BQi7tBE/gJC/ePe/h2M7rkN6yaC6TzbsxzBCMktxrTXRkAsAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551010; c=relaxed/simple;
	bh=coAssiB5s3BHcWfufm9xuM2t6aLsl0hqzz+I47rZLP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9jO1fKntu3XLFxSVYZqZ1y6lYOQFJYH+BNmG3bBeW8pMZv0KeVoJudmbIGHw5r5YtGSgpoSryxKtkaQ1xZDVNSJ/C8xwSY4B7+QgfGeWo8gzBBp7vEIEbBYSS9ua50sPY1OcPITQofnQUMen2jxGoHwRRaaJ9Ytb2cL80W6oMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rcrAyvSx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66bd4f7b2d3so5626641a12.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775551005; x=1776155805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvIQyuVRFxWn/kbN1SCbK2vfu2qTJKpKKyKCht1EX/8=;
        b=rcrAyvSxW2RhUEG6eAhKqZ+AetYohKd4TcfyjmLsD+RWjFbtBP3tovmpskAOQqYKMX
         v6kRZTd4aAuQeetOcxD8rQYMiwptbE+z8+64EQIPiV4alf2gS+0Z7lSy01Pem+db9V4h
         IHU8m+t9OBJlMO9N/41g7mCEg9p7SDJxS18hVElLIHWXiFYF4XkupGrzLheRQaRMVwZ3
         jLscwxgT0KFbJ2lcrXIp4L3fZjI/Z0HwIt+TTcROsfrSsj0tve+SfQicum6li20uSYb2
         D2X3b5t6Zpl6s3WCDPFOtez+zTE6M2GEUuqj5GhxBb71fM0KFIxoTWSIZudyQRd0eIlC
         OLTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775551005; x=1776155805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MvIQyuVRFxWn/kbN1SCbK2vfu2qTJKpKKyKCht1EX/8=;
        b=Qc1EMK6AmYdUnvauTfjG8ifO4Gu5HHpEUG/Xw9evdvaF7jvjQHlEMd+KiHQdSZfmD7
         ou+JlSmNFalttCStxRWnWE+4BX9oXxu/IdPyOPTQvQNj9htcLUN7blYUqygCoYvtuLTI
         zm2MB/Hz9cOnKHr6Khg3ua54pn+iAdr5omDcj1sB4XLSETgBNoGC+t0OI9qI7rGZhdBJ
         j6B4caENtu43cnM1+DiCI6GeduUEUdopamqSRjzlnOQ+kio3KQpwwlFT7/UuJLFJHz8L
         8yoZxtfQQZ5HyyjDmdXsscigsKd7iRnTckMOthOMFxZ3QAgzetavtrevq5roEAIhcTb9
         lekQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6l4ltykJsLjiTKj6gSsHAVn2LbvWQ0R0HPl586P4JfS4bUVi3Z9id1ZOJ4c5wl10PN/cffX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze6siP6CLHaKlRmXW60Dbu7dfxIj+i52lHa5DvqOOAvOZZHuOd
	N28F7HzDIcUKVe3K40w4dG1KIOyO3eggo6bGRQ+N2n4VH6vltP/68zI/DF/Zs1UDydeYeJrLGjo
	YVH02NSw=
X-Gm-Gg: AeBDieu+hPMI3izBH08K+0fIKnDyo5u6DzuvBUOoEQpinfggLvnoedtvQ7nrN/8MbDJ
	sJ6nkhNwA8z3cAnNPYP9URnZ/hylnZRVeVJuZ+C7DLXkiK4C0cb4RlN4si45du9SA0hDOSLneRO
	6QGCXv6vwO++FbaJqbzu2A7konU3Zqhq1eZzGpNC2zkJviJIwWo7e3szdoiSTtWu/Q8+kom7fTo
	kPefOLHqEaI8RPMxSAeZQ+uCfWHhGvBvuWwZTHFOV+HEyGadAKGg71wFHaokXvoR6qANyPTCJAP
	nOxIzJb2UUtRDW65/ofwem8yA5h7Avdt68u13UWdec4tB54zptYv7amdQ5qBb6R5uX9YKUxTs3z
	8nyntL8yU5qKHiLvz5CV7eR7T/DRmCFyzNLRt/J4svQWEE3EjcFzCDED3t7AMO3GAM+J/hboaRw
	W7kt2LV53rqAeFlGEJaRxRMode1196NH9qeal0kGIjKR2aLy4ZIcBjZMhyH8O6vFJggDA4AQAe7
	x2bfRjO2c1Z6L3zegpeYOA0VF/GxfHCC+la9mRkL2fUhoH/CMhMZ86RqFOjMOPT3iI+6VaVwYHn
	RUKQfMGHTNceDw==
X-Received: by 2002:a05:6402:26c8:b0:66e:714a:f6ad with SMTP id 4fb4d7f45d1cf-66e714afb89mr5429021a12.9.1775551004633;
        Tue, 07 Apr 2026 01:36:44 -0700 (PDT)
Received: from ?IPV6:2001:1c06:2302:5600:7555:cca3:bbc4:648b? (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033a74e8sm4110570a12.16.2026.04.07.01.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 01:36:43 -0700 (PDT)
Message-ID: <5812c794-fd2c-4b49-8146-db6a1c783706@linaro.org>
Date: Tue, 7 Apr 2026 09:36:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] media: qcom: camss: Fix RDI streaming for various
 CSIDs
To: Loic Poulain <loic.poulain@oss.qualcomm.com>, bod@kernel.org
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>, Hans Verkuil
 <hverkuil+cisco@kernel.org>, Gjorgji Rosikopulos
 <quic_grosikop@quicinc.com>, Milen Mitkov <quic_mmitkov@quicinc.com>,
 Depeng Shao <quic_depengs@quicinc.com>, Yongsheng Li <quic_yon@quicinc.com>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260406-camss-rdi-fix-v1-0-d3f8b12473d0@kernel.org>
 <CAFEp6-2BMaT+u0cAJnZNCaxbiNGCayYs5uMr13AEe2iWWZZxzQ@mail.gmail.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <CAFEp6-2BMaT+u0cAJnZNCaxbiNGCayYs5uMr13AEe2iWWZZxzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linaro.org,quicinc.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_FROM(0.00)[bounces-233521-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bryan.odonoghue@linaro.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 52ECE3AB6E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 07/04/2026 09:16, Loic Poulain wrote:
> I agree with the observation and conclusion that proper PORT and VC
> support is needed. However, as things stand today, this mechanism is
> also a convenient API for leveraging different virtual channels.
> Concretely, if you want to receive data from both VC0 and VC1, you can
> simply use RDI0 and RDI1. Changing this behavior would effectively
> break that usage model, leaving us only able to retrieve VC0 data,
> which feels like a regression to me. The more compelling use case, in
> my view, is the ability to stream different VCs in parallel, rather
> than streaming VC0 multiple times?
> 
> This then brings us to the Pix interface, where streaming something
> like VC3 does not really make sense. In the current csid-340 series
> [1], I therefore took a simpler approach/workaround of forcing the
> main channel (VC0) for the Pix interface.
> 
> [1]https://lore.kernel.org/linux-media/20260313131750.187518-4- 
> loic.poulain@oss.qualcomm.com

I thought about that however, there are no upstream sensors driving more 
than once VC right now.

So this really is a bugfix. You can even see it in the original commit 
message for this feature, imx412 was used in the example but imx412 
doesn't support multiple VCs.

This is a pure bugfix and now that you draw my attention to it, I think 
you should update your series.

I guess this explains the indexing stuff I was nagging you about.

---
bod

