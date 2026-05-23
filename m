Return-Path: <stable+bounces-253885-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCgtOk4rEWqniAYAu9opvQ
	(envelope-from <stable+bounces-253885-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 06:21:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AE46F5BD1BE
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 06:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4020A3023E24
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 04:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68762F690F;
	Sat, 23 May 2026 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GuBoUoU+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F087B672
	for <stable@vger.kernel.org>; Sat, 23 May 2026 04:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779510074; cv=none; b=HPPSlkXeUbGMzkF5HYIJb2k9AdE/K2SwytfaAK4lQkmA/ZaXR4BGNAls3Yl/uq1jZZAaeVW97HbnHKkU1c7HLHLP8NJEX5UcXPEykBJSulJHxTqjLupaKqgOsIclwr/nPWa4WbNIM7FKXrbiN8M2KAjp9+S+7PV5DfuiesjmMJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779510074; c=relaxed/simple;
	bh=sP4hIdRybK3GwzJG3lV6J01HG4xGzYINJibZUnGFPD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3vqkb+gbb6U8wTJgrTMerAFnmkJVwSae9VwjfXDOCwLDxRPV6h7F+64aBUycXgqUPTQf7cMeuYHu5cGzxpkfntmSVHL97c9u+a7d/rvIWvsYkA9Iv80QBCYLfGlXx01tZ+QjFhIVxSxeqI19s7vueK3uROuuNdfDtl8qbLdv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GuBoUoU+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85EC41F000E9;
	Sat, 23 May 2026 04:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779510073;
	bh=WK+lvIJUVWz0x1GFZSdPtr+qxR3N7WKpcWE8VDHwwA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GuBoUoU+hARzfOqR7dsgXP8cCPH32s2IDXCxaTCaWlSGZoQF+HdIeI+NHxwZxYbrN
	 CsKTThL9gMDe2SuYy9Ds0yCnjEFAQmzKi0zstJ3eGRDwkZayx+pFBQPVB2Z7x8Elri
	 Ts5UBxeksFTEOKqaUNzRn594andNtMOOIu/ptJgI=
Date: Sat, 23 May 2026 06:21:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: stable <stable@vger.kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [6.6] net: skbuff: propagate shared-frag marker through
 frag-transfer helpers
Message-ID: <2026052357-viper-tipped-4ea9@gregkh>
References: <a785911d711bee40be215dad119f9922e014aead.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a785911d711bee40be215dad119f9922e014aead.camel@decadent.org.uk>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-253885-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AE46F5BD1BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 07:21:39PM +0200, Ben Hutchings wrote:
> Hi Greg,
> 
> I looked at the backport of commit 8f6a5356a33 queued for 6.6, and it's
> not quite right.  The change that is supposed to be applied at the end
> of skb_gro_receive_list() is wrongly being applied at the end of
> skb_gro_receive() in the backport.
> 
> In 6.6 the skb_gro_receive_list() function does exist and it seems like
> the same change should be applied, but the function is in
> net/ipv4/udp_offload.c and not net/core/gro.c.

Ick, ok, I'll go drop this, can you send a fixed up version instead?

thanks,

greg k-h

