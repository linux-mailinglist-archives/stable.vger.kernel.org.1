Return-Path: <stable+bounces-32963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C368E88E932
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 16:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C50B2DC56
	for <lists+stable@lfdr.de>; Wed, 27 Mar 2024 15:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58EC83A14;
	Wed, 27 Mar 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HICW2jou"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B051EF0E
	for <stable@vger.kernel.org>; Wed, 27 Mar 2024 14:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550559; cv=none; b=fS0GtLO9m+1CU4kHPVvYVqilvjhDrI2cM5OQBVYEd9mZInDc2uY5+CWsRNvyCHZadEXXVWJ81+EJdZMuA29T5Z0ot7TL+jdtNRzVTidO4EI6Xp6cwqdc69MGXrLsDAEcPIOSzDF3nJfMGyxkwrbPtopEIj5DbSwIWbMVpIDv7Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550559; c=relaxed/simple;
	bh=7O5BIR0nPVoBgF7YMOPrQALX4heSXBKNsw2P1LKbsbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnoqObYGumgQlq9D4e+HtblzcyG/Yqik0aquiy3nME+T2yQyFPO4Pw5h7uehxq+KhjfZtiAq3dFJgbQ8DC4We6x8WOqFGT91ptc9yvRN496IbnFzzEFvCLQAD9IyJhW1MCq0Th9HsKU410ayTdVptEyjD6XrQDIE1xImuHcFa6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HICW2jou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC2DC433C7;
	Wed, 27 Mar 2024 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711550559;
	bh=7O5BIR0nPVoBgF7YMOPrQALX4heSXBKNsw2P1LKbsbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HICW2jouEbXJaLDVPNo+rM8Pc07BDALW4N9ZVkMEC9nBJqfyyiWgu1k1tUAuQe+RT
	 ogaEb5+4wMHY26X05m/8oi5+DYOKBgq+/gHccN9zsh1LIKvSazoXl1iExZU+hZdydG
	 uLdF93itl1ks7qyN09hBRVhElY0rp8KEwKujG8YBVd0RB+2aaDn5A2Un1qDn3qNywI
	 l/5hMJ8pDR0ylnWKYXt5LNM/rZRXCuclG1UY/WSP0XQ/xQ4DfQ1JUc0VL/Xpk7qJtZ
	 tBoeoaVkwpwlmfjEJadQWnbqL8WmgD/0eGSa5pNbzpqBsm4IxYQOrtkJQBF3iaF50g
	 57UjKcKGQsUdQ==
Date: Wed, 27 Mar 2024 14:42:34 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	valis <sec@valis.email>, Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1 1/1] tls: fix race between tx work scheduling and
 socket close
Message-ID: <20240327144234.GU13211@google.com>
References: <20240307155930.913525-1-lee@kernel.org>
 <2024032703-wager-mandatory-d732@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024032703-wager-mandatory-d732@gregkh>

On Wed, 27 Mar 2024, Greg KH wrote:

> On Thu, Mar 07, 2024 at 03:59:29PM +0000, Lee Jones wrote:
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
> > ---
> >  net/tls/tls_sw.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > 
> 
> Now qeueued up, but only this version, the older ones I've dropped from
> my review queue based on the review from Jakub.  If they are still
> needed, can you provide backported versions?

Thanks.

Full disclosure, I have no plans to backport the remainder given Jakub's
comments.

-- 
Lee Jones [李琼斯]

