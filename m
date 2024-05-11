Return-Path: <stable+bounces-43560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94A78C3189
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 15:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41364B21137
	for <lists+stable@lfdr.de>; Sat, 11 May 2024 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD6B50A63;
	Sat, 11 May 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHmwWVkM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412723BB21
	for <stable@vger.kernel.org>; Sat, 11 May 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715432877; cv=none; b=ZUcCutzi3tW45D1QoBnBw7w8xDSFALsAJu25tgbF+W6Z+jKV/tIBI7faxKV3EyymktAijoPzjDGLL2mK09TIDBsWSjK+OSuA+Br81D3hGrY2s8l8od7WsRv2jC/tQp0nGuECAjDx/+ubOwnYQCR0e2flnE8ukvda/J6xrbzXKFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715432877; c=relaxed/simple;
	bh=C4l+MCmXUfLjwPAzR0utBnE5/JPeIPgp0Xc7Ghb5PIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=er5QqHRw34tXAvTdtO2YxDk7PZppgUiTxuu7H30OYYFgkLVfd2S88FDuEmKf0PYcewNWH8S/RztusHAcwI38XmENBv6L2u1kwAlxi0iMFWUiN9Rahwy14vnL3dIeNGYXvrGj/ExPoScHym/I3jsVdB+UDfXo1EEvXkVrrNZbDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHmwWVkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF12C2BBFC;
	Sat, 11 May 2024 13:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715432876;
	bh=C4l+MCmXUfLjwPAzR0utBnE5/JPeIPgp0Xc7Ghb5PIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tHmwWVkMDYYqAMhYnB4EcL9Xl+lEA7ObI5CquAQwXTPyplcaSqANwAq9nmlO2v3vb
	 YBOLvfGgFZm3XX2rySpqaO0DWrNI5sCnO5kQNqi+9OqltY3NoF0AaNGowA9jEtezZ5
	 Bl+4dMxAyKenD0tTQ9PG3vOrGwr62tDTfrGIIBKJXYxf44+0fq249yOxIOkgGB+tKl
	 r52TMUY0FkryESph9LpdfjqXPeIXdbi0xPJomOb8ttDOIL+HGvbAq2mgFWricaobFR
	 tH+ua3emacvHQmHbpEe0f8qBB2bE9eAHDlctSzv6GCQEfDsICdkSP/KPf0IK9YkVMX
	 EE3pRNc65BRXw==
Date: Sat, 11 May 2024 09:07:54 -0400
From: Sasha Levin <sashal@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: 2 fixes for inclusion into linux-4.19.y
Message-ID: <Zj9tqvPF0GF53jIz@sashalap>
References: <20240510073605.GA6146@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240510073605.GA6146@google.com>

On Fri, May 10, 2024 at 08:36:05AM +0100, Lee Jones wrote:
>Dear Stable,
>
>Please could you apply the following fixes to the v4.19 Stable tree:
>
>  97af84a6bba2 af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
>  47d8ac011fe1 af_unix: Fix garbage collector racing against connect()
>
>The former was only applied as far back as linux-5.4.y because the
>commit in the Fixes tag wasn't ever applied to linux-4.19.y, however it
>is a dependency for the latter, which fixes a real bug also found in
>linux-4.19.y.
>
>The assumption is that the latter was not applied to linux-4.19.y due to
>an conflict caused the missing dependency.  When both are applied in
>order, they do so cleanly.

I'll queue them up, thanks!

-- 
Thanks,
Sasha

