Return-Path: <stable+bounces-246917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CawLUqbBGr3LwIAu9opvQ
	(envelope-from <stable+bounces-246917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:39:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB475364FD
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 17:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98094300B5BE
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5A43BB110;
	Wed, 13 May 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DjHfLfOB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F5B33469C
	for <stable@vger.kernel.org>; Wed, 13 May 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686334; cv=none; b=MHqHT3PbksRlqA0jhMiSUvjaCmEzHqvz3DzvPyK7PCs0ji9ItG761gqdDGRittsHwG1LPM2Ri6IJmkoajPVMlGkwYlm6u0fz5qGJeuJ7TIOKe0Qi7irCncNolxzOjZtSDGideVS2SfTsyjysPDJTY/86rqjopEM08L3xGGGNCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686334; c=relaxed/simple;
	bh=MWLrwkMxzHYzL+dNIJFzK/jYmwFKgXCt+GOa1sxnVfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeJljvHzdQDbQlyZYGkCzGWZvbyT2GD0kXy63zH3pcboLUiLE7Ibs4zCgne7kOcOyzFpC0UYN/cA1EKL0bCeubERvaywqoGv5P68Tr2ydnSNMg95vTdo3g8K+KuAJxXCwm5twxrp/R4KHcWOIZg0ujmXy8ZBVgbeuLYhCDtNd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DjHfLfOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A6CC19425;
	Wed, 13 May 2026 15:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778686334;
	bh=MWLrwkMxzHYzL+dNIJFzK/jYmwFKgXCt+GOa1sxnVfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DjHfLfOBA2pt+5MD5QQbLJC6eKsktaK5nvZYY4A9COpK5L8aNuHRCuCJqspocaF7u
	 ksdIM9xIYMPO6Z2sfUdMFvEFJBcVhA61W5pOH3yIE2iVv8JFFX2vT6dyNWnyEPIRbS
	 yaUlWBpbEKYfhyUSI1A0UdjWzMml+Pbbs5+DiQEY=
Date: Wed, 13 May 2026 17:32:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: stable@vger.kernel.org, manish1@arista.com
Subject: Re: Please backport b8e753128ed074 (exit: Sleep at TASK_IDLE when
 waiting for application core dump) to < 6.12
Message-ID: <2026051303-derby-oversweet-263d@gregkh>
References: <35e9c59e-6e54-4683-9751-175d425fbc37@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35e9c59e-6e54-4683-9751-175d425fbc37@molgen.mpg.de>
X-Rspamd-Queue-Id: 5DB475364FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246917-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 03:24:28PM +0200, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> I am forwarding a backport request from SONiC Linux kernel [1]. It’d be
> great if you could apply commit b8e753128ed074fcb48e9ceded940752f6b1c19f [2]
> to Linux 6.1 and older.
> 
> > On Linux 6.1, coredump_task_exit() parks sibling threads in
> > TASK_UNINTERRUPTIBLE|TASK_FREEZABLE while one thread of the group
> > writes the core file. Under sustained memory pressure the dump can
> > take longer than kernel.hung_task_timeout_secs, at which point
> > khungtaskd flags the parked siblings and (with hung_task_panic=1)
> > panics the box.
> > 
> > Backport mainline v6.12 commit b8e753128ed0 ("exit: Sleep at
> > TASK_IDLE when waiting for application core dump") which switches
> > that wait to TASK_IDLE|TASK_FREEZABLE so the watchdog skips it.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://github.com/sonic-net/sonic-linux-kernel/pull/575/
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b8e753128ed074fcb48e9ceded940752f6b1c19f
> 

Now queued up, thanks.

greg k-h

