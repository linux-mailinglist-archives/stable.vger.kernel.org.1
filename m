Return-Path: <stable+bounces-142015-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF55AADB9C
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C04B4685C0
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2921FC0E3;
	Wed,  7 May 2025 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0TWwhpa"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013B1F4CB0
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610858; cv=none; b=hUR/wD1PW2P7WA9xtbJJRnbsJVgKL0Ar6JqAzlhEVFbNMrSdKJol2ZADlH2f8sTfwZU576Xy4O0MFtRqn3lh5wynfGyzlUlijVRXpMcKs1EWZVbjruz7r098cp1MeJoqA/lUxdaq5mCk1j2EV2UQBiFtGpW6DvvDJjolGqdAiB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610858; c=relaxed/simple;
	bh=ZAkl/D4HYMiTs8TdHPaNq0qUfW7IR4yaQoTiRnukCNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q4hzuUBCLBtsaoOqQztcTG2dzj0X5QgPLg6H/LmpQZQb+GGV6RfRSMGwPUrEWjY1WF/xi+z8woHyLZlWmKVMv6ajMAzatA0+XyPX8NbXDMm/GjtsXuDgcjvK3etrW6eu//LiH6BlqS9fMp099z8Xi9E++WJ/GxgmyFsLEwjh5Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w0TWwhpa; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cee550af2so7127975e9.1
        for <stable@vger.kernel.org>; Wed, 07 May 2025 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746610854; x=1747215654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjJVOzsV/sS1KqYgiKb6WpgqfUC9eIpjHHMhaITJ/3o=;
        b=w0TWwhpawoLeSkCQGcoV8GTgRzYmEFfPFh23PuMqFSRdcCIpmO5a3VaX/cuIUcG6K2
         33mFOXKr+Dmupwsiejyx57b0ygRbyyJvEuf9Y09sSjQ8DhPO4aDXw6rH2rslPyr1HXob
         c++ACrZYEa8Ou9yr771B3zBquhM0kUWWwWVuRKI/ibZKNSpHZc76K6pYv9RXWkbefdnb
         fPtB0+6O1vqRVAANeLAdCI6rr7763tDESe7hYpS1E0g8+cJzNntAcqEGdoj8503r016R
         7WFrqyDP+wPDrgDpVtdMNNrIRMxHGJ9Er5mZupVkhu22M9gyeBasYJBLV+aqqNmjQCEF
         VSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746610854; x=1747215654;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjJVOzsV/sS1KqYgiKb6WpgqfUC9eIpjHHMhaITJ/3o=;
        b=tybYk0vkg8Ym1TxBZqcbJdx322sV718QC6BJlLTlN5SHkkWwMD3GvNIxv8fbC+1LZU
         KJkqbMexvbHzc7XS1I2LexzSSuCpS/vgOwcgRXs3GTEvQA5APFdhoOL7JPwXtkqoVT3K
         1zJNTDIuUMPwVTjGNbQGc12u/8VXDM3/ePRQy5yii8xTzcqGALCZym+mEtrz12sa8wZl
         EGaUHi8gOA1nhEYhsqwEhZbo/6RLXFpnp226wiSFNC8qVgddQe4TjqxSPsQe42lmvyQq
         h/tVvMvbwEE/k2ScDi6Zo/H8SCdqd4BMnANmUMBVnSwvk0Za2vLK2tl9geHw9h9ShMw6
         ABjg==
X-Forwarded-Encrypted: i=1; AJvYcCWXRjSc09f6RNWG7/z6lmt5WpygeKBvBb1Mqcp3pFXI3CIR5khdRALQ/2fqZvcGN198vZ3In9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8l6e+0SSOEumCd+IacPdoJ8HFn9HAhK/SGUkTzoo5r5/VvQ1P
	5ySSZfqlKw2ttnFbkKIPXV4Mrcc30GD9qdUJfKEwWxMvJ+JFSFJbNQYCy8Ai+wA=
X-Gm-Gg: ASbGncum3q7jN0BhXzkS0MW3xU7+t75NMOXdXssGUr3mGdykecJaJW0dplRgmuW6jK6
	kb/VHWNwx/NY7KMAysDUKdNHK66LEoScOk/vZ9WhHjBbB2O2kMHj+UBFVDG9fJ4Ah4JK0EKmrsi
	OgedyQ2LX9wjjyb2sPDMFgb5JteGS2peckvabYY5lQVqRN8hJHRMBwoTcRQ7MehI9l19zYEiNHs
	vPjzwgjCvdLOPLqZgsEmnK9eB7VkSdJzkkfzY0wSm83yA9JiZyhEm6SmcZx7+wzVF7+eNA95Qqp
	zsKNJrAHqnVjYjTpBEeVq77c9FmmlpKG6W0wM8uGitApbRuuI4Gj5s7sd1E=
X-Google-Smtp-Source: AGHT+IGTYzGThTxOdxwaI5G+9aUb3aVHRykaAtXbsesYBP9DWb7wZzv8RquKPzZDNQ1IOuOLVdxb7w==
X-Received: by 2002:a05:600c:1c8c:b0:441:b397:e324 with SMTP id 5b1f17b1804b1-441d44ed543mr6268495e9.9.1746610854412;
        Wed, 07 May 2025 02:40:54 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.207.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441d438e7f0sm25374535e9.29.2025.05.07.02.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 02:40:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Gatien Chevallier <gatien.chevallier@foss.st.com>, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>, stable@vger.kernel.org
In-Reply-To: <20250507092121.95121-2-krzysztof.kozlowski@linaro.org>
References: <20250507092121.95121-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] bus: firewall: Fix missing static inline annotations
 for stubs
Message-Id: <174661085321.105567.10502174461599708056.b4-ty@linaro.org>
Date: Wed, 07 May 2025 11:40:53 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 07 May 2025 11:21:22 +0200, Krzysztof Kozlowski wrote:
> Stubs in the header file for !CONFIG_STM32_FIREWALL case should be both
> static and inline, because they do not come with earlier declaration and
> should be inlined in every unit including the header.
> 
> 

Applied, thanks!

[1/1] bus: firewall: Fix missing static inline annotations for stubs
      https://git.kernel.org/krzk/linux-mem-ctrl/c/66db876162155c1cec87359cd78c62aaafde9257

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


