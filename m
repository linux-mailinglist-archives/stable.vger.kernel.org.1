Return-Path: <stable+bounces-75800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 800EC974BDB
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 09:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363A81F243E5
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 07:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D988D13D539;
	Wed, 11 Sep 2024 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RP7X5r83"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214CD2C190;
	Wed, 11 Sep 2024 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726041160; cv=none; b=SxIXiUyamGXWx5EkhviQJ9v1m8SC06NHClCW7J94mdKe7FIj9Q+Mo58zK+cIZqugxMclSQjwHg1ch5PhX3jgu+2Okm5Gl7l346+Brah5pm2+8XxnDoqNABjXulbmUPRrnPFuW5LmveswVFBr1CMWX4EmoH0ZeeeuCZhPvo3hEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726041160; c=relaxed/simple;
	bh=UI29GiP/BTLgiRbNSRwQ6gBKRktbmqpd0ppzqV8JY2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type; b=hdIgMaXY2UpmUia318eZRxRPicDKu0uNzsdT1aUChupOzI1PSAi/AmLu44mlSRev/+/dXohoXMLdfi7wcrUpyAmSzwLsbak+atMr7irWNup1AIs9eTAUJ6drun5UWQpImF7oLOGB/mAXxDvS3HUEakIqaFc6LPL2XNYwujZIxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RP7X5r83; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d64b27c45so408631866b.3;
        Wed, 11 Sep 2024 00:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726041157; x=1726645957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YIm4Dw5q7Rs9OaJTn4hnJUtrKFl6GJTKrB6nNZ9HBHY=;
        b=RP7X5r830dtNm+kY4G1SPatf61FPZmZVGxLzQZ8FhRBMXltzbB/y1SLV98B8HueAqK
         VLmqn9Hfg1uumuCndfXsxdblRN3q7i8X2g4ziRGewfNPe7KTFhm9lK2OUH5dzP3t+DId
         jnAD1QYOVJ09Tx6UmELtpyfl7yWV+JvTu7rgeTz1EeOike9tkOGZ7lbN0bl7qz+feooK
         vyMg3kXsDkJ2pw25tVFLsTyWCrh6SAUZA8Uc5yIaxhte6kUegQoH+jDRzR7dd4Rt6t6a
         DhX2sgCvTu7tmlE+NEB9k2OwAIJjwi8mKHK1GgJeoyxvUIbmlUQFyUI239zJg9VeBtc0
         g6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726041157; x=1726645957;
        h=content-transfer-encoding:mime-version:in-reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YIm4Dw5q7Rs9OaJTn4hnJUtrKFl6GJTKrB6nNZ9HBHY=;
        b=DhN8CeRyFMyFXdxsffDCDLbp/FYS1SPyCODtKXtisZMIaf8kIWIZ4/+YgxOTojgKuz
         7AIzjwJk9xZMqoB2HbfPurjoUOhLE4qGgXViZ4OgnkTf+a3aNTB2V2eVP56G+Mb4oRAc
         Eu0j2T4eM9TQ+BHoO+v80yu6etw4nJIJlkm0v9IjRNAav91g78CWlOSxN+Zd+GXICJLv
         p/X3E/iTmtAnHeSO0MZWs8zOlxDNTSVI85OaNGJmiHJWlumG8pjMc9ymw1IG5IHTKB4e
         yY6fWNM4AMDzHJX0jJPWm2d5s2UcvscaR6AIeGHaRg1dh6KhfBhh52ak37tdti5B7IcX
         zQuA==
X-Forwarded-Encrypted: i=1; AJvYcCV9Hp5pi9g++CMdCNAEvyPrmnQeU5nQ0lm6oLkW8vv/v1EB0ytLcmkedMwzBtYwJhJHKjULPqkO@vger.kernel.org, AJvYcCVEga6xpLW0Le4woiHEXx1xwW+kOSVc8rJi6Adte5/vKHUGtCuhWjTlAhKvGP9hHYZZmq65V9VpPFXhFq4=@vger.kernel.org, AJvYcCW+B6Y0xzV+l9Zs1sLZzFCWD17i6eCP4DWeZiL9k3WbMGjmPPjaz78d1WYONMr+F44KJOByXxJSPVUH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81NzZTyz7VQ1s5tTQJK729m0KmBbZKS5I15MkUihM8U4iQI+h
	CQ8pjEB1fwvic2wGZs5ii0o+ducWxJiUnd1jLPQoz7dfggRv0guR
X-Google-Smtp-Source: AGHT+IF3r5SvX0o26mmTqhW1R6mkJkUFdnD/jtn0nOQQaVNIrITpcYaKVGaWDQVKtiA548yW/02BsA==
X-Received: by 2002:a17:906:d554:b0:a8f:f799:e7d4 with SMTP id a640c23a62f3a-a8ffae21979mr289611966b.59.1726041157120;
        Wed, 11 Sep 2024 00:52:37 -0700 (PDT)
Received: from foxbook (bff5.neoplus.adsl.tpnet.pl. [83.28.43.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25952671sm580707166b.68.2024.09.11.00.52.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Sep 2024 00:52:36 -0700 (PDT)
Date: Wed, 11 Sep 2024 09:52:33 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: ki.chiang65@gmail.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] xhci: Fix control transfer error on Etron xHCI host
Message-ID: <20240911095233.3e4d734d@foxbook>
In-Reply-To: <20240911051716.6572-2-ki.chiang65@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> This happens when the xHCI driver enqueue a control TD (which cross
> over the Link TRB between two ring segments, as shown) in the endpoint
> zero's transfer ring. Seems the Etron xHCI host can not perform this
> TD correctly, causing the USB transfer error occurred, maybe the upper
> driver retry that control-IN request can solve problem, but not all
> drivers do this.
> 
> |     |
> -------
> | TRB | Setup Stage
> -------
> | TRB | Link
> -------
> -------
> | TRB | Data Stage
> -------
> | TRB | Status Stage
> -------
> |     |

I wonder about a few things.

1. What are the exact symptoms, besides Ethernet driver errors?
Any errors from xhci_hcd? What if dynamic debug is enabled?

2. How did you determine that this is the exact cause?

3. Does it happen every time when a Link follows Setup, or only
randomly and it takes lots of control transfers to trigger it?

4. How is it even possible? As far as I see, Linux simply queues
three TRBs for a control URB. There are 255 slots in a segemnt,
so exactly 85 URBs should fit, and then back to the first slot.

Regards,
Michal

