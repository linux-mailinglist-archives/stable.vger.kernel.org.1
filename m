Return-Path: <stable+bounces-152601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D94AD823B
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 06:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFBB17F6EE
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 04:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21B4246791;
	Fri, 13 Jun 2025 04:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qgFb5GSz"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467792F4333
	for <stable@vger.kernel.org>; Fri, 13 Jun 2025 04:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749790721; cv=none; b=ZqkJEiSY/zSOm2oIW5t+WP95l8Z+XN5qGzuVPTbDSUT0Qy7lcWjmqqnufUNBYG7mPC8yB4jS492qtLqOQDgQJ604JI/8yeBqowadhleCwS9ABEbRTUpBypLvbdTV0bNf8ag9hUY0pg7BRM7WUlIS9790TlM+Z/jRwPZ9z8EpsOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749790721; c=relaxed/simple;
	bh=Wesaa8VNA4Ubt+y/N1vt5Pqot5XvDgiOPDgrALDlj0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AojcgunYIKbi9ONGseMdz+t/TD2tt6bFulW6HArAjmyNDajkoChbhfzis1OvUqU7r8lSGSm3qtiS+/pSrJBP66M49dX7O0KnGjIo26eotjFSHPDZXbYTTcv437mKCQi4RAG+m/1X27JO32E29XKFqu3bPLxkCQj/su4aBaCW0BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qgFb5GSz; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so12890985e9.0
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 21:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749790717; x=1750395517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+T8+BNeLHVuyhQQdh4y/PB3afxUPghJX6G+TJfvU9E=;
        b=qgFb5GSzbYMeijgvF1gw43lBDu7cvLInhfAnXPz0smyv1wIJY0lfneh5KrSJAFWCp6
         ryKNvLXKkKp2uw3e4neV/uytMbQQIzQ+PwfRZujvF78CVN5xzIfn4va7UgRT8ntCumib
         U2W20ow+YEKJZ89gJuoDz1bdQFEPXdsp4L38tWxK0w2Y3XQasf6BQgJ3R02AGNjz7xE9
         nXySHN5BEyUeTAsQ5evvFh2zAzBuC6dlmYnH1x+DEbTXtPWoyoYxuogyBOpaCASAuIKI
         FWrUlqbaWyKnNlm39dR3lnX4xHN00eP1wdIYwEJQwXdrs518LVXnpOGhJjQra/+8hwQF
         HVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749790717; x=1750395517;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+T8+BNeLHVuyhQQdh4y/PB3afxUPghJX6G+TJfvU9E=;
        b=rLLf7H98+BcaaZssgZHIkWPtlR+Ft5/B6N0AtIAUP3e0/pgR+Yg4Yudohz5oyBU+yK
         1zE9FsOii533WZ5Pt+dhvK4xDm/bjeOYZObdob6rIY+lanlZkmRyDwF/xxe3bgB7M6Zg
         r2nCwP9zjSzqhs74z/VhI/MzybWebONkwUKyt5eAUQSneejAaRsHnAEEzP2rMGKs6RoZ
         5GPPUo9hlVQx9OXIGIVC7Qz1BEBLXWGRPBZqhSObGk9bsYiLhljmVIfx8iGj+e+LBbKa
         LX9ogC0ohKnHDDDFmRazrv0AKNoRijIPfOH9+unCkyB6skqZUOdmNgaDqn5CGaWZVC5g
         1dwg==
X-Gm-Message-State: AOJu0Ywrt8tyAcJnzdfgutiPhCnaP7reyGF9kdZo0GDR8EQF/1PHCA7j
	Pc76zPFUYpZEi2dxBkO50IiieAIhMxkF1KOHaIFFiPPYGHiTGpiFzMQSONCfsD2kCss=
