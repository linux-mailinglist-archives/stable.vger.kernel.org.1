Return-Path: <stable+bounces-260932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LGwPFt4/JWrsEwIAu9opvQ
	(envelope-from <stable+bounces-260932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 11:54:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B124464F496
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 11:54:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=YJp1uk0V;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260932-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260932-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8019B3012BE8
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5A5388E50;
	Sun,  7 Jun 2026 09:54:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE4F38734A;
	Sun,  7 Jun 2026 09:54:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780826074; cv=none; b=lctMABqML2yHNZlG95dxm91pTfz8YlCShR1m2QSZFohyDBv1VxVOq4WfUQ5w5ym4kdgDLtRnP1jZypp3KVy3juxlSMIiG/LrorIbeEjB2CoXx6c1Xx91JPOet1r7TCwcho5LjgtANC3LYjQuASolIonIus4nBoKTcBJspGtfkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780826074; c=relaxed/simple;
	bh=rLzS8kVZIaLrxE7golOIyuypqsEka7TpVmWikthKQlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFvA5rxDLpBEHCdE8JDBYehYSnm/AfRTN7qx/pBnjopGiS3COAfMGhA/RvHOURKUUI6A0ptFqsDX4MsY/YQJb6HfFvAQO8cBerIdDesadFHsYfVGkEMJjAxQQuJ1vvhjAOzxOBs0Wd4nl3L27YPWetFQWi5yR2J1pyyDrS9s0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YJp1uk0V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ED021F00893;
	Sun,  7 Jun 2026 09:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780826073;
	bh=z13/UNc27kjJOIZUWZbt7bi5IAGJ1TZgFynQ0tyy04I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YJp1uk0VkfN4UnvjgEac9t3OrHpM5RBCSrkWIy/xf5j0n4E4BZeNs/SsuTEJmBD9o
	 CLRKYBo//Qk7u4IxLlNgE2V0/Svj84B1YAvzNwFvdTaYALNAnQfzN9Oe8CnJYhH0Kd
	 jcacCC7kIT2E2DQUBvp7q9ANevZQKJJ5UwNV6otU=
Date: Sun, 7 Jun 2026 11:53:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: David Heidelberg <david+nfc@ixit.cz>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: nci: add data_len bound checks to activation
 parameter extractors
Message-ID: <2026060725-husked-latter-8231@gregkh>
References: <20260607094822.322125-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607094822.322125-1-hexlabsecurity@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260932-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:david+nfc@ixit.cz,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:david@ixit.cz,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,nfc];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B124464F496

On Sun, Jun 07, 2026 at 09:48:26AM +0000, Bryam Vargas wrote:
> nci_extract_activation_params_iso_dep() and
> nci_extract_activation_params_nfc_dep() read an inner length byte from
> the NCI RF_INTF_ACTIVATED_NTF payload and use it to memcpy() into fixed
> kernel buffers, but neither function receives the caller-validated
> activation_params_len.  A crafted NCI notification with
> activation_params_len=1 and an inner length byte of up to 20 (NFC-A) or
> 50 (NFC-B) causes memcpy() to read that many bytes past the one valid
> byte in the activation params region -- a slab out-of-bounds read of
> kernel memory adjacent to the NCI skb.
> 
> The sibling nci_extract_rf_params_*() family was given equivalent
> protection by commit 571dcbeb8e63 ("net: nfc: nci: Fix parameter
> validation for packet data"), but the two activation parameter
> extractors were not updated at that time.
> 
> Add a data_len parameter to both functions, guard against an empty
> region before consuming the inner length byte, decrement the remaining
> count after consuming it, and clamp the copy length to what is actually
> available.  Update both call sites to pass ntf.activation_params_len,
> which is already validated against the skb at ntf.c:801.
> 
> Fixes: e8c0dacd9836 ("NFC: Update names and structs to NCI spec 1.0 d18")
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> Verification (NFC-A ISO-DEP, NFC_ATS_MAXSIZE = 20):
> 
>   data_len  inner_len  without patch              with patch
>   --------  ---------  -------------------------  --------------------
>   1         0          rats_res_len=0, clean       same
>   1         1          memcpy +1B OOB              clamped to 0, clean
>   1         20         memcpy +20B OOB  <-- PoC   clamped to 0, clean
>   2         2          memcpy +1B OOB              clamped to 1, clean
>   21        20         memcpy 20B clean            same
> 
> NFC-B (attrib_res, max 50) and NFC-DEP poll/listen (atr_res/atr_req,
> max 62) have the same shape and receive the same fix.
> 
>  net/nfc/nci/ntf.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

