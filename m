Return-Path: <stable+bounces-235437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKn9DlPN12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:01:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 615AC3CD44E
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9045130B368F
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1A2D6409;
	Thu,  9 Apr 2026 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWgRkilN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8973D5649
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749979; cv=none; b=HWAjOCRzL3MTPESNce4I2I5CmLQRXe9B+jkdbkS+uTPSdyW2PUOZmajBMHNRyRtCxurUICjqbFCkm432Q1Mjlo0BFex+Pt1TP9prhqf2hUqfbyfIEJKA7TopBHslR4D6H/6sf6Z+vtbnZ3KopkyxHxQIpQU+mqCmA2s/zEN+wRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749979; c=relaxed/simple;
	bh=/pvXc5WIJxIAf4hbxTG79yDKdrk8s8Sribq0S9nfTEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aU8Mxa8hpegIj3/UfA/aD2n0xAS5Qo943FR6AnT90AnIUlfm3kEOuMWpS/9fB6e3ovXSlNqjHEPsG3btm8pCbMQoyOjcOSf874W30xm6nMW6yA/ajGMY9LdmlJ4lY4tSL9+VypHWks7gX+vFzxTHhs339IbC0BflzCjXwrhAI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hWgRkilN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38cbe9162f8so631381fa.0
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775749975; x=1776354775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5p2xo/4m0JDhf++H7DLBizAlziwNWg0BWASCHtSL14=;
        b=hWgRkilN7uvDud/09oH/2BAyiFtDWBPMCJk4SR7DGkWzxEZDYF69LrX9d2fnpO0fpw
         hUKUJKrp0xTK7P8yQlJhAS4z+6XvBqcAp4QN2Tl93gdPJkvrpKoTUd2XxYRz4tgBxVGs
         kR3JAlu0MKD9GMFVNbThce/Mhf6jel3DNXczKlkvk/+S89HufIYtvif1IBkhZ/T4GoOK
         e00NULCvjDjE9QtL/18ciIXKG6YyE1XhOavSGPV8z1X0elWWg7eR0yt3gmGC91xJZZwl
         XNK+LUUseRzBp+XCEC0xYwJzUuNjU33vkd8rQ/2hpP0eNIYF8NbvYTT3reaWNIwIJ2+v
         WeXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749975; x=1776354775;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K5p2xo/4m0JDhf++H7DLBizAlziwNWg0BWASCHtSL14=;
        b=mE+t9X7o61YBWriMgLBRBKCl2D+SDSpJMlBlfksDGc6mHfqlh2ySVMWXUDjw9HDpgL
         jCRRiyk1kfNtT0impR7C8uagesz0F/iEBzUrwvo5fcuTwYC1oN8+a44VNxEUDrMqtcU4
         9f449nC97PQGvV0htLZrnwk8T2ljMBbvKapbZnoU2Ncf3nDp9PzNgxPbnoP8ofMrQWoT
         tlAui9+cPutdLtuXt8ug/ueyGOwCh9znMsINanAvErl/bGc8ED1Pz8OsTncIOJpZnnMc
         w9MLBOrj2Jm7I/YDFp18NC2pxi78RWPJ56zQEo6LVIM1VdkaI0dH2gHU1H5J2Ci5vPwJ
         WO2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcEgVN4wESW/JJzUvmYc2gaj4sCR+IzfJcjqp4BAhrPyiNcgpB5f5lU4KtoyNj8inpgXjMIZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiYA1S67abV6WhKq9OzmzxxEGTvibLLs6n78Bya4/MBb65sInj
	H/m8K731nmdwHVYXZJayK8KktayyVTNZu6+6cHDJZYdCFUQ1yjsj1A4WNJdVnTYibqw=
