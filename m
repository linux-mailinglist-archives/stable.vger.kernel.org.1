Return-Path: <stable+bounces-25775-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 808F386F18D
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 18:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43526280D2C
	for <lists+stable@lfdr.de>; Sat,  2 Mar 2024 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D79F2576E;
	Sat,  2 Mar 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2SKMTF/V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBAA1B298
	for <stable@vger.kernel.org>; Sat,  2 Mar 2024 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709399014; cv=none; b=kpVVuUjfYzq9rSO/QNMte210yk6ONTOZ4WUY+wAq6tEWjvt+1Wb9KuZEsjLvT/YKO74n/nt+L4Aj9o6nWyk7oksVnnuw4vDeAeyJAxqk03a7aUrF8xM6IYpyMIMq5M38nNMNocia8/gZKO8G+FPjTJQis89rpO9MNKjcBd8oSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709399014; c=relaxed/simple;
	bh=PAnj89f+8PdKa5RSI4KEbH4Ar/phx4dnFU+/C6iQrCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQIdfQFm9rbUNT7SJIqzwnM2PsJid5KT10whFm9hsRl7jeSGiz55kFRZ8O1fC8cCFwQUO4CQ8gdWvXBUhtTNLH0Qfh1uwiUL6caRImgiWPn2kESb6CIoGlFIjxefP8OED3BHD5KGV8uEoptcVJzz8at1I8KqW68hLsd6q2N5spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2SKMTF/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F14AC433C7;
	Sat,  2 Mar 2024 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709399013;
	bh=PAnj89f+8PdKa5RSI4KEbH4Ar/phx4dnFU+/C6iQrCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2SKMTF/VpCJC3x6mK/UN5N+sFl5SBYGURsarI83Nx4Y8/1YkGeVzPAma6jiA456eX
	 eTJSIjEH+GRDIIsH91Xzx784srBm0DV7+G2zDnH9/kBKsI0WMrPrrNXvUB/Z4qWdD3
	 1qpOwY6zklFHzJblGXsR8fm04gd09pA6W+xFGtjY=
Date: Sat, 2 Mar 2024 18:03:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rainer Fiebig <jrf@mailbox.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: 6.6.19 won't compile with " [*] Compile the kernel with warnings
 as errors"
Message-ID: <2024030214-scratch-compactly-638f@gregkh>
References: <339c80e4-66bc-818d-89c2-2e89cb41c4b7@mailbox.org>
 <20240301175621.GA2789855@dev-arch.thelio-3990X>
 <b0f08ff8-bddf-309d-4c30-1246e80f3f44@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b0f08ff8-bddf-309d-4c30-1246e80f3f44@mailbox.org>

On Sat, Mar 02, 2024 at 10:30:54AM +0100, Rainer Fiebig wrote:
> Am 01.03.24 um 18:56 schrieb Nathan Chancellor:
> > On Fri, Mar 01, 2024 at 03:42:17PM +0100, Rainer Fiebig wrote:
> >> fs/ntfs3/frecord.c: In Funktion »ni_read_frame«:
> >> fs/ntfs3/frecord.c:2460:16: Error: variable >>i_size<< is not used"
> >> [-Werror=unused-variable]
> >>  2460 |         loff_t i_size = i_size_read(&ni->vfs_inode);
> >>       |                ^~~~~~
> > 
> > This is a regression that was inherited from mainline because
> > commit 4fd6c08a16d7 ("fs/ntfs3: Use i_size_read and i_size_write") was
> > applied to stable without commit c8e314624a16 ("fs/ntfs3: fix build
> > without CONFIG_NTFS3_LZX_XPRESS").
> With  CONFIG_NTFS3_LZX_XPRESS=y  the build was fine.

Thanks for the report, will go do a new release with this fix in it.

greg k-h

