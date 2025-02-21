Return-Path: <stable+bounces-118571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6EFA3F358
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 12:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B433B7EAD
	for <lists+stable@lfdr.de>; Fri, 21 Feb 2025 11:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFEF20968D;
	Fri, 21 Feb 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="b9WQwj1U"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941721E9B01;
	Fri, 21 Feb 2025 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740138656; cv=none; b=Y2r1WE/BF7BVlolfhaRDjj8Y0kViP19utRINr+Kb2wtl+zi1SyHmGq6PCK18stTxFHyZVoDVBtL8bsTkH22aUrhqk8qnIMUeHcZfY6wdjILdcihtHBoNkPtItyarZoG7lRLcY895WaSD4xjG/07DKoWJT1mtow+DaiyegfToepM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740138656; c=relaxed/simple;
	bh=4iKGjyET1laEexqZtbAZOOQU2sFeiufZBXLJZpatY10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCmd6J7gBpOX2QQulhbFcH13GxcjafTM+6WopJzHhsMscHYfZVb1wHe3EsM3ZZnPgp96uwigi2ta09ixPzbbAWwVbQOqFq/LxZdg8v6Ga9vPvX/02tCIDU9UD2zyHh8/ZcbxvRrBhSBbiowrMhxdqE6kmrSgDuIbL9odRTbq0zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=b9WQwj1U; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38a8b17d7a7so1088333f8f.2;
        Fri, 21 Feb 2025 03:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1740138653; x=1740743453; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DCetbYu7M/r5G/cWLg8Lx6IRcaQzJ405eRDRSC8isck=;
        b=b9WQwj1UOYdQb5YimVuDLkmp91nLstJY9MlIbgrmHAEIoIEF6g6oXH48IAvHf0lfBa
         XZ2Hyk5L35+M7hJT9JQ0+BkYqGEQ6fZvN8D9JOhQEZQifeWxKC7tlJHnvUQjFPGxjSWA
         DOugyszJB/jhQuI13RADaDEr3Sttf8sUtaWo2F60r4QsyiVmaHoX4xExx6qZWn5YAF7g
         wkdhq3tNDkQOfiGnAzHKx2XpJP8JSNxTiyLpTybpeHqPUNvDo+iV8UWMOtA1a3tb6q7F
         7L0OA82VnEvai59CuILLctwRlMSRdoFBHfM7pTNwfCBfPHZNWWFlxzkYj4hbQfScDSq2
         /1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740138653; x=1740743453;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCetbYu7M/r5G/cWLg8Lx6IRcaQzJ405eRDRSC8isck=;
        b=sG/Cz3KUlDuY3gz71kv2x7K5Xxxr7vnQ5bkdmKvyZsBO9Y1ykvy74XNziCXg0zSylm
         qOA25Ol0bYFKaBuDE28CN/jt5HnwFWi8NPUrUrQBUZM9TW53peDXlXWd9EuX2R8o+PI8
         +2IEtthfzqygFvSJxgdMrq5BXZzjEefHwhD+F1mbvYJh80Xp5eFyvK4tPoiQBrnMODAu
         LI+FMefVLrwv1iwMWxbDSVzQBODYs4UXm+Z31akXUpDR2/votm+W1b/3Qza9Kj2I8/Y7
         GOJ+ZMHbzAZTcfpXvnL/sKUzHeP5PwbvB0DbU21PKp1O7CxP1syyPp1J6qRB6bjaHlZs
         lFJw==
X-Forwarded-Encrypted: i=1; AJvYcCVkZNiLN+veu4or+tNIf/Sv4IH0kpo9pGa+pieSvQtpISSkseH7QqCm1ROBMyVzS6Eax3lemO2C@vger.kernel.org, AJvYcCWubBsc/bxrptGac1j8d7bkOpKzO3K8vUyJy18CQimZnmich/x43SDiFy6tyKVFntQaXKkiIIvAhaJJb8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1nxQ3MkJNhbhhyNzvAMopYw0EaiRT0j21Lnwwiv/hui20r3Zo
	w9E1btcfemXo4UyooRZhN9zct4BPtSWkg3bAc/QcBLbJRnaL20M=
X-Gm-Gg: ASbGncuHjwwWni3k3lKRZOGjAhmEIDEttqpImV3HEibI7kJRiHmcxZjI/+ivmxdLrrX
	MStTsP7GcwiTh6UtIS3mTkU44LgvObhQ2rkh3yjbKvaqwFdLRMeYunEsLIipY7CRahclHpZJVTR
	jpdFHLxN30EQ6uMluSB66i4KLNaI9EXFVusOEEsh2gQBES/Hi0Whd2FFL+0HPCuJQD+we2taWJa
	YCx5GLhWeJl0AkX4Svg6Ib9Cz+Gq/lDOn+0TmErQ4uCR85BtCWe6C+EhSnALooUBmjMI+QISYP+
	ghpImFsDMTu/WqK70OR9HTy0VZmXrF7MGhdN6lv2v99gq4SEGiex9hX9tPT6NuycdoQyivycKlI
	lAUo=
X-Google-Smtp-Source: AGHT+IHderF5dL8n18p2RisusD5mS+o5hF48IgFJWXe+lSEDsICJsZcv5gmaeGAv2kReqDUuV5QHNA==
X-Received: by 2002:a5d:598d:0:b0:38f:3c8a:4c0a with SMTP id ffacd0b85a97d-38f6e7539b7mr1651006f8f.7.1740138652774;
        Fri, 21 Feb 2025 03:50:52 -0800 (PST)
Received: from [192.168.1.3] (p5b2b437f.dip0.t-ipconnect.de. [91.43.67.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b44a7sm23540504f8f.12.2025.02.21.03.50.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 03:50:52 -0800 (PST)
Message-ID: <370446d6-6668-458a-a472-e7c1595854a5@googlemail.com>
Date: Fri, 21 Feb 2025 12:50:51 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 000/225] 6.12.16-rc2 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250220104454.293283301@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250220104454.293283301@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.02.2025 um 11:58 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.12.16 release.
> There are 225 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 server. No dmesg 
oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com

