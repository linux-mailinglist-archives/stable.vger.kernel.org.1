Return-Path: <stable+bounces-144740-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F1ABB56C
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 08:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD8601892195
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 06:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CACC2580D2;
	Mon, 19 May 2025 06:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dKHqGtCc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7FD1E9B04
	for <stable@vger.kernel.org>; Mon, 19 May 2025 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747637835; cv=none; b=EaHA3FnddW0oVPMrq4Pg99uIgZ3zVqV03d+X/i1V3ESYeBaaO416kiraJnkzeW6VD8YAWm52ZFb68Z80nUhsEvaN6/lea3Ec/bT0AObHA4YffZa1Tj8QyXTrB1Y8+o3bDlMQ4c/eR0XMi8DpubE/RpLrbOjzlKQQOT/aSAz3agQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747637835; c=relaxed/simple;
	bh=xiCN8eXxLeBnW23wMhJ3g9YnGCX+NRRYT6p5GNxO7lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3DOe8AKfk6oD0V/x6hl9i97wTn63rT78faRqlPEutSdta8nk4+ianyNl3DoTuydN2xgOrHf9Qpz/4C8pO+ey8AKWlEGYSMEmNjS8jS33JRog5/sZ/i6zaaXh2a2HoCYA/ZXLxuh7kY90DazrpM/wskZE275GImaa2RaS+R7pWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dKHqGtCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9C5C4CEE4;
	Mon, 19 May 2025 06:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747637834;
	bh=xiCN8eXxLeBnW23wMhJ3g9YnGCX+NRRYT6p5GNxO7lc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dKHqGtCcpw2Ylr5+lTdDffIpR48JpENABk6HrR2y5c6Xb9vYZS3lGMuUqNjFVjLy+
	 U5zRyxf9hPtYgyVo2l1PPOOkV4Fi9//Ogzq29kQAModRu1t/6IQViqt7VkeDJASh0h
	 /2WZfjEQ8iwNrchVa493E9OOcL30oEjj7Zgdrcbw=
Date: Mon, 19 May 2025 08:57:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: stable@vger.kernel.org, stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 6.12.y] usb: typec: ucsi: displayport: Fix deadlock
Message-ID: <2025051945-rotten-primer-4e5c@gregkh>
References: <2025051224-washing-elated-c973@gregkh>
 <20250514144931.2347498-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514144931.2347498-1-akuchynski@chromium.org>

On Wed, May 14, 2025 at 02:49:31PM +0000, Andrei Kuchynski wrote:
> This patch introduces the ucsi_con_mutex_lock / ucsi_con_mutex_unlock
> functions to the UCSI driver. ucsi_con_mutex_lock ensures the connector
> mutex is only locked if a connection is established and the partner pointer
> is valid. This resolves a deadlock scenario where
> ucsi_displayport_remove_partner holds con->mutex waiting for
> dp_altmode_work to complete while dp_altmode_work attempts to acquire it.
> 
> Cc: stable <stable@kernel.org>
> Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
> Change-Id: Ib10b1ec42c210b49cf67155ed1df7b074a99405e

Why did you add a Change-Id: here?

Please fix up for all of these that you submitted with that invalid
tag in it.

thanks,

greg k-h

