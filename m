Return-Path: <stable+bounces-100538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF1B9EC559
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 08:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E5518837B9
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 07:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153E41C3F3B;
	Wed, 11 Dec 2024 07:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W6OenLjZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74431C683
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733900935; cv=none; b=dZS9CLT6H+49YwUyjuJXu8xLaxdMSy9pyptwyN+YvPR9HRibu+11SwfIumNNGmiVUhCx/zxlYIc0amb+vgfGSDO/9LBOTftt9T1DY5nAIvctDDfU+WyTYc2lexHwGrvUBxeCWKOIMVeZ704RElzxNAN+IkejptYijEgprAI7HEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733900935; c=relaxed/simple;
	bh=9p2IgtvvPHfJUnR6QdYKU6gDMbWm+aWT8vIUDSNuqmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PmtNsiunqk9fKM0AACxhXIVwb2Q1XAxPz/eNmPEoort0Eo7B9tr8pWSWV8k0/A+FDoWVPkSX6isYNJyFbAOgnpTk/pZRz9ctZ9kTP3K3i+uBXNGkUYFcU2N+EaytUPvhzphgOf6pJj2vr1FC73hWqyz1NXt9FOfNaT7BH0118xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W6OenLjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F12C4CED2;
	Wed, 11 Dec 2024 07:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733900935;
	bh=9p2IgtvvPHfJUnR6QdYKU6gDMbWm+aWT8vIUDSNuqmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W6OenLjZfbM4aTb0PmVuFn//MkhUqMxW6ShnbD02DSRIGixAcI7TQYjfzW2pSfJxp
	 2/FBYsLvRoYj9pvxrfSx9vsYfuZPFqGgKGJNzcKwH6h+v5JSWUWQjxM3MHIM7icJja
	 Bu2moCRggEQWyz1H+5UCU6AfnCBDMPuh5Ib+cwec=
Date: Wed, 11 Dec 2024 08:08:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: performance regression fix in nvme backport to 6.12.y
Message-ID: <2024121101-flashcard-whenever-fc08@gregkh>
References: <1DB6C887-2C97-40C8-8C8D-0F38CE68AC0F@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1DB6C887-2C97-40C8-8C8D-0F38CE68AC0F@oracle.com>

On Tue, Dec 10, 2024 at 10:28:57PM +0000, Saeed Mirzamohammadi wrote:
> Hi,
> 
> Could you please apply the following performance regression fix that is now in mainline to 6.12.y stable branch?
> 
> Commit Data:
>   commit-id        : 58a0c875ce028678c9594c7bdf3fe33462392808
>   summary          : nvme: don't apply NVME_QUIRK_DEALLOCATE_ZEROES when DSM is not supported
>   author           : hch@hera.kernel.org
>   author date      : 2024-11-27 06:42:18
>   committer        : kbusch@kernel.org
>   committer date   : 2024-12-02 18:03:19
>   stable patch-id  : 7975710aeefd128836b498f0ac4dedbe6b4068d8
> 
> In Branches:
>   kernel_dot_org/torvalds_linux.git  master                 - 58a0c875ce02
>   kernel_dot_org/linux-stable.git    master                 - 58a0c875ce02

Any reason why you didn't also cc: all of the people involved in this
commit?

