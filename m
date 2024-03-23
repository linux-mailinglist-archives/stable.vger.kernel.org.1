Return-Path: <stable+bounces-28660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B8887A88
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 22:48:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE21F21692
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 21:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AA65A119;
	Sat, 23 Mar 2024 21:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1clbKzx"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113022625
	for <stable@vger.kernel.org>; Sat, 23 Mar 2024 21:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711230492; cv=none; b=Us/gq9hdgs+1v2GjbVeHDIQ00zZmp08SzLxzml63EfbIdYDLgrMFCXiKB+/3aFOxD37eCFuIZL41ZVmTN9MkoYojFYtdTTwJ0b0pqq9M8QTNVYZmZo4oIvChzR3zauqY3pbpGjwAc180YtdR59OD6EubqILCWuc20P6hzFYQt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711230492; c=relaxed/simple;
	bh=prtJMPgUU2oRzHDb/DgGlKpWHhxrJkqwVkhAGks0SJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rq9BLRtniwUHee2KB+GmWo+vVR78XKRO1P9CUf3JLNLffEgCSYvgFfkfW1yaM/90MxpVp7W5qK3f5nSRQ9sR3ozQdcQny9ZYnxLmdc225bvud20xHhpNPDDxLbKHpFI/sA8duULz0UgUzqYBCQntIcSMl4bopDJj/2ch3txua6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1clbKzx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3416df43cabso1966619f8f.3
        for <stable@vger.kernel.org>; Sat, 23 Mar 2024 14:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711230489; x=1711835289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCMUS0MlnJpeL+ScI7XJHjplatXCOFZ9gPJ9nku76U4=;
        b=E1clbKzxCqQA3zOeb2IiKMz8XWs+VVNs+oe28AIXbJLpP78SiDZhrLkDh7IXI28pT8
         yPk6Elv2tn2LsN+g0C8dpchnFsIt8/DOya0kGmSlMgOTYJUenGYw7IuPnL3McrDTtLXk
         OPyk9nTPmz11Ly9kyb4nHvMrXuzVQUosz3wcaiS9LMF8ksU6RdEMYtQKH5TCXp61KLbW
         hQFy5anWO8hvR4oHkoQOPgYlFTLl/1idfwDbmDNsM+CmtwSkc66OTN2pTQBF2nw9pGOG
         zASYckI7Ppl39xifXg6Ee0sdstwOFj9Z3816H+7LcYJOQ6QSCKixMfaGU9yOzhSMhuC9
         nBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711230489; x=1711835289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCMUS0MlnJpeL+ScI7XJHjplatXCOFZ9gPJ9nku76U4=;
        b=ezsHAewHgz6/VVI9YJ74kTJuov0kUhmkT05T4D6jE6j8mv0TWWRbUa8F5fp/VavX6x
         ypDCsr5LiQgplYmbjFhFEbqcQeRxAswMvM2aBxpy6IKrynYPvL2ZHn8duBOPjK9fGCrs
         JI+YXE7SMELdBB6mj5UV4SXZakpf+vSTCfMYiH3SWMR3qVaF+mO98jUPcMbIY8+tqE1o
         N8enx+INsJZzsqDrhyLegIy544j9gREBgoz31FbgzYE+dtiBjBsnVOtqwXh2c5GbwPwZ
         Sg70W0aE6ZO8b1ufSR0W0oAJnr601yP/CiRp5q2Wf0norWYrBHiJOImIscVHUtoupTZG
         UXDQ==
X-Gm-Message-State: AOJu0YxFHDljI431QxSAOOlqfe0hJSukY59fa94j+1Iym3wFwyOaTbSS
	Yvp/6mE34XRHVq7Ht7++35ivAxfJum/La1NDzyiF05uC0hFb23W4esSLSXaB
X-Google-Smtp-Source: AGHT+IFq+okjJQhOTPWpuo3wJdyiInYXf/s1Ue0vrEMk11ksCP1UOpfb3/cT//sRYAZtfgzibKn6Fw==
X-Received: by 2002:a5d:6b85:0:b0:341:be75:5e6c with SMTP id n5-20020a5d6b85000000b00341be755e6cmr1905197wrx.3.1711230489311;
        Sat, 23 Mar 2024 14:48:09 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id k7-20020a5d5247000000b0033dd2a7167fsm5273647wrc.29.2024.03.23.14.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 14:48:08 -0700 (PDT)
Message-ID: <3585a148-2d88-454a-a6b1-d34cfa64460c@gmail.com>
Date: Sat, 23 Mar 2024 23:48:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: 8821cu: Fix connection failure
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
 <aa20f8ba-d626-4f82-9312-6cc2a4cfc097@gmail.com>
 <2024032355-liking-calamari-1571@gregkh>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <2024032355-liking-calamari-1571@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/03/2024 18:23, Greg KH wrote:
> On Sat, Mar 23, 2024 at 06:18:07PM +0200, Bitterblue Smith wrote:
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>
>> [ Upstream commit 605d7c0b05eecb985273b1647070497142c470d3 ]
>>
>> Clear bit 8 of REG_SYS_STATUS1 after MAC power on.
>>
>> Without this, some RTL8821CU and RTL8811CU cannot connect to any
>> network:
>>
>> Feb 19 13:33:11 ideapad2 kernel: wlp3s0f3u2: send auth to
>> 	90:55:de:__:__:__ (try 1/3)
>> Feb 19 13:33:13 ideapad2 kernel: wlp3s0f3u2: send auth to
>> 	90:55:de:__:__:__ (try 2/3)
>> Feb 19 13:33:14 ideapad2 kernel: wlp3s0f3u2: send auth to
>> 	90:55:de:__:__:__ (try 3/3)
>> Feb 19 13:33:15 ideapad2 kernel: wlp3s0f3u2: authentication with
>> 	90:55:de:__:__:__ timed out
>>
>> The RTL8822CU and RTL8822BU out-of-tree drivers do this as well, so do
>> it for all three types of chips.
>>
>> Tested with RTL8811CU (Tenda U9 V2.0).
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>> Signed-off-by: Kalle Valo <kvalo@kernel.org>
>> Link: https://msgid.link/aeeefad9-27c8-4506-a510-ef9a9a8731a4@gmail.com
>> ---
>>  drivers/net/wireless/realtek/rtw88/mac.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
> 
> What stable kernel(s) is this to be applied to?
> 
> thanks,
> 
> greg k-h

6.6, 6.7, and 6.8, please. The older ones don't have USB support
in rtw88.

Thank you.

