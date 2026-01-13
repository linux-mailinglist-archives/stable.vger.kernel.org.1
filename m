Return-Path: <stable+bounces-208241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF43D17022
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 08:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B7B5301A4A5
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 07:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972036A010;
	Tue, 13 Jan 2026 07:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="LHVlAJE5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF7E350A22
	for <stable@vger.kernel.org>; Tue, 13 Jan 2026 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289321; cv=none; b=YW6z4bFqpZ846HwQYe4k6RWB+u0dtD4CcUuxpRBS4pqhGY2ITmLh3i6IlOKTikr1nHpSPU1up0HcgQqbDFhihInAFjXCe2OBZMgRHRyxFgY6Qhvj99UgKVbWZAdahG5GKMJkR4n4szH5yUoOg5r1EKhDdnCpLJGMs0bHON9CIgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289321; c=relaxed/simple;
	bh=qeFsTeEpoF3zIxQCD3DBAjGU6WKZrDFxyMLyFtzcRwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dmrNfnfjdpY7zYGxaZFiin4zKwiH1NlHAw0/FJnkF5Tifwckhanp/PVzFapdPRYXKOVtZ7QOWfqO21NnECy6FnK8ut81KGilprBikl+4WOA7rkRL/yRZOPAdtNlyrAZH3TWpKkRi2Jo9OW83FCcWEv0ex6+ulFKl6mE5hcZjAlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=LHVlAJE5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34abec28aa0so243662a91.1
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 23:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1768289318; x=1768894118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wzxFZZxVd1IebHEa0BdBfjUDEIBf31met66Jm9QEcR4=;
        b=LHVlAJE5UhndnL3N6Rn/1seqCWXPzvc8lSle3J3BiA2DdYG6ws7LJE4jhvwKITh9ol
         s2qyz2KdQmwzaOacjhnR4jKiEibInqHZ449WTBdkmWjHwz7S5AfPxESNPIvzR97lI4rv
         unuDq8wIusj6U9MHyE9JD9NMeGrMPoLEUoblg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768289318; x=1768894118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wzxFZZxVd1IebHEa0BdBfjUDEIBf31met66Jm9QEcR4=;
        b=LXVBCYwrVwBzs5/BDjSjZAGEHyCVTxoC9UG9Z5BqwGUPHhfNqVXgYAZp//6w1AH9de
         gLhr6DMLVyv8uri8p9yylOuCyNvTqVFkDF8I1p+T/bxU9ghFAblh67E0INYKkLJ2hrUT
         b+2CmktxvinQ0So6PTr02BRb/agL8DSyT70RvOfS0pct8b62bdNMCsRqA1fh6C/Ll0tT
         0dx5qGoMvcgKa2po+OXJdoPxPY2RjNENF+tXXHKAmr+tdONrf7lHJklJcBC1Vy/KEVyU
         RgrouRSZyyxuPymhr2NrWO9mC7C0tek/Qiw9xlgTgPyHLwBxFQ6//72wSLPEq5H/gGpW
         jNxw==
X-Forwarded-Encrypted: i=1; AJvYcCWLe6SgNkCE9z99ww5Y7IN3X7qYeXDLSS/ILu5j+CxENAPjGJJf59qQz7WPhfsQNcu41XKbO+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyden3g14+tRgdr4rbx3Sg5+YCLa1EYKbI8ispVEW129RY6T9kP
	kWqbiYsDN7DRqplIMW4B39uVp+cuv4ElyQmSa/CmNuzv/z0uatg5UojTnjFx8UXGht1AygkrKuq
	qP8rKUk4=
X-Gm-Gg: AY/fxX7A6k5tdrpPUbh6CY53L/054yZkz7hMcJr15SiavTDtDP2dJoIVAqkXTf4tSl9
	lRy2eRxTMZtoEron0Z5fJB5wE0X7PU0IV7ocUG7L/o0ylYqspbRWNyqyYiw/NaAwdV3mZA9+tfZ
	6bp7ZPoG4sIBWkEobsfQh2JiSCIdZUK89TirquXMUPLlmZqVWlCH4fKQLF+Tid+A6COZBKq9gGj
	PGze0ZU5/Zosj5Ai88YyuSO2kdX8X7dxfDTzPj75gfqzYsKh+OVdV7qnmKO3IShdfSDgfhBpo/C
	vyzRkrqn+CZgEBi1hBPlfnDdxtOqpP5vaFr7r8Jc1m2W13Acioz/M4OEc5oG6DYsf2pL9rti8ry
	e2GAzd/shK1z4jnIH2U+r5R120gZUtx3iR3ta32uIV4vTBG2xL7owKk44YkKuhN2n1VdHnaAKiB
	4u/l3o8R3S804uXQ==
X-Google-Smtp-Source: AGHT+IHWiEOGsEYk5HRTOt4npQKGBT/C/jfvHfyuadQbv27mXpGQ+Engs1nc7uCtN+sVSVzHEfqGiA==
X-Received: by 2002:a17:90b:4d01:b0:341:88ba:c632 with SMTP id 98e67ed59e1d1-34f68b7019emr13726634a91.0.1768289318318;
        Mon, 12 Jan 2026 23:28:38 -0800 (PST)
Received: from [192.168.0.14] ([202.179.69.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb64d7asm18941950a91.11.2026.01.12.23.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 23:28:37 -0800 (PST)
Message-ID: <ff7602e1-ba2b-4ba7-bd93-3abafc5f572b@mvista.com>
Date: Tue, 13 Jan 2026 12:58:25 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "ipv4: Fix uninit-value access in __ip_make_skb()" has been
 added to the 5.15-stable tree
To: gregkh@linuxfoundation.org
Cc: stable-commits@vger.kernel.org, stable@vger.kernel.org
References: <2026010815-famished-defeat-cd36@gregkh>
Content-Language: en-US
From: Shubham Kulkarni <skulkarni@mvista.com>
In-Reply-To: <2026010815-famished-defeat-cd36@gregkh>
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
patch in stable kernel.

On 08/01/26 9:28 pm, gregkh@linuxfoundation.org wrote:
> Signed-off-by: Shubham Kulkarni<skulkarni@mvista.com>
> Signed-off-by: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
> ---
> Referred stable v6.1.y version of the patch to generate this one
>   [ v6.1 link:https://github.com/gregkh/linux/ 
> commit/55bf541e018b76b3750cb6c6ea18c46e1ac5562e ]
> Signed-off-by: Greg Kroah-Hartman<gregkh@linuxfoundation.org>
> ---

Thanks,
Shubham

