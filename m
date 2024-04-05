Return-Path: <stable+bounces-36037-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989278995F4
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373001F22F15
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18F92561B;
	Fri,  5 Apr 2024 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QGqYB09G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0732557A
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300061; cv=none; b=MnFupg9QqJWIN21b6oHEwoUUyST58yjzbuvJkM4JDQLzw0TdAiC9vlK1Xp0/nBorLqWmeddZwyCxuWPlE7yn/uvPyShAomuJYpnr7QhDokEtxkePlGNsKf5zoUztEyqPMYbIj5LPk3fZQrk/rRnJ7BK0PgK9xp11LrguvaZfPUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300061; c=relaxed/simple;
	bh=GGWOGcWHW1b4w29/lzo8Sy4pCXN19o6C15I2o+PCr0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNm+GkJ6/m5dfAI92CR6S54Od+Zu7IL94JAMAzNXnrVEvkw4XiTR8DhNihY1n6IdyfAhXURH7ifQUy/NvQO4dSvnsyJYhNFjTBky5Dee7OYldjjlIuC20RIYbq9d0MdWadhfkbUinh+rlTZ+e2gXLTA3mjvQXlU9etKnUwX1VQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QGqYB09G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5537C433F1;
	Fri,  5 Apr 2024 06:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712300061;
	bh=GGWOGcWHW1b4w29/lzo8Sy4pCXN19o6C15I2o+PCr0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QGqYB09G7viKlvsZ69DLNgopHgLUblhAKXgXKjcdoNPPkcDkYunCnaM4hfLJ6ygbP
	 wxAGYfHAj6WdTBvJls9t4dt42dNmbLLAqZ2MaUyzYknmAqd4IQqlrpkPO3kuVOaGGr
	 OTktObEnnsdXFZgkD13BIe0cqKBHvoe2GuYnc70A=
Date: Fri, 5 Apr 2024 08:54:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: luiz.von.dentz@intel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] Bluetooth: hci_sync: Fix not checking
 error on" failed to apply to 6.8-stable tree
Message-ID: <2024040507-duplicity-conical-fef6@gregkh>
References: <2024040517-sharpener-displace-6491@gregkh>
 <ef6a8d2b-c4f2-4222-9d91-07415306001c@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6a8d2b-c4f2-4222-9d91-07415306001c@leemhuis.info>

On Fri, Apr 05, 2024 at 08:37:03AM +0200, Thorsten Leemhuis wrote:
> On 05.04.24 08:26, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.8-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> TWIMC: there is nothing that needs to be done here, that patch is
> already in the 6.{1,6,7,8}-stable trees.
> 
> I had asked last week to pick it up early because it caused trouble for
> multiple people; but apparently the commit-id changed before it was
> mainlined, which I guess is among the reasons why this happened. Sorry
> for that.

Ah, I should have caught that, sorry for the noise.

greg k-h

