Return-Path: <stable+bounces-208242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE12ED1705B
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 08:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5C4B30407DC
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C51130DD2F;
	Tue, 13 Jan 2026 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="fRCzHTX/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBC2F6925
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289527; cv=none; b=RO2qoEmQ1bGX7XMnX9hagGvGSQmDmmbIwDPVgvlALZUcgMuFKY+7cv7i7thn9GlVB29iXgsHI71eQ4Rho3U+jEbM+PiM17ZXblClTC0LGYaXhBcnajXRob1X4kGCwGbzp5rZnGd1MSS8NManGofgqcgwFPuMf/3zDfRdBpKzXfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289527; c=relaxed/simple;
	bh=ARXYngUFaxmH+mPnGbqcbAtd7NLnC7W9LOf548VWRkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W86vDY7MeRBfpS7K8CeKORlF9hu71X5Kj1cuwrdzuXVKspphCSlY0ObQCXCYy9FvuWWYBRAq4Aftqc75eSWMXLGOcLs2n6aAZXfPUEGSTo3WIosY/+qqKAozJvfWnrumeVbKLPJycpPW8L0CP8BLXTIlJeh5evDD6xrY/k865zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=fRCzHTX/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a07fb1527cso13767045ad.3
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 23:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1768289526; x=1768894326; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qH+5jdzgCFADMVkKrtrdACp3JCVRynfUE/U5zxsyvbE=;
        b=fRCzHTX/9equuErcA9Vp7t7RwcFBmSavydee83evJgEgJ5YvwnBluCp6utk+wHIeft
         cPCGKYOA+JxGV5lCYSTbLaOLn+Uj+6S4x81vt0wLUhNmDAwkm5/YHoujA4yDTmITae/6
         MeuTxk+eyMU+QMK5VFG8WzPuOkdRfsEIc5ygo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768289526; x=1768894326;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qH+5jdzgCFADMVkKrtrdACp3JCVRynfUE/U5zxsyvbE=;
        b=MF7jnjVGCsyFrLND1bCG0G3laPTyYil8o5ejuIwdHCMYktMJGuRUTBJ78KgXBP7O+k
         KxWF8VJB4AiNc3Cq3EeqKyZ/4/X0ur1kQRJHVP5I6uo8QIkvZeti0SuvKeUlBNeKprma
         8sX/IpgkgX+ra1pMMSrw8ccuigX6rH4v7ddM+ulTHYS1bgRVUvnKAZjKh9/6NpdECMg1
         RjZGnmnbqKpPvqqxZSeVRXrnT0UdhxuTepgm2e3niUzD/nXzUVVFifxBsqmCJHKE0Q1V
         Ifs7TLuBf/7k2lCypyskhFBEifJ9JRxqpKDXiF8CPFtynyjC5P7Q5B/sDJLqv0oPWYUh
         6J6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCHUZVgH2apskqsfYJFN4b3gl1me/bcc0BS4AXikIk2uMoQCUvPmRx3Nex2QC9FKnVC6Zmqrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEG6SCNVbOk9/6ARLhxKWeOsdbpZeosQ8zRp0hxz3ltgwjLPqh
	ErQLG5kGCYnMvFf1Tp2OCETydPUaK94KukrV1RdZupvFSYCJK4tG76Bq56+YhhUGr9OKZ+534SJ
	o+xML6KA=
X-Gm-Gg: AY/fxX7PkQNqfiKFzK0R8gbL2ya89Htd2GnuY1tUulAl8R7sTBG8G1CJdqC2LW1+0EB
	3zQ7WkMvyKROU/eGcVF+w3gH+iFHKilRc0AJxVlfSTmxQcj8tj00VZe0M8kuffcJ0wx5GNnIZWh
	6bP/UB13RcxeAd1hJeJxTcc7RTKx8BZfpT2DOdahctA0hEE0uM7yIHEA+KFRb6qp6WcbPeU8YuG
	KZ8hiOFS1rxjVRUnW/IkoHSDJFU0OyPqwIdJPH+iiX1oHQJHROuesGBPgjL4rzbmaLwaqbN15EE
	Eb2Dj970X9Yknmuwwf4aQhILq3sWQwm5V1MxJs3FiSCnls0VfwWXhrzT7OnM7jcUEHvlmyh2ziB
	uE5VKA5P1hoUUEue5319PBzqDK5tho6yb1IE/jx8DLJov3dzJztpxIpW/7fdZ0uYghsGSKQx2Ar
	OYQmf079z70UIcRA==
X-Google-Smtp-Source: AGHT+IGo3A/8kgdvqkP52J5LYTxSZTo19+zVXaBvtNEQRjll+kZCg1984DEMwSH6ngRY+LYL6Y20Ag==
X-Received: by 2002:a17:903:4765:b0:2a0:be59:10bd with SMTP id d9443c01a7336-2a3ee4b3445mr137347015ad.4.1768289525905;
        Mon, 12 Jan 2026 23:32:05 -0800 (PST)
Received: from [192.168.0.14] ([202.179.69.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a311sm196290255ad.19.2026.01.12.23.32.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 23:32:05 -0800 (PST)
Message-ID: <64e1fd72-8b26-4af8-9666-6cbeb8ca2523@mvista.com>
Date: Tue, 13 Jan 2026 13:01:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ipv6: Fix potential uninit-value access in
 __ip6_make_skb()" has been added to the 5.10-stable tree
To: gregkh@linuxfoundation.org
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org
References: <2026010852-bargraph-unthawed-a44c@gregkh>
Content-Language: en-US
From: Shubham Kulkarni <skulkarni@mvista.com>
In-Reply-To: <2026010852-bargraph-unthawed-a44c@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

Thank you for accepting this patch in the 5.10-stable tree. I Just
wanted to bring to your attention that the patch merged in the
stable-queue contains the lines which I added for reference only (saying
"Referred stable v6.1.y version" & the link). Also I thought this could
be an explanation, if Sasha's bot points out the difference in the
mainline patch & this submitted patch.
My apologies if I have not followed the correct format here. But can you
please recheck if this extra info is really needed in the actual merged
patch in the stable kernel.

On 08/01/26 9:27 pm, gregkh@linuxfoundation.org wrote:
> Signed-off-by: Shubham Kulkarni<skulkarni@mvista.com>
> Signed-off-by: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
> ---
> Referred stable v6.1.y version of the patch to generate this one
>   [ v6.1 link:https://github.com/gregkh/linux/commit/ 
> a05c1ede50e9656f0752e523c7b54f3a3489e9a8 ]
> Signed-off-by: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
> ---

Thanks,
Shubham

