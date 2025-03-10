Return-Path: <stable+bounces-121702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6620EA59313
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 12:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2B9188F30A
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D222172E;
	Mon, 10 Mar 2025 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e4kjwBYN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D921D59F;
	Mon, 10 Mar 2025 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607487; cv=none; b=b5VG8KN4KumvAxsIfC4hhJnaO3gHtwfg18RIIaAYIhf1FjJ6/TOZKaz+c9TUzlrj21fSATxUMGtHJttVBAbdYHJStF6y9NflxtRmjjGeqjbEppfc4Dxy8n9dpFCPa9yplTuInmAPX+4TUs5O+O0S4Dykd5BcpioMghRxlJ4iU34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607487; c=relaxed/simple;
	bh=14UewvfJ+/2PjAk0D1SqdZQSZgjkrVVUb+Auj52tKjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBk6F7atF4tXjC5VmVWjqhaPZnfTTaE8eC1keawt2qOyS4kEY30RBcCHA4AHsHrZFThLaJbqe5kKvPa1XgY80OCmpFn/3P05CQLDgUsc0VCSqMkHmox+Ru5VsKSqKJh997WGJ1VmjhefpIObj2eM5GzBVVfIq02QAU9PePU89wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e4kjwBYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4648AC4CEE5;
	Mon, 10 Mar 2025 11:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741607487;
	bh=14UewvfJ+/2PjAk0D1SqdZQSZgjkrVVUb+Auj52tKjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e4kjwBYNMlilfi05+8E5CdHRnnuKhDnHx1oOOHOnQx9Qxj67SqbcY0g7tYU/mFjKt
	 hVe1vGu6Ddr2uwASiK5Mc1AIBBb0F1M4MQa/fHcW1a4DhNiH9QGkXvG4WcOBbd5xCL
	 MAlFGuSegbat055P4mR7gPuHOYHpqJKWiQtXpKVQ=
Date: Mon, 10 Mar 2025 12:51:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Max Kellermann <max.kellermann@ionos.com>, dhowells@redhat.com,
	netfs@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6.13 v2] fs/netfs/read_collect: fix crash due to
 uninitialized `prev` variable
Message-ID: <2025031020-unframed-blast-a985@gregkh>
References: <20250214131225.492756-1-max.kellermann@ionos.com>
 <a3ad0b7e8b5e16ee25cbc692798c0858e55a1b0c.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ad0b7e8b5e16ee25cbc692798c0858e55a1b0c.camel@sipsolutions.net>

On Fri, Mar 07, 2025 at 03:27:41PM +0100, Johannes Berg wrote:
> On Fri, 2025-02-14 at 14:12 +0100, Max Kellermann wrote:
> > When checking whether the edges of adjacent subrequests touch, the
> > `prev` variable is deferenced, but it might not have been initialized.
> > This causes crashes like this one:
> 
> [...]
> 
> I believe we also need this in 6.12?

Now added, thanks.

greg k-h

