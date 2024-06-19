Return-Path: <stable+bounces-53841-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEA690EA51
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3D21C21803
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288C813E3EB;
	Wed, 19 Jun 2024 12:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xotcFIWj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBFB135A6D
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798576; cv=none; b=a9q/bLnfzThBFOoMj83EC2CvfzNF+sQPgxikvRwszOBNKcJSA5eyf1kjo7FGj4jEouYpY1t5NmkFm4GXgo4natP8zMZK2jh9XgSwzXgqfXJShHzXTTGqX9xDudYTwDZGqFEGWnNB+Vf6h7CKNUWUSN4SZs24nw8Bsnj2b+pakes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798576; c=relaxed/simple;
	bh=mEhPAZ6TLMcGlK/ESlx9IlF5gbMk+0kZ8Z1G/TW7aNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilMBz5dOzhPSm9reKOSwYOkYZw3E6+D3CoCsq4n5ijXYxJWbFu9c/+XU6BelutdgqmUqxQHzo0qRxphb5wJ17XLNYlvV2aRfc5XGoMB1M2PH7GiAx9x74VxMvLULgooTSsTQqXNZ2Df4ouRDgHbO9mMRLK3y+cXYvB+6XQLpD4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xotcFIWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C12CC2BBFC;
	Wed, 19 Jun 2024 12:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718798576;
	bh=mEhPAZ6TLMcGlK/ESlx9IlF5gbMk+0kZ8Z1G/TW7aNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xotcFIWjXdJ7ATuGmS8/aQAQWuekMo4wP8TFWA3JWuy/eX0/Ulr2zA/WqsDHmu6r/
	 JpAuFRQb0ptSpaOlVJRb6J7K9gcX63HS/peTSrAWkPPPKLCfmdwvj63l98JRXjvI9o
	 D7zGWzYUyfQoy9TUTZKIkGBTmCsx5MVjiYl+vaLA=
Date: Wed, 19 Jun 2024 14:02:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ronnie Sahlberg <rsahlberg@ciq.com>
Cc: stable@vger.kernel.org
Subject: Re: Candidates for stable v6.9..v6.10-rc3 Use after free
Message-ID: <2024061944-womankind-oak-e74b@gregkh>
References: <CAK4epfx_PohoB=QwKb96NE6yOFX1U3LYCAnfdZumaJT_qSan_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK4epfx_PohoB=QwKb96NE6yOFX1U3LYCAnfdZumaJT_qSan_g@mail.gmail.com>

On Fri, Jun 14, 2024 at 07:11:04PM -0400, Ronnie Sahlberg wrote:
> Here is a list of potential Use after free that are not yet in
> linux-running-stable
> The list has been manually pruned and I believe they are all genuine issues.
> 
> 546ceb1dfdac866648ec
> 36c92936e868601fa1f4
> 4e7aaa6b82d63e8ddcbf
> 2884dc7d08d98a89d8d6
> 166fcf86cd34e15c7f38
> 4b4391e77a6bf24cba2e
> da4a827416066191aafe
> de3e26f9e5b76fc62807
> 0fc75c5940fa634d84e6
> 647535760a00a854c185
> a4edf675ba3357f60e2e
> 90e823498881fb8a91d8
> 2c6b531020f0590db3b6
> 7172dc93d621d5dc302d
> 86735b57c905e775f05d
> 795bb82d12a16a4cee42
> 2ecd487b670fcbb1ad48

Again, lots of false-positives here :(

