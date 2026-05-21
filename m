Return-Path: <stable+bounces-253592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAXyLqUtD2oiHgYAu9opvQ
	(envelope-from <stable+bounces-253592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:07:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B38B5A8E12
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 18:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0BD731F61DA
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0676302149;
	Thu, 21 May 2026 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0A0wY6vU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B31A25B0BF;
	Thu, 21 May 2026 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779375298; cv=none; b=cmGZt50ITYoxPYpxQzolOk+m044nyt3F61tQLyEvA60X4YazD4bO5jfm+xKmta0MJ75ZVEigyK9DcayfshxGIIiVmozv6kWqvh1QNAZUhH63BeQFpXp0nhaDG6lYN/fXeUzlrrA1Lqkx9yR+LF9272fAl0C6x50/Xd2a7iPLEJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779375298; c=relaxed/simple;
	bh=QlWgbW3pFkcQOj/PL0k5HaPpVqTox669Nkqx9Y+XxFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpaZxLEOf6Npz/87aeFf4/MlmCSOdkuk0heKtG/sihMmuWjl5fx/I1GQw6hdzXrRbnL4cPo5WJPnRjliH1OWsJVk34KKG3nDp8rxcRgPbtR1FOMQcLiBQbcj0z/1KrohA2s54WD120mVeFB4JnEKEJR7Yj7QAs2eqhfQ/jNtzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0A0wY6vU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90ECB1F00A3B;
	Thu, 21 May 2026 14:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779375297;
	bh=HEx9DxUrs/iGvi6fLWKnJs3KTeqse2/9ksgs21gAPiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0A0wY6vUoCQBaK1MBaj4vfBaRpn7/1jH98WpdoDu+KleussBcYjxP/hUH6RwRQQDb
	 HR/EVzLAqbsBMYmPQ20WGlxwg1H6iFJU8dbJqn2gpoRQguLqMIQgQ6f9uZISNPBsBi
	 Nhq2+aTVgtFzp/LOr+pbfnexZk4YVhK6juPgbtwg=
Date: Thu, 21 May 2026 16:55:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: oneukum@suse.com, carvsdriver@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC] USB: cdc-acm: Fix bit overlap and move quirk
 definitions to header
Message-ID: <2026052144-unwritten-washing-df27@gregkh>
References: <20260506093213.1473262-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506093213.1473262-1-guanwentao@uniontech.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253592-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1B38B5A8E12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 06, 2026 at 05:32:13PM +0800, Wentao Guan wrote:
> The VENDOR_CLASS_DATA_IFACE and ALWAYS_POLL_CTRL quirk flags added in
> commit f58752ebcb35 ("USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10
> INGENIC touchscreen") were placed inside the acm_ctrl_msg() function
> rather than in the header with the other quirk flags.  Then, their
> values (BIT(9) and BIT(10)) collided with NO_UNION_12 which is already
> BIT(9).
> 
> Move the definitions to drivers/usb/class/cdc-acm.h where they belong
> and shift them to BIT(10) and BIT(11) to avoid the overlap.
> 
> Fixes: f58752ebcb35 ("USB: cdc-acm: Add quirks for Yoga Book 9 14IAH10 INGENIC touchscreen")
> Cc: stable@vger.kernel.org

Why is this needed for stable?  What bug does this "fix"?

thanks,

greg k-h

