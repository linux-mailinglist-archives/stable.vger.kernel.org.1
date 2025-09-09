Return-Path: <stable+bounces-179138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA81B5096F
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 01:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FC7D5451B4
	for <lists+stable@lfdr.de>; Tue,  9 Sep 2025 23:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C863B29346F;
	Tue,  9 Sep 2025 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2GxbR3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B39223337;
	Tue,  9 Sep 2025 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757462285; cv=none; b=I9SRiFU6QYlcKI2VFjdnGj94GILhe+XyVRvXjTeIt9tu1HAI54gjmo7POO8FF3nwoJsAOI1ybagbcNkpwurBGjJooqAU671kq/BC7RFi9vl8jBc0SBmX9jg/QV4ta0zMHsTq08Cwi8hBnQVcD2Ipddaw0EObCfdre5sW0noUgis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757462285; c=relaxed/simple;
	bh=QiBrjwW/3uPQgkLLHTBq8e3ZkK8ZDXI6qH8ZOHqVj7U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaFZXUTnexzgWlUmcRq46IZYgORf+0iK7mI6++X+Ei0kYTu6vEFjBXcbdV7s+cC+EGBDceoPuPurO8lkRkjqpACYrGDxOHPzlJwocIW6IYrFAw0Cp57ljtCyTQa0MWH1WgRd9Lbwp/1G9k2EyVcbpG1oKh9dVPCsYDhbwQugp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2GxbR3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57E1C4CEF4;
	Tue,  9 Sep 2025 23:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757462285;
	bh=QiBrjwW/3uPQgkLLHTBq8e3ZkK8ZDXI6qH8ZOHqVj7U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k2GxbR3nAj6cgpjmiSRVXgpDWMnC1Q/WmGOABIedTSHa0ZLHl6IF+lVrzhCu9Pbi6
	 ZE9rnjl5/Kzk2a0kV0u3rhEu0+r4PDzPhq0wiSXToQMSVQiaSMOY0RmKMqQAGD3MnE
	 wX9X2uqxOQGdhKxYCP/yB77HsRNGtrG+fJ+/T1tb+FXsqBVtMlpTbdDNIbC06pnOPR
	 t1z1GSDQx7qfy76k2/JRuxMpKkXdZlBWwTu6lklbp+jUuA7ydnsFb6epkdhHuRTR9p
	 2ctWcYd5oBRUWETGJv8rP0Jd7ift1vXTeDJh5lSgp3b2Ja+Ve88eLb5gpQuNKqfXbw
	 0fcR632Q8QGeg==
Date: Tue, 9 Sep 2025 16:58:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Hubert =?UTF-8?B?V2nFm25pZXdza2k=?=
 <hubert.wisniewski.25632@gmail.com>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Lukas Wunner <lukas@wunner.de>, Russell King
 <linux@armlinux.org.uk>, Xu Yang <xu.yang_2@nxp.com>,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <20250909165803.656d3442@kernel.org>
In-Reply-To: <20250908112619.2900723-1-o.rempel@pengutronix.de>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 13:26:19 +0200 Oleksij Rempel wrote:
> No extra phylink PM handling is required for this driver:
> - .ndo_open/.ndo_stop control the phylink start/stop lifecycle.

Meaning the interface is never suspended when open?

