Return-Path: <stable+bounces-223020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCoTJXj4p2l1nAAAu9opvQ
	(envelope-from <stable+bounces-223020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:16:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 310C81FD6BC
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 10:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8736130EF7F9
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 09:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453939184B;
	Wed,  4 Mar 2026 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YhLLzj7j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DCF372B41;
	Wed,  4 Mar 2026 09:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615394; cv=none; b=ibMEk80kwP59FnLH95/apQL9fEmDADWMKdhZ72AaFXwrK5GMJm/RnIz/k3HHqAOlupwOsqFuj5nCpoAGbNM3gSXiB0NWU7kG4vGE3aVBmwvl1nqai/17fTeq2bqDZ4dKOG143PcC8XSumxlC48xz5vdSVKziY2pWDfbg0Q74ZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615394; c=relaxed/simple;
	bh=fZAY9GXUfd6KhFkGYFrLa191k2VxXA1qbEeATN+njhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ro0rIjLzJ6VI9YVUHmsTIA2L2dmr6mry0a8BPRRImFWu120PV0EKvV0BtIiEjt1MUF7an4rsarsyK7eK0DyyFGO4z4REL7qPV7nYPBwgvB4a5AcDJzDEzVKgjaA2lh+p1eOrcniKI0nxXz+Sv1lIS9xpkwuA7bTn8BeQhsQmTXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YhLLzj7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F17CC19423;
	Wed,  4 Mar 2026 09:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772615393;
	bh=fZAY9GXUfd6KhFkGYFrLa191k2VxXA1qbEeATN+njhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YhLLzj7jVWtpWhVCxNAuQM4J+G0DYsFPfwsOb5VB1AGy15FE5a/ZTlEb8iZ9fNPk8
	 DLiBcbqSxEVIgwF2vc2yZOUkZXFDOdCWkanO/lvecJTi45J1nxpNECXEhb4Q172l8j
	 ETTpfdn63wwu/vXYJdLjeFEtgRyLTo0C351HaER0=
Date: Wed, 4 Mar 2026 10:09:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jaskaran Singh <jsingh@cloudlinux.com>
Cc: stable@vger.kernel.org, james.smart@broadcom.com, kbusch@kernel.org,
	axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.10.y 0/2] Fix incorrect backport of nvme-fc ioerr_work
 cancel_work_sync()
Message-ID: <2026030410-unpaid-operation-bddc@gregkh>
References: <20260223172241.291649-1-jsingh@cloudlinux.com>
 <CAJyTHZzRBH+MuBxJOW7CGiKLyt3DisvwYvmH9_=EQfD1srf+1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJyTHZzRBH+MuBxJOW7CGiKLyt3DisvwYvmH9_=EQfD1srf+1w@mail.gmail.com>
X-Rspamd-Queue-Id: 310C81FD6BC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-223020-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 03, 2026 at 11:16:34AM +0530, Jaskaran Singh wrote:
> Gentle ping.

It's been just over 1 week, please relax, we are staring down loads of
submissions at the moment...

