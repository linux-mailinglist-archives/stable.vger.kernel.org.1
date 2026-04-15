Return-Path: <stable+bounces-238030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP9AAEUa32mJOwAAu9opvQ
	(envelope-from <stable+bounces-238030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:55:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCF0400446
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 06:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35C66303019D
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10F2330B0B;
	Wed, 15 Apr 2026 04:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qKU0S3+3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A529E0E5;
	Wed, 15 Apr 2026 04:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776228929; cv=none; b=ambDULnQoE2Fx2r5Ji4hnEFjjJzeCFnpZVsPZx46sKMIwbBPBkyB1WQZqU39kusQGYx3fNFIprVa3azzzhXdBqZ1kwdn37rwf72u6FF3Ss5sZrufF7pJWjGbD3aGwFyr2TFbMIc9o7MSqnUA9LtMV1EZdGF1WFH6qGbHdhWWulQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776228929; c=relaxed/simple;
	bh=CgD8yDwX/LpKMqyfme+UTCppo5KKCMpnwC581PlowAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbaFptnut4gWSYXyA1OLyQUmBFzVC5gC1scdnHwG8+MbSNIFfaPybYUzoyWULgeKaNdIs8eYsidhBFbJjayKtSPPhuwg8Ab2YJAI/YG3IWb4Qz8Qb+/FVdc0CZ5IaTCvJWSIcfxEQK0yP6RKV1B+YeKpz6hm8y02J8YGfiPMwQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qKU0S3+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87696C19424;
	Wed, 15 Apr 2026 04:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776228928;
	bh=CgD8yDwX/LpKMqyfme+UTCppo5KKCMpnwC581PlowAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKU0S3+3n39uypt9KrvaXN++EkbBm0R/ZuFAxwRXjbzx/iOuCR/iNG5wCORtw9qAx
	 utJasT3ZZlUoIBo2Yjdgan+FZMi5oTx2wQ4EbQZv1ZaYzS1zb4TgOtT8rJdbT8Drfh
	 UHslfhs3YbgUIOHuXmCGx1+1yARQU4t2Q2DVLyRg=
Date: Wed, 15 Apr 2026 06:54:45 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: luka.gejak@linux.dev
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix remote heap information
 disclosure in issue_assocreq
Message-ID: <2026041528-bling-germinate-e1c8@gregkh>
References: <20260414194945.138626-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414194945.138626-1-luka.gejak@linux.dev>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238030-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 5FCF0400446
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 09:49:45PM +0200, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
> 
> When building an association request frame, the driver copies the
> ht capability ie using the attacker-controlled pIE->length from the
> ap's beacon. If the ap provides a length greater than the size of
> struct HT_caps_element (26 bytes), it causes an out-of-bounds read
> of the adjacent heap memory (HT_info and network structures).
> This uninitialized or sensitive memory is then transmitted over the air,
> resulting in a remote heap information disclosure.
> 
> Fix this by clamping the length passed to rtw_set_ie() to the actual
> size of struct HT_caps_element.
> 
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Luka Gejak <luka.gejak@linux.dev>
> ---
> Note: Note: Alignment of arguments in rtw_set_ie() is intentionally 
> like that to avoid WARNING: line length of 105 exceeds 100 columns.

That's not ok, please exceed the length.

thanks,

greg k-h

