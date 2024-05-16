Return-Path: <stable+bounces-45269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098B58C7515
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 13:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B14A1C21889
	for <lists+stable@lfdr.de>; Thu, 16 May 2024 11:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3343A1459E3;
	Thu, 16 May 2024 11:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h6gbd+L5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFBF14535E;
	Thu, 16 May 2024 11:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715858364; cv=none; b=DyA8MoxYR4X1zyjTZBhIDnRDVvkIzUWjV0AXAyJ6VslLqbDXTwPp55a3fqWokx+lar+y1yYA1TaXZLRFIV3q+5oX8+drG7DXwpjjXXKXAdK4NEWgpLhQW8Vv5M5ZH5h5KONl8VVmvbhO4tFLztOz0c5P8Za8bUpOkAkBQHzBbUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715858364; c=relaxed/simple;
	bh=/xZgGEjWlvf2pVl8CGoMoJWHwKg+P2Qx8xXvpSNoZm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCCMbeu0gTnOlqT0TXYoLF3SLbPz/D7KiMvx+CPvbweccuJgepvmeqacCyraLRm8R0Jun15SZXR1nZDB9J0/gxy82jyJzIes+pK1Ok6chGPOEBwGVrqeLZMLAi1hkZ974NCLDch7lPwsJWelm8qvulitopkKXQapZqCjLJtW+Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h6gbd+L5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CC7C113CC;
	Thu, 16 May 2024 11:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715858363;
	bh=/xZgGEjWlvf2pVl8CGoMoJWHwKg+P2Qx8xXvpSNoZm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6gbd+L5D1ATDcywzm8Uy0tn29T/3gO0CGVEkbgUf9e5C+0Bfra9XB0ise7YYhhnm
	 ZB8j3jcn2XMEdn7P8EJqIF2DUE06X8d1afccqOnsIblqRSkDbKaUDYHlV1TrmtA1ZX
	 CEej+YdAJRYd7xaEv7Y2h518K59SaPFEQdpOKvPE=
Date: Thu, 16 May 2024 13:19:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Sergeev <alexander.sergeev@onmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Rtnetlink GETADDR request for 1 specific interface only (by ID)
Message-ID: <2024051638-chase-viral-0653@gregkh>
References: <ac768f81f5218be629864b850bb7b959-1715851155@onmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac768f81f5218be629864b850bb7b959-1715851155@onmail.com>

On Thu, May 16, 2024 at 02:19:15AM -0700, Alexander Sergeev wrote:
> Good morning!
> 
> Recently, I have found an issue with `rtnetlink` library that seems to
> be not intended and/or documented. I have asked about it several
> times, including here and it was also reported here. Neither in
> related RFC document nor in rtnetlink manuals the issue is described
> or mentioned.

Great, then why not notify the developers involved in netlink?  That's
not the stable and regressions list, sorry, as this is not a regression.

best of luck!

greg k-h

