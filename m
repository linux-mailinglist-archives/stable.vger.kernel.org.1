Return-Path: <stable+bounces-242104-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wA2mLFVW82mLzgEAu9opvQ
	(envelope-from <stable+bounces-242104-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:17:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C74A34D5
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB4CF3001FBC
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD9A4218B7;
	Thu, 30 Apr 2026 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qAim7nMB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8764218A5;
	Thu, 30 Apr 2026 13:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554907; cv=none; b=TtEPIIam63lIJPXQGoKc+qcbGanKBAsR8pb0Y7BEKzKEmjPfw+uRYI8IxofEQFIwhVv+5aSsUM+HlV1rcC31wGxbj2ud46WG3WRQwC7vqnaJIAD/yDI10h/s63awlwVL7mg2i/MAGAJRdOpLzAqTisOzOwVYDLgkKXHy2LJ2DIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554907; c=relaxed/simple;
	bh=cPwaNAE8fIXZ9U/1et+TfgfkpMf3plBG2cZcKoz27uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DoAMSuVm82TKBcVPw33rLmd411plUFvYnbHvKCaY0PrSGzikFk2XYnTOvTfgXE+8E3LFeBdSdY16jGu8CmNJ18eGtMsVMKI7XgU/xPZ9B8d0ugmuOCYIyQBVvZqK0iYyBf5ce8dMT4l4vR3M1Mi+KU1XlSYwzTkoFfCA1vtltbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qAim7nMB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A438CC2BCB3;
	Thu, 30 Apr 2026 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777554907;
	bh=cPwaNAE8fIXZ9U/1et+TfgfkpMf3plBG2cZcKoz27uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAim7nMB+O6fEY83qZrRguk29F9Ii0qD8J9+Y0p2Yfk/V9NygUT4iig0Es87ioJTt
	 BJ+EhlT7GT2zI6N+kIMgX44tZYhIB7fEyKrjmP4PdWcrBxHIkQT3EoSxyIGp82OSRL
	 P32AFYPiGaZzdF6x4hXe8egsDfW0wjQ8/4UBC9P8=
Date: Thu, 30 Apr 2026 15:15:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luna Jernberg <droidbittin@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	stable@vger.kernel.org, lwn@lwn.net, jslaby@suse.cz
Subject: Re: Linux 7.0.3
Message-ID: <2026043052-deflector-dodgy-93a6@gregkh>
References: <2026043052-coasting-tinwork-27b5@gregkh>
 <CADo9pHjPzxmHNd8MAeWH=CCuVazxpb3OxdasEcUxoarvLwKzZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADo9pHjPzxmHNd8MAeWH=CCuVazxpb3OxdasEcUxoarvLwKzZg@mail.gmail.com>
X-Rspamd-Queue-Id: BE5C74A34D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242104-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[copy.fail:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]

On Thu, Apr 30, 2026 at 03:09:05PM +0200, Luna Jernberg wrote:
> Hey!
> 
> Works fine
> 
> patching: https://copy.fail/ next ? ;)

That was fixed a while ago in older kernel releases that you should
already be running :)

thanks,

greg k-h

