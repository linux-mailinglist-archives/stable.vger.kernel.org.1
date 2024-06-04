Return-Path: <stable+bounces-47928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD68FB4F2
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 16:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B50C281220
	for <lists+stable@lfdr.de>; Tue,  4 Jun 2024 14:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1125CDDD8;
	Tue,  4 Jun 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ax/5c55t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DBE179AF
	for <stable@vger.kernel.org>; Tue,  4 Jun 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717510374; cv=none; b=DGklsBQSPG9wa28WQI5Jp3WELuBUWX7UzOur1nsbcqrjv+dyL8QSl/lAHvo8ZemfspNqSH+PFB7shj/DCuPQqWbH/pQr0UgoHYtvrNwFm/fXy6fCN+hiAPimK05HYX2u+3jji26ofOfVZaOp91QXtZP+AI0LQ277oJ9dHBGTf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717510374; c=relaxed/simple;
	bh=bP9vHDMEpgA/vVANNY7vb/QpnpwnTPTNQUB08n0JZ2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tX1eaYbmPFEVpInk2gPz7vcTlEQa1r7sgmFvnssNPbcLn6XAos7ZELy2U3rAwJbDANgtkTNPje9OxwSdyoreiTBRrvxXZnVR4TSEJum+6QZJPNtJz6JYba/7HR9EnwXmtCxjrgvQbU8NagAkz4vlMPjy+Td+Dl/B/gNhanv/yio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ax/5c55t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F8FC2BBFC;
	Tue,  4 Jun 2024 14:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717510374;
	bh=bP9vHDMEpgA/vVANNY7vb/QpnpwnTPTNQUB08n0JZ2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ax/5c55tnJYIAeH0rX+Mht9BdQtcWxB0L2UVH7oNUaNh6fx7/JXgOh+G2RIxqKG6H
	 jM90fgOsOgrX3vaBjkHRRdGM+C397+bTkW+f5wjTT+Aw7TnCpOr3DZKnE+j1MjUAUD
	 5gNHxb+0snbWttty93CD8iDXwxlJWK4IHZMqpTM0=
Date: Tue, 4 Jun 2024 16:09:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Maxime Ripard <mripard@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: Widespread breakage in v6.9.4-rc1
Message-ID: <2024060454-clavicle-jump-c4f4@gregkh>
References: <dc0c4e9d-e37c-442d-8b75-72f0e2927802@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc0c4e9d-e37c-442d-8b75-72f0e2927802@sirena.org.uk>

On Tue, Jun 04, 2024 at 02:48:27PM +0100, Mark Brown wrote:
> I'm not seeing a test mail for v6.9.4-rc1 but it's in the stable-rc git

Those trees are automatically generated from our scripts at times, there
has not been any -rc email/cycle started yet.

> and I'm seeing extensive breakage on many platforms with it due to the
> backporting of c0e0f139354 ("drm: Make drivers depends on DRM_DW_HDMI")
> which was reverted upstream in commit 8f7f115596d3dcced ("Revert "drm:
> Make drivers depends on DRM_DW_HDMI"") for a combination of the reasons
> outlined in that revert and the extensive breakage that it cause in
> -next.

Build breakage or runtime?

I'll queue up the revert when I get a chance, thanks!

greg k-h

