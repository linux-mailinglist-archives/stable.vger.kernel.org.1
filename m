Return-Path: <stable+bounces-206286-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1EDD04A8B
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 18:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9743360E480
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 15:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF81356A36;
	Thu,  8 Jan 2026 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hWvUNIE3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4D439005
	for <stable@vger.kernel.org>; Thu,  8 Jan 2026 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864272; cv=none; b=rDMVLHjWkLiU1E2NJzOLnDoGeAJq5y9QtUwKjF7rPiLg9sGFTKpManXu8NM6tO5Ce6Ani6a2P3RN/G/puJ7XMdVsJenGOBZLib/jEW8cgqhw512WYQv3fxo40ZoHWlJHJmExBu4W2Ki/WhFV4Fb8WO0z0bZ+YAijZwPmMuG9xlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864272; c=relaxed/simple;
	bh=LjAxWb2PeelWG5mOcPICfLVu8lLgOv7pq0AyLmQtI0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PH2AQ0q7wP36kzLJiSJ/gir+uSErRx+j9Cs3B0NtiL3r8Y+ljACTTS4qh/vOAjsZFSgspYxIVmA26ueXoxngCzOlslZhwASyT7XTCJtbXrOqEN7Y8h72cqWKDzCA75u4ehCI65sKAqoul6FdfYs1sFmOFb57Q4UeLp6t7/LSxK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hWvUNIE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3179C116C6;
	Thu,  8 Jan 2026 09:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767864271;
	bh=LjAxWb2PeelWG5mOcPICfLVu8lLgOv7pq0AyLmQtI0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hWvUNIE3+zelROOysykFnt/v28yf1IBskQ2ZYWBvJv4ATfi+zbgsI7TUnZe5qiX1r
	 RKhMgaTGq1OGV6D+ieOHXarYLp+Yrus9n+Qv0StgpaIBtIF/su3amcaIN/v2Lbmm8K
	 NsX3xoeJi/7C4BTJ7XoW1/rrEZZPNO1uXegZ4oQE=
Date: Thu, 8 Jan 2026 10:24:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Cc: stable@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH 6.6.y] xhci: dbgtty: fix device unregister: fixup
Message-ID: <2026010820-repulsion-gradient-a498@gregkh>
References: <2025122917-keenly-greyhound-4fa6@gregkh>
 <20260107002520.3158298-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107002520.3158298-1-ukaszb@chromium.org>

On Wed, Jan 07, 2026 at 12:25:20AM +0000, Łukasz Bartosik wrote:
> This fixup replaces tty_vhangup() call with call to
> tty_port_tty_vhangup(). Both calls hangup tty device
> synchronously however tty_port_tty_vhangup() increases
> reference count during the hangup operation using
> scoped_guard(tty_port_tty).
> 
> Cc: stable <stable@kernel.org>
> Fixes: 1f73b8b56cf3 ("xhci: dbgtty: fix device unregister")
> Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
> Link: https://patch.msgid.link/20251127111644.3161386-1-ukaszb@google.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/usb/host/xhci-dbgtty.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Git id?

