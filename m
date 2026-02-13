Return-Path: <stable+bounces-216076-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNP7HVIWj2mbIQEAu9opvQ
	(envelope-from <stable+bounces-216076-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:17:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC17F135FD1
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 13:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95AEB3038AE1
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA69A34D4EE;
	Fri, 13 Feb 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uktPk/Ul"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA721DFF0;
	Fri, 13 Feb 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770985038; cv=none; b=oLb25p6irBFI8TFBdTSAurIlhDScAVur22EjmOqNGRXzfvIzaun+qGJVKKHuINbvv90qQapHz3H8mvbIhQjE5vuOtu403OoaC54tKAgrn82BbayRD8ZpBNQdg4Id5G1nYTtz/nU0FE1SI4TQrVk2rfOOqz+XlOBVA+bV29pBV/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770985038; c=relaxed/simple;
	bh=acl4FRIep9r939xsaprpo6dnIx/DgwLOFwnj+XnOOxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/tivJTSr7cNxGnOSjYDqO7acCpU9GVZpzr03TLoS+NrZnubAN0gLXm+LOqmwHOt/uJhYe1HxR6rIiE/r8jwPMGuj6k3Zg8YqQUWIdwKPl1Ew8B8WnHUiMrcpCuQIVMncxcrj9LRYrOPMXfg7XWbnVWqmmHiAu91fXWFZf3hMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uktPk/Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F295EC16AAE;
	Fri, 13 Feb 2026 12:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770985038;
	bh=acl4FRIep9r939xsaprpo6dnIx/DgwLOFwnj+XnOOxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uktPk/UlsWGQt49WaBDsh8ydf/NSfUSuBQPlDtfslspfmsTPI21TsH+avxWVWBQj/
	 8vHscfp4IWD5zbPh4j5XSnYXaZebaRtTQLl4yyh+cBcM8srzTxEJasITyehqvqRcT0
	 YGYelQfgPuFfNxBzkRcc4XFxYAI6bOvpW+LL4d7o=
Date: Fri, 13 Feb 2026 13:17:15 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Igor Klochko (Nokia)" <igor.klochko@nokia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Philippe Belet (Nokia)" <philippe.belet@nokia.com>
Subject: Re: [PATCH] uio: fix uio_unregister_device
Message-ID: <2026021323-delegator-reusable-4e13@gregkh>
References: <AM9PR07MB720434A2B0CC99BC0BDCD74E8D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
 <2026021306-shabby-overhead-0626@gregkh>
 <AM9PR07MB720414361A0BA3BA2CF107208D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR07MB720414361A0BA3BA2CF107208D61A@AM9PR07MB7204.eurprd07.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-216076-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: DC17F135FD1
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 12:09:04PM +0000, Igor Klochko (Nokia) wrote:
> Hi Greg,
> 
> > Nice fix, but what is causing these devices to be created and removed in parallel?  
> It's an outcome of a stress test.
> 
> > Nit, line wrapping at the same column width :)
> > Please use more digits, as the documentation mentions.
> Acknowledged, will resend the patch.
> 
> > So no locking is needed here?  It's only the minor that is getting messed up?
> 
> Only minor. If I look at the history, 0c9ae0b8605078eafc3bea053cc78791e97ba2e2 moved the minor before device unregister.
> 
> However, this breaks a fix done in 
> 8fd0e2a6df262539eaa28b0a2364cca10d1dc662
> uio: free uio id after uio file node is freed
> 
> > And should this be cc: stable?
> 
> 0c9ae0b8605078eafc3bea053cc78791e97ba2e2 is a CVE, so it was applied on LTS kernels, we discovered this on 6.1.
> I thought stable is the right place for these kinds of patches.

I agree, it is, but you need to add "cc: stable@..." to the
signed-off-by area of the patch, as the bot referred to to, if you want
that to happen.

Can you resend this with that added, AND the sha1 fixed up for the
Fixes: tag?

thanks,

greg k-h

