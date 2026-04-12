Return-Path: <stable+bounces-235824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id a6xEEHC322mlFgkAu9opvQ
	(envelope-from <stable+bounces-235824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 17:17:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9A33E4733
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 17:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF56830041F6
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D860C381AF0;
	Sun, 12 Apr 2026 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+le5F8U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993CE26E71F;
	Sun, 12 Apr 2026 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776007020; cv=none; b=GQd0pHg7/m/8SQGDosujY1HiA4GBs9wrd0Yr9AlAt+P0Knb9mz+uAl0BOmcsIkRs8AWSHmdywbmKn/sYrJibIieKYxfFD9KHMyHr+e0amxwklf5YjjnYs+6I5GDBtyq0k4hZnaSB5Lns/3ao7NH+QPv494YSp6AFQkq8ZgdAjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776007020; c=relaxed/simple;
	bh=5zef6enKB5ySdyV6i+5YPI+rubdsXOoMloPeHZAGqaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YdJzGWOH+pv0xBVkTMVeSpN+2YB8v5faB5hhEWAzDI/gWe1AZNARc6tcquLnTWfqNSQPTzEYEds/mWrObcVGG2UsdjiHjuI3MYO3TilG9dUyUxk5XGxPWgzJSRCxHwR5muBljwJan0HuF0rBP6UAftADLDu37/kjvOa+AaoTp7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+le5F8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38EAC19424;
	Sun, 12 Apr 2026 15:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776007020;
	bh=5zef6enKB5ySdyV6i+5YPI+rubdsXOoMloPeHZAGqaQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R+le5F8UT4rF8r3/IO4T90e5P2z+XSrdsi6VeJJtPQODVjN8AJvp7CNXTTbO48vk2
	 AcAFPlTtNOnXXx3HuUPQSSTKLZnXtjGnJi3sjMLpAhhle4UG4yMI7IaysVXlScxlb7
	 0FegLuHidt3kZs9a+M18aeWyNx/3YT6BaEv8mFRDyTpe5OH6JfbpPenBFBsR+unBfG
	 IZNOuE9Fk4CGcgZwtWGVOCr4ZH3Q7aKoAIyobjdHIUl0w5G69pWA+xskPAjzGQWWaz
	 ARMEt3o0yuMvMXT0MNshgfrX6ZidFUMumL2hbtjsV+xFWSYFsXMjICW/JJ54MIRAt2
	 raplHc9VlMeCw==
Date: Sun, 12 Apr 2026 16:16:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Gyeyoung Baek <gye976@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: mhz19b: reject oversized serial replies
Message-ID: <20260412161651.3479e47e@jic23-huawei>
In-Reply-To: <ac4rKEMYAl-FJ5e8@ashevche-desk.local>
References: <20260402054015.38565-1-pengpeng@iscas.ac.cn>
	<ac4rKEMYAl-FJ5e8@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235824-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[iscas.ac.cn,gmail.com,baylibre.com,analog.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CA9A33E4733
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 11:39:04 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Apr 02, 2026 at 01:40:15PM +0800, Pengpeng Hou wrote:
> > mhz19b_receive_buf() appends each serdev chunk into the fixed
> > MHZ19B_CMD_SIZE receive buffer and advances buf_idx by len without
> > checking that the chunk fits in the remaining space. A large callback
> > can therefore overflow st->buf before the command path validates the
> > reply.
> > 
> > Reset the reply state before each command and reject oversized serial
> > replies before copying them into the fixed buffer. When an oversized
> > reply is detected, wake the waiter and report -EMSGSIZE instead of
> > overwriting st->buf.  
> 
> ...
> 
> >  	struct completion buf_ready;
> >  
> >  	u8 buf_idx;
> > +	bool buf_overflow;  
> 
> + blank line here.
> 
> (No need to resend just for this.)
> 

This version addressed the comment I just made on v2 so all good.

I tweaked whilst applying.
Applied to the fixes-togreg branch of iio.git.

Note I'm unlikely to send another fixes pull request this cycle, so
I'll rebase that branch on rc1 once available and send out then.

Thanks,

Jonathan

