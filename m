Return-Path: <stable+bounces-58253-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EE992AAA3
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 22:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E4D8B218C2
	for <lists+stable@lfdr.de>; Mon,  8 Jul 2024 20:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD6114D717;
	Mon,  8 Jul 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6llRMhU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2900A29;
	Mon,  8 Jul 2024 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720470754; cv=none; b=eWz1u0KR3HRb2HQDtLWkHRhWOWoxDRSBDq9HxnVcvp6odTS2BSw00Cr5hrdXPoAgEMgae+x0HxhdpyJpXmdUqTCtxBDh1LDi3AB+FEoy3u3P5Px/sgy8nw753pVmwGqjKv+iInl4kE9fx4zhvgssOOmq9qdYelSYhIstolKtqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720470754; c=relaxed/simple;
	bh=uFwukNnK2jqoknq4ATZonWIBp7WJXBvW0eK/AgTdmb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLVbT8i8CEteN0zJIuI1o/hsBtAG+rBzbSg0EPSx8WUGIXBawL2gIXPz4diC0My25BddqHJMpsqvHzo90E/So8nV7alt6Cv/aPzqVRi2eql5G8G9TbQW2BjQMpEX+989+T+jfSPfsdwO9sD7emYp0x3l2CsQ5gFYkakX+5V5RKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6llRMhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D44C116B1;
	Mon,  8 Jul 2024 20:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720470754;
	bh=uFwukNnK2jqoknq4ATZonWIBp7WJXBvW0eK/AgTdmb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X6llRMhUKp1Ux75UbOYvGX/omU5506ePF4g1DZRithEnyhtQ3Kl2D9dLL/B7j4unA
	 QHAdPJ29oeK8MA8EG0bbrWb0c9XyNGH775ybD1/9dDdVQsIFiRxmZ4r21+Xu1Q2SOf
	 7QgolDIlbJlkGSc0hpRyF7Ii95JHReZhB9ffR2eIhtGpHxxEFjZ92PMlA6y58kyme0
	 RghvtIuuKmXdfVQicYNZaZ1Ver2Ny07qB5WFbrHCt4xA0DbwnqlkzxAr/iWN5Nly9V
	 1RDlYaBjQG2jqNrjpkgWPWkbWY1huXTueDJNdWUlabyMyv2A1+dmkQOH7z5/I40KbY
	 wTEK6Qo2b/ulQ==
Date: Mon, 8 Jul 2024 13:32:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/4] ipv4: fix source address selection with
 route leak
Message-ID: <20240708133233.732e2f0c@kernel.org>
In-Reply-To: <cc29ed8c-f0b2-4e6d-8347-21bb13d0bbbc@6wind.com>
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
	<20240705145302.1717632-2-nicolas.dichtel@6wind.com>
	<339873c4-1c6c-4d9c-873c-75a007d4b162@kernel.org>
	<cc29ed8c-f0b2-4e6d-8347-21bb13d0bbbc@6wind.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jul 2024 20:13:56 +0200 Nicolas Dichtel wrote:
> > long line length. separate setting the value:
> > 
> > 		struct net_device *l3mdev;
> > 
> > 		l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);  
> The checkpatch limit is 100-column.
> If the 80-column limit needs to be enforced in net/, maybe a special case should
> be added in checkpatch.

That'd be great. I'm pretty unsuccessful to at getting my patches
accepted to checkpatch and get_maintainers so I gave up.
But I never tried with the line length limit.

