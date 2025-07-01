Return-Path: <stable+bounces-159147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A909AEFB2B
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 15:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6893F443FEF
	for <lists+stable@lfdr.de>; Tue,  1 Jul 2025 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827FA2459C7;
	Tue,  1 Jul 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZJ2fNRP8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C231E515
	for <stable@vger.kernel.org>; Tue,  1 Jul 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377879; cv=none; b=M9iO55LAAMlYLQPMDld7yGCfkRzM4EHf0TDFTRPY0Q/stdN/6mcQLE0KCH8Ucc4HgKizpc8/5D/q4pFrGm7Qhnze4uwJey0AB6FeyQC+n1qmdEMGi8i3gsoejxAPGauq2Ad1YxHZwMHokxVfkAwZdDVdQdKR87A9AAsjKnV1EH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377879; c=relaxed/simple;
	bh=omtabSV5lHsCaEz9RxZLPhMvbNaYGkd4Zy+eVSvjFg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2kCH2Ha+DPf1MTrsyUH3L5CYPOh6IIsAHgi8PPm6b/iMGYgs3TvOocQBGQQOgWUqhX6YJDDLYY5u+8P2UBmefp+WuU8/2BG8flPu7fLQXhkKv1vlW0i4dyClZnMksXnl0AfxH/+/N1xGLJv5a2iNHcb27RC1kBMTlNohdgRApQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZJ2fNRP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C22C4CEEB;
	Tue,  1 Jul 2025 13:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751377878;
	bh=omtabSV5lHsCaEz9RxZLPhMvbNaYGkd4Zy+eVSvjFg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZJ2fNRP80rgl+HvdYAnCi50RAJHb9+66bp2/rycEOoaXonbl04ScLJeciaFRcrt/3
	 w1dPhZFIICeVcYqDqpMDfvqWGXJeCXgqJSzDOPu/oiqXxCpn7ARPsulVF2G6bE+gqJ
	 XqNhw47+zn6rDE5PG7R5hjF0eMqaomvNaY3RHb4k=
Date: Tue, 1 Jul 2025 15:51:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yann Sionneau <yann.sionneau@vates.tech>
Cc: Li Zhong <floridsleeves@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	stable@vger.kernel.org
Subject: Re: Fix forgotten in stable backports?
Message-ID: <2025070107-shut-unbeaten-6789@gregkh>
References: <fb7b2cd7-02bf-439a-8310-f507a4598c28@vates.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb7b2cd7-02bf-439a-8310-f507a4598c28@vates.tech>

On Tue, Jul 01, 2025 at 01:44:22PM +0000, Yann Sionneau wrote:
> Hello Greg, all,
> 
> I am wondering if by accident this fix would have been forgotten while 
> backporting to stable branches: 2437513a814b3e93bd02879740a8a06e52e2cf7d ?
> 
> It has been backported in 6.0 and 6.1:
> 
> * https://lore.kernel.org/all/20221228144352.366979745@linuxfoundation.org/
> 
> * https://lore.kernel.org/all/20221228144356.096159479@linuxfoundation.org/
> 
> But not in 5.4, 5.10, 5.15
> 
> Even though, indeed, the patch would not apply as such, but it seems 
> trivial to adapt.

If it does not apply, then we require someone to backport it and send it
to us for inclusion after they have done so and tested it.

thanks,

greg k-h

