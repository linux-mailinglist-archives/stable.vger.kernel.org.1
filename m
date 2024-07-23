Return-Path: <stable+bounces-60774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4300C93A10C
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 15:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E351C22229
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1BD1534E8;
	Tue, 23 Jul 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GtSOOpj9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959FB152182;
	Tue, 23 Jul 2024 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740559; cv=none; b=N4SEaG8yRAKHUPjnbyqiC2OvKLcVH7u9cj+nXYOqhaEhnqZKs2Ywm6DvEe3fut0XhuVIV2lMU4EYXJr+6vXPpd6BMXCx5Eyk/0Kn3MIcDWh3Y1PLMtX2XsLfZrpj1J0yTRKBb4nzUEblAbObitUCSdNNIXyN7n+KYpy8+WHroP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740559; c=relaxed/simple;
	bh=CJ6odlK7baI24/AOmmEydF07fAZOeER+tUXYTE2d5IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMQW85dcQMJWOJ9c7tnMXZxZTPS4lUmBu+LZImrvgNGFhu1YeSwA1BWNzzJI6NfyB0pgKPBJq8Y4ort5em5aocE4HW3uSQo113o1FBOaxt9e2TWM+B15XPk/zTU5pzxpASf3rj8ixLGVqH6nYxRwFHJQ8bgd8uwcywmh9MNUsM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GtSOOpj9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79D7C4AF09;
	Tue, 23 Jul 2024 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721740559;
	bh=CJ6odlK7baI24/AOmmEydF07fAZOeER+tUXYTE2d5IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GtSOOpj99vAwrjlrrQ4YGxaCDLOisq7eaaYyXZmuZX4mAT+u9PIDrpQTVAuxAJuV2
	 1aUHsSpRiv0GW7NUW3LzJ9lVSNHGV423QOD9O89GnsfeDyVlZI6QdL2zNbj4L1Oj7H
	 KX3R/L+AySRY2qbuCmco2Pxb18kXUyP+GWYqpMLE=
Date: Tue, 23 Jul 2024 15:15:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: John Stultz <jstultz@google.com>, patches@armlinux.org.uk,
	linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
	Neill Kapron <nkapron@google.com>
Subject: Re: [PATCH] ARM: fix get_user() broken with veneer
Message-ID: <2024072348-perfectly-duct-e0aa@gregkh>
References: <20230926160903.62924-1-masahiroy@kernel.org>
 <CANDhNCraQ6UCDNH3s4+YKCWfk4dGjxP_LkZ7WBUnJ_WiKM5u6Q@mail.gmail.com>
 <CAK7LNAT3WQ+3K+Z=ueZ4f_1EF29aPui-HS2eV3erSb9rHJSPLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAT3WQ+3K+Z=ueZ4f_1EF29aPui-HS2eV3erSb9rHJSPLA@mail.gmail.com>

On Fri, Jul 19, 2024 at 12:04:39PM +0900, Masahiro Yamada wrote:
> On Fri, Jul 19, 2024 at 2:10 AM John Stultz <jstultz@google.com> wrote:
> >
> > On Tue, Sep 26, 2023 at 9:09 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > The 32-bit ARM kernel stops working if the kernel grows to the point
> > > where veneers for __get_user_* are created.
> > >
> > > AAPCS32 [1] states, "Register r12 (IP) may be used by a linker as a
> > > scratch register between a routine and any subroutine it calls. It
> > > can also be used within a routine to hold intermediate values between
> > > subroutine calls."
> > >
> > > However, bl instructions buried within the inline asm are unpredictable
> > > for compilers; hence, "ip" must be added to the clobber list.
> > >
> > > This becomes critical when veneers for __get_user_* are created because
> > > veneers use the ip register since commit 02e541db0540 ("ARM: 8323/1:
> > > force linker to use PIC veneers").
> > >
> > > [1]: https://github.com/ARM-software/abi-aa/blob/2023Q1/aapcs32/aapcs32.rst
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > + stable@vger.kernel.org
> > It seems like this (commit 24d3ba0a7b44c1617c27f5045eecc4f34752ab03
> > upstream) would be a good candidate for -stable?
> 
> 
> Yes.
> 
> This one should be back-ported. Thanks.

Now queued up, thanks.

greg k-h

