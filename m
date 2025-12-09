Return-Path: <stable+bounces-200428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EA0CAE99A
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 02:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DACA30E3C67
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB6526FDBB;
	Tue,  9 Dec 2025 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pd6JSIMY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE2C3B8D40;
	Tue,  9 Dec 2025 01:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765242730; cv=none; b=Or6LupqYZ3a7QDzoGFQvZ2JWmhwC+2q4T1H+R9KmAJHco+Iea46Whe9V6JZ0XXwDx+HX3jvRTDqNGlzLjFShG/xYt59A3ZDYOoicCeas1twaBPK1g/JL7Owk+qRFWmHHIaotEF3dMSXfcAVAJcrmaeMvlHxQPUiJoXc/lATV/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765242730; c=relaxed/simple;
	bh=tdPB2PgMe3mUkDXQiTbjYNJfDLYriS/A9ApOIexKkXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CleQO+KEeY6f3Sn5QsY1MzJk1fwH70ledW4M8GJP3QKSOY4XmKmS+bQV7ZT/B5199Iu0Wva4u4PjCVoZd02R5xp5Lr48TlAHQay339aOHpzJVn76RHVn92qohoL/JrpSPtI2B3mQzzOPbj16ksr3TDNSHFzjjjKdXWgnGopLhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pd6JSIMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DA3C4CEF1;
	Tue,  9 Dec 2025 01:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765242729;
	bh=tdPB2PgMe3mUkDXQiTbjYNJfDLYriS/A9ApOIexKkXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pd6JSIMYFMnskJxSUCN+xCQbB9d2BHLm4McvapDYGN03mSx0XzAQCAC+fKUpQ+7up
	 E9YTpP2bwrE3vWqxOLt4ilYOf5nbXESIm5GHpImOXscbu9vpO8SI5RQwbT2GBMQA96
	 AUQvg5Q9fLDlsDiiRFrKegZ/ywzlkOMyd2ZdHW3c=
Date: Tue, 9 Dec 2025 10:12:05 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Slavin Liu <slavin452@gmail.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, stable@vger.kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [BUG] Missing backport for commit b441cf3f8c4b ("xfrm: delete
 x->tunnel as we delete x")
Message-ID: <2025120949-harddisk-condone-fd95@gregkh>
References: <aS14lT5jZKpwAg4N@secunet.com>
 <20251209010626.1080-1-slavin452@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209010626.1080-1-slavin452@gmail.com>

On Tue, Dec 09, 2025 at 09:06:26AM +0800, Slavin Liu wrote:
> Thanks for the clarification.
> 
> In that case, I would like to request backporting both of the following 
> commits to the LTS kernels to resolve the UAF issue:
> 
> Commit b441cf3f8c4b ("xfrm: delete x->tunnel as we delete x")
> Commit 10deb6986484 ("xfrm: also call xfrm_state_delete_tunnel at destroy 
> time for states that were never added")
> 
> Please consider queuing them up together.

I have no context here :(

Anyway, these commits are all queued up now.

thanks,
greg k-h

