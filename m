Return-Path: <stable+bounces-194869-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52980C61735
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 16:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 686214EA14F
	for <lists+stable@lfdr.de>; Sun, 16 Nov 2025 15:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD6B30C379;
	Sun, 16 Nov 2025 15:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc6KKPtq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CB41DEFE8
	for <stable@vger.kernel.org>; Sun, 16 Nov 2025 15:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763305750; cv=none; b=m0qajYATahAp51V5U7auDHs7dy4miO+xI+zZNAsDgaWRdYH+ytzKWont6l00bkeHRA8Lb9cq+A7GFjJY04Uw9f5+692F42nzfJcXjuqFBf3oSxxguPWOx856PRrAFIJVbaxa/tK4DAyjmkKX0zFfiAw2K/+/NgHO2rykw96vx5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763305750; c=relaxed/simple;
	bh=xq8xTEaVyip20qvmaObDd4dfH1b/XchZRVgFrwvraHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1fYU+fe3ID7OW7uLqyLol1Y9sR2xDTw6hdqzFQ0NnyfZ1be3I70Kf56bZxmqp4Tzhzk1bNmqPCysjALDqtz4oaJQ3pa6Na9xMSCwbD/jBxZHXLnwx7beZ6nIGEkI3wSpS0xlLTnViyhf1aeUGcvXa+hncrA7ZPnSPxdzg5HeNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oc6KKPtq; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so38228605e9.1
        for <stable@vger.kernel.org>; Sun, 16 Nov 2025 07:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763305745; x=1763910545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvODb/e7qLsRFrmDWJkGdxSLjYJZj6/4elRLF1YEXuE=;
        b=Oc6KKPtqtYazDKDP0bX02uTJWmEUPOW6uAMkZTKj7Vpbs4AU7lWm09tFd9fgIPys9G
         itXJh6/j4rVJvnFALAQ2u3TuPdKSaolZeNtkjSwYj5H2xpQKMmjOnfeYC156eyxqRFJi
         OObe9pXTH1FMSBxhKhK0qZ+DSE+rAo6hlcDPVSBAWJlEvsJI7KkkXpBCM5xSBwR6l/9s
         MmlxI2DXX9kw0ToFDc1GEksUJDJ8pDOIl+WpaWm5vwyKMeBAqbnw2k8nRF/LuyvKmYR+
         pRhSCtin20ITF03WWZaQuPJpWXQBTvWKp4igxWfrT3yC9RCzcRnNcp3xzqoEHxojkU6/
         WGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763305745; x=1763910545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EvODb/e7qLsRFrmDWJkGdxSLjYJZj6/4elRLF1YEXuE=;
        b=nHDcYzcvsFe2CfvcsCIJ7u5xGRhtzem9Hb6ZxTpi/dj643lxKLqdFcMocTwQjiiQwp
         qPin2vFFnah198AJ+/ulKLG63f2z2pYIanhw2gOVogQwla3Bdal0nMvkPfEOWr9+IKsl
         X/P8OGtnPHmBaqK6OjXBNAAG1B4WitNXNTHRf8eOpQl9chUDwp1BbVh1hZbu/JBeBtKI
         iGY9xh8vfIjy+VoqF6Ge0OvAshXY9at7ZJtbMUofebnF1YOw1z7Z1xIYnUb9dy8Yil8z
         Bh6N9XugTEF9uYrBrw97XeSwPKwqGP4GC+UjuXtLLee/FB9NPvdJy+Mpc+bVe3P7OgK1
         TOLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW05K/hCWohebKpKoDDbaiuB6xeINcG6DdPp/kza0Fzc1JLvRLNu4G28kW60niSgNxoFTfpEZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy0A4FTphktkoGTvvvS95jmoaIjEmc2NutpUqiMmZuqkzCth1d
	W/pWRNmh/wkF1BIWggwnXaBZS5LMLiEe/20dr0DXE79h2RVBprpa/CA+
X-Gm-Gg: ASbGncvkTdSVrWvg7BQ0qIEUfQZ/dcQ2h0vrHPe4hqkF7UkJCoEZPoRpuiLAhNij74g
	Q0TWSRAxChNOK+pOPYdZ9BnlvizegTlmed1NcvoDR46bJQVgjOeOeAnOddrZ2blRqCSDadLHyuz
	VWjjd1pWAD1IfSrq7C321O2Ipb/53I6necTBgQM0t1ux8AUcrUg628YidlFbTHdL40TmjAvYQuf
	VLF+5R8Dg+WepI3a6+O2D0FHLWBqOfxGbXGgQUNHQLYOb7skZ+2J+KlYAs7rEhRDKPMxivQT9vX
	QvVXLQ3lEEH2FjZ2EhoV/GbeD6NRFui5iztckogJuOxBgOGMiRcKyF60CR//2svPmhgc3dX8Rch
	avJjoLRvjcxwxehNLCX/uo0xqr1oPsNKtPpKytzIsISilDH85iCo5PEQoUwmYtZP9R7I1gi1+xq
	uiJrLNrVnHfu2pBNRDjew4
X-Google-Smtp-Source: AGHT+IGMp5GTuzD+R9g6gkfd5sPc9gSs2a2eVt8uvtcAe/vzEoodhAs9XilhHcDZOUcO+nPtbyO15Q==
X-Received: by 2002:a05:600c:1d20:b0:477:7a1a:4b79 with SMTP id 5b1f17b1804b1-4778feaaeb3mr87055775e9.37.1763305745160;
        Sun, 16 Nov 2025 07:09:05 -0800 (PST)
Received: from [192.168.1.12] ([197.46.78.60])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779973ddcfsm83154645e9.15.2025.11.16.07.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 07:09:04 -0800 (PST)
Message-ID: <a3d10075-3ff3-419e-8231-0a1558195d0f@gmail.com>
Date: Sun, 16 Nov 2025 17:09:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: memory leak in dualshock4_get_calibration_data
To: Max Staudt <max@enpas.org>, roderick.colenbrander@sony.com,
 jikos@kernel.org, bentiss@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, syzbot+4f5f81e1456a1f645bf8@syzkaller.appspotmail.com
References: <20251116022723.29857-1-eslam.medhat1993@gmail.com>
 <ddb16ea8-7588-4c0a-9e34-6bd8babd598f@enpas.org>
Content-Language: en-US
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
In-Reply-To: <ddb16ea8-7588-4c0a-9e34-6bd8babd598f@enpas.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/16/25 06:34, Max Staudt wrote:
> On 11/16/25 11:27 AM, Eslam Khafagy wrote:
>> function dualshock4_get_calibration_data allocates memory to pointer
>> buf. however the function may exit prematurely due to transfer_failure
>> in this case it does not handle freeing memory.
>>
>> this patch handles memory deallocation at exit.
>
> Reviewed-by: Max Staudt <max@enpas.org>
>
>
> One minor thing that I forgot: I see that the commit message is all 
> lower case. Proper capitalisation helps readability and matches the 
> kernel style. No need to resend this time, but in case you're sending 
> a v3 for any other reason, it'd be great if you picked this up as well :)
>
Oh, ok. but, no plans for v3 for now.
> Thanks for your patch!
>
welcome
> Max
>

