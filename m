Return-Path: <stable+bounces-238596-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cE1zFcSx42kQKAEAu9opvQ
	(envelope-from <stable+bounces-238596-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 18:31:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E454219B1
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 796DE300D46B
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E5309EEB;
	Sat, 18 Apr 2026 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7uKLCcL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F7B2B9B7;
	Sat, 18 Apr 2026 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529829; cv=none; b=YaoVJox0ar74XSA50Ex1YuOMWRaPe1I+hsehCEmN9WjTSov/zT5RDFk5zndE0Dz/hwGpzg8SeJGdp0xPmuCGRp072C/C7ks9+xhmWY9M04H8tKTWdRLNxZTIL57QezG2xIjIi6jMZxcaBlQMQIiN65q9u1MaRZn2iEM+zps4ibQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529829; c=relaxed/simple;
	bh=W7O5PbCRUz8QfAQcbD7i1/n5mpJXzGzl/oLb9BuD2R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojjHcpV6Rm263waozz7JeCSIoIfkgGdCwv51l/OdxO8aQV6Bf2n+vuuiKnZekVV9g7yrJ0B45OqmJB16EOT7CHFyP9Fbpmr72J1nByw0kBlDvk3P25nyVQqZ3SMITUsc1s4yCxoqzJ2ayzpWsl9paitlQl2l7HMYFHFiIhWOnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7uKLCcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB49C19424;
	Sat, 18 Apr 2026 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776529828;
	bh=W7O5PbCRUz8QfAQcbD7i1/n5mpJXzGzl/oLb9BuD2R0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7uKLCcLQyAozXCkFH7fmEXV0/WF0tdYSM4YsWyNuAEEH06HnzBAK3vocI6kBwnPf
	 r4IR15jdd229vxnCMkTPCcHYVXmIaTog8x6cp9sFSO8oFEF+5S8wSC9/VGWNwj82WV
	 nWqxBbqZ0LQ68D6xshLVhC/CEcoEhhCNOFQUZfk7OEJNtpmslVVWB69ksA1SnSUyS8
	 rVApZk5AcCyT1qVGO8DnKPvVSEulsUomHDffCMtFpuftkKhnnMz3jj+DtO+7HPno4X
	 GQs4H4//WlajW7Y7MxZX0PeyZ9owo7tCmNO1kHjvPYkK8jDKTnxB3QkIVXDj6ynYYV
	 MCL6+X8cXKtkA==
Date: Sat, 18 Apr 2026 17:30:24 +0100
From: Simon Horman <horms@kernel.org>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, pabeni@redhat.com, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 net] nfc: hci: fix out-of-bounds read in HCP header
 parsing
Message-ID: <20260418163024.GH280379@horms.kernel.org>
References: <20260416051522.4154698-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416051522.4154698-1-ashutoshdesai993@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238596-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Queue-Id: 98E454219B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 05:15:22AM +0000, Ashutosh Desai wrote:
> nfc_hci_recv_from_llc() and nci_hci_data_received_cb() cast skb->data
> to struct hcp_packet and read the message header byte without checking
> that enough data is present in the linear sk_buff area. A malicious NFC
> peer can send a 1-byte HCP frame that passes through the SHDLC layer
> and reaches these functions, causing an out-of-bounds heap read.
> 
> Fix this by adding pskb_may_pull() before each cast to ensure the full
> 2-byte HCP header is pulled into the linear area before it is accessed.
> 
> Fixes: 8b8d2e08bf0d ("NFC: HCI support")
> Fixes: 11f54f228643 ("NFC: nci: Add HCI over NCI protocol support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> V4 -> V5: fix whitespace damage
> V3 -> V4: add Fixes tags
> V2 -> V3: drop redundant checks from nfc_hci_msg_rx_work/nci_hci_msg_rx_work;
>           remove incorrect Suggested-by tag
> V1 -> V2: use pskb_may_pull() instead of skb->len check
> 
> v4: https://lore.kernel.org/netdev/177614425081.3600288.2536320552978506086@gmail.com/
> v3: https://lore.kernel.org/netdev/20260413024329.3293075-1-ashutoshdesai993@gmail.com/
> v2: https://lore.kernel.org/netdev/20260409150825.2217133-1-ashutoshdesai993@gmail.com/
> v1: https://lore.kernel.org/netdev/20260408223113.2009304-1-ashutoshdesai993@gmail.com/
> 
>  net/nfc/hci/core.c | 5 +++++
>  net/nfc/nci/hci.c  | 5 +++++
>  2 files changed, 10 insertions(+)

Reviewed-by: Simon Horman <horms@kernel.org>

Review of this patch at Sashiko.dev flags a number of related problems in
this code. I believe none of them introduced by this patch. And that
they can all be treated as area for possible follow-up.


