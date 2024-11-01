Return-Path: <stable+bounces-89509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451CC9B9719
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 19:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D72281F0D
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 18:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D21CDA3C;
	Fri,  1 Nov 2024 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2wKpG88"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1241CDA27;
	Fri,  1 Nov 2024 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484465; cv=none; b=Am0ZUs51OKpinQJ9arpsbW0iy/rUEiy1CTiAFdkUU55Y6czEC6pCAbXlL39/zWAKAkY1Iw5t7KllFGAWDjzUbwxBPvzLXXE/F0r5xZ2dTA7jVZSaiMcwAXNDtzortqRxlbXc+EL6wOcppVzVA32I9R10C44J5BHMqZmfa3BzMHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484465; c=relaxed/simple;
	bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:Cc:To; b=f4u33muNSuOUb3YTcPh2CCT1M+OVB8xdHT59LrIh/Xw1yjZNT3qWXqFkurxHM0+LDTUYKPdNXY2Y6RFEUO5DgxVVCCezDhqxf+vUzzCPGf7I/ZijOziV+ubIWKXuvnLM9/ar3J0YKEWj1hhyJBWkaA/jSl6xdzQqHqJIZDU3F7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2wKpG88; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a99cc265e0aso348052566b.3;
        Fri, 01 Nov 2024 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730484462; x=1731089262; darn=vger.kernel.org;
        h=to:cc:message-id:date:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=I2wKpG88RDQGuvx94kP0ySA7RO3v3ZLTlz+BMcabYqz4KNHqUiPSLdnsobnxC3oI9a
         1lRUi1rpzGOfk0jcFzqK0nnMNqLDDtdsQWBeqh2kinVIcUDPbkuIdJoUBA/Jv5EwPWk7
         lRSQ/WZZ4mNtcKdKOlkmGP2sswVex51euUUt785XklqllFs93t0XXaR7nRs/ypoMlh4j
         sunW/jW1O37VPAmbzMNfxaSgeughf4Jyqp5/u8NfHq+IERos3fdXK8HE7PndFxiZC1f5
         JGxMUUEYZuB3kKBp5xA6mS9Qk4EWVIoikKkm2a20Tv+9rSRtxH9iz9pzlPzhlev+OoYW
         gvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730484462; x=1731089262;
        h=to:cc:message-id:date:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=H2rjhZLfH5K2sFASxi7n5ByFckScIDKKZUGthx8YWHDVgJBCSawpJ01hl7phM9B4d3
         Qg6oSe/P/Q2zkg1cRcd2dzovY/V4jMuRIfC2N/d3MCT1zYOCyz3KESdL492rZftiKhtq
         FEb7xwjtxzPRNjK18I7yJ0lZcfpBV9NVg8oQODHBaQjdW2uazsH2zQ3Ze4oJxXcNcfRF
         jvbs+hGW9QKJcL6TsvQXqrUKTSKwO1SDWMCo2kRiHPoEtV1VrUv7Vir6IMaoJLkkn6Yg
         jR8F/F5C0u35Jna7fWH72V/BnfT8Z8Z4zY3H7VazH/2liXrshIRyuEcSe4kV+DAZBrtU
         dkRw==
X-Forwarded-Encrypted: i=1; AJvYcCWojaRg6VBNC0LpNq/ekOThLo1bQq6kXYL4gST4TxrV8d1ZREcwDqmIvlZe4dJfylzKgue9bjxRWSrcF44=@vger.kernel.org, AJvYcCXXXDpsBFtoAeWXeRxgbO0Bcd6gPv3WwwDDcewrpvy4WxpG9lmjfb7tyJbVSPCksa5M4ijfwXt5@vger.kernel.org
X-Gm-Message-State: AOJu0YzzTMaoqVXUUUxDfCkElP9Q2MqAlpPdIXc+Q3uHVFHKbITzuXq8
	7UIUZi67cId6VBAArYCasml+K17X+7onZcNXvgtgbu+qzPzXmYl/
X-Google-Smtp-Source: AGHT+IGIND0a2w6FiSMiKhuFQgaTuS9zBQtQXZDnUefy8qn1grI0b0CwYI+KoEZhLJXD0lzwYEpKAQ==
X-Received: by 2002:a17:907:8686:b0:a99:4615:f58c with SMTP id a640c23a62f3a-a9de5d6eb9emr2496049866b.2.1730484461854;
        Fri, 01 Nov 2024 11:07:41 -0700 (PDT)
Received: from smtpclient.apple ([102.209.109.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56494052sm211690766b.29.2024.11.01.11.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 11:07:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Ivan Fay <ivanfay99@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 6.6 000/213] 6.6.57-rc1 review
Date: Fri, 1 Nov 2024 21:07:39 +0300
Message-Id: <D1C54175-3397-4EB5-9130-8D4889D4818D@gmail.com>
Cc: akpm@linux-foundation.org, allen.lkml@gmail.com, broonie@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, jonathanh@nvidia.com,
 linux-kernel@vger.kernel.org, linux@roeck-us.net,
 lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev,
 pavel@denx.de, rwarsow@gmx.de, shuah@kernel.org, srw@sladewatkins.net,
 stable@vger.kernel.org, sudipm.mukherjee@gmail.com,
 torvalds@linux-foundation.org
To: gregkh@linuxfoundation.org
X-Mailer: iPhone Mail (20H350)



Sent from my iPhone

