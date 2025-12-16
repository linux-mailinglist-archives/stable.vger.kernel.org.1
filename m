Return-Path: <stable+bounces-202743-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F4ACC56CD
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 00:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 37EB23002498
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 23:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B63313E17;
	Tue, 16 Dec 2025 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tYBSC/fw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611223182D
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765926334; cv=none; b=CTjlYjxN+d9+KS94UPwydY3ntdrNg0h0gh/hjWQbzGOhnAI4tQP6KtJxnQl3FEAR5ayWJP9JF0k0IitdT0ZecSGaGuVr2XEP9sNaQ8MN7Dvv8sCiGLQo0PARDPub3NpR6OqIJrpKni6fM2Wb2Y4/UMEpqRyR+Go9ax2hORPPfVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765926334; c=relaxed/simple;
	bh=6XblpDM2MxyVpvF5n4JXCD7alP+SzrEDDA25rJ6+9xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNubm2FN8lnup94nH8gNpQjGUpkwZhWBOY268Fyeh25QGlLB9O1NpSNNIP7upzfswcxxjhIiWFz/qmGbMfouPqCzokwk+VYqvKN0tHBnmStde7+msXarvxgV3V3324Ei1CYtX5ay2vVtyIrON247kt7sHl3IN3hXHm5MRBkOhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tYBSC/fw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA53CC4CEF1;
	Tue, 16 Dec 2025 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765926334;
	bh=6XblpDM2MxyVpvF5n4JXCD7alP+SzrEDDA25rJ6+9xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tYBSC/fwrhtoRVQhaE51ArXpL5id0Ypq8KNmimLyGpqM1db25IVcpzgylePudhwqq
	 QO/n6FdN8G+Ml9Wsj4wQMtAd+SgWRX+pVjrXhZsCEfsu48bQkOfNP0AnRTv+0egdln
	 B61jCTAH0Nk3PdmkKYIji131Rl9MlvkutEdlEekdZjpf6rWhrxdpNK3NUfMdirzp8X
	 oGVoyB3RpOI7IARPOskgeBUH8rWRwcb0fQJLQiWKDTY83P1mZrsvCtOec0m2SgbUa/
	 gWr+hLqzrZp1BNkyVLs9JEV85TIMK1DEJUYAwzrlUFBo6wVTJOKF/CrqnJGHpm7Nv5
	 Lu7vwnseu3hKA==
Date: Wed, 17 Dec 2025 00:05:29 +0100
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	stable@vger.kernel.org, =?utf-8?B?6rmA6rCV66+8?= <km.kim1503@gmail.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Chris Wilson <chris.p.wilson@linux.intel.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
	Krzysztof Karas <krzysztof.karas@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH v5] drm/i915/gem: Zero-initialize the eb.vma array in
 i915_gem_do_execbuffer
Message-ID: <cawjzyb3alintifoolf45ykiu726guasc7jnj6niwpbprleci3@i6ueo3ppmxsy>
References: <20251216180900.54294-2-krzysztof.niemiec@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216180900.54294-2-krzysztof.niemiec@intel.com>

Hi,

just as a confirmation, a question for Mr. Kim,

> Reported-by: Gangmin Kim <km.kim1503@gmail.com>

is it Gangmin or Kangmin? :-)

km.kim looks more like Kangmin.

Andi

PS no need to resend.

