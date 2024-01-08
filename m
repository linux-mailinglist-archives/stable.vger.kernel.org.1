Return-Path: <stable+bounces-10289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDFF827438
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675921C22D99
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD51D5381E;
	Mon,  8 Jan 2024 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsazdLgs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AA51C4E;
	Mon,  8 Jan 2024 15:43:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37886C433C8;
	Mon,  8 Jan 2024 15:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704728580;
	bh=e0diCRXnB2T26avDf7pkSxhRs12yiwDVC4N+fJ9gh+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FsazdLgs9+xIHJlyYSbuhEi/fK7ruw9/c5IgL057MUV0qljOJi3+/ATFgeiXFC34H
	 aC7C//+oKE7ZDfLs1H/Puied4rZRFXXESGCWk5SBr4XAkUk2Y9jHOlCTCyNV1+PzBh
	 P4XilaaC93yGf/KvAAYIEITvlMwkOXPC/jQygBTm0bTHIo+80oMlslqt3q9gWL2bpA
	 ChUPBXamXNE8P0Jptf2bLdZxeq4pt+85914AFgIX6g50ODNa1ZB3nxM+qITId83FKn
	 NU1Jn/tXPuQ9e/8EHfeHszNpuMXd1aMLsnWhc5xeeihszwQ7/2QTRqV6m014vGnXj+
	 +bbMHEsg1UHqg==
Message-ID: <437bfcbb-e6b1-4ae9-a3f2-4eba1a8532ae@kernel.org>
Date: Mon, 8 Jan 2024 16:42:55 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 075/150] arm64: dts: qcom: sdm845: align RPMh
 regulator nodes with bindings
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Sasha Levin <sashal@kernel.org>
References: <20240108153511.214254205@linuxfoundation.org>
 <20240108153514.668148004@linuxfoundation.org>
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <20240108153514.668148004@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8.01.2024 16:35, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------

This one brings no functional difference, but it makes the
devicetree bindings checker happy.

Konrad


