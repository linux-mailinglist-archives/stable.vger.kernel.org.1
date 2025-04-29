Return-Path: <stable+bounces-136998-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74D3AA0382
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 08:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F2A5A5851
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 06:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A88274FE3;
	Tue, 29 Apr 2025 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gv7NSDHc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE4D25332F;
	Tue, 29 Apr 2025 06:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908645; cv=none; b=Nt8InpT388Fa27crPsLOtOZhNSV9zADzyqhElv+keEZzdwsc1awmZHg0PQotEGWJ5lOXJI1Dijkf4H//A9iaILKnuUO53eIoLmg5zziiILEtKeoCGQ16vSWiPMAV+oxP4iVJSkLDx3eQxI+gRFpM4R1rmxySAjH8HWcmK0IT/Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908645; c=relaxed/simple;
	bh=d817Fyaq34u3PY0n5I8o8NhUE0mBmh3CQp3MUhO//bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjAt3JdRhZN8l561M2SQS0kyzUoLyJlKwL79LMvtpe4nr6OOw7k4u2GvxAeKDtYygRaCH0h11MgbJkHZAVaKGAh5XqpG5HxvpYXmhhfGxjmLbzEfx1FzAwO0LdnwrLr0Vkp/EefOhjLc5whHsHQHSV/tlq3uuDoRsdzEwEqAF1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gv7NSDHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE4EC4CEE3;
	Tue, 29 Apr 2025 06:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745908645;
	bh=d817Fyaq34u3PY0n5I8o8NhUE0mBmh3CQp3MUhO//bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gv7NSDHccWBHmlv9yaz85U3dO0mQwhlMhdAkuKHcfCYVDqiIgOWq1z57aqwe+TxFL
	 geeYcOdVm7mmreKK3MRxGKdHM2eRldaAaf6zjNN3rhf0HnrtrUL9cKQsh67n4xH7xh
	 mKVqCwS43/t+ySD7/18Roph7gJx4umT2DtSMexvQ=
Date: Tue, 29 Apr 2025 08:37:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>
Subject: Re: Patch "hardening: Disable GCC randstruct for COMPILE_TEST" has
 been added to the 6.14-stable tree
Message-ID: <2025042914-displease-endowment-3ed1@gregkh>
References: <20250429014846.406859-1-sashal@kernel.org>
 <120BD02C-8EA3-484F-81F5-6767B66C48A8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <120BD02C-8EA3-484F-81F5-6767B66C48A8@kernel.org>

On Mon, Apr 28, 2025 at 08:50:05PM -0700, Kees Cook wrote:
> 
> 
> On April 28, 2025 6:48:46 PM PDT, Sasha Levin <sashal@kernel.org> wrote:
> >This is a note to let you know that I've just added the patch titled
> >
> >    hardening: Disable GCC randstruct for COMPILE_TEST
> 
> Please don't backport this to any stable kernels. There is already a fix in -next and the problem only exists due to a 6.15 landlock change.

Now dropped from everywhere, thanks!

greg k-h

