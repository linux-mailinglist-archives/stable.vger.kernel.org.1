Return-Path: <stable+bounces-208243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3BBD17076
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 08:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 503EE304322F
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 07:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B311730DD2F;
	Tue, 13 Jan 2026 07:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="M86i4z4u"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC82F6925
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 07:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289630; cv=none; b=BbdbdqLbze6Pg4uMYYApTVXO2haCFoR78gjiJW2Ygwel03j+xIy6SZoAgvVFx73JIHPaVbD7705Y2q4sKDOsTM+O7dv5dRR1zQ74+wZz4xfIZV1QvaRnB3yyo8YnJFm93hqCfrFNbdZkQOBevdXIwJh1HohvOZPj6WY+NYAyBhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289630; c=relaxed/simple;
	bh=qaJtFIMANtsn3MUecYOomZtvOyG2AOWvRXicCsH/JVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbSuefu2OVzWAB9xJQ7Iy1ziL6SMFFwMiacfcZ39uLBVHSXcONg/u7P9ewRqyNes+8BVUo3/2hHnUFlacxVF08IY+b7cbaMKHKjGGa8ecMW9+ihr5acuAEQKzchIlgPZuFZPgj6/KqlPg68XfniJb56TVJZlZEPJ1xmVDvwelBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=M86i4z4u; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-81ea900c5dfso138113b3a.3
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 23:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1768289628; x=1768894428; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66kiY6DeNMafpIZAono+DmVHNPdj7umQZUCdDEMZe1c=;
        b=M86i4z4ut2s59OAyJapsGn8wY6LC3tspNDO+F6HTyL2qHIlGINd4qROnbkRhsSKvw1
         6LVBKJwRh3gQLwUADr/w2vbQ2ZpMqTzDkW+HnIFQSj6gZKHRuH/88BSURE3XGI87fO/u
         SwnfvGe/0J8XPOahUKXMuHEHOdwwDXJ37RtSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768289628; x=1768894428;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66kiY6DeNMafpIZAono+DmVHNPdj7umQZUCdDEMZe1c=;
        b=rBl/qLEnVyDdaw4r6cXCpe+KPj2YamzpO1+kUSsXwIuLQxnHTAB3wcLNEYgWSfiZT7
         6Nsq01vmNJELe8q7EtNm4qMG45bLkMhC8JMg7BKGg+cghyA/DMszf295tE1zKLfso15P
         VpbsqLJxl5cmnKyB96FkM3wDcGIPVv3DTpf/xfkG6X3zJX8QIQg+sJkECnpEOcF0UgGW
         PvTgd2h/xraOxQB/w86k8oSIcOpp+LiQkzC8l3+yzVrMLWtcjVWR59fjdjbevOofcqSv
         lHlFpkNfzXRGlEmPE7bQNoJmaWYgOvh7FvbCpenyKADDT7XMnTqHK1mDDiGJElay8akF
         v4uA==
X-Forwarded-Encrypted: i=1; AJvYcCWffEwioQV+54mmmFuhXh5m99tAasrSClTo2L3ywxT/a1gwqAF91UffyPVoQDaIK9BLj0/J8iU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVbreaUzb9TEHRDY9KJV0omUmhKZWWogjJOZ5ikuovSCxckVIo
	EEyfMPM2h0KwSlm66NwFxngicekPpkOPOrQ9VVs0YCW8IR23v9qJXoh0eReDTKCB66A=
X-Gm-Gg: AY/fxX5aJQLV+2Skw9+88TdbJTKp/faez4WxvQj8C95V5WGajVu1vtUQSvPfZLTh/LV
	6SbK71BagErkawYKU33Xqn+NDv6FBTnmKndm1uh/zBcdIEAJmT116VuuAYehABib/RnMXvrGhIN
	/9j9sOGHiwHH00Fq0cp3WBwf3WZrPokTVMvEy0Kb14ojFTxDtlerxqc0aoaR76/Jx2fPAupZrRB
	3uSJrFU808/TzRZL1pgejqiLFJ4teJ4t4gsDiQ+Faq/XAlDNn+EVwO6r4Uw8FnLCfr+RoQ3QdER
	j9Vvj5Q7l6asZmCu6q7I7D5ygtV/v2FPFs+wfflyBaFjraDGpj1uDaokxhmb+UitVqkbX1NCHbr
	Lg8sqWpvVRThL7Ew5+E3zcUPcVaeQuWHs90EvEWxWBXL3axM1qRmgj50qrT59QhCn+TiLPaeMvn
	iW79mXcWg5TENi+w==
X-Google-Smtp-Source: AGHT+IFEiJ+3Ihbowbp5xXpfvrwVzWmXXoeZjE+F2ognJ75zqEhRjx3kh34VtKELtO4RjJI2WyNdfQ==
X-Received: by 2002:a05:6a21:610e:b0:356:3b05:2955 with SMTP id adf61e73a8af0-3898fa11537mr12931741637.6.1768289628574;
        Mon, 12 Jan 2026 23:33:48 -0800 (PST)
Received: from [192.168.0.14] ([202.179.69.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81efe4a95c7sm9327369b3a.37.2026.01.12.23.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 23:33:48 -0800 (PST)
Message-ID: <a4462624-fa23-4df5-bb4d-0bd7ff848b62@mvista.com>
Date: Tue, 13 Jan 2026 13:03:43 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ipv6: Fix potential uninit-value access in
 __ip6_make_skb()" has been added to the 5.15-stable tree
To: gregkh@linuxfoundation.org
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org
References: <2026010815-buffed-cake-ce56@gregkh>
Content-Language: en-US
From: Shubham Kulkarni <skulkarni@mvista.com>
In-Reply-To: <2026010815-buffed-cake-ce56@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Greg,

Thank you for accepting this patch in the 5.15-stable tree. I Just
wanted to bring to your attention that the patch merged in the
stable-queue contains the lines which I added for reference only (saying
"Referred stable v6.1.y version" & the link). Also I thought this could
be an explanation, if Sasha's bot points out the difference in the
mainline patch & this submitted patch.
My apologies if I have not followed the correct format here. But can you
please recheck if this extra info is really needed in the actual merged
patch in the stable kernel.

On 08/01/26 9:28 pm, gregkh@linuxfoundation.org wrote:
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

