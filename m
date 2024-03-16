Return-Path: <stable+bounces-28295-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB9487D99C
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 10:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D401C20B6D
	for <lists+stable@lfdr.de>; Sat, 16 Mar 2024 09:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850A211CBA;
	Sat, 16 Mar 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqH8IaQr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C8913AD8
	for <stable@vger.kernel.org>; Sat, 16 Mar 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710582079; cv=none; b=WpMPibyj38OlclU0RDFkQBxYHhOgzn5SwguokQQMYete4Pqk2vO+bFnaUX0E2ryMD/v2pLBtrJTfpQRujiSxTo4EoFq7PRzpGUldKIZRsawGfLXjTIC2E5Q2+XUVokUfQ2CW45GRC5tuwrJUuL6EC3AAs+4xkGRKMvGm5QH8UZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710582079; c=relaxed/simple;
	bh=LSvVYtDp3EgrkiyYQsdXi4PViDzACrLcEUJTgaBQsfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZV0l0pdP6OB8dQ0gquj/Tb/3LrT6x1accTqbIsbF242ekswdDVdpYKJxZctOP7dCwP4BHZwApQTxUCRdOgOpynczhw2mOkLZ7AcXCtKfxUd00mcWu/gNkgvWnJuDInXkDW+HSc/tfyFF8j6laExX9nAhbhN0RTrCn8eFaFnJ4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqH8IaQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763DAC433C7;
	Sat, 16 Mar 2024 09:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710582078;
	bh=LSvVYtDp3EgrkiyYQsdXi4PViDzACrLcEUJTgaBQsfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqH8IaQr6nDsV3QaMQeEBLmEDCc69CNr2Nv4u/8Zcr08oCnhHz9HLuosygNLLsAtR
	 RejiOS68scbcxrPCh1fCMCaKbo2dYpfL71L5vnYhX0B4o+weurWjGMmMFyNR3oTm3P
	 b0yq4yylZIxBks9PeNfnxHx8e19oKPm+6tSMcj9/IyO3nxWKP6fIe+T1kb6D2GW6F0
	 Ug/bzsTYRnd90mrXdqIjuaZm5nMmr7yQR37XEO/YC86C9fm7hQDW37vHMrbY/l1w3V
	 iUycKPoWW/QZUbTYJstL0eIZGudUMILrpFnFmwikUwRN1d8KbEfbgzXyWNObzF7wno
	 UvjAML+UvJLaw==
Date: Sat, 16 Mar 2024 05:41:16 -0400
From: Sasha Levin <sashal@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, kernel-dev@igalia.com
Subject: Re: [PATCH 5.15 0/5] Support static calls with LLVM-built kernels
Message-ID: <ZfVpPMl3JJakSHT1@sashalap>
References: <20240313104255.1083365-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240313104255.1083365-1-cascardo@igalia.com>

On Wed, Mar 13, 2024 at 07:42:50AM -0300, Thadeu Lima de Souza Cascardo wrote:
>Peter Zijlstra (4):
>  arch: Introduce CONFIG_FUNCTION_ALIGNMENT
>  x86/alternatives: Introduce int3_emulate_jcc()
>  x86/alternatives: Teach text_poke_bp() to patch Jcc.d32 instructions
>  x86/static_call: Add support for Jcc tail-calls
>
>Thomas Gleixner (1):
>  x86/asm: Differentiate between code and function alignment

Is this not an issue on 6.1? I don't see d49a0626216b ("arch: Introduce
CONFIG_FUNCTION_ALIGNMENT") in that tree.

-- 
Thanks,
Sasha