X-Gm-Gg: ASbGncuwW2dQJGi4p7wI1oBq4R1GlST43PyTUyhBNUwIXQqxAQDRdTEzxTFy18D2+WR
	zlqlGH/N3UWgOgIoLsmCg24IFT4erEA8FFZLzxoexZkXDjqTt/a/AMhIzGF7FM1+nKprUZb94Zm
	L5msUrKi1bpePotQpnAtbh8wlbu42IuTcJDxf0UGd2Nt0HwBAdXJQ4BtOXY/QZ4HVo9K2XZ/zcD
	4i71BkQDaaWqkNd9HK4/nU9hOgVUUNdevs1T93wp9MkDP00RPB/sD31pIBT44GQkYh473FMu8Qm
	IfZKxExbDfyHJZBzdDRHWo2ZWFPqPKhdIzRfcA0iF4cNwQxkZjqqRhLh5nnGd5mSCwnjVkRzmQQ
	aePI8vA==
X-Google-Smtp-Source: AGHT+IEg3YVEp3Pwf3jnLxnku0Bq4liGi2hQEdQ5JrlR6bVBM4reuyGsu3oWruk+WCMv8uUVIYfKSw==
X-Received: by 2002:a05:600c:821a:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-45334b63134mr10775985e9.22.1749790717242;
        Thu, 12 Jun 2025 21:58:37 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a53f79sm1172893f8f.4.2025.06.12.21.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 21:58:36 -0700 (PDT)
Message-ID: <43227f48-9d0f-4798-92d9-a1ccc497d37a@tuxon.dev>
Date: Fri, 13 Jun 2025 07:58:35 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Backport sh-sci fixes to 6.12.y
To: Sasha Levin <sashal@kernel.org>
Cc: linux-stable <stable@vger.kernel.org>
References: <6aa4a135-eb89-49e0-b450-7fa30d7684ee@tuxon.dev>
 <aEsqctMnzUfinUga@lappy>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <aEsqctMnzUfinUga@lappy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Sasha,

On 12.06.2025 22:28, Sasha Levin wrote:
> On Wed, Jun 11, 2025 at 08:23:54AM +0300, Claudiu Beznea wrote:
>> Hi, stable team,
>>
>> Please backport the following commits to 6.12.y:
>>
>> 1/ 239f11209e5f ("serial: sh-sci: Move runtime PM enable to
>>   sci_probe_single()")
>> 2/ 5f1017069933 ("serial: sh-sci: Clean sci_ports[0] after at earlycon
>>   exit")
>> 3/ 651dee03696e ("serial: sh-sci: Increment the runtime usage counter for
>>   the earlycon device")
>>
>> These applies cleanly on top of 6.12.y (if applied in the order provided
>> above) and fix the debug console on Renesas devices.
> 
> Could you please take another look at this? The first commit applies,
> the second one is already in tree, and the third one conflicts.
> 

I double checked it and applies clean on top of v6.12.33:

039164b1a5e4 (HEAD) serial: sh-sci: Increment the runtime usage counter for
the earlycon device
6a0ed6d47c02 serial: sh-sci: Clean sci_ports[0] after at earlycon exit
a25aa21fb6c3 serial: sh-sci: Move runtime PM enable to sci_probe_single()
e03ced99c437 (tag: v6.12.33, linux-stable/linux-6.12.y) Linux 6.12.33
80fe1ebc1fbc Revert "drm/amd/display: more liberal vmin/vmax update for
freesync"
d452b168da17 dt-bindings: phy: imx8mq-usb: fix
fsl,phy-tx-vboost-level-microvolt property
1ed84b17fa9b dt-bindings: usb: cypress,hx3: Add support for all variants

Would there be a chance that you have searched the second commit in 6.12.y
by its title? There was another approach for commit 2 which was integrated
then reverted. The title was the same. Grepping on the current 6.12.y gives
this output:

> git log --oneline --grep="serial: sh-sci: Clean sci_ports\[0\] after at
earlycon exit"
fa0e202e23ff Revert "serial: sh-sci: Clean sci_ports[0] after at earlycon exit"
0ff91b3bf53e serial: sh-sci: Clean sci_ports[0] after at earlycon exit

However, the content of the reverted patch and patch 2 is different.

If commit 2 is not applied then commit 3 fails to apply.

Could you please let me know?

Thank you,
Claudiu

