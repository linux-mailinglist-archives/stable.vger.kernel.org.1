Return-Path: <stable+bounces-189969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BE4C0DB5F
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 13:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A7214FEE48
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 12:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF64D23BCEE;
	Mon, 27 Oct 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VeLMii5W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E622D785
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569356; cv=none; b=dMx0Kanv3aJyGz8up4Iz95gNg6+qrczHmo7XzOQr8wN/7z1TRW4LtwsfBTxvw2NsqUqFkc7CorEpTE3Cm8md8uqTV4mHXjuxnsqJ9iS3K8MIlLIUDGoC8Xe60ZU7JkHCFdMG7S0406OBacmmZikyDOggJTSKD6bHyc/mxAf0aa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569356; c=relaxed/simple;
	bh=6QQxIA8lTQbGzByio6r3XShz2dUYu3EqzlDWbTUO1DA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqa0h7pz9VEwkDMpRA1Vh9k02ODwElJnr8UHQXRhXwZisfyJjWt83QGUsHWdfoXE4YcxBx6rV4Y//8HJ+GzyTLPc/Eomn+fWPyYK72yiw4+M5Hsa2tbZDO3Lj2C70K8vA4YeZrTQHeFHF6M2sRXfRk9zd3JlmgyF6od8WWEZJC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VeLMii5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2647C4CEFF;
	Mon, 27 Oct 2025 12:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761569356;
	bh=6QQxIA8lTQbGzByio6r3XShz2dUYu3EqzlDWbTUO1DA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VeLMii5WS3Xx8I3sfDV2MHeiWqWtkqF23UJ2X8CmcTro1nwS2aB0UhvPX9WHCf5lb
	 tr7Zmuwq9ImP/Z4Zm3SK2D8rV78n83/wp/SaGuUWAcWe/aWYeBZ+YE956UAPkVPbOx
	 dxjIEcS/YLBPuOkWIJ3AzyArV87gcorJQO2zOxjA=
Date: Mon, 27 Oct 2025 13:49:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Slade Watkins <sr@sladewatkins.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] scripts/quilt-mail: add my new email address
Message-ID: <2025102707-pointer-shortcut-5dff@gregkh>
References: <20251027124457.36664-1-sr@sladewatkins.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027124457.36664-1-sr@sladewatkins.com>

On Mon, Oct 27, 2025 at 08:44:57AM -0400, Slade Watkins wrote:
> My old email address is no longer valid and was bouncing. Add my new one instead.
> 
> Signed-off-by: Slade Watkins <sr@sladewatkins.com>
> ---
>  scripts/quilt-mail | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Now applied, thanks.

