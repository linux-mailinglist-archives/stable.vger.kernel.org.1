Return-Path: <stable+bounces-59410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73075932725
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F3D28060F
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 13:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C419ADBE;
	Tue, 16 Jul 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xyTLKZNY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E175019ADB9
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721135432; cv=none; b=sZxNNpA/KWtv2pFkJXyoiybG3AGAuJHXUylxtOk/v0KWNhEaOAkqux5hjUbM9ZASdC9vIQqPpXCMgh/cgUh8vWZP7eCWg4UgWFPWhHdo+ycpAugfAn5KBZGfO6ex+uCibYT+G4QtNwJaQVp8ZO4BVWIHL7YFJVjIFzZXFv+mMX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721135432; c=relaxed/simple;
	bh=bnmNoa4RAH8hgfPlKBVAsMzCphGbOcTm2aMbmh05Wq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edKnvb8nv/tg+LUj2hQcpv+ZJvwuNVyfn7MrMhvllnqIPVhaJiFfjguGh7fyxGIWHjQ5mKcXVYxr5GH0H76hqTbpefbwA7XbbZx1ApyED3284Qu1SIVTiDg8yAMEcEbdTcsuQ9ilzTdBiZxxvvq8bjxOmGOgCCoa39Jh0CYIfmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xyTLKZNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7D0C4AF0E;
	Tue, 16 Jul 2024 13:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721135431;
	bh=bnmNoa4RAH8hgfPlKBVAsMzCphGbOcTm2aMbmh05Wq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xyTLKZNYRoHq9LkeaEWgeB/v3V26sNpyoVFkbnYAH2gObKFEaxOO55E6hsDeOmKWK
	 AtfCQZHlimPYazWQBJ3+p8WyvIrBUxdjI3aTcedk8d/DFlNYqrrQU+IWpbjUpezUOA
	 A5OSfr58fcvJj9i2Vk7KRlX3ivcHSjkpGxxKZbmA=
Date: Tue, 16 Jul 2024 15:10:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: stable@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6] nilfs2: fix kernel bug on
 rename operation of broken directory
Message-ID: <2024071618-compacted-gigantic-4694@gregkh>
References: <20240715162711.6850-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715162711.6850-1-konishi.ryusuke@gmail.com>

On Tue, Jul 16, 2024 at 01:27:11AM +0900, Ryusuke Konishi wrote:
> commit a9e1ddc09ca55746079cc479aa3eb6411f0d99d4 upstream.
> 
> Syzbot reported that in rename directory operation on broken directory on
> nilfs2, __block_write_begin_int() called to prepare block write may fail
> BUG_ON check for access exceeding the folio/page size.
> 
> This is because nilfs_dotdot(), which gets parent directory reference
> entry ("..") of the directory to be moved or renamed, does not check
> consistency enough, and may return location exceeding folio/page size for
> broken directories.
> 
> Fix this issue by checking required directory entries ("." and "..") in
> the first chunk of the directory in nilfs_dotdot().
> 
> Link: https://lkml.kernel.org/r/20240628165107.9006-1-konishi.ryusuke@gmail.com
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Reported-by: syzbot+d3abed1ad3d367fa2627@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d3abed1ad3d367fa2627
> Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
> Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> Please apply this patch to the stable trees indicated by the subject
> prefix instead of the patch that failed.
> 
> This patch is tailored to take page/folio conversion into account and
> can be applied to these stable trees.
> 
> Also, all the builds and tests I did on each stable tree passed.

Now queued up, thanks!

greg k-h

