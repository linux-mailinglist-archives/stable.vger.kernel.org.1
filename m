Return-Path: <stable+bounces-137120-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 156FDAA118C
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 18:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7131217187D
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 16:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DC121D3E9;
	Tue, 29 Apr 2025 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K3Ixu6Az"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30BF1DC988;
	Tue, 29 Apr 2025 16:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944273; cv=none; b=WN+GXSFgfD3WbMKF8EkRNWAriTAmRoJMCyNLIk9lTchSdGIu/je7FyJkhH4naAabw6fgIdNB2aOd2bGGwr1WD86c+icqk6WvtKAYLT7NU0jbF2M8GAdPaLyOfrPkLo3Yfrxd9BNL+YGbWdAj7lSw2VzoQ7w4cpyejT4Kz2sK3SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944273; c=relaxed/simple;
	bh=dp1B5zOvRveNyTwwk3MQebtsan6h8klv0nIzLbZxH4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8J94dSIQwkd+VOrazopEp+PTeOWnkaA3AA1te2ekoI/a2Wc2Fzjzv/i9SkmWN9tyPgdgE28N/YU7CTk1KwUHdceNIAQUxZqFZO2GeooCUE6Ml5TMlP71tCfMjgbPB+Dydh5Zjx1bmSCOJrmBJUsoytj4NNg9NJqEysONRplrc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K3Ixu6Az; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47CAC4CEE3;
	Tue, 29 Apr 2025 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745944272;
	bh=dp1B5zOvRveNyTwwk3MQebtsan6h8klv0nIzLbZxH4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K3Ixu6Az23E18jvbtxtm+rAG1V8Yn/E7bnzmNTNahHTP6SlUdRj23WeR7y3YExtA6
	 1CDp3wqRw2IouWVPrSEshyhcgR0h60DDlfGBn9XPzgT2xhz6O4xTulWhCV1oTWegQQ
	 SbuAXA2bnA2l3ASViOzNhNajFrx91y1vgbI3shnw=
Date: Tue, 29 Apr 2025 18:31:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org, Kai Zhang <zhangkai@iscas.ac.cn>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH stable v6.6] riscv: kprobes: Fix wrong lengths passed to
 patch_text_nosync()
Message-ID: <2025042945-financial-rumbling-bcd0@gregkh>
References: <20250429161418.838564-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429161418.838564-1-namcao@linutronix.de>

On Tue, Apr 29, 2025 at 06:14:18PM +0200, Nam Cao wrote:
> Unlike patch_text(), patch_text_nosync() takes the length in bytes, not
> number of instructions. It is therefore wrong for arch_prepare_ss_slot() to
> pass length=1 while patching one instruction.
> 
> This bug was introduced by commit b1756750a397 ("riscv: kprobes: Use
> patch_text_nosync() for insn slots"). It has been fixed upstream by commit
> 51781ce8f448 ("riscv: Pass patch_text() the length in bytes"). However,
> beside fixing this bug, this commit does many other things, making it
> unsuitable for backporting.

We would almost always want the original commit, why not just send that
instead?  What is wrong with it being in here as-is?

thanks,

greg k-h

