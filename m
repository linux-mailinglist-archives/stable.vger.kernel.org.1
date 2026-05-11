Return-Path: <stable+bounces-245192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOoSFDPOAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:40:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E7550E07B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C67CD302AE34
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D4938F25E;
	Mon, 11 May 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dfl9S5va"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2B637B01C;
	Mon, 11 May 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778503011; cv=none; b=FllibZFsytCE9N57JNZSdOMsPTsR/Qw291c2WghzLmjraw0E5Uo9iagw3EpdYjvVc1Ty1H8WTd95qZrAaoF3KSC8Kz1Z42x+TCetwz7CeS+mHiq1RFK8TgANpH3muaTUsIAh1/3pBHBOcQdkH3U9fVbhWnHN9r8w3J8Yl2bNFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778503011; c=relaxed/simple;
	bh=wSf8Yj543MfpEXpvXvoA6Z7kuRiTzZ8BevSv9fKsEGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB4ttLSFS+C24BZGU4+HhmofNJk5ULUmq7h60E9T0+eRkmgY9mrddXGi2umoPoLKyQr5vY2SmBN7k6/Do3mcYXywRedNLVWHLHF1fZovkJsmXC5vaxbL/AJvBv+fdm2NYQtWXf/iwTZ8UD++VfYtB3QyMB8v96ZsXm09xVmtBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dfl9S5va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910F4C2BCB0;
	Mon, 11 May 2026 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778503010;
	bh=wSf8Yj543MfpEXpvXvoA6Z7kuRiTzZ8BevSv9fKsEGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dfl9S5vaHDNeBc6jnfVanXqOrWHcjQGyzq9vP6N/IruiHY5lRf1q8aU9cSuuvjRfb
	 7QTEeNddx9ESOSthE/ZsWRRMlNp6A3KiIYbZ8noo2RxxC8iVj9Tx7xHn5i5BBwFTQZ
	 lzY+QUMCTQBJrBfhgzS23Ex1FJdpmintZVDDfckk=
Date: Mon, 11 May 2026 14:36:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexandru Hossu <hossu.alexandru@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	error27@gmail.com, luka.gejak@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] staging: rtl8723bs: fix OOB write and read in
 HT_caps_handler and OnAssocRsp
Message-ID: <2026051127-outfield-crushing-d8c5@gregkh>
References: <20260428091621.739680-1-hossu.alexandru@gmail.com>
 <20260505172214.3650398-1-hossu.alexandru@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505172214.3650398-1-hossu.alexandru@gmail.com>
X-Rspamd-Queue-Id: E0E7550E07B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245192-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 07:22:12PM +0200, Alexandru Hossu wrote:
> v4, addressing the sashiko review comments on v3.

What about these review comments:
	https://sashiko.dev/#/patchset/20260505172214.3650398-1-hossu.alexandru@gmail.com

thanks,

greg k-h

