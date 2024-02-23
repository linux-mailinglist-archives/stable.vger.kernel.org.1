Return-Path: <stable+bounces-23499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33058616AD
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 17:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AEA1C23F63
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 16:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8E082D6F;
	Fri, 23 Feb 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OffizNI8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A38682C94
	for <stable@vger.kernel.org>; Fri, 23 Feb 2024 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708704055; cv=none; b=Esl4bfp2ZmWtaafmjEP5KhdPTktSp/4grEUntUvEmcIKvyN49PZr5FDkH2ZgrFUPIS8+kzy/ZTmf0QYz8dzknMBilBkTaiGeeqoiZ8F2u3+DkyiyWo21jpwJMIqCU7fnnF0bMZ1OR2kB3qF+fNii+f9O/6JBGqG1wzVIDuFAk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708704055; c=relaxed/simple;
	bh=Ea1QDh7NTI4hN7B6+SJCY/MbovbfIXXlAc7OitRLnT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYzNGKVK/ej9WUlouGHoMrC6siCxYF1SLIE0Dl+kpE/3vgOOEqmw8p+ntJaT0oDjG50AsIMJOHOELe7I9/KKzenUbXTiuZohgfjnayA/6IpGomTUIfciUNu1lIQ1C+e6HemCi+irCBTNxllf1IkezLmzBug53utu+XsZFNJK0WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OffizNI8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DB1C43399;
	Fri, 23 Feb 2024 16:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708704055;
	bh=Ea1QDh7NTI4hN7B6+SJCY/MbovbfIXXlAc7OitRLnT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OffizNI8Igkh4w1sHsmYAGsf/JKe55yfiB+RpEA3bQ5NkBc2cFQrtSLcyxfCXZZHR
	 AQAS+CdjCk6eDf4pEMdjyzVkW/F+RDg48fvc4q1jWowIyRgh2tmZN4Sb1VjM/+5wMd
	 +JovqjwRgZ6jHfu8mm1a09vs+Gw9JyGSlxCdzUXw=
Date: Fri, 23 Feb 2024 17:00:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] zonefs: Improve error handling
Message-ID: <2024022338-boozy-font-b07f@gregkh>
References: <2024021942-driven-backhand-7edd@gregkh>
 <20240220034423.2571184-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220034423.2571184-1-dlemoal@kernel.org>

On Tue, Feb 20, 2024 at 12:44:23PM +0900, Damien Le Moal wrote:
> commit 14db5f64a971fce3d8ea35de4dfc7f443a3efb92 upstream.
> 
> Write error handling is racy and can sometime lead to the error recovery
> path wrongly changing the inode size of a sequential zone file to an
> incorrect value  which results in garbage data being readable at the end
> of a file. There are 2 problems:

<snip>

All now queued up, thanks.

greg k-h