X-Gm-Gg: AeBDietZg9+xknyHjM7b8xVK9wdcGxDTILPSJSgcpxGLR5zBmOjqOSOJV0trmqHsOk3
	k3yi852opARlm1BxC/Q9DDlWN8htiT2Q6RXyCFObBab6kEgt+LSJhDkLH4p6hFbd1M+n9EOwRNz
	9d42YmIhN6k+Wjdxhyj9unVsI5kWrtO6oU+MnmFJmJJCL8DjncsY/bWWk8LHLtURYIHOFKInRru
	9NRwMRaDKdF8mX7xLQjQjqwoqfYR24xiV8HZdyadhFmBk4CVsBQunvFTZpLfH+cQMnoWewoS7FM
	+o4AOXgaEiGHA+aIUP0OXBQ3n/7OqUxeWj1ix96i+6WmfAB2UD++YlaAcmBVTr5/gdlMPSsd3vM
	mA7tcJm9pB9FFhwOOv2U9WfjJCdXJztfP3H5eWCCbNvcliOhHwuO28oohoPymqraLH/GyDToBR3
	qmSLvaIs7n01E0kqkrdJ2GKnU/U0I73zbaYjTaN0NMxZbY2ozP6xd0Y/Mg2PQWYkYDQsZrx+qAy
	MBfxg==
X-Received: by 2002:a05:651c:1b06:b0:386:5df3:8195 with SMTP id 38308e7fff4ca-38d9d4c710amr34829731fa.6.1775749975281;
        Thu, 09 Apr 2026 08:52:55 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e495ae59bsm188831fa.38.2026.04.09.08.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:52:54 -0700 (PDT)
Message-ID: <b7aa5f4b-a2d7-4a97-98d1-58f7fa5dc349@linaro.org>
Date: Thu, 9 Apr 2026 18:52:44 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] media: qcom: camss: Fix RDI streaming for CSID 680
To: bod@kernel.org, Robert Foss <rfoss@kernel.org>,
 Todor Tomov <todor.too@gmail.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Gjorgji Rosikopulos <quic_grosikop@quicinc.com>,
 Milen Mitkov <quic_mmitkov@quicinc.com>,
 Depeng Shao <quic_depengs@quicinc.com>, Yongsheng Li <quic_yon@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260407-camss-rdi-fix-v3-0-08f72d1f3442@kernel.org>
 <20260407-camss-rdi-fix-v3-1-08f72d1f3442@kernel.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260407-camss-rdi-fix-v3-1-08f72d1f3442@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235437-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[linaro.org:server fail];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,oss.qualcomm.com,quicinc.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.zapolskiy@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 615AC3CD44E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 13:34, bod@kernel.org wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Fix streaming to RDI1 and RDI2. csid->phy.en_vc contains a bitmask of
> enabled CSID ports not virtual channels.
> 
> We cycle through the number of available CSID ports and test this value
> against the vc_en bitmask.
> 
> We then use the passed value both as an index to the port configuration
> macros and as a virtual channel index.
> 
> This is a very broken pattern. Reviewing the initial introduction of VC
> support it states that you can only map one CSID to one VFE. This is true
> however each CSID has multiple sources which can sink inside of the VFE -
> for example there is a "pixel" path for bayer stats which sources @
> CSID(x):3 and sinks on VFE(x):pix.
> 
> That is CSID port # 3 should drive VFE port #3. With our current setup only
> a sensor which drives virtual channel number #3 could possibly enable that
> setup.
> 
> This is deeply wrong the virtual channel has no relevance to hooking CSID
> to VFE, a fact that is proven after this patch is applied allowing
> RDI0,RDI1 and RDI2 to function with VC0 whereas before only RDI1 worked.
> 
> Another way the current model breaks is the DT field. A sensor driving
> different data-types on the same VC would not be able to separate the VC:DT
> pair to separate RDI outputs, thus breaking another feature of VCs in the
> MIPI data-stream.
> 
> Default the VC back to zero. A follow on series will implement subdev
> streams to actually enable VCs without breaking CSID source to VFE sink.
> 
> Fixes: 253314b20408 ("media: qcom: camss: Add CSID 680 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir

