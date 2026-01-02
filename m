Return-Path: <stable+bounces-204432-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0CECEDAFE
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 07:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3439E300548D
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 06:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04C8238C3A;
	Fri,  2 Jan 2026 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z38t9jdR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D011E1DF0
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767336768; cv=none; b=T2XF+fyejgV/fSHk6DodXww3DbYmhJbARKcutohGRfqvfOU9FXRGUZTGGuY7mcf7epZE1Vw1YObyweF5WVCzyjvBXt3mjIRcBD8yL62HyruYaBiA3WP2gb7DThD1EE6oId1lp1PWloYUcumTmFer3I83ZR6z8xDgintycEqk2v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767336768; c=relaxed/simple;
	bh=xRmGFTnGdmaQl9nQctDGZcEGhSU/mRAzqqJCgFJVZ4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN4aUu6fferT6kNGs03tSuc93cO3VbPseT6NVCGguHe4o2t2NmOEu++GOQt+aqxzvFhOSywadTYRAd2GVomHFNSN9Q2j4cxWCA1/HeCA8H0u7U7H7rItGbl6ycg+9fxhuVzpOP1A5gnXK8pcPbtmuFAZlqrZOLC1ujjyqpqgxuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z38t9jdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F21FC116B1;
	Fri,  2 Jan 2026 06:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767336766;
	bh=xRmGFTnGdmaQl9nQctDGZcEGhSU/mRAzqqJCgFJVZ4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z38t9jdRcPqLc0n0VEmmCCV9dVZAKuJcGnVGyes2Wm12qsLkUfSOQKOWO8i7qbtAF
	 lZ9CiHfNRhEvC1kAEtzUEeqqIDNDJGwBwcqBOWhlLp2lO7I/q/oM68s5XSXhsvco/k
	 C9yIdL2hSOkZ6/qtFZw3lt6MKbnk+iZNV55LDweI=
Date: Fri, 2 Jan 2026 07:52:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio Callegari <sergio.callegari@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Sd card race on resume with filesystem errors (possible data
 loss?)
Message-ID: <2026010216-replay-polar-18b5@gregkh>
References: <547b67dc-0b01-41f7-92a8-ab4371195f40@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <547b67dc-0b01-41f7-92a8-ab4371195f40@gmail.com>

On Wed, Dec 31, 2025 at 06:21:32PM +0100, Sergio Callegari wrote:
> Hi and happy new year!
> 
> I would like to report a problem that I am encountering with the sdcard
> storage.

Great, but I would recommend contacting the storage developers, they are
not here on just the stable list.

thanks,

greg k-h

