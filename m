Return-Path: <stable+bounces-177729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC4CB43D34
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 15:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32445A5860
	for <lists+stable@lfdr.de>; Thu,  4 Sep 2025 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BDB3002DA;
	Thu,  4 Sep 2025 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="giQSzoqA"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B427D3019D9
	for <stable@vger.kernel.org>; Thu,  4 Sep 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992541; cv=none; b=ONg2RQz9Rtl35UuJ7E1Kr2x5NJw7q2Ze8jOa4iQ86myfvQbEz4oKrjxrKU3JeAnbv4v9TDp9OFJ/4fdrW3MBH11wKlwhPi7Hd5PrrI3+aKyXx0XmEIMwlTyIvIGy0ctRuwid1NfGUzGv4mdXbz8ajzIjnJWfS0hZ8iikIME+tNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992541; c=relaxed/simple;
	bh=wqa7Ca/07c/im0pW7NjeH3wQc1LgXZaFgUeldip/esM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=npbP/kY0YiXVbagBN20FF9GQZhNsFtwTI/j8ESVVDZmLAu9UWRjZhLhpQRBjauUILAY+Du3mlqt2KrLQmOnZ8+IzHHavW5VvC85XyS4DjCYWYn8rKLgiZSUGD5C2YFXpx6ypq6SNKasrp5LberDumtbxDiUKq/UWsHBveyou4/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=giQSzoqA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b627ea685so8660335e9.1
        for <stable@vger.kernel.org>; Thu, 04 Sep 2025 06:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756992538; x=1757597338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwjkP+OkdyXJDv66oQ0CyedXSSfDjbG63ToGTcAWABQ=;
        b=giQSzoqAO2QYW7G900Zd98DCdMmpI4p1e2u1BztSTvzN3wIzrnuq0gfhmWwIDNQFOl
         QrCbEN/oYvDWn5uW0tGXNoYA1ZQ/0ziQoKeCyflqhPic3b+mT4euKRkolkYCexIxg+xX
         GRlCUz5eEwiUyKBifI8TSHvH2I/e6bJWLlCwyk7rrihglcCWCqM0k+WPstmSuiLkLAr3
         BISp2jWTCCaQnSBUJmUH8Et1oROjQ30BzzTPQDNrPcqiLmLDiHSraMJaZVFQ8vwMYQNe
         esMpJ6Mph4Dkw8CmTJjea8A6bjc7SNyfuRnJNYSnXnXUOfqT1UidltYZbDkhfBIiOfk4
         KbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756992538; x=1757597338;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gwjkP+OkdyXJDv66oQ0CyedXSSfDjbG63ToGTcAWABQ=;
        b=dy03np2s04u/QiC25DoqK0CExar9naR8azV6CNYW29Sa7PbNSBiPP1P6F4KXgwyZxX
         LBxMgdv32tAv6cTz89cCP9q+JpqqQ38EVTqHmxfDojfkJ+CE5ugsagFHwcuhQQ4rOGs1
         LFKx+P1I0wtPUqzr0lefPWwyu5fawVn3tzxaMx4jfLDxc6TUPqjOzYZYKpNOaVljIFhY
         x8z8YX+fTUxVG9+LqBlXP8+fD3SPzXwDL80BZTClbLmcvE/TuDbPUG7UsGlnL/AhRWzI
         TAcUju04Jypu1l9imk28N7proZCgoUD7kEHVjNhcUWnTx8LUdu8AKbclf66nZPCKc7ep
         legQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM9XM7AoW5+py1sQ/mgzsuIzs9pLCRl3byvkmmu+3ZogY5KD7n7EedwFx9nWXps6DE0MFITVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw663tjWIDUs2XWyPZEmugJkVI0Sqosg3D/Ibsi4bR7lJC6SUC+
	Pu5jEWEKS4LA6m5LTbg+OBy/LFQ55pg8NUflHgl2noQgS7lxOB9QO1CFUDIEFPPf/TY=
X-Gm-Gg: ASbGnctae5yxRapJ4VmhpkTRYHiP3bGntPhVkRUbbjVZGz0XIk6ebR3yIIErDCu7UuN
	boV74Xnzbcr2FDoNpHOslSeV9BB7tqb47jyriOHKQG5cddHYDQqE8AS8+d9jNkZLX60qH4VDVnl
	EMwzI59AU8Xr5efixrGcgubxyXJ3ff3YzL0YrhNsE3RPb3NV4fwqB23pgE2xDbaeJ7G44EE1llU
	f96omUPH0Rjrzesdkmj+8bRyJSHt1fF1grbHDr//TFDTvyw0Rr5QFBlXtM8EabmAVv+mhYWTZyp
	Tk/HrBqHaXGvw4J6KB0V73nLll3vyTfYclB2vC+pSDUnFtctG81XBwl6LxKSS/Fe5GTJxNEDZSU
	WEm/inqBfIWCWMC4Sa38TsI0ZHRayuQQAWOlX99QBLmuzeJdjDbCBbw==
X-Google-Smtp-Source: AGHT+IFc2iqk3tYMkm4EFxxL9R4GOj3DzOJyDOMOzUxuB34nLUq08b5Npz5Qy7crtT2kbpIf1kyDew==
X-Received: by 2002:a05:600c:3b21:b0:45c:b6b1:29a7 with SMTP id 5b1f17b1804b1-45cb6b12b8fmr62352635e9.16.1756992538058;
        Thu, 04 Sep 2025 06:28:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0869b33sm34579425e9.9.2025.09.04.06.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:28:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Carlo Caione <ccaione@baylibre.com>, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250725074019.8765-1-johan@kernel.org>
References: <20250725074019.8765-1-johan@kernel.org>
Subject: Re: [PATCH] firmware: meson_sm: fix device leak at probe
Message-Id: <175699253745.3375485.7091705423903700055.b4-ty@linaro.org>
Date: Thu, 04 Sep 2025 15:28:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Fri, 25 Jul 2025 09:40:19 +0200, Johan Hovold wrote:
> Make sure to drop the reference to the secure monitor device taken by
> of_find_device_by_node() when looking up its driver data on behalf of
> other drivers (e.g. during probe).
> 
> Note that holding a reference to the platform device does not prevent
> its driver data from going away so there is no point in keeping the
> reference after the helper returns.
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.18/drivers)

[1/1] firmware: meson_sm: fix device leak at probe
      https://git.kernel.org/amlogic/c/8ece3173f87df03935906d0c612c2aeda9db92ca

These changes has been applied on the intermediate git tree [1].

The v6.18/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


