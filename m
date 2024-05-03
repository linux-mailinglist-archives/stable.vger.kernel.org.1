Return-Path: <stable+bounces-43019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D48BAFCF
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 17:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B31BB214E6
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 15:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DCA15216C;
	Fri,  3 May 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCn5q9u6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B614F898;
	Fri,  3 May 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714750227; cv=none; b=GD2hqRN5cu6U0bt9P1C/ZqaQU37uE02lixgaEciu2mKNsFBJPQdmQsPTJksMj5Pjt5iOkemR6OSfm0oq1Vb04QxPLdL1SrJLDLQK1xYnQhww9oEPyuyujeSzMwReytWcbVKMunGmhkY6AvTAYYgk1/34YPOiPhzMIFRMB9KEcTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714750227; c=relaxed/simple;
	bh=q5aFn3JJf8NzHICKfVTl+yVymYMpwR4aItacC58XDwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6hHWKtRRDjcInK12/oyIwnepEYpyoKGaaV+sZf131GjwVI6GSd9EzaAQ6HMlDt5RWfAZwKo/pgAKWDT1zpxNLh7og60AV8Bh2tGDMiMr1lZzv17hI6J1KGG8xMPZvVDesPEhosLRm2qXIZGVFqBMInIgxCGZTZRnB/qxNGgAc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCn5q9u6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A0BC116B1;
	Fri,  3 May 2024 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714750225;
	bh=q5aFn3JJf8NzHICKfVTl+yVymYMpwR4aItacC58XDwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCn5q9u6TmSuof6YDzAzekkGIyJ4/mkdBHclyN/0MGSTFcZ5zRvhAAccuWI6jon6r
	 HMF4ZZZppqSNqggr005YEQ4ubWpvAtZXZr/H1zBjHUxfU4zJTo+ezoEPe9rdN0IOlQ
	 bYvUoV7RE24ZWxCUQXhnvNyicW9Ksc3PDpkGDAsTLVsqtL1gt1/KE6Apc16jZI4znE
	 CO9qxEQaBM08MFb164bLV3B1xOsy6WfA2Y2jFkEcKKEWrdaTiRhGiNWvz8ntambzC+
	 u2jbx/xxdGXJ9WdDFLT6cV70mt2/tv2y8GqSmMgQRqfxA3VoG8uc7vrUCpNN47Ckmb
	 SrnIDZDVhchkw==
Date: Fri, 3 May 2024 08:30:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>, stable@vger.kernel.org,
	Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] fsverity: use register_sysctl_init() to avoid kmemleak
 warning
Message-ID: <20240503153023.GB1132@sol.localdomain>
References: <CAHj4cs8oYFcN6ptCdLjc3vLWRgNHiS8X06OVj_HLbX-wPoT_Mg@mail.gmail.com>
 <20240501025331.594183-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501025331.594183-1-ebiggers@kernel.org>

On Tue, Apr 30, 2024 at 07:53:31PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since the fsverity sysctl registration runs as a builtin initcall, there
> is no corresponding sysctl deregistration and the resulting struct
> ctl_table_header is not used.  This can cause a kmemleak warning just
> after the system boots up.  (A pointer to the ctl_table_header is stored
> in the fsverity_sysctl_header static variable, which kmemleak should
> detect; however, the compiler can optimize out that variable.)  Avoid
> the kmemleak warning by using register_sysctl_init() which is intended
> for use by builtin initcalls and uses kmemleak_not_leak().
> 
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://lore.kernel.org/r/CAHj4cs8DTSvR698UE040rs_pX1k-WVe7aR6N2OoXXuhXJPDC-w@mail.gmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-next

- Eric

