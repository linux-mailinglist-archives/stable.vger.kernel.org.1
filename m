Return-Path: <stable+bounces-254687-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EASdDQdlF2rEDggAu9opvQ
	(envelope-from <stable+bounces-254687-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 23:41:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DF15EA74E
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 23:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0E42305DA9A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5183A6B9A;
	Wed, 27 May 2026 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldgqd+AU"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B539891E
	for <stable@vger.kernel.org>; Wed, 27 May 2026 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779918077; cv=none; b=UB+pjfHPG77YK02J1+sdVwmQJE4isai42kpk3EUXDL77lWXTHAJuuMxxIju85xV3QoL4NxD3FFSRxkyPDpZ5cwmseedfvWyVgPZA86i18beyyTsythUwvLSr6glGZx796AtQ5PdDJ9SygeV5ZG2Hhrvzy3aRr/u/Sywg12zWW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779918077; c=relaxed/simple;
	bh=H2q+9lVRHkFpT8xh7oZtUq8sMwBtqlHtfDEZCw5om4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyBcuCm/ISWIJAEW906g4J66v8dNFktXUh7K1In1fqFyc2+5xENX0U/g0ovehL0eSPGUIqDq01T1dHZkWTQUrq2ITR89C4Tjo+dJDPNS9ocB47UG/JPTGpDhulCmOCeKjZDjLhRaQ2qsZ6Vetj6l97Ec34ZGbU1wn+JTcpiWVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ldgqd+AU; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-136b46c3540so4865240c88.1
        for <stable@vger.kernel.org>; Wed, 27 May 2026 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779918075; x=1780522875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XyVWwIzkff7WseZ7Vmlrgtp+ZrMXZZPNibWetKjmvpU=;
        b=ldgqd+AUgVcfxbvbOLtUqXcvx3judn7jP4+Nv2pbYdeLb3DaNWjq/GcVcnzRhI0Rwk
         Z7se6IUlDh0MrXTbmlZBh+RcZg6IfhoaaxjvmEXOXFHdU5fAPspTY79wHP/CDGrqiEHI
         UEkP+8Amc301c989eKdpZFr9MOIesjV/t/T6IXrj/w4YnUzpEmF83i0kJLheSJnLaj+x
         6TaWmN5RYi8vo9PWcXNB+rovSR0C3Gsh5iyi5EZwP1hpS2qxTvHjgO8odb726WgUQfcD
         29ZIQphl9MhoxP7b3SlITrSiYSAzyd/iijhtRK0Q8cZJso338VfgBz2Odn1YBPZJpFue
         8Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779918075; x=1780522875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XyVWwIzkff7WseZ7Vmlrgtp+ZrMXZZPNibWetKjmvpU=;
        b=sxlP06wimC8cJ5tBezBACc38iePOARNlo1jM21CDDGszEl7ZoxHqecLwkH1e2guodi
         uUL7EUYmMiPPsiBERtEx9vgBOSIChWoLP15agH1Brl00ay95RxbWqq5XbHIb/pEHzncY
         3Vran4GrSl7sLhG+O0A+KG+G1Y14bbj2vxDRGKsFJLUT3xi6WJs0n9utpraoyKS4n36y
         H3hCmCpvVdwLcc6KDbLHzEMProWXk6Arso+ucqMHlcbPYXm5zD3G0o8wNoyX4yst/K7I
         5ujfKNaWt/hHPh8gIwQdBgoE8W0ZwmCGp7D01BsZDmLpax7wE5LZe9ZtzIWHamiCW34O
         u/Fg==
X-Forwarded-Encrypted: i=1; AFNElJ9lj4QZCgaSZI4oR8jcWHhZiicItdoMXNesQkKAGm0Ss0n01WQo+En49E/y/v8l6GMI5lsxWWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw48cvHQFq4TCqM//dO+vkrIz6M7k4AM5gHBAcGHQVagm2sJAOH
	GlYe37GuKQBMscl7NxJ66ZpSrAd2f3uWhA4JmC97mBOZfRk5bMuK+yqz
X-Gm-Gg: Acq92OGxRM4bIL9E8yg1TfaxVWDASZAco1ftdWWlD5ATYQdnAcUhdS5AJFCZUWvJJDo
	5UrBN1Y0961BDpykOI8eZPB2K1i77oxNaJ89oErFYvR791dLqlfMTm0zMKC8cHtFwW+BRsDp2G1
	YAd02O7EXEiapeX2E8CFJkd0BvlQVY/wuBF6XeKlHN8udOnlIhlYrnfjVFfqEScCTxqYxSRLThR
	3RzWhLBIbXQtg9DxM9iq1F03VxREDhsvMSI5B2Mw4/937mx4LslNpfN2mAHLcG0DTGCIfaIOlJL
	b3WTgX33p9NNXXJ+vpTEPS51iHuIn/cRRHMIw9sUBlRjeUueL6Ajd2HZKOXQFjLtg7Pi8DEbpjw
	pQEyB52ytM4ocmISxeQlnd1a859KdCdHlMMLLC+WTwBTkt1Zn4i91SSceSHnqY3kqKR7uTjnLQP
	iEuEy+L7yH9dKcpxDwlH9yLnZkUTyUegA37v55UybE54CNeo8/Xfhy00I/H4VM1JO7MZHbX6AmE
	8Y=
X-Received: by 2002:a05:7022:618e:b0:137:5b9d:cf87 with SMTP id a92af1059eb24-1375b9dd5e3mr1725302c88.0.1779918074854;
        Wed, 27 May 2026 14:41:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ca8d:7a6a:7fd3:5948])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aa88c7esm11128204c88.10.2026.05.27.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 14:41:14 -0700 (PDT)
