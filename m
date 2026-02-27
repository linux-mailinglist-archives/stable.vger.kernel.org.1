Return-Path: <stable+bounces-219904-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAJjK/IVoWnoqAQAu9opvQ
	(envelope-from <stable+bounces-219904-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:56:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA8C1B2703
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 04:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EC2A30E83FA
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 03:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179933C1B3;
	Fri, 27 Feb 2026 03:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJk1ta4A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFC33A9CC;
	Fri, 27 Feb 2026 03:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164588; cv=none; b=BrzqO5azsN+NiPPkZOnWrHLl+F6F0F3J37vaelbJ40w+VTx4HfUCJCeWf08cy9lzU8zVP5X1SKVcKAZPDJFhP9CbVvhVr6rYxl26VBwN5yJ6eHtd2NOPPWXhx7jM99WiHgtiQ+4Kz8PMKj86CsF+gISi3NMrFeRmUHXFw/UyRWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164588; c=relaxed/simple;
	bh=z5xjxIuCEpexUDITWJ0ilvcIxUSMlU5ufgnavoF6tA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvHQc1wFqG9Ocso/qyQjyY6pEUpnV4e+9YHIHu5i7Utkm1FVrGOxy3rLaap2TPjAIO84t5i5qKO/m28T5a28OY4QAguuxU8/7WUDGnxFks/6xFG7xQM9O8c1nf5RQxGYfT7DVj6+62JGQi56CKsN2Uc92yjJBJFmiCvjkbKXMw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJk1ta4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A928C116C6;
	Fri, 27 Feb 2026 03:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772164587;
	bh=z5xjxIuCEpexUDITWJ0ilvcIxUSMlU5ufgnavoF6tA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJk1ta4ASdK91McYHdy5oBfPe9radvFqWvayT8OODWfwrt9QgxRP0NcGE8mKFP0OK
	 5DpKFIIDVaYYx3CIXX7ko3X6nD11zA66J09yrufa+G1vETQuMzoC7hSeDM7hhxvgpf
	 S+Jbec0bFt3uOT1XVJqEbHoV1G9L/SGEa4KV9hS62VLK+NO39ixsViQVXC+eftNLeX
	 gQ/kuzGvptBEEsG8BRmva3yZaExaaC3IsvCkb9tJOtbkG+wt6hnZiQiPAOsX3m7BTH
	 Qp1ngEDRNpQzgkoxV3xVXdTXtq/eWqU/SUFruliEGlnWkWsyKppBZygxfBqsB4IYdd
	 SW4ztcJJpjzAA==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	avigailx.dahan@intel.com,
	boolli@google.com,
	aaron.ma@canonical.com,
	decot@google.com,
	willemb@google.com,
	przemyslaw.kitszel@intel.com,
	sridhar.samudrala@intel.com,
	aleksandr.loktionov@intel.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	sreedevi.joshi@intel.com,
	Samuel.salin@intel.com,
	netdev@vger.kernel.org,
	sx.rinitha@intel.com,
	joshua.a.hay@intel.com,
	tglx@kernel.org,
	dima.ruinskiy@intel.com,
	emil.s.tantilov@intel.com,
	david.m.ertman@intel.com,
	stable@vger.kernel.org,
	brianvv@google.com,
	pmenzel@molgen.mpg.de,
	edumazet@google.com,
	horms@kernel.org,
	piotr.kwapulinski@intel.com,
	joe@dama.to,
	rafal.romanowski@intel.com,
	brett.creeley@amd.com,
	mschmidt@redhat.com,
	jacob.e.keller@intel.com,
	intel-wired-lan@lists.osuosl.org,
	vitaly.lifshits@intel.com,
	jedrzej.jagielski@intel.com
Subject: Re: [net,v2,02/12] idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL
Date: Thu, 26 Feb 2026 19:56:25 -0800
Message-ID: <20260227035625.2632753-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225211546.1949260-3-anthony.l.nguyen@intel.com>
References: <20260225211546.1949260-3-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	TAGGED_FROM(0.00)[bounces-219904-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.988];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 0EA8C1B2703
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL

This patch adds a NULL check for rx_qgrp->splitq.bufq_sets to prevent
kernel panic when idpf_rxq_group_alloc() fails during initialization and
the error path calls idpf_rxq_sw_queue_rel(). The panic was occurring
during device opening when adding to a bonding interface.

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index 761a77510467..59aafadae3d0 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -1341,6 +1341,9 @@ static void idpf_txq_group_rel(struct idpf_q_vec_rsrc *rsrc)
>   */
>  static void idpf_rxq_sw_queue_rel(struct idpf_rxq_group *rx_qgrp)
>  {
> +	if (!rx_qgrp->splitq.bufq_sets)
> +		return;
> +
>  	for (unsigned int i = 0; i < rx_qgrp->splitq.num_bufq_sets; i++) {
>  		struct idpf_bufq_set *bufq_set = &rx_qgrp->splitq.bufq_sets[i];
>
>  		for (unsigned int j = 0; j < bufq_set->num_refillqs; j++) {
>  			kfree(bufq_set->refillqs[j].ring);
>  			bufq_set->refillqs[j].ring = NULL;
                           ^^^^^^
This patch adds a NULL check for bufq_sets, but does the same issue
exist for refillqs?

Looking at idpf_rxq_group_alloc() in the same file, it first sets
bufq_set->num_refillqs to a non-zero value, then attempts to allocate
refillqs:

idpf_rxq_group_alloc() {
    ...
    bufq_set->num_refillqs = num_rxq;
    bufq_set->refillqs = kcalloc(bufq_set->num_refillqs,
                                  sizeof(struct idpf_sw_queue),
                                  GFP_KERNEL);
    if (!bufq_set->refillqs) {
        err = -ENOMEM;
        goto err_alloc;
    }
    ...
}

If this allocation fails, bufq_set->refillqs is NULL but
bufq_set->num_refillqs is non-zero. The error path calls
idpf_rxq_sw_queue_rel() which now passes the bufq_sets check but then
dereferences bufq_set->refillqs[j].ring in the inner loop.

The inner loop condition (j < bufq_set->num_refillqs) would be true,
causing the same NULL pointer dereference the patch is meant to prevent.

Would this need a similar check before the inner loop, similar to the
bufq_sets check added in this patch?

