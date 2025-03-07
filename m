Return-Path: <stable+bounces-121334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B18A55D14
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 02:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD2416163F
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 01:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBB314EC62;
	Fri,  7 Mar 2025 01:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Hnlm1fG3"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214063BBF0;
	Fri,  7 Mar 2025 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310806; cv=none; b=OCLXPmVECtwR5+MRd5TDlXkqU9iT/Q88X7lII7QtorglzhaIrKh2baYCUhi46W5s00Bhn6yoeZHilvvOCw6Dht5tr/p3mqA4Rad39CrDvaHhmqmUWjtSghdrfCJ7Yt34Lrm8L6yykY4AXA0m85f0M+BJDAH+NUJv7n3B34Rq/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310806; c=relaxed/simple;
	bh=WaKsnKv62GEUgnh49NOpZFJt/lqW92ABA9XWVmhU2oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fd/zw5Mr6Wk2HxnKa9+exM3ev4S3/zD7CPatxH24yWLjnMBX0wzDuH2O++xk6n4Ip82yLztSLoDIYdNMmDnIOW4xeB2alSt/3uoLYa+yBVRtwcg9A+YszRZD7/BFOna7TTc3AJhmbJBj43FXzBxJI0t+kaPo+RGldNhuucf4Iew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Hnlm1fG3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912c09be7dso803412f8f.1;
        Thu, 06 Mar 2025 17:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1741310803; x=1741915603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzAe6BCnu8dMT1QibRWlPYxwJFiqy0HpiikS58YVRo8=;
        b=Hnlm1fG3HsXWIREWq/jUllUrSqsupuHGelXqDH9uiybmRvX0YDYDF1GfM0TjftXVVb
         dG/FDRESI+U1Xx2G0jiHoh2hmbR8oweHUzdeSJfO7OfULzzrlQFFsb95dvRWaigExA8h
         of8HHhROkvXX+ek7NMcrrbCgNgo6mf+boX7xy35doOoT5ecfekhIevjzM4lPa1+AAl91
         4Ih138N5C5uPMkE7iOjsTuaZg1QL67KHbJ0W1cjt4tpXPazcefhZEn7lpRNUUTrdBDF9
         xKOLNfCjt3c4ornHpLzNxyc/vCQrg0ZJ53+8uJdf92Udt50wDipOykTKBLVx7Y73PZO2
         qXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741310803; x=1741915603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzAe6BCnu8dMT1QibRWlPYxwJFiqy0HpiikS58YVRo8=;
        b=mrtQf9gsqnJf9TwO5O5woqoL3CEaSqeCE0I91DY1gzQ27B+wzb+Xyg23w8eqk96yYR
         R5auS1VJvQW3DqgeGe4oiyCfEwvvv+uxsKS2g/3QzdALnILx4Kg2SsBcFLFVAIfSC1pG
         mZMwUzE1xqPVaBexVEfLQj1Xxg1mqF0Bov2XUJgGzQ54uZKEN/Im5SIBkVRiatXr0usm
         N6TCbbCGoS6qRdS1NS7/A+jt0zJq/nwp+n8AS/MTDSLHlotY2IJF5HfTq/Q9a8LjsZ+7
         NOTgJddIf87o44103B3zfWa051yJXMQ+PE7Qwd/sgkmX2PRsYDRrmYH1y+swKmrEaNte
         6IVA==
X-Forwarded-Encrypted: i=1; AJvYcCWf24YsvvpOsi7BvgmPkotN85x/ZrHKXMyndg99+aCrbQiE3FjnjCHomuWKt0XzslkEmzKUCKHJ@vger.kernel.org, AJvYcCXVSC1jGlufwqsDBxTlf5h6zeoggN8xSmnEqJKBIk5RDmoOqamgYyun78FG0XnZ6lz32H+ajvXVPrxVU2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaGq48y/RTJO7o2NmFYoqrrEHjJYOAwKBY9kBAL2iiQv/RvXPc
	fd5E38UTPy17J44zxRd+l6F0MLU4yjhhks/1U6cJ7nkFPHmt12o=
X-Gm-Gg: ASbGncuyJb1aCi3WKXTRfzOSfWd6zeF3HoeFQfSiRNY8jeCHjUFF58PbT/T63YImOXV
	buNCVeTXzkDmy3YDL2s1USd/tKR13t3VAEoKUrM4P2ngVMXep/+BKrFvyVLL5Kj5MSxusP2Sv8k
	paancNOwPmighexvaIr7Sl+lAI9GPM1hklTEZeCoUGJe4BnkbWNfu30c8wZIqFKvyBYpLdmB7kZ
	M0Kml6V6/LPc4tpIiaRT+VfPU1WlNiYf5D+T0IWoB7IHzsbHp42uU5dbob4IR/XOobPyPTh/JLa
	s39C09+sGThyoXJF5wsGhPZQUnJMZC8bcwu/vuO6jbQNdWb0c5901hl5lhOV4Ax0MOcsgFKTvEs
	eRUD17Y5UhZanrYlmR7ss
X-Google-Smtp-Source: AGHT+IHFoUP63tnjiZj2HPn04qVjNBUg6jSXQlAGaY27VGgqn/b9aJRQPxBIeV6aadYlzEkhCjUN0Q==
X-Received: by 2002:a05:6000:144d:b0:391:2e58:f085 with SMTP id ffacd0b85a97d-39132dab192mr832676f8f.54.1741310803136;
        Thu, 06 Mar 2025 17:26:43 -0800 (PST)
Received: from [192.168.1.3] (p5b2b4f54.dip0.t-ipconnect.de. [91.43.79.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd6530f26sm61732585e9.4.2025.03.06.17.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 17:26:41 -0800 (PST)
Message-ID: <e79334b4-4bde-4995-8416-e2742f36cf47@googlemail.com>
Date: Fri, 7 Mar 2025 02:26:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.1 000/161] 6.1.130-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250306151414.484343862@linuxfoundation.org>
Content-Language: de-DE
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20250306151414.484343862@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.03.2025 um 16:20 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.130 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Just like rc1, rc2 builds, boots and works fine on my 2-socket Ivy Bridge Xeon E5-2697 v2 
server. No dmesg oddities or regressions found.

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

