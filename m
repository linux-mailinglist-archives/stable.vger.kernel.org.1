Return-Path: <stable+bounces-61434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9DE93C3FC
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9B481F214AC
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111DC19D064;
	Thu, 25 Jul 2024 14:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jmp0mqo8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E253FB3B
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917308; cv=none; b=Kj3urBYr0WG3SvumJEFS8QJXo2q418obIVA1TvUpY4KJciZcaIDdE1UeFptOBuBSPyLqmK+PfU+G5QE8L3kwrBKfobCygNMiOb9Lchq1OCD3rt9sOvaQXpT71eHmZu69OUCmpvFFntoYkNgPujlZSayE31cOaDdwnlI/aCiyiJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917308; c=relaxed/simple;
	bh=ZltkhJ6+a/lpCOzk3f/1/2Ffa9BzRcQT2wokwXVtug0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP8fUjgQqEIhUvBRQ0D4ySbocL/jp/eKb2RypJWtBKUtpI+VVjzNPuI1YFStQce0HVSeMirW+YLukTktLHs+bKC7wnDAl1TBWAdGdLjFKGu62F7IgbaE4URhDRqIXcRPbOsnRxrtHybM6YT0JFySlVMoGzRVWQtRoYSPYEglWxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jmp0mqo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7DBC116B1;
	Thu, 25 Jul 2024 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721917308;
	bh=ZltkhJ6+a/lpCOzk3f/1/2Ffa9BzRcQT2wokwXVtug0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jmp0mqo87s2Ah7pv9CE370F091ntWx1kp3TS1JtJYxfUzerZ09K3/O7IwabK0101m
	 +zN2OwC7Lr1MDgXWVLUuhtOmAYij9qOVGc4/eW5MA+AhizwD3x6biqeLbDtn/8tFMU
	 j2nZZDscmQ3ydotSh8X5mUAvnRyj5jVNqL7hrOJQ=
Date: Thu, 25 Jul 2024 16:21:45 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>
Cc: stable@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
	Jan Kara <jack@suse.cz>,
	syzbot+600a32676df180ebc4af@syzkaller.appspotmail.com
Subject: Re: [PATCH 6.1.y] udf: Convert udf_mkdir() to new directory
 iteration code
Message-ID: <2024072521-ducky-record-3b13@gregkh>
References: <20240725135313.155137-1-sergio.collado@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725135313.155137-1-sergio.collado@gmail.com>

On Thu, Jul 25, 2024 at 03:53:13PM +0200, Sergio González Collado wrote:
> From: Jan Kara <jack@suse.cz>
> 
> [ Upstream commit 00bce6f792caccefa73daeaf9bde82d24d50037f ]
> 
> Convert udf_mkdir() to new directory iteration code.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> (cherry picked from commit 00bce6f792caccefa73daeaf9bde82d24d50037f)
> Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>

You changed things in this commit and didn't say what or why you did so
:(


