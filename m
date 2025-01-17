Return-Path: <stable+bounces-109398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52031A152ED
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA087A4231
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681616DC3C;
	Fri, 17 Jan 2025 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b4+X/9EQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64165D530
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 15:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128287; cv=none; b=VaZJqNGluGDZVHnshTxaaPAtYLcGlswjmv90sFHnfDp/hhWIWo8z9iRAKnXvjp+rnPBtlwVObHv6VNOOohl1ZsRUKR6izBreWTfbDC7DgoyhEvwNzaiAKINRovhoSQb4mtdcf9MGZEd4UzSD23JBUeHJJWTx6zKdIJAY3yCNBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128287; c=relaxed/simple;
	bh=KgNsd6tgxu++dol7ndtvGZI7pvxvQDWsb3+EMr/c1qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rms4fK+LMjKUkMjuzWAgO4NSxGOxxFgYV4cAxyTDfUR3rpoDD0GM05T5MyvxY9A7Pqy2Q4cyAKn2CKTYBan6HbO/+FdRs5PwUvOiCvwjvXtrgBFLoVLYDDTIYga8hkRo3L/Fe76GKgA3kQTdeS1JiQde1Ybm73YnmCm4mkhs27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b4+X/9EQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDA1C4CEDD;
	Fri, 17 Jan 2025 15:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737128286;
	bh=KgNsd6tgxu++dol7ndtvGZI7pvxvQDWsb3+EMr/c1qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4+X/9EQUWABMuoTr/+0DcGC6blpr3jWq+RtbpabAt8dmAZ2X8ULQQMKiGcsvylh1
	 mYq2nCGDwWnAwkVtE6ReZ7F67BCvSncn4TYyUSkoVw6IqHdYFGrggqR7MvO+I2wn6g
	 3NNfvdlBryLWxyLpWOe9dfYK7x+TZqN4/+dPpPVg=
Date: Fri, 17 Jan 2025 16:38:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Terry Tritton <terry.tritton@linaro.org>
Cc: stable <stable@vger.kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
	Sasha Levin <sashal@kernel.org>,
	Daniel Verkamp <dverkamp@chromium.org>
Subject: Re: [REGRESSION] Cuttlefish boot issue on lts branches
Message-ID: <2025011749-rust-bartender-9ecb@gregkh>
References: <CABeuJB2PdWVaP_8EUe34CJwoVRLuU8tMi6kVkWok5EAxwpiEHw@mail.gmail.com>
 <2025011740-driller-rendering-e85d@gregkh>
 <CABeuJB3xEQfgx1TiKyxREQjTJ6jh=xt=N7bTQoKgjAN1Xoa5WA@mail.gmail.com>
 <2025011710-chug-hefty-2fd6@gregkh>
 <CABeuJB0jMbysm06guUvCA_O9Dbqmd6n0X93deiVtqgQwWW9TQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABeuJB0jMbysm06guUvCA_O9Dbqmd6n0X93deiVtqgQwWW9TQA@mail.gmail.com>

On Fri, Jan 17, 2025 at 03:18:01PM +0000, Terry Tritton wrote:
> > One for each branch please, as the git ids for the commit is different
> > on each one, right?
> 
> Thanks that's what I assumed but wasn't sure if there was some script
> that did some magic.
> 
> Sent those to stable now, let me know if there are any issues.

Looks good, I'll get to them next week...

greg k-h

