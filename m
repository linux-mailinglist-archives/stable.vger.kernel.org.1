Return-Path: <stable+bounces-33020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE9488EE58
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 19:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9961829D50A
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 18:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6E2137C2A;
	Wed, 27 Mar 2024 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LynwBi7K"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D3339A0
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564538; cv=none; b=dxNMNiWUKWXXL0jB0URwIEiFINFsqCDGSeT1j9MtYFREbzLN4GDGCpCnXXPEmTayD7YcrIMUCgc6g02uemdujEH7I0TEnKXWJG+gxlMTqQ2Yto2k1EEi6K9LEaeAZ26eXNKcgDOZtvxFg2gATtzhoqM3jDa2zlTA0duM6YAy2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564538; c=relaxed/simple;
	bh=5HXL6NCLstp6EMwWQaPu+LrS+qSVstlJP6Tykn6vC40=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=EGc8w1oOz+tMegyocFMggN0vHI0hjEXWMhQFJ6QxHHlZYeIDVUebC0A+2JtW+qAyjVCfjFR4ELOk59VXKJGNaJpk2spPVWDiQ8X+xboxYGnHDfY1tM9gDXppHuADHdoG2f7oRQzla3aU/Iq+l2Qp+Iwk9KxtoXkBVHcsVXAtR8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LynwBi7K; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a468226e135so16234966b.0
        for <stable@vger.kernel.org>; Wed, 27 Mar 2024 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711564535; x=1712169335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkUbN4TAD+oOYBJfnzJXFKy738TCZCTNAGWUhZK/Ujs=;
        b=LynwBi7KdQQ/MskbEKjEw5rXqqsdi49oFKceYZsbiWrlJyocxqEap57eYohqTK3J1D
         yGQTca6kO+l7IdFJX4mlkROCi7wmhfdGss3C1alvwBUG24dFsLRAnk2mM1fHE+1mpBTw
         1O5vUEcmMTqPuu2TramvBnaUXEfJYylf65KcRiIqMUPWdQSdm9YiOvFOx7VjcRifa+XG
         pEh/IUKkhoKFw77Bne31UHyNYsaAqrOgvxw0fDFY3G+XY12OiACwZGjwgjmPjPMfjZQF
         mU/9VcjjxwUGsxzsxQhFrAACD5NKu1OX2vnxEqnotoX3e2GJIO4BAkKHfsCFX/Mi5GyN
         G7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711564535; x=1712169335;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VkUbN4TAD+oOYBJfnzJXFKy738TCZCTNAGWUhZK/Ujs=;
        b=NK4XiUdrF8Ns3Z5XGf7Pvn/yd5swrn7F+K6QYBqbZ7Y+K1yHTn+iN00/h4LyeYuLOg
         ssbCFqIwMhK5/5CPuAYwmiFrQQ1g6aEE/6/b612cF3yDu/F+YheGb8bJ8eU/4ka62MP3
         8Y0dhX0hclWFXpIIxG2HMvwEaofKuOjVyt+6z0tehKUx9PzWeSRp+FAdEvFLkiPoZV9E
         3LWxH3BDlk8eYUZNJikXIgzssv9qDVbY73Pc+xFF+VlM3vMParzhFiKiXxqFXOJY6Ii9
         1Nxcyeds14hvZAqHIXyketMvMPklIQxXr4bbQ7WltZBsux7UfsZJUnjkd34iHR1DmD1M
         1/qA==
X-Gm-Message-State: AOJu0YyG2iCfi/qQ/9eIg4IaJHYbL8oDgBbv2RIWgCGXBV9NVsHXr5fI
	qZrbGgrAStcMRp6Rfjg+SoceWjOn9JE0oQqz4A8eQGfyvagU1sWZ6W71fxcMAQJ/Tywy
X-Google-Smtp-Source: AGHT+IHTZtWhzb+avF5lUBup5TotJMsj4NY2HfdGv9G5tsBDoYgK5j6nc+qH1LkoNFC2DpjKVPyzRg==
X-Received: by 2002:a17:906:c7d8:b0:a47:31db:d8ff with SMTP id dc24-20020a170906c7d800b00a4731dbd8ffmr212288ejb.40.1711564535129;
        Wed, 27 Mar 2024 11:35:35 -0700 (PDT)
Received: from [192.168.50.7] (net-93-144-80-247.cust.dsl.teletu.it. [93.144.80.247])
        by smtp.gmail.com with ESMTPSA id q7-20020a1709060f8700b00a46faaf7427sm5718524ejj.121.2024.03.27.11.35.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 11:35:34 -0700 (PDT)
Message-ID: <1b8a991b-ad82-44e6-a76d-a2f81880d549@gmail.com>
Date: Wed, 27 Mar 2024 19:35:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
From: Luca Stefani <luca.stefani.ge1@gmail.com>
Subject: Pull ASoC amd fixes into stable
Cc: Jiawei Wang <me@jwang.link>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey stable folks,

Can the following patches found in mainline

[PATCH] ASoC: amd: yc: Revert "Fix non-functional mic on Lenovo 21J2" 
(861b341)

[PATCH] ASoC: amd: yc: Revert "add new YC platform variant (0x63) 
support" (37bee18)

be backported to linux-6.8.y?

They're improperly assuming the 0x63 variant is part of the Yellow Carp 
family. This causes the microphone input device to not being properly 
probed on the device.

Known broken devices: ThinkPad P16s Gen 2 (21K9CTO1WW)

Thanks, Luca.


