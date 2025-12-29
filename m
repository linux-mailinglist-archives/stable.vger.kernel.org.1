Return-Path: <stable+bounces-203479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C14F3CE63F1
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 09:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79F8D3006581
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9C023ABB9;
	Mon, 29 Dec 2025 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRvvLhen"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A7D1C8626;
	Mon, 29 Dec 2025 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766997037; cv=none; b=V3xKAS1LSEzCgmOX910lfBF9Ql2rUSLtxEm/+93LjZwEIvGByAZmlWAZ6ABxs+MJeePEPYHRP3WOlkecovZ/Wsva1MbLIUhMpHFaFJPhepnAG4uSQzoQne2WLQEPs51FcmQiuVFmLbWXCQcn5BsTjW6Kukqu/WUqt1s4RHjxZTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766997037; c=relaxed/simple;
	bh=n+4Vy8rai+s6XSvnBGa9OPc8jPApInUghc5+Yvwzoo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3cjyISy6C49+Lfs2MrdTqTkyw7vIw4IFsxsdVsy/t5BPgUICEwC1qprH/UZ3TtnJl1LmA/E+0EVaAuqA3Tvn9/N/pvtoogLfSkW58UJIkWyQnypUXP+hLgHTabi7UqO0pvTsHunn5n09o0dk7vYf+g2yrMNs2xk3XrRv/b1k6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRvvLhen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75297C4CEF7;
	Mon, 29 Dec 2025 08:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766997036;
	bh=n+4Vy8rai+s6XSvnBGa9OPc8jPApInUghc5+Yvwzoo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRvvLhenzEKts8AL5oX1M2/YpkfgJIK82bURxRRNK4mHar/ksYEqQORiiYzGtZJT5
	 hgSIUKc6jyE2mqpbHeaXX5RbTWE2OmhC7H/eZSMXSHgVVjPlwwepn7I79hVX7TFRhf
	 JKftSbUQElyfIt+V5aOoOMk7kapElT0PAcDd1H0K2On9TOkjFCJyIAapUxnB4t8FOA
	 oQeHskZnloLkmSmfe3yYqZr7Ybe8L7/0L9qQyNwIVB3Njw7hpCg4plKCTQW3GA7jZH
	 iP3EpVichUHo0M+sEu3iWX1sqAjV5jLJ5ZFi9ZeaUJE6zUHEITr+ybmFVzRI3Zv90d
	 qjGNb5aEV2nog==
Date: Mon, 29 Dec 2025 16:30:28 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Carlos Song <carlos.song@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	Frank.Li@nxp.com, daniel.baluta@nxp.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx95: correct I3C2 pclk to
 IMX95_CLK_BUSWAKEUP
Message-ID: <aVI8JKPm8eTx9NgA@dragon>
References: <20251118062855.1417564-1-carlos.song@nxp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118062855.1417564-1-carlos.song@nxp.com>

On Tue, Nov 18, 2025 at 02:28:54PM +0800, Carlos Song wrote:
> I3C2 is in WAKEUP domain. Its pclk should be IMX95_CLK_BUSWAKEUP.
> 
> Fixes: 969497ebefcf ("arm64: dts: imx95: Add i3c1 and i3c2")
> Signed-off-by: Carlos Song <carlos.song@nxp.com>
> Cc: <stable@vger.kernel.org>

Applied, thanks!

