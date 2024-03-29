Return-Path: <stable+bounces-33649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58279891E6C
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7F31F2496A
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 14:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BC516D11F;
	Fri, 29 Mar 2024 12:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ilpHVWkX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E615A16D119
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716552; cv=none; b=nbAuaKFTzpKwfaxgA7prRC9c/EnozLd445unKGEd4XSo67WnWUpFGn8O0/mPWDY3pFloeQiXW1F6QoDaSoH6Dc0yxlaKOHBBPdFEBm0W0kGOoDpWwt5QwjCIMk2HmFO6sm3hUGPEIxJ7hazTrJdLnR/7deZhj7GtnCJxlYW5xgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716552; c=relaxed/simple;
	bh=4QpyOAswf98sDHUTk+WhliIXWYBHtM9un6jV7hdIFMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EM1SGl4Eeo+zV5WJ+e+Xpo7NVpTOj1EZgh6Uz3Jk9q8mHKHf2bMjYuN/1iDlrLOhhKcAtX/RwAh1oteuP0iA28ZcU9T1trpD9eghUirak+jMZsF2Nt2YUNLNkUlz+4XPkVc8tLuGMl6Yzy1DNmPdk06RSeFfHMuyJ5fetuS0WDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ilpHVWkX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371ADC433C7;
	Fri, 29 Mar 2024 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711716551;
	bh=4QpyOAswf98sDHUTk+WhliIXWYBHtM9un6jV7hdIFMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilpHVWkXjXFo/AxAGexA+Wov873FFUB4stULJ7drt1CYxjzbCtPCL58xFRAwltEBX
	 8+h7kiL03H337381oWzmS+lD7dhfe9bs9UwJEwJA7/Wm5730FVC9M1U194lxvyTaLY
	 UsXMC43UsfA1x3UiEkuJZfqBpdGIP45ucyHrDXGI=
Date: Fri, 29 Mar 2024 13:49:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH v0 0/2] Fix LPSS clock divider for XPS 9530, 6.8.y
 backport
Message-ID: <2024032957-garter-subfloor-26c3@gregkh>
References: <20240317005400.974432-1-alex.vinarskis@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240317005400.974432-1-alex.vinarskis@gmail.com>

On Sun, Mar 17, 2024 at 01:53:58AM +0100, Aleksandrs Vinarskis wrote:
> This is a backport of recently upstreamed fix for XPS 9530 sound issue.
> Both apply cleanly to 6.8.y, and could also be cherry-picked from upstream.
> 
> Ideally should be applied to all branches where upstream commit
> d110858a6925827609d11db8513d76750483ec06 exists (6.8.y) or was backported
> (6.7.y) as it adds initial yet incomplete support for this laptop. Patches
> for 6.7.y require modification, will be submitted separately.
> 
> Signed-off-by: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>

All now queued up, thanks.

greg k-h

