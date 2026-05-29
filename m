Return-Path: <stable+bounces-256606-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFmIIZF8GWr3wwgAu9opvQ
	(envelope-from <stable+bounces-256606-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:46:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25712601CF6
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC2783038C65
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E93D7D60;
	Fri, 29 May 2026 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="doQ+STQB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RlmuvkiZ"
X-Original-To: stable@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05D3CC32B;
	Fri, 29 May 2026 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055082; cv=none; b=A740vSPAe8krqjRDNAZ1dGkwV11y21/2oF2YlxFHfegF2LHr4B+Qp18jlxrYFbrVkQIsFn2HU5zoP6dMXevHXWmoFMBJpeHXN02Rzv1wgpXtvua9EkEGE33ibJBzrX8gkZCP9iBLiizdAH+umjey4LxXvpzsPnetaXeUznfMoV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055082; c=relaxed/simple;
	bh=KxEniBUpCAt3fvOHE3feCTvcQdwY5BA59C13hgw3oJo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gYioXfSeRv/7WHYDNfDJ9vGgaNTxEQYP+daeMwQPvcRfwUCP4DTjy14alqlhmX7wbzHR0KDzeynay1nCtaazYacuIHtexZEjKK7BVfyJWwEBQexMWGwCQrVhP6ROUT5mp3syXC3bKibHQVH07EFG3LHO2J+NRrEktJx9cJ7byZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=doQ+STQB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RlmuvkiZ; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 187F91D000B6;
	Fri, 29 May 2026 07:44:38 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 29 May 2026 07:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780055077;
	 x=1780141477; bh=dakiticL3KcnH3Mr/ftel+GcbHuqEroaW01vc1VFp8c=; b=
	doQ+STQBDCQgZDyK9pBeL0MTZOTbF07Z/QNSNr0EM/3dEPvcnCWJPz56JRM/EklT
	PWYu9w/2yhbTmhgCyh6Kk/ruMfJGRCAhqhg8QF8ARqOvvu+ejgkRI41p5BWECfQz
	EaPAGA+e42ZPEaxyGzfMZTvqghJP8bootznZb/WnSdT1NkDu7sP+X00/ckgCFXyL
	aPU9qo7MMfAUnw2VeymhcU5LRx2AcwDzyXS+d0jNEUhfN/9qB4gyUFJHxWmIs0tB
	+2ZCDutrLkoL5S+WSqCCM9+7qFY3oxySxt0Z8BNP0csGsIvGwd0VUoOuHDVgxODm
	1cB36qFMEdwbC3V/VkL1BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780055077; x=
	1780141477; bh=dakiticL3KcnH3Mr/ftel+GcbHuqEroaW01vc1VFp8c=; b=R
	lmuvkiZtvll5fAliuc/TayDNvVWNF6BMKGoWKixK6BqYmOlBwhRy5BZVwVagtfS/
	IdNE0yxwYcuAyCoCy8Wu3i2Vt0eOaC1RBBgIaakbpv6glha6evjUjCLlS4zMOY3i
	0SWXMozKanuJha9r1FUaki4gPF9tom9gFyUJQmLw0dheqtI6FPGYhNoc5tKbuMPs
	oqPYl63xlN0Qj3Dg3ooIlyuJ/dfDQ5pZRpgU7NI7ERsAfOPo08OQ2vE72nZzni1/
	HgbTWkt4P3xXaV1BUXm0jmqyDuvtuDecii4e27p44YCdGs//sFI56Nax7U+8nPEM
	0KaSqmByBTVWcDLiX0ZCw==
X-ME-Sender: <xms:JXwZagmdaKx8-aNcyjUjF3Sa4WL8r96Xcs7Mrsk3KA87uRNBC5K1dQ>
    <xme:JXwZaqrGe9NGz0h1SnvmbEUnwwCRrksXx-M65tdmPCc3kZKiSlx-PDPX90z7mp__R
    lIMfj2xr4IMdNnRVuicZjiHqCvD4i3_vlo-XvwlUJispV5g0wHeYNg>
X-ME-Proxy-Cause: dmFkZTE1AF5MuKiGjejyqiNs30FvaXZD/yW/oTzYH3UBKvNMbqhYUiGLgUeBuBy7X5uoOl
    4ybjLNi+fwFzCC9jiQREiqcI76WN1VuKsrnej+BrSv6Gp+mjdbS3XWvzJzaSexVgS4KXOZ
    zQTIfg/WUY0dIfRGE952WmkgtiI7YW+0zMYxdpWx79VfZeXeqq8rhqEuXDuaE+PuuZjLHS
    uBUcDK6I861h6yf5/Z81VmnqC2v4S4rOch4/3I8bbDEXchPpIRi89Px4hVVGSwAuJNbfzB
    tDxxWKi23rcH+qe23+fvt2yCYVjTwlrVLbHlp3Qpd7FG7oCzJ1Tdv6mobO+wXryNnK79g+
    NcBsAeIz2y/45Opi7CaUmYVDDhYyDU8wp6cHa7/5uNDrATQITbumjW7liU/JcP0Jyx56mY
    UiCLgKRsyMo7IR/Y+CcGOfeO5NCSlzuGFn5/KklrRnzQc+ves0E6LNWuMZe5NlDOrt64Ti
    de7hPqkvuUTZxPJ0g+iip8GGx5Ycgtd/3EsG8fKe9v3AWPHLcXGeMu7BiZ/Tnkz0tN2VkJ
    OtYZLCNa7C5XLLy8MRrPXDjBqhX5xHyJ9OvygLX2fSq9H6QvvLBzlMJPnxZ+noO9QHZ/0I
    /479X2zXsltj1R8AzCoGTxISDQaC5kQsKqOGn40F/LCHBzT+ttyjAQxI5d3g
X-ME-Proxy: <xmx:JXwZasIsi81tOW2TXB2vBVZEbZwPz0Peq_4nP98nIS-wL7nfUe_IoQ>
    <xmx:JXwZatuX_j_MRa4jIqAUcb96tsCv6EvBfp0HhUx67ax5kVG7yFfC_A>
    <xmx:JXwZar8ARCpsh1-AyQHPSnr9KKRptmrUXC8gGWaPONSJ-IXi6vfJ2w>
    <xmx:JXwZav28spS3WNj6lag2ON44iiGXTfvYNtFYepFwWRvUhQ3XTkhsYQ>
    <xmx:JXwZasJh5DiBbqJEG7zNlbaySmfxS8HwR52mvUr6dA4wHfCtHl35VHhi>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 452C5182007A; Fri, 29 May 2026 07:44:37 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR8ZB97ino5k
Date: Fri, 29 May 2026 13:44:16 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "Alim Akhtar" <alim.akhtar@samsung.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Peter Griffin" <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 jyescas@google.com, kernel-team@android.com, stable@vger.kernel.org
Message-Id: <9d6bda31-839b-4cf8-b715-0d24760c73c2@app.fastmail.com>
In-Reply-To: <ed771a16-6241-4246-976e-48349e544b5b@linaro.org>
References: 
 <20260505-acpm-fixes-sashiko-reports-v5-0-43b5ee7f1674@linaro.org>
 <20260505-acpm-fixes-sashiko-reports-v5-4-43b5ee7f1674@linaro.org>
 <a1629d9d-0357-42a3-aef8-c8d1cfa5ad39@app.fastmail.com>
 <ad30ca8b-01ba-40b9-a631-503ff463bc50@kernel.org>
 <26e9c700-c519-4888-8739-c48c73b8a39f@app.fastmail.com>
 <ed771a16-6241-4246-976e-48349e544b5b@linaro.org>
Subject: Re: [PATCH v5 4/7] firmware: samsung: acpm: Add memory barrier before
 advancing RX pointer
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256606-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+]
X-Rspamd-Queue-Id: 25712601CF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026, at 13:20, Tudor Ambarus wrote:
> On 5/29/26 11:25 AM, Arnd Bergmann wrote:
>
> I missed the data dependency chain. I focused too much on the read
> part in __ioread32_copy() that I missed the RAM store implications
> in it. The RAM store is forced to wait for its SRAM load, and the
> writel is forced to wait for all the RAM stores. So the entire
> payload is guaranteed to be visible in memory RAM before the writel.
>
> Maybe I thought about the reordering of the final __raw_readl() loop
> iteration with the writel(). But the dma_wmb() -> __dma_wmb() ->
> dmb(oshst) from writel has a compiler barrier, so the compiler can't
> reorder the code. And given the ARM64 device memory accesses ordering,
> the ordering is protected.

Ok, thanks for checking and confirming my thoughts.

> My bad, sorry. We shall either drop or revert the patch. Please let
> me know if you prefer a revert.

I'll leave it up to Krzysztof, as he's already sent it to
soc@lists.linux.dev as part of the 7.1 fixes, and I'd
like to send the rest to Linus soon.

Krzysztof, if you can send an updated pull request without
this patch (and maybe also without b4a38606991c ("firmware:
samsung: acpm: Fix dummy stubs to return ERR_PTR"), see
separate email), I'll just merge the other fixes and
send that off instead.

      Arnd

