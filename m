Return-Path: <stable+bounces-159208-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2695AF0E77
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0400844380C
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90B123C4F9;
	Wed,  2 Jul 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Posgb6/I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E6623C4E5
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446242; cv=none; b=KE0SX7WeK9mD3+VTTpXEn01tbwuOX8GCwI63TW1neSZvZvm2DLXWZGEGzFMbNeubSHJ7CiAw5fnKim6y57dQt8l3YN/9cLtGd0pQWXaN2ww+2G254oFfB4yQiFyz3REARltk8sL5kBvMGe+3um9g8chaj6Rv1qUisGE+MAe4yvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446242; c=relaxed/simple;
	bh=n2QJPm+kybT5UdTx1gQm3LNXkYxjN9BZQv8wZbVEXB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIgIN7mCwwyxU9tuTYJtqR5KSwT96S5g0LOVZSU4tie/rSUHfObA7g5LBNXElCw0GASFJx9ll+cV/dtlqfX2/gEddPIne3dR3qhKDCXZddWj6igpQN8fuJLYdJoI5cvorAUD3WMYCOuxMmO76zbqg/c8HLN02YjU24IiqAh5y44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Posgb6/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70FAC4CEED;
	Wed,  2 Jul 2025 08:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751446242;
	bh=n2QJPm+kybT5UdTx1gQm3LNXkYxjN9BZQv8wZbVEXB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Posgb6/Il9wKAbrU1cft6oUk1o6O5mbHeV+4HaepRnt6IgRDLthOHUJ1Xj3HcP+mq
	 /gTxSi16S0jGIlqcwBLkfv2CWRrW10/LZ2D+4kU5Oqan9kIOcNQDHdX9h+UycKXj0T
	 HVx42wjS/KHsUblB5ZhFdqGcofPIto/3p586VxXE=
Date: Wed, 2 Jul 2025 10:50:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: 6.15.5 stable request, regression from 6.15.3..6.15.4
Message-ID: <2025070232-dude-pectin-afa0@gregkh>
References: <3dbc6a08-ad33-467b-babd-437d37312e90@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dbc6a08-ad33-467b-babd-437d37312e90@kernel.dk>

On Mon, Jun 30, 2025 at 07:03:06PM -0600, Jens Axboe wrote:
> Hi,
> 
> Details in the patch attached, but an unrelated vfs change broke io_uring
> for anon inode reading/writing. Please queue this up asap for 6.15.5 so we
> don't have have any further 6.15-stable kernels with this regression.
> 
> You can also just cherry pick it, picks cleanly. Sha is:
> 
> 6f11adcc6f36ffd8f33dbdf5f5ce073368975bc3

Now queued up, thanks.

greg k-h

