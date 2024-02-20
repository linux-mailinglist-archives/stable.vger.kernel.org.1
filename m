Return-Path: <stable+bounces-20833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277AB85BF25
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 15:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3DD1C22E54
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 14:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9FC6F51C;
	Tue, 20 Feb 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tW53ZpTl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A41E6F067
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440814; cv=none; b=MjjWE/yEze095M5zhz/Q5WAj9LuKPKk75O/PwA+pQugwbf/MS+NChXMLvvQD7HP02wM7ZW4hEfykHylIqHLi+kbIuepOGUgUOhKJQrRwch5TrtYWv41sI4Q2sBxVWsZ5UhmkoN7ihShjQOhm8HBPwEMWAVvf5KLkmVnm4AaliGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440814; c=relaxed/simple;
	bh=6kmK/QDLvPtajPatlt5EqbS/Ae1OQMmhZumdwomzmnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GAhQUT3rukbo5itnEgNdOXZxLh06wpL+R7LKFurR8C9DbnD7iGT+qSOfuv4rN7yfEqcniRL81RpxYvMNKrKiqbHZuWYT7riICfxpiK4aue2T7AgtfRl+cwnZHBUGYy0nu8yhmYX9k2SyKm2eETD3T7l8cKx9UpIZEo/Px9S34Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tW53ZpTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C8AC43399;
	Tue, 20 Feb 2024 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708440813;
	bh=6kmK/QDLvPtajPatlt5EqbS/Ae1OQMmhZumdwomzmnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tW53ZpTlTpwQ0VmFytSdwCMIyK8kKgIKgYJ1bp0lTZ3txqloBNk9QBJceTgiOmDcV
	 Ty2DL6unDEzNXmOQ4lnZLZ0kCaaVGN3I43rlTyR9RUz9FrVe/St2/VWAqiNK1YyCYa
	 LuPG2VVmMXEfVAoZUCpmYSUMDfre7o368KgG+fEM=
Date: Tue, 20 Feb 2024 15:53:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Helge Deller <deller@kernel.org>
Cc: deller@gmx.de, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] parisc: Fix random data corruption from
 exception handler" failed to apply to 6.6-stable tree
Message-ID: <2024022024-demeaning-italicize-ed01@gregkh>
References: <2024021939-unreached-bacon-95e0@gregkh>
 <ZdO9knwyE513vgYl@p100>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdO9knwyE513vgYl@p100>

On Mon, Feb 19, 2024 at 09:44:02PM +0100, Helge Deller wrote:
> * gregkh@linuxfoundation.org <gregkh@linuxfoundation.org>:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Greg, below is the patch adjusted for stable kernel 6.6.

Both now queued up, thanks!

greg k-h

