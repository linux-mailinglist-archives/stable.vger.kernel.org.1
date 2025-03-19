Return-Path: <stable+bounces-125604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A7A69997
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 20:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1C27B38D3
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B6020E704;
	Wed, 19 Mar 2025 19:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAibpK4o"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC8214226
	for <stable@vger.kernel.org>; Wed, 19 Mar 2025 19:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413138; cv=none; b=aXHWW3R/8dUzZqd5IFF5jE3z6tXpeIqO3OBwLOuo1zLQWp/+mfcU/cfWvQS8Nb7nV++sidikKmMnpCK2QdcmULCIeDENGE+lqdjJOT0vWdKpJWbLezUvOaD3OWhknx6OV2ZKx/pTmUy2nLVZyjthN0sEmClN7Z1GNS82y4sUkag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413138; c=relaxed/simple;
	bh=1y3R7b0DmD48U1jUhf7ZVBbYaQ7UOT8lO8Rx6BwuKDI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=j+FNyGHf/gNEZPNxYfdAkMo+vuMBic18qEjoTKe+R9lqyHeiUKMxPJckZiCINckqCX9w91O5CzhErRhSQXADr3v3WC+39VRMPg2dWJlD6ZMGiPvJD1Mvw+0rLwFuRNKm/Kr95NKlo/0CpiekmK1ru4hevRKQ8HPfsatdRPFbWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAibpK4o; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-399744f74e9so863749f8f.1
        for <stable@vger.kernel.org>; Wed, 19 Mar 2025 12:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742413135; x=1743017935; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqMsXA2Pn/x09AFHqyaJaU4cTDRogMIdyWPLzphrlQQ=;
        b=WAibpK4onxqdi263cLzJiw/BpWCT/y94MI9GCcXrI+rtMbTDALv+GdxtBhb2moKkho
         lDFuoldJ4eAJsXZ+6slxUxkwqaKtZOmoDQMVnaFM/ZUGm+g4NN6fiWjAW5FPj5MNscDS
         JZ52LNF5zUOKBhD8Q7plfGJl9RS5dE1s+VbD8NEMsNHz8WrZ0QhFccuuNacWnD8lHNM3
         MLDR4tCzFlcred8joFtiN3ZOR31LypA7cqRN7iIqEp+5zg2yLrnyX1dIp1XO1jYlSTrQ
         A1PPkSqvUaWUHZv0+4D+z6JAocBI9QK6bfFuye7oUUmjzzK3h6PV45xu/Bi1a308wne3
         ugnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413135; x=1743017935;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EqMsXA2Pn/x09AFHqyaJaU4cTDRogMIdyWPLzphrlQQ=;
        b=Oh4t/TFZcp3VlW5jelARzfiUBK6s90O1F7M67QJ7XxrAQA0rzbA0orEw3v1wgcTgwN
         Esb0u2ZdB8NPTRKkHw5LUpsLzgqONctnfw+0Jjo7zABMtObYDDB0zonWQcTsDGx/B5Ky
         +vJcGwMOcOOaXi7RhT9uneCJLT4Orx3QuH0QlJ3lwZ+4zVe7du9fShYYei91TpAsK4ef
         4a1SdUlN6Ctw7tsm0yR/ZLGvugO+Xw7oTChrvz0XMU0NPap5tT4fpFkiU34IjJXqcswx
         EXQDzD9dQ8I6v7HeQdDZS6fSMYX8iQUIhrr4Ug0zPAqr9AQhQQjGjAjmTS5bNnwkT1Tu
         X3BQ==
X-Gm-Message-State: AOJu0YweNyQTuaFB70xwqZEGRQm+3S5Q3StDA9HxueLFGG2faHsS0QPy
	FGxAppwO0v1iDpxsf+r6u0DG9AThHlzlkMsSsAmutIid383F/LtWRke2Iw==
X-Gm-Gg: ASbGncs8/B6D9VVzjAzrId1ZPD1e9B7HTZMxQ1jMo+lnK+Ozl3fXq2mkH06ylPv2noC
	rY2kx9y8JZTKOGcFPDXYnb7AAzH0C2yuaEYtT7p+izREpLV7coM4gofqEG8ho9axF218fwexvzk
	YNNjk9w/ko+gCUKfIvhOVbFWtbQDiKmynaJvatsTYo8dTazUXe5/y/TYst3xw5XlryUlB3+QVTi
	9/yN91+XbnaYjxjbyR6W4U94iyObV2r8WypREes+W9TIPxeTQ/H+SpFduFdaL/5S6GVsYWvJAKS
	neVS4/XV9O/V6fxWi63cWS9Tf85rgdQyO8xJrwq0bO/VHR2hlzk7Z1vcxJTbhd2aTpSYSTgsvRa
	d9f31P3Q7F420vQqzqhB2RghQFYLVVf5z/eX1Gw==
X-Google-Smtp-Source: AGHT+IFjNhON3VzKjJ/yRrIkI3EbjS7s8oGQsthAMacFWVLycgU9m3c/H7UFW0Bx1krt2a6Y93udgw==
X-Received: by 2002:a5d:6dac:0:b0:391:4189:d28d with SMTP id ffacd0b85a97d-39973af6867mr3680202f8f.34.1742413134541;
        Wed, 19 Mar 2025 12:38:54 -0700 (PDT)
Received: from [192.168.10.160] (net-188-216-175-96.cust.vodafonedsl.it. [188.216.175.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f47c60sm26877435e9.13.2025.03.19.12.38.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 12:38:53 -0700 (PDT)
Message-ID: <415e7c31-1e8d-499b-911e-33569c29ebe0@gmail.com>
Date: Wed, 19 Mar 2025 20:38:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: it, en-US-large
To: stable@vger.kernel.org
Cc: Linux Regressions <regressions@lists.linux.dev>
From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Regression: mt7921e unable to change power state from d3cold to d0 -
 6.12.x broken, past LTS 6.6.x works
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

There is a nasty regression wrt mt7921e in the last LTS series (6.12). 
If your computer crashes or fails to get out of hibernation, then at the 
next boot the mt7921e wifi does not work, with dmesg reporting that it 
is unable to change power state from d3cold to d0.

The issue is nasty, because rebooting won't help.

The only solution that I have found to the issue is booting a 6.6 
kernel. With that the wife gets alive again. If, at this point, you boot 
into 6.12, everything seems to be fine again, until a boot fails and 
from that moment on you are without wifi.

Working around the issue is not very discoverable. On my machine not 
even a hardware reset (40s of power off button pressed) helped alone, 
without going through the 6.6 kernel boot.

I think the regression was introduced with 6.12 and I remember having no 
issues with previous kernels, but cannot be 100% sure.

Similarly, I do not know if the bug is with the wifi card driver itself 
or with something related to PM or PCIe.

The machine on which I am experiencing the issue is an Asus ROG 14 
laptop (2022 edition), with AMD CPU and GPU.

Thanks for the attention,
Sergio

