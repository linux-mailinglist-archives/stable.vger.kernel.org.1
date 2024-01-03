Return-Path: <stable+bounces-9254-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E251D822AEB
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 11:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5B3B22F8F
	for <lists+stable@lfdr.de>; Wed,  3 Jan 2024 10:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D7618657;
	Wed,  3 Jan 2024 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gdz/3401"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBC1864A
	for <stable@vger.kernel.org>; Wed,  3 Jan 2024 10:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734BBC433C8;
	Wed,  3 Jan 2024 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704276436;
	bh=lmWKhK/OEhj6Do6ltq6Gf25igB/FRsmAmXsX8KcTTW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gdz/3401LBNPn0rOU/bipnAm+CYVi7SVbAM/2R+BXDRz539BFdLmuqZPRq2epU1Qm
	 c3VfyJsHWdV0602kQBVOQZ1aq3Zh+spo9P9k7lePYZ0a2KXexD054PeWkT03/tfh4x
	 hGtpWFR2gOlU5Q28IqCUvflCFZHxRMEM94lTgHm4=
Date: Wed, 3 Jan 2024 11:07:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: lometsj@live.com, stfrench@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y ] ksmbd: fix slab-out-of-bounds in
 smb_strndup_from_utf16()
Message-ID: <2024010307-itunes-reshuffle-2339@gregkh>
References: <CAKYAXd9kQaQYwBuc_=gMi2mKz3aggjxDvkbTCtYM_oJ5i0Rq4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd9kQaQYwBuc_=gMi2mKz3aggjxDvkbTCtYM_oJ5i0Rq4Q@mail.gmail.com>

On Wed, Jan 03, 2024 at 09:29:16AM +0900, Namjae Jeon wrote:
> From: Namjae Jeon <linkinjeon@kernel.org>
> 
> [ Upstream commit d10c77873ba1e9e6b91905018e29e196fd5f863d ]
> 
> If ->NameOffset/Length is bigger than ->CreateContextsOffset/Length,
> ksmbd_check_message doesn't validate request buffer it correctly.
> So slab-out-of-bounds warning from calling smb_strndup_from_utf16()
> in smb2_open() could happen. If ->NameLength is non-zero, Set the larger
> of the two sums (Name and CreateContext size) as the offset and length of
> the data area.
> 
> Reported-by: Yang Chaoming <lometsj@live.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>  fs/ksmbd/smb2misc.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Now queued up, thanks.

greg k-h

