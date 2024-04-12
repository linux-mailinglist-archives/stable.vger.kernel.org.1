Return-Path: <stable+bounces-39242-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E210D8A2337
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 03:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FB901C214D3
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 01:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3CD134CE;
	Fri, 12 Apr 2024 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wa9HJT4N"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382F12B79;
	Fri, 12 Apr 2024 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885251; cv=none; b=Y/7mEfiCHffK4c52yEXSHA4feyZxstDbZSmWujyqNnpSTS9aS9NiaOWA9Cl4EdfN9G0CDoAEoorkJ9Aui1rECwRFMI+JEw7X5qt70xEnk3ZyvpPFCOVmJzgfL+thY4atsJ74ippIqpsH6GjzzMdFB35G+nbZ5KPCPmhGkcgAMow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885251; c=relaxed/simple;
	bh=Ftl1ELwoUg2yhIIHfz2G1tgb+Ro1SsK1dVV7+WesnzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UI9zfiDUoyVVty96/eXPuV4+wY76fR4mSn/SohaFfd8x7AFsJy6SZvYuIKSFi7irBnmJZr5RtyVV4jw44s/YnV1tVu2zDbl35n+OMTVyNpfEshOda+4o6mUfQ9nWvF7U9pxNiBBfnIDPxSkeRfAu1kdAdKWCS26hUFhg4OLDC7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wa9HJT4N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AB3C32781;
	Fri, 12 Apr 2024 01:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712885250;
	bh=Ftl1ELwoUg2yhIIHfz2G1tgb+Ro1SsK1dVV7+WesnzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wa9HJT4NX2U9KixURe0OmDMPjdp9Mh/udp2DgLxOk0T2fcCR7+N45J6MTJUW6bsvh
	 9VZTiGYMMyIN9DEhzRR1ZsaqWCHkzKp3ssYDO+P0s9Fhy9deoiHi6h/EGbS82BY2jR
	 ADYy7X0+FENxApBVTAbsKCxR1aCbMSdKEWeGqDib1TPy1D0QA3Woa0vUBWqxjxRJCx
	 yrhbIeRLxsSAXnUvo8mZnwaxvR/G/GcbeQaioCU2GPe0xmdy5CFBDf8OrCdjhfNaur
	 7LRvXgsHxrmAlOnJx+ejBS5ciMbPxqwCiwu5rYFgwJ6IJTeQheSLIkYp+qvFA5tCH+
	 vMzaABd1XIyvA==
From: Bjorn Andersson <andersson@kernel.org>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Johan Hovold <johan+linaro@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] firmware: qcom: uefisecapp: Fix memory related IO errors and crashes
Date: Thu, 11 Apr 2024 20:27:24 -0500
Message-ID: <171288524180.749915.6159719966958784520.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240406130125.1047436-1-luzmaximilian@gmail.com>
References: <20240406130125.1047436-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 06 Apr 2024 15:01:09 +0200, Maximilian Luz wrote:
> It turns out that while the QSEECOM APP_SEND command has specific fields
> for request and response buffers, uefisecapp expects them both to be in
> a single memory region. Failure to adhere to this has (so far) resulted
> in either no response being written to the response buffer (causing an
> EIO to be emitted down the line), the SCM call to fail with EINVAL
> (i.e., directly from TZ/firmware), or the device to be hard-reset.
> 
> [...]

Applied, thanks!

[1/1] firmware: qcom: uefisecapp: Fix memory related IO errors and crashes
      commit: ed09f81eeaa8f9265e1787282cb283f10285c259

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

