Return-Path: <stable+bounces-135255-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4B8A986A3
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810923B4707
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033A266EF8;
	Wed, 23 Apr 2025 10:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="AOgM6h34"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC11DDC00
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745402453; cv=none; b=MCavl8A2X6MKs0qIjUWwyAGuTzjfNobkhJZSAG8sVdIQBiFMwHspQQHeSmiUgXs+rKH3UreGWFBnq9H+i5bG9C1pjBqUL4j2X6/MmIypjLL3lGwI4hRdJdVZwjPb0YthENaKa2EVzXYon+xFCFF2Vu/vL9MxRaCRmAMqITaQHds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745402453; c=relaxed/simple;
	bh=INh/rprybvU6VsQPHpwnovM5144FGqOCEIhODDGAji4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fv7a64qAh25QIRfUckeuqEODf46LbOOIPtBb5EtPDIDAcGyLEu7/noGEV1cYuEM71QO+t/anE4uKD9MrLK8NfYA8eGJfEQS2u3HpHHL+a2XQLQSjz/GPR673hgiVAHiV0SO8sDRhDxQGXaeVeJy4TgzicdDTsnLqoFiTRukydFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=AOgM6h34; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c769da02b0so5382847fac.3
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1745402451; x=1746007251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NqFwAvLk84I2P+huTGEVAaDjgqVvOObJjT6pzpPPtzg=;
        b=AOgM6h347FxpU2Ls/joPG0jSd6ZUkvwC1Ht5GJEgRrRGUAG07Zk7CXbikgO3Vmxhv4
         CTZNkQclmh772YLZ1INFwtyw20jJ2jSCUjiMQT0CGSmU7h/0QaLjF8TfWk2WO5ZXW38p
         izfDVynwvCoSE93UTXC+WsODi9/qrkA7hUcJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745402451; x=1746007251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqFwAvLk84I2P+huTGEVAaDjgqVvOObJjT6pzpPPtzg=;
        b=XJAwAlKQXBGCxbVHGSUMRF+U+0hj7jseo0b0LZ1hjWPZKG+/y3sObzJORKBkJWUHvO
         rLSngER65Mge48rCVy2y+ph9CR78UJrZNfbKfL4hLbaGmreAnu1QWS1lEn5xo7L2CMDs
         rlt7nkMSrdp2R6Gr6DYJ80QbCSQQ6XacoQ4u2Jepcf9n6TbeU5sUtgW3OgMnKqEJGwXw
         ry/RmG5wzz4uFiUsQNnhgV9mhrr4lfPVWr6Ln6fBg2pH4j6nk+7oNI9jIn29i2tS1vcP
         gUdONoSK19FYUHla2jvfmN1xPVnu5YqU15ZKI/1w8VmBxFJzR9C7XRsBTORGkJxGbRRT
         RqGg==
X-Gm-Message-State: AOJu0YwL4HUDtzCyRjAbl7WZt2xouFvMjY/WhUQ57QuPqCHa2ytXtBRX
	DxB8+eHq2VSgACnYqVi3U/d4mzQLy4OKRZxbRAL7fNUI4zmNpiCAGwIQceHYWDmf/o81FYdX2xV
	S0YcsPHDusWRNwaoIHais61szKtst/LjJ8xxfzA==
X-Gm-Gg: ASbGncu6+7uGpErQZQhQzWgZ3kfp9y3GzTJzapxaDBt8xfd9JTz/A6k6Wb5vhh7UOm1
	CN1Y2SRxQWH6WBtVXDkkgKSaKSqFcaFLhLv5MbVpCIeNBHnwFTQZK28FceBJyzu4KE+8SajPmWb
	neEyOi2A7hBY7YeTRk+vxzPanKbevW5Rx1DnNPn65VF8b931YCdwk=
X-Google-Smtp-Source: AGHT+IF7WMZglwL97Hnl7cJAtVzc63X67dWzococWkb1lk1FbWJ5cGM7oSJkGBgTz+/4TIBSGdQhWubhmMvHCfCTl3Q=
X-Received: by 2002:a05:6871:8014:b0:29e:32e7:5f17 with SMTP id
 586e51a60fabf-2d526ddc68bmr11552403fac.28.1745402450762; Wed, 23 Apr 2025
 03:00:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025042230-equation-mule-2f3d@gregkh> <20250422151709.26646-1-hgohil@mvista.com>
 <20250422151709.26646-2-hgohil@mvista.com> <2025042204-scrambler-dropkick-e453@gregkh>
In-Reply-To: <2025042204-scrambler-dropkick-e453@gregkh>
From: Hardik Gohil <hgohil@mvista.com>
Date: Wed, 23 Apr 2025 15:30:39 +0530
X-Gm-Features: ATxdqUGVVcFNe4uoM_Ic46lAv6YHIw6EQwS8-K5KSlIqUQ8tAGCRJkeeKqE3mRM
Message-ID: <CAH+zgeHyrhAVmJOHZ7BKE3BX2CaTK8Es3MDqSU=HRwz7yX0OTA@mail.gmail.com>
Subject: Re: [PATCH 3/3 v5.4.y] dmaengine: ti: edma: Add some null pointer
 checks to the edma_probe
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, peter.ujfalusi@ti.com, vkoul@kernel.org, 
	Kunwu Chan <chentao@kylinos.cn>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> Sasha did not sign off on the original commit here.
>
> And you didn't either.  Please read the documentation for what this
> means, and what you are doing when you add it.
>
> thanks,
>
> greg k-h

There have been no changes from my side for those patches. Do we still
need to add a signed-off sign?

