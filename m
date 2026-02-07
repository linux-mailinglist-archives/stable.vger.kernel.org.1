Return-Path: <stable+bounces-214759-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBWgNiw5h2kuVQQAu9opvQ
	(envelope-from <stable+bounces-214759-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 14:07:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D507105EC6
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 14:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 450A13013B70
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 13:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF7B341063;
	Sat,  7 Feb 2026 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K4rqJYrk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B22C3252;
	Sat,  7 Feb 2026 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770469673; cv=none; b=hoC8gTmqhoeHSOnCSVsoktiWfzy+zYICMXtGuLZBNVZM8PEefb51X++NQtarBee1zZpveuz+AdVi9N/EOJdiWQxxIAMhnaXTNL4iYq086hAEnDD0IMwzKKc7Mag8TqfDJoBw+6Qg/KK2uIVfP4fb8IkAlUPcAOt8wfCqVuymwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770469673; c=relaxed/simple;
	bh=SAxjMoq0gNFyEtiN9yRUX/imRsxV8cIsS7xThiEYu9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9hdc4x+tbvRK2bKsBlmeAihKMgqlBt/VL52Ka8p6SnW2ci7h4r5Nv9pTmPHunD9tCMQbWO9sdLmgxViYmYqUQP1wNByuhtv9g7KEXaT6p94zfc6TOTp+7xvDJd0NWGFF/bjt7evy2hSyPiYrSLpCT7I1PFoXtYiSgF8SQ+dfOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K4rqJYrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8593C116D0;
	Sat,  7 Feb 2026 13:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770469673;
	bh=SAxjMoq0gNFyEtiN9yRUX/imRsxV8cIsS7xThiEYu9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K4rqJYrkXI5MRyk4SrRhE3rh3cR79+FY6nLykoR/dcSHjnnTT97uZmNcx0GGvDq6F
	 dpks5JJ3Toh/IrGH/WT+fP4g19hHV3/LzwXJEi1qt6DZJlCcKRF++WFSZ8W/vDy1Xb
	 StOJUGQdrOSJFUhCaLJKMHCmUYkY3J4YQEFJQPbU=
Date: Sat, 7 Feb 2026 14:07:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luka Gejak <lukagejak5@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 1/5] staging: rtl8723bs: fix potential out-of-bounds
 read in  rtw_restruct_wmm_ie
Message-ID: <2026020709-breeder-delicacy-91bf@gregkh>
References: <20260130185658.207785-1-lukagejak5@gmail.com>
 <20260130185658.207785-2-lukagejak5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130185658.207785-2-lukagejak5@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214759-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4D507105EC6
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 07:56:54PM +0100, Luka Gejak wrote:
> The current code checks 'i + 5 < in_len' at the end of the if statement.
> However, it accesses 'in_ie[i + 5]' before that check, which can lead
> to an out-of-bounds read. Move the length check to the beginning of the
> conditional to ensure the index is within bounds before accessing the
> array.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luka Gejak <lukagejak5@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Nit, you have an exta ' ' in the subject line :(

I'll take it, just be more careful next time please.

thanks,

greg k-h

