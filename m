Return-Path: <stable+bounces-241320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKhnCAJg72mHAwEAu9opvQ
	(envelope-from <stable+bounces-241320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:09:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CB34732A5
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D500C3008444
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D22F25F4;
	Mon, 27 Apr 2026 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XM3DPMVE"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22527313E07
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295210; cv=none; b=EhtklzYYH0Daly8M58LHYtdyJTw9F8HsG6mQte9qVfJQpZ4OFhPD3ee8GI3JHHW4xDvQ4gE4zRWdZLanCuTdhvL2Tkc4gfpMB1ukyfG/013t3C2EtFo59c9eg+1s2QLCsmAOkQbShaE4wmbBOuuiDqxh0ZmxYBQynLoX0N5qLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295210; c=relaxed/simple;
	bh=IYUpsYBEN6196owDLzfH5/F1IIkOtluq3J8p6eTninc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EVWYgtA2sPX+sSq/85fLNqUhZIP5N7Dk4+eVsZPtaHeAUKE01FnWQUwO1wY6Pr0tNPZ/upsndlJhTcvZxvQR0fPZ/kss+CKylIEEmSCjrmjH/OziBXi7bt9yZYJnFLlLM9NZ6gtGSy6Fwp1RgqrToILloq//bOFx0CwVkY1MidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XM3DPMVE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso69346525e9.1
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1777295207; x=1777900007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IYUpsYBEN6196owDLzfH5/F1IIkOtluq3J8p6eTninc=;
        b=XM3DPMVE+K1XOoLpa98jBTuVUCFrDSQ+RquqB+lEApwbw5/ozF2g2iFFmpvt8XJIC6
         ib6MlNKA6UcJmXzsEsMHc+SZ6IPzkBJlN2nrdzvsgjLQn3WX2sM5x9jGWYxmTdBi5N/p
         u529qWO50tGXl7EOfgLEnEIiUqvLxBnPTnBxEF9mUtZ7+PPRpy6VoHjC3uz097BvAMlf
         9LmLlmHnFiqDdOppWP3TgS/L1EfoNx8pZ7ZEnIk6zVaxM7qxsiU6uWfGFe2EwXs/aekJ
         TGDNvBkwtOfovaKxam8pVGPx3ov5t3LaSFIM/hNhXX1kIMj7lTWcNNL5P+On2i0brFZ8
         pVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777295207; x=1777900007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYUpsYBEN6196owDLzfH5/F1IIkOtluq3J8p6eTninc=;
        b=TpfKa0rHb17reWySF/juWuVdi7Ni7nR+qcJ67tvNatJrDkKojYg3J1klg/pTiKAECY
         2rWInp7GRSpDzXIwjGPRyb+E5wDqoQsSzt2LVt7EObulvRDIx5IGe08U/7K2/7DGSxgA
         ttB30aaESK+piytQIgtpfaORq51HKrvMyaH2rXiloOuhXQ534URxTLuFCB0DhiqRTQ5N
         DSqGZVvSVkiPyLCaCRC0xuCpnIlqkNsl6Q9ZZeF5nEPHaNdV9Dj1csklKugdSxF3iUFR
         zFY8327ZztIC22hOwO4SF1T543ql3GqwcXmso3oLBu/t8d20ZnIZ9ySJRPuQTWenwTwV
         dsHg==
X-Forwarded-Encrypted: i=1; AFNElJ84Ps0jD556pfhbPY9ephKSyUlhGzBgJVM+N8JvBamgdMLQ/uPadD3mTEhGMJkVbe7HRa4VDT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQr9ZXQX1ErmM+s8VW47ATFfdZxHKZXCMjlZWJqvBkcD9puloZ
	mhQI1SQ7MuCDLCydToDp1K9WC+uZM6H5ghabHHBHQmXSJaUd7m9ZI9gsU2cf4fLi22c=
X-Gm-Gg: AeBDieue/AKxdPGEyY1timo0e354Mi+JImA0nmz0UC5OHtGe1aey0SUvhR3HfjiWfET
	xoEixMJa5fdUuC68KWaczI10S0elr+fiVxofJ3bznu65fSJu9r0a/jHjU5vUfRFXSvn4uEUMK4I
	Ze2nWH3+tjvmhLFKT0vRxFo1HZejJTjEHMxRgGPYWL8WAb6D8ty4dDWHRvrpj9OgqMXPDdw2OcU
	3ML61TUIOOGdMK0PSWpl95ya7SI7YAOFodcEC4HvcyB5DKNKx+w6ingu/ihL4tozW7gduoueikp
	9M1qB/kWUlG0xOETsNkbV3bt0rlahO3XZB3SxInxlb0WU/DvZS7K8BwNzzeU1Za6Wd1174ekmY3
	AvXIvbNEzZybsakuYClRIXrHqfAqPX9Ric4EM0MU4XwcfcpoVP5pqeBZmX9GWDJNUkWhhfXHlSa
	ETRn/XbfJZRi8irIz5Al94KMnFG9cWoFK5O7l7hZTDi0s98She0Q88Jw==
X-Received: by 2002:a05:600c:8588:b0:489:2005:b36e with SMTP id 5b1f17b1804b1-4892005b4e9mr301808215e9.19.1777295207493;
        Mon, 27 Apr 2026 06:06:47 -0700 (PDT)
Received: from [10.11.12.108] ([79.115.63.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb78d1bcsm348440715e9.5.2026.04.27.06.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 06:06:47 -0700 (PDT)
Message-ID: <29a976ae-c8a8-4a5b-85c7-f52a7901a7d2@linaro.org>
Date: Mon, 27 Apr 2026 16:06:44 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] firmware: samsung: acpm: Fix sequence number leak and
 infinite loop
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org,
 andre.draszik@linaro.org, jyescas@google.com, kernel-team@android.com,
 stable@vger.kernel.org
References: <20260423-acpm-fixes-sashiko-reports-v1-0-2217b790925e@linaro.org>
 <20260423-acpm-fixes-sashiko-reports-v1-2-2217b790925e@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260423-acpm-fixes-sashiko-reports-v1-2-2217b790925e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 61CB34732A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241320-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tudor.ambarus@linaro.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi!

I need to drop this patch, as it can cause silent data corruption.

Will send a v2 dropping this patch and adding a few more fixes for bugs
identified by sashiko.

Cheers,
ta

