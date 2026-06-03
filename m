Return-Path: <stable+bounces-260072-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G72nKygeIGp7wAAAu9opvQ
	(envelope-from <stable+bounces-260072-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:29:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15240637818
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 14:29:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iO8p5ibD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260072-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260072-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01E3A30358A0
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 12:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776633D3D05;
	Wed,  3 Jun 2026 12:24:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22555367B90;
	Wed,  3 Jun 2026 12:24:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489448; cv=none; b=Q0q7Gaup7TilSdRzkZ7hFp039o3awxe6nBAkEW66/7IOYen7DuJYT/6fFEJoxAQNil7LWAdi8Nfgg632rBygylGSbD5glFgxqaD/rVk4Pqff0yNEcsrYbXqjKljWwTR2RC2IOUEVO2Lpa+VOtQfrFIKUFuAPgAdQxeLMFHmsbdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489448; c=relaxed/simple;
	bh=fhgpEIvNeyfQKRYomQWaRlL99rmQ0rQnJNsvUCdcMvc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bMfDADaDsoSAzu2IH02od/eV0UdvO9Oxh+6LnNsyrSiU6POc8ht0ZPN30K1AzykLeYqDY0rL3HLMhx44SCysdm/hzWxECMVcy8HEwXTxCUCWijNprjbK5Z8QYsJfQvBb4yYmAHDyZo5YwX4BntmFPFNpLsaWIg8KzbOdlUm6JD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO8p5ibD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346F21F00893;
	Wed,  3 Jun 2026 12:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780489446;
	bh=hXHl2kqJr/S0Wgp1udof7iRvEicwkY2guHehFWaFpsU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=iO8p5ibDLCSM+5JybV5K1CNtix4uAW5j922nOHf7n2wJpy1egElT+q+oQBH3H7oUu
	 ky1Mwq6Yo2U1xISpBK7R/iS/UvldPaaw0pY7H3jWNBu3KPixstrx7lFStW0klZEQ41
	 nsV9QJNeELkoPruc7vju0nrzMo7es36Cj3QO5OUQr9ZjLWgvSd5OS8VjkK22MOPns6
	 BHlHj4JemmiLSu+lAgFYN8DlsL5+eF4Q+YbRsjWxO5UM9jG7fjxm/LN+0l/HiNzZ59
	 I1WSou96FSYbmK0A9I6v8pnNTGbhTotZcVCQCGp8/2ZxpYpqBTynGRo5pAEJo6yF7v
	 IEWpNAzMFWTsA==
Date: Wed, 3 Jun 2026 14:24:04 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, 
    benjamin.tissoires@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: fix slab-out-of-bounds write in
 wacom_wac_queue_insert
In-Reply-To: <20260528175945.2987781-1-jinmo44.yang@gmail.com>
Message-ID: <7970933s-3os1-595r-54pn-s6s36n019626@xreary.bet>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com> <20260528175945.2987781-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jinmo44.yang@gmail.com,m:linux-input@vger.kernel.org,m:dmitry.torokhov@gmail.com,m:benjamin.tissoires@redhat.com,m:stable@vger.kernel.org,m:jinmo44yang@gmail.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-260072-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xreary.bet:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 15240637818

On Fri, 29 May 2026, Jinmo Yang wrote:

> wacom_wac_queue_insert() calls kfifo_skip() in a loop when the kfifo
> doesn't have enough space for the incoming report. If the kfifo is
> empty, kfifo_skip() reads stale data left in the kmalloc'd buffer
> via __kfifo_peek_n() and interprets it as a record length, advancing
> fifo->out by that garbage value. This corrupts the internal kfifo
> state, causing kfifo_unused() to return a value much larger than the
> actual buffer size, which bypasses __kfifo_in_r()'s guard:
> 
>   if (len + recsize > kfifo_unused(fifo))
>       return 0;
> 
> kfifo_copy_in() then performs an out-of-bounds memcpy, writing up to
> 3842 bytes past the 256-byte buffer.
> 
> Add a !kfifo_is_empty() condition to the while loop so kfifo_skip()
> is never called on an empty fifo, and check the return value of
> kfifo_in() to reject reports that are too large for the fifo.
> 
> Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs


