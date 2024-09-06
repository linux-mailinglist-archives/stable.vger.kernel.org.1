Return-Path: <stable+bounces-73756-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA7096EF66
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 11:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA6331C23A17
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 09:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F325C1C86EE;
	Fri,  6 Sep 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="InjV6blG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258341A8F
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725615408; cv=none; b=NIR1c/miTvImRaPBT6KWfiJd1fdowD89xxmRCPYbqHeV+9rR+XAb8VWiUbVPG12GLAwMCB8iDad34D8u9m7JTFYvimw2ydKS0qdD3vVbjGipjo2W9ejUxb7JFMH/uSJwGdeXXouv9c/iXhzZro5dAm95+S0XHvlb3RbTgsn5Srw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725615408; c=relaxed/simple;
	bh=XLHVl2vpldmTnVcV6tFsEfAfpWj3agCVXOmRm5RJ2pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjQ0KuOPJmB6KO7EWKFKraQYxk19uVVGAGcizsuwRiTzjDajcdxVa7hX3t4OdHdg13QlFiy5CuJ5ySxR8iHL9yloc3+TRXcFO8B+Kh9N8Er56KUF089wMmrbcZEhPn01XbOOO67yg7GZM7KX6u8+FPTB6PK7LPvq56rjMduBePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=InjV6blG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC36C4CEC4;
	Fri,  6 Sep 2024 09:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725615408;
	bh=XLHVl2vpldmTnVcV6tFsEfAfpWj3agCVXOmRm5RJ2pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=InjV6blG7jGNmA/cx4l/rWxaBVkJ9RN+bqoiaYv4Gbd5xZ501lh2fNxRzIf7RXv76
	 ExdLJSojJPXkMaQkZiSAikcekTAX+8rQBW+diRGHVBAvxVF6FQtCfNKVmy/5RBq5E0
	 PXx4swVewhypLHn3025xHN0kiAX9iEiwW5Lixi/8=
Date: Fri, 6 Sep 2024 11:36:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mptcp: pm: reuse ID 0 after delete and
 re-add" failed to apply to 6.12-stable tree
Message-ID: <2024090633-exact-vitamins-5cb3@gregkh>
References: <2024083041-irate-headless-590c@gregkh>
 <775029c6-ddeb-4a87-bd2c-69bb45a1e1c0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <775029c6-ddeb-4a87-bd2c-69bb45a1e1c0@kernel.org>

On Fri, Sep 06, 2024 at 11:20:31AM +0200, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 30/08/2024 12:21, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> 
> v6.12? Are you back from the future? :)

Hah, you noticed this, sorry.  Slip of the finger :)

