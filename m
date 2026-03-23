Return-Path: <stable+bounces-227972-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHB0IW07wWn2RgQAu9opvQ
	(envelope-from <stable+bounces-227972-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:09:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F722F2899
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 096B0307BF0D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6625145948;
	Mon, 23 Mar 2026 13:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VvJVoDvi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAD7286A4
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270822; cv=none; b=fDiag/CZlLLHZFfvnWy+t8Nrxqvg6/Albo8R5Z78bRD9gYOf9hJdXTELCA4K5vwzGVKLgP/uxUaISwCe02mD+hxAUk6R6G7h1jOZtDX1XawLhb/9Sjn6STKLHoirNu+y49109xPT6xxb0a6K6m1L7n7kYHM/WwZWsT7cab8+kuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270822; c=relaxed/simple;
	bh=NiDhwM7+uj+ZCcIpQ1Vu0ykSSlBJ19E/FGMRyVej0rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqJrwHZrKVDPnrWjov6Cq4U8b2SaOVBTFK/YckYKg9eiCh97/TciV8hYj3Ms/U7YrXF//TLseWqkhkh09LqC0cZUHJcYm/asC31O8BAAsa24AI9dxCN77BNHg2sJjb0E2djBhOT3Wy/6xl4sW4Hb8udigym9wyqioMpWnGZlqkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VvJVoDvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FA01C4CEF7;
	Mon, 23 Mar 2026 13:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774270821;
	bh=NiDhwM7+uj+ZCcIpQ1Vu0ykSSlBJ19E/FGMRyVej0rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvJVoDvidVotVU1K4aRMuVX1HRLAF9gN8IIyhafkmizBrnxIWkuIzBRL1LlAY3hXD
	 vt6F2Za7zZrjtzTPKi5W8AYHvg66zrisfC8e3Acw9HfuM7VG7A2v46F5EdIhiYgDhl
	 4F4n01YdLtuFfc//BSpyc5+wS71V7/0xrWjqv2ok=
Date: Mon, 23 Mar 2026 13:59:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] smb/dfs_cache: Fix NULL pointer dereference on
 session connection failure
Message-ID: <2026032355-portfolio-corral-c5de@gregkh>
References: <20260303173139.517020-1-ghadi.rahme@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303173139.517020-1-ghadi.rahme@canonical.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-227972-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: E0F722F2899
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 03, 2026 at 07:31:39PM +0200, Ghadi Elie Rahme wrote:
> [ Upstream commit 6916881f443f67f6893b504fa2171468c8aed915 ]

No, that is NOT what this commit id is.

> It is possible for find_ipc_from_server_path to run while the tcon is NULL,
> resulting in a NULL pointer dereference crash when calling strcasecmp().
> This happens when the ipc connection fails freeing the tcon and setting it
> to NULL while the dfs cache worker thread was already executing.
> This issue was fixed upstream indirectly by a rewrite that removed this
> function. Although with this fix the issue can still occur, the window of
> the race is now much narrower.
> A fix that would completely fix it using mutexes was tested and
> worked fine. However the regression potential would be much higher and so
> would be the deviation from upstream.
> This is a good balance of safety while minimizing upstream deviation.

No, please use the upstream commits instead.  Also, you did not cc: any
of the maintainers or developers involved here, which would mean we
couldn't take this anyway.

sorry.

greg k-h

