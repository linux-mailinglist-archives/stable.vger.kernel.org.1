Return-Path: <stable+bounces-262539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d1OdAF+UKWoPaAMAu9opvQ
	(envelope-from <stable+bounces-262539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:44:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A396966B9D5
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 18:44:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b3mu8BqO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262539-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262539-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C8E1430623F1
	for <lists+stable@lfdr.de>; Wed, 10 Jun 2026 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6516733C1BD;
	Wed, 10 Jun 2026 16:35:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D2C33260D;
	Wed, 10 Jun 2026 16:35:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109315; cv=none; b=c3spsbRP4aHcNu5f1jojInbcMbTn7+TyxtBr+pAMZS4jRgoM6UYfUy0Rpx5CggMVSWAsLGecbaN5g+Cg3Y2TC0rbep4Grbms/R+3tkNMy3kcXARsmPS5Nh/zJjjL5MQfpXnlO6kh1BTnhzuhg9aH4xOXG1+Db2TQjIi7fyeNjyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109315; c=relaxed/simple;
	bh=o0UHpGfUu2Y4xLXTxuCWVifSMbbKVSTfndNre6mkvOI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qCftIQcjstABWtROfu2CHVBHOb7tWAIpm6vowjCscgCeWjqDxQqsC9HoJAKrgZ59HNhuGR6gjxe/C7ZSerhY2LE3KehZxPrRVnqRQUnW+8bDqfP9oUkYKSk94A1Pec24n+/VShBXhrTSh/Dli/rWnKUPrjf3ihG5T6BVPdi498M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3mu8BqO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582261F00893;
	Wed, 10 Jun 2026 16:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781109314;
	bh=aoK4NCFgt75hg7TUdwmbCdz+xbW1TUVb2FQGnQHVjwA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=b3mu8BqOUoGIadgVLDjbMjxNFwmzOyhLO9iw9neqEa2FHJ59+cShg6pCsZ0X7zxci
	 xYgz3vHkfIBVbc9LxTn3kaOIS+90YPGNUtuSsHDWZGR0be2sllU9Hf2fzCIJIquxkz
	 mPkGID8tcz2n1T9lmScUhc/eqRsxz7Hm0spgTJ72QOdYW/dQ4ZhQBUfBTgMCPCAywk
	 azHFKAzDwNwp+bNruoqZ/FEMtMd3VncalI5Cd5hhOHGvwQTutkV7H7el0tqIRsyG+6
	 EdpNrtATopu+l9syg62MYsXpiOfW+KTPgt4UI+Vo7cCyntg0gmVm8Gkg6lOAPmt2Te
	 GqnZgBKRlbjgw==
Date: Wed, 10 Jun 2026 18:35:11 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Tianchu Chen <tianchu.chen@linux.dev>
cc: bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: hid-goodix-spi: validate report size to prevent
 stack buffer overflow
In-Reply-To: <f7e444a3facbe5fb2627167ab205771476e46bc8@linux.dev>
Message-ID: <081p3q54-1553-0o92-4osr-r51s82023q24@xreary.bet>
References: <f7e444a3facbe5fb2627167ab205771476e46bc8@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tianchu.chen@linux.dev,m:bentiss@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jikos@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-262539-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A396966B9D5

On Fri, 29 May 2026, Tianchu Chen wrote:

> From: Tianchu Chen <flynnnchen@tencent.com>
> 
> goodix_hid_set_raw_report() builds a protocol frame in a 128-byte stack
> buffer (tmp_buf), writing an 11-12 byte header followed by the
> caller-supplied report data.  The HID core caps report size at
> HID_MAX_BUFFER_SIZE (16384) by default, while the driver does not set
> hid_ll_driver.max_buffer_size and performs no bounds checking before
> copying the payload:
> 
>     memcpy(tmp_buf + tx_len, buf, len);
> 
> A hidraw SET_REPORT ioctl with a report larger than ~116 bytes
> overflows the stack buffer.
> 
> Add a size check after constructing the header, rejecting reports that
> would exceed the buffer capacity.
> 
> Discovered by Atuin - Automated Vulnerability Discovery Engine.
> 
> Fixes: 75e16c8ce283 ("HID: hid-goodix: Add Goodix HID-over-SPI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tianchu Chen <flynnnchen@tencent.com>

Applied, thanks and sorry for the delay.

-- 
Jiri Kosina
SUSE Labs


