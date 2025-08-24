Return-Path: <stable+bounces-172707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8095BB32E8F
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 11:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5004444DC
	for <lists+stable@lfdr.de>; Sun, 24 Aug 2025 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A694F1EA7E4;
	Sun, 24 Aug 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FBLH6vD1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F317A31B
	for <stable@vger.kernel.org>; Sun, 24 Aug 2025 09:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756026065; cv=none; b=lAT3TajpXV+IfNZpuGFaXEuvEjtxKiysEy0iFFYW95c7vzTfakxj2TXpgvulcO7tBs7vwk9Nm5BYfYM3nxV82Gfv7QwrAJL0XL4NUMfyNsA0Xxo+Khnboc4XT0TLk2KSHMmjVSVDOzKP1ZLsiEpXevJ0jJ9dUb7hYvvMauFlKhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756026065; c=relaxed/simple;
	bh=/FmCqj2u2V8mp0UjjYF2Fnjzx7frypxGep1lBC5W+ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loxvbm+Mqigyj0zVKdwitOgDxQolnG4C24mHakVNNEoEuN1YMLLGm4X8qWlF9IhpmtG8NWIyZ/L001yVCtSBnFfqnWiW3Gf1/G+pEXicbN7LLDWlNeHHAkbWd29SGIUMOIa/W89GGmHJE9TnX6P/HK8JGnUMf7HOi/MMPFN5xTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FBLH6vD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 797D4C4CEEB;
	Sun, 24 Aug 2025 09:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756026064;
	bh=/FmCqj2u2V8mp0UjjYF2Fnjzx7frypxGep1lBC5W+ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FBLH6vD1xyZHGhZupurJJiXDqq58uRTXx4NKkircguBR1slJBtNWWA+62IXIMwGlB
	 CZQ+WJlLuS5jRVb/CtF7osgc0FoMzMTfMhLRhanK5QcOIK35gkicqhvc66YoNZxHut
	 naUdlTf1k1KUwp7VkDqq7HZcr/O1ZWIQ4B1E5PXc=
Date: Sun, 24 Aug 2025 11:01:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-stable <stable@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Apply commit 5a821e2d69e2 ("powerpc/boot: Fix build with gcc
 15") to stable kernels
Message-ID: <2025082435-swoop-cyclist-b6fc@gregkh>
References: <7240379a-176f-4187-a353-1e6b68a359ce@csgroup.eu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7240379a-176f-4187-a353-1e6b68a359ce@csgroup.eu>

On Tue, Aug 05, 2025 at 08:03:49AM +0200, Christophe Leroy wrote:
> Hi,
> 
> Could you please apply commit 5a821e2d69e2 ("powerpc/boot: Fix build with
> gcc 15") to stable kernels, just like you did with commit ee2ab467bddf
> ("x86/boot: Use '-std=gnu11' to fix build with GCC 15")
> 
> Ref: https://bugzilla.kernel.org/show_bug.cgi?id=220407

It only applies to 6.6.y and 6.12.y, not older.  If you want it in older
trees please send a backport.

thanks,

greg k-h

