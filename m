Return-Path: <stable+bounces-38010-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D75D889FF4C
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 19:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65267B264DE
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 17:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA8617F38F;
	Wed, 10 Apr 2024 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QbQ6q4AG"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4EB17F365
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771925; cv=none; b=iJpct0fEW8QO/5ItrxPzFg5ZFkzJaQzep+nIJbo1Zd14NprVGzRifbnfdtho/rbgqy8eC3eqN5FgtqSJrM4RSa7pA+qux1REDa72qWVXu6tgFLXCjsB7bnUjGxoYwTzfwykq3SgZ/w6Ujq5nL9hsvpZWEdnhF+2u8bM2ahkgYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771925; c=relaxed/simple;
	bh=YwYXMXs0IVxwk6DATVGOErw+hkjBmJdEIaxZBT6Ct/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JcsDyeuyREolRuu1bzgfdl0Y4SPvbU43ZXraf0giol2rxIpGV3NngHMkctoXFmMHOTUN3kOovbwf/D+uco4Dr3al5CRHoL9LEDNaOBym3UqVPX1J91jJb5jiKXcO/oFo9T5e3l4Fqif3jsuRKgXTzvJC6lg4qLMc4m4PAtG1DeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QbQ6q4AG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d87660d5dbso50383041fa.3
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 10:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712771922; x=1713376722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZfESw/9OR2lnetOyNgUHG3OZQhlip53uNIlAUytWmY=;
        b=QbQ6q4AGy+czhv78IqIaEbpMIYYhRPBH2y9EcMBgYFQuV8FUPn3x/aiNyizEJn+3ZW
         yHrIN0uvPyx2vevp7g5KS8V4qyB6PlHOzGdsYdVr6EKY3dG1eL7QnG1mVAF2whELEyOI
         7jVmrwEa7Kd9uqUmFaaauCicRvC+DqPBzGQoFPUyx3fg41nu4auFTJrQZGmfYkN7B5tg
         x8arWIg4zcG5OckTVT2xuhcsTDWSo5mCQW3kAD7FoNDydPcug0Y/LIobDhPNm0lCJXYp
         viFrLxoVMjd5+KiVLBQKh327madBm5ok0xQTI3VArDb7cLSMcZ9f2Quax0ICnoXaIfCx
         L8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771922; x=1713376722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZfESw/9OR2lnetOyNgUHG3OZQhlip53uNIlAUytWmY=;
        b=l2C2xbXo4fxFrlQ7V9MKpr6/ucAUOlHWRQ4q9qGJnzzfwBxhgX2BpUJGnw2Dt+ZW7x
         o3FawapaCqIUe/V3YgGeheO8ENglsU+SjN47x4emXl/2pJAoJwjYJzTEek/0mmdpgbNc
         8Rd6ZbnDT3yc9p+Lw9PrydEO4n+T3eywqir4SNwwwFX6n2aMXqagaXrHmZypqWOFpqrW
         WwKioIVybGzxwu/6zbDkGGDa8UVZJYSovm6nxBAEVnwTDIwGNbaHecbnz5snvP4uuxSX
         KSxEgLdRxil8oGL8H4q/bRwjUAp+35MQvI93I0znqs9acB4wCDtCsWq3fG1x0DZ1HC4J
         ujgQ==
X-Gm-Message-State: AOJu0Yy9LXaKxo6+8MjxbBRlWoUoNTyskTpb8adGPEn/1zpMHsAfypj5
	TRqB6IhdsJVu+uucjvP3I4buFlyiC/Mw6odKwLMkA1vHhBhUoziK5wmhZPnNMYnoyQTATTPuHle
	ha0g=
X-Google-Smtp-Source: AGHT+IHuPz9eKSloG3aQH7ciBR5TQDfDencMS58CGvG0dkNQ9r6hcdHyVqXbSZfKVuohartThR/MwQ==
X-Received: by 2002:a2e:978c:0:b0:2d7:447b:c30c with SMTP id y12-20020a2e978c000000b002d7447bc30cmr2323385lji.48.1712771921923;
        Wed, 10 Apr 2024 10:58:41 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q10-20020a2e84ca000000b002d8ed1c8245sm37727ljh.67.2024.04.10.10.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:58:41 -0700 (PDT)
Message-ID: <e06402a9-584f-4f0c-a61e-d415a8b0c441@linaro.org>
Date: Wed, 10 Apr 2024 19:58:40 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S"
 has been added to the 6.8-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 buddyjojo06@outlook.com
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
References: <20240410155728.1729320-1-sashal@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240410155728.1729320-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:57, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      arm64: dts: qcom: Add support for Xiaomi Redmi Note 9S

autosel has been reeaaaaaly going over the top lately, particularly
with dts patches.. I'm not sure adding support for a device is
something that should go to stable

Konrad

