Return-Path: <stable+bounces-263526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pACCLDfAMGooXAUAu9opvQ
	(envelope-from <stable+bounces-263526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:17:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBCC68BA89
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:17:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263526-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263526-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BDAB3021729
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 03:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8473A3C4143;
	Tue, 16 Jun 2026 03:16:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735C83C277C;
	Tue, 16 Jun 2026 03:16:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781579779; cv=none; b=qcXpkn4VuM8ZSSi8O5dXgVhUFUMIK7YWKQHU7XJSliFrb9ZR7o1bPdTGCeCIZu4qVnU2RfsK2Vj25kn0kdPemjkKikK8UyMn2S/agTLLYAzwSpOu8f1aRNm6luLWIoyit+ZyWow+PUR/kSTV2D+Fjkf8QfTYEGgKH1zzR8PQyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781579779; c=relaxed/simple;
	bh=qtqTjDdI6m+T4XN/N6CcVLUF+QBmCRwe8Yyo4kAe7/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cru0DenjTszwCoQkAnxB/Ik7GTkHsjMVahJQLcUFJ8zkq0iwgAmj/58mL3aTaHqqjkMAGsLYGiv+pvHouxow1QPkaUL3ocLH1dOU4mO47IkSa3ciqZBhDdlGRlChwrVzTkkYRyajQBV6JzIt7nqbPyKHMYCvpLdAM37Hpxu58U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 6A5EB10DD4;
	Tue, 16 Jun 2026 05:16:13 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 44434600DC48; Tue, 16 Jun 2026 05:16:13 +0200 (CEST)
Date: Tue, 16 Jun 2026 05:16:13 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: djbw@kernel.org, bhelgaas@google.com, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/TSM: fix use-after-free in find_dsm_dev()
Message-ID: <ajC__b2Z3W_8746Z@wunner.de>
References: <20260616030243.1661791-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616030243.1661791-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263526-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:djbw@kernel.org,m:bhelgaas@google.com,m:linux-coco@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,wunner.de:mid,wunner.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DBCC68BA89

On Tue, Jun 16, 2026 at 03:02:43AM +0000, Wentao Liang wrote:
> In find_dsm_dev(), pf0 is obtained via pf0_dev_get() which returns a
> reference-counted pointer.  It is declared with __free(pci_dev_put),
> so pci_dev_put() will be called when the variable goes out of scope.
> Returning 'pf0' directly while it still has __free cleanup causes the
> reference to be dropped before the caller can use the pointer, leading
> to a use-after-free.

No, the code comment preceding find_dsm_dev() explicitly states:

   "Note that no additional reference is held for the resulting device
    because that resulting object always has a registered lifetime
    greater-than-or-equal to that of the @pdev argument."

Your patch looks like it may be an LLM-generated hallucination.
Did you use an LLM to come up with the patch?  If so, please use
an Assisted-by tag per Documentation/process/coding-assistants.rst
so that we know to expect hallucinations.

Thanks,

Lukas

