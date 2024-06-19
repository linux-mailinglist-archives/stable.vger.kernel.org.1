Return-Path: <stable+bounces-54659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902C890F464
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 18:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB3A1C211EF
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 16:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A150154C10;
	Wed, 19 Jun 2024 16:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM1YHjgh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAA1CA92;
	Wed, 19 Jun 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815552; cv=none; b=u07P+wNx2syUt5tmWDOjiLTc0yeyDMBmaxksHwaE06fZcS8LCr55AInDG4SFnGSYH7rCByPC5MkrRn+h5rpr0UI7VPsK9da5eOL32Wlc1OAVaVcp9VqMj6+1dXp64H+atCz5/T0JiJH3b37a3JuWjhPj3D3WCl1Z2BraE9DHhhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815552; c=relaxed/simple;
	bh=K8uYWHQVt5wnGOLTeizQh7FySqtxu5oVMkUG6y75JQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNdQQI+uI4op2XsNDVlhVjZyTJra5q/xQKinBpbbSNTExKkNK4mCXMLK696t/Ia0loqpXlMEsQndS8JBDKFPrDGuuR/Llxlomp7iIeRD/46OF6tVv7FZEL1Z9Gw5hys5HGedLDFjnhfXyw3HV+9ybFHXccXwF+2I/qfwbhmw0P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM1YHjgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798FDC32786;
	Wed, 19 Jun 2024 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815551;
	bh=K8uYWHQVt5wnGOLTeizQh7FySqtxu5oVMkUG6y75JQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UM1YHjghpU8mmx0WQ80JK3tpB5rYEtG8qffkGASY4KfAADQNuJpHNBv9TCRrI63SJ
	 2ZdNtFA5Lg+cGxfbrtxK5rueGtv3NlJl8u6EATbzdzfmsCXFtK+cKBQWn991o0jKw2
	 eqZWP55RjvG97ECV6cVGYNq78LIkxfmzzfsuSW+xagY0neWU9L9Dyw87vAXeRvOmAA
	 EUQmE3WSP3zdUXlRa7GqJTbKX9KdY/c4J2kkD6tuZxtBodYSy9znEaypOse6zRmh7u
	 0XkK6oDY2PHUjRSuXj/87/GIw7Yde7lzDyeRDeD3Ai6qxaeknT1W8NVpRM1Dv5riX+
	 u7nWuMGuYlv2g==
Date: Wed, 19 Jun 2024 17:45:47 +0100
From: Simon Horman <horms@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: ax88179_178a: improve link status logs
Message-ID: <20240619164547.GM690967@kernel.org>
References: <20240618115054.101577-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618115054.101577-1-jtornosm@redhat.com>

On Tue, Jun 18, 2024 at 01:50:40PM +0200, Jose Ignacio Tornos Martinez wrote:
> Avoid spurious link status logs that may ultimately be wrong; for example,
> if the link is set to down with the cable plugged, then the cable is
> unplugged and after this the link is set to up, the last new log that is
> appearing is incorrectly telling that the link is up.
> 
> In order to avoid errors, show link status logs after link_reset
> processing, and in order to avoid spurious as much as possible, only show
> the link loss when some link status change is detected.
> 
> cc: stable@vger.kernel.org
> Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
> ---
> v2:
>   - Fix the nits
> v1: https://lore.kernel.org/netdev/20240617103405.654567-1-jtornosm@redhat.com/

Hi Jose,

Thanks for the updates.
This version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

