Return-Path: <stable+bounces-244579-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPWBBW6l/GmwSQAAu9opvQ
	(envelope-from <stable+bounces-244579-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:45:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DF74EA6DC
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 845E53064101
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73FF402B8B;
	Thu,  7 May 2026 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g6z6btlm"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE7E413245;
	Thu,  7 May 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164811; cv=none; b=lNNK3ixtry7p+hMh7ePqKPuaukITG4ivVLcSL+BwsEitUlMAiesTPtfmwiCFtPk19RtVII2BOF+s92u9IF2ldY6o+scEdK46mypVl968BW8nhdT6DtETh17Q1Db0xqokC9YzmDz+V2H+r64jiWTSnEzKrcL7soVZmLyDcj2i0es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164811; c=relaxed/simple;
	bh=ASymM5PB3wiMqwerpa0t5KbgEmK7BZNQH7mIQrcYjf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=io5gt/7lYmeZxa4qYx+0Wyid8kfCiwL6yB7ihvKE+RfIJ8s5sjWWROdesAvpYYTg3/siWTLAvd53gj2R8qHzT9pqOk/IQxM5JOoRtNsZgyBcSbnNWrbes9sKW7Ce+++P11f+csdpOEJUvf02F4HJe+NCOsOB5tx9nZXbT0Q6gXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g6z6btlm; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8BC69C5DC5B;
	Thu,  7 May 2026 14:40:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C1F8C60495;
	Thu,  7 May 2026 14:40:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A248C1081949C;
	Thu,  7 May 2026 16:40:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778164807; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3eZ8TQZoXzIrcLlh2vL4pRszm+YYsLewASdMrSEtg6A=;
	b=g6z6btlmMRF1ZZU8l0fBQzxB5ErhceJh43xrMKDUbUngmVaBeBNpFPA4K3lrcBD2qk5gJH
	ONyPOBeFDVd5EvNtdlR3fof0lT/gmZj6qmU6VUpB37QT5YAc3TK/06F7MTM2GAXjpdrt8m
	RyINlArYhC21JJ6lh+HHZW5ajUwHmdWYa+HcJmOUYY7nnqzNrKLFgnXopwZOql77S5IZqP
	LMkSe/ipewOgVv8SAPcqIIpSodVH4sv+jaxMsPaKxuFlZ5XDgbUsaHvILnpS7iNY4hHHj8
	ubljWT68mYkgxdvSM/9+5MZX+8LhyPTrZ9Pxsm7NevMGUXxUBO5NZPzRgizsTQ==
Message-ID: <02fe1096-4730-46b3-8b79-917a0eac887e@bootlin.com>
Date: Thu, 7 May 2026 16:40:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] crypto: talitos - fix several issues in the
 Freescale talitos crypto driver
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 David Howells <dhowells@redhat.com>,
 Kim Phillips <kim.phillips@freescale.com>,
 Christophe Leroy <chleroy@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Herve Codina <herve.codina@bootlin.com>, stable@vger.kernel.org
References: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-0-5818064bd190@bootlin.com>
Content-Language: en-US
From: Paul Louvel <paul.louvel@bootlin.com>
In-Reply-To: <20260505-bootlin_test-7-1-rc1_sec_bugfix-v2-0-5818064bd190@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 74DF74EA6DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-244579-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,bootlin.com:email,bootlin.com:mid,bootlin.com:url,bootlin.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Action: no action

Again, some issues breaking existing crypto implementation in the driver have 
been found upon Sashiko's review.
Please discard this v2.

Many thanks,

On 5/5/26 7:53 PM, Paul Louvel wrote:
> This series fixes several issues in the Freescale talitos crypto driver.
>
> Patch 1 fixes a missing dma_sync_single_for_cpu() before reading a
> descriptor header.
>
> Patches 2-5 add support for chaining an arbitrary number of descriptors
> in the driver for the SEC1 hardware.
>
> Patches 6-9 rework the SEC1 hash implementation to build descriptor
> chains instead of submitting one descriptor at a time via a workqueue.
>
> Patch 10 fixes the same ahash request size limitation on SEC2 (64k - 1
> bytes), by splitting ahash_done() into SEC1 and SEC2 paths so that SEC2
> iterates through descriptors sequentially.
>
> Patch 11 fixes an off-by-one in the submit_count initialisation that
> wastes one FIFO slot.
>
> Tested on an MPC885 SoC (SEC1 Lite), and on an MPC8321EMP SoC (SEC2)
> with CRYPTO_SELFTESTS_FULL=y.
> For the SEC1 Lite, some tests are failing due to a timeout waiting for
> request completion. These failed tests existed prior to this series.
> On SEC2, there is no failed tests.
>
> Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
> ---
> Changes in v2:
> - Split the first patch into smaller, logically separated patches for
>    easier review.
> - Added more context on testing on the cover letter.
> - Introduce a fix to correctly read hardware descriptor header. This fix
>    was motivated by a remark of Sashiko on the v1:
>    https://sashiko.dev/#/patchset/20260504-bootlin_test-7-1-rc1_sec_bugfix-v1-0-c97c641976f5%40bootlin.com
> - Separate SEC2 64k-1 ahash limitation fix into its own patch.
> - Link to v1: https://patch.msgid.link/20260504-bootlin_test-7-1-rc1_sec_bugfix-v1-0-c97c641976f5@bootlin.com
>
> ---
> Paul Louvel (12):
>        crypto: talitos - use dma_sync_single_for_cpu() before reading descriptor header
>        crypto: talitos - add chaining of arbitrary number of descriptor for the SEC1
>        crypto: talitos - move dma unmapping code in flush_channel() into a standalone dma_unmap_request() function
>        crypto: talitos - move dma mapping code in talitos_submit() into a standalone dma_map_request() function
>        crypto: talitos - move code in current_desc_hdr() into a standalone function
>        crypto: talitos/hash - prepare SEC1 descriptor chaining, remove additional descriptor
>        crypto: talitos/hash - use descriptor chaining for SEC1 instead of workqueue
>        crypto: talitos/hash - drop workqueue mechanism for SEC1
>        crypto: talitos/hash - rename first_desc/last_desc to first_request/last_request
>        crypto: talitos/hash - remove useless wrapper
>        crypto: talitos/hash - fix SEC2 64k - 1 ahash request limitation
>        crypto: talitos - fix invalid submit_count initial value
>
>   drivers/crypto/talitos.c | 578 ++++++++++++++++++++++++-----------------------
>   drivers/crypto/talitos.h |  14 ++
>   2 files changed, 315 insertions(+), 277 deletions(-)
> ---
> base-commit: db8b9f227833e729faf44a512aa1e88a625b5ad8
> change-id: 20260504-bootlin_test-7-1-rc1_sec_bugfix-13169ed07ddc
>
> Best regards,
> --
> Paul Louvel <paul.louvel@bootlin.com>
>
-- 
Paul Louvel, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


