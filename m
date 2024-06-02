Return-Path: <stable+bounces-47832-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CCF8D7414
	for <lists+stable@lfdr.de>; Sun,  2 Jun 2024 09:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC521F215A8
	for <lists+stable@lfdr.de>; Sun,  2 Jun 2024 07:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F1018EB1;
	Sun,  2 Jun 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WgNINnze"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592CF14F6C
	for <stable@vger.kernel.org>; Sun,  2 Jun 2024 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717312562; cv=none; b=ip9iklaaVOw+cGXJ5GigjNAcVrHKkJP+5GbhbNuvmZ6daeosfDOr0wdfytkno/8osJrE+1klJXLiZlN6TcVQYq+LgEL/fXqVaXrVfUIAxqWTbT8SlFZQ+PE9tUYqZkelgENjgZK+Aw4YBt8Ort4FDoRtZuMqPVSM71URgid1P+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717312562; c=relaxed/simple;
	bh=iey6MB70LwTxGe/1OuIDnAC9v618Rcx26lOkOHQRBf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsCuVJ8GGTNS7HOx5nKxA4cYJvnLguSHpHor6zBRxgER2wJGhcAj0skC9RjZy593A2Klk+A3owTETxZJboKEf8o92L46+Av0vf53MuYGFI7SdoxgJFHQiDrSYg18cmUTakzJ3NXAbK4WBg7O+nnAVewb3MXh0UdsLlHZu83D6Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WgNINnze; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D985C2BBFC;
	Sun,  2 Jun 2024 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717312561;
	bh=iey6MB70LwTxGe/1OuIDnAC9v618Rcx26lOkOHQRBf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WgNINnzeX7W6TQ+9UE8hg/PKTMu9vkN0h6Bx+seUNS3JIQPrCFmO9iZmPHHab6I6n
	 OdOeHRhoyH58Ll75M6xUAUQ+y5ARNTk0dqcSIOnJdazbMdt7TczEpt1t/jbk2mEGbG
	 avCadx3OQTPxT1mH2UyD6eSfUIF0SFSLy8vqblUY=
Date: Sun, 2 Jun 2024 09:16:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Massimo Di Carlo <massdicarlo74@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: Maybe a security bug
Message-ID: <2024060236-compound-pointless-6db6@gregkh>
References: <2324886.ElGaqSPkdT@max-desktop2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2324886.ElGaqSPkdT@max-desktop2>

On Sat, Jun 01, 2024 at 05:32:01PM +0200, Massimo Di Carlo wrote:
> Hi, I hope this is the right place
> 
> I think I found a security bug.
> I have a faulty hard disk and sometimes the system doesn't boot
> but a root console appears.
> it's already the second time and I didn't think to take a photo.
> 
> I'm not talking about the control D or Root password screen!
> 
> A root console appears directly.
> 
> kernel 6.8.11-1 manjaro 64 bit

You might want to ask in this distros user support forums for help with
this as it sounds just like a normal "can not mount the filesystems"
issue.

good luck!

greg k-h

