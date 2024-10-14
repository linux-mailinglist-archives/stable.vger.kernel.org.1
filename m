Return-Path: <stable+bounces-85073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F09099D8B2
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 22:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3E81F21BD2
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 20:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD981D0940;
	Mon, 14 Oct 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSCe6BXM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620BC4683;
	Mon, 14 Oct 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939593; cv=none; b=AE+Sz/5aOFSZ5o+AICmt1DgKwzBsR0Q8IPgHB7PCWe93jcL7wzcB89e11b+XRoAVYH8XLIO3MmGFuVDndESb0yiSeHpoVnSGU2QgCT7wRzSDevtzqcJlzVmrKvMMO6d3Gv4BP59mXe+t/kAI9jMWX2whExm64eqz5veD4DmsWzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939593; c=relaxed/simple;
	bh=64JiN4LK453yYlyTEVc6A5l5hKQQdefneibH0xbetKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vmtu4wIMz9NZFmSUMDVHsYU7gcz9juVcbaBSkvdlMpPGZXShMx+b6lWzjMc1QdmUWHEZU/duO/ZAy+31FR37VxHEmXwAJcHG8wibWzYrgd5jjj0pv3EUQci5O25L4wB4gG2edd66nsXSNoSHqqgWfxYLq7cQu5p5/5DIKyJoybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSCe6BXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7DBC4CEC3;
	Mon, 14 Oct 2024 20:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728939592;
	bh=64JiN4LK453yYlyTEVc6A5l5hKQQdefneibH0xbetKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSCe6BXMnOx7FDUAIn8waEDA/WZt0F1wrrmrxotrcoQ+Eyg/hRTEzeGtG+NKZSFQX
	 puWljPl1Isas5r+5Cv8YIZO3n0+f1bfL3O7lRGIZz42fH7V0cTrExYPth1ffUUUD+M
	 HbwyPa1zIg97TEW00vwiLhcnTIxAz14ItKdaF1/i0NHCfveeeJVMmlo63Ap+VZpsnQ
	 UIt7jmU2zjB4+D+F8Oa8njSsjgNQKMImxNXQ+bPL+V0vRYAY79evESHTZx9TLNsgWL
	 jdEX0FGsmFNRP98uo01EolcpbdvL++vW5jn9XnuHufSToJ+h56eOhaOCITj91MDU8n
	 agHAGQmwowVlw==
Date: Mon, 14 Oct 2024 13:59:49 -0700
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: x86@kernel.org, llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
	Fangrui Song <i@maskray.me>, Brian Gerst <brgerst@gmail.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2] x86/stackprotector: Work around strict Clang TLS
 symbol requirements
Message-ID: <202410141357.3B2A71A340@keescook>
References: <20241009124352.3105119-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009124352.3105119-2-ardb+git@google.com>

On Wed, Oct 09, 2024 at 02:43:53PM +0200, Ard Biesheuvel wrote:
> However, if a non-TLS definition of the symbol in question is visible in
> the same compilation unit (which amounts to the whole of vmlinux if LTO
> is enabled), it will drop the per-CPU prefix and emit a load from a
> bogus address.

I take this to mean that x86 32-bit kernels built with the stack
protector and using Clang LTO will crash very quickly?

-- 
Kees Cook

