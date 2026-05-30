Return-Path: <stable+bounces-256867-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI+WG468Gmqq7wgAu9opvQ
	(envelope-from <stable+bounces-256867-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 12:31:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D676960C1F5
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 12:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17545304995A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677B374722;
	Sat, 30 May 2026 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tkJl43J6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F491A0B15;
	Sat, 30 May 2026 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780137030; cv=none; b=lKkaKuDmXpXo0ffgUwixW+oCCY1q72trg7ry5ekxfCsA/wbADBnV5aOKn06RyrdfaY6iCpodmT3CNtwkRjZiCuHFZ4SyyCXqLugnm5Vr4ZvxyuYpTAKpqMe75QN7g9y/vO87y1TDrwFqgn0WK/UIKkgS6uPaONmYh0i72LLxCog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780137030; c=relaxed/simple;
	bh=NwNvM42/n4zB9cab+HVq7KTKcoLj4KX8MUmltLuhme0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsRGX+BcHm5hFuxPmLeabXsxxwHPHcfEzGLiADFWnsLrjP1loo1v0rvXsq4D2+p4FMYfor7O2q3oW5YAQ11FhS9wQTZn96G9TNEOT4y7iMRPNXqe1g+8tZGkB/HhJT/Qhc2y3QNTytWLVBBN03ZA5t9frSNBr5Vrveau0OG/yjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tkJl43J6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602691F00893;
	Sat, 30 May 2026 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780137029;
	bh=sExTVAQNfp+Wvo2s9CnxcQhquuzTS07EAHg0HbugqnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=tkJl43J6KN7al+GZVz/U4pTfTdL5xtk3o4WUFibEJRWxc+kieSeSr02EMAEaiOCzP
	 j6s8d1BNTmkohPyhixTwWp0GV6lWwhYkHnHWXZfruSscfYe1+67MTrX/N+p8MosUNQ
	 DA/n5BBcVQgptN0aBu/mdckR3qmzFvxKpddqv9j8=
Date: Sat, 30 May 2026 12:29:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dominik Karol =?utf-8?Q?Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: Mark Brown <broonie@kernel.org>, Hongling Zeng <zhongling0719@126.com>,
	Hongling Zeng <zenghongling@kylinos.cn>,
	"linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Introduced double release_region in gpib/cb7210
Message-ID: <2026053027-follow-hurried-162b@gregkh>
References: <PpNUbGhrvT8I_KayoDvQYI2PYjmMw1QEkuVBDZz2PwBsVVgPkBXJarc2mBM0IhiH3AQG0GtgqEsDRXNj3yUKEDBaZa25u73pAjvcE6vfRsg=@protonmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PpNUbGhrvT8I_KayoDvQYI2PYjmMw1QEkuVBDZz2PwBsVVgPkBXJarc2mBM0IhiH3AQG0GtgqEsDRXNj3yUKEDBaZa25u73pAjvcE6vfRsg=@protonmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256867-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[protonmail.com];
	FREEMAIL_CC(0.00)[kernel.org,126.com,kylinos.cn,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: D676960C1F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 07:23:14PM +0000, Dominik Karol Piątkowski wrote:
> Hi,
> 
> There are currently two patches [1][2] called:
> 
> gpib: cb7210: Fix region leak when request_irq fails
> 
> in linux-next that came from char-misc-next. Patch [1] introduces double 
> release_region (if cb_isa_attach fails, cb_isa_detach is called and it already
> takes care of cleanup) and patch [2] introduces release_region on region we
> never obtained.
> 
> cb_isa_attach is set as attach and cb_isa_detach is set as detach in
> cb_isa_(un)accel_interface and cb_isa_interface. The only place where I see
> attach is called, is in common/iblib.c, in ibonline function. If attach fails
> there, detach is called, where a proper cleanup is performed (and it includes
> things like nec7210_board_reset for cb7120). AFAIK, the same approach is used
> for the rest of gpib.
> 
> Please revert these patches.
> 
> Additionally, patch [2] was cc'd to stable@vger.kernel.org - hence adding it
> to cc for this email as well.
> 
> Thanks,
> Dominik Karol
> 
> 
> [1] https://patch.msgid.link/20260503093036.283546-1-zenghongling@kylinos.cn
> [2] https://patch.msgid.link/20260518022939.16881-1-zenghongling@kylinos.cn
> 

Now reverted

