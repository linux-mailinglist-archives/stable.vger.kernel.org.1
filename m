Return-Path: <stable+bounces-16228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B6E83F2E6
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 03:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBDE282C3F
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 02:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC9BA3F;
	Sun, 28 Jan 2024 02:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr7BWLKW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C12D8F7A;
	Sun, 28 Jan 2024 02:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706408254; cv=none; b=QKJRfFLxZR30erhR8hHmf7IsAKgnUVYAAOGsflFvKkrLGer1JoDvdDnXLrNZeflenASqtfPO64jTmVez5KNNoFafNqXwdhxu/KkdAxYy5oAmJS8z2rx/+htxcYMPGo4wKZerxHAYVjuuORXNBiXmsx4RxaJ6mosptE59XYuSgGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706408254; c=relaxed/simple;
	bh=ZbJOu5LKswB4T8UzyEXjsEuS56DwkLrDfR3gGtYXBMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ze77rAi842Ea7BOUWI+5RTKKatmj/2l/6ZjoHGtIySxG3nNTcSLKpmaGy6WReNzcAasNtHPuD6b5e3eiz+54HOGRr1XOtMhOYqk8l+z3XdnDcNGxuB8tJ9gmHO0e+cLM5ef4J7FB2NpRvE/9mCSC0yoNuzI8ffWDhR5r84Z/oho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hr7BWLKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6001C43394;
	Sun, 28 Jan 2024 02:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706408253;
	bh=ZbJOu5LKswB4T8UzyEXjsEuS56DwkLrDfR3gGtYXBMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hr7BWLKWNlCItl9BMmLR1Dk5jGrlk5XcWvGS7NH8kDH31v7j3iYzCm8u2i5qqG7uE
	 7pslFI8+hMH8pA48O+RSjYaGvH4GQE4ftFvIxvTIR/XxiUqrJ6xMU5EcFSQwdEVtUD
	 bnJbLjSXXryQ8/u9E0NelwejYUkl80SoNvoKAryZYG1ow+DBowciMenVFbNb/TYWge
	 SYILJRAfZJc1DtdAygYakzoxGERKJTjtN5ntdHWi4aNemCzI+qiNAXMvlIng5LW4ol
	 KN2xCQXj2gI59S1bwdcfso5cPVYXOdfy92ejImMEt+OJw5M7dyZbW3VFlPC2vZL+lf
	 J6gAp0SUrexkA==
From: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450-hdk: correct AMIC4 and AMIC5 microphones
Date: Sat, 27 Jan 2024 20:17:20 -0600
Message-ID: <170640822843.30820.12830781344408633837.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124121855.162730-1-krzysztof.kozlowski@linaro.org>
References: <20240124121855.162730-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 24 Jan 2024 13:18:55 +0100, Krzysztof Kozlowski wrote:
> Due to lack of documentation the AMIC4 and AMIC5 analogue microphones
> were never actually working, so the audio routing for them was added
> hoping it is correct.  It turned out not correct - their routing should
> point to SWR_INPUT0 (so audio mixer TX SMIC MUX0 = SWR_MIC0) and
> SWR_INPUT1 (so audio mixer TX SMIC MUX0 = SWR_MIC1), respectively.  With
> proper mixer settings and fixed LPASS TX macr codec TX SMIC MUXn
> widgets, this makes all microphones working on HDK8450.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450-hdk: correct AMIC4 and AMIC5 microphones
      commit: 915253bdd64f2372fa5f6c58d75cb99972c7401d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

