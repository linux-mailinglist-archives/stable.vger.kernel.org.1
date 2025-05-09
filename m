Return-Path: <stable+bounces-143064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B44AB1C79
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 20:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769E516F512
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 18:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B02223AE60;
	Fri,  9 May 2025 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOR3T+Ue"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906D241139;
	Fri,  9 May 2025 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815942; cv=none; b=Kj2Fjy6QyhhPYz6kF4iAqP05iB4Dgtu4f9ZnB9siBlxMXg8OsxmX8YC0eqp2OWQDLPq2Y9AyngQOthJu0u98jRtYco55gUqkxE8vlyZxY7RAWXHpigS4DDmmOYvPl4reOxztD7wNXmMPlzkxNPpf39r3Sej+hJMthX9GJXiNZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815942; c=relaxed/simple;
	bh=CNzigu9OBmuWrlsbb6lkAHKQvEmV0rXReJcmd4lUIG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG7V0QtBF96zjRDYgHyCMkue5IwbQSavd2O0Jb5M2MuZ2WBfUOP+W2lxXgcjNyD/KbBHk6p0zzy2c0c+4kJ8LvsW7mO4qysJEL8jSmVX+bw7cTPQ/SwuRGz4xreQ6SAkp28/PPif/4VF+VWFEeM40pRsAV5MCsjyOZFNARU83ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOR3T+Ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5AFC4CEE4;
	Fri,  9 May 2025 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746815941;
	bh=CNzigu9OBmuWrlsbb6lkAHKQvEmV0rXReJcmd4lUIG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QOR3T+Uea/m9D1NaeSWXmmevBwXXe1rwMHM9tj20bdo5M/Q1Uz6xZw+S9DICifwPw
	 mq+MEqH0ToOrWY8bUhm2sARgZvXf4NJp+4wzxRfO0ygybgggqztpqAMvpqm7kehrlw
	 hELbnaCIrgfTjteCssiBoQPaMu0o0oO9jSFmt17Ugt91b0YEVY0KyRByE5AWVL3Egw
	 iMIpJ6ihhnprEpw8MmmEwfOE4nghtEPK5HSt4MtTLU8qi+T0u5ZphiQdat+TJvlTtU
	 /H5ahjFWOcwroMtB7aNubyLP5eN/MdKW6LyuF70OlcPx1kMmYPRMavi03kh3Edwb/M
	 OO+/gygR1OmMg==
Date: Fri, 9 May 2025 13:38:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Benjamin Bara <benjamin.bara@skidata.com>,
	linux-rockchip@lists.infradead.org, stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	Klaus Goger <klaus.goger@theobroma-systems.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: usb: cypress,hx3: Add support for
 all variants
Message-ID: <174681593868.3912440.12960505435883876267.robh@kernel.org>
References: <20250425-onboard_usb_dev-v2-0-4a76a474a010@thaumatec.com>
 <20250425-onboard_usb_dev-v2-2-4a76a474a010@thaumatec.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425-onboard_usb_dev-v2-2-4a76a474a010@thaumatec.com>


On Fri, 25 Apr 2025 17:18:07 +0200, Lukasz Czechowski wrote:
> The Cypress HX3 hubs use different default PID value depending
> on the variant. Update compatibles list.
> Becasuse all hub variants use the same driver data, allow the
> dt node to have two compatibles: leftmost which matches the HW
> exactly, and the second one as fallback.
> 
> Fixes: 1eca51f58a10 ("dt-bindings: usb: Add binding for Cypress HX3 USB 3.0 family")
> Cc: stable@vger.kernel.org # 6.6
> Cc: stable@vger.kernel.org # Backport of the patch ("dt-bindings: usb: usb-device: relax compatible pattern to a contains") from list: https://lore.kernel.org/linux-usb/20250418-dt-binding-usb-device-compatibles-v2-1-b3029f14e800@cherry.de/
> Cc: stable@vger.kernel.org # Backport of the patch in this series fixing product ID in onboard_dev_id_table in drivers/usb/misc/onboard_usb_dev.c driver
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
> ---
>  .../devicetree/bindings/usb/cypress,hx3.yaml          | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


