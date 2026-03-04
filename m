Return-Path: <stable+bounces-223021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG/dF5v4p2mtmwAAu9opvQ
	(envelope-from <stable+bounces-223021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:17:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E151FD6E1
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EF11304DC89
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 09:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEB1394470;
	Wed,  4 Mar 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gbm3RNeV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24A438239E;
	Wed,  4 Mar 2026 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615446; cv=none; b=nGnMbtxWI3Qp/P2AkO75biVIzQ3SJUpNA54aZfMB3Rrd0dVIRw/YzEnk7IK1VksLcP7kkK8Oj27qte9IccAiaDFHwY6DUZN0dnm8L/4rw5MmPX0oNEnzhH7lP5WepNLZC/twK1TGoCYV2WmuhlSeWJg//HLISE3kQMgBvZC7u7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615446; c=relaxed/simple;
	bh=IQrK6dW6KhF2jclfZoFYRQf9hoTV5uXhQwtwxKM69hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEtfiUn/Ks/a/mheas+MC9DsM1sx1br2NWfrTDKLW+Co2N5C3pmHu0E4G/YtzUS/SNYAizkibEfrcfS9hb4hPlNVJ/p29elpXVWwDgZG0bikyO8R/FtwoMsyxZLG23oWUYabM4K/YMRp5O76wjhoya2hc5JiUQM2t3SrXqAuJps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gbm3RNeV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D0CC19423;
	Wed,  4 Mar 2026 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772615446;
	bh=IQrK6dW6KhF2jclfZoFYRQf9hoTV5uXhQwtwxKM69hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbm3RNeVfYKq5g9YsKy/U4Rsm3Oa+aH5tyxQnPEvZXppjztN/5D49s6CKIBzIgQOA
	 JF+amskP33fTYYPg019pciQhRJbTq2bSptdxFeB/RR8ovDmlSfKX5DYDCrGRbrty0K
	 aik8x1GpFwourqAhe7i/bU+qPJX4fuVWnV+AzRsI=
Date: Wed, 4 Mar 2026 10:10:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Joonwon Kang <joonwonkang@google.com>
Cc: stable@vger.kernel.org, jassisinghbrar@gmail.com,
	linux-kernel@vger.kernel.org, sashal@kernel.org
Subject: Re: [PATCH] mailbox: Prevent out-of-bounds access in
 of_mbox_index_xlate()
Message-ID: <2026030417-shudder-value-27ca@gregkh>
References: <20260304073052.3224244-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304073052.3224244-1-joonwonkang@google.com>
X-Rspamd-Queue-Id: D2E151FD6E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223021-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 07:30:52AM +0000, Joonwon Kang wrote:
> [ Upstream commit fcd7f96c783626c07ee3ed75fa3739a8a2052310 ]
> 
> Although it is guided that `#mbox-cells` must be at least 1, there are
> many instances of `#mbox-cells = <0>;` in the device tree. If that is
> the case and the corresponding mailbox controller does not provide
> `fw_xlate` and of_xlate` function pointers, `of_mbox_index_xlate()` will
> be used by default and out-of-bounds accesses could occur due to lack of
> bounds check in that function.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Joonwon Kang <joonwonkang@google.com>
> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> [ changed sp->nargs to sp->args_count in the code and
> fw_mbox_index_xlate() to of_mbox_index_xlate() in the commit message. ]
> Signed-off-by: Joonwon Kang <joonwonkang@google.com>
> ---
>  drivers/mailbox/mailbox.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

What kernel tree(s) is this for?

