Return-Path: <stable+bounces-214797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EqTHCtYh2k7XAQAu9opvQ
	(envelope-from <stable+bounces-214797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:20:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F4106597
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8B1A3004904
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F191C3542C9;
	Sat,  7 Feb 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fpAsRXY1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574A353EFC
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770477606; cv=none; b=AJdkJjnyXW7ojadHXCOJ/g6+VrCmy5cO4VVAeUubNHKRSsbpjhemV31H79z9BI+si9XYv7qfKMAlm0jfg64OZuQyk2/I6TdYtUFXVHYtFcsPmlESKVJ3CDrEIWVgDpuJx5HNZL6jjwX28rTyb4FaoiitKBhXgaFF+YeBIDBnT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770477606; c=relaxed/simple;
	bh=HLYa3bR2tSJY7gYFYH4dnDdR19fb/P3rdmm6PLjWmMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONjSz5rbMbD4ZkTTWmLkeT9rpT+QTVlEjLRSyjgTKHyrvXX1a9lSt9NqnIkQtopVCmVj3yK7VDkCrF80GC9K6jVQJVxXPPhtgZA2QJiS/+Tq5EKUvFVLbph9YzBNNIdgEi/KhNdbaPcYlICXWGz0aMZ4mryxVB1Iy7W9iTSpiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fpAsRXY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DB9C116D0;
	Sat,  7 Feb 2026 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770477606;
	bh=HLYa3bR2tSJY7gYFYH4dnDdR19fb/P3rdmm6PLjWmMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpAsRXY1XbjWbnsMQu19nGubDktnaQVvvdz7hBtDmu++haSmSM9hwjIyc7hePUbC+
	 DC6pyDg6CIAzhy5vZJlKZ2vCllIMQNQeWhRqif3220+Oaic5OHe7yGlr23oGTi5IIe
	 nQSCwCJFmC/F8JyP4zJ6UXqomZUtV0eOthXBr10k=
Date: Sat, 7 Feb 2026 16:20:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Kovacs, Alexander" <Alexander.Kovacs@amd.com>,
	"Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>
Subject: Re: [6.18.y] Fixes for USB4/NVME hotplugging
Message-ID: <2026020755-stuck-rinse-89ff@gregkh>
References: <48e48a86-f88a-49e3-a9a0-29f8f43175cf@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48e48a86-f88a-49e3-a9a0-29f8f43175cf@amd.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214797-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 081F4106597
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 02:06:15PM -0600, Mario Limonciello wrote:
> Hi,
> 
> Some of my colleagues (on CC) have been chasing an issue where some
> percentage of the time USB4 NVME enclosures weren't working properly on
> hotplug.  They narrowed down the PCIe traces and found that it was caused by
> a race condition between multiple drivers shortly after link training.
> 
> This issue traces back a while, they reproduced it as far back as 6.14, but
> that's mostly because the hardware it was first reproduced on had graphics
> enabled in 6.14.  Given the root cause, I strongly hardware enabled with
> earlier kernels would also reproduce it.  Nonetheless the issue has actually
> already been fixed though by a series that went into 6.19.
> 
> commit a2f1e22390ac ("PCI/ERR: Ensure error recoverability at all times")
> commit 383d89699c50 ("treewide: Drop pci_save_state() after
> pci_restore_state()")
> 
> Can we bring this back to 6.18.y too?
> 
> If any questions about the methodology or details, they can add more.

Now queued up, thanks.

greg k-h

