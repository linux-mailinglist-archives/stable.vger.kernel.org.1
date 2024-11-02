Return-Path: <stable+bounces-89565-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0CC9BA097
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 14:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A299B1C20DB3
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE3B198A3B;
	Sat,  2 Nov 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie header.b="YBm1tuXO"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28300198827
	for <stable@vger.kernel.org>; Sat,  2 Nov 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730554977; cv=none; b=WMj1ceJeys96eimUd0RdeJcVDvT8ZM5J/DnIKH6FoMzNx5WnTQ2Vu5eKqqaYu1GwtQQNeKaFuBwIAQyDAmry0v/D95kINdrOTKWaWjud/NxxTGLe+jK61ZIiUDxHy136Dbxp5YdAj/ChIJYNjTOsCJcMWkYrA21u2UFGDtsPQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730554977; c=relaxed/simple;
	bh=+nP190fTcVJZ6KtvpJHylOAbl1kZxeNFaK2DoYuCVjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6UhRuw4OZs6B55O2a9qI1chbCra1nZKXigeT4PNJouYsYmj6Eno7lMrKg+I45JN+mjTuy8gyBjPAXoxgC99L2UbCo5syhL7oFG8PDWfym7dfJCCelihll6Zs3vziqevQhBz+sxtObYgDMCA6XM+I0Z3bWGASdvfXyskuURMPS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conchuod.ie; spf=pass smtp.mailfrom=conchuod.ie; dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie header.b=YBm1tuXO; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conchuod.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conchuod.ie
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d51055097so1775423f8f.3
        for <stable@vger.kernel.org>; Sat, 02 Nov 2024 06:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google; t=1730554973; x=1731159773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/4ALDjW26fb+PpeY22UyTRtH0nvyjOpDSpJmdfXUgg=;
        b=YBm1tuXO6YS1nWt80qVK34LQlM5i66AJYd9BZ9Zuu4Rh4ttrJnUmCKrsi0ExN8GHRb
         7kRdwRzpzV0Kxv+rJ1kZm4RY3xFiGSLG9mio30mB18o0ZNu8E0R2833bTzxwmScuugXG
         QeU+//t7FOUkMxEW57CqAXnLTbVCWCLJPAMktvepTipvyqmLzlJ/+xvlCWc6Mlv1wvXH
         By2Vpdfa6TFhRLfXURU18rO3mJzejN0/vBYkY4t9H41OeODbVh4BItbC0UBgb4u8WDdG
         OqCF46wJXaoowRO/FWaAypfWVvCLSqAvDZqHemdGrO7Eg0I08WP8PWkF/PiE27VUbeK9
         JiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730554973; x=1731159773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/4ALDjW26fb+PpeY22UyTRtH0nvyjOpDSpJmdfXUgg=;
        b=t3BYDip9hloqjYdNTk4D5udJqVxect4jX8h/dtBpakwqCshioEw3t5CtpDy5KEb9jh
         BYCigPpoRkzAN0b6V5lEf7YeKZbROXIJCYJMHT4OGqYpUGSozkgOTCR91n1DxwKbDwq+
         If/WDQLt5rz2zRJuRP/4XylSnV1hBzs6/y6fzh/amR/PgTrhHyEoFblkJoiVphb8cmmJ
         YpvlH44YO0c7sFh975Jhz8VMyExrTuIHs6hdaoOSMNtLYiC0Lk3YIZJePbXSFGmQml6Y
         UmPGiQ9zmgzBVfkaCIGimLlEl73hdlJ4h/y74Hpp4rExrKmLn2TRvM5rK0vhun4nzAIT
         qfvA==
X-Gm-Message-State: AOJu0Yyuep/ZC/bQV1daEATwf7GdcvVsPu9veUT9bIOg0RGgsvUrtmYT
	9TsivV9zTc4NxM28Cq1pFaiyOf7uV7PiPev5so0HxThnGy3bWD8Y1Z7fOlxBNgUX1I6bj7HXldF
	g
X-Google-Smtp-Source: AGHT+IGpkR1Krb2o9Uv2MTuPkph5mhMqPX0t2t+nST/D5tCfMgcEFkaoUysq3uHMbfMNKiwETTvsLg==
X-Received: by 2002:a05:6000:1a89:b0:37c:cfbb:d356 with SMTP id ffacd0b85a97d-381c7a5e9camr4866906f8f.28.1730554972824;
        Sat, 02 Nov 2024 06:42:52 -0700 (PDT)
Received: from [192.168.2.9] ([109.78.175.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d40casm8159132f8f.27.2024.11.02.06.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 06:42:52 -0700 (PDT)
Message-ID: <61548681-29c3-4348-a048-658747c0212a@conchuod.ie>
Date: Sat, 2 Nov 2024 13:42:51 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "dt-bindings: gpu: Convert Samsung Image Rotator to
 dt-schema" has been added to the 5.4-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org,
 m.falkowski@samsung.com
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Inki Dae <inki.dae@samsung.com>
References: <20241101192914.3854744-1-sashal@kernel.org>
Content-Language: en-US
From: Conor Dooley <mail@conchuod.ie>
In-Reply-To: <20241101192914.3854744-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/11/2024 19:29, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      dt-bindings: gpu: Convert Samsung Image Rotator to dt-schema
> 
> to the 5.4-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       dt-bindings-gpu-convert-samsung-image-rotator-to-dt-.patch
> and it can be found in the queue-5.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 25cb1f1f53fe137aefdc5e54bb1392098c4200ed
> Author: Maciej Falkowski <m.falkowski@samsung.com>
> Date:   Tue Sep 17 12:37:27 2019 +0200
> 
>      dt-bindings: gpu: Convert Samsung Image Rotator to dt-schema
>      
>      [ Upstream commit 6e3ffcd592060403ee2d956c9b1704775898db79 ]
>      
>      Convert Samsung Image Rotator to newer dt-schema format.
>      
>      Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
>      Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>      Signed-off-by: Rob Herring <robh@kernel.org>
>      Stable-dep-of: 338c4d3902fe ("igb: Disable threaded IRQ for igb_msix_other")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>

How is a binding conversion a dep for a one line driver patch that
doesn't parse any new properties?

