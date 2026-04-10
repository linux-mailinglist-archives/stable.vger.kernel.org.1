Return-Path: <stable+bounces-235640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IN6+Bhki2WkqmggAu9opvQ
	(envelope-from <stable+bounces-235640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:15:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B330A3DA3A0
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 18:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D61B330A11E9
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4A33A453B;
	Fri, 10 Apr 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dikAX2jN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FF3D9023;
	Fri, 10 Apr 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837410; cv=none; b=N3Oa6QCgaOLTjcDXkJkZQira0IaSAnisHPJaQJxGzn7zwaJ4jPpUBkwiEQNu6eVBeRFi7wcKE2Htp9LVWmBTdZbMa9U6Gi2ut5S8m/wDLtLkaLaKsF3dCSjf/gqRxIMrVhB344GBfKvpHuy6VtnUMhITrN/ukYfedfQ8H8kZPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837410; c=relaxed/simple;
	bh=XNd1cTBZzPYsM3r8iicSJfeTerWVBa/bMKGdjtzQPyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iprnRwX7XIqR0BHn9Ge8b2Yo+F/NYdoDc9G+8FTu5bVIsYcggnhtUaZHQTzK/ahTJ8Lc9/LpPnCveAMbVYbuXlyoUn1EhxkpTioR7YkVmfCBwBYMIbzGf1o0IRR0t3OufNXpXvR8Vxrmxv5jYPy3n2O4db6vAjx2xD/bXU/ZTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dikAX2jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D1AC2BC87;
	Fri, 10 Apr 2026 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775837410;
	bh=XNd1cTBZzPYsM3r8iicSJfeTerWVBa/bMKGdjtzQPyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dikAX2jNfpxNoAOX+uTymI6QYeuCsrsBQgOBtHsVUAso52baCl9MBqdsCZ2XaXyrw
	 hIhA5T3q6YtWDoe5vlsQlHHHvb3M8+ht+sP3SGjAJuYbh+Wn3MCZI5pXy5NeN+yHCU
	 6iVIpIjKPg/A/bYg9caHMl2tOSalE/6kPVaZA0KfZxbaUrsRE3E3oO49loLRK4ytde
	 3KA7ZZ5iLVlXUayev8cpd2cfxZC6zmtp+IWyBu7DS6E257gBMceX7GolpRW0Nb3P3O
	 wu5PABc390llWcX75xbZ67McfimpbEhFzJWXh2fgiRNzFTW/0fEDfQmwrkuBgxyhAa
	 q0Tun0pOMkfAA==
From: Simon Horman <horms@kernel.org>
To: mashiro.chen@mailbox.org
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	ben@decadent.org.uk,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/3] net: rose: fix out-of-bounds read in rose_parse_ccitt()
Date: Fri, 10 Apr 2026 17:10:01 +0100
Message-ID: <20260410161001.644157-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407171600.102988-4-mashiro.chen@mailbox.org>
References: <20260407171600.102988-4-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235640-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B330A3DA3A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: rose: fix out-of-bounds read in rose_parse_ccitt()

This commit adds bounds checking to rose_parse_ccitt() for 0xC0-class
facilities to prevent an out-of-bounds read when parsing call request
frames. It ensures the remaining buffer contains enough bytes before
accessing the facility data.

Cc: stable@vger.kernel.org

> diff --git a/net/rose/rose_subr.c b/net/rose/rose_subr.c
> index 4dbc437a9e229..a902ddeddc5bd 100644
> --- a/net/rose/rose_subr.c
> +++ b/net/rose/rose_subr.c
> @@ -370,6 +370,9 @@ static int rose_parse_ccitt(unsigned char *p, struct rose_facilities_struct *fac
>  			if (l < 10 || l > 20)
>  				return -1;
>  
> +			if (len < 2 + l)
> +				return -1;
> +
>  			if (*p == FAC_CCITT_DEST_NSAP) {
>  				memcpy(&facilities->source_addr, p + 7, ROSE_ADDR_LEN);
>  				memcpy(callsign, p + 12,   l - 10);

Can asc2ax() read uninitialized stack memory here?

If a facility length of l = 17 is provided, memcpy() copies 7 bytes to the
callsign array, and the 8th byte is set to null, leaving the remaining
bytes uninitialized.

When asc2ax() processes this, it consumes the first 6 bytes in its loop.
The pointer then advances past the null byte, and the check if (*s != '\0')
will read the 9th byte, which contains uninitialized stack garbage.

Would zero-initializing the callsign array prevent this?

This regression wasn't introduced by this patch, but exists in the modified
function's loop termination logic:

net/rose/rose_subr.c:rose_parse_ccitt() {
    ...
    } while (*p != 0x00 && len > 0);
}

Due to short-circuit evaluation, if a facility consumes the exact remaining
bytes so that len becomes 0, will the loop dereference the pointer p before
checking if len > 0?

This would cause an out-of-bounds read past the valid facility data.

Should the condition be swapped to while (len > 0 && *p != 0x00)?

This regression wasn't introduced by this patch, but resides in the same
parsing sequence:

net/rose/rose_subr.c:rose_parse_facilities() {
    ...
    facilities_len = *p++;
    if (facilities_len == 0 || (unsigned int)facilities_len > packet_len)
    ...
}

Since packet_len represents the total remaining bytes including the 1-byte
length prefix itself, and the length byte has already been consumed, only
packet_len - 1 bytes actually remain for the facility data.

If an attacker crafts a packet where facilities_len == packet_len, will
this validation incorrectly pass?

The parsing loops will then expect packet_len bytes but only have
packet_len - 1 available, leading to an out-of-bounds read.

Could this check be updated to use facilities_len >= packet_len?

This regression wasn't introduced by this patch, but violates networking
subsystem safety rules regarding socket buffers.

Does the rose subsystem safely linearize socket buffers before dereferencing
packet headers?

Throughout the subsystem, including the parsing functions and routing logic,
packet offsets are accessed directly from skb->data based only on skb->len.

Since skb->len includes paged fragments, if a packet is fragmented such
that skb_headlen(skb) is smaller than the accessed offset, could
dereferencing skb->data trigger a page fault or read garbage memory?

Would adding pskb_may_pull() checks before accessing headers resolve this?

