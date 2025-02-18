Return-Path: <stable+bounces-116765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57878A39CE4
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 14:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB8A18975D7
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 13:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724EC26B2B2;
	Tue, 18 Feb 2025 13:02:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9CC26A1D4
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739883763; cv=none; b=oyrKzWoKkDikuD72s3aCT3QUaCDw8s23uNg/Z69ghSelOQD16KWASU7GD7I9udpy4R17ZdlDIYNnfnCEcW1AWY7uLYJwYGE6wd9mg2SJGDv6qSfVEvNrTAy5g4NWF984Qmn6EgcnW8tYnvtg1QjTSkTHs9pcFpnJHyXA/qqLJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739883763; c=relaxed/simple;
	bh=cSVBEe81sQLfZxSJRUx7ugCLph/sHRkpRqnByn7SciU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFfVp16LipxJ8mAfVJTGOdBdqO+V23nZLcYDGQWQwJR61B4oRKrKgRdjXlczxqWzTEFxy1DINh5wJYJUmyYrpPeyEAaPrg+ze59gVuWOqBJkD7YG96d+M5j5+hwfNsNSFbr5MoUlCxTJkPWIIquJPn2uql4cMKQvl+UgG0BtK/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 1C0A472C8F5;
	Tue, 18 Feb 2025 16:02:34 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 0BD447CCB3A; Tue, 18 Feb 2025 15:02:33 +0200 (IST)
Date: Tue, 18 Feb 2025 15:02:33 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: stable@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: Patch "MIPS: fix mips_get_syscall_arg() for o32" has been added
 to the 5.4-stable tree
Message-ID: <20250218130233.GD31360@strace.io>
References: <20250218124834.3277340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218124834.3277340-1-sashal@kernel.org>

On Tue, Feb 18, 2025 at 07:48:33AM -0500, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     MIPS: fix mips_get_syscall_arg() for o32
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      mips-fix-mips_get_syscall_arg-for-o32.patch
> and it can be found in the queue-5.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit de89111213a3fb4751245214dc4dd590ed153d29
> Author: Dmitry V. Levin <ldv@strace.io>
> Date:   Wed Feb 12 01:02:09 2025 +0200
> 
>     MIPS: fix mips_get_syscall_arg() for o32
>     
>     [ Upstream commit 733a90561ad0a4a74035d2d627098da85d43b592 ]

Just in case, the previous commit,
ed975485a13d1f6080218aa71c29425ba2dfb332, has to be applied
along with this one, otherwise the change will not compile.


-- 
ldv

