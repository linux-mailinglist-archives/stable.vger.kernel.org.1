Return-Path: <stable+bounces-41626-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CCD8B55EC
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 13:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3172BB24326
	for <lists+stable@lfdr.de>; Mon, 29 Apr 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396993A8EF;
	Mon, 29 Apr 2024 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VgN2Zeq7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD1DBA2E
	for <stable@vger.kernel.org>; Mon, 29 Apr 2024 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714388420; cv=none; b=QRitJZ4IE8+gIzPdxEVwyZYTBnTaFkAaKH6keNlCnuXroVKbwzvm7bMkY9ftyJNzc2TEq96NE3HwSof/Ne5wAx1ac/+67Pep1xenMOPOuWULmo6vMhkzlfROHtr9rhk1Pze22LGD4UApZqAyPh0BObJzw47C3rmKG9JXgXSuWK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714388420; c=relaxed/simple;
	bh=FL4DGtRvZ9CMTyBVdHAGUxxn9UM9oPFl+hSwFEOxirk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcC/Fyhv9rOnB2DKmhwHNaTMfIv2zbryQV5aFud14rSHROwOyDyeTrSE0HJe6hops+lU/TQQdRTkXRlHmtlsZeY3OESx8jYoIzZfiTi3W9+/tgpZGZCXd/DjVZwTn+t9NE4cKJgvGwabZb17BSp9f2B2FswwUBF22w52kKyNfjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VgN2Zeq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A81C113CD;
	Mon, 29 Apr 2024 11:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714388419;
	bh=FL4DGtRvZ9CMTyBVdHAGUxxn9UM9oPFl+hSwFEOxirk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VgN2Zeq7WW6GajGGPFFSqzekN2l6paOrSTJPBF5H6WKBDRy9ZRBRzOhbE+EPX5jJb
	 bYp8BcXzHalcQdKOup2XBXNnbh+fALQQK26n9PRqJymCE3lhGUw9Fi02a5G34z/cWZ
	 AEU66+Ky0qKfwb3rhwhU1TGZTQ4UpN+9rlHdBSCc=
Date: Mon, 29 Apr 2024 13:00:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Terry Tritton <terry.tritton@linaro.org>
Cc: stable@vger.kernel.org
Subject: Re: Backport request for [PATCH 0/3] selftests/seccomp seccomp_bpf
 test fixes
Message-ID: <2024042905-badland-uncheck-167d@gregkh>
References: <CABeuJB3YcaYHK=qcRbrr-QuU1-sduG3v+Xzg9b3fdAPVDDfyaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeuJB3YcaYHK=qcRbrr-QuU1-sduG3v+Xzg9b3fdAPVDDfyaA@mail.gmail.com>

On Fri, Apr 26, 2024 at 07:12:21PM +0100, Terry Tritton wrote:
> Please backport the following fixes for selftest/seccomp.
> I forgot to send the original patches to the stable list!
> They resolve some edge cases in the testing.
> 
> commit 8e3c9f9f3a0742cd12b682a1766674253b33fcf0
> selftests/seccomp: user_notification_addfd check nextfd is available
> 
> commit: 471dbc547612adeaa769e48498ef591c6c95a57a
> selftests/seccomp: Change the syscall used in KILL_THREAD test
> 
> commit: ecaaa55c9fa5e8058445a8b891070b12208cdb6d
> selftests/seccomp: Handle EINVAL on unshare(CLONE_NEWPID)
> 
> Please backport to 6.6 onwards.
> 

All now queued up, thanks.

greg k-h

