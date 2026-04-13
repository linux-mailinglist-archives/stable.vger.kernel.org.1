Return-Path: <stable+bounces-236130-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E+7FOYH3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236130-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:12:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8103EDC25
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 830A13073384
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 15:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1EF3B892D;
	Mon, 13 Apr 2026 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aYJdfE0d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6B3B3C10
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092777; cv=none; b=YOEz31BViuAnUf/63lrX0MoqPMnGav431pULYVgTkg7X0IW0axSqHlP927twWJNXnz+8EeREJZhgFFk5boNhsuvvwpXhPZC0JHAOZKTWpI221k4ZQ8OUAyD0KJmaQCrKblhv0bwbtr0J5zm+4Nw4fAD2KUxyOV4ENuPXX5S4ULc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092777; c=relaxed/simple;
	bh=rAD/rQOdSpiv/A281+Zs8/NwbO9uoe/I1e9mNzvtHgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2ujmilhmo4VECrFeOnM7YOmnPOk6iSvI1wltkcSa3Udj6262q/mstW0W0wEIOsP62x58Cu21WFoE8AcBIga/UYX9dAVNJX5PhB5W9xYfkSzikzvnG7qFDvpfnPdmGJXClL1bkSHc/ZcBQ87j4OWlbQWWAQHodtTMZOSqYQbljk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aYJdfE0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25829C2BCC6;
	Mon, 13 Apr 2026 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776092777;
	bh=rAD/rQOdSpiv/A281+Zs8/NwbO9uoe/I1e9mNzvtHgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aYJdfE0dFhhY3Z/dkbNLtJ6xB70tTtvu5aYsRJA5+di1dk3VcExq37j+F4y+CLkb1
	 oftB3fNgNtZQrJeAYVlDZ7wa9UR6UIpPpcs3DkF3cLPVoTFftcCJqKUvfthhgWm7zt
	 ZBJfbmVOsO9rQEiqtS6pbSN2SOkZJFkpOxeKAl5M=
Date: Mon, 13 Apr 2026 17:06:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable <stable@vger.kernel.org>
Subject: Re: 5.10 / 5.15 stable inclusion request
Message-ID: <2026041305-dropbox-acre-0654@gregkh>
References: <0379aa3c-0bba-4836-b633-0bc8bc8ae4c7@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0379aa3c-0bba-4836-b633-0bc8bc8ae4c7@kernel.dk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-236130-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CC8103EDC25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 04:00:09PM -0600, Jens Axboe wrote:
> Hi,
> 
> Looks like the backport of:
> 
> Fixes: 84230ad2d2af ("io_uring/poll: correctly handle io_poll_add() return value on update")
> 
> to 5.10-stable and 5.15-stable were missed, probably by me. In any case,
> here's a backport, please add to the 5.10/5.15 stable queues. No rush,
> just for whatever is the next release.

Sorry for the delay, now queued up.

greg k-h

