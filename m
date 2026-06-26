Return-Path: <stable+bounces-268778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gZWZKMg6PmpaBwkAu9opvQ
	(envelope-from <stable+bounces-268778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:39:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 008FC6CB6D7
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:39:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=RphR6Lj7;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268778-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268778-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A453530BF087
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63D13E5A27;
	Fri, 26 Jun 2026 08:32:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B83DC4B6;
	Fri, 26 Jun 2026 08:32:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462768; cv=none; b=lnRV4JMv0jiqpIx8kj3uY2HpXf/nqlcKre8s+yTnIuCnyhT1q5ywFrh6UkhfJVdW52taMa+vqZ6M1JvAjuqI3nk+Yexs7Nd/AR+i8i03P1vK8lyW58umsdSeVrha7JqTDwfheNyQmEihHMyCGyisgC/2dOxyYd/+GQIIXTZCdaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462768; c=relaxed/simple;
	bh=fN9Z+4SIkdhKUBHQNrTSY+nfHPkzG6ev+/cA3e9IMjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxAgoUhuUim7BRd5wSkj5p9bCfJ2Rk5dLuUUEkuI7KDAMFjqKNZLQkMKcqcfVjw4SXM9xqftHx83vuxXbK8bESBKMvCZMeW2uKJmmO6K38srlCEtFydJHK6wJfU76VlR+/Is1anGTGnaCQvEM0CdfohWr+VgWJ5/iXUGtYo8EeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RphR6Lj7; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782462767; x=1813998767;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fN9Z+4SIkdhKUBHQNrTSY+nfHPkzG6ev+/cA3e9IMjU=;
  b=RphR6Lj7mLlvEjnJ6z9nA02Z5jhJ5WvRMgZiShtL28fxlcKyqP/F+v7g
   8TaQ0c7ajs/Y88fZ4ve/N4VRNUGstK/9Ey5U1W1OFN7OL4qOixUxEWU8j
   xDEWRA/0BNrXKRUyvfehkEQJmsvxlV+zc8e7PqFCvztE1s309RNuSVQD7
   au1a1QC+Qx0Nx4Gzz53p3i61QuxRCzq4mbNOFb7OqtD+hZ1L4xIegF5IV
   Jpzoo4KIDsUOXjDF7r0Iln34wVfeaMnTSg6NEYhgvbXQd5DIpUGjjfvY4
   BTsARcgx3Yyp8w5CXPHFdR/N8fhCut9/0QUbMCSsEq9IOX5978Gxtdh+l
   g==;
X-CSE-ConnectionGUID: KGv4UF3uQziYpZ9N4uXvPQ==
X-CSE-MsgGUID: dIEW8AiNQ8i6+msn7S76uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83458425"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="83458425"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 01:32:46 -0700
X-CSE-ConnectionGUID: FVuWtfz/RJSN5/qzjPbwHg==
X-CSE-MsgGUID: wdfhldQ1Sr6Ny5Axjcq67A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="244881654"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.35])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 01:32:44 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 9D4381204E0;
	Fri, 26 Jun 2026 11:32:44 +0300 (EEST)
Date: Fri, 26 Jun 2026 11:32:44 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: HE WEI =?utf-8?B?KOOCruOCq+OCryk=?= <skyexpoc@gmail.com>
Cc: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: misc: usbio: bound bulk IN response length to the
 received transfer
Message-ID: <aj45LDu_DxVC5sL0@kekkonen.localdomain>
References: <20260624090952.86439-1-skyexpoc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260624090952.86439-1-skyexpoc@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skyexpoc@gmail.com,m:israel.a.cepeda.lopez@intel.com,m:hansg@kernel.org,m:gregkh@linuxfoundation.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sakari.ailus@linux.intel.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-268778-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakari.ailus@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kekkonen.localdomain:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,linux.intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 008FC6CB6D7

Hi Wei,

Thanks for the patch.

On Wed, Jun 24, 2026 at 06:09:52PM +0900, HE WEI (ギカク) wrote:
> usbio_bulk_msg() copies bpkt_len = le16_to_cpu(bpkt->len) bytes out of
> the bulk IN buffer (usbio->rxbuf, allocated with size usbio->rxbuf_len)
> into the caller's buffer.  bpkt_len is fully controlled by the device
> and is only checked against ibuf_len; ibuf_len in turn is checked
> against usbio->txbuf_len, not against rxbuf_len:
> 
> 	if ((obuf_len > (usbio->txbuf_len - sizeof(*bpkt))) ||
> 	    (ibuf_len > (usbio->txbuf_len - sizeof(*bpkt))))
> 		return -EMSGSIZE;
> 
> txbuf_len and rxbuf_len are taken independently from the bulk OUT and
> bulk IN endpoint wMaxPacketSize in usbio_probe().  A malicious or
> malfunctioning device that advertises a large bulk OUT endpoint and a
> small bulk IN endpoint (e.g. by claiming one of the quirk-free IDs such
> as the Lattice NX33U, 0x2ac1:0x20cb) therefore makes ibuf_len, and
> hence the device-supplied bpkt_len, exceed rxbuf_len.  memcpy() then
> reads up to txbuf_len - rxbuf_len bytes past the end of the rxbuf slab
> object.  The over-read bytes are handed back to the i2c layer and on to
> user space through i2c-dev, disclosing adjacent slab memory; with KASAN
> this is reported as a slab-out-of-bounds read.
> 
> The number of bytes actually received is already known: act equals the
> URB actual_length and is bounded by rxbuf_len.  Reject any response
> that claims more payload than was received, mirroring the existing
> "act < sizeof(*bpkt)" check just above.
> 
> The control path (usbio_ctrl_msg()) is not affected: it uses a single
> buffer (ctrlbuf) for both directions, so its analogous copy can never
> leave the allocation.
> 
> Found by code review.  The out-of-bounds read was confirmed under
> AddressSanitizer with a faithful userspace model of usbio_bulk_msg()'s
> receive path (an rxbuf_len-sized buffer, the same act/ibuf_len/bpkt_len
> checks and the memcpy).  A USB raw-gadget + dummy_hcd reproducer is
> also available.
> 
> Fixes: 121a0f839dbb ("usb: misc: Add Intel USBIO bridge driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: HE WEI (ギカク) <skyexpoc@gmail.com>

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

