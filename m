Return-Path: <stable+bounces-43161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C38BD85D
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 02:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD93F1F24046
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 00:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B85C622;
	Tue,  7 May 2024 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtTd+I4b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56717C;
	Tue,  7 May 2024 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040277; cv=none; b=BpbDRQprj69ulrIhKHdW5OFNxo5tCuUd0mfIK1LaCxoTKOJercAVlsv6VkQQFFPmiwOXKImlKz/1ExuBVRxvOzyOK/aEuFJZO0W6bwYU6eM5a2daEDnz125hk0VLmJno9Sj4BHefevydALB7HK/nw6DHz382hj9m6tE23jTRT3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040277; c=relaxed/simple;
	bh=CnpWjYWf0nEtcCfe4MoiuANX57ZSPXjhuiL2jphhHww=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=bl+3BsymGjUTOT7+IVGgLrC52h5mJj1q7uLiXHQ3jKHMwmTYnloOw+nRuhysNPkpBKqhRsmhM51Q3I2JNplG85LYrZaDX+HWpbShGrvG4cuKlOhD+4Mg/v0gsj19S+yuo7c0eIowoTXkYGlTeTDaO1Mdv91lmvtttqWCfzABa8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtTd+I4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4CFC116B1;
	Tue,  7 May 2024 00:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715040277;
	bh=CnpWjYWf0nEtcCfe4MoiuANX57ZSPXjhuiL2jphhHww=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=OtTd+I4bjsXdhE2KzPujqPkMlyaOqwCE4xpPHoQ1clZiQYe1O2bhtjK6rzySYkzuu
	 1WmFdGyWIFQ4tNGQIV2v+7f/9eiZTeXEgEFbWULhBmsg6M8WEgvs9vFcPUYBoFHve9
	 rRzW4rjZ+gI/5ZkjNShbOOOWhuRJJAPBl7rECC6k6Q0qEslDWkE2tPHIW55/51bhEF
	 WhpWeXf0P91WICXePiDPWBr5A3i+21hT+d6AI8etrOPn1cNOXsQrsDi/wjgtlEK84+
	 Dn5GfK9ttarZ+xARqrIE0RIoyLcEeJZsojlNRijpq0Fl6XKXxh8kf70JUqlkmuUrEI
	 0ORwJxtwQReWw==
Message-ID: <ee18e89b77f0c08ef45cbcc75e2361bf.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240506063751.346759-1-quic_mdalam@quicinc.com>
References: <20240506063751.346759-1-quic_mdalam@quicinc.com>
Subject: Re: [PATCH v2] clk: qcom: gcc-ipq9574: Add BRANCH_HALT_VOTED flag
From: Stephen Boyd <sboyd@kernel.org>
Cc: quic_mdalam@quicinc.com, quic_srichara@quicinc.com, quic_varada@quicinc.com, stable@vger.kernel.org
To: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org, bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, quic_anusha@quicinc.com
Date: Mon, 06 May 2024 17:04:35 -0700
User-Agent: alot/0.10

Quoting Md Sadre Alam (2024-05-05 23:37:51)
> Add BRANCH_HALT_VOTED flag to inform clock framework
> don't check for CLK_OFF bit.
>=20
> CRYPTO_AHB_CLK_ENA and CRYPTO_AXI_CLK_ENA enable bit is
> present in other VOTE registers also, like TZ.
> If anyone else also enabled this clock, even if we turn
> off in GCC_APCS_CLOCK_BRANCH_ENA_VOTE | 0x180B004, it won't
> turn off.
> Also changes the CRYPTO_AHB_CLK_ENA & CRYPTO_AXI_CLK_ENA
> offset to 0xb004 from 0x16014.

How about this?

 The crypto_ahb and crypto_axi clks are hardware voteable. This means
 that the halt bit isn't reliable because some other voter in the
 system, e.g. TrustZone, could be keeping the clk enabled when the
 kernel turns it off from clk_disable(). Make these clks use voting mode
 by changing the halt check to BRANCH_HALT_VOTED and toggle the voting
 bit in the voting register instead of directly controlling the branch
 by writing to the branch register. This fixes stuck clk warnings seen
 on ipq9574 and saves power by actually turning the clk off.

>=20
> Cc: stable@vger.kernel.org
> Fixes: f6b2bd9cb29a ("clk: qcom: gcc-ipq9574: Enable crypto clocks")
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

