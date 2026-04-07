Return-Path: <stable+bounces-233478-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wB5ZJ7FZ1GlLtQcAu9opvQ
	(envelope-from <stable+bounces-233478-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:11:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCD03A8987
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 03:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2213302F727
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 01:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9423B1D514E;
	Tue,  7 Apr 2026 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMul48R1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54985175A99;
	Tue,  7 Apr 2026 01:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524263; cv=none; b=Wxv/E8L0lmxqFp4h+8Ddmd50ECu6ZxMAprYd1Vb8Xj6uuCzDn0aFsZxzisjSniENuvoh9uZmhXbMAhQd/yRv0PYFZV6IexON35dZbWrRdQOL1H5e3pYp3EtEA71U9SWwPOJZ2Q4cFzN9VzG6xeiE7isFO3nBFWgSgRxTo19XrEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524263; c=relaxed/simple;
	bh=ZXj38vIObp9F072c7DsHoOrcRUp7uumJB+k9WQ9WWSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E1ZBpxeoNqNF16PdR34m/CYHNqeEpkLuHx2uJ1CRAjGQtDBZysKjAUPgSvg8GQ6yuW11ZxD0b+1TagLqB0MMy+FHI8/uQsVxunBz84ghjn+tlri0NI5D4BNVhdZn7k5m2/srGzWlv5bMOJmn8gfNvCb9y4JcU1cQJE966tZs748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMul48R1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B81C4CEF7;
	Tue,  7 Apr 2026 01:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524262;
	bh=ZXj38vIObp9F072c7DsHoOrcRUp7uumJB+k9WQ9WWSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VMul48R1xrmVSQU7SBY3Ame7NN/BxhhhXrJ8nJdd1y9ECZh/Ee6I5kwBodFkL5Cxr
	 wk+qe9N+k0XggF+nhOO2YZ7GEEqpHCb2ke5/RwUT+/x6H5emeaGBG863JtzfFTDWli
	 vGvJ6fMpvkicREeMkDNN4k9e3F8WUeFEZbZ1QNbl2iu64olH5w46qwq/qcA6pcrp5s
	 2wyoBFAPaHWfbXhsAhucrPot5fbpaR3/KM6Ayv3SzxswEgNPt4dPk+/8I8GuhoXw9k
	 JOmIj+RqJozXtcVLVFo43QYzAao+slLywxyheTIRdg2PD+JC3CbiX0xgtQrT7YmwPu
	 v0nE3rVvUHsKQ==
Date: Mon, 6 Apr 2026 18:11:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <mchan@broadcom.com>
Cc: Junrui Luo <moonafterrain@outlook.com>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Prashant Sreedharan <prashant@broadcom.com>, Jeffrey
 Huang <huangjw@broadcom.com>, Eddie Wai <eddie.wai@broadcom.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Yuhao Jiang
 <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] bnxt_en: fix out-of-bounds write in
 bnxt_alloc_vf_resources()
Message-ID: <20260406181101.10b1ddee@kernel.org>
In-Reply-To: <SYBPR01MB78817B7EE349BB2CF0FC6873AF53A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB78817B7EE349BB2CF0FC6873AF53A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233478-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0FCD03A8987
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 17:57:10 +0800 Junrui Luo wrote:
> bnxt_alloc_vf_resources() derives the number of DMA pages for VF HWRM
> command buffers from num_vfs and stores them in the fixed-size arrays
> hwrm_cmd_req_addr[4] and hwrm_cmd_req_dma_addr[4]. The vf_event_bmap
> bitmap is similarly fixed at 128 bits.
> 
> If num_vfs exceeds 128, the allocation loop writes past the arrays,
> corrupting adjacent fields in bnxt_pf_info.
> 
> Add BNXT_MAX_VFS to cap num_vfs at 128, matching the existing array and
> bitmap capacity.
> 
> Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Quick Google search reveals that BCM957608 is supposed to support
1k VFs so I suspect Broadcom may be scrambling for a real fix here.
I'll drop this from patchwork.

Michael, if my hunch is correct please make sure to credit the reporter.
If you just need more time to validate - please take this in and repost
once ready. patches older than 1 week "fall out" of our patch tracking
:(

