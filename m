Return-Path: <stable+bounces-23470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E444B861269
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 14:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8482B1F244AF
	for <lists+stable@lfdr.de>; Fri, 23 Feb 2024 13:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB67E777;
	Fri, 23 Feb 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TlnfRXcI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4A47E0E8;
	Fri, 23 Feb 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694119; cv=none; b=JpWwGSCM+JINTJ8JRnTFyXhd45jK+TXBENWoZ5RsmGMvkJAGnSE6CusbWKgvPZ+7cxgmMjDitGB0ulFiDdY9M8eTb1KkZNQhrRxVY88Xz20okuK8my5H7l9EEwRTZfFcYIBzQ8KC1CarjsFXMr3Dn7UIp8zpWIEIT2rpssNT50Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694119; c=relaxed/simple;
	bh=te2WRS4DLp2nwUKsghuHNrDiaDhYS7tnewrYBuUAcIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGfezPAp2pwxNql82VPTtlHhR06AvVyUuCEiggQbjMesiC9riSdK188TL/6oX5h+EvGk1P4CTOHzaiGmYUhNIXbb9yNMgBH77CVlpQ97X33bPSyFHkZWWsSSK6qauR26GstAtuGlgzKZOn1LdmLvwD15vXoF51rYOmVJh2ROlUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TlnfRXcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADA8C43390;
	Fri, 23 Feb 2024 13:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708694118;
	bh=te2WRS4DLp2nwUKsghuHNrDiaDhYS7tnewrYBuUAcIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlnfRXcIdY/JFjmeEU1UaPUzK5YBry/z266emM2ez4YgixaGkWXBBDY0jFL/qWpjG
	 zjdJCigoO1c4OHFibgk+Y52A6ClDRCQV0yMQHt0yO62egYMJgfzxiY49HkN9+ZOh16
	 A+Mx1j8GDGZT4H09/OWcXthqR/854xJzNu+U7DjA=
Date: Fri, 23 Feb 2024 14:15:16 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, joel@joelfernandes.org, chenzhongjin@huawei.com,
	rcu@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] linux-5.10/rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
Message-ID: <2024022359-busboy-empower-900c@gregkh>
References: <20240207110951.27831-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207110951.27831-1-qiang.zhang1211@gmail.com>

On Wed, Feb 07, 2024 at 07:09:51PM +0800, Zqiang wrote:
> From: Paul E. McKenney <paulmck@kernel.org>
> 
> commit bc31e6cb27a9334140ff2f0a209d59b08bc0bc8c upstream.

This is not a valid commit in Linus's tree :(

Also, what about 5.4?

thanks,

greg k-h

