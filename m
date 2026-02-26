Return-Path: <stable+bounces-219792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLBEIoQsoGmLfwQAu9opvQ
	(envelope-from <stable+bounces-219792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:20:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DEA1A4FA1
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 082FA305336D
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8089D364E8D;
	Thu, 26 Feb 2026 11:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMaNvHRq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD44F3624A5;
	Thu, 26 Feb 2026 11:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104701; cv=none; b=m8e4seDoQPIL/aa0tR6++OfbaF6Zx8wIN6Dxon09DTOZfNdSv7NMqU+YvcS2Sj2lNQV9vEgiHnSPeDiPG7kCiG0VAsOyquuZKGsbyOf1jNORrcLW0ji2r88fUjWoj4OTqgPGNTgeSU6XOag8l3lRxOQFA81zM9bcNUfAN4EXNhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104701; c=relaxed/simple;
	bh=IkuCNROmTgo+spkIEdT15GSdhabkpsrR4l8+6f+wIgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVvNtazNFxyksdOsDNh47V/SumlXlP4mayyh7+HhfEKdAcknBzmNAXwoAN1gUZA8Ry31aYA/aIZuszQXZPHvy9iyf3KJSaIEVlLEGOBt0WboigVZ9QBE9Pxmjez/DuigyZPYV7MPa2R8NleUTrARFoAfEXkogTAKQRQrsTMJImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMaNvHRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D14C19422;
	Thu, 26 Feb 2026 11:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772104701;
	bh=IkuCNROmTgo+spkIEdT15GSdhabkpsrR4l8+6f+wIgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LMaNvHRqh5R8mK4CXT7lHEv86FIBuUGq10+zVmwG11V3hp2O1TvcLWgyQ2kBnZVAM
	 MiSAuAeagkYtiLCdEV6I2oTpoavUzGTrfEu4KO0XU6M0EXI8EzaScQfbHHJfRhyfxa
	 BskTCxtfwJbKVyuUa1iGg+VxP8tBPGa1f8u1lMfmFLTRV66hWRvqM+IwbjwPnhukN3
	 RDqpzX5t4hk1g4o/E5V+T12H3YGk5h5huHnS46hCtkDHthoxpdEOf84cjLnMrsx0/l
	 /q8E8K5io8JylkaNsyNtGkVMJGgvLlqwTNxgtOm+XZBqsvTzPISg3x+ec7aM34FwrH
	 Z0BotpLUo9ntw==
Date: Thu, 26 Feb 2026 11:18:16 +0000
From: Lee Jones <lee@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>,
	David Rheinsberg <david@readahead.eu>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: uhid: Fix out-of-bounds write caused by raw
 events mismanagement
Message-ID: <20260226111816.GA8023@google.com>
References: <20260211164025.171242-1-lee@kernel.org>
 <aZmsTQeeGf26FqvY@plouf>
 <172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet>
 <47ro00po-r74n-870q-q178-67s8rpsss12q@xreary.bet>
 <aZ3IKiL91Ya7_iIM@plouf>
 <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <r6574n79-563r-9rrp-0n92-784532r67o63@xreary.bet>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219792-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5DEA1A4FA1
X-Rspamd-Action: no action

On Tue, 24 Feb 2026, Jiri Kosina wrote:

> On Tue, 24 Feb 2026, Benjamin Tissoires wrote:
> 
> > Long story short: that patch is too intrusive as it makes assumption on
> > the behavior of the device. We need to understand where/if the bug was
> > spotted and fix the caller of hid_hw_raw_request, not the uhid
> > implementation.
> 
> Thanks a lot for the analysis, Benjamin!
> 
> I asked about that here:
> 
> 	https://lore.kernel.org/all/172q4775-616s-p7s4-7n80-p8579n0r3516@xreary.bet/
> 
> So let's wait for Lee to clarify. Until that, the patch stays out of the 
> branch.

Thanks to both of you for looking into this.  I appreciate your efforts.

This is very much real world.

Is there a way to add an errata for the PS3 controller?

-- 
Lee Jones [李琼斯]

