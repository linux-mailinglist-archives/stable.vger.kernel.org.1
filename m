Return-Path: <stable+bounces-245190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNPtFj7QAWryjwEAu9opvQ
	(envelope-from <stable+bounces-245190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:49:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B650E31B
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFD10310827F
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEDD3E4C62;
	Mon, 11 May 2026 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sBLTXXxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249139E190;
	Mon, 11 May 2026 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502599; cv=none; b=nIMp8FAUQZJldC0Ka9t8xD74mG/crDuOpq7+J/RDZouih7FDt7CQgdl/w5caC6EleJ5SK8UrZKCHWl+sj0dPumJz8j2RJ06pxEUmQrDeN5/wlY75NAmGCGAn4uTSedYKMul+AXqImTrmGqN13XpCoADjo1dfpsJQb0ELLSY5Je4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502599; c=relaxed/simple;
	bh=AdlorSgCtBmPOONlp4nH3YbTIzcJ+kTT+g17vanKSac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqV8pZrUSoWuGS+4jf7/BWR66MhebFn15EhwqslgQk9q3AdPmae589v/5rxRPvZNKHRDNAONPYejdq42cL/AMZYOy1km9+gCT8km4q3AQuSAcaLM2r90bGjCJkJekTPUEYidgKVqqCUCDzp+7VxJ4sZ7Uu6lUksGFi1ZwSeFNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sBLTXXxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADB6C2BCB0;
	Mon, 11 May 2026 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778502599;
	bh=AdlorSgCtBmPOONlp4nH3YbTIzcJ+kTT+g17vanKSac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBLTXXxUSYw32gXPcb8gw07SQ9sncPOEkpEo2gMCImBngMjrP2qXbOd+9eFdd6URn
	 2jSfQ4c2UDiNkMjsTqDoZ79gGXK0LwhmBNi5/BNacaiEUcthXwn936PpuYjuCUL3dy
	 9RZKBiAbu258cAg0u+k2z1lejTwjOhAK88pLR+yg=
Date: Mon, 11 May 2026 14:29:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: vipoll <vipoll@mainlining.org>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: fsa4480: Add chip id read retry loop
Message-ID: <2026051145-comic-collision-4797@gregkh>
References: <20260511122246.31673-1-vipoll@mainlining.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511122246.31673-1-vipoll@mainlining.org>
X-Rspamd-Queue-Id: E06B650E31B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245190-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,mainlining.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:22:46PM +0400, vipoll wrote:
> From: Victor Paul <vipoll@mainlining.org>
> 
> The first read attempt may fail on some devices (e.g. Xiaomi Pad 6)
> 
> Cc: stable@vger.kernel.org

What commit id does this fix?

thanks,

greg k-h

