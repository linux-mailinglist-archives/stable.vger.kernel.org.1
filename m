Return-Path: <stable+bounces-27097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4877C8754DE
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 18:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03549284B98
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069312FF8C;
	Thu,  7 Mar 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQIO8u8e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707B112FF6A
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831404; cv=none; b=FX6d1Z+Lu1qnvxrlBpHiDI5DZYNp0tIQZdq0ZyB321N/xblmIPicn/498izGuTfbPkwGVzndAAfyq6Kib9Hv9XqV2ncLWS9aTOlG86qMowhdNvh02Cu3fAVkU491fQY2UVaQimFRcK3h25sfmYnArXXWNO2DPV/v8g1dTwYaMCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831404; c=relaxed/simple;
	bh=YBDfpgFL40C1uSsCzg1PDFTP8wXlYdsxobceaYZKNgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSjnC88mIlFj8sY2SWTdnOSjhkioCQS9Tj9BwZtOPCudh3YxJIDKhrVoEggG3gJ1hm6ChPwMF7DdEhl6IrMkRQ4sJrdi8qZJwCIkljo6vgc+2wEFGfXer/TPfod5Pmp9X166owyPZLFwikmhIzcZ5yS6bR66ZhwKNfNCr1lbw+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQIO8u8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EC2C433F1;
	Thu,  7 Mar 2024 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709831403;
	bh=YBDfpgFL40C1uSsCzg1PDFTP8wXlYdsxobceaYZKNgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQIO8u8euySMBPxqlESK1FW1JaCqCR9ck3gf+xiUx/rVUvwUHxedEMS5tci17oGny
	 /pHuKOOmuPSl3Oq9sWG5joKfJ1H8+MkXA3dLnMKXZqW+1ueejWafHVSR7d2SWV/nVt
	 g5mx1YQdGGiASHXNc2pnK2/GioSNRJcNcggMFPJ1kE9yYM7Dd8BMtWdKETpxajjudm
	 PZrbivNSQtLQ4oPxhSMB1l4CCetHCacjMznoFNzVb5AkbsQ/PkXueS/JaKCbVzmPKm
	 sK0SPT9sn64aUdkqTO/8WW0c1eLrLpoqADVRHvF3m1qKONfXI11W+DD/pgayZde8YI
	 eyfveXDbENk9g==
Date: Thu, 7 Mar 2024 17:09:59 +0000
From: Lee Jones <lee@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org, valis <sec@valis.email>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/1] tls: fix race between tx work scheduling and
 socket close
Message-ID: <20240307170959.GO86322@google.com>
References: <20240307155930.913525-1-lee@kernel.org>
 <20240307090815.2ab158ed@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240307090815.2ab158ed@kernel.org>

On Thu, 07 Mar 2024, Jakub Kicinski wrote:

> On Thu,  7 Mar 2024 15:59:29 +0000 Lee Jones wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > 
> > [ Upstream commit e01e3934a1b2d122919f73bc6ddbe1cdafc4bbdb ]
> > 
> > Similarly to previous commit, the submitting thread (recvmsg/sendmsg)
> > may exit as soon as the async crypto handler calls complete().
> > Reorder scheduling the work before calling complete().
> > This seems more logical in the first place, as it's
> > the inverse order of what the submitting thread will do.
> > 
> > Reported-by: valis <sec@valis.email>
> > Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > (cherry picked from commit 6db22d6c7a6dc914b12c0469b94eb639b6a8a146)
> > [Lee: Fixed merge-conflict in Stable branches linux-6.1.y and older]
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> LG, thank you!
> 
> The 5.15 / 5.10 / 5.4 fixes won't be effective, tho. I don't see
> commit aec7961916f3f9e88766 in the other LTS branches. Without that
> (it's still correct but) it doesn't fix the problem, because we still
> touch the context after releasing the reference (unlocking the spin
> lock).

No problem.

Should I accompany aec7961916f3 with this fix into the aforementioned
branches then?  Would that then be effective?

-- 
Lee Jones [李琼斯]

