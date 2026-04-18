Return-Path: <stable+bounces-238605-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFXnIuvU42mRLAEAu9opvQ
	(envelope-from <stable+bounces-238605-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 21:00:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2728B422024
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 21:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EA00302E41D
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 19:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BD830C35C;
	Sat, 18 Apr 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qovQVO+C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799CB238150;
	Sat, 18 Apr 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538846; cv=none; b=OPM5piZU1OgOVdjLsQOBwTnlINAJQdKJSGag1DoOkuZ+4nhNGkylnEr3yyAI3F/4hx+0ucBWsgX2+4Po9eBuBzwUqSusoI0/MEpzXZVW5uu4KYrkiRVdmZ3EVM0zLCxNWZFsX5ROywd8IVHcAJd5oUo4/4NDzwrOdx37KpTCrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538846; c=relaxed/simple;
	bh=ZArGxMxvgYerGYzwBIhcXeSFpQKPLxziiu+4LOWVfj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXjYc44s6i8FfdKHaHa9PBPCIeANIxM4ajmvwYMf13SlfJLwDBMjk/5sW0Gc5vvJNFmnv95dhi1DqU/Qq0eEc1qadCgsqevB9Gl8hXJAp3149PCJXeMv6PeQ050ST/WqyQzaXkC3YYF1PiyVMHcK6pAhvCTccPjpkfWfIp1xkX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qovQVO+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA30FC19424;
	Sat, 18 Apr 2026 19:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776538846;
	bh=ZArGxMxvgYerGYzwBIhcXeSFpQKPLxziiu+4LOWVfj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qovQVO+Cx7IysAYGxHLGre7O4fpGrARq7KUmVyhz+XDPvuRpS7OaXrw7i85/hAZ9W
	 8DGmA8FN04yoh6lDO7L1x1tn04TrWZMK0DHr1gpBoFknfj4dXSeAYGdtJ4DYK7TRjA
	 naKDShd8yMFP8IUtzMwD0SXdZcE7jr2qcFsqy7Tl8ol618LR/g6iExagOjvBRoTozg
	 6UjpTjefHifaEqxpNcfA0hQDDhjEgMNl0qxM54NUeT6WBN4npyeGg3wuqHSWUDT7hh
	 Y6LYDRkAy+o/KMS/kEWxUi6iIAw7b4nLuG/MLvGYmWzlVAS7UP6iYeMoJPGBphQotl
	 00Zdjbh2NCKBw==
From: Jakub Kicinski <kuba@kernel.org>
To: jacob.e.keller@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	emil.s.tantilov@intel.com,
	stable@vger.kernel.org,
	aleksandr.loktionov@intel.com,
	patryk.holda@intel.com
Subject: Re: [PATCH net v2 11/12] idpf: fix xdp crash in soft reset error path
Date: Sat, 18 Apr 2026 12:00:20 -0700
Message-ID: <20260418190019.194263-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416-iwl-net-submission-2026-04-14-v2-11-686c33c9828d@intel.com>
References: <20260416-iwl-net-submission-2026-04-14-v2-11-686c33c9828d@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238605-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2728B422024
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

Jakub: I'll drop this patch and apply the rest.
---
idpf: fix xdp crash in soft reset error path

This commit fixes a NULL pointer dereference in idpf_vport_open() when
soft reset fails by restoring vport->xdp_prog to the old value. It also
updates the restart check to use IDPF_VPORT_UP instead of netif_running().

Cc: stable@vger.kernel.org

> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -488,6 +488,7 @@ static int idpf_xdp_setup_prog(struct idpf_vport *vport,
>  				   "Could not reopen the vport after XDP setup");
>  
>  		cfg->user_config.xdp_prog = old;
> +		vport->xdp_prog = old;

Does this also need to roll back vport->num_xdp_txq?

Because idpf_initiate_soft_reset() overwrites the vport struct with the new
queue configuration before failing, vport->num_xdp_txq might remain > 0
while vport->xdp_prog is restored to NULL.

When the interface is brought up, idpf_xdpsqs_get() evaluates
idpf_xdp_enabled(vport) as false and returns early without allocating the
NAPI timers (xdpsq->timer).

Could another interface redirect XDP frames via ndo_xdp_xmit, bypassing the
check because vport->num_xdp_txq > 0, and cause a NULL pointer dereference
in libeth_xdpsq_queue_timer() during idpf_xdp_tx_finalize()?

>  		old = prog;
>  	}

Is this old = prog assignment leading to a double-put of the BPF program?

If idpf_initiate_soft_reset() fails, this error path drops a reference to
the newly provided prog when it calls bpf_prog_put(old) right after this
block.

Since the function returns an error code to the core network stack, won't
dev_xdp_install() in net/core/dev.c also explicitly call bpf_prog_put(prog)
assuming ownership of the error cleanup?

Could this underflow the reference count and cause a use-after-free?

[ ... ]

> diff --git a/drivers/net/ethernet/intel/idpf/xsk.c b/drivers/net/ethernet/intel/idpf/xsk.c
> --- a/drivers/net/ethernet/intel/idpf/xsk.c
> +++ b/drivers/net/ethernet/intel/idpf/xsk.c
> @@ -568,7 +569,8 @@ int idpf_xsk_pool_setup(struct idpf_vport *vport, struct netdev_bpf *bpf)
>  		return -EINVAL;
>  	}
>  
> -	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
> +	restart = idpf_xdp_enabled(vport) &&
> +		  test_bit(IDPF_VPORT_UP, np->state);
>  	if (!restart)
>  		goto pool;

Does this function leave the queue pair permanently disabled if the pool
setup fails?

If restart is true, the queue pair is disabled via:
    idpf_qp_switch(vport, qid, false);

If the subsequent call to libeth_xsk_setup_pool() fails, the function
returns early:

    ret = libeth_xsk_setup_pool(vport->netdev, qid, pool);
    if (ret) {
        ...
        return ret;
    }

Does this early return bypass the idpf_qp_switch(vport, qid, true) call
expected later, causing a permanent partial loss of connectivity until the
interface is manually restarted?

