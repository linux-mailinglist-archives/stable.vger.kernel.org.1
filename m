Return-Path: <stable+bounces-126883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 246A2A73728
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 17:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CDA317D174
	for <lists+stable@lfdr.de>; Thu, 27 Mar 2025 16:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C321AC42B;
	Thu, 27 Mar 2025 16:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl1VHmPA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E219CC0A;
	Thu, 27 Mar 2025 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093715; cv=none; b=X8/HHO+GoZY1rwG/BbtZIykcYt0ayaIj4FHw7jXJWCgLYN/5VAVNcHb0jpvcux8hd5dZxAaLReMFSYjr/RbArsWBXkbJIHJeUMW/Tlw0f7v/ywTkdin0cQBQ7gQOK566UpfM1xcFKWQnjRvH3A3uC+bzcmmYtoy1CdbZlKLKUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093715; c=relaxed/simple;
	bh=cgDvoTMdFl8uJCZb28WudBmYP1cge1/0I+1+v6MpP9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBNjL+VgZfJglw2LgEpfYeADnLTMhwCXdUdt2+j2rVuLBAL4q7XK+w81yobNgrMjaDX3fML0UXqSUsufiBGk6y7Wg8cs2WcsfGGYbQQ30uB6scA2rwB+msxfu4/AmXEeLBTBtijF89XPJuaZb4g5uk+8fdfDCmd9Iuo3a7YRRtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl1VHmPA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609EBC4CEDD;
	Thu, 27 Mar 2025 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743093714;
	bh=cgDvoTMdFl8uJCZb28WudBmYP1cge1/0I+1+v6MpP9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gl1VHmPArr+Oc1d64A5bGcyj8lgREvZPSDTk3D/n0Bo1JqkK0pB6dtHmX4+2V4PuL
	 2HDKE4IrSaqHzobn6atrf8G3IVE6Hk5ZybBurAtmZu2ECnvTi8vgVWuCGKBskXN18n
	 BPSZJ2u23RK1MJJ+i86DWhz8OVQNV7uRZkTx7EA0dLLQyGclYgqF/h7VSWKl08RVea
	 c3LDx0b3F1FBPSZ8YaB1esfGOwuiIHilQwAVhtPUTbj/liVjJ1g4NSxLtIDAnCzt0+
	 Pt6g6rtRmttd8PEdH6ZuE7Nc24EtIG3pz5AfOMeLP28TuuaRBJ8aN80hBOWIEsisX7
	 Ntj08FKtZQnRg==
Date: Thu, 27 Mar 2025 09:41:52 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Ard Biesheuvel <ardb@kernel.org>,
	stable@vger.kernel.org, David Binderman <dcb314@hotmail.com>
Subject: Re: [PATCH] arm64/crc-t10dif: fix use of out-of-scope array in
 crc_t10dif_arch()
Message-ID: <20250327164152.GC1425@sol.localdomain>
References: <20250326200918.125743-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326200918.125743-1-ebiggers@kernel.org>

On Wed, Mar 26, 2025 at 01:09:18PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Fix a silly bug where an array was used outside of its scope.
> 
> Fixes: 2051da858534 ("arm64/crc-t10dif: expose CRC-T10DIF function through lib")
> Cc: stable@vger.kernel.org
> Reported-by: David Binderman <dcb314@hotmail.com>
> Closes: https://lore.kernel.org/r/AS8PR02MB102170568EAE7FFDF93C8D1ED9CA62@AS8PR02MB10217.eurprd02.prod.outlook.com
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/arm64/lib/crc-t10dif-glue.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to https://web.git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=crc-next

- Eric

