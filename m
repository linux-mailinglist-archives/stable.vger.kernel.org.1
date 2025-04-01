Return-Path: <stable+bounces-127311-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07658A7784F
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 12:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373251889D8D
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 09:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24181EFFAB;
	Tue,  1 Apr 2025 09:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cqWiE1SC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF46F1EDA1A
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501575; cv=none; b=ECWLUwB4OIc7vWmXby7wgqYVnZO+ih4dyJgrN0sZQkw1tnUohbr+ruDhJxzwStrQS4WzsfV9UKht8dtmbQhJdVJWHhRNNO39oSixxwIif1wPOMdAK6/MYt9DccSQ+pgj16yePo/zz/yDoNqRMGrxLXHJs21MUt+5XJ2wvFGAcIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501575; c=relaxed/simple;
	bh=eoeeFPVxkg8Jb82rWzD+TkBRS63QUDme/PB/b1MxnCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMwuUgiRPzF+hX/mDB0JHaUuzF9l5hGo6/TGiiExldQWqeiFXW/kzn5wutYJK+R5y5vNjLwQNwnZHYFRVOytaHmTdhgtYQutYtD7MYZkUBfZZ41zeGtm8tGqEhpeXHgltkY27XFGi3Fxgia1z62u1MB+XamVroQtWYFwNtyyPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cqWiE1SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD956C4CEE4;
	Tue,  1 Apr 2025 09:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1743501574;
	bh=eoeeFPVxkg8Jb82rWzD+TkBRS63QUDme/PB/b1MxnCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqWiE1SCywyBlnxkah79e+jHzhkXS19hhgqFxVqQEeCMhf+RLfTRwYEfG+dCtldJy
	 RpJp82FG4YFELvO1SM/8AUqG7+rN5mVCiS+B9XcNeVxke3hNWegJ0wQq6nyITVoXC0
	 Jx86CICg51E83aHMbo7SkL402aJaKBcGi//nmQSg=
Date: Tue, 1 Apr 2025 10:58:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kang Wenlin <wenlin.kang@windriver.com>
Cc: regkh@linuxfoundation.org, stable@vger.kernel.org,
	viro@zeniv.linux.org.uk, ebiederm@xmission.com,
	keescook@chromium.org, akpm@linux-foundation.org
Subject: Re: [PATCH 6.1.y 6/7] binfmt_elf: Only report padzero() errors when
 PROT_WRITE
Message-ID: <2025040101-riverbank-kilt-459b@gregkh>
References: <20250324071942.2553928-1-wenlin.kang@windriver.com>
 <20250324071942.2553928-7-wenlin.kang@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324071942.2553928-7-wenlin.kang@windriver.com>

On Mon, Mar 24, 2025 at 03:19:41PM +0800, Kang Wenlin wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> commit f9c0a39d95301a36baacfd3495374c6128d662fa upstream

We obviously can not take a patch for 6.1.y that is not already in
6.6.y, right?  Otherwise when you upgrade to the newer version you will
have a regression.

Please fix this up by sending the newer kernel backports first, and
then, if they are accepted, send the older ones.  As it is, we can't
take this series at all, sorry.

greg k-h

