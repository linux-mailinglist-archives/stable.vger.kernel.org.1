Return-Path: <stable+bounces-223835-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePljKl7jr2nkdAIAu9opvQ
	(envelope-from <stable+bounces-223835-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:24:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A66C224853B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 10:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA9CE3008635
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 09:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BF143CEFC;
	Tue, 10 Mar 2026 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJa2q8qX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB142438FE7;
	Tue, 10 Mar 2026 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134512; cv=none; b=NDZ9O/vqwjQ1DDMJItumYSMVMi8CvJZDxmZ55C3uGTuCt/W3AGbohx6NHIs86I2ERYJkOFqcUdD6LpERrZAz70K9Jgs6b07HEj7NnG8TeqYs33T2LO5/jc7NprU+ojzCC4+dLuCwsMFsvEcM2NvDwi8cpgsY5wDL1HkrJItsJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134512; c=relaxed/simple;
	bh=TjT1+p6v6zuaY5OcYbGBI4btNS2kNeaW6BC56ljUlpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzC+9Wa2wd8SRxs/mL7BqrA0WMirJqjNr3bnvhbTYvv7LB3Gz/C1rWu5czTUPTAaPyWnGmrkbhDpWiKipc06RN1JAIJrmyOWmJsFv+duzDOzH7Qa4I5uQE3efVaos6kmC4L1wydiQMpemLhUNSw1m+SEFA5MjEccnBAZBe3v8SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJa2q8qX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD1BC19423;
	Tue, 10 Mar 2026 09:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773134512;
	bh=TjT1+p6v6zuaY5OcYbGBI4btNS2kNeaW6BC56ljUlpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJa2q8qXewxeJj/xp8qMuM1Lal9Lkjd7sU80xdLA9aa50lMijmiX6Wdf7kRghNE20
	 5ldRTFzAQ6FP9KqGUJ5ld/lDJfMNJNMmeqwKW9gWNSua/eUJoDIzt5YOcO2xqKqYt6
	 gI7Qrdl7Da2v4HTPWb6mU/AjP2asLKPM7M2nSspUf1VznVK1I1nWfmWVt6n5dfVja7
	 BEnentzhqvjB78LWflL/Kt5iMs0ACziEvr/AHIfPJnMKmk6Zml6tqgFcjb1cQWL9An
	 VPeQthgmHyA0zJLydvUkaG+62vbUESXDkOPouz3MXmBZ4HPWZY4cv0MMKx/8+zrNC0
	 eM2jOYF48hcnw==
Date: Tue, 10 Mar 2026 09:21:48 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Brian Mak <makb@juniper.net>, Herve Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mfd: core: Preserve OF node when ACPI handle is
 present
Message-ID: <20260310092148.GE183676@google.com>
References: <20260226224511.458065-1-makb@juniper.net>
 <20260306133806.GM183676@google.com>
 <aarmKE49wgbIblRb@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aarmKE49wgbIblRb@ashevche-desk.local>
X-Rspamd-Queue-Id: A66C224853B
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
	TAGGED_FROM(0.00)[bounces-223835-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 06 Mar 2026, Andy Shevchenko wrote:

> On Fri, Mar 06, 2026 at 01:38:06PM +0000, Lee Jones wrote:
> > On Thu, 26 Feb 2026, Brian Mak wrote:
> 
> ...
> 
> > > +	/*
> > > +	 * FIXME: The fwnode design doesn't allow proper stacking/sharing. This
> > 
> > So when will this be fixed exactly?
> 
> I don't know, it's a huge task that requires of redesigning how struct
> fwnode_handle looks like and how it cohabits with struct device. Do you
> you think that NOTE will be more appropriate, because it may span several
> releases.

If someone is going to do the work sometime in the near future, it can
stay as FIXME.  A few releases isn't going to offend anyone.  However,
if we're just going to sit on it and this is likely to be here for an
elongated period, it should be changed.

Any idea who is planning on working on it?

-- 
Lee Jones [李琼斯]

