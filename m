Return-Path: <stable+bounces-233052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGPWLp+UzmkBowYAu9opvQ
	(envelope-from <stable+bounces-233052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:09:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF60E38BA75
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 18:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA434304CECA
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C3E35F165;
	Thu,  2 Apr 2026 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kDDu/tCp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C071DE4EF;
	Thu,  2 Apr 2026 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775145976; cv=none; b=fNWHlRdBT1xfQxYqLFSliRWywNvyKEOJr1aMHsZdJh35hcw7Uwr/bffWZPbslBD/vJKj3MDkxKrGKejbp8JywiU+O7e0CapNQO/yxe6Vf8HgfO38QrB0nQ+3PAlFQuJ9npX3iwbFzCUFmQ+8wzDi+3PNRfv9inbtOpZv/5T+sQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775145976; c=relaxed/simple;
	bh=ZAISLyKx3hRBzu3V3eZyGzioW3U4jUhg3L4QBR8J9N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEO9i+DeqCO1s/ExThzX8++aMES1K1Chrohvmoluy09VhGc4XOUOJ9A/e2zxutgEXLlRZ4NxFPFnvuLz+fWsgAbF1ro1pAFtfBJ4BaFSCEgaDmlgcK5YsGl5fGnoy5LIiNSzFjncz/1VlAUJu10Mc9R7GLLL22B1gsu57xM6AWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kDDu/tCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE90C19424;
	Thu,  2 Apr 2026 16:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775145975;
	bh=ZAISLyKx3hRBzu3V3eZyGzioW3U4jUhg3L4QBR8J9N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDDu/tCpcFRlhOQ57wBFJXOxfDP428xWxxrEdcBbY/pjQ+eFmWEPDxg5RO4jEyoBS
	 0CoQhC34ARujWzv8s4mds/Md7edtIAR3eu8Bofe97cjDBgYmaNjmnpNgt5bWDM8ymT
	 zpH3KkSmnXb4rP3/PNbnmGH7KdQRr/ONRgarOF54=
Date: Thu, 2 Apr 2026 18:06:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Alba Vives <sebasjosue84@gmail.com>
Cc: linux-fpga@vger.kernel.org, yilun.xu@linux.intel.com,
	conor.dooley@microchip.com, mdf@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fpga: microchip-spi: add bounds checks in
 mpf_ops_parse_header()
Message-ID: <2026040243-gratify-griminess-87a6@gregkh>
References: <20260402125446.3776153-3-sebasjosue84@gmail.com>
 <20260402153752.3793055-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402153752.3793055-1-sebasjosue84@gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233052-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.941];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BF60E38BA75
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 09:37:52AM -0600, Sebastian Alba Vives wrote:
> From: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> 
> mpf_ops_parse_header() reads several fields from the bitstream file
> and uses them as offsets and sizes without validating them against the
> buffer size, leading to multiple out-of-bounds read vulnerabilities:

Note, bitstream files are "trusted" so this really isn't a
"vulnerability" just a "someone with hardware permissions sent a stupid
file to the kernel" issue :)

> 1. There is no check that count is large enough to read header_size
>    at MPF_HEADER_SIZE_OFFSET (24). Add a minimum count check.
> 
> 2. When header_size (u8 from file) is 0, the expression
>    *(buf + header_size - 1) reads one byte before the buffer.
>    Return -EINVAL since retrying with a larger buffer cannot fix
>    a zero header_size.
> 
> 3. In the block lookup loop, block_id_offset and block_start_offset
>    advance by MPF_LOOKUP_TABLE_RECORD_SIZE (9) each iteration with
>    blocks_num (u8) controlling the count. With a small buffer, these
>    offsets exceed count, causing OOB reads via get_unaligned_le32().
>    Return -EAGAIN since a larger buffer may resolve the issue.
> 
> 4. components_size_start (from file) and component_size_byte_num
>    (derived from components_num, u16 from file) are used as offsets
>    into buf without validation, allowing arbitrary OOB reads.
> 
> Add bounds checks for all four cases.
> 
> Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
>  drivers/fpga/microchip-spi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Please look at these review comments:
	https://sashiko.dev/#/patchset/20260402153752.3793055-1-sebasjosue84%40gmail.com
this driver is "odd", but some of those comments seem correct.

thansk,

greg k-h

