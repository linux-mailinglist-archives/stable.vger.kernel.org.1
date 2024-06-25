Return-Path: <stable+bounces-55142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0257B915EE6
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 08:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A951F22F04
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 06:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6BA145FEB;
	Tue, 25 Jun 2024 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg0sVRIa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49090145FE4;
	Tue, 25 Jun 2024 06:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296835; cv=none; b=r5grJsoGGskxUARSAxyqibz1hrRyLjzI7wfZkBa7c9g9oY/QpPy0vEd6eMmvHx6SB2tQ7x9RJZITCW/UfCjW9q2Qiq41AyZ3il7YbP1+8XGDBnDYdBmHLzYsksElUGyxwXMqfMl90mKidALHdi7DbE5nU4MPX955LFXLclhjp30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296835; c=relaxed/simple;
	bh=69+4K8gfp5gBw29JWo1fquWpYqexLpvOS+CGGlqN/FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSdU21lLXWmgG/AmFbtaAoIC2f3hPWhZosbJ3yPFuzgcHvo1c5I8WkN5yevUlXm7GLsJbsf6PhrMPvtoQqJvka/qLOSejYTMrDQ+/YxK4QVnTRv1ZgvYSMORPIlegWN/1F+LpHdtaYqUUXnCmj8a8H8gB/3jmyu67+yMrqw59eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg0sVRIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C187AC32781;
	Tue, 25 Jun 2024 06:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719296834;
	bh=69+4K8gfp5gBw29JWo1fquWpYqexLpvOS+CGGlqN/FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gg0sVRIaEMr91373fxE9CnrZOIO8f/FktsNUfYtErjNjrTi3QfAX7n3R+4xZfT5+e
	 Zy9sL0haa9rRGdAtEBz/5Krr8UktCg7PSqPY89qk6/h8BsD5OW3lSPV4hkgW/voDwr
	 FOg9rfK5+lXHnzOjBf/XJFRZ8dRsdlKL6/YFe1q2o9QL6cBZ6sYXO+6NVRlxUHvVJU
	 P8aBO0a0KP0HOJfWfXTYB0HX/TJf73gkduzuDVxXh83Lk21lT3e89qJeTdVKQ2ANH/
	 0gNRyC+ksXllg0VhduQk2b/tB0sSAsmHIsDlbK9oNiHj0I9O5jhmScgO89OVPYqtln
	 TMy8RxctXYJqg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1sLzeD-0000000087j-1lSk;
	Tue, 25 Jun 2024 08:27:22 +0200
Date: Tue, 25 Jun 2024 08:27:21 +0200
From: Johan Hovold <johan@kernel.org>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, johan+linaro@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: Patch "arm64: dts: qcom: qcs404: fix bluetooth device address"
 has been added to the 5.4-stable tree
Message-ID: <ZnpjSVGrN7kJMuhx@hovoldconsulting.com>
References: <20240625033042.1608217-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625033042.1608217-1-sashal@kernel.org>

On Mon, Jun 24, 2024 at 11:30:42PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     arm64: dts: qcom: qcs404: fix bluetooth device address
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

> commit a48b0e85558565dc3a10c8021b1514099cada102
> Author: Johan Hovold <johan+linaro@kernel.org>
> Date:   Wed May 1 09:52:01 2024 +0200
> 
>     arm64: dts: qcom: qcs404: fix bluetooth device address
>     
>     [ Upstream commit f5f390a77f18eaeb2c93211a1b7c5e66b5acd423 ]
>     
>     The 'local-bd-address' property is used to pass a unique Bluetooth
>     device address from the boot firmware to the kernel and should otherwise
>     be left unset so that the OS can prevent the controller from being used
>     until a valid address has been provided through some other means (e.g.
>     using btmgmt).
>     
>     Fixes: 60f77ae7d1c1 ("arm64: dts: qcom: qcs404-evb: Enable uart3 and add Bluetooth")
>     Cc: stable@vger.kernel.org      # 5.10

This was supposed to say 5.2. Thanks for catching this.

Johan

