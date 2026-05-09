Return-Path: <stable+bounces-244935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IYGNF8S/2lU1wAAu9opvQ
	(envelope-from <stable+bounces-244935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 12:54:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3BE4FF694
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 12:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E677300EFB5
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 10:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472C32ED39;
	Sat,  9 May 2026 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flaat7pt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3452F8EB0;
	Sat,  9 May 2026 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778324057; cv=none; b=JccxLtHDJu6B9Z9LFpF3FLcgTeKuUpIhM9v+ngmd5V11QUUUx1Hc26sifrf8Mh34Hea5hGfJjazUKhDp0gLEs3s80smOAuxN6JufzrVbZRFkeI8E4ZFwam0wcKwekUQgKyO1p5VxIr7LiikbZ4TH+7RDocsxTA49YSLKsKWLrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778324057; c=relaxed/simple;
	bh=M2vfiUDgWfCAo7yTAK+CXL6KMCLvo1p4h1crlYTFDN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mHrXuFHOTPrcjsJ5leX7swaWn00hxNbNAH2utNe8LcISCf+Z/Q5jYxfVzkDhM2F4vVkml9w0BTUV+USrzga/Vmm+m5TZmM/bhKsVb+7+5/CKm9CIo2o56tFxbB5Z0+7TNXN3mkHEjo/3etexV1xeYhV6BMqwmZJal9VQ/CMDe28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flaat7pt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39FDC2BCB4;
	Sat,  9 May 2026 10:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778324057;
	bh=M2vfiUDgWfCAo7yTAK+CXL6KMCLvo1p4h1crlYTFDN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flaat7ptRMa7G3wceebGMJL9r9EkUrvPkCOGnV1tC7K9YPMTgeM9ywoXBrckoZkc7
	 Vrzs+1TOgcOkcHLZW9T6j0fQBBIpLw/kkI01Stue5by6V6F8bjUWPRZ+dP6VyABul7
	 k4zGePeQuRAWb1sf+AABSDJvs1kDMUTyeTQUwzAjQ//hz6NesUqzw9W9NlUzzbM1+i
	 ySPNzTklOKTLJDj8SBC4cK1CjYYzcKCS3qmhUTT3cPk3khCiZPBx8egW5vjYOqpL2o
	 rbPhmP6z6kONiGM//DI8VfM9/dir4XHaW3L+a42STwy8yLEDqXpb7pZG7Kz+OxpvSl
	 AKBklcsKNyDaQ==
Date: Sat, 9 May 2026 11:54:12 +0100
From: Simon Horman <horms@kernel.org>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, pabeni@redhat.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, david+nfc@ixit.cz
Subject: Re: [PATCH v7] nfc: hci: fix out-of-bounds read in HCP header parsing
Message-ID: <20260509105412.GP15617@horms.kernel.org>
References: <20260505170712.96560-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505170712.96560-1-ashutoshdesai993@gmail.com>
X-Rspamd-Queue-Id: 6B3BE4FF694
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244935-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable,nfc];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 05:07:12PM +0000, Ashutosh Desai wrote:
> Both nfc_hci_recv_from_llc() and nci_hci_data_received_cb() read
> packet->header from skb->data at function entry without first checking
> that the buffer holds at least one byte. A malicious NFC peer can send
> a 0-byte HCP frame that passes through the SHDLC layer and reaches
> these functions, causing an out-of-bounds heap read of packet->header.
> The same 0-byte frame, if queued as a non-final fragment, also causes
> the reassembly loop to underflow msg_len to UINT_MAX, triggering
> skb_over_panic() when the reassembled skb is written.
> 
> Fix this by adding a pskb_may_pull() check at the entry of each
> function before packet->header is first accessed. The existing
> pskb_may_pull() checks before the reassembled hcp_skb is cast to
> struct hcp_packet remain in place to guard the 2-byte HCP message
> header.
> 
> Fixes: 8b8d2e08bf0d ("NFC: HCI support")
> Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
> Cc: stable@vger.kernel.org
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>

FTR: There is an AI-generated review of this patch available on sashiko.dev.
It seems to me that all of the issues flagged there are pre-existing and
need not impede progress of this patch.