Date: Wed, 27 May 2026 14:41:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jinmo Yang <jinmo44.yang@gmail.com>
Cc: Jason Gerecke <jason.gerecke@wacom.com>, 
	Ping Cheng <ping.cheng@wacom.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: wacom: validate report size before kfifo insert
Message-ID: <ahdgcqtACd-PGmzJ@google.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
 <20260524135203.1996265-2-jinmo44.yang@gmail.com>
 <ahdJzWhVFm7mWu-v@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahdJzWhVFm7mWu-v@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254687-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A2DF15EA74E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 12:47:03PM -0700, Dmitry Torokhov wrote:
> On Sun, May 24, 2026 at 10:52:03PM +0900, Jinmo Yang wrote:
> > wacom_wac_queue_insert() passes the report size directly to kfifo_in()
> > without checking whether the report fits in the kfifo buffer.
> > 
> > Since commit 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX
> > limit"), the kfifo is sized dynamically as min(PAGE_SIZE, 10 * pktlen),
> > which can be as small as 256 bytes. However, reports received via
> > UHID_INPUT2 can be up to UHID_DATA_MAX (4096) bytes. When such an
> > oversized report reaches wacom_wac_queue_insert(), the existing
> > kfifo_avail() loop cannot make room for a record larger than the total
> > buffer, causing kfifo_copy_in() to memcpy up to 3840 bytes past the
> > slab allocation.
> 
> Does it? Or maybe spins there indefinitely? Also, doesn't
> kfifo_copy_in() return 0 if a record it too big and not copy anything?

OK, so the root cause is that kfifo_skip() must not be called on an
empty fifo. I think you want the code to look something like this:

static void wacom_wac_queue_insert(struct hid_device *hdev,
				   struct kfifo_rec_ptr_2 *fifo,
				   u8 *raw_data, int size)
{
	bool warned = false;

	while (kfifo_avail(fifo) < size && !kfifo_is_empty(fifo)) {
		if (!warned)
			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);
		warned = true;

		kfifo_skip(fifo);
	}

	if (!kfifo_in(fifo, raw_data, size))
		hid_warn_ratelimited(hdev, "%s: report is too large (%d)\n",
				     __func__, size);
}

Thanks.

-- 
Dmitry

