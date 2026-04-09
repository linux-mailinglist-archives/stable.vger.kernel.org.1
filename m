Return-Path: <stable+bounces-235441-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFsPFc3N12mrTAgAu9opvQ
	(envelope-from <stable+bounces-235441-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:03:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FA83CD4DA
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 18:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6095931F6912
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 15:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FBF3DE451;
	Thu,  9 Apr 2026 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joRS/r/e"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9F130BF6D
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 15:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775750034; cv=none; b=i2J8Tnm2b7ydJRSjH1gV+F7AdTapyzezHYO6TM/s0G/hFzLR8rKYAw1qI6r2hwsFs1Zdiddd3G5KySjGm1fx4w9cNGi5coez6AmQiecIQSlehfASQYGAlOQxKjbIL3dVfep3uVhQ6gUw3FP9kNRLW+zOSC2ceA1ndwlZIPdyuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775750034; c=relaxed/simple;
	bh=lpYW6QtUEzz3MqWh8OmxWBkyfeGJcQZTfJfv+NYNYoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHhmMugSMHPjZ8hpJH3Wd5fn9Y6GUwJlY5j6ARiz4VUUEiEpulko70dRk9mbvl7XC1rpXBo62GfO6uOAEBQyvuiyBtdUruj1oZCeYgbFGKoV10cDKoAVHIcHxyU26y8JH/u9OK5byUfj4V8wYrIheErRnv817qFF13rGkfCyePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joRS/r/e; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a3d29c4a21so120129e87.3
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 08:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775750030; x=1776354830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YIT5Bg10xahQ5nKaiIHS18eD2BykZR6y21exJn2IrA=;
        b=joRS/r/e4QaztA46lKFzwLhelpwKUqYHAC9j3IcA7hu6qNWkEXt9I3mv2DxK3xQj+v
         BQaVd51nQiWpSnWrjc7LJUD+dhQYl7t7FoEBbIQcPmdVv9KEpLzT1UwLIE/l0NyYSlNa
         L0tigNjb5D9Avo8kuyWoPaa+Y3Ncwxa5TKGrqVY5HRdOvs8QyrJjB8qeAYVfygpNtDtv
         oUzH9UN7R1rWIZbs1jmFat1c3vnluCetPp7GOPpNIndlLLDRYNZ8hsdUSK4BPYPnTqPw
         MAAxhinNrQTYspaNtJ8qXenLfM6guZcDgd/lcF0V4y+UY9Xr6u5VVdW7xkuJq/je+Fs2
         cvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775750030; x=1776354830;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YIT5Bg10xahQ5nKaiIHS18eD2BykZR6y21exJn2IrA=;
        b=IwbbrRK0QJviLX3QeC/8ibRUCxRoQCSgHpLPahavOcC61N94pco7bGhCwl0TXRnR+s
         iOZlbl7f805NUiF/WjIHmuQ5ERkNgtTk4PLJQrg+SOvdVQqlNnKK4iKVz1mCk4wbMTdm
         xSh+qJzlp/iqmlS6Ts2wytsJ0uUUL1rfvx9Cu+zNTK1Oz3qyHXjhRyQufwxRtscbrdFm
         28ILVYCnH0aCgLmc76U2rTu5VqYkKfIKnyqUl5NhDvKKLxiOSlgutuRbOT/R+sUD3JhB
         xBAlMvyKp5aIF1Kz83qhWyqHraGGEbxpCOCFKz+LOv407D4UTvYzGIuQCV9ClTq76Z3w
         i+/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXj2oVvRuvgXc3RNLGdjSURAfTWGbLrAZlmE3V9POZDQtL94ARlK5WcrkTkOUy5y2N+B5OAmMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzFbPZ13lVudz/LwKYVS60VtQoscrs/nl8IoRmFRRBpY7VpnY
	HGepEiIerkZeVrRUmnSfoXlWQxnWccBcZggNR5dnzPHhVtfmnadEO8GXq9jGheSQBVA=
X-Gm-Gg: AeBDievtyb6lzEIhKC6JXWGr+FUPdwbY8EbMTY756KR1kY9Z0V6rZGr92e+V/WgIodq
	1yM6RHvf24GApSTupFQZLEhrK6V0HRM5TjG60p/Pn27agICqjr2OD7jNS75B8WR1pBbIIWojeti
	L7vH7HUB9PkztiN4t4KSk+ThKeNwIlatZ8wWF6iRmzcXnz0z0C5/BNtyUtuC6kaHwH9WU6jqpRe
	lEvlwRAYScusjbjrop22/7qhuEsjZZfCKr7Y5bDWi0yWWzxwjkBCtj2XWMdAwclgYGfGF6fTmal
	T5ga2Tvw8PvYxGfoKhsfVJi86XQmv68zrHc2dVjKhBbubkuiwNmupW79MQ0rX2GCFL11m6j9pM8
	/NobRVPiy/mVGX8DobjJpsnqEe2MozkRkWo7QgWUVvX9dvGuDRwSlpSuckhhnKctbKgvNQ6s46y
	+g9G/PVjwZKZb9FTOfWs4u75NxFjjYVpEa1ETySUrO0OULrzofXc5lo4IskmktF/WFK+oi+Z9Zn
	6eFTw==
X-Received: by 2002:a05:6512:3d01:b0:5a2:c981:2f81 with SMTP id 2adb3069b0e04-5a33758dd9cmr4275190e87.5.1775750030027;
        Thu, 09 Apr 2026 08:53:50 -0700 (PDT)
Received: from [192.168.1.100] (91-159-24-186.elisa-laajakaista.fi. [91.159.24.186])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eeee125esm937e87.46.2026.04.09.08.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:53:49 -0700 (PDT)
Message-ID: <f4bf0d34-07a0-4813-83aa-f49fa417df7f@linaro.org>
Date: Thu, 9 Apr 2026 18:53:47 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] media: qcom: camss: Fix RDI streaming for CSID
 GEN2
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
 <20260407-camss-rdi-fix-v3-3-08f72d1f3442@kernel.org>
From: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20260407-camss-rdi-fix-v3-3-08f72d1f3442@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235441-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,oss.qualcomm.com,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linaro.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.zapolskiy@linaro.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,cisco];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:dkim,linaro.org:email,linaro.org:mid]
X-Rspamd-Queue-Id: D6FA83CD4DA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 13:34, bod@kernel.org wrote:
> From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> 
> Fix streaming from CSIDn RDI1 and RDI2 to VFEn RDI1 and RDI2. A pattern we
> have replicated throughout CAMSS where we use the VC number to populate
> both the VC fields and port fields of the CSID means that in practice only
> VC = 0 on CSIDn:RDI0 to VFEn:RDI0 works.
> 
> Fix that for CSID gen2 by separating VC and port. Fix to VC zero as a
> bugfix we will look to properly populate the VC field with follow on
> patches later.
> 
> Fixes: 729fc005c8e2 ("media: qcom: camss: Split testgen, RDI and RX for CSID 170")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>

-- 
Best wishes,
Vladimir

