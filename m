Return-Path: <stable+bounces-243848-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qG7WF/qz+GmWzAIAu9opvQ
	(envelope-from <stable+bounces-243848-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:58:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4134C0447
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D061130459C4
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309893E0220;
	Mon,  4 May 2026 14:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XW2rsONK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E03DF011;
	Mon,  4 May 2026 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906573; cv=none; b=cx2plBXnM1nDj4ejoEIrHCLwtQo3GZPCFHP8M59YXbdK17JpE+vgO5AgOSMsMd5sKCdnj4FpN8RVC+X/kMEWO4gxFtNsVO1TadSZCtXhnNBU2YLTiKYEULfVJ88o8SDv8zJe3RWU/JozivTyxVSDuPVcmHT+tYIbZTcwcIANL7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906573; c=relaxed/simple;
	bh=6Ran1wl6jjk1U4QW+1lEUi34u91hdseej9fzZ7JFpEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=livX+KGsnJbzqh84vFvZeUSbVg8qSwiaCnMh4fiQT8Mn67Q6kLLua3G+tkUxpdlRl2YrNoHNIZ2IxkqgnCi8aX/tFT0qV+pBa1hYnPRA1OG4cBOnnrIWcC5mHTciiu58nS9/zxa8gaEH8cHRDj2ZdbMTggZuTdD5mi+VPo8Ly3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XW2rsONK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BCFC2BCC4;
	Mon,  4 May 2026 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777906572;
	bh=6Ran1wl6jjk1U4QW+1lEUi34u91hdseej9fzZ7JFpEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XW2rsONKDQ8O4ObwagF0c1yaVmOV9AkyGY/WDqWbphlr3E6XysSuTHuMz+tn5rLhq
	 IOEh9gbIYrGBZubDUpteOHeG6+5M5/OEuhqYoWjQy8qb7CWTi3IOcrX59cpl4xEwDM
	 K1jeFWnEJHeVR36dG+SDJbl9mwp+SyPO7xsQsRq8=
Date: Mon, 4 May 2026 16:12:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Feng Ning <feng@innora.ai>
Cc: linux-staging@lists.linux.dev, Luka Gejak <luka.gejak@linux.dev>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6] staging: rtl8723bs: fix heap buffer overflow in
 cfg80211_rtw_add_key()
Message-ID: <2026050417-monkhood-backless-4c3e@gregkh>
References: <20260413113224.5201-1-feng@innora.ai>
 <2026042626-tabloid-suitor-33c5@gregkh>
 <20260427111738.33069-1-feng@innora.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427111738.33069-1-feng@innora.ai>
X-Rspamd-Queue-Id: EF4134C0447
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243848-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,sashiko.dev:url,innora.ai:email]

On Mon, Apr 27, 2026 at 11:17:45AM +0000, Feng Ning wrote:
> The cfg80211 framework allows userspace to specify a key sequence
> counter (NL80211_KEY_SEQ) of up to 16 bytes via NL80211_CMD_NEW_KEY
> netlink messages, but ieee_param.crypt.seq is a fixed 8-byte buffer.
> When cfg80211_rtw_add_key() copies the sequence counter via memcpy()
> without checking seq_len, a heap buffer overflow of up to 8 bytes
> occurs, overwriting bytes following seq within the same ieee_param
> structure (key_len and the trailing key[] flexible array).
> 
> Cap the copy length at the buffer size using min_t().
> 
> Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Feng Ning <feng@innora.ai>
> ---

What about these review comments:
	https://sashiko.dev/#/patchset/20260427111738.33069-1-feng@innora.ai

Are they incorrect?

And was this tested on real hardware?

thanks,

greg k-h

