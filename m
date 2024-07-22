Return-Path: <stable+bounces-60654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B506938A1F
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 09:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85641F2183D
	for <lists+stable@lfdr.de>; Mon, 22 Jul 2024 07:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F7413BC25;
	Mon, 22 Jul 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0b2ciF9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292B23EA7B;
	Mon, 22 Jul 2024 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721633663; cv=none; b=jlZ8dG4O835nW3JGc4SD+xmu452ibATy5iCX3cCevA2u0+/OYHhD9fcc/uji+vdUktBgre6UQC12wO5ZNbI5xRafunqeN3ibu83i/ccKts/MVjqa9vCnIEUR2/eKSYRkeMZ9GDvJGPg6/6gGQLWiBsJUQqbd8DzH8IRV8pWCcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721633663; c=relaxed/simple;
	bh=j3UIQ/6odt/x0J6TOEayHfVkiYIZI2+Y4cGU1nPXJUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxCu5bnsvvzBDWF3Ia21XKjwRYaKvIT5ozvRsrixdw7+kSeZVqAtKhRoNHyNwspfQJcdnruIIB8wvBJqtIIL2IyytIycJSgs1dKIXEb+am/inpwp0B4i9WuLJwCmO4BEzRDCB+gHFrF+Y+WE1T3LzqI9S/lnotjpoKLAnlCdAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0b2ciF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C008CC116B1;
	Mon, 22 Jul 2024 07:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721633662;
	bh=j3UIQ/6odt/x0J6TOEayHfVkiYIZI2+Y4cGU1nPXJUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0b2ciF9TYxN9rPRvP4pqEzCkdtEyIRNDRAOH3dxGsID2CY3+tPoSWueXGlfr1MGv
	 0otXd7xHkz3OAkWkRDjf1BbVK+Ecz0lOsi9jHH4jQs5O5o2+Dw8c+o4qcnIFUkY+2p
	 yasNiytgXwitpEAmWRoTIn2dQY5ojCi0eMnN1ZFC1X6whXAiV/Idfrqd1dMgHPD7Fx
	 nzPC1g4T8B62vgifOpi0E5YeGgZ9IT78AfJaK5GNHtMVzsbnTNiweo+++BLacS7ibN
	 URqO4QOv3ANwahPCi4mhCIjqih5Tsw0AFBAiIwzIDKlpNjScsvTyJHYlNVQ9qCKAyB
	 OlMkl+nFrhgWQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sVnYr-000000001bx-0fzr;
	Mon, 22 Jul 2024 09:34:21 +0200
Date: Mon, 22 Jul 2024 09:34:21 +0200
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Abel Vesa <abel.vesa@linaro.org>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/7] arm64: dts: qcom: x1e80100-crd: fix PCIe4 PHY supply
Message-ID: <Zp4LfXvJJWbXsp1I@hovoldconsulting.com>
References: <20240719131722.8343-1-johan+linaro@kernel.org>
 <20240719131722.8343-2-johan+linaro@kernel.org>
 <aa099580-c0d6-401e-9956-be4a6b595dcf@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa099580-c0d6-401e-9956-be4a6b595dcf@linaro.org>

On Fri, Jul 19, 2024 at 08:34:27PM +0200, Konrad Dybcio wrote:
> On 19.07.2024 3:17 PM, Johan Hovold wrote:
> > The PCIe4 PHY is powered by vreg_l3i (not vreg_l3j).
> > 
> > Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
> > Cc: stable@vger.kernel.org	# 6.9
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> 
> Mind fixing that up on all laptops?
> 
> Most of them are 80-85% CRD copypaste designs and regulators for
> precise things like PHYs are generally predefined for a set of PMICs

Sure. I worry that this blind fate in copy-pasting is going to bite
people, but it seems like at least the PCIe PHY regulators were shared
on sc8280xp too.

Johan

