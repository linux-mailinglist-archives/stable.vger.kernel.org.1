Return-Path: <stable+bounces-50240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 113CE90527F
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3696B20D5A
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FF416F84E;
	Wed, 12 Jun 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YMaqBwsa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F265F16E881;
	Wed, 12 Jun 2024 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195501; cv=none; b=Gu0hcX6JJeERXabxb3kgzX+l9GBc1AKMfHqk5xW7QawD3hkPDUfmHoZMFre5sexSNfvEUb97jlrfjNO6MhZctb29sdJ2ikhN53Fm63rKrT6CanDQhxojS0b7/IYaUJBSb4w+f3dXB5iRSOVDYb+N7cZGaMOJUPef4rj64WGkT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195501; c=relaxed/simple;
	bh=+2vL/S1O23FjoDP4Hh9mAj1ndA29Hs6YYae/q1VNlJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0+JeE/iSU4QihsqPTQBf76fReFBqZ98aDONxr5JEpXw8/O29R3WVdpaJXveQ9nb6qShXpcZ8HeyX4bL+/LBHAir8I1lECi6awD+N+qnWDGlCncH8QeViNUNrBZbTL8XpE3VRBdZgSIeH3GOdczPRe5djh0BElxyqxztDPQ8AUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YMaqBwsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98F18C32789;
	Wed, 12 Jun 2024 12:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718195500;
	bh=+2vL/S1O23FjoDP4Hh9mAj1ndA29Hs6YYae/q1VNlJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMaqBwsaX+Tn982jCenryorgBRIapWzzboRHeFW2m2JE/KE8BdwIYfrg6SBzUl+d5
	 8QgDaJhufxTsZsjuuovJ98gPDZKO0+zSJ2qEloNLwD1DtNxTxGbto6QR80CY8oQHCt
	 Hy/gFq3sGUHUi5ynSu0aVw50SeOuUlgfozxaVL3o=
Date: Wed, 12 Jun 2024 14:31:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffrey E Altman <jaltman@auristor.com>
Cc: linux-stable <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Backport request: commit
 29be9100aca2915fab54b5693309bc42956542e5 ("afs: Don't cross .backup
 mountpoint from backup volume")
Message-ID: <2024061230-flyer-cupping-86bb@gregkh>
References: <2f3691b1-4f19-4a21-b235-a46ae54b8424@auristor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f3691b1-4f19-4a21-b235-a46ae54b8424@auristor.com>

On Tue, Jun 04, 2024 at 11:50:06AM -0400, Jeffrey E Altman wrote:
> Please backport to the following patch which was merged upstream.
> 
> It should apply to linux-5.4.y and later.
> 
> commit 29be9100aca2915fab54b5693309bc42956542e5

Now queued up, thanks.

greg k-h

