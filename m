Return-Path: <stable+bounces-6978-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7566B816B37
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 11:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30723282484
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 10:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B614F63;
	Mon, 18 Dec 2023 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nRIAklYM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F34F199C4;
	Mon, 18 Dec 2023 10:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14496C433C7;
	Mon, 18 Dec 2023 10:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702895511;
	bh=lxVWYRHNMIauyDYUXT+4gP3LzQOKn4L8ClRI4XT8nrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nRIAklYMFSEpLvvwm8jlqx/E5dbxEMBgL2nZ3KAIQuAuiG07P4+MvUJwYQw3iXE6x
	 53fyEjIzxo+VYXAFpEGLt9WYe0HQgz1lZU+aT/H7JHNAofJoCiM6Hk8Jo8BvDeUbOY
	 dcdobyFjplTeAPINhAVjvlmL7m/Vu/Ek+bIfT/NM=
Date: Mon, 18 Dec 2023 11:31:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mark O'Donovan <shiftee@posteo.net>
Cc: Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
	stable@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Patch "nvme-auth: unlock mutex in one place only" has been added
 to the 6.1-stable tree
Message-ID: <2023121822-squiggly-septic-d950@gregkh>
References: <20231216210540.1038298-1-sashal@kernel.org>
 <bfe2af35-b057-4335-ade9-8b8cf4d9532b@posteo.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfe2af35-b057-4335-ade9-8b8cf4d9532b@posteo.net>

On Sat, Dec 16, 2023 at 09:33:50PM +0000, Mark O'Donovan wrote:
> This is wrong. This patch should not be applied to 6.1

But 6.6.y is ok?

Why one and not both?

Actually why is this really needed?  I'll drop it from both trees now...

thanks,

greg k-h

