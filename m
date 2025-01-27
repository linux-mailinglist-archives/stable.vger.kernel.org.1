Return-Path: <stable+bounces-110876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD4A1D9DC
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 16:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ADAE3A4BFA
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 15:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072613B5B6;
	Mon, 27 Jan 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9UdtQRt"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5983B192
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992801; cv=none; b=Y24AhUKb/GiYtf9ir+bZli+7ictsNBK1UZd13DquRHxDBDdnMBWoT1VyY9vhdhDvgFWaO+D4lRH66c3CmbIKUXy0bwrldUgNfuWq0SR/u4+6ng9inKjNem2WYNaTRa8HERJFHYmA6eRJabOgMhu5NKGiuroqtnPVR99pa1yBhLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992801; c=relaxed/simple;
	bh=N1Ojiro8aDPYY2Ui+tNuOUqnHpyjZQL3icPbEdgR5W8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHq5OtxZIE9n4t91i2qsmNJDv/XMC4auskBqScDkPvY5HvQOtFw1b4GFPy78ZGo0hsaXBtq2wv5gHapcaBeqjDpbTLZyy79yKBxKyLEnkkrEq0842W5Vs/pMbsJYrDpkp8VQsU59HQD03I/ri2N4AEncZbW3GV9tSCGLS8Y+dTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P9UdtQRt; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e54bd61e793so7587228276.2
        for <stable@vger.kernel.org>; Mon, 27 Jan 2025 07:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737992799; x=1738597599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FyzF5JKQNS8WVSZnXyHkt17dR177PmUZO2C7o3A2Y90=;
        b=P9UdtQRtsmbwceyISGTJK52CDLmzGMY0OnL3nWBlQRDvaaqRGtZx4NJgWRmvyK8zQ8
         JnQwKcLl46wsLQ93Z2xzRFzxbZjYhmwRuIXy1l8Def1eI6e1noSvfHqVLDOpLMkUEWST
         J6zJ2S88IyTNyMERi7waH8QGG8OQqNMziXQO5i5pvXeCjNb0/FKSQWk8dYphyOh6ti4z
         WhPMBzsinW8KE0IxojSEh6ykAumofkGqnNAXZzXrvwJ3Ed3g/BBfof01Co/bNTwoVK+M
         drh+Pi6f7U7t6q0a9QjDpLWFSvdBAXNyAlAayOkVcSJbytF5yEehsRoYEmRi/IjnVSqi
         Rd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737992799; x=1738597599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FyzF5JKQNS8WVSZnXyHkt17dR177PmUZO2C7o3A2Y90=;
        b=fcJPZ+Nx6ku/8GFz6jbqA+QDxNSY3Khr5lcTSn1tE0cr0hcCKCicwminVzIkOAbBNN
         Dn8EQ/agly0pp1OM+iaSQurhZcaqLNw+buBDeTrH5I7vP/O08DvlZa8nX5jbgYZvIy8h
         +oqfnWcUjSwrszgnTBf/vanIn+Ip3RWpjOFpiGH7BZ0ReEVRqKe8QfJQEgdCjWsaxDXK
         M1kxQRo3oNgIRoeUIU9tDS+zUiEocS1l3p0L9hvcjxGac59Zk7qe2T5iowIf2DW0p9bh
         PkYQ6tq229mYmsBhep4wZ4waeckHeqLuUO55QmKEktzImY+TV7HUhF1SCxFa13k2Ci78
         LGww==
X-Forwarded-Encrypted: i=1; AJvYcCWLklHoKKinQl653Oc8CPotuJ9po/RmpLlnnxNOmUZNQHayyzFnUTYpnYP/l8yg2bV+b5hA09k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHzh2nJydg0YbBnlXTwg6UMCJLN4SlQHrxObiItEuLFNIfonV1
	uikQlMY0FxlPhPMKGk8UhtyCsXlYt15Vo22r0xQeVF0Cvt61RghG+GvdLnvgATAYiymG+4wnJ3E
	G9j/8pszgJNnquCtWWppuN0AItZ9CUmQyCK/XlCrWAODaLUXC
X-Gm-Gg: ASbGncvUQ+coeQfqBwqK7FoT0R3z2gJeJhmp5tal4w8i3nFBLqZBY7Xios0qpYxek+8
	F4wn6g6MJVvpJOLoBBYwWwURtKsdpC882RzWY+aIh4yXTx8V3p43hH8FJEbyZfmGjGY1JxWXvKc
	tXneXbIypDwuU20nsPfw==
X-Google-Smtp-Source: AGHT+IHZaLOKkERtiYS5shkEjMAlT4iStOAU7WeU2T2q/yIKvnOtjzJiNS+UNV5Jv1kfmhHEVL9ETxrqPamzGSdb3SU=
X-Received: by 2002:a05:6902:1b81:b0:e57:414b:577e with SMTP id
 3f1490d57ef6-e57b1051956mr31803374276.12.1737992798737; Mon, 27 Jan 2025
 07:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120151000.13870-1-johan+linaro@kernel.org>
In-Reply-To: <20250120151000.13870-1-johan+linaro@kernel.org>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 27 Jan 2025 16:46:27 +0100
X-Gm-Features: AWEUYZlPxQezcPWC_RlZRyj-Wpd76XVtWwXGlnlr4q8ReulBHMnbsaHMT-5UGVU
Message-ID: <CACMJSesr42T=qr8GoUwxGB51mnr04TB6j4_hztGAFXx008ZJLw@mail.gmail.com>
Subject: Re: [PATCH] firmware: qcom: uefisecapp: fix efivars registration race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Maximilian Luz <luzmaximilian@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jan 2025 at 16:10, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> Since the conversion to using the TZ allocator, the efivars service is
> registered before the memory pool has been allocated, something which
> can lead to a NULL-pointer dereference in case of a racing EFI variable
> access.
>
> Make sure that all resources have been set up before registering the
> efivars.
>
> Fixes: 6612103ec35a ("firmware: qcom: qseecom: convert to using the TZ allocator")
> Cc: stable@vger.kernel.org      # 6.11
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

> ---
>
> Note that commit 40289e35ca52 ("firmware: qcom: scm: enable the TZ mem
> allocator") looks equally broken as it allocates the tzmem pool only
> after qcom_scm_is_available() returns true and other driver can start
> making SCM calls.
>
> That one appears to be a bit harder to fix as qcom_tzmem_enable()
> currently depends on SCM being available, but someone should definitely
> look into untangling that mess.
>
> Johan

Yeah, I have it on my TODO list. I'll get to it.

Bartosz

