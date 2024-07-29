Return-Path: <stable+bounces-62361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0267F93ED58
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 08:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3116F1C21912
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87DE83CD2;
	Mon, 29 Jul 2024 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eua+NDd7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72A824BF;
	Mon, 29 Jul 2024 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722234268; cv=none; b=b/KshAim3tcKG95lc1o3omQ95Abxe47pL1XzEcQOyCK9PWUnrkvoMYidkHXHyngXuaamrR/uqYIxE1vW1X4bSfo1lw0W0MyaI3P2VpjJsI4NeF4q8wTx6HaPSWUvsZsfKYqozlso7hydQANwjNQKB/p5dDbP88fkhy7TnJFwXno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722234268; c=relaxed/simple;
	bh=EIwkIWaClibDJBez3ZW3LL99g7TnNUMV5dK8u3fE5+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klSCmOHpcV9BO9MhMHCM1hRUqz2jtY2B37fkRTRsINQCuGfZ87DlOSvGe+NlQFrZhodx1cJX1GiOYpGLtOxzp58GdDGs2DU2+Fyg3RtYBEYRxjiqxbqfAhuB/PHpHq6CVvd0t/eRcr5++GWbGUy3TfMIk29US1FD/tQ441M9rkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eua+NDd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C14C32786;
	Mon, 29 Jul 2024 06:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722234268;
	bh=EIwkIWaClibDJBez3ZW3LL99g7TnNUMV5dK8u3fE5+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Eua+NDd7HkSfIa8STxZuzbE2UnjeUR5Qwd3uEt14J+2MXDY7YVwc3ezWpnOkeL8jj
	 14q0ajITiwmkyI5UkeodV5qe3ezXt4qR7bTWRbGY7lFdVH7UgYgJunmNwYKhc64bqG
	 SckyAdqpzOYcHl3vzIyIO90g+3JrUT5Std3ZMVN4=
Date: Mon, 29 Jul 2024 08:24:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, jslaby@suse.cz
Subject: Re: Linux 6.9.12
Message-ID: <2024072948-glimmer-glitch-6a95@gregkh>
References: <2024072750-gummy-bobbed-8af6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024072750-gummy-bobbed-8af6@gregkh>

On Sat, Jul 27, 2024 at 11:42:50AM +0200, Greg Kroah-Hartman wrote:
> I'm announcing the release of the 6.9.12 kernel.
> 
> All users of the 6.9 kernel series must upgrade.
> 
> The updated 6.9.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.9.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


I forgot to mention that this is the last 6.9.y release to happen.  This
branch is now end-of-life and everyone should move to the 6.10.y branch
now.

thanks,

greg k-h

