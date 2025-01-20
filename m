Return-Path: <stable+bounces-109555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C0FA16F02
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 16:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3D03A64B9
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA91E501C;
	Mon, 20 Jan 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ax5zvqfr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839261B4F02
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737385751; cv=none; b=gp41qY0mnzEq8VfExxxJNZrYM+CM4UDLf1UgtezXGRpzaFBaV7IAfGK4U1jDPEY+WMWMQ1731ruQRy4AnrVEalD9XjZkFepAeRjLEgYOinEiCrJB2bqOXuRm69rX7o8fEe9WonxN1H0OxKVQmvw1MwN92yeFb3r79VqCNKuyMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737385751; c=relaxed/simple;
	bh=WlbO07wDAMSgDw67K4vHb8D2p7wR+wqcMgN8zND1d0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bxnk7enPymNQ3ZP8LwU/uS50hTWjLSUaqgUB26bLIEhBMwzaJoWW5q/g0vbQqlMtYCuYEaHUrwFRMRT4ny0j6B9LfRrf/WkPoyzgMQr4Je3TBB3wv4Dxu3LvURhi09ngcptZMj2TDw8zAUpJlBVCAf9aHj7fxBRdAKc0+OcSrFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ax5zvqfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A133C4CEDD;
	Mon, 20 Jan 2025 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737385751;
	bh=WlbO07wDAMSgDw67K4vHb8D2p7wR+wqcMgN8zND1d0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ax5zvqfrOT8YsNRePQjAR/o/PqyUs2/H4jm29boc5QMVQLAEqowtyxlD+uE67fNpV
	 erSA6vwOWvwiFTatz3x8IV7/J/8zkwHyb14jBilc9pzxQOyGwGpnAVTTIJ2JgXB/cX
	 LCRO6WE7xC6TS7x+RODuqBlxWLXvvUC/DCCmW+Nc=
Date: Mon, 20 Jan 2025 16:09:00 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: INV Git Commit <INV.git-commit@tdk.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 6.6.y] iio: imu: inv_icm42600: fix spi burst write not
 supported
Message-ID: <2025012046-dazzling-foil-b3f1@gregkh>
References: <2025011346-empty-yoyo-e301@gregkh>
 <20250113124638.252974-1-inv.git-commit@tdk.com>
 <2025011500-unmixable-duplex-9261@gregkh>
 <FR3P281MB175777574467C382B07AAAF3CE192@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
 <2025011515-perfume-bless-e2bb@gregkh>
 <FR3P281MB175713D9EC9CD1A135227620CE192@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR3P281MB175713D9EC9CD1A135227620CE192@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>

On Wed, Jan 15, 2025 at 02:02:45PM +0000, Jean-Baptiste Maneyrol wrote:
> Hello,
> 
> strange, I've sent it.
> 
> Here is a link to the mail in the mailing list archives:
> https://lore.kernel.org/stable/20250113135307.442870-1-inv.git-commit@tdk.com/T/#u

Ah, my fault, too many different threads for this subject.  What a
mess...


