Return-Path: <stable+bounces-152315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3527AD3ED4
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 18:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D9A57A4F60
	for <lists+stable@lfdr.de>; Tue, 10 Jun 2025 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B99239E60;
	Tue, 10 Jun 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgauDWco"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C633239E66;
	Tue, 10 Jun 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572860; cv=none; b=A6BUvVZ8pcVT2AVpGzUpio9ODTrtnN6yT83uAJ50aX4+KPAQQMzxnr3tUCCunwlW4qWrZQE3nzedNQubCW7HlspswMg2CvmrgHNriMwN3yQ/FDhzaOX5KYt5JvwMcvNU2Eekats79nGIByCxnEIsnWXM1/O/FqkxRqZx7dneJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572860; c=relaxed/simple;
	bh=q5pZXGzab5L7kIA5opntKbzztK0z+GseiREu1iWJWq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgivI0qlavbr5VjSkflc5/6kupjBAd7it4bgAt+ELTgv5TOIh2AqEkc5aIsnKCEQoK8trCFCobjcMvt/En5JDwoJnglDJrLe4lS+JAe4ZkanIgorKPyTDLHgRolbw9fKV0upfrNCjyJAFqPou1zlIpKB9Pp4l6ItYstdltMd3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgauDWco; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-235a3dd4f0dso39331405ad.0;
        Tue, 10 Jun 2025 09:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749572858; x=1750177658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qnpi/fv02jA2ezwHhPOatuvGODwDYoxXXaeEv1Eqd18=;
        b=lgauDWcopKT7exqPuMxRJM+PCC1E1i7Iu9RtxRHo2PHATxHRWNld0p6NYDI/Kb+Uaf
         ICCUl6N4D+zISNEYkodKVnIt835hSVwLGxxv3QYiI7UXnl52y18yrUOlCUpFUihEwFSU
         vYIx0/Poc3Gv+hpY1wYcT+tYQpGqJm+H21FjgZPwEydSDn9u5Q6o8o0ehBkc316d7PAd
         V7iJEIwHdW5YH2XfYJv8KX79dJ4zjNuSxwGXNPwRCAWHE6rRX/3ebO/ow/LIOGUxW865
         n+XqI36UDbLmrFh1RuaGXS3v5u4jtOAnJhw/177nSAfqEwF375lFhZCeYwCISNB24UIe
         i4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749572858; x=1750177658;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qnpi/fv02jA2ezwHhPOatuvGODwDYoxXXaeEv1Eqd18=;
        b=dmfDxJu0xT7uXNqGotzhChRrD4DlnsvN/bl7zheN8yPLPOAY4v5mZLszXi6f67vWJ/
         AED6acue1kQjwbbycpxHx3k06YXcLo5w2Rxf39par7wpXvYN3JL/tMyWcVtTxw2gShfv
         u8Kl8TeeYpGYuTfyAxuyU0wCBHuUb6xTf3zZKMVBx+7IH5TRCwh2B37S/l3crN70kAeL
         +lDBYS+Gs1rdI4IYotSpVMzp8l85PCwvz9iGbyPpw0Q6fR2cOm8nh9j3zv19+DJFFetJ
         N73h+iR+CnniRwYdl1b6Oq6qZKnHNKdMhBf0XssdScnmzBv91cAUu/Sq9KlIFTQq2Bvi
         dWUw==
X-Forwarded-Encrypted: i=1; AJvYcCUvOsHXbWjzwvl1dbBO3lbltiWflzEalgMGZ4z93ASXw4JDSdn4NA6mM5B2szxqFwEMgZg3sUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGEOIfm5rSX69KDridpRLRRCPDs/tQcuXp4u4OFWcHCBQV3UpO
	DSqRMCZX2jQ5AlAb9SldbGMeuTw3pm+bOUl8JBL+3ll77ZJzwKf2hdDKAtjX4y5r
X-Gm-Gg: ASbGncuaPRWIK0BFRaiFdk0zNryacYR2n5pE8r5t4P39b4TrxCBZG7ueGmEgKGnnUU+
	TfS2M5i6fasewmT2A2T8aznX7eLD1x8Ma2V56Lm60yYKqeqdA0IqlGZ2vS8C2D6qKU5hPinaSOk
	Agwyyd8wkk3h9fPTe3UablqoLAVoNtnnqaTqyZAWdz9J56w5WXOKm5eIBN2xzJEeXIEGGIcxJzY
	z/iPIt7kXmxhX/V+54OtcrIaJHj/pEsuHO0lmAGHB0TYcMQIaq1NIhNYoUBwdhrWFxMAe0dr3mZ
	h9/g/msTIGlJlp2me1KauXRfzDOh4hv20XFZPXa0oTdHQemaUPQ7fyVdJNCCWPzaRyIPmwwikT4
	h42jJ9p/o8ERwFw==
X-Google-Smtp-Source: AGHT+IGpTrb7cBzENw+NXQu9WEpfRFX/Vs8phwWjOLbp0a0gR9J1gLWGnXLnYRSegmtnjQjUu8xV1g==
X-Received: by 2002:a17:902:fc4b:b0:235:f298:cbbe with SMTP id d9443c01a7336-23640c87c06mr8388835ad.12.1749572858257;
        Tue, 10 Jun 2025 09:27:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236032ff2f7sm73338715ad.92.2025.06.10.09.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 09:27:37 -0700 (PDT)
Message-ID: <02e3f9b8-9e60-4574-88e2-906ccd727829@gmail.com>
Date: Tue, 10 Jun 2025 09:27:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Tulip 21142 panic on physical link disconnect
To: Greg Chandler <chandleg@wizardsworks.org>, stable@vger.kernel.org
Cc: netdev@vger.kernel.org
References: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <53bb866f5bb12cc1b6c33b3866007f2b@wizardsworks.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Howdy!

On 6/9/25 15:43, Greg Chandler wrote:
> 
> This is a from-scratch build (non-vendor/non-distribution)
> Host/Target = alpha ev6
> Kernel source = 6.12.12
> 
> My last working kernel on this was a 2.6.x, it's been a while since I've 
> had time to bring this system up to date, so I don't know when this may 
> have started.
> I had a 3.0.102 in there, but I didn't test the networking while using it.
> 
> Please let me know what I can do to help out with figuring this one out.

I don't have an Alpha machine to try this on, but I do have a functional 
Cobalt Qube2 (MIPS 32/64) with these adapters connected directly over PCI:

00:07.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr+ Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 19
         Region 0: I/O ports at 1000 [size=128]
         Region 1: Memory at 12082000 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at 12000000 [disabled] [size=256K]
         Kernel driver in use: tulip


00:0c.0 Ethernet controller: Digital Equipment Corporation DECchip 
21142/43 (rev 41)
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B- DisINTx-
         Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 64 (5000ns min, 10000ns max), Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 20
         Region 0: I/O ports at 1080 [size=128]
         Region 1: Memory at 12082400 (32-bit, non-prefetchable) [size=1K]
         Expansion ROM at 12040000 [disabled] [size=256K]
         Kernel driver in use: tulip

the machine is not currently on a switch that I can control, but I can 
certainly try to plug in the cable and see what happens, give me a 
couple of days to get back to you, and if you don't hear back,  please 
holler. Here are the bits of kernel configuration:

CONFIG_NET_TULIP=y
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_TULIP_NAPI is not set
-- 
Florian

