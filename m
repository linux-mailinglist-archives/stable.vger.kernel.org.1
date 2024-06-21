Return-Path: <stable+bounces-54795-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236F911B94
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 08:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E401C22803
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 06:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AEB147C79;
	Fri, 21 Jun 2024 06:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEz8tGKj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F747F45
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951010; cv=none; b=SXd7BMGSEIwIAuwVvxEKRP3qPP2yZym6n6+2Xje7viyXw8uG8rtzGNLKZ2IP3DC6voMx6QGDAZNDkxpNHSrcPna+vFkA5WBFCSIwS8CvVJg3F/RQrCxBnjR6WQFESJFhOG+xlcB/slLnxcfqQerytqfVlb2ZjCnrSp5PajPDzqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951010; c=relaxed/simple;
	bh=zMhNksKlxgDWJLOdWm5Srrf/T5GwEkXiwFjoRzm2X7I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gcJQfPCBg4vvsh7IMO//vS2vjLwcJv/Mfl0kj5DK5035XR3vYrX2F3KT+dCzROY8/vblT2BbKoQ6Nfbs8zwA/8zUkiAuGJAVEAG6WJcWJgQkS3NRHFfNWB4djjhnk0W62KoIHZjlx7MVs0a8zK854kxqUntp+Q1Q91TVipiWjX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YEz8tGKj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so15933275e9.3
        for <stable@vger.kernel.org>; Thu, 20 Jun 2024 23:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718951006; x=1719555806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkXmKbpIJRgUqctSd9ZQpnUJmrvVX9FaWF9GJe1dHqA=;
        b=YEz8tGKjGWSPhufcjqRjJ19owgdY1XgFmQJE/gmMPYQQ8QJuDx0WdMqGeOblFWHqVf
         srJ+4YYhWVLmQmLar4jRQFKK51K3qqVbsoli/nC8CygNeFYUFURtRx9oPxgZJp2+v7cu
         BnGqvVKQF8M8nokedI4udP0x1Wl5DVtsI7cGoZvj1cSJIEbKTJhKmUWupGQqVK88WKFP
         jwmSVOjh15UN8OHVwp2cznUA2yKh2NLNq+SVoSQEEmlGw8K0ompRzWlKTRcavJ9m2FPJ
         staYynUDW1nz7AnVdVtQQW5OaVAqH+sdzmxVAD5sYI51g8KhDNLKbA31rwD4Nmoc5Qm9
         LHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718951006; x=1719555806;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkXmKbpIJRgUqctSd9ZQpnUJmrvVX9FaWF9GJe1dHqA=;
        b=enalRyx+YrFPXISDACwJmoTXAa3wZFGG7fuivW4edzTfhYbgs+ztiqru7XRK1ZHs4I
         eIg0P1AKQax7gR3jYW02yZkM70Lx/m9CqcfxOuWsvlwEVpjwd9C3hE5+UHUvjozIckFh
         51Ybutrk82qGOeGujTR9GZM7R/+fWmtC9ukTZnDXyj6kyYatBabTYZ8oplaE7mnbRsK4
         +FNv96XKh+Xk6SZm/abeI/p9q+c0YJyKBruMWclW4zjO9BFZHAde2RqiCKcmm0tNOqeF
         anfT1NACv97JagWrdnpjMX56200E5nJ7LroqO4kSni1xMjLkI7vswK1seXssPGgl2L14
         Ty3w==
X-Forwarded-Encrypted: i=1; AJvYcCUWSPOvt7KAtiRRr/RvisAC/l6ze/YHXK/Ib0/Hwakeia6fTFcAWORVyk6nPtRN7su6tVIHg7kbdYsJeVjVBtgtIeVzYjUv
X-Gm-Message-State: AOJu0YzbyXKNAqXCWJ2zyIKqbmKy82Z3SWl23G+HD/ar0HmDI53j9LPd
	/yt8TC1TE/SUBaek+IHLbzxSz9WMqlf4JiNYboxpgQGgSkRLUXt8ba1idJZHSxyHO5SIsCqBYN/
	3fgo=
X-Google-Smtp-Source: AGHT+IGRxVnvqEGjCt60N7h0oLYURKo03b6UBEbfAzRe8XBa+0Djr3OY8r+KHjWNaMVb2TsZUB8/4Q==
X-Received: by 2002:a05:600c:1d8d:b0:424:7e0f:df51 with SMTP id 5b1f17b1804b1-4247e0fdf9dmr27675525e9.33.1718951006199;
        Thu, 20 Jun 2024 23:23:26 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817aa340sm14204335e9.19.2024.06.20.23.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:23:25 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Sean Anderson <sean.anderson@seco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Joy Chakraborty <joychakr@google.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240613120750.1455209-1-joychakr@google.com>
References: <20240613120750.1455209-1-joychakr@google.com>
Subject: Re: [PATCH v2] rtc: abx80x: Fix return value of nvmem callback on
 read
Message-Id: <171895100442.14088.18136838489262595773.b4-ty@linaro.org>
Date: Fri, 21 Jun 2024 07:23:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Thu, 13 Jun 2024 12:07:50 +0000, Joy Chakraborty wrote:
> Read callbacks registered with nvmem core expect 0 to be returned on
> success and a negative value to be returned on failure.
> 
> abx80x_nvmem_xfer() on read calls i2c_smbus_read_i2c_block_data() which
> returns the number of bytes read on success as per its api description,
> this return value is handled as an error and returned to nvmem even on
> success.
> 
> [...]

Applied, thanks!

[1/1] rtc: abx80x: Fix return value of nvmem callback on read
      commit: 126b2b4ec0f471d46117ca31b99cd76b1eee48d8

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


