Return-Path: <stable+bounces-10327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82E6827474
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4483F2890D3
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC39D5102B;
	Mon,  8 Jan 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kWB3lq2s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEE25101B;
	Mon,  8 Jan 2024 15:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C19C433C7;
	Mon,  8 Jan 2024 15:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728985;
	bh=doY6OWSnDsK54sjwSUptnE0msrL1HdUiXZI1M4ldST0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWB3lq2suMcT9PJz7zFoT+kA1y5xoaD+bezIS132G9MilyeW9+mYFIJ7G7X+csov4
	 8eBHs0WIYaJt/yQ4XPsWh8igIj4iObgP7BkfoOrMmbR6Tzf32TfQ2uPXDw3k0Qjno/
	 +vW6f7vRvplezG7IqSpwbbRcQ0TJKNRZC4cCkcwA=
Date: Mon, 8 Jan 2024 16:49:42 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 075/150] arm64: dts: qcom: sdm845: align RPMh
 regulator nodes with bindings
Message-ID: <2024010821-sharpie-purebred-798e@gregkh>
References: <20240108153511.214254205@linuxfoundation.org>
 <20240108153514.668148004@linuxfoundation.org>
 <437bfcbb-e6b1-4ae9-a3f2-4eba1a8532ae@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437bfcbb-e6b1-4ae9-a3f2-4eba1a8532ae@kernel.org>

On Mon, Jan 08, 2024 at 04:42:55PM +0100, Konrad Dybcio wrote:
> On 8.01.2024 16:35, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> 
> This one brings no functional difference, but it makes the
> devicetree bindings checker happy.

It's marked as a dependency for a later patch, which is why it is
included here.

thanks for the review,

greg k-h

