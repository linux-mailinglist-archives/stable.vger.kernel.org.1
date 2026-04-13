Return-Path: <stable+bounces-236095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNDSAJL53GnXYgkAu9opvQ
	(envelope-from <stable+bounces-236095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:11:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5923ED1E4
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD4A330ABE86
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCED23D3CFC;
	Mon, 13 Apr 2026 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ/rI1Uv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793853D523E;
	Mon, 13 Apr 2026 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776089053; cv=none; b=EZM8rTuMDsd/kMoBMh1nCTjaQ1whqNMJLAUWKed/TjbyIDpxZnlW+6mG+iN9M81NzIggnoSahQXbVZYbwbxW1XghEkd49lY97CDtltW9blb3gwDHnK+Pb5Zl317ADZ+/ezWFrE5XhdDqj/c0fwvfAUXZNtG5qm8MZ7m0XaYXWzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776089053; c=relaxed/simple;
	bh=PZPocgNq/t+BoK9YO0g4NcHOvsEnwrcuzcTMgVzbDRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lySxyctB2xFIXBFB4+OIAuG0ypwQZMERc/vAVEH7MYBWnvgyd9jIVAjDdnn/n1WSr3A/JMFA/jJ2v1oHxH/lDgFh/nVko6ULyG9JQZevYjLnNiCh4mh0by/K5NM4fZCuH1YWTn3vklAn+IBx443IAwy028HPwP/pKjTl+X2olqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ/rI1Uv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9062CC2BCAF;
	Mon, 13 Apr 2026 14:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776089052;
	bh=PZPocgNq/t+BoK9YO0g4NcHOvsEnwrcuzcTMgVzbDRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQ/rI1UvHOQ+roW0A6IDSgDJ1b0pLaQvXe5zqkw+FVGVpWk8EG1wK8fGIagzv6Mim
	 4O8BpTNUTZPrNHweOqewPuZft/QR4+jHezJ/glnRr/F91wRA6HcCOzM7ormX8x8lds
	 dR9IPCfYKcSZNwExOtF+Y78WtWLmejYpNQ92Ya7SH8y2HcZL4Tf4TVsEw+uehCRszU
	 lUy0lOI5KQVDIewL3zdcwlsxR2nJw6h0XZda++ue09kUXr6LITbszedrYV4YeMqXUi
	 D1ylNUlHp0S5hV4a0Xk971C+ZxKs2YgRY1oIAkHAgxmQ7oEVUsrCPzOWi7WeIfzBL4
	 E/Fmsl2sCLMMQ==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 6/6] ixgbe: fix integer overflow and wrong bit position in ixgbe_validate_rtr()
Date: Mon, 13 Apr 2026 15:03:07 +0100
Message-ID: <20260413140307.715409-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408131154.2661818-7-aleksandr.loktionov@intel.com>
References: <20260408131154.2661818-7-aleksandr.loktionov@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236095-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A5923ED1E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ixgbe: fix integer overflow and wrong bit position in ixgbe_validate_rtr()

This commit fixes two bugs in ixgbe_validate_rtr() by masking the
traffic-class field properly before assigning it to a u8, and correctly
shifting the mask for clearing out-of-bounds entries.

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 5ff462a848feb..8ebf717ce4017 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -9782,11 +9782,12 @@ static void ixgbe_validate_rtr(struct ixgbe_adapter *adapter, u8 tc)
>  	rsave = reg;
>  
>  	for (i = 0; i < MAX_TRAFFIC_CLASS; i++) {
> -		u8 up2tc = reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT);
> +		u8 up2tc = (reg >> (i * IXGBE_RTRUP2TC_UP_SHIFT)) &
> +			   IXGBE_RTRUP2TC_UP_MASK;
>  
>  		/* If up2tc is out of bounds default to zero */
>  		if (up2tc > tc)

This wasn't introduced by this patch, but is there a pre-existing off-by-one
error in this bounds check?

If tc represents the number of enabled traffic classes (e.g., 4), the valid TC
indices would be 0 through tc - 1. If up2tc equals tc, it would be out of
bounds, but the condition up2tc > tc will evaluate to false and the invalid
mapping won't be cleared.

Could this allow an invalid UP-to-TC mapping to persist in the hardware
register, potentially causing received packets to be mis-steered to an
uninitialized or non-existent traffic class queue?

Should the condition be corrected to ensure up2tc is strictly less than tc
when tc > 0?

> -			reg &= ~(0x7 << IXGBE_RTRUP2TC_UP_SHIFT);
> +			reg &= ~(IXGBE_RTRUP2TC_UP_MASK << (i * IXGBE_RTRUP2TC_UP_SHIFT));
>  	}

