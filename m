Return-Path: <stable+bounces-58756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A1192BC3C
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 15:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3650F1C20757
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177C11607B7;
	Tue,  9 Jul 2024 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BqdpaCv3"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F816630A;
	Tue,  9 Jul 2024 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720533367; cv=none; b=p7Y24+APou33s1h5CVY23ZkvOBPsTv/rbJKClXA1dUH/4cPj2bgCTqGTTdvRFrxdQNSmFwrOjDAYKKJRq1bl31oE4jdlcuIhjZ6nahfcrNjCMP4VQGVNlEUm5tM0dWub0K1AfEjhMAkc1OKoTgwSqTIQOARilt+oUiPIVPmXDI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720533367; c=relaxed/simple;
	bh=nyxSs+bRjH/rdH8wAvp4e5QkrTLGG0SI8P31JfbyLaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZNLP9cqouJ7bUw+pUBAboRkGtnDTEd/YL/kPDCS/Svdi4cHlh0dRkP+dGPpzS0bKUvhLo9TJ4py/PiZ9+2tt1UXU7fiXUBxQnrtKK70j1TX78E/I6LBmqYqmq6FkMuI+TKtgWaBpRmKueXPL3sLKSLDMJzaLiauWuZvR4Ln8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BqdpaCv3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 511E340E0185;
	Tue,  9 Jul 2024 13:56:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id x7WZIQL15i_T; Tue,  9 Jul 2024 13:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720533359; bh=pxEUpoax/p4niLJAJOZU+/xkgTtswD2UnZ23G4T/3pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BqdpaCv3rbP/MH5Q34UhprLGjY2VkDQPkOG/Q+LhfZ9DXjIFxyBweKMESf+7Ju0jO
	 xfHhd1rbuIaneTNtGrMUdcdBXpFdcYp0zJD+P6SX517UMZ34vA4SezG0hJDMFxzMzS
	 sq/HnSEdpgkNYugSNxueED4drn65zCgn2aGrNRWkxlgFMuaFiXze2Uj2T2x8PJ008+
	 Zdmhxjze1PKb5biuKVIz6JlTGrXhtRTuTfr3+TZs2LofSraDg3Vuk0hSbDHbdH/sRO
	 t8o15PQ6PfiJt+M2lklz3DgGnLVYHBxYoKZtcdDNyO7PjJS+dKo3b+p7bOy7urgNxP
	 SQ49gk2x2Jv+PFsd23QcOZo6z5XYM5FesG1FNpRAG6OmUIQ9Jm+UC3jI+bJoW121Y4
	 SOZdzotnatCFAy+HgUKWbCa0h1NZ44om20L/ZZV6mk2bnQ/VkxmVkt3WfQxsEetAeF
	 JQ69NzhBQ+qirM0dbNJu6dbnGqP1BpaZDTtLgUMF0ipqMDVFhdccObinhy5DAM5j9E
	 sslYBAH3LMpJxCCxLqQqhq3plSop9iCVzA5PSSfeDXfOETL5WLmqbUDz1zd517A6VE
	 keVIBB6SQ4IB7OKk3Fgg6LJRM1h7VCFmdiaSG/0+b5CBjL6hglXvnw4WUm4Vi07Qwm
	 jsGz3h9wF6Amsr0bIfFAw+x0=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 37CE640E0219;
	Tue,  9 Jul 2024 13:55:52 +0000 (UTC)
Date: Tue, 9 Jul 2024 15:55:45 +0200
From: Borislav Petkov <bp@alien8.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jim Mattson <jmattson@google.com>, Ingo Molnar <mingo@kernel.org>,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 5.10 RESEND] x86/retpoline: Move a NOENDBR annotation to
 the SRSO dummy return thunk
Message-ID: <20240709135545.GIZo1BYUeDD6UrvZNd@fat_crate.local>
References: <20240709132058.227930-1-jmattson@google.com>
 <2024070930-monument-cola-a36e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2024070930-monument-cola-a36e@gregkh>

On Tue, Jul 09, 2024 at 03:33:54PM +0200, Greg Kroah-Hartman wrote:
> And is this only needed in this one stable branch or in any others?

Lemme take care of them.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

