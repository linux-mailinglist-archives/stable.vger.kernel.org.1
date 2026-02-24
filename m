Return-Path: <stable+bounces-217924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIy0Gv3NnWn4SAQAu9opvQ
	(envelope-from <stable+bounces-217924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 17:12:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 529051899F3
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 17:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7150E303AA8F
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 16:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91953A7845;
	Tue, 24 Feb 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmxnEmZp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9CF3806B8;
	Tue, 24 Feb 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949560; cv=none; b=m841RuiKYULhHPc6E+7SgPlDdb6NM01jiN08h/QghpbPgGXpkiSgGVIG2ND+QvDCZ3DdIU9llMcMfTR3XueHpziH5Ztd8Y6ds/7VaTjqlHc4Dp3Doh18JyJLgLGs16YabO9UY2pdL4jnFqznTiw9tanl5oGzt+PDfnhq2DN6X0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949560; c=relaxed/simple;
	bh=5E0qT8mDGaw2I+EpER6p5r5QiqwYmfMaK2tnZ5m34mk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iV7mnNNmK1Jgvx29LElBIdV4ho5AFhJK+hWIAC/IMyWVz4mAiG95MnQgGJ1IUzxro2C/9NjZTHv2XSGqsWpreH0L6u5OytiVhV+HIT3KHE9ZR8JJb3aI2QZJYVTZxRLCW/MP6kWHTIOnLcJlDrO9qshWQm1q97wqu5qeaF6RXOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmxnEmZp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63E2C116D0;
	Tue, 24 Feb 2026 16:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771949560;
	bh=5E0qT8mDGaw2I+EpER6p5r5QiqwYmfMaK2tnZ5m34mk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=NmxnEmZpsr7UbZ6DjMLih5uSxezCzyRPBQW+nZgj85AGoG1/KuYj59d1esgvsO2gn
	 1ayFQKWXt1YpJGILrmQP7F2Tg8evgiiyYl0h/JYA7L+bG6EPJP0xaNkMBvnUzwEd1w
	 xzWI7ffsnn5ZfwiFPtEWwkF0aLEcZx6J/7Ng+WNLiUFLDkQjH+srDnD2/xfLB3HntU
	 Sa4vwkK+C7+n8y6lcVNAADF+QdGBxZrzdUuGq+U68HoaGSAy2OEoqXPTh14ZmWXoQf
	 6Xj01ez9Wu16vqT9xjALHhCpgcdDjGIxWTigYVErTfQdUMXhr8GQ+Ncwp6POXIXosW
	 Ywvn3pMsS8LrA==
Date: Tue, 24 Feb 2026 17:12:37 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Benjamin Tissoires <bentiss@kernel.org>
cc: Lee Jones <lee@kernel.org>, David Rheinsberg <david@readahead.eu>, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
In-Reply-To: <aZ3IKiL91Ya7_iIM@plouf>
Message-ID: <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>
References: <20260211164025.171242-1-lee@kernel.org> <aZmsTQeeGf26FqvY@plouf> <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet> <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet> <aZ3IKiL91Ya7_iIM@plouf>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217924-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 529051899F3
X-Rspamd-Action: no action

On Tue, 24 Feb 2026, Benjamin Tissoires wrote:

> Long story short: that patch is too intrusive as it makes assumption on
> the behavior of the device. We need to understand where/if the bug was
> spotted and fix the caller of hid_hw_raw_request, not the uhid
> implementation.

Thanks a lot for the analysis, Benjamin!

I asked about that here:

	https://lore.kernel.org/all/172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet/

So let's wait for Lee to clarify. Until that, the patch stays out of the 
branch.

Thanks,

-- 
Jiri Kosina
SUSE Labs


