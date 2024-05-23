Return-Path: <stable+bounces-45660-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D488CD18C
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 13:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89D51C21AF4
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 11:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A28E13BAFA;
	Thu, 23 May 2024 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBz12nTi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDEE13B5BB
	for <stable@vger.kernel.org>; Thu, 23 May 2024 11:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716465135; cv=none; b=a6lVwuAQL09Xm8xMvGgwBsXZ0mwZOUeeAJQSMcJuQSsD6Bkt+ILvORk63vt6vDIQxdxjinygdf1AgHgYlWjmFC6DZKdhCWvlEgrRUvjuJ39A4d7Dm3bFJs+HTOvtn/yrqUW7cpm8Qc87OafTBqNZhPGxcrNV0WcixsVx3QFQn1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716465135; c=relaxed/simple;
	bh=rlvbPKYJSeOouX0LacRAKV5teQ0Mud1QsMHMHqAA6Rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G46genBbZcV9X/oMpVBu/rYM9bOK9CnE0IuyaPWgI35D/nJwEuGGYztUSg8VcDLfVdYDla9gG+XT1i3cHTvKIW+DAF7Yxcjy6xJeuojqNdkEKDSJNPK9cTpV4gVYyqGaziur1TKtbQVkL70ONGh3ebjdhHdwojAVOVVVY6EadEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mBz12nTi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C705C2BD10;
	Thu, 23 May 2024 11:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716465134;
	bh=rlvbPKYJSeOouX0LacRAKV5teQ0Mud1QsMHMHqAA6Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBz12nTibu+fZxGoahsPY0ZxWEyu7GO5BKZx8pCnVyQly0ztxeicZUavg5902YNPM
	 qgPR/UGbOPqVZXVWITuLswuX/guEhhfquGEWk4vl+Oq8GNb/lZRSbPSWvNNP9Q5o5c
	 CYQU5NzBfT1l3bHTiuW1Vfr20hiDd4uYxQtG30ok=
Date: Thu, 23 May 2024 13:52:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shaoying Xu <shaoyi@amazon.com>
Cc: stable@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>,
	Robert Morris <rtm@csail.mit.edu>,
	Steve French <stfrench@microsoft.com>,
	Guruswamy Basavaiah <guruswamy.basavaiah@broadcom.com>
Subject: Re: [PATCH 5.4] smb: client: fix potential OOBs in
 smb2_parse_contexts()
Message-ID: <2024052306-exquisite-octopus-b84e@gregkh>
References: <20240507225445.25498-1-shaoyi@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507225445.25498-1-shaoyi@amazon.com>

On Tue, May 07, 2024 at 10:54:45PM +0000, Shaoying Xu wrote:
> From: Paulo Alcantara <pc@manguebit.com>
> 
> [ Upstream commit af1689a9b7701d9907dfc84d2a4b57c4bc907144 ]

Now queued up, thanks.

greg k-h

