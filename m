Return-Path: <stable+bounces-152486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B7FAD61ED
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 23:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A761E253D
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 21:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B28A248F62;
	Wed, 11 Jun 2025 21:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lww1Z/aU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53415248F4C;
	Wed, 11 Jun 2025 21:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749678706; cv=none; b=noXxzZ/GaWQAgrhtsTBv51hzqomWEVu2WIR+Vn5z9Cpk7SBMZy8Yc+iErbZnrPLppZZQO2SET5kn9dlk9nfabZ2FmTaHLs6T1bD+emMrWSicJKfNOQZc1F6Hl1NYxnfP3cbT3er+y+T38JErMEF+sdgzOGsvI67/ziTggIVpcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749678706; c=relaxed/simple;
	bh=lOF+vJkSoTcD/Yeh5Qod+FBW7jj9zn7uSn8kVPYoEfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PcD+nrAl35n2oW87hWnee1ICCpw+Phr4WFZzdOYXPr8b7a8unQMiNnechN1nI8Kx+W9JNyKaYOGCE5RUyqYsAoCgCwklPurcmYg4uTkWJ+Os+7Pt4/tzyKYkHR+hGMOaYPgSCloaQqW8udy1WXQBOIGjzU8ZLPJkTzTYEiz1nyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lww1Z/aU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7BDC4CEF1;
	Wed, 11 Jun 2025 21:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749678705;
	bh=lOF+vJkSoTcD/Yeh5Qod+FBW7jj9zn7uSn8kVPYoEfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lww1Z/aUQX7bXggPR8ZyY05kKqlKxNVkxCw0upkeypbOW5zMKMSdDlYwgkxYQ8tQ2
	 2TpY8mURV7V3Z+h8zRrOSErEjrsi4KTP422kHomSwJCs3mSSVRb0TSw1hoEUL/cThw
	 G1aj6m9fSSWTxRmN4Biobgyr2tMRI1TPHyS+7+SuKtPRIrCkFx1EBrdCryCwblRvR0
	 DHoaPk1ZzK/uW7aKUee4uHWIshXBiV5XroU3fgVuD/WLUAnBJLxbHGxstQMrV5grgK
	 Sul9VB52Hg2RyZ0bTxyiFozvYRJDLRiiAnIjpByz+fKPRdBDdkGvlcJ6k7xADnFgvm
	 wqs700Tay4vSw==
Date: Wed, 11 Jun 2025 14:51:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Charalampos Mitrodimas <charmitro@posteo.net>
Cc: RubenKelevra <rubenkelevra@gmail.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: pfcp: fix typo in message_priority field name
Message-ID: <20250611145144.2bc0a7b7@kernel.org>
In-Reply-To: <87cybbzbe3.fsf@posteo.net>
References: <20250610160612.268612-1-rubenkelevra@gmail.com>
	<87cybbzbe3.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Jun 2025 18:42:28 +0000 Charalampos Mitrodimas wrote:
> > Fix 'message_priprity' typo to 'message_priority' in big endian
> > bitfield definition. This typo breaks compilation on big endian
> > architectures.
> >
> > Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
> > Cc: stable@vger.kernel.org # commit 6dd514f48110 ("pfcp: always set pfcp metadata")
> > Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>
>
> I had the same issue today, happy there's a patch for this.

Could y'all share more? What compilation does this break?
The field is never used.

More info about how you found the problem would be useful.
And I believe this can go to net-next, without the CC stable
and without the Fixes tag. Unless my grep is lying to me:

net-next$ git grep message_priority
include/net/pfcp.h:     u8      message_priority:4,
-- 
pw-bot: cr

