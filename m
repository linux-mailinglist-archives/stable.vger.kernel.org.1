Return-Path: <stable+bounces-23896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4B986911B
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9BD1C21CF5
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A0013A896;
	Tue, 27 Feb 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a+lUmmWc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C139E13A275
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038684; cv=none; b=WO96n7GwDQzQftfMWG40ipvkWcNK/FvnAc4L+VLgHuZz+dLGkxCQDs/piuYExxBp9v4m2pvn+Y5JucZsLn2UntKAQQorPvpX3ZdvRfSIFQwdJ+0WkvIPDMNv9fkHyugtbpaIiTVwXqWfN1201NvS6kSRifxb4tFHv+pslkfqxPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038684; c=relaxed/simple;
	bh=wO5xgP+ys/I48EjOZKgdmjLoaMN1QtQ4Y7xIMwvMzUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTYO+5wWxKT0n3B6iyp6SaAj4H0sGJJ3UrMcCpZnJKRPVq8BJkd6k/4M8PuyakTUw6boUusXu7tK2cOuOKO6eyc3WaUUOy1xRJ/FgJ9iehEMnVgznL0nByxNFMuqL9j6deeqsseL1Pgj3xoTNz1hIeTxdGqYlvq/M9Vg5rf2BL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a+lUmmWc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3C0C433C7;
	Tue, 27 Feb 2024 12:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709038684;
	bh=wO5xgP+ys/I48EjOZKgdmjLoaMN1QtQ4Y7xIMwvMzUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a+lUmmWcVjKDPPmw/iLERkg6g+0m5E5DBWjkpQiev4bb3D+Og2OAMQ+uSVZLtYyV7
	 wUKdVtNcQWzs5tUiItLT7nwysT/yxxAdFUX4GhiMl/nYYO7QDEccpmgUO1hxJcl/Lc
	 I69UJSSXCGoXW3dHoI2TeT3K1lZA0QCNVanmPRSE=
Date: Tue, 27 Feb 2024 13:58:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Doebel, Bjoern" <doebel@amazon.de>
Cc: stable@vger.kernel.org, almaz.alexandrovich@paragon-software.com,
	edward.lo@ambergroup.io
Subject: Re: Backport commit 4f082a753122 "fs/ntfs3: Enhance the attribute
 size check"
Message-ID: <2024022752-scenic-praying-4e60@gregkh>
References: <799facc9-af53-4bdc-9264-0cebf0b9baae@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <799facc9-af53-4bdc-9264-0cebf0b9baae@amazon.de>

On Tue, Feb 27, 2024 at 01:38:53PM +0100, Doebel, Bjoern wrote:
> Hi,
> 
> please backport commit 4f082a753122 "fs/ntfs3: Enhance the attribute size check" to the 6.1 stable branch.

Now queued up, thanks!

greg k-h

