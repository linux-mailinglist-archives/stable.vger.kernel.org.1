Return-Path: <stable+bounces-223693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCrKKSnsrmkWKQIAu9opvQ
	(envelope-from <stable+bounces-223693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:50:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01F23C0D2
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F38D930C78CA
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040D3D5226;
	Mon,  9 Mar 2026 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IcePNSxs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A1363C4E;
	Mon,  9 Mar 2026 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773071138; cv=none; b=BLfuCHmdhQ7xNeiyx8XwKh1Q2gTQRpY+A/x7/Q9ZW11aBmdjqsr0+FAFjuiABqBjlJmKPtpJ+bzrZqVZVoJo5XtP8gvYhNlF2RWAXEE1MxGbTZIY8FxouOABXvGUUqCmABjgmFY0nSy3pibdhbZZ00vhabQjluFADjZ0wi0UgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773071138; c=relaxed/simple;
	bh=CHIABcfp6iFjBK4U5KHO6h46nMUq7NvXYnb1FyFja3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXAag6xBXMRsCYIol0u8oGuyaqt5E/F9ckEILLAdT6xtBo40e8USwepSFvlRhO/a/ChxNRztrNT+LzU2gC6r+ilZ+pYbkh7BmWsmTDz7084cq+00S5Y3TT3oRbA8fy9q0HSXeEJOgbskNNOkOxtf6MD41pfj1rQUon4ZCuTWU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IcePNSxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741C3C2BC9E;
	Mon,  9 Mar 2026 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773071137;
	bh=CHIABcfp6iFjBK4U5KHO6h46nMUq7NvXYnb1FyFja3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcePNSxsXv/P4uBrW6ce/vz7c4D4ccbdz66tz+MxL8JrMG/4+5hs56v1n486TUEYN
	 R8IS+xUO4n2w0LBxOv10Gh1UyY170rfJKKEixHkTsuUfzmoGjw1I5vY86GhP8zoC/k
	 I9tCAirwB/P07pLok6RUrXAA/r8ov/OoRMnfmjaw=
Date: Mon, 9 Mar 2026 16:45:35 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Johnny Hao <johnny_haocn@sina.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Wenzhi Wang <wenzhi.wang@uwaterloo.ca>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6.1.y 3/3] hfs: fix general protection fault in
 hfs_find_init()
Message-ID: <2026030916-chaperone-twelve-8284@gregkh>
References: <20260309061649.1621436-1-johnny_haocn@sina.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309061649.1621436-1-johnny_haocn@sina.com>
X-Rspamd-Queue-Id: 6F01F23C0D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223693-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sina.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.319];
	RCPT_COUNT_SEVEN(0.00)[8];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 02:16:49PM +0800, Johnny Hao wrote:
> From: Viacheslav Dubeyko <slava@dubeyko.com>
> 
> [ Upstream commit 736a0516a16268995f4898eded49bfef077af709 ]
> 
> The hfs_find_init() method can trigger the crash
> if tree pointer is NULL:

Why is this not part of the 1/3 and 2/3 series properly linked together?

thanks,

greg k-h

