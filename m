Return-Path: <stable+bounces-47594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B148D2692
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 22:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC3CB26B45
	for <lists+stable@lfdr.de>; Tue, 28 May 2024 20:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EEE17B432;
	Tue, 28 May 2024 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T899pEGx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3DA17B409;
	Tue, 28 May 2024 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929680; cv=none; b=s1f/5zHSCx8HYrXn6osFlAxspeKIf9YyBePl3ZW6AF2xokG5XxqDarPKkAFqgs3Hor9Axy7kSvplednm6xhVLVdM2oE1Q0SoEbmkD+5k45ug5n+CjxTKxwKV8XwiihMhtROIDvztLOY+dkI34Sq9iahznBYN5GBqZlnyQ8n3P2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929680; c=relaxed/simple;
	bh=iEcVS7kNwhO3HFB9CScl6vFacYu+gRoXrd/D5F+ZUUM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:In-Reply-To:
	 Content-Type; b=EeSMwIMVXbRZcTFpC5i+3455GV+ck0pOvk7fscDB3enHyaffRvGAc+CKxcVTTu/HCl/AfofmZhuJ68CUnwQRy0uoZBYlXMyY9rZ9jggspKyoLlr9+P6XmBWltWsB1irArQgwSovKvVMtvfkfB31Ix4EM51eJeAufAJKhiPytdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T899pEGx; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-35502a992c9so1376103f8f.3;
        Tue, 28 May 2024 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716929677; x=1717534477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6FE63oTYkWPlAI/9XHCPUmOHWIDgyDXFFG5HlAkfZ4=;
        b=T899pEGxGmAAghF+LXRCsHlCpjVYCI8XBjQ/8fKIBgku1OF/2OI1jdF67/xQjCH81k
         BX6FOtbxnvgOA3p167bc+8b/nbfZhD3JFW0HwPAInEGay/4oH3DmxgRQaRgVcj8Wpsv5
         G3yCjX/2xTWzoHG0HYXxzPyJU/48BamQK5og6mLTqrgHg7nrN8PVgoYxAz68txW8Vx67
         sJ/0X+jiD51IZ1W6zF2TnNnI6H1Zlq7etLoGRYDixwCLRyEtFAI3A5+OX/V3HVgSqJ17
         1HNpjetm+UccP3wrVlw14SsIBINyVfMiH++C6zyeP42tflHD/kJ671QhZNGg5Tl1dEW4
         gTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716929677; x=1717534477;
        h=content-transfer-encoding:in-reply-to:content-language:cc:to
         :subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y6FE63oTYkWPlAI/9XHCPUmOHWIDgyDXFFG5HlAkfZ4=;
        b=l/R9Ky4g6HZkMHsinXGIsFRwjfqtLiYovzeRO4pik08GSioonkDiE6kTWAwRk8i368
         iCGYTNFfNg9kTINt38yrIJLMo0MNTH0deA68MaDxXBtxpCqqVZsUAegTfYfZsvCKEeyW
         96Z8n2/USReAzQTA7/OkrUhq7VnLV2G1azESrCMXk7DaknKvSckBdM3zBWDzBkGCIi7M
         +9Vmj6IkacR9p6/tVQ+7gQl7b7GRaSaCyTanVZZtpWHNvFRSCtszxtPLz+gbG+ClYoUF
         +jwzGtmyxRpQxjUnrvnShaay+xst4UfckFdJx/I1YAJwVfG2+ccqUdehLt4etbRMwydw
         gsPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjudLa6FRCYKQo+wH4ZFMz8e3dLTw8965VtId6fKJaLZrP8gIM9Wc3TlwEMIiZazktetWG8W3pTlognl2oLxh8N11H17VCVknCJtL9/qqA
X-Gm-Message-State: AOJu0Yy674H4PtLvk978PRPaRedxoy4DGtRNA59nSBOhnPs1P5DX9XWD
	HSZocJdAPH3U9UbqsExuAFm1T4gyHuir/SU1Yfy6s24FsV1jYjMk
X-Google-Smtp-Source: AGHT+IHjFpmdzBHqUWc+Pqo+B6yRQMIbFlgbaMgYEfh7yVC87GyDVnV/XkxD6Xeb2MSXu/Gut4OMVw==
X-Received: by 2002:adf:fc91:0:b0:355:3cf:49ad with SMTP id ffacd0b85a97d-3552fe185b8mr11130763f8f.65.1716929677150;
        Tue, 28 May 2024 13:54:37 -0700 (PDT)
Received: from [100.64.100.6] ([179.61.241.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3557a08abd8sm12751917f8f.32.2024.05.28.13.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 13:54:36 -0700 (PDT)
Message-ID: <c947e600-e126-43ea-9530-0389206bef5e@gmail.com>
Date: Tue, 28 May 2024 22:54:27 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mike <user.service2016@gmail.com>
Subject: Re: Bluetooth kernel BUG with Intel AX211 (regression in 6.1.83)
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>,
 Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 =?UTF-8?Q?Jeremy_Lain=C3=A9?= <jeremy.laine@m4x.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Content-Language: en-US
In-Reply-To: <8e8ca7a6-1511-4794-a214-2b75326e5484@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.24 20:46, Linux regression tracking (Thorsten Leemhuis) wrote:> 
Well, did you try what I suggested earlier (see above) and check if a
> revert of 6083089ab00631617f9eac678df3ab050a9d837a ontop of latest 6.1.y
> helps?

Hello Thorsten, Jeremy,
I hope you don't mind if I jump into the conversation trying to help.
I'm also experiencing this bug (with an Intel AX200) and I don't see
any updates in this thread since a month.

I tried reverting 6083089ab00631617f9eac678df3ab050a9d837a
on top of6.1.91 and it looks much better: it's been 10 days, and the BT 
and the system are stable.
Previously, I encountered the mentioned "kernel BUG" at each boot, and I 
was unable to stop/kill the bluetoothd process.
Let me know if/how I can help further.
M.

