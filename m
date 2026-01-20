Return-Path: <stable+bounces-210583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KqlGz/ab2n8RwAAu9opvQ
	(envelope-from <stable+bounces-210583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 20:40:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB32F4AA03
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 20:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2C119E86AA
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C6742EEAE;
	Tue, 20 Jan 2026 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="uB7J5VIU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEE342EEB0;
	Tue, 20 Jan 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768931178; cv=none; b=M//uCWJ8TDmZajm9oUP3NXtebtyqZq206AYI9Qbc5O/VcIrLVXmhkUxaqNdMrMBTbQLygA2DtVV0S0BS7SnTPfqKUSHaIjwU/zKLFBMvCRMSNialuFw9DCm3/T6zZ+tplc/g/g85JHuu7rWLxpHEE22kpMt0FkLmq07Z59AIrWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768931178; c=relaxed/simple;
	bh=d913gHiC7qyAQGtH50oI3jMK1kbHhTOj4kG7zU0QOmA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DlDiPT1916gFwxjK/bZQmS/0QrOmFRLszguFO41QSQHm7zyGhGj43CbzIRORQvG9WOSD9DR8iliibfJLO+IsqQ1jFy/HOcY5oF9G8a3k5Yr/XNxX1oPcouRggsEnNNDvkM+q06mhES1JNS0y1o4Jc/Nb1bN4KNOiXwxcWlDsIRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=uB7J5VIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532CDC16AAE;
	Tue, 20 Jan 2026 17:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768931178;
	bh=d913gHiC7qyAQGtH50oI3jMK1kbHhTOj4kG7zU0QOmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uB7J5VIUyJlYBEPPsxzVcA4alTvhY6C6nzyO6qsW2rXfF7KeTSdxAvdULVMLimp58
	 e0wofVjX7CNvQNv0DM7awPKca4ol6l2pbrvVd9thyhwUrtMZz8w80mOxqX0gvitatf
	 ODg5ErvdlaNQ3fygK7JRr98fQWgTwsd8rl8rrzXo=
Date: Tue, 20 Jan 2026 09:46:17 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pimyn Girgis <pimyn@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, elver@google.com,
 dvyukov@google.com, glider@google.com, kasan-dev@googlegroups.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] mm/kfence: randomize the freelist on initialization
Message-Id: <20260120094617.ed5a53e9ec40e8f0a91f8cb6@linux-foundation.org>
In-Reply-To: <20260120161510.3289089-1-pimyn@google.com>
References: <20260120161510.3289089-1-pimyn@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210583-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: CB32F4AA03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 20 Jan 2026 17:15:10 +0100 Pimyn Girgis <pimyn@google.com> wrote:

> Randomize the KFENCE freelist during pool initialization to make allocation
> patterns less predictable. This is achieved by shuffling the order in which
> metadata objects are added to the freelist using get_random_u32_below().
> 
> Additionally, ensure the error path correctly calculates the address range
> to be reset if initialization fails, as the address increment logic has
> been moved to a separate loop.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")

It isn't clear (to me) what was wrong with 0ce20dd84089, nor why a
-stable backport is proposed.

Can we please have a full description of the current misbehavior?  What
are the worst-case userspace-visible effects of this flaw?

