Return-Path: <stable+bounces-3785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A80A8024F0
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 16:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67E5B209E9
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B3E13FF4;
	Sun,  3 Dec 2023 14:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EV52bu16"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74522E8
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 06:59:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2868f826a46so285864a91.0
        for <stable@vger.kernel.org>; Sun, 03 Dec 2023 06:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701615589; x=1702220389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tYM0h4rCknXpAN2an1CS52/HeAD7gojPPCR5bgdJdJE=;
        b=EV52bu16DoXFgT4oNgkOSRaFNM3OeyxFzkF4+1KgtoTEEFDGFA4msd1o4Pdztne87p
         /IueiFi5xANQ7Jh+h8IrATny0/0MDYVElK4icysKKBN+Q7CmdtwcLH1Yl8txFbfqCJFI
         T74onZMgesJ+ByJwmxtQ/0ivIYDXoCLNNZIFDMVYZ+CV9xLMSLmpMT2ytJMx9n7toUC7
         RS93DSag0VctT7FU/9Jnl3aE7rF8PPQWf3jJE4EgqcCugqSXe4Z7ptJPSuy9UCbxfiVk
         9f2cPT6EueHXN9oHRibVaEgPclmHdaavR7UHkeG0orXMt78PHqSMczmvG9FZY2nnwIsz
         gvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701615589; x=1702220389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYM0h4rCknXpAN2an1CS52/HeAD7gojPPCR5bgdJdJE=;
        b=fRw2PyoVkQ3g+u3nvl3kN4CrXMqA9BOsgE8cgfO+fXghyMxfuEoD2AjK2RLHCxUamn
         FZBuVpiqqkKdMIpodEKGqNaoBJ8SWFbepnw3GxrV4qzv1g0lW70hNkjAVRxmdVnQjAvz
         5JgJZdJiBdwutAo1ely6dYRvcH5kFOrfTiUZpSVxGEGD8MqnF0WDWbefp1TavjmDk5VM
         PCb3S1ax15BA7sBjKqFDr9aBF88xJkBLla4vIM1//+r+3xng15FY8QRDiXDaUNUnjJOy
         V/w1i4/tad+/VoLqDU809wwrP2sNt7p3qMRZkgFJF+4boOoIb/oAW0BPmPIAxHLJQgfx
         pA6Q==
X-Gm-Message-State: AOJu0YymBgLzOekpRaCxFNA+Uc+i5rX2ADnXgGXw5ujHSxqmmj7E+BHF
	qJ3JGU+Bu+qTVe/kdZKyZ1CNVw==
X-Google-Smtp-Source: AGHT+IGDvwDn+CxXlOyCgJHC2aqVHZqTn7Q0AaU+hyxqKEQ4fP1tyAjDGLzb/IoLLCKBGA8Ws4ibiQ==
X-Received: by 2002:a17:90a:db91:b0:286:515e:b8e6 with SMTP id h17-20020a17090adb9100b00286515eb8e6mr8617346pjv.1.1701615588724;
        Sun, 03 Dec 2023 06:59:48 -0800 (PST)
Received: from [10.0.0.185] (50-255-6-74-static.hfc.comcastbusiness.net. [50.255.6.74])
        by smtp.gmail.com with ESMTPSA id 1-20020a17090a000100b0027722832498sm8876492pja.52.2023.12.03.06.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Dec 2023 06:59:47 -0800 (PST)
Message-ID: <644de084-3205-497c-9c7b-fff06661d394@kernel.dk>
Date: Sun, 3 Dec 2023 07:59:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] io_uring/kbuf: defer release of mapped
 buffer rings" failed to apply to 6.6-stable tree
Content-Language: en-US
To: gregkh@linuxfoundation.org, jannh@google.com
Cc: stable@vger.kernel.org
References: <2023120359-fit-broom-4a79@gregkh>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2023120359-fit-broom-4a79@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/23 6:47 AM, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> git checkout FETCH_HEAD
> git cherry-pick -x c392cbecd8eca4c53f2bf508731257d9d0a21c2d
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120359-fit-broom-4a79@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Pick this one first:

commit edecf1689768452ba1a64b7aaf3a47a817da651a
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Nov 27 20:53:52 2023 -0700

    io_uring: enable io_mem_alloc/free to be used in other parts

then it'll work fine.

-- 
Jens Axboe



