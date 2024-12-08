Return-Path: <stable+bounces-100075-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DC49E85F7
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D618C1885025
	for <lists+stable@lfdr.de>; Sun,  8 Dec 2024 15:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB7B15855C;
	Sun,  8 Dec 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkYeFAWG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB2E13AD03;
	Sun,  8 Dec 2024 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733672395; cv=none; b=HbC85TpqCtQX+5mp8q3EdUa85ridkLOdZ1Js9Nzlrzi04lbp27ZCBi6b3pYqrowWjyi/E7/GoYgonNN6/OdYtXZGsFFXS2MxFuTWr5D7PVBK9+eVL7SxxZQm5h4b0x9bqo6Ww6sZrDeSVfNG1E0Q8XWIIxSTMMfGjIdiLr8t7PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733672395; c=relaxed/simple;
	bh=Gx5f3shkmroS7Y09AqZgaEyC/C5onrqzjrHhIwJpBz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nB5CjX26CjLv+pyCayQyy+JFxJqKbJV0ESkArm03y6eGeFHD4BG8eCkECp+GWyOpisvt5Yp6rtzPy9C863maH+prLl13B71Oz5ykxDP6DD4k7AdHUQxnT8zkk9T5vkUXbDNNp48hSIcI6XeJSKjAXIu/4GKCB2H97/e3niKZDvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkYeFAWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEB7C4CED2;
	Sun,  8 Dec 2024 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733672394;
	bh=Gx5f3shkmroS7Y09AqZgaEyC/C5onrqzjrHhIwJpBz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YkYeFAWGk6JHOupu1GMUBk0SlM6p+IOAw9vlYwa0MdY/jyia66J1rVBvr/o3RIC8S
	 gtskvfoaAZFs5C8SAqaXYDnPNwsYvZhraWxfqO4v2TvvTS4Lp6uMKfVR7OJr2ZtIf8
	 2aiiJ2ySwZvRm0/tdxuCG/5P4StdL8Cm7cgSCx38HaZOq6qAjLMc7WpH8s3hcfobDb
	 FAEe/XSVC3MUk/4xLqw78bqG9ZgBl3jxtEHuneG/fmn9zAvmj2CvYGl1+ShGv/Nlhk
	 IWvPp/lKaqvnyobiwzi4QO1W+pQOcZ+NFIA2R8mMGN2D9J3ROC0TdW0Ol7jEhwgDcS
	 T5mOXoYq+tECg==
Date: Sun, 8 Dec 2024 21:09:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Sam Protsenko <semen.protsenko@linaro.org>,
	Will McVicker <willmcvicker@google.com>,
	Roy Luo <royluo@google.com>, kernel-team@android.com,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 5/8] phy: exynos5-usbdrd: gs101: ensure power is gated
 to SS phy in phy_exit()
Message-ID: <Z1W9xuCrn40uPWbr@vaman>
References: <20241205-gs101-phy-lanes-orientation-phy-v3-0-32f721bed219@linaro.org>
 <20241205-gs101-phy-lanes-orientation-phy-v3-5-32f721bed219@linaro.org>
 <2024120528-poker-thinness-6cfb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120528-poker-thinness-6cfb@gregkh>

On 05-12-24, 09:04, Greg KH wrote:
> On Thu, Dec 05, 2024 at 07:33:16AM +0000, André Draszik wrote:
> > We currently don't gate the power to the SS phy in phy_exit().
> > 
> > Shuffle the code slightly to ensure the power is gated to the SS phy as
> > well.
> > 
> > Fixes: 32267c29bc7d ("phy: exynos5-usbdrd: support Exynos USBDRD 3.1 combo phy (HS & SS)")
> > CC: stable@vger.kernel.org # 6.11+
> 
> Why is a patch 5/8 a stable thing?  If this is such an important bugfix,
> it should be sent separately as a 1/1 patch, right?

Correct, one should move fixes to top of the series..

-- 
~Vinod

