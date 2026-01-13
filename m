Return-Path: <stable+bounces-208238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9881D16EE8
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 07:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEDDE3033DCB
	for <lists+stable@lfdr.de>; Tue, 13 Jan 2026 06:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE05369965;
	Tue, 13 Jan 2026 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoQQGfF4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2B25F98B;
	Tue, 13 Jan 2026 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287540; cv=none; b=cowjO5uXW1SwnXmaKSgeUsFYhTUSDmOJSyAjSOx82R4HmU5KQzr4V3lbOjRygXHLwJVJtxZrcmCxMJT4EbIL5kR9qs8khW5uodCplA45wRieonn3LB1K9Ou3rzXemaFIEexxTIYwBajcl09ktCrsinGDq6ghC1RWRr3XxZF+c9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287540; c=relaxed/simple;
	bh=inkLnSl0ItzeVinaMJYgEU5Xice93U0TjHQH3H3LEVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIRCJiJslboM2lSnNZP+e5tQwnUR5dKxvRbMJ5jHRx0eCBeAHH2pqUK4naSNIhkHQtgWgyZrzo8JsSBiZs60XqDrI1bvQJJyFip9WqSttQeuVtChJgIgcu94aMqLjbe9tc7gpAPqePWWyCzh6Cad/22hPREcjnVXLPDL8E5VO08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoQQGfF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47842C116C6;
	Tue, 13 Jan 2026 06:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768287540;
	bh=inkLnSl0ItzeVinaMJYgEU5Xice93U0TjHQH3H3LEVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AoQQGfF4j3uqXMq5Ca/8b5AJS6i2raNtMWlorWMax9SQ/ivKBH7CYAeX3Y3YU7qrW
	 5ztSQ9BZX196R9+Bp1UI6sWWXzv+M9reVlVaPGuU/BkDI6QPSt+230EFqo6qenTxdf
	 1BaNRgPAOrQ8fRdOp8dhu72nDDR2wOaTFz6fgl1TNz6mT/D7+Uiis8LyMcZnCpfkX6
	 5/HrYQIk0QFXQlffSKJVLWjAS8wgKm1hPDYs75U0hC+MPNz1lvLL63nUxi3Pkbia4P
	 9opiMHucT3Snny6hmeWTOG8UyCM9Dl3epRvCWoiEc71OLRtceUkmGoxRefAYtuty3X
	 EW1Znlv0JZFnA==
Message-ID: <675f32d7-c866-4b66-93bb-0dc6ed53f5f9@kernel.org>
Date: Tue, 13 Jan 2026 07:58:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: apple: Ignore USB role switches to the active
 role
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260109-apple-dwc3-role-switch-v1-1-11623b0f6222@jannau.net>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20260109-apple-dwc3-role-switch-v1-1-11623b0f6222@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.01.26 11:13, Janne Grunau wrote:
> Ignore USB role switches if dwc3-apple is already in the desired state.
> The USB-C port controller on M2 and M1/M2 Pro/Max/Ultra devices issues
> additional interrupts which result in USB role switches to the already
> active role.
> Ignore these USB role switches to ensure the USB-C port controller and
> dwc3-apple are always in a consistent state. This matches the behaviour
> in __dwc3_set_mode() in core.c.
> Fixes detecting USB 2.0 and 3.x devices on the affected systems. The
> reset caused by the additional role switch appears to leave the USB
> devices in a state which prevents detection when the phy and dwc3 is
> brought back up again.
> 
> Fixes: 0ec946d32ef7 ("usb: dwc3: Add Apple Silicon DWC3 glue layer driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Reviewed-by: Sven Peter <sven@kernel.org>
Tested-by: Sven Peter <sven@kernel.org> # M1 mac mini and macbook air


thanks,


Sven


