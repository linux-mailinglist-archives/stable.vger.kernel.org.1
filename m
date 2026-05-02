Return-Path: <stable+bounces-242569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIieHntX9WkuKgIAu9opvQ
	(envelope-from <stable+bounces-242569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 03:46:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4844B0989
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 03:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E717300B186
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 01:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC92F1DF256;
	Sat,  2 May 2026 01:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cz9mzjC9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF6B175A92;
	Sat,  2 May 2026 01:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777686389; cv=none; b=oukXtEiyx+hht6wdQYHoVTJbGI/RpW0rnvJBj0gwUGRCtyIiwobWfbSYukcmc2CMGNFnUhI4kZ/l3P0pBuWlgtItAjK10eCYliQ4SAsnPkpnXR3VPL2rLJaI0CtNo3vvPzgbkDzGCGTDxTp3eS3bnbEzBN42M4+97ddvH6knN3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777686389; c=relaxed/simple;
	bh=FSdD8oUJ7WdmAf4RWSbcyqjJSm5a6GIZvCI9hOXAEI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHm3JDWbD9RIcU8F2Jg8asHA0JZbakWlDP1lXUv/x+GvQOejsO/AS6FQB9IaA+zZTJbLyeiZjA9c+e3NyJTY6Z3RAzX04JBAzH/OOVMLTDXf4q3vBnbuxnAeMTKlWRsZAI7R4Gd+WOiusrA7wJeCggHyuARY9JyDDXu2naC8MhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cz9mzjC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818DDC2BCB4;
	Sat,  2 May 2026 01:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777686389;
	bh=FSdD8oUJ7WdmAf4RWSbcyqjJSm5a6GIZvCI9hOXAEI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cz9mzjC9ssIV8Ma6Jo9XVKE/FbBqp0BruylfaR05u39GEngrYTDUaBL444jp+Kh9e
	 K6fDKxZqqbdcsmPgBQirlrWAk2QVplc98FTh42hwhiubeDVvBUQNQ7rMdmQ8f6guS8
	 5xsHOOE9ABHIoJPPGXDzbh84Szq69kMfmHPE/lTA4ux1u8UtBGrCHX1PZiAcwSsXBg
	 Vj+BDWfkkK/fpBOl6+atj2NRClKm7VSUrkHpMnz7wwmfj3hYPBHCtmBo1p9209aZ+k
	 APjy6TwdMQLk4T1MpXsLYzMqFFYKW0P1cLiyqpuFXM1dUylA8PTf1WsFT7QVkEZtie
	 sCD+zpQDec/jQ==
From: Jakub Kicinski <kuba@kernel.org>
To: evg28bur@yandex.ru
Cc: Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kees@kernel.org,
	horms@kernel.org,
	darinzon@amazon.com,
	bhelgaas@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: fix division by zero in qed_init_wfq_param when all vports configured
Date: Fri,  1 May 2026 18:46:27 -0700
Message-ID: <20260502014627.3677476-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429151136.19308-1-evg28bur@yandex.ru>
References: <20260429151136.19308-1-evg28bur@yandex.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1E4844B0989
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[yandex.ru];
	TAGGED_FROM(0.00)[bounces-242569-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
qed: fix division by zero in qed_init_wfq_param when all vports configured

This patch adds a guard for non_requested_count == 0 in qed_init_wfq_param()
to prevent a division-by-zero when every vport already has the configured
flag set, returning -EINVAL in that case.

> diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
> index 42c6dcfb1f0f..b287e04c8adc 100644
> --- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
> +++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
> @@ -5105,6 +5105,13 @@ static int qed_init_wfq_param(struct qed_hwfn *p_hwfn,
>  
>  	total_left_rate	= min_pf_rate - total_req_min_rate;
>  
> +	if (non_requested_count == 0) {
> +		DP_VERBOSE(p_hwfn, NETIF_MSG_LINK,
> +			   "All %d vports are already configured for WFQ, no unconfigured vports to distribute remaining bandwidth\n",
> +			   num_vports);
> +		return -EINVAL;
> +	}
> +
>  	left_rate_per_vp = total_left_rate / non_requested_count;

Is returning -EINVAL here the right behavior when non_requested_count
reaches zero, or does it turn a division-by-zero into a functional
regression in at least two reachable paths?

Path 1: qed_configure_vport_wfq() configuring the final vport.

Looking at the counting logic in qed_init_wfq_param():

    for (i = 0; i < num_vports; i++) {
        u32 tmp_speed;

        if ((i != vport_id) &&
            p_hwfn->qm_info.wfq_data[i].configured) {
            req_count++;
            ...
        }
    }

    /* Include current vport data as well */
    req_count++;
    total_req_min_rate += req_rate;
    non_requested_count = num_vports - req_count;

When num_vports - 1 vports are already configured and the user is
explicitly configuring the last remaining one, the loop counts
num_vports - 1 configured vports (skipping vport_id), then the
unconditional req_count++ for the current vport makes req_count ==
num_vports, so non_requested_count == 0.  With this patch the call
through qed_configure_vport_wfq() -> __qed_configure_vport_wfq() ->
qed_init_wfq_param() now rejects that operation with -EINVAL.

Path 2: __qed_configure_vp_wfq_on_link_change() with all vports
configured.

    for (i = 0; i < p_hwfn->qm_info.num_vports; i++) {
        ...
        if (!p_hwfn->qm_info.wfq_data[i].configured)
            continue;

        rate = p_hwfn->qm_info.wfq_data[i].min_speed;
        use_wfq = true;

        rc = qed_init_wfq_param(p_hwfn, i, rate, min_pf_rate);
        if (rc) {
            DP_NOTICE(p_hwfn,
                      "WFQ validation failed while configuring min rate\n");
            break;
        }
    }

    if (!rc && use_wfq)
        qed_configure_wfq_for_all_vports(p_hwfn, p_ptt, min_pf_rate);
    else
        qed_disable_wfq_for_all_vports(p_hwfn, p_ptt, min_pf_rate);

If every vport has been configured, each iteration re-validates via
qed_init_wfq_param() and now hits the new -EINVAL return, so the loop
breaks, rc is non-zero, and the else branch calls
qed_disable_wfq_for_all_vports() on every link-state change.

Would it be more appropriate to skip just the division and the
subsequent percent-of-min_pf_rate check when non_requested_count is
zero, and then fall through to record wfq_data[vport_id] and return 0
(the final distribution loop is then naturally a no-op because every
vport hits the configured continue)?

One additional question on the commit metadata: the same function was
previously patched for an adjacent num_vports < 2 division-by-zero in
commit 1a9dc5610ef8 ("qed/qed_dev: guard against a possible division by
zero"), which carried a Fixes: bcd197c81f63 ("qed: Add vport WFQ
configuration APIs") tag.  Since this patch closes a second
division-by-zero path in the same function with the same root cause,
would it be worth adding a matching Fixes: bcd197c81f63 tag so stable
backport tooling picks it up?
-- 
pw-bot: cr

