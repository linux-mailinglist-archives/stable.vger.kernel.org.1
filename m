Return-Path: <stable+bounces-105432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A786A9F96D6
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 17:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603001889788
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A121A43A;
	Fri, 20 Dec 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IkQbq0JR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDD121A421
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734713221; cv=none; b=KpF7YDVUipygmu1/APD6jRMnWI2yja4P+QGAl+kiX4a9xIVbK38QJBf85ba681w/lP4CHxnnljk9DRukm1u+NIU3E37kYeUA3rR8zBc6KKLyoR9ZdgJPQTeJfGaOCHmut4YCtitL+vxBfKS97rA5beKnJ62FZZuyWv//seIWz9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734713221; c=relaxed/simple;
	bh=/B2hFvPofbZI1fc2VO8E92d2OtYMYvxKg4TvrOTtaAw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MuDgAv8JzjpzhP2FuH+SQluhzxttNdUkYBTbWiWCFnsWCIqdeU+jfUqKobSWECwF+MYDLKstLNDXBM6z8bXyk/zasH7uaCZAmJl0v1nw1KHm2sIx0uR8InZVXgSafo/u3fimoDasvlffxl3jbZUBcGljWJ2wy0g3Tu6rHTt+ptg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IkQbq0JR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso1872270f8f.1
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734713218; x=1735318018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN3NCV0VK/uGJibMQfEcSGLqDK9XIPj1wk3PZ/vmF2U=;
        b=IkQbq0JRWjKA2GALN8m5dAMffjC86Qjc1xJ9WfGsRQHT3FIH8hdJkHeCMg3cUkj+4p
         OBply9sQqML/udXphC3PIRn/Qxr8C4enzLACJIuqesJS7oLlAaa9QThZmkXCDtc651xo
         SurdbjpEiCbXW4ImaJV4kUaDnDUB0IQb9DJeDs0W67U4IvV72jj7TmoGR5nlUUNRUbjw
         kXWC1k2qWhywSkyk1eZvl6jHV/uB8dVjbVFongLfkTgAQaI+aSbIbk2t0n+TG/T5X0VU
         232PWtUYwSYNbAGZ1pTVNGzpeWJoUDWG7Ex7QfKnC6PBULN7qVo30sRCtifNcco2ybC6
         ZOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734713218; x=1735318018;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pN3NCV0VK/uGJibMQfEcSGLqDK9XIPj1wk3PZ/vmF2U=;
        b=dNtwJt5ug73F2shA/GWSHTeKDvq7IVkjtxnGYaPUZnAW46vpOg7AQKiOVaZY/toIZb
         BqkxqWnK8s3gEaiMFEDOuVqo1UO2FRcFesKDVKUi1UEsDJU1iWGchoerG3C5hPjMBDFi
         YosbZCsqe2afZEdsP2SPmCaeXBTz+Nbl10DJWrtgMJ7WEebWAQiIZiaGThy+kfRiX4Jw
         3v8jnVcnHGvvulAnv3B2Blw+x9tYfxJCC9CIO3srpsYR3VH3zfsMQV6/s/xZMpLW65SG
         ylTYOm96A8mDgDIYxfXkNMNllc+lBJb5HiwRAALTlRRbmaKNYqPRRhidUu8ebryZKNou
         6NyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdyO/JrDotEGccABMW0kxraIzP9VhCkCfCBnPVgOwYDHefWkGvhz9eBD4ZMXVbC+QuhI21w3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuFLBKQd+u3VQ2svUGqBIlHYneFhTESGB2VxbFkxYc76TIyRos
	NWj54TXf7D8SuNZOHzCWcXK2JUuIreTTbdiU4HN4LKTtauNBguemZy2Qtwo9dGY=
X-Gm-Gg: ASbGncsMgpJ+RnmgH/V7MMaU4K6EXkTEMmBzn6cgC9d1tMNcNU4GvCIBnbZpBUNKwS/
	EhQl/f7kdtpPpQo22tnYlhwYlWLTFzU6Q+01uP67yT5Con96yGGPMwdBbJwqfoAxU3aDg0Wl6rs
	ZvejE0Wdk1BKBTRbIuIe3j7iWit9tV8tfdOrx327vyTnz73KGmfEHrf5LQSZw9m0ovAJB8y+ynV
	mm5pBzHlXD580zHaIwTh3uioyqj7cDsiEcGupakg9Kq1JgXvF2LjOGwujN2AqXkxZ7q+F+a1b0=
X-Google-Smtp-Source: AGHT+IF2qOn5DQvkDWQOOGonC75zrI8OJerUlOXhUaC5o56J1R56eQiHy3EN9O2yh86rk+H5NyWy+w==
X-Received: by 2002:a5d:64eb:0:b0:385:fb8d:865b with SMTP id ffacd0b85a97d-38a223ff5bbmr4232823f8f.48.1734713218009;
        Fri, 20 Dec 2024 08:46:58 -0800 (PST)
Received: from [192.168.68.114] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e2f9sm4546038f8f.81.2024.12.20.08.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:46:57 -0800 (PST)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shyam Kumar Thella <sthella@codeaurora.org>, 
 Anirudh Ghayal <quic_aghayal@quicinc.com>, 
 Guru Das Srinagesh <quic_gurus@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241220-sdam-size-v1-1-17868a8744d3@fairphone.com>
References: <20241220-sdam-size-v1-1-17868a8744d3@fairphone.com>
Subject: Re: [PATCH] nvmem: qcom-spmi-sdam: Set size in struct nvmem_config
Message-Id: <173471321721.223061.15271739555049260433.b4-ty@linaro.org>
Date: Fri, 20 Dec 2024 16:46:57 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Fri, 20 Dec 2024 13:22:07 +0100, Luca Weiss wrote:
> Let the nvmem core know what size the SDAM is, most notably this fixes
> the size of /sys/bus/nvmem/devices/spmi_sdam*/nvmem being '0' and makes
> user space work with that file.
> 
>   ~ # hexdump -C -s 64 /sys/bus/nvmem/devices/spmi_sdam2/nvmem
>   00000040  02 01 00 00 04 00 00 00  00 00 00 00 00 00 00 00  |................|
>   00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>   *
>   00000080
> 
> [...]

Applied, thanks!

[1/1] nvmem: qcom-spmi-sdam: Set size in struct nvmem_config
      commit: ad71aaa9083a7ca8be9105d30a3eeaf4937234f8

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


