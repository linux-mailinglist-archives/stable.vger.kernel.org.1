Return-Path: <stable+bounces-136650-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CA2A9BD25
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 05:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D46EE4C1CC6
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 03:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DC0176AA1;
	Fri, 25 Apr 2025 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKerBoZi"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87D2701AE
	for <stable@vger.kernel.org>; Fri, 25 Apr 2025 03:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745550504; cv=none; b=uSgA+bnESc7slgLdo3A1cVbCNiqNpBxeAw6vRYF8pI4DcA7D42NTnMoU45LaMdlCLZEzgQ7+o3VMVmAKk+aQe+mkaZu8YeYzVEdq+VU5++ByOVImqYf3qPazayBR+/XtCDZy0Dkv/cS9xwgarLOMsnyZoZt0huDugEQYISdUjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745550504; c=relaxed/simple;
	bh=yH/Z/PRTvfA1+rSCAWGqs6hvN2TxhW2s7ozO8IADBcE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=f58fPCfw7aW98JhPXgx2j7bUk3EnFyXEwoI4epZ7mPoMqFl34TFO7CMhZjUDRsPrcS5RkA6dqeTDEZvZYihLcV9UtznDLNjjDGOrH1TQ3+DgdvMH7sPw1k4zOYVBtV4AqH2SnMBiGucd+Xu+kQ0ztaaPD79BDi8FIKZXjNF7AXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKerBoZi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so316613366b.3
        for <stable@vger.kernel.org>; Thu, 24 Apr 2025 20:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745550501; x=1746155301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yH/Z/PRTvfA1+rSCAWGqs6hvN2TxhW2s7ozO8IADBcE=;
        b=YKerBoZi9DVdO3np1n0cm4VqvMHGy4U86gMruMXaPp7fGO4e0L1dZmEIeZw8jHLBQK
         1OsthZ7Jsg4z2xeX590BRO5FUmLFhnch8uD1igAK9jXlN4vtWOCr5aBH4nxsjKKHCL8r
         0ecURn6VqohDlgT6+//H76PY+jN18mshrOOEEcDgQgs7jAswKeteYn5heBVjA0DFGxyK
         twfCN9w0YnuKgs6nhz1QqFXNCKCi5MsbsrLBDr2UxBtjQR1kxb19D3OpXhW/CPmK7ssR
         Ejv8um+7WFgtHNYi/xVCgYl136DdVpV6jBNvPpgtO1ygu6KDiZFibswGGSmiuxxRu1Cp
         4yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745550501; x=1746155301;
        h=cc:to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yH/Z/PRTvfA1+rSCAWGqs6hvN2TxhW2s7ozO8IADBcE=;
        b=PvqrkGBUdH4JEc3DPngQ3KCcvzT0dds66z44tdcMyN9jQBHSiKMCecWE79e3lCtOR2
         rtupDxUXcbOJ7yUYWZqQ3Wyo7ExARL6YL8w+BKTUOfYU9y4vnfkNG5NvaDEaba91Iek8
         FGUs7Ix7lLECA2uBjnSgywYIoZABmVX0CIzaFE2o9fgyVZkzqBU/YFTNDYzZQcIPr4AR
         N3SB6tSkT3xxNvK0KC4SEFJCIj7AYRnRgBpq5Mv4jcINU2wljosinaA7VmU44/o8B9AM
         hZrdFbfSHrLKZwqz9zz5zr9pdI2JjcLwjlnroBbEDbJexTcLepidM7/t6TELnMYW7aWI
         vfUg==
X-Forwarded-Encrypted: i=1; AJvYcCWst4cW9bDqOubx9Ks1uqFMWx4XPkNifYzcmznejKYSHiy+OlmYy3wl6cWvSUyT1rGC26Rtq3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz46kLqSPpxKZHk5G8jyHIIs/CWhDQ/0i3XL2D1P4v5jvJFN+3g
	bXdNI9LpVtTJFB/CpWGupB8pxTm4prMOp+CnhqduhURf1GEcxo2cEnQjNSXKHH4n4T8tfYtR58L
	sOZ/CdeeqeR8ewIz9EsGI0/9M2+s=
X-Gm-Gg: ASbGncvjLu6gB4m60fZaUl/iGuSY7ebGW6WSrSoAAw8MMswiJwTkbOvRsiN5Q8wTKTO
	lwfPlLUP9bzaw942ZNi9MmGEwFimdxQCsZr1XTWtuWP5LtPYHaRj8OvMl5Mxx2CEB8/Wg4vSCxQ
	J3rrNA3rKQ72oaJhPQQQ1KEYgumuTUYCZb4VQhu3GyImpSbmx8Ff36Xg==
X-Google-Smtp-Source: AGHT+IFTZWDxjb9CngwcWUDgClV8SVpfjCDk+u+hMOljbm5N5l1ndGMsQhhoIOof9UO1tz1CSqJqMqAD0Ef0SEAORl0=
X-Received: by 2002:a17:907:7f0e:b0:aca:c8aa:5899 with SMTP id
 a640c23a62f3a-ace710ee68amr56139766b.22.1745550500740; Thu, 24 Apr 2025
 20:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Thu, 24 Apr 2025 20:08:09 -0700
X-Gm-Features: ATxdqUE6m3tHkpqq0jp9EcZGnZ1kZGlE2YCE-EJ2hDZTw6EwZYEv9_6PKyM7xug
Message-ID: <CAKSQd8W_+31AuMS2+yMYCMjP5QhzMtOHSmFahidR=3xOHpSdKQ@mail.gmail.com>
Subject: Re: [PATCH] Handle Ice Lake MONITOR erratum
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, andrew.cooper3@citrix.com, Len Brown <len.brown@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> [ICX143 in https://cdrdv2.intel.com/v1/dl/getContent/637780]

> There is no equivalent erratum for the "Xeon D" Ice Lakes so
> INTEL_ICELAKE_D is not affected.

There is ICXD80 in...

https://www.intel.com/content/www/us/en/content-details/714069/intel-xeon-d-1700-and-d-1800-processor-family-specification-update.html
https://www.intel.com/content/www/us/en/content-details/714071/intel-xeon-d-2700-and-d-2800-processor-family-specification-update.html

And although the ICL spec update...

https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/ice-lake-ultra-mobile-u/10th-generation-core-processor-specification-update/errata-details/

...doesn't seem to have a MONITOR erratum, it might be a good
idea for Intel to double check.

--
Christian

