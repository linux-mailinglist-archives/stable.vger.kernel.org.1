Return-Path: <stable+bounces-262024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PlyIKO6qJmp1awIAu9opvQ
	(envelope-from <stable+bounces-262024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:43:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 488D2655CF2
	for <lists+stable@lfdr.de>; Mon, 08 Jun 2026 13:43:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bWf5FjWx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262024-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262024-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22C56300E141
	for <lists+stable@lfdr.de>; Mon,  8 Jun 2026 11:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF7936BCE8;
	Mon,  8 Jun 2026 11:43:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CB33DED9;
	Mon,  8 Jun 2026 11:43:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919014; cv=none; b=CJ177ozlbNDBPQ/ujM9IeHD5R6hBSEJnFjlZAy187PzmanLcPzptYIVMni6rRvCGZ5xY0afxW0q5vTLQSRnSvyl28ZKzhsrPAzjQ4SeREE+gDUWeyvBqWK0hoo0H5xxJDOAxg+puJhNZRblDHI+I/asAsz/gmTOd8csjjhVIKCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919014; c=relaxed/simple;
	bh=NsuGiHwdu+aQ+9U789licK2umfvuTZy68oIxrYbfUcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/gvvfqS9XcsW/VC6Xv0xhVA9qU1JdXGNErFfgTH9WMujeEEYXomf6SmaZpprp+zN+sAxBnkSO8IoY3xPp2eMpdv5HvrDybLRR2nsqgg6g9LUWrBhqrmbmeNiJz98UdirSQTW1PEyuQV2C+3O6KVQjujH06BTs6CQCNapWzmURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWf5FjWx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F081F00893;
	Mon,  8 Jun 2026 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780919013;
	bh=c4KQmWAFbwvAHdHK+YZw55+mKgkoGrzLFa35PKtZIxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bWf5FjWxSQW1bNKfipzPMcrRjx1FScPh3uSDFMNZcA/Unc8xmjsGJG2YJ8DZWlpl+
	 DZ9JUAM2hOQ5YjtMWNDInxKl6aHc9irZ7sVGHv3acKjxWBS2JUhsFkw+aB2VYjxO0M
	 hChDHgDcUdRNP1TlzWe0AgWKcXsmn7d7o2PtcdDrA+V8OqnR89scuG0Mhf0C60StI3
	 wlM4h6RxDpFxDlfUNU4iPBSdtdTf0p3OGrGz5qZjPRk9RFtgeV1c4txl4walZ0XeZx
	 RZhK3s0gjChBixZ2zkbf8dLABDKOXP2tFPrOHigP7wg/qHdiU0zy6l2Z0u1ri2Wsz5
	 KVCMd9ttpuGkQ==
Message-ID: <6f86dc2a-27c0-46a7-8d28-8e07ecb77566@kernel.org>
Date: Mon, 8 Jun 2026 19:43:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: pata_legacy: remove documentation for removed module
 parameters
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-doc@vger.kernel.org
Cc: stable@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20260607064053.195166-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260607064053.195166-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:linux-doc@vger.kernel.org,m:stable@vger.kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-262024-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 488D2655CF2

On 2026/06/07 14:40, Ethan Nelson-Moore wrote:
> Commit 3c4d783f6922 ("ata: pata_legacy: remove VLB support") removed
> several module parameters from the pata_legacy driver, but neglected to
> remove their documentation. Remove it.
> 
> Fixes: 3c4d783f6922 ("ata: pata_legacy: remove VLB support")
> Cc: stable@vger.kernel.org # 7.0+
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

