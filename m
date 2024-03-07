Return-Path: <stable+bounces-27096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA78754D6
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 18:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F400283EC1
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAA312FB26;
	Thu,  7 Mar 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrvNbvJL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50DF12FF7C
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831296; cv=none; b=cpZlfeVVe02dt0b6DFJCZMnXhFo5fEDY6Sw4pEquiWExXB+gjkN8d7vHn4Ly9sEmqpNrsM+/saafBAYHTL7b9KyBn9GuIkEkwUSuQygCXkOQGos8DGrstvB8D40OKqonZRTIp3OrE1zKUmQQomNQEwDbNKhG0Rt+THnOpTv2BZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831296; c=relaxed/simple;
	bh=k80A8L187ITvpoIFNbV053GtyQNFG9vfrED0q12v7HI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sbC03YwVupWjwB2XubIqfclSqfQptYJdGTJxFbj76JxDG1QSVFDjnblDLFXFhuk3OKQwRk0ZUIN332p2+QBVqsGsB218eUW1CK5WIWJs/mKGDaOrtKYNTInIhJTHL9QJocN+a2od/RP6gWmVXRZr7N6wE+CLPXTdWORifTwHun4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrvNbvJL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360E6C433C7;
	Thu,  7 Mar 2024 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709831296;
	bh=k80A8L187ITvpoIFNbV053GtyQNFG9vfrED0q12v7HI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FrvNbvJLnW6orNKc+wDHojylLBJe8yheY0Bnp9zEeppRmNlfZKoj6hTknCjODEUju
	 cJ1M0SaLjb34k1DmecxmiwrLcje77uZbboQ/C+p0RXyoIHTqoxYN0Qzp/VpbVDJ6Ys
	 iSlwX9KRnQo1TozR8Ijod+i9l1EryADA64+nGffxOPQS6MYQQ/AYpc3X21U06HCMdp
	 SSOjes9QB0yKbXYqYRGODtE5hWvBuwTiHmQzU4HvqWW14yv8lA9GnNtqIOCtDjdCE9
	 iJ9q+fGIM637XVmzP23WEdG0/SzW3HYE9ax5WCnDXFNEJ6zwQB1dTIoEclRoIibpFz
	 tTkBUYb7DDjvA==
Date: Thu, 7 Mar 2024 09:08:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, valis <sec@valis.email>, Simon Horman
 <horms@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, "David S .
 Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/1] tls: fix race between tx work scheduling and
 socket close
Message-ID: <20240307090815.2ab158ed@kernel.org>
In-Reply-To: <20240307155930.913525-1-lee@kernel.org>
References: <20240307155930.913525-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 15:59:29 +0000 Lee Jones wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> [ Upstream commit e01e3934a1b2d122919f73bc6ddbe1cdafc4bbdb ]
> 
> Similarly to previous commit, the submitting thread (recvmsg/sendmsg)
> may exit as soon as the async crypto handler calls complete().
> Reorder scheduling the work before calling complete().
> This seems more logical in the first place, as it's
> the inverse order of what the submitting thread will do.
> 
> Reported-by: valis <sec@valis.email>
> Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> (cherry picked from commit 6db22d6c7a6dc914b12c0469b94eb639b6a8a146)
> [Lee: Fixed merge-conflict in Stable branches linux-6.1.y and older]
> Signed-off-by: Lee Jones <lee@kernel.org>

LG, thank you!

The 5.15 / 5.10 / 5.4 fixes won't be effective, tho. I don't see
commit aec7961916f3f9e88766 in the other LTS branches. Without that
(it's still correct but) it doesn't fix the problem, because we still
touch the context after releasing the reference (unlocking the spin
lock).

