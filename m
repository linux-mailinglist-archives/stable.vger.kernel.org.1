Return-Path: <stable+bounces-253739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHcQLsIsEGqSUgYAu9opvQ
	(envelope-from <stable+bounces-253739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:15:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF55C5B1D32
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F36F83006931
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463333C4B84;
	Fri, 22 May 2026 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsCM97v8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EAB3655D4;
	Fri, 22 May 2026 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779444618; cv=none; b=qJCUyDn7yZ167j+f1wTL6G+PAEEYop+X+NXzZpAgyVQauuqlsozGTN3F9efaSwleQsdTy8oCX7LoOJGgIZC4vBzcZoFJzU2C2PSXyMYmNDsNDOBnCzwAL7h5ksVHPHAcOQ57D6MVa5bFnZd8O5AdcDgZ44i9N4pIb3Vl62q0RVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779444618; c=relaxed/simple;
	bh=purigjzazC6iuoPtfxc6U7OhdHuddJAuH9JSqzVSMK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ni0NQzDXa1dnrLtUnOpSVRbe6FCvOZ2U7Zvo1LbC9gdJH+aoHe6yOJPY2k30QIc4gjw84B94u6ngjOo/3KAbpsl3JNmgzapfVunIcNirJXCwsnRXnswql7x7+rbDPrwEwpXxuwQTnjngGNlajj+dpXV6YNDvxYDJcrydpkeI1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsCM97v8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862AA1F000E9;
	Fri, 22 May 2026 10:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779444616;
	bh=vQG0R3E3WDtywVUhQWTHTtN5nopehZFRDjq3Xpq792E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OsCM97v83WdbIcx6psD7rf8HWnkXo28B6qM7NJL3iii41in5rRgeNlF0JO+bPZ8Qr
	 Xoc/VlSRrw4Y2Xbu0bXSbj5SCqeT5COUn+6PqN2E9fnIsxvpp9KmoBmsHpbkjLZ97R
	 s9J6AVgyqasXxwiRMLHziJwQlSpCmqNJH1m10njjumiIXDlN4t6TlBJZOdwf48qjoF
	 eHjoAFFVC6Cl2+62Eo5yWhb92/Ef1KtxMJRYFB6cddCc/AmCk7kyqDkviswNwrsGEX
	 VCNMXMGA5tFNVFkEDOygKP/b8bgKneKp4Ee2wMJrBz1LyfkYqW1WrnvY1wNbBh98eN
	 OmpJiovMWt/dA==
Date: Fri, 22 May 2026 12:10:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, thomas.weissschuh@linutronix.de, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Subject: Re: [PATCH] fs: Fix lock leak in replace_fd()
Message-ID: <20260522-anzetteln-bieten-blutwerte-9d3be56be53f@brauner>
References: <20260521074934.49256-1-zenghongling@kylinos.cn>
 <m3xus4s4xup32v7ijjolq6p3tlrj3bpwettldpqwxcwxanfvyt@5ihbtgch7liv>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <m3xus4s4xup32v7ijjolq6p3tlrj3bpwettldpqwxcwxanfvyt@5ihbtgch7liv>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253739-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kylinos.cn,zeniv.linux.org.uk,suse.cz,linutronix.de,vger.kernel.org,126.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BF55C5B1D32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 04:45:28PM +0200, Mateusz Guzik wrote:
> On Thu, May 21, 2026 at 03:49:34PM +0800, Hongling Zeng wrote:
> > In replace_fd(), the function acquires files->file_lock but then has
> > two return paths that don't release the lock:
> > - When do_dup2() fails (returns negative error)
> > - When do_dup2() succeeds (returns 0)
> > 
> > Both of these paths return directly without unlocking files->file_lock,
> > causing a lock leak and potential deadlock.
> > 
> > Fix this by making both error and success paths go through the
> > out_unlock label to ensure the lock is always released.
> 
> do_dup2 always releases the lock regardless of return value, so this
> patch cannot be correct.

I mean, also:

static int do_dup2(struct files_struct *files,
        struct file *file, unsigned fd, unsigned flags)
__releases(&files->file_lock)

it's literally in the annotation... and if that had been a bug it would
be very very noticable very very quickly...

