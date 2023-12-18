Return-Path: <stable+bounces-7073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9416E817060
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC6B2286E
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407D2760B3;
	Mon, 18 Dec 2023 13:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeSm0ZC+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1575BF86;
	Mon, 18 Dec 2023 13:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A39C433C7;
	Mon, 18 Dec 2023 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702905465;
	bh=2D73cq9xpsgZNF8poo2tWxiFzoJi0MVWvA/bi4m11G0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DeSm0ZC+8/uSNx9wqeeaYCkUnK5l2I340GhJP5tg4Bj3mCbL/VRIO7Z0wVdEMa4VS
	 W//CdXR67J/Fe7+HxMfnK57yjZDoWS5GhwcYUMIx/+nf3vDGDfAkiXBm1sODsERI6e
	 1VsRBDkxNCDz3sPvI+7gWRqDkxScv0XSpzCg7vJnpq96X+7/pXkl0BcQYw+q5jVHlr
	 XU7ZpuCeMzCfm9Fp8NSAU4YUzQX6X0oHUEb7GHvpbUG6ON92hcY6RNkSZH4BEGaxmo
	 gEpzz31vYwmTm1ssooSf43tYxacVw9YJZ6tciKO+oP7mNreuDQdItw1wzRb+V2Yunh
	 zcv4ILTaR6fDg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rFDVA-0005GA-1O;
	Mon, 18 Dec 2023 14:17:45 +0100
Date: Mon, 18 Dec 2023 14:17:44 +0100
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: fix
 path to header
Message-ID: <ZYBGeBEDZaBqrh1j@hovoldconsulting.com>
References: <20231218130553.45893-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218130553.45893-1-krzysztof.kozlowski@linaro.org>

On Mon, Dec 18, 2023 at 02:05:53PM +0100, Krzysztof Kozlowski wrote:
> Fix the path to bindings header in description.
> 
> Fixes: e1c4c5436b4a ("dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp binding")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Not sure a stable tag is necessary as these descriptions are not parsed
by a machine, but looks good otherwise:

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

