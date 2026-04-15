Return-Path: <stable+bounces-238031-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLV3CKga32mJOwAAu9opvQ
	(envelope-from <stable+bounces-238031-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:57:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8293540046E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B990C3088E32
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD0B33B6F6;
	Wed, 15 Apr 2026 04:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z/fulMzx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF629E0E5;
	Wed, 15 Apr 2026 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229026; cv=none; b=MfLfOgVC+8qnBF02xqHEqbKsXJBW929OUn7sGjmkPcVkA6OK31iIYFwhDJ5i8uc3rq8c/Km8KiDjBPGUjiBYKUyMICL9AXcmAIe+A4RgwA52oPKwlgy38N/Yg+1/2H7oVzMmEMxS7yhPNKsT5IvZYJF+6E7+ZQwTs7Iitg9NSgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229026; c=relaxed/simple;
	bh=7bmwn0Y1gXkqV0ww6VHn7/DtwKTUCI45wxEIgUaBz+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVvR+Qw3Ch2q0TIQGHmjJJVkMPxkPBH9JBXwnhAA6FNGbmVK7g76q4ZkYyed+ICXKMMD/7iv2EC4WnQo6glFW6K2IU2YbIr644zKcy2l0UVZcGSByuDaUP3NPHr0SzX31QPW+1/yfAxmXea4okF1wwW+WFRGH4M4pbWPeEYdVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z/fulMzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F09FC19424;
	Wed, 15 Apr 2026 04:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776229025;
	bh=7bmwn0Y1gXkqV0ww6VHn7/DtwKTUCI45wxEIgUaBz+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z/fulMzx+m5Pf0PHLc+EPwHCE8dCXCQ6spbWp8EjBIrxtS1V12yZREcjp/ndeIwCR
	 r0n1buRKL/ffp6lPeQyozHLmjBFa/5BRccyZi2Ssu/728huG3R3nJCNejYrwINK+0k
	 SjdrYlc3AqBNqiOeF67SUjvETZMjHIG3rdfJFcCw=
Date: Wed, 15 Apr 2026 06:56:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	error27@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix missing frame length checks
 in OnAuthClient
Message-ID: <2026041526-resonate-overpower-e45f@gregkh>
References: <20260414213959.1028301-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414213959.1028301-1-hossu.alexandru@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238031-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8293540046E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:39:59PM +0200, Alexandru Hossu wrote:
> OnAuthClient() accesses pframe without first verifying that pkt_len is
> large enough to contain a valid 802.11 management frame header:
> 
> - get_da(pframe) reads bytes 4-9, requiring pkt_len >= 10
> - GetPrivacy(pframe) reads the FC field at bytes 0-1
> 
> Additionally, when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ the
> unsigned subtraction passed to rtw_get_ie() wraps around, causing it
> to scan well past the end of the buffer.
> 
> Add an early check against WLAN_HDR_A3_LEN before any pframe access,
> and a second check against WLAN_HDR_A3_LEN + offset + 6 after computing
> offset to guard the seq/status reads and the rtw_get_ie() call.
> 
> Suggested-by: Dan Carpenter <error27@gmail.com>
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
> ---
> Changes in v2:
> - Replace incorrect Reported-by tag with Suggested-by: Dan spotted the
>   missing length check during code review of the heap overflow fix; he
>   did not file a separate bug report
> - Add missing version changelog (the initial submission was incorrectly
>   labeled v2; no v1 was ever sent to the list)

So this is really v3?

And based on the thread, there was a v1, this one just replaced that.

If not, then I'm totally confused, please resend ALL pending patches for
this driver that you have as a patch series, properly versioned.

thanks,

greg k-h

