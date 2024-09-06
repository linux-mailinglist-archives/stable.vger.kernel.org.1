Return-Path: <stable+bounces-73770-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7A196F175
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 12:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4ED028E7E5
	for <lists+stable@lfdr.de>; Fri,  6 Sep 2024 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3620215852E;
	Fri,  6 Sep 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AlHG3d3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AAA1459FA
	for <stable@vger.kernel.org>; Fri,  6 Sep 2024 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618491; cv=none; b=tQi7mTqJnldEplHZtknHwp+l4c+fb7pphUvqGhZs3guYatsXdGlSk2pBvX9G0xpbwJu2yQXioVMMsveUyEw8mguFibwfDZLJxexhtj7JkRWHrYsEgjSCJZo80IfKPfbhU16bvzD2mkbV7tyAxIWrZMjXf+mymXLrSGU7uYWTgp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618491; c=relaxed/simple;
	bh=rlF32XDlvyxZQHTdwLpfyb+9LDpVB1p2h7qu3WmWwoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A79D0jsjuVBVf9XTpvnhkYGTfwdV8fRBKjWAgGNoBCDeMT9zqsOmUalMUUi9JbVIH3JGkf4baJi8CybNeTC7mMCQ8UOqvARXoPfTn5CbDzonsToTb8i/+Ir43LgZYHIbJPoDfNH6QpuMO0iG3UOeITheRRXCx9PhQvF5PEni9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AlHG3d3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B41C4CEC4;
	Fri,  6 Sep 2024 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725618490;
	bh=rlF32XDlvyxZQHTdwLpfyb+9LDpVB1p2h7qu3WmWwoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AlHG3d3WbGlP9UpVFDAxcy+HZIeQ8/mWbgphCIkfviAgXy67CkPLwHODDB2RaWs+j
	 h7RsUqmc80iqDErpsVeW3SF+/YxJmS0UoIBn0zwjiFfSBDgCvBTw0b0zE9S9KqNwsx
	 Oph7V4wQ3/ErDuBjiNuMcMpAmdpDoIgqjwvIClxY=
Date: Fri, 6 Sep 2024 12:28:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: meetakshisetiyaoss@gmail.com
Cc: stable@vger.kernel.org, smfrench@gmail.com, nspmangalore@gmail.com,
	bharathsm.hsk@gmail.com, lsahlber@redhat.com,
	Bharath SM <bharathsm@microsoft.com>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>
Subject: Re: [5.15 Backport] cifs: Check the lease context if we actually got
 a lease
Message-ID: <2024090630-crushing-eskimo-af87@gregkh>
References: <20240906102040.28993-1-meetakshisetiyaoss@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906102040.28993-1-meetakshisetiyaoss@gmail.com>

On Fri, Sep 06, 2024 at 06:20:18AM -0400, meetakshisetiyaoss@gmail.com wrote:
> This patch fixes a directory lease bug on the smb client and
> prevents it from incorrectly caching the directories if the
> server returns an invalid lease state. The patch is in
> 6.3 kernel, requesting backport to stable 5.15.
> I have cherry-picked the patch for 5.15 kernel below
> 
> >From 2bb51b129ceb884145c3527f8c04817cc00d0e6e Mon Sep 17 00:00:00 2001

What is the real git commit id of this change?

And what about 6.1.y?  You can't skip that or you would have a
regression when you upgrade as you shouldn't be using 5.15.y for much
longer, right?  :)

thanks,

greg k-h

