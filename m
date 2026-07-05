Return-Path: <stable+bounces-271989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3GSXHtWfSWpe4wAAu9opvQ
	(envelope-from <stable+bounces-271989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 02:05:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1690708ADF
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 02:05:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=h9Raqix+;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271989-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271989-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 553C73016D27
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 00:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A21979CD;
	Sun,  5 Jul 2026 00:05:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818AEEA8;
	Sun,  5 Jul 2026 00:05:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783209934; cv=none; b=cWPMEYs63e7mk6XWH2ES1QYTmIJHpD3JUexVe2zg8O1WsZqwxnB2tw64wuTVz30UALztbYrabv93hKaOms6rgo2cgvvSUspuoKAGq+isUherQEjmQJwDKWBw2R/Z2t6V7ULpQYaTA2jwXjcwuoWN2PW90HCIc/Ovuv6o/67nMyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783209934; c=relaxed/simple;
	bh=+m/sdhZfHlDzmQnbOHsef8P2LMpWwf4c4pmcDkd/Mng=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g76rKAMT7yRFKSO5HVVjVSVmFG1y+qtVbQ8n295FMe9qLYwI+E2QxRogh+bjE71v9kCWGKahyKEAohO0bqP/+saadK64lJjjrKWiT/F0OULqJgmKs2vikf1i87ijMtnIiSHEtRv/lFlvWeal5aUveljKhQMiK90Fb9TWM8uNu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9Raqix+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4683C1F000E9;
	Sun,  5 Jul 2026 00:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783209933;
	bh=3hqE/DKL9gQuMz7nhcQ+bGghBLPWZUMdJpGNilRT2Gc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h9Raqix+npgUvNwCiAscQw42ogENlitwbL9ZuFWwT61WZ9zLt9UJBdOcXXu2Y4hsd
	 yTkBWYfiOx/RjR+4PLS6m9riCvUgw+if+zVo8RfHf6d4h6wcpePr8QKdctf13gPtHy
	 1SweNJkZfXvbKFqLOX0jdaPzS6sdrkhA5MPdTo0+VEqUBILyKjYVuANjI5oGXSszgo
	 xuSnCW2qLh6NVhpYnln7zs45a+VpS2tPf45YLfpvvNwwGKW6QmOmqx75XZp/ernhuP
	 xZb7DGoGk1zuYHUSmkY05RJRapMNiPrbOXdVDSxZzZk97x67gHR4DsslZGPydLtETw
	 DM5hfHykE9QTA==
Date: Sun, 5 Jul 2026 01:05:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Biren Pandya <birenpandya@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linusw@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: accel: kxsd9: fix use-after-free and PM leaks
Message-ID: <20260705010528.6429c1eb@jic23-huawei>
In-Reply-To: <20260703-kxsd9-v3-proper-v1-0-e9f08af25d7e@gmail.com>
References: <20260703-kxsd9-v3-proper-v1-0-e9f08af25d7e@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:birenpandya@gmail.com,m:dlechner@baylibre.com,m:nuno.sa@analog.com,m:andy@kernel.org,m:linusw@kernel.org,m:linux-iio@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271989-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,jic23-huawei:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D1690708ADF

On Fri, 03 Jul 2026 22:53:21 +0530
Biren Pandya <birenpandya@gmail.com> wrote:

> This series fixes a use-after-free during device removal and resolves 
> multiple runtime PM reference leaks.
> 
> Changes in v3:
> - Split the fixes into two patches (UAF fix and PM leaks fix) as 
>   requested by Jonathan Cameron.
> - remove(): Dropped the early return on PM resume failure. The driver now 
>   makes a best-effort attempt to power down the device unconditionally, 
>   addressing feedback from Andy Shevchenko and Jonathan Cameron.
> - read_raw(): Mirrored the -EINVAL reset fix from write_raw() to ensure 
>   symmetric error handling on invalid masks.
> - Dropped redundant pm_runtime_mark_last_busy() calls, relying instead
>   on pm_runtime_put_autosuspend().
> 
> Link to v2: https://lore.kernel.org/linux-iio/20260621193036.78549-2-birenpandya@gmail.com/

[PATCH v3 0/2] etc

Don't resend for this but please check future series for missing versions
before sending out.

Jonathan

> 
> ---
> Biren Pandya (2):
>       iio: accel: kxsd9: fix use-after-free on remove
>       iio: accel: kxsd9: fix runtime PM leaks and unchecked returns
> 
>  drivers/iio/accel/kxsd9.c | 44 +++++++++++++++++++++++---------------------
>  1 file changed, 23 insertions(+), 21 deletions(-)
> ---
> base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
> change-id: 20260703-kxsd9-v3-proper-51a1f05c4951
> 
> Best regards,
> --  
> Biren Pandya <birenpandya@gmail.com>
> 


