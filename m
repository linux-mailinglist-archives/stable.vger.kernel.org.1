Return-Path: <stable+bounces-114864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11815A30680
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 09:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A4E160A44
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A91F0E31;
	Tue, 11 Feb 2025 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sCa8z6Rb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F25A1F03C7;
	Tue, 11 Feb 2025 08:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739264227; cv=none; b=fwUk9jkXEcg8TirZ9IanHVvnjk4Xto2nX1ddWf1NMNMQpFTmsQymnjmPaiiDRDLJk/mjF3+bgmAlrvoCQbDWy90dcOYp8Slr3RcLv7B0DEkCWoUBlUVpnoc2WleLsE0osQUlhyWddipPcZFjFb7uF5T2bQpzGJlDXKhQ/R+iMrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739264227; c=relaxed/simple;
	bh=pBsTrBDHLigDR5M0gWdLfTzRx6yqQjxlGKMG6+7fJTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYIwL+cIZarcGxjXjQheBMnN1u5TH785PJhTIUtKqo6fMS4Ks0Dw8uK8i8DbH0pxL/UDxBUHVel3WTuVOXJLOZfAiaiNl17ZpjWNmpV0YV0I+JrY5AVRj4qm/A5HHsWczeIhBrH0yWggRxsg0mh3SSXHn+Fgelr4CFLnzrZ0lEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sCa8z6Rb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AA2C4CEDD;
	Tue, 11 Feb 2025 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739264226;
	bh=pBsTrBDHLigDR5M0gWdLfTzRx6yqQjxlGKMG6+7fJTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sCa8z6Rbl1uQpt0l0aO5GrAL6AwHj5Pyo2IfyZ1o8lBq5EicSEG+L+sLKieMhijVY
	 2RQcEKK2C0Cx0JV2tcNj2FwJM7pf1DnLWTadQxzr6hUgiTFsIug9r/+ViqBKszy+XH
	 QXkcrQCtW5m7PnOrccryR1QTBAKzwIpv7/c3B5m4=
Date: Tue, 11 Feb 2025 09:57:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Libo Chen <libo.chen@oracle.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"lwn@lwn.net" <lwn@lwn.net>, "jslaby@suse.cz" <jslaby@suse.cz>,
	Tejun Heo <htejun@meta.com>
Subject: Re: Linux 6.12.11
Message-ID: <2025021127-lapped-untwist-fef3@gregkh>
References: <2025012322-scuff-culminate-51b4@gregkh>
 <1E4095C7-59A5-4421-AD2E-6EFF28F8A850@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1E4095C7-59A5-4421-AD2E-6EFF28F8A850@oracle.com>

On Mon, Feb 10, 2025 at 07:43:03PM +0000, Libo Chen wrote:
> > On Jan 23, 2025, at 09:12, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > Ihor Solodrai (1):
> >      selftests/sched_ext: fix build after renames in sched_ext API
> 
> Hi Greg,
> 
> I think the commit "selftests/sched_ext: fix build after renames in sched_ext API” was wrongly pulled into the stable 6.12.y
> without the sched_ext API changes introduced by Tejun’s series: https://lore.kernel.org/all/20241110200308.103681-1-tj@kernel.org.
> As a result, the sched_ext selftests compilation fails starting from v6.12.11:
> 
> exit.bpf.c:36:2: error: call to undeclared function 'scx_bpf_dsq_insert'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    36 |         scx_bpf_dsq_insert(p, DSQ_ID, SCX_SLICE_DFL, enq_flags);
>       |         ^
> exit.bpf.c:44:2: error: call to undeclared function 'scx_bpf_dsq_move_to_local'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    44 |         scx_bpf_dsq_move_to_local(DSQ_ID);
>       |         ^
> 2 errors generated.
> ...

Thanks for catching this (nit, can you trim your reply, it's hard to
find it in a huge email like this.)

Can you send a revert to fix this up?

thanks,

greg k-h

