Return-Path: <stable+bounces-132843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB56A8B8A7
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 14:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915195A3C23
	for <lists+stable@lfdr.de>; Wed, 16 Apr 2025 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342E324E007;
	Wed, 16 Apr 2025 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUPd16u4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3124886E
	for <stable@vger.kernel.org>; Wed, 16 Apr 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805408; cv=none; b=cP0wldSXuH6rztCWqH8twg1AaMb+xgyCyDTfgPotPNErEWShxhzS5hOPhEK3sFQc8p815v+VEYDmxmko4LfvgSmoK4945WPxxIZNB87Gcx1cSwRIjvwy8mmsAzjFa4pLybbhNicjr7dRoY6BypaGoPrJLVjdoOVAlunPfbgXdjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805408; c=relaxed/simple;
	bh=eSqUxdw+knq0VEg3KUP5yWXKZxiSUA8O46Zm7+37lpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0B8IKMG8BlAqtiCbn/udWVWPvszqk16FNR1XDlBZe6KNews+tLUwD++se3BzWz34aPiaPXVzWZEUqmoRaOP1xa5g55F9BuxeCyDk68Xy+Q0FckAR4ir17XvZ2hs/0ITbzNpyfD8Wa39VOFQaCrj1W9amZK4YUe5w2SrteNxxFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUPd16u4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso50004275e9.3
        for <stable@vger.kernel.org>; Wed, 16 Apr 2025 05:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744805404; x=1745410204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y42aZbJ+EXJLkSTiNisifgjorzr07bQAgsETmkkzDgA=;
        b=UUPd16u4zMkjxdNK3GkNr/6f8Qc0Va0FlgE6Xv/QK03WyuJTEcPWjh+ZwHOQc5mID4
         7HelciPn5jYmJBhnf5D5XTZ+3FiLZddbNmVHaEMzqdi3WkQK9A32a1IxE1m2Q9fMuTSp
         9z3G69ngRN9Cd3kAbcMbLZFELjOmPA6dEZIirqF6mR/qmEuRBPQn8y7eIjUjzMKalyjb
         AG3krQv0h7TQrEb7WDvZjKbH6OhUdb9f1G8QDBGrtSmd94OP7XxfWn6xBUBeP3gP1D4Z
         1UKSwKZFGYCnzv6CK7JEojm6coDpouAaO58U+ia5Lj04XxrESxGdpQisfdIDQ8aEWwiG
         W58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744805404; x=1745410204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y42aZbJ+EXJLkSTiNisifgjorzr07bQAgsETmkkzDgA=;
        b=L2A/l2jfAIKf2i9cGpDxOANNPTm0D9Xo4fryATOVV0eXZcfjg5gYXbCI4dB+0miyor
         KBUfJax100Q8ZGhOqqUtQQTA+Cyc0l+srZehHYznu8ZLl7oq23O33tEX4WyTQnPK68aX
         ReMYrfaOnrDp3f3eqSamw3BJDUqHzYT+nfELdHs8mcTn2mIcc9DgEywWjN1aEoNm7rnY
         x7f1x0MJau1nJRv1HJ6zvFFE7NmutI9HekjqRWPRF7mpecyMduW2ld6+Vb4kaTbqT00L
         eMsBtBBuGiRatXaluVf+nP3pkSpbSwy8vpO9IejNhAjCmoUjWpQcwSrfQoW1tgQVdY7t
         vEdg==
X-Forwarded-Encrypted: i=1; AJvYcCVaKKB1i6qXYjogGaFEDouqlKlQ5U5FTTcFxCDJAotWRa6xGoXYovsCrYLxn3FAbOQwGS7/W60=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJRL4XqUR+cKWZVzqMP6IhzQLQTe20K21jAGNo9wUFW+m6m20
	xQwzDQp25HxiXrkWTD5W7JYIFZaxuR2AeOoOVjJopuj5TnIzxwP8tigwaRN8z4M=
X-Gm-Gg: ASbGncv5LrKhdwKGScY7owGOzLXEFxeHhVTALum7L9Zd7xjK9IXVaughlx8yNfj0DKd
	2JDdgc7uhJkmeX337Pos04Jk4m2QmyQpF737BZpXySh/lgOhJiZrnIVl8XX5TmPrpEpXzuc4Ody
	GS+3XBut8UZ+YWmme5sGVlX8P04KTNSA2LFQt0wbR741GHjlgqDSeOqIM/VKTr7uRo0I2IxFu0g
	plqhgvpet5ZsrHffIvxP0bBA5b8uZgC2cfgA9j2gp3xXOKQJsFZImYT47+NrP9D1ZqAKK0rZlN3
	PLrqDdmZxL3BC+2EFs7oBuD/gA5sdQ3pxtY9gG6WAQvpgB+keMJD34GHfXkoa9V7MiffMdcbzVB
	8o6LT/Q==
X-Google-Smtp-Source: AGHT+IG/5+8sfYkHLGOAY6lPDHCl7HnqCX318hQLUFTWjKL/iIuVLzmSZD/M/vmf4/QtA5Lbe/j/Cw==
X-Received: by 2002:a05:600c:a09:b0:43c:f00b:d581 with SMTP id 5b1f17b1804b1-4405d6decb3mr13337465e9.29.1744805404203;
        Wed, 16 Apr 2025 05:10:04 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4404352a536sm37332905e9.1.2025.04.16.05.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 05:10:03 -0700 (PDT)
Message-ID: <70a630cb-06ad-403c-b2e2-ae6d26e0877e@linaro.org>
Date: Wed, 16 Apr 2025 13:10:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] media: iris: Skip destroying internal buffer if not
 dequeued
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20250408-iris-dec-hevc-vp9-v1-0-acd258778bd6@quicinc.com>
 <20250408-iris-dec-hevc-vp9-v1-1-acd258778bd6@quicinc.com>
 <811cd70e-dc27-4ce0-b7da-296fa5926f90@linaro.org>
 <137c68d5-36c5-4977-921b-e4b07b22113c@linaro.org>
 <96bd9ffa-94f6-0d1f-d050-5bec13b3328f@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <96bd9ffa-94f6-0d1f-d050-5bec13b3328f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/04/2025 05:58, Dikshita Agarwal wrote:
> Although firmware makes sure that during session close, all buffers are
> returned to driver and driver will release them but still we shouldn't rely
> for this on firmware and should handle in driver.
> Will fix this in next patch set.

Shouldn't we reset iris in this case ?

i.e. its a breaking of the software contract to have failed to have 
returned a buffer by - close.

Its not enough to free the memory on the APSS side as the remote end 
could still assume ownership of a buffer... right ?

---
bod

