Return-Path: <stable+bounces-179390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97850B55514
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 18:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185967BCDE0
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD2321F3A;
	Fri, 12 Sep 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rV/dNX2O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66230E83D;
	Fri, 12 Sep 2025 16:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757695931; cv=none; b=ZcXJuTLeMAxv8EI/jHDRynEtrFCwWUUDOBK2S92Qq3s0c5wzmH2y7laHG5yDBslydk7MmjwRdZhRa8UZD/+MD6/ejFJ8pCxP255qAO+xkiOa1KoZcijlHN136oakEzFy9pM189tDjTn6JxYEVjoi7ut4mevDzEceFGP7QqhUtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757695931; c=relaxed/simple;
	bh=ZwPu6i1q4L674NWESIVXfoVkfAhaVD4C8JNmPdJf8so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQa2pELVSSAAeKbFpaLe8QFtgaSNnCr3DBh9xWZp8XKjjA0o+pw3NTpXNn1pbuzEXAtE+p7qDpcc0meWLPM1PtKGExeW7uhrwwS9v4LyIK2oey1a2VQgzKwIFd6AkZo05c4NRkS3YU2QX0e7GLY3Hq9pZ9o/jQPm1drVop05H/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rV/dNX2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4ADFC4CEF1;
	Fri, 12 Sep 2025 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757695931;
	bh=ZwPu6i1q4L674NWESIVXfoVkfAhaVD4C8JNmPdJf8so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rV/dNX2OrINE+BqDEAep5wRxFKR6f8nd0vrad89g2Gn7Cw9CZSWjmjJudekZWZsth
	 dDe/RA4MFx1tN320ZR8D947C7meI53yRtq65KdR8JrGaVfgJB5juXqdXPk+baRuc6k
	 qti9KKvxlGQC9/2JWsDToO0eB45p0i12+W0HZ4GE021QcT58evmb2MUF/usrWjPsL3
	 Pf2YSYPDxgZsM9i/UUeonKGZclVgU2nPzbMSef2xbBCS9Ah5gAtyUrkjdUmJn+0fVr
	 xGR1vDH6QLXclRwKQbkyUTLHC94k+SNpqyexvzOmSynu9tHgJYegem1OoS9BjYWY+y
	 plTA+LzNxcnFA==
Date: Fri, 12 Sep 2025 12:52:09 -0400
From: Sasha Levin <sashal@kernel.org>
To: Eliav Farber <farbere@amazon.com>
Cc: luc.vanoostenryck@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
	natechancellor@gmail.com, ndesaulniers@google.com,
	keescook@chromium.org, akpm@linux-foundation.org, ojeda@kernel.org,
	elver@google.com, gregkh@linuxfoundation.org, kbusch@kernel.org,
	sj@kernel.org, bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
	clang-built-linux@googlegroups.com, stable@vger.kernel.org,
	jonnyc@amazon.com
Subject: Re: [PATCH v2 0/4 5.10.y] overflow: Allow mixed type arguments in
 overflow macros
Message-ID: <aMRPueS-kkgjHec4@laps>
References: <20250912153040.26691-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250912153040.26691-1-farbere@amazon.com>

On Fri, Sep 12, 2025 at 03:30:34PM +0000, Eliav Farber wrote:
>This series backports four commits to bring include/linux/overflow.h in
>line with v5.15.193:
> - 2541be80b1a2 ("overflow: Correct check_shl_overflow() comment")
> - 564e84663d25 ("compiler.h: drop fallback overflow checkers")
> - 1d1ac8244c22 ("overflow: Allow mixed type arguments")
> - f96cfe3e05b0 ("tracing: Define the is_signed_type() macro once")

None of these SHA1s match with what's actually in v5.15.193. What's going on
here?

-- 
Thanks,
Sasha

