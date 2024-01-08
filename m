Return-Path: <stable+bounces-10021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7B08270CB
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBB0283A8B
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC445C15;
	Mon,  8 Jan 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mypvNLs5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CEA45BF6;
	Mon,  8 Jan 2024 14:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF4DC433C7;
	Mon,  8 Jan 2024 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704723193;
	bh=DMRsklMR8P9d0F90QDPNkLTmnPVPCiEoQBWpGF9hW1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mypvNLs5XlpGVxgNpq/lTji0dFqPlCI1zp1wJIV+LkOqOCmsj2PBlaOmZsdCKGNn2
	 0mswuOXV++NqtquzRoLkMCt5aT2ppudsYrJ+K4G6EgMctgmNsY0C1diQ6/WOydRKRY
	 R9MfhPcnVO03/hIxNSR68DaJweUqTTLTjkXIFuqk=
Date: Mon, 8 Jan 2024 15:13:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>
Cc: Leonardo Brondani Schenkel <leonardo@schenkel.net>,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-cifs@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>
Subject: Re: [REGRESSION 6.1.70] system calls with CIFS mounts failing with
 "Resource temporarily unavailable"
Message-ID: <2024010838-saddlebag-overspend-e027@gregkh>
References: <8ad7c20e-0645-40f3-96e6-75257b4bd31a@schenkel.net>
 <7425b05a-d9a1-4c06-89a2-575504e132c3@sairon.cz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7425b05a-d9a1-4c06-89a2-575504e132c3@sairon.cz>

On Mon, Jan 08, 2024 at 12:18:26PM +0100, Jan Čermák wrote:
> Hi,
> 
> I confirm Leonardo's findings about 6.1.70 introducing this regression, this
> issue manifested in Home Assistant OS [1] which was recently bumped to that
> version. I bisected the issue between 6.1.69 and 6.1.70 which pointed me to
> this bad commit:
> 
> ----
> commit bef4315f19ba6f434054f58b958c0cf058c7a43f (refs/bisect/bad)
> Author: Paulo Alcantara <pc@manguebit.com>
> Date:   Wed Dec 13 12:25:57 2023 -0300
> 
>     smb: client: fix OOB in SMB2_query_info_init()
> 
>     commit 33eae65c6f49770fec7a662935d4eb4a6406d24b upstream.
> 
>     A small CIFS buffer (448 bytes) isn't big enough to hold
>     SMB2_QUERY_INFO request along with user's input data from
>     CIFS_QUERY_INFO ioctl.  That is, if the user passed an input buffer >
>     344 bytes, the client will memcpy() off the end of @req->Buffer in
>     SMB2_query_info_init() thus causing the following KASAN splat:
> 
> (snip...)
> ----
> 
> Reverting this change on 6.1.y makes the error go away.

That's interesting, there's a different cifs report that says a
different commit was the issue:
	https://lore.kernel.org/r/ZZhrpNJ3zxMR8wcU@eldamar.lan

is that the same as this one?

thanks,

greg k-h

