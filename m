Return-Path: <stable+bounces-93999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A15339D26D3
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 14:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5051B1F22D8D
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAE61CCB41;
	Tue, 19 Nov 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MCfA1irf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9661CC8AE
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732022908; cv=none; b=bLHANoGpbI7QjxCI8Pn+NFBe76++2rEWCOTwnDXK8avjyHbC0G81tS5nO6C/dXFivZBMJxS18b18WJCndiSv52nEDaK/aMvajAj0LFIien/0WSJD5f3A9PELGhXe56mWXwvMd8+i5TQI/NC/KYVhb5LtIM6lKkELBBKEX2VYGJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732022908; c=relaxed/simple;
	bh=viBHZY6PndLnOEsoBN3+z5LCu8zb7PQAg0Hsh7tA2ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sW9FUgjbP/qipJiU7DoHKyZlEzHM5VPQWStXU+yFWAEO08na6Ny1ERxJmK/xctLbtVNKAFBHVYiZQCIxq/WFKvmlec4PP5V+1eo1xHgU8dlixCfQeXG9ZlIiX/7I8Hi7dFAYUZPndBmK+89ctMdXGb1DrY+sQUwBz/lqUpMNbTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MCfA1irf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256A2C4CECF;
	Tue, 19 Nov 2024 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732022908;
	bh=viBHZY6PndLnOEsoBN3+z5LCu8zb7PQAg0Hsh7tA2ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MCfA1irfc9K6TvdRoVOHi8SUdVoDzvBs5HHxn7q3RKQDZ5WSGp812MJWvDJXoeiDl
	 OEUJ20874IPJXf0z5kESjUPRAth/pXq7s4zl86KYLCpXtPvdZQmaBlEErCaFYjnk0z
	 1FQ5MDJ7K2KoOetnUz6aVk/tTjwvEW2zjSeWSmzw=
Date: Tue, 19 Nov 2024 14:28:04 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, aha310510@gmail.com, chuck.lever@oracle.com,
	stable@vger.kernel.org, yuzhao@google.com
Subject: Re: FAILED: patch "[PATCH] mm: revert "mm: shmem: fix data-race in
 shmem_getattr()"" failed to apply to 5.15-stable tree
Message-ID: <2024111954-repulsive-kissing-add0@gregkh>
References: <2024111702-gonad-immobile-513e@gregkh>
 <c27966fa-007b-97dd-c39c-10412539e9d3@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c27966fa-007b-97dd-c39c-10412539e9d3@google.com>

On Sun, Nov 17, 2024 at 08:53:17PM -0800, Hugh Dickins wrote:
> On Sun, 17 Nov 2024, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x d1aa0c04294e29883d65eac6c2f72fe95cc7c049
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111702-gonad-immobile-513e@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..
> 
> For 5.15 please use this replacement patch:

Now queued up, thanks.

greg k-h

