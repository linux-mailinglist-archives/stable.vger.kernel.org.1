Return-Path: <stable+bounces-89078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACFA9B3222
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 14:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB05A28222C
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 13:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702661DB92A;
	Mon, 28 Oct 2024 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mrOASrr6"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC481D54CF
	for <stable@vger.kernel.org>; Mon, 28 Oct 2024 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123399; cv=none; b=Spxk/BlcYlpW44oDS4weNmenesM4G6ckCNT2yXnTxRhvOujjy6HoQrE2wC7BGxJmZJQ1kKCXS//TN9Op3Qq+saxHrC/mGNWYLlwyaAAUg2I0JPOS7dfqeXQ0jvz8fqdPiZ+aJh0uhTjcQ+zrZGltvuJJ/Hc2TeD0Xnq09F+oGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123399; c=relaxed/simple;
	bh=6Mj1VRgXnG+nvybtv+ZC4oMxMVCimRwftrC4glOVmPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJ+TkoGxGTg3iX9Di987DYRM/9sOMAfU5gxYIiaQJGODagF4cjdgqZf6cRwwH3VyZG/Sns3MkqAMfmS4B+3dmWEG7RBtFMA8mgrnL7uDEJYT4hrXcKDBmpYiAwF9v3p+BBK2pRkcX74tOWd7mwIpFYL4gB67SA63uQDe5RcIRLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mrOASrr6; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d50fad249so3266391f8f.1
        for <stable@vger.kernel.org>; Mon, 28 Oct 2024 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730123395; x=1730728195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/p3KIuaZuZhHqqQdmdj5IlyJ0aVNyH0A6LgRHkyb/Y=;
        b=mrOASrr6ouUPvMQ7XM/AdYaGGjITszpUbzeJWt6SYZDPPs/C3Kk+V59MRCpc5TGwAG
         0OABVyTNOHYji56eVX8jYmO02hBLLG0d4tItvczmlbHgl4Vd7n8cTSLD8LlvGQAal+xW
         dHpzFg/xgQ45KALdDdpD6ZD3dyN75/QdTPn88SgeL2x7ZG/q4NpApGDNXxOwDtB++Dai
         C2E7yTo5RyXoybpARdGqcAEKR8tuzKo1mQQRZ7eZzK3cSy3mPBXG5b+kHigSOYiwsZ4y
         Jvs4r11/tAAGR4fPF4M8tFMZaUgOq8LMhOOsw8+HcdgdFywhKjyBu93qew0V0VzBrQDI
         hLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730123395; x=1730728195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/p3KIuaZuZhHqqQdmdj5IlyJ0aVNyH0A6LgRHkyb/Y=;
        b=QYLNdGwBhsRso78GQIaMap1GFzMQ5dCdIrDgasSF+pSTjYN8slsnz1t9UhGXiJfFLB
         L0CEQYsP989K7QqlMFa6A2WWmdoS0yPNotwUcMfTJCT95JQAvatIxTUq3JUzjjGn8rNk
         nJIu3O2Lj9aF+gRAdxd5xgEsnQB1w5why0bY8eVeCKfMIxXdLm8JsHNrQYl7Iq6/r5Ms
         WkdN84aIZ9rpfRQrjaNaSJREtIfffYriiO18Wc3rWyap/KlqZkIG4CCFOcWUgGO9iVd+
         zfxyrAFEsz3NOSI+9YI+M5nF2oJUka41IsFpLm1RzPXUAdy46vhTBgl18WaOPn7Lr8La
         Chxg==
X-Forwarded-Encrypted: i=1; AJvYcCUkYsuzy5ZkBzTFsKAfKnEV2blil44AP2AFfNGtZNk6p4MyU/i4okr+HeaQucNDQY49iT28jkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxBPE0ORefcVuuGoKdCAPOpPbRfGHyB/gweEJ/hdkJMIPZSNPG
	inWWduYffJYNMm7tbH9vDNkTZVKvz5nETqJ2Z+iUfj/x413mN9hh/ihDXw5ZTOvG2OiHBykIr5J
	0
X-Google-Smtp-Source: AGHT+IG0JhYIpcvY1BRr3C+OP/h8ZDpapwg1W+exN7ZHkKKqyPSQaMfnJyOqZXo3BznfrRGV4btjLg==
X-Received: by 2002:a05:6000:1e46:b0:37d:4f1b:35b with SMTP id ffacd0b85a97d-38061162ab4mr6678395f8f.34.1730123395463;
        Mon, 28 Oct 2024 06:49:55 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b1c3absm9589325f8f.21.2024.10.28.06.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 06:49:55 -0700 (PDT)
Message-ID: <317073eb-769c-442d-915c-d803c2960f3e@linaro.org>
Date: Mon, 28 Oct 2024 14:49:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/drivers/timer-ti-dm: fix child node refcount
 handling
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241013-timer-ti-dm-systimer-of_node_put-v1-1-0cf0c9a37684@gmail.com>
 <5a535983-6a78-4449-b57b-176869fd55d8@linaro.org>
 <e7ca7a5d-749d-40c1-893f-da3d593eb4d4@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <e7ca7a5d-749d-40c1-893f-da3d593eb4d4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/10/2024 13:26, Javier Carrasco wrote:

[ ... ]

> Hi Daniel, thanks for your feedback.
> 
> Actually, if we are going to refactor the code, we would not need the
> extra variable or even the call to of_node_put(), since we could use the
> __free() macro. That would be a second patch after the fix, which could
> stay as it is without refactoring, because it is only to backport the
> missing calls to of_node_put().
> 
> I can send a v2 with the extra patch leaving this one as it is, or if
> really desired, with the available variable.

V2 with __free is fine



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

