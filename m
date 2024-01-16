Return-Path: <stable+bounces-11341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FE282F057
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 15:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAF18B21AD0
	for <lists+stable@lfdr.de>; Tue, 16 Jan 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648AE1BDE0;
	Tue, 16 Jan 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NTSdV00k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1325C1BDCA
	for <stable@vger.kernel.org>; Tue, 16 Jan 2024 14:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BB0C433F1;
	Tue, 16 Jan 2024 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705414391;
	bh=dMCU6fAjjIBzndeJX+j1oJtgqwqmoJr5J2cyrfAGzEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTSdV00kZGsy6Q5Ktz1rEYq5npcx9h0LCwzyTJUICmptxMPUv40tSKYWGzyx6lGJn
	 mBsegRygckmIbnvzmF+hyFLvEZpea8szak1oJsUVSIs8nWouhewTWnDan2yCbrwgUu
	 MXPoiKHCx5PYWlraF4kaqqXS+F1djGHIHyTW5XaQ=
Date: Tue, 16 Jan 2024 15:13:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: stable@vger.kernel.org
Subject: Re: fs/bcachefs/
Message-ID: <2024011614-modify-primer-65dd@gregkh>
References: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <g6el7eghhdk2v5osukhobvi4pige5bsfu5koqtmoyeknat36t7@irmmk7zo7edh>

On Mon, Jan 15, 2024 at 05:12:17PM -0500, Kent Overstreet wrote:
> Hi stable team - please don't take patches for fs/bcachefs/ except from
> myself; I'll be doing backports and sending pull requests after stuff
> has been tested by my CI.

Now done:
	https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=9bf1f8f1ca9ae53cf3bc8781e4efdb6ebaee70db

We will ignore it for any "Fixes:" tags, or AUTOSEL, but if you
explicitly add a "cc: stable@" in the signed-off-by area, we will pick
that up.

> Thanks, and let me know if there's any other workflow things I should
> know about

This is going to cause you more work, but less for us, so thanks!

greg k-h

