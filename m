Return-Path: <stable+bounces-60384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D06933706
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 08:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14881C21118
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 06:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B1612E48;
	Wed, 17 Jul 2024 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ojmh0SEl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C62FB6;
	Wed, 17 Jul 2024 06:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721197683; cv=none; b=JxyZwEilVlg2uV5ooPFvWFsh+l7SJXfKoGvEzXg18IQz6CKSL5Mk/ukQfDKJ1BCMwNWKdzfo1oYU/F03uuGb5riYJuuDVnBk6U38k0KoJWBnCDWZPgCUCcsZftOmG1D2adzxxO3bVt2zNM81cHy1kS/SsuakBsEWcY31G/ZcSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721197683; c=relaxed/simple;
	bh=xJ21wQWNJH7fSPcxod4y8wsO74LO52sKPxPx7F7b6KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpacfEKHAfIJ4UsafM9bvRkKHWdKIP36sveStEZRcBQx7ObxrAY317im2ILaDSqQYx37emtB1EyGKBfOgKsqz6waALa6B2WhbKiqfpGrLI9XuG1owDZb0nWo3i/JyaJjj+zH8Iz9fJP1va0nHlZWhaJrtPV4oWG+0nndOa2A1Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ojmh0SEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C014C4AF09;
	Wed, 17 Jul 2024 06:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721197683;
	bh=xJ21wQWNJH7fSPcxod4y8wsO74LO52sKPxPx7F7b6KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ojmh0SElU8RLCci2Vxyubc/skECu+A/ee3wy/259j/clfIXeK1VP3GwkpCWijBnZ7
	 8Y8nw1dUFHpmd85PENdclQtzdvbIPu5AYT1ABOih2cibyrTTYhwqfwWaj4BhQADEcp
	 xr/PaX3F2ouDj66ldIZbFMsEDqpaRqFCBdVENbM8=
Date: Wed, 17 Jul 2024 08:28:00 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Damien Le Moal <dlemoal@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 6.9 093/143] scsi: sd: Do not repeat the starting disk
 message
Message-ID: <2024071753-reversal-squabble-7e82@gregkh>
References: <20240716152755.980289992@linuxfoundation.org>
 <20240716152759.554308808@linuxfoundation.org>
 <3908f81b-0500-44fa-907a-111efeefcdc0@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3908f81b-0500-44fa-907a-111efeefcdc0@acm.org>

On Tue, Jul 16, 2024 at 12:55:32PM -0700, Bart Van Assche wrote:
> On 7/16/24 8:31 AM, Greg Kroah-Hartman wrote:
> > 6.9-stable review patch.  If anyone has any objections, please let me know.
> 
> Please wait with applying this patch until this conversation has
> concluded: [PATCH] Revert "scsi: sd: Do not repeat the starting disk
> message" (https://lore.kernel.org/linux-scsi/20240716161101.30692-1-johan+linaro@kernel.org/T/#u).

Now deleted, thanks.

greg k-h

