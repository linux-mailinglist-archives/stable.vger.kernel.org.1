Return-Path: <stable+bounces-195368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 185EDC759AB
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E88794E3593
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935B536E9AB;
	Thu, 20 Nov 2025 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq3J5+ev"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E03A36E9A4;
	Thu, 20 Nov 2025 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658684; cv=none; b=k8dc9wT0iVoZHhUJkByKDcJVjrwGrmWNbv/F5rv/LNHiGsb7HlJXRkOuCUGAqR/KsYZm2cc/Ao/99uuak2cC9sLsk9lkfU6xAEVJPJe+ZvEzqxzJ+foioQ7tzqJ5t29v70p3CA6CowDRL0sUHJ4ZfefN73X67pZYPeM6i60j8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658684; c=relaxed/simple;
	bh=OS/r0EpM0s5wxSFxcNk05ajk5qhEsvQksnkARUX8mc0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jhRldGbZjjFBF0nzupv7cP2RAZ8WAMmj28mUsfIb2kYzTkJ+lYnE9525/IOWSCQDgt6/uhLJVxSrFO0AGaqkdE8nCEC6Gh1Pg2SRMiLr7MtGxS6kKQfMZ9f8NW/EYVVmNubO1kFZozoXkrFHEIeqLWR/Zz/wvga8rWchM951VTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq3J5+ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB1EC116C6;
	Thu, 20 Nov 2025 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763658683;
	bh=OS/r0EpM0s5wxSFxcNk05ajk5qhEsvQksnkARUX8mc0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zq3J5+evRCaPmxhDA42H5sjKUoSEnD0mw+9/fYrGHockn5O4LFP5vnREYCUS5lPQM
	 HcfDfPzfa8g/FO2vKwfZcWnl6GOvYbQ9AkSDAz7R2qXZXSGhZW+NT6GTLaPphxpv+b
	 TEQjHLa1UFSwUyEEcC5AD4uetQMiFs3bY6hGWFKJp4hnF/U5XH1qAUfB4YAQrKljUp
	 jktgcAMSeH5ZpQ02G/Tf7c5G++tuwBDzi8Ogy7I/Mr8Q62qbKYxWommAvrZg6NZZSP
	 jsCR8doZ5vMootrUZ3+2rrWWp3VvoobyQ1JsG5WLX9/TucVUukJuXvb4Zx0ZsC6uB4
	 tEj1HS5kJrJMw==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Johan Hovold <johan@kernel.org>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>
In-Reply-To: <20251017054537.6884-1-johan@kernel.org>
References: <20251017054537.6884-1-johan@kernel.org>
Subject: Re: [PATCH] phy: broadcom: bcm63xx-usbh: fix section mismatches
Message-Id: <176365868179.207696.17035169965635910169.b4-ty@kernel.org>
Date: Thu, 20 Nov 2025 22:41:21 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 17 Oct 2025 07:45:37 +0200, Johan Hovold wrote:
> Platform drivers can be probed after their init sections have been
> discarded (e.g. on probe deferral or manual rebind through sysfs) so the
> probe function and match table must not live in init.
> 
> 

Applied, thanks!

[1/1] phy: broadcom: bcm63xx-usbh: fix section mismatches
      commit: 356d1924b9a6bc2164ce2bf1fad147b0c37ae085

Best regards,
-- 
~Vinod



