Return-Path: <stable+bounces-116583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9628A38498
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 14:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE70189456F
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1223A21C9F0;
	Mon, 17 Feb 2025 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kqbgyWRn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5F21ADB7;
	Mon, 17 Feb 2025 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798720; cv=none; b=niwhcAv08b/ETA/tou7dyl48l7Ut6VNzHTvqQhjop7OyxNhYWSFD8AUpfsKuHEoap91F4o6Aqf8ix2GrJNcZAeWsN+6Eu8Nw0x/caib71GAg+Vvwhh7Zm6EQyekJIWIDUcvBIHXQCs+99ABfJTk+emNqzG1NA4/mJXo2gWCoJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798720; c=relaxed/simple;
	bh=4E5ZrM3Ckx+c725bWUKVc8Zn+UHOWHT/1ZUVfbkEHxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5VSN6IW6Mrb+JeHLlqgo+O31od78eKHujhbo3jjDJv8H7vkAuLHYMsU0D6ztBT7sEi5Fts6kZkeDWfyAcQL78gawqXkiQH3xYPTVa59utm6bgFGXwCHQraDFKFBFVvxOKO1AzptBCr9sx+lsdygmTFKHHtucaiHuKwJkV79o20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kqbgyWRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C515AC4CED1;
	Mon, 17 Feb 2025 13:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739798720;
	bh=4E5ZrM3Ckx+c725bWUKVc8Zn+UHOWHT/1ZUVfbkEHxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqbgyWRnixQk4nzL777ntVGM6BgoCbGgQlwQhEQUcn2/y2x2HGMr91NbaKm4TQxJb
	 nDci4niFERe0x22zFhNGmptP+jfBHS0QkAy5PpHVRMQ4sRBG6vxz7NsXqnh9bbPgRM
	 RiDd91sHUWnjhqpC7xhy9MH6hNF9cx9rS0G6Bqyc=
Date: Mon, 17 Feb 2025 14:25:16 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Stefan =?iso-8859-1?Q?N=FCrnberger?= <stefan.nuernberger@cyberus-technology.de>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"lwn@lwn.net" <lwn@lwn.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"jslaby@suse.cz" <jslaby@suse.cz>
Subject: Re: Linux 6.13.3
Message-ID: <2025021704-region-calzone-7d24@gregkh>
References: <2025021754-stimuli-duly-4353@gregkh>
 <a082db2605514513a0a8568382d5bd2b6f1877a0.camel@cyberus-technology.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a082db2605514513a0a8568382d5bd2b6f1877a0.camel@cyberus-technology.de>

On Mon, Feb 17, 2025 at 12:41:58PM +0000, Stefan Nürnberger wrote:
> Please revert the commit titled
> "vfio/platform: check the bounds of read/write syscalls" from all the
> latest stable releases (6.13.3, 6.12.14, 6.6.78).

Ah, the joys of patch :(

> The backport was already included in the releases two weeks ago and the
> new one doubles up the existing check. The full list of fixed versions
> (back to 5.4) is correctly mentioned in the associated CVE:
> https://www.cve.org/CVERecord/?id=CVE-2025-21687

And that CVE record now shows the duplicates as well, remember, we keep
them up to date when new stable kernels are released.

I'll go revert this for the next round of kernels, but it's not really a
problem with checking the same thing twice, so nothing is broken.

thanks,

greg k-h

