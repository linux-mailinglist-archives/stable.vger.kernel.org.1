Return-Path: <stable+bounces-43451-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356568BFB31
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 12:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B005FB2217C
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 10:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8281ABF;
	Wed,  8 May 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z3FgsNNT"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1B98120F
	for <stable@vger.kernel.org>; Wed,  8 May 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164932; cv=none; b=dyjCKbO2nX6Kv1faL0tU4gCEpshNmdg0D3nSsxJp446YC7F0DP3ZBQE16hJ2jDu7HS4L5ZMf+yUPowIsHPbsB09DGT0+nQVD96cAkMSDskEQyIVNf4GTvMVBUx8bIUADhTFpsX4BNzK/1yWeHupo+sSmP5oCyMkFd5ctj/3mruo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164932; c=relaxed/simple;
	bh=msFOWMMZAv+nOcQqKV5mzuGZJ+dqXm8YAjq5UYtYae0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BH9VMPJZfyaMKGa8U+udAkMWmrY830KFTzmzely0E5y9zmTHkxPGOf1TyPTs1CU8HxCt+g+M14kIRZzzarGuqSpCum27YxLkY+tHlV0PqR8x4mkhTRdkQMhI0hikFuL6UovnVjUgVjdczQerOX2sUar862JMc9SrwXWyn8f2FOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z3FgsNNT; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61df903aa05so44430907b3.3
        for <stable@vger.kernel.org>; Wed, 08 May 2024 03:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715164928; x=1715769728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SCNZSYQEn9C0yYifJvIKeqaC0I3ddBBIVvQAOJJfdew=;
        b=Z3FgsNNTxk1w3eCb/U+dIqo+fSnddur6Kj3Hjwm6PWw6J43QdXoqeyT9WmkuZsv2Fn
         r0CglCSOtTjn42IStELQLTUfutMDTHCLcjU7Xv9xg0rZExtbqIQLsgy+7rKvINYWrjr3
         mpdFacD3PlzYQKEt0u4BXc6JzQs8LEQjpOU0pyERqcnGVQJqam7XE69WSpuRL07S+eMF
         8UOwMlMZPVNNO0MtG3MSzXrNLqYVpOcQ9By2Rf+4C9CaYhcWQ1vYd5xPF98wCF6TtCM5
         QhLhFYECHfF6Cpj66Bvzue9MmTZucTPd1gd8CXiZSy7hhEj2vRMqYGZQ71X1My/ETTNL
         JGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715164928; x=1715769728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SCNZSYQEn9C0yYifJvIKeqaC0I3ddBBIVvQAOJJfdew=;
        b=taFWUruaeCe807lBr/HePlPtKj3vUSvHXMzFl6ESpF/31k8jxBzMXChcIDubEPGyzH
         XssTWfxa7fnvMQ4u8ZgALoNWkJSTKhUX2uNBohxFzW3zzdSXivMQTTfIq8Dru5cjTHjN
         1sMh8oYfqEHVpP//+icqTxVLVLY7qOyrWyklS630cBzAmW/EqqHCx6XwEm93Jc/QmKrG
         aw3XYG56NYSnJNR4H4qwFIvNvFkyA00klFNhTSWC1z9fAV9PmB5rQIfYz29Ir2VRdUUb
         dgjvm0HhJVhyyrdKzZvv2iYFMCpluWrFTlsIewmhm8aMTYJNmiVRvXZaDfPScpVvmUOz
         cgzA==
X-Forwarded-Encrypted: i=1; AJvYcCXkabVNkzPfP3bwmyHjqDEdSEKZ+EQ60eOEZdBeVi3YwdPXBeyupenZW99pYLGHc6MYAu/90T3sWq7udBOUjl3KADJYS6Pu
X-Gm-Message-State: AOJu0YzaxgnYT4BH+wRyF1aaJDNmLNlbEama4qqishMFjYydrfu3rzwH
	D/2P7CP69wD8IB98oDZL0mdIPzdQoXkJlV/866qWswgKMJmMl5mF13p2hBrC3iAnkQ39qX0Egup
	aQl3zNWmYYnG+hR+N7gOvBgL1YJ9mqC4W+G5jMA==
X-Google-Smtp-Source: AGHT+IG/YkpxJFnMtp9np4dGXgtlpi8FQCo5Um1fohI6F0WuAx9qFoD5jZyRnJpee9YYAVFVuPsAG5b/WQKuWWsqGYM=
X-Received: by 2002:a81:844c:0:b0:61a:db67:b84f with SMTP id
 00721157ae682-62085da981emr27885857b3.27.1715164928430; Wed, 08 May 2024
 03:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSo37UN11V8UeDM4cyD+iXyRR1Us53a00e34wTy+zP6vx935A@mail.gmail.com>
 <20240508075658.7164-1-jtornosm@redhat.com>
In-Reply-To: <20240508075658.7164-1-jtornosm@redhat.com>
From: Yongqin Liu <yongqin.liu@linaro.org>
Date: Wed, 8 May 2024 18:41:57 +0800
Message-ID: <CAMSo37XddAvE199QpA_WR5uwQUjzemF8GxqoWfETUNtFw6iCrg@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: amit.pundir@linaro.org, davem@davemloft.net, edumazet@google.com, 
	inventor500@vivaldi.net, jarkko.palviainen@gmail.com, jstultz@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	sumit.semwal@linaro.org, vadim.fedorenko@linux.dev, vmartensson@google.com
Content-Type: text/plain; charset="UTF-8"

Hi, Jose

On Wed, 8 May 2024 at 15:57, Jose Ignacio Tornos Martinez
<jtornosm@redhat.com> wrote:
>
> Hello Yongqin,
>
> Sorry for the inconveniences.
>
> I don't have the db845c, could you provide information about the type of
> device and protocol used?

The db845c uses an RJ45 as the physical interface.
It has the translation from PCIe0 to USB and USB to Gigabit Ethernet controller.

For details, maybe you could check the hardware details from the documents here:
    https://www.96boards.org/documentation/consumer/dragonboard/dragonboard845c/hardware-docs/

> Related driver logs would be very helpful for this.

Here is the log from the serial console side:
    https://gist.github.com/liuyq/809247d8a12aa1d9e03058e8371a4d44

Please let me know if I could try and provide more information for the
investigation.

-- 
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android

