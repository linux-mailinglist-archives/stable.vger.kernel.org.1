Return-Path: <stable+bounces-116675-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69CA3941B
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 08:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E8F7A2B10
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 07:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A1A1F2B90;
	Tue, 18 Feb 2025 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O+b2CziQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3581EEA2A
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864965; cv=none; b=YiRDGEQMkeM3HeZprRT5lyV8Du6klyNgfQUAja7tqaa196HO0ByiHmtZLh1Sy5RLWdM+Q9Ut7e24dzj/1bhTNsid9urdNK3onO14vURkHuOTYJvELVMlhg9B11IlcKjaAbh9v/92k/nQKtXnocnnFv+fb+iCAP+shE2oXxVm6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864965; c=relaxed/simple;
	bh=GkKM+DBOVd6orqINq/RQKJoYmvqEfIBoyz/KfGtJob0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8bN4ApFd2KTcXQwWEOyF1Ptz0PeXv03sgJIp8mivtsw02zLCgdkLNlxoGQ5N3DDRaEsA3D7fpSj+Zxcv+hgm+WlPi2ZXhAAG8m4DKPnknr4Ur6USZPoIINhLGDsl5cwgx2v42h3FuJo9WpfxAjYk8nDIi5YpTOCUnVx0+KB8nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O+b2CziQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9646FC4CEE2;
	Tue, 18 Feb 2025 07:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739864965;
	bh=GkKM+DBOVd6orqINq/RQKJoYmvqEfIBoyz/KfGtJob0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+b2CziQI7QBIXRcVlCnvy5ky1X8c21WGDfIkounmiyZyG/vLjdrK0+gdRVNq/qe+
	 aMTnIo081BdrszrIrscjueQ6ioi7qyOCmD1sk7Tn6gb66SYCLf2FCeG/I9IkubTS1G
	 nj6l3H/rdy4ijnFbwxXKv4llKeMtCxJupXiKUVx8=
Date: Tue, 18 Feb 2025 08:49:22 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: jaywang-amazon <wanjay@amazon.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] x86/i8253: Disable PIT timer 0 when not in use
Message-ID: <2025021817-jockstrap-urging-d01f@gregkh>
References: <20250217202434.11659-1-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217202434.11659-1-wanjay@amazon.com>

On Mon, Feb 17, 2025 at 08:24:34PM +0000, jaywang-amazon wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> [upstream commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c360]
> 
> Leaving the PIT interrupt running can cause noticeable steal time for
> virtual guests. The VMM generally has a timer which toggles the IRQ input
> to the PIC and I/O APIC, which takes CPU time away from the guest. Even
> on real hardware, running the counter may use power needlessly (albeit
> not much).
> 
> Make sure it's turned off if it isn't going to be used.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Michael Kelley <mhkelley@outlook.com>
> Link: https://lore.kernel.org/all/20240802135555.564941-1-dwmw2@infradead.org
> 
> (cherry picked from commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60)
> 
> Cc: stable@vger.kernel.org # v5.15
> 
> Signed-off-by: jaywang-amazon <wanjay@amazon.com>

Why all the blank space here?

And why not cc: all of the people who did this patch on it?

Also your name needs to be fixed up.

Please work with your coworkers on getting this all right so we don't
have to do this type of basic reviewing for you.  All of your recent
backprots suffer from this and can not be taken, sorry.

greg k-h

