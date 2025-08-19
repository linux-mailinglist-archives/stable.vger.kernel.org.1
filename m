Return-Path: <stable+bounces-171764-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D8CB2C012
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 13:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047D11BC2AE1
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 11:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A981F326D40;
	Tue, 19 Aug 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lsNw0tW6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B83F27586C;
	Tue, 19 Aug 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602314; cv=none; b=s/yh7OxWE2dMserKiEdgB0risKLknVTUc8/db22eTAG7hJQe4ePEEKGC6UfDP2uE9alRpO0iVVtQFgzLG9x8TobX9/vK1o7M8JhOLHR8nvlpA9khkYGNgiq01gPGg+2RCX0n8QGy/j2MCTaMeVocwY9Eel4tU8AydcukGojVtWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602314; c=relaxed/simple;
	bh=aLhnNIcDt23uH43MseyIo2dgJ0SryOAJ5P53JjqN+Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9tFHw6dWjMnz7HyxhWDioWLCLFG3GYPHxGevAe5q+tn3sBIm0U+CyOfGKYgxCdIaGpHrTOVzUMFjWIPxdITSu33c7ozPvGSVB/FtQiUOq1wTj35AxTcN9/mD8ewwNcSzisIsfDCDIlae24ofDyzwX/b/0FeW7zML2uO8JG4Rms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lsNw0tW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CB0C4CEF1;
	Tue, 19 Aug 2025 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755602313;
	bh=aLhnNIcDt23uH43MseyIo2dgJ0SryOAJ5P53JjqN+Co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lsNw0tW6yibxj07+KhOMK2O8uTje0CUH03250Rbbb1M67qiAkAActu9hzruc3oasP
	 XwWSb00TdzSeMTmc+tSnl0tzOem9zXvWGCts2IMnqjrwYJ3j/lebUwFua5G1m0cruO
	 A5A0xPcegBQpbLs1osZ4nFas5OrbQ64AI50Owlkk=
Date: Tue, 19 Aug 2025 13:18:30 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Charalampos Mitrodimas <charmitro@posteo.net>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Eric Sandeen <sandeen@redhat.com>
Subject: Re: [PATCH v3] debugfs: fix mount options not being applied
Message-ID: <2025081958-scolding-spruce-696c@gregkh>
References: <20250816-debugfs-mount-opts-v3-1-d271dad57b5b@posteo.net>
 <20250819-hotel-talent-c8de78760a68@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-hotel-talent-c8de78760a68@brauner>

On Tue, Aug 19, 2025 at 01:11:58PM +0200, Christian Brauner wrote:
> On Sat, 16 Aug 2025 14:14:37 +0000, Charalampos Mitrodimas wrote:
> > Mount options (uid, gid, mode) are silently ignored when debugfs is
> > mounted. This is a regression introduced during the conversion to the
> > new mount API.
> > 
> > When the mount API conversion was done, the parsed options were never
> > applied to the superblock when it was reused. As a result, the mount
> > options were ignored when debugfs was mounted.
> > 
> > [...]
> 
> Applied to the vfs-6.18.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.18.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.18.misc
> 
> [1/1] debugfs: fix mount options not being applied
>       https://git.kernel.org/vfs/vfs/c/8e7e265d558e

I've also included this in the driver-core -linus branch, so it should
have been in linux-next for a few days now.  I guess both versions can't
hurt :)

thanks

greg k-h

