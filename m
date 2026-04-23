Return-Path: <stable+bounces-240463-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AK5NGFgD6mk/rQIAu9opvQ
	(envelope-from <stable+bounces-240463-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:32:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C61451501
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EF6C301BA51
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362823E7161;
	Thu, 23 Apr 2026 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JC+jvmZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50BB376BD3
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 11:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943940; cv=none; b=AsPTRSSZl6rHAqH5cZjoFPcuS+HtbBLbM2mCUyutFC5Br59Cv26YfscqXnSYEqwpL1Te5aAeVJxh5XtwxniIB+SZOf/DbGfClJA6OuQ73PGm/kyJaykxDpNbpH6/uOEOLM5fG81ZbBKGh5vX5X7xu7quMlFndU5mFrD+8ST9lpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943940; c=relaxed/simple;
	bh=u1cFUigbHynrW7j3ngIYNDco2wDUGRMpuNGp8m0gPWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ec140Dto1WbS/CowiHeIPEj7b7klb5MWUDz4S63N5v5fAwlMdlw9Fn2wFmY3Ukj85YcnPcN1752CTbSLovq09axILSEa8SoQsnWsKvQ6ALP+Hoqv0Guwx46WetBRDH+Njdgno+1+g+jWFTywXhlLfLoaIgzwXLAWQqrogyPypN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JC+jvmZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765BCC2BCAF;
	Thu, 23 Apr 2026 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776943939;
	bh=u1cFUigbHynrW7j3ngIYNDco2wDUGRMpuNGp8m0gPWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JC+jvmZIEBw/2ZzUzoofL1NGaUOKV2TfD/AcS8VBpLLEV35bogR33A+WJ5WizkZHv
	 sxvXUJsCk133PPvRHGU74cn8Q0xNpiXeuqWAqlfkao9fZ7JqcUgVgZ9ESY4e4f0gHL
	 99FYS/KuNgAbvql2ZSUxlXTxanmPCkrWG/SqSjXg=
Date: Thu, 23 Apr 2026 13:32:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ghadi Elie Rahme <ghadi.rahme@canonical.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] cifs/dfs_cache: Fix NULL pointer dereference on
 session connection failure
Message-ID: <2026042346-mouse-robe-dfb5@gregkh>
References: <20260303173108.515913-1-ghadi.rahme@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303173108.515913-1-ghadi.rahme@canonical.com>
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
	TAGGED_FROM(0.00)[bounces-240463-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: D9C61451501
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 03, 2026 at 07:31:08PM +0200, Ghadi Elie Rahme wrote:
> [ Upstream commit 6916881f443f67f6893b504fa2171468c8aed915 ]

No it is not :(

And this commit is not in 6.1.y, which is required before taking this in
5.15.y, so you do not have regressions when you upgrade.

thanks,

greg k-h

