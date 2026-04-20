Return-Path: <stable+bounces-238731-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPqzHJj15Wl+pgEAu9opvQ
	(envelope-from <stable+bounces-238731-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:44:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D44428FB7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 11:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 843463014127
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A338F923;
	Mon, 20 Apr 2026 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="On12/JsX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7E38B7DD;
	Mon, 20 Apr 2026 09:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678267; cv=none; b=ptj+yes35WYJh6ftamib2ZbTzjjXgRRjwb/CXM04wBX9uR8dJEnJXk99W4XF5E3SqYsKG4B96lljHdVUrI4MJfvys8Ge+ZFD4bS3mrYm8o81WjSkRgG1SO4QizXoYLsfXsDMymy4hVuBn6KBg3oJdZkoY8H+pNw0ANUi73fTR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678267; c=relaxed/simple;
	bh=orVQQAkokr/ZgckLno97Wt1TCs0NqYT9zlpZ/LTDeX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O53314ylNLKCTEYfKePS47yw/hFgKkfpAMqhQH5CHaE1perZRlSOEDAr4LrUgKVtrDtUz+mMEm+DOlsnXETQByvLrFprQacXL6z9uzh62VSBib3LD6UjrPBcFZDbDHYaeuMSbQjWPy0BpQfxyGC/jQkVPexht9ODAfWhaF7AikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=On12/JsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F6FC19425;
	Mon, 20 Apr 2026 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776678267;
	bh=orVQQAkokr/ZgckLno97Wt1TCs0NqYT9zlpZ/LTDeX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On12/JsX+i3fpguYVx+6aKWBA0+2Scgbv6LSEOxAV+u2KOK1nNpbXBsMoySfGYkvj
	 CPuuFEe3gLujpHyyHjFkL5v+2gImBBbvR5ri2bfaogKzIIM/zaH+Z/Fa4hX3OtM0Yj
	 LXhC4vzROD0sD1jJuTMJB1fp64nZV7y3YkOI/bGk=
Date: Mon, 20 Apr 2026 11:44:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Tyrel Datwyler <tyreld@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries/papr-hvpipe: fix NULL dereference in
 handle creation
Message-ID: <2026042009-lesser-refrain-c154@gregkh>
References: <20260420093856.123681-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420093856.123681-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238731-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1D44428FB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 05:38:56PM +0800, Guangshuo Li wrote:
> papr_hvpipe_dev_create_handle() transfers ownership of src_info with
> retain_and_null_ptr(src_info) after anon_inode_getfile() succeeds.
> However, retain_and_null_ptr() clears src_info immediately, and the
> function then still dereferences src_info in the subsequent list_add().
> 
> Store the transferred pointer in a separate variable and use that for
> the list insertion.
> 
> Manually identified during code review.
> 
> Fixes: 6d3789d347a7af5c4b0b2da3af47b8d9da607ab2 ("papr-hvpipe: convert papr_hvpipe_dev_create_handle() to FD_PREPARE()")

Please use the proper notation here, as the documentation asks you to.

thanks,

greg k-h

