Return-Path: <stable+bounces-231254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OVfASSdymmg+QUAu9opvQ
	(envelope-from <stable+bounces-231254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:56:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F39E35E3DE
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 17:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD0DC300AC2B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E35374196;
	Mon, 30 Mar 2026 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uD/HkKGv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1397344DB5;
	Mon, 30 Mar 2026 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774885901; cv=none; b=Apz15DYAyJqM2AW9dyvaw3ZKnCbJIm7mSARe1HmtUvno4A3Dj0BnnO9Oiku6BlmNEYI66I47vHdD8yDKyx0kUjeZMAyyqVkL6vlWenkLtuGwX5W0P3yJH85DmBkCq5n4GRKn7lzEdtLLjAHOHN/QYtzJxdoaKkEUJNR4waJzohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774885901; c=relaxed/simple;
	bh=VjZpJN9SN3Cbv+q/GHgyVTPouO/S00Aq2D+4UhnLGVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJ1ay4xiFnzPEqNyYVnG7QNgE0RKDzij9GwzNls88A2pQJplM5cujYkA4o5D8zdjA5nPxKZuSLSwpUC2+1MHqMhI4YgV4NmyuMqnsJkxyxWUDluvXEWPziTO5QoabGnCkoq9F6m3PmsGSiLdVgWjMg3JSeLio8W+09qHpNHZ8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uD/HkKGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D81C4CEF7;
	Mon, 30 Mar 2026 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774885901;
	bh=VjZpJN9SN3Cbv+q/GHgyVTPouO/S00Aq2D+4UhnLGVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uD/HkKGvpDvOk7tq5zKCA9l93yF85/7C69IQjnL5GJv2lbUkKg3LkpskN/rSvYyyZ
	 rmMvd935vGVOB2+5simP+7qOeU5KYY+qhGnKB2/hTnRPLoRfXGwaaKWxoOZUkMAC9K
	 SbjBGLgzAUDn+sEjprm6Zrf+Po5W5cEGQFUeFnG8=
Date: Mon, 30 Mar 2026 17:51:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Cc: marvin24@gmx.de, linux-staging@lists.linux.dev,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3] staging: nvec: validate battery response length
 before memcpy
Message-ID: <2026033041-elf-coach-5fae@gregkh>
References: <20260330125200.820693-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330125200.820693-1-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231254-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmx.de,lists.linux.dev,vger.kernel.org,intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 6F39E35E3DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 06:52:00AM -0600, Sebastian Josue Alba Vives wrote:
> From: Sebastián Alba Vives <sebasjosue84@gmail.com>
> 
> In nvec_power_notifier(), the response length from the embedded
> controller is used directly as the size argument to memcpy() when
> copying battery manufacturer, model, and type strings. The
> destination buffers (bat_manu, bat_model, bat_type) are fixed at
> 30 bytes, but res->length is a u8 that can be up to 255, allowing
> a heap buffer overflow.

How can the embedded controller send data that is not correct?  It is
trusted, right?

> Additionally, if res->length is less than 2, the subtraction
> res->length - 2 wraps around as an unsigned value, resulting in a
> large copy that corrupts kernel heap memory.
> 
> Introduce NVEC_BAT_STRING_SIZE to replace the hardcoded buffer
> size, store res->length - 2 in a local copy_len variable for
> clarity, and add bounds checks before each memcpy to ensure the
> copy length does not exceed the destination buffer and that
> res->length is at least 2 to prevent unsigned integer underflow.

Is this the only data that needs to be validated from the controller?

> Reported-by: kernel test robot <lkp@intel.com>

The kernel test robot did not report these buffer size issues :(

thanks,

greg k-h

