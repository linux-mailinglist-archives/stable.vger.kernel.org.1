Return-Path: <stable+bounces-45656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D128CD168
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003842837EB
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D07148843;
	Thu, 23 May 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GVMP4KfG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C2A50276
	for <stable@vger.kernel.org>; Thu, 23 May 2024 11:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464431; cv=none; b=sKjKJAsTIn+MeJXUzUu6cjVf5gmjmQbVNH2N8qmCDKrHyMqZC5xQwV/+Y3j9OwbTqEO8Enu+qUKiogOqadAof7qfVokxaTlh5oIlzfQUEEqPSEKgQzu/3L+wXfxLROffOAL0Yuo0/U+AKPg1rfBWtBwznkFUrYWJqhCUGgBMRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464431; c=relaxed/simple;
	bh=qr06mU2grXGusJTWp7Hc3OrH0n8fvbLg0ohyArFtPxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbI8a7xI9AowQEeLpWYpMcwrCKltM0cPfDEpEFU9VgLf1WUt6mA5nrP4qQf/0dkahB6znKCpY95gvb1DqS3jfjYT/ENuKAo3v1CtR7YzT02c4ytW+3dn3I7kTBUUn4DADgnXL/7hnpQIHSWz0s6gyz0L+IA+u4DxD2wI9WMYeLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GVMP4KfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D3AC2BD10;
	Thu, 23 May 2024 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716464431;
	bh=qr06mU2grXGusJTWp7Hc3OrH0n8fvbLg0ohyArFtPxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVMP4KfGM0XR35Q6VjjKTVxv3kyFQeDLH54IFSvGnCXc2n2cnrsLxMzo6R6Y+rXyg
	 qAc9sBLDECPKhSPOKfHl+Jm3N+vEU53r8MpOrvV+DTV9PU0YMf/snWJ3viP6fKVujq
	 C7pDhglJ54Sz7tVZGWj+7Fx+Th32c4E+zuYyXirE=
Date: Thu, 23 May 2024 13:40:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Srish Srinivasan <srish.srinivasan@broadcom.com>
Cc: stable@vger.kernel.org, agk@redhat.com, snitzer@redhat.com,
	dm-devel@redhat.com, ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, He Gao <hegao@google.com>
Subject: Re: [PATCH v4.19] dm: limit the number of targets and parameter size
 area
Message-ID: <2024052321-keenness-judge-564c@gregkh>
References: <20240506100435.2059451-1-srish.srinivasan@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506100435.2059451-1-srish.srinivasan@broadcom.com>

On Mon, May 06, 2024 at 03:34:35PM +0530, Srish Srinivasan wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
> 
> commit bd504bcfec41a503b32054da5472904b404341a4 upstream.
> 
> The kvmalloc function fails with a warning if the size is larger than
> INT_MAX. The warning was triggered by a syscall testing robot.
> 
> In order to avoid the warning, this commit limits the number of targets to
> 1048576 and the size of the parameter area to 1073741824.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: He Gao <hegao@google.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [srish: Apply to stable branch linux-4.19.y]
> Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>
> ---
>  drivers/md/dm-core.h  | 2 ++
>  drivers/md/dm-ioctl.c | 3 ++-
>  drivers/md/dm-table.c | 9 +++++++--
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 

Now queued up, thanks.

greg k-h

