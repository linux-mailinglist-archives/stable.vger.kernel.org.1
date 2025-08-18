Return-Path: <stable+bounces-169922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E818BB2992F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 07:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C843B7D2B
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 05:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82E0270569;
	Mon, 18 Aug 2025 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1xqZRdCY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F10526B742;
	Mon, 18 Aug 2025 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755496519; cv=none; b=H8r2N74+XP4YJcri5qWFWT2Gnxnqqx/NGEbgYrltflU++T45mZMrzJpuJLgBG6Xy4wljV95lghsNJW/qu9ZcGFRPgBUehTZ3DiMxJC6U4At1A3Qx45WiigpmbPCsQKYfWLt/z13z8lNZmE5OAmZaCjW6n31Z2MG3rHCc8qvlmNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755496519; c=relaxed/simple;
	bh=JvbvWqFM2nCr7Bg1exEFYkJB0h6NgS45kcoubGExQIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+Ri7HOZ0K679tDLbtA23Jf1d0PTi94BINCAXEzpNCvCazUdX88XdoxUrjmtXv9MRN1fE42K1RK4gacfCxNEbka6acPwcgrG7kGnf2p0tTGQq9UlojyRRMoGlOmtCXt8JIeib2h3rZAX1cNVC/CJvPqa4y4OAMehibTInIYw1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1xqZRdCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52DBC4CEEB;
	Mon, 18 Aug 2025 05:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755496519;
	bh=JvbvWqFM2nCr7Bg1exEFYkJB0h6NgS45kcoubGExQIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1xqZRdCYM7REWdBgR5gQcb5ph3uGGz4jht8G9J4Bil7rwj+zh1bREhh2nzdFLjSUg
	 x5dFJ6M6oIwuD8sM9NdQCsDACDEwQkeQwzMhr4p1D++eFpQgQrIgP6dWKGvh1uWQVp
	 b5lKZPIudCw0m9gh21dp1hnqR1P25Vx7SePYtr9I=
Date: Mon, 18 Aug 2025 07:55:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org, xni@redhat.com,
	Song Liu <song@kernel.org>, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Patch "md: call del_gendisk in control path" has been added to
 the 6.6-stable tree
Message-ID: <2025081846-veneering-radish-498d@gregkh>
References: <20250817141818.2370452-1-sashal@kernel.org>
 <7748b907-8279-c222-d4e4-b94c3216408b@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7748b907-8279-c222-d4e4-b94c3216408b@huaweicloud.com>

On Mon, Aug 18, 2025 at 09:03:39AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/17 22:18, Sasha Levin 写道:
> > This is a note to let you know that I've just added the patch titled
> > 
> >      md: call del_gendisk in control path
> > 
> > to the 6.6-stable tree which can be found at:
> >      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >       md-call-del_gendisk-in-control-path.patch
> > and it can be found in the queue-6.6 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> This patch should be be backported to any stable kernel, this change
> will break user tools mdadm:
> 
> https://lore.kernel.org/all/f654db67-a5a5-114b-09b8-00db303daab7@redhat.com/

Is it reverted in Linus's tree?

thanks,

greg k-h

