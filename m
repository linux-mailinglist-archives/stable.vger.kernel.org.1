Return-Path: <stable+bounces-50142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A799037D3
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 11:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9800A1C2320B
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 09:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A3217B41D;
	Tue, 11 Jun 2024 09:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Em7OVcsK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A0B17A930
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718098211; cv=none; b=Oq/DLYFAj42CVqreo1XoAVWJeRXha35VwXGZA9MRFzqt/M+vW4RN7FpJunOE0Nm6A0bzxe1Rzh12xY2puEy2suWYWrUyJ3zH1bid7Veyn0X/lKPKQtNYQNll7y4acO5NRwxokyz4sv9dOcs6papmkkLY93Yvyfa9ePdW0YCv83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718098211; c=relaxed/simple;
	bh=jWN+yGkKNosTh7VvPp62+8bUuzK3hZMqb3x+AAM6aOo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jHgj/F7Xys0Kx8KnUVF2q9XLZ6fCR0DuPOOUNeogORmcV51m2ZoGecbjn1DoE6pcfo23FWheodb1T+EvQw5cIpgo26pHgzViCemCV5JJjzZbajzMFZrZXwpzFzA6CoUawE8D2oT+HuO1B7HG/ZOCwFYEIUTp15zZr+2cSdZucH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Em7OVcsK; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f3efa1cc7so22815966b.0
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 02:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718098208; x=1718703008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEiolzJ9Rm1ucL36ZKdGfO9BXAHThbq3hA10O8Bq52E=;
        b=Em7OVcsKVH6nBgX8RRQv3JIVgtm8rF/860N0oW5MmyTQ3njQj7C5b+OL0qrD2r8PlR
         MpsnzOt5tgwPLp1cW9mUBavsoCZ5oBDMJScp2cCvgvf+M0/+QaQy8wR7ml4Dh+vIvJNx
         SU0vqiXJ8Us/j+5acA8jnhtbso69RT0kboeRL6Vfn/NJIq1Hif2K/jp3MpLKzp9dhV0T
         VwF9RAo9djZZDygIuHWrdxDIGIeUAopIz2FWziQ4Eh90GODsemtQX073YWUbtPc1ZtW/
         1U+Rx9BczNFyRTDk9iyiEVGkVm4M+D+5ewU1neWUMFtIRlNtm3bGDg1sxSj1nJK+ST4J
         kwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718098208; x=1718703008;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEiolzJ9Rm1ucL36ZKdGfO9BXAHThbq3hA10O8Bq52E=;
        b=n7oo6UvisLzum99DlV9xeVXQGIeuLz6FvsAGlFdF5BdHetm3ieMCu12ZL6i2mGY2Xo
         lr1so+USqYGA97X5hn7y1mROYz7i9suQZ6jAOz2Q4XD0yUuhSmwLju4wyjkyar862XFa
         BD+8ZnO7b5ayv3SpoPyDaT+G5sKvgDw941pk5tenQQjabYQakMN3cxuvS3RLWOShJFhn
         ShC3ParH0HRDAj2zL3NZyfrM1oiHZngRiBhWb1BcHvVhQ4YScJRB5gOtIQkJrSrkSjl4
         lRazYHp22tgxkZjtvoX7EM1xywK7RbXs8vaZ5RXQvnM08YtOpzdW1ClOsHLrbAuq2V+2
         S/MA==
X-Forwarded-Encrypted: i=1; AJvYcCVcrX2Wv9AqCJun+pWmYRrTgupzHcuG1zsUV08/qSyeGWRMFYFOqjIY7wZoVnduZ6SlmI1hnv61mNGmPxv/HIuGSIBdZAel
X-Gm-Message-State: AOJu0YxBAPD+FBg+OnljS19Ovl9jA0do1qTKFaNQEcE1T0aERSFeRP4o
	c2NIlRQxXAc/J6MhvpyJOaWaJWKXHebJGXlaYQwnGhwrsCJcNZycbDTyN8APgGM=
X-Google-Smtp-Source: AGHT+IHgSKwaveghpPlJADPqdDkr6LtFnf8M7V3JtUNRohufMYfKUyiu7bTEjWZm42g2TjAGmhoQeA==
X-Received: by 2002:a17:906:468b:b0:a6f:dc0:d6c5 with SMTP id a640c23a62f3a-a6f34cefb92mr138382866b.18.1718098208002;
        Tue, 11 Jun 2024 02:30:08 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eaa4dsm735715966b.110.2024.06.11.02.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 02:30:06 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Nicolas Saenz Julienne <nsaenz@kernel.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Joy Chakraborty <joychakr@google.com>
Cc: linux-kernel@vger.kernel.org, manugautam@google.com, 
 stable@vger.kernel.org
In-Reply-To: <20240607160510.3968596-1-joychakr@google.com>
References: <20240607160510.3968596-1-joychakr@google.com>
Subject: Re: [PATCH v3] nvmem: rmem: Fix return value of rmem_read()
Message-Id: <171809820628.51273.17270495551404270565.b4-ty@linaro.org>
Date: Tue, 11 Jun 2024 10:30:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Fri, 07 Jun 2024 16:05:10 +0000, Joy Chakraborty wrote:
> reg_read() callback registered with nvmem core expects 0 on success and
> a negative value on error but rmem_read() returns the number of bytes
> read which is treated as an error at the nvmem core.
> 
> This does not break when rmem is accessed using sysfs via
> bin_attr_nvmem_read()/write() but causes an error when accessed from
> places like nvmem_access_with_keepouts(), etc.
> 
> [...]

Applied, thanks!

[1/1] nvmem: rmem: Fix return value of rmem_read()
      commit: 139eb4bb33a2857fe439c02a201a85af52ce6186

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


