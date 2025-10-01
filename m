Return-Path: <stable+bounces-182956-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFF5BB0B75
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 16:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D2B189E48E
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 14:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C789253B52;
	Wed,  1 Oct 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw12BhD3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41AA15855E;
	Wed,  1 Oct 2025 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329206; cv=none; b=HEiqyPc3uQ577KFG/yyGnTS8fBZwzp19A0it+JvlayrfjFybpsbSaHPxb8qNkxu1RkSVU2SlEVug/AwtU+1AfW+oAffrnm/QIix2I8SJRHTlQkj/IWIQtAP9MK8t/ffjG8uDSf6A6WU0vtOpbIRqag026q0HCzOu8VO6rG14LAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329206; c=relaxed/simple;
	bh=WxHv4Dq4K/vN1AMjLzd6suZe6icLMcYryWPtbs06Rb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRIzAfy7bRzIeI59UITadou1ndpJJAzZYSGD0ALpJwBYZ4hXXT+XSnGxEkdzIKaHwtLUOJ5C2u3n0wXaJbJFaQfYSpI4PyTchURFkg8Dhzku+lIYimUVNccpt76subD/4Lt7gs+iMyl96PWc8l9fepbaK8wexLwIlNSAnvjIHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw12BhD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC79BC4CEF1;
	Wed,  1 Oct 2025 14:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759329206;
	bh=WxHv4Dq4K/vN1AMjLzd6suZe6icLMcYryWPtbs06Rb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aw12BhD3ZXIxvGlHOW11z0pt0lRNBXVSmKy60ecUtePDkFm2UAOTN5r8LecigR0UM
	 LmZVsOXjM2Ud9IZZ7Q34YYpwvoLpE8Lbr7IwMCcbKccRAo8GdefTWMwcu4rsy35Qb1
	 4XjhmoFUgtoaOZ3Lkl9Ua9pTzJBUlxBBPZwcWaX3ZPpopXxihwj9DMcE0wponm3VcZ
	 YmppL2+SHRIIUEf/LQRX7QPk8H2Zs19GeD58qPteQb5vh0oR7511sahoCz4ZNJwrls
	 U26eTwWnFad3CshQ4e2WaJPn26zFPB6HW3LYWmxEwQfhinbgRPPfM4zC76EqmIfX4I
	 LybgQ0kXYA3yQ==
Date: Wed, 1 Oct 2025 09:33:24 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: lizhi.hou@amd.com, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org, saravanak@google.com
Subject: Re: [PATCH v2] of: unittest: Fix device reference count leak in
 of_unittest_pci_node_verify
Message-ID: <175932920385.1497002.3410181800952961448.robh@kernel.org>
References: <20250930081618.794-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930081618.794-1-make24@iscas.ac.cn>


On Tue, 30 Sep 2025 16:16:18 +0800, Ma Ke wrote:
> In of_unittest_pci_node_verify(), when the add parameter is false,
> device_find_any_child() obtains a reference to a child device. This
> function implicitly calls get_device() to increment the device's
> reference count before returning the pointer. However, the caller
> fails to properly release this reference by calling put_device(),
> leading to a device reference count leak. Add put_device() in the else
> branch immediately after child_dev is no longer needed.
> 
> As the comment of device_find_any_child states: "NOTE: you will need
> to drop the reference with put_device() after use".
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 26409dd04589 ("of: unittest: Add pci_dt_testdrv pci driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the put_device() location as suggestions.
> ---
>  drivers/of/unittest.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!


