Return-Path: <stable+bounces-104006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6319F0AA5
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 12:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D311881D99
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36DA1DB520;
	Fri, 13 Dec 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DF8fZKwl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E46E1D9592
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 11:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088495; cv=none; b=koDIXT0DX6KqlByObSVt6c9Q1i4DtEuik4I1qU86NqvnPvUZoimoK/kdBZis5Kzx4vX1axNwM6y7vzVurJoGvbr+E6WHjsJ25CPBfk9ZoHJyosv/KrucTEOecYhfvSflvRw5E5nYgXPOPiCWaROKuqEBsuktqCJ63llVk0xKd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088495; c=relaxed/simple;
	bh=Sg21WLr5uomJHOy4JrgtVeSHvtXbtFRw2KbT3XM8Thg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCOqFiCNGAIRsdmDDvvYniAdpEc5yf0PB3foi8xNh8T9h3QRZepYA2lHjg9HT4k5WlgIo/CBpwhoyGO5+V4oIR1lZ3TPiWMWLywALXFmsRfa0NKojkZuNGLtZi96oyADs9E1OqpCsV2s7H68BgEPsJGbdTY3zUvdhzgCzNNsu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DF8fZKwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D926C4CED4;
	Fri, 13 Dec 2024 11:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734088494;
	bh=Sg21WLr5uomJHOy4JrgtVeSHvtXbtFRw2KbT3XM8Thg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DF8fZKwluM4kDyQPMfH16bddVY9fwjrOvWZAkmG5mRm2I48JkBCKcwI5yDcjbYVSY
	 PHYDh28ors3cFEx2ZJfx0KQAOC7XRxFf1eqyH6OeG5SfinXJTVv/HCcK0gKeP9dagj
	 9lewTqFaZuvAPcZi7LKt4hRbnQc4H2o5sQNcTyeE=
Date: Fri, 13 Dec 2024 12:14:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: bin.lan.cn@eng.windriver.com
Cc: stable@vger.kernel.org, libaokun1@huawei.com, jack@suse.cz
Subject: Re: [PATCH 6.1] ext4: fix uninitialized ratelimit_state->lock access
 in __ext4_fill_super()
Message-ID: <2024121345-comment-dislike-a7b5@gregkh>
References: <20241213071055.3601224-1-bin.lan.cn@eng.windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213071055.3601224-1-bin.lan.cn@eng.windriver.com>

On Fri, Dec 13, 2024 at 03:10:55PM +0800, bin.lan.cn@eng.windriver.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> [ Upstream commit b4b4fda34e535756f9e774fb2d09c4537b7dfd1c ]
> 


Now deleted, please see:
        https://lore.kernel.org/r/2024121322-conjuror-gap-b542@gregkh
for what you all need to do, TOGETHER, to get this fixed and so that I
can accept patches from your company in the future.

thanks,

greg k-h

