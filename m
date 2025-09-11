Return-Path: <stable+bounces-179249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E0FB52D46
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 11:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3141E7A7AC1
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3892EA49A;
	Thu, 11 Sep 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZILn9q50"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3422EA147
	for <stable@vger.kernel.org>; Thu, 11 Sep 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757582984; cv=none; b=AHLB99xvwhnhT/uQMjGU25WznCS9qQlsOtMfhKxv+wSzSV5myzi8uCXALafXLiU4xwtJAKcdnscLXgoBWXj3Y9b5ZI4ItrQ2BbMU69YlMJ0QtAJ66o9c00B0kQ0K769P4gWnJluwuftmoKPObrXeiGc6Ms8i0WzMrcNCjhfeEpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757582984; c=relaxed/simple;
	bh=aD+vVYVhj1ox7WHNmXKQS68L0Zye3qkpz4fixE8sgUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VlFC7diLfPPdtm6s1gKff6DBjCbj3nl6A5oznHS4Dtgbe8DuHVJOHK4ySFFjuUjTyRoFTSC+AVFPndGrfUfcyZMky43XPM0OynTq8gzmoRu1BHNulT9HeOemCbmRQb1xd/AL4Yx6dyuYFAGVoy/kCVWg641WorJQ8uL1NzGUxjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZILn9q50; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45cb5c60ed3so445925e9.2
        for <stable@vger.kernel.org>; Thu, 11 Sep 2025 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757582979; x=1758187779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hC+hJQkcVSXLbc1lxRNyfmEb4byMZ95qWgYNvEiyn2w=;
        b=ZILn9q505Be7nFGFxpjI1BtMrDCsBqHeLc6shTE5h60vK/24maUDoaYTrGRmPYgUFY
         PW7C/OT/BXMnHWb4yZWkGoj17xM5AlgOQq7dzThfYexegCzo3WlV4KvuKE5diaZqjfqh
         R/Zrb2AMFvLZjjDwlcObmFHCFpVVx2RaCKiF9iun3LfywTqX/kho5/TvSDL3lYhTwas/
         sUSNKHa5iAQHswha1ptUXIOoArZ424o+fgY6RhJKbXkoOVhYndGvoNlOHCTcJS9OR+hq
         8lRAOy7nCNeeQtfr0T7TDrHwK5kdMYRyoPd2rd6w93MJZGqAEUquXVAsofrseNIhi0RF
         +9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757582979; x=1758187779;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hC+hJQkcVSXLbc1lxRNyfmEb4byMZ95qWgYNvEiyn2w=;
        b=wCanqZy9hLAyAD6VZV78J019nCf2eZ79igVWLism412EQb3KNuEoVxyGdS8kuYEi8R
         0VXRicCAZ9VL+WdwCaOGnHDtafIutEtENA8oalxi8y+X3tfuE43Fy64DqPcaFhrJg5Ay
         3k0yH/dT8fmTv30L7Pm2Exjlgtnrxz2zqXr3Uiw2Bd821QnD3QYzjAvnPNjjK0gqiEVk
         46FWW7U1TWPn+vSVvElpAZ4en70ExUEzZqw6d1Xst1XVL13EtD5lvNQEIBXHMFHwh1M3
         zObAb199R+LhkD3B3vtv4Z3M61LxBYxrbDTnXZiCdTIjjS3H2LqLAPERJzqUWV6158fS
         IPfg==
X-Forwarded-Encrypted: i=1; AJvYcCXgn1VR/fzriaagP1JPidqrI0H/znZfcd1AZz2EAK1anoX6s9wV9JMMJa9yyKax/SjVD9AJyyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNbGCxOwqdxkl0JyTzNqZybWfzLGqKMZU6fdyeGiP6auceb2DW
	k+GBFSKhEAWoioOQmkV/E5xIr/Dx6oxmFhaRHKevx64CxuAlFXAjvMofArUynajLevM=
X-Gm-Gg: ASbGncu4/XLc1rffx6s8mrcg+q8m4W29U8t33RMpim9T2BgLjMdey8NKYyExnwArbLW
	/KdjQ0gKskU6lbJseZ1yBSnx2zDnnqjmLKePXPnqiXId+uNIH53948boEsnWD3hHvLDDRa+KvfW
	hM6cQwFLIZHVtD9h0l7rkOkmEVgWJAtMrkqHlevn48Dt2TBNI08Klqrb3IhdoZF86DSCNuIpcK9
	bAvwwRDWSZ6tXvazlSCAkYPJA9PFzzWIrUdwxkpcLQjMw3iR0PK6d5+RpEABzos13JAg+BBNfdB
	SWdP0EO0KZs9Dzm67rtLpyJcl/rNtQaZwAv4Wp65vtIy0xj/b6h43apCszS8DfDlFF8FY9A5kkY
	bok/TVSsoD+6M1M5cSAYui3IXcRMScoX3DXZP+d0vpy2b3jlg3w==
X-Google-Smtp-Source: AGHT+IHLpivrFJJuNi2aFsQowzY2Z21CVbIySOCBNLdn/DehLTyA9Hoq5rzO7sBA4BakWwnpnraSTw==
X-Received: by 2002:a05:600c:37c7:b0:45b:71fc:75cb with SMTP id 5b1f17b1804b1-45e02a94b69mr7953895e9.5.1757582979441;
        Thu, 11 Sep 2025 02:29:39 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607d75a0sm1731484f8f.44.2025.09.11.02.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:29:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
In-Reply-To: <20250908-acpm-pmix-fix-errno-v2-1-bcc537cf3f17@linaro.org>
References: <20250908-acpm-pmix-fix-errno-v2-1-bcc537cf3f17@linaro.org>
Subject: Re: [PATCH v2] firmware: exynos-acpm: fix PMIC returned errno
Message-Id: <175758297808.29372.10913804909854615057.b4-ty@linaro.org>
Date: Thu, 11 Sep 2025 11:29:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 08 Sep 2025 14:02:00 +0000, Tudor Ambarus wrote:
> ACPM PMIC command handlers returned a u8 value when they should
> have returned either zero or negative error codes.
> Translate the APM PMIC errno to linux errno.
> 
> 

Applied, thanks!

[1/1] firmware: exynos-acpm: fix PMIC returned errno
      https://git.kernel.org/krzk/linux/c/1da4cbefed4a2e69ebad81fc9b356cd9b807f380

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


