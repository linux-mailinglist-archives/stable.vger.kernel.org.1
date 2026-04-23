Return-Path: <stable+bounces-240533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PE5B9xv6mlBzQIAu9opvQ
	(envelope-from <stable+bounces-240533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:15:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B55BD456966
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 21:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97AD33023C92
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 19:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F03A4539;
	Thu, 23 Apr 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pii5z+9K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D963A3E7A;
	Thu, 23 Apr 2026 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971532; cv=none; b=WSO3YWdM+Nt56hhclELK7rkk+qHyXSs6az+CgkcEn2tltS9EdyXEDj1kVEuPh4nrYm5A+JwZC3lb0nAIZSAKcRlhIGZ8CqQbfduVlK+Y1F+dqW3eqGvX/Y8TVecZVmwU/vIKiz8K7DWyFZ50D0Bs0STqds+HInxi19FSXBmpcpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971532; c=relaxed/simple;
	bh=g6vNzNCJwHf3dC57rvt74SpjXQGmzPRvLwlJDi+jNL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etKVD47OIHSVMsENsRJYymXLDwbyT9z1feCnQvUF3XFDZVLmtPfJi/t6QNz42/QfURS7Otj5LRtdYiPFEcDWC4YVZTcSMoqBnMS+ZhYVluOPC6rHvrDA1/cbynOgT0OUoAM9aPd/uLFkSuwC2YY44Ai5HF9KemPUD0nzDRSdyQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pii5z+9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD227C2BCB2;
	Thu, 23 Apr 2026 19:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971532;
	bh=g6vNzNCJwHf3dC57rvt74SpjXQGmzPRvLwlJDi+jNL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pii5z+9KlKCJy2TSmufYR7tzZYcGnKRm0ek7ZJjmribXO5UdRW4TS7UzHn0TwkQk3
	 SUkKUzp1IzrP5GjWpHxKdvnLiiSGJGnNi+RhaZvdRNLm7U+E4JK/YvBbRy472Xyh/V
	 i2GptTta91KlSmjMofzFiVuczAPjQqr9W06W52tjg/exbHqqIo3ZPZ3x6V7T9YbwNG
	 vMvrTu2c5DuRInsR6wIGols9gL6Am+dhJz2JmDeN24gp16zX4H1ZPSs4cBwmxTpXgZ
	 UdayjOC9qPO/P0hBY1iF0AvgeSiE8BQOTxmj3ii67MtZDqys4HFzvza28pyORTD40C
	 jX1WnFuUCVfTA==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.bommarito@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	sam@mendozajonas.com,
	fercerpav@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 6/6] net/ncsi: validate GP payload lengths before parsing
Date: Thu, 23 Apr 2026 12:12:11 -0700
Message-ID: <20260423191211.3296634-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422160342.1975093-7-michael.bommarito@gmail.com>
References: <20260422160342.1975093-7-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mendozajonas.com,gmail.com,vger.kernel.org,davemloft.net,google.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240533-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B55BD456966
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/ncsi: validate GP payload lengths before parsing

This commit bounds MAC and VLAN counts to software and GC-reported limits.
It adds validation to ensure the declared GP payload covers the fixed GP
prefix, consumed entries, and the checksum before parsing filter tables.

> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index 94354dca23eac..565d38fd4b92d 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
[ ... ]
> @@ -924,6 +926,14 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
>  	if (rsp->mac_cnt > mac_nbits || rsp->vlan_cnt > ncvf->n_vids)
>  		return -ERANGE;

Does this code read rsp->mac_cnt and rsp->vlan_cnt before validating the
payload length?

If a malformed packet with a payload length of 0 is received,
ncsi_validate_rsp_pkt() guarantees only 20 bytes (the common response
header) are pulled into the skb linear data area.

Since rsp->mac_cnt and rsp->vlan_cnt are at offsets 20 and 24 respectively,
could accessing them prior to the payload length check trigger an
out-of-bounds read?

> +	payload = ncsi_rsp_payload(nr->rsp);
> +	needed = offsetof(struct ncsi_rsp_gp_pkt, mac) - sizeof(rsp->rsp);
> +	needed += mac_cnt * ETH_ALEN;
> +	needed += vlan_cnt * sizeof(__be16);
> +	needed += sizeof(rsp->checksum);
> +	if (payload < needed)
> +		return -EINVAL;

Are there missing timer cancellations during NCSI device unregistration
that could lead to a use-after-free regression?

ncsi_register_dev() initializes timers for 256 NCSI requests. If an NCSI
request is pending when the device is unregistered, and
ncsi_unregister_dev() calls kfree(ndp) without a prior timer_delete_sync(),
could the timer fire later and cause ncsi_request_timeout() to dereference
the freed memory?

Is there a synchronization issue between the workqueue teardown order and
device unregistration?

ncsi_unregister_dev() frees all packages and their channels via
ncsi_remove_package() before calling disable_work_sync(&ndp->work).

If the background task ncsi_dev_work() executes concurrently during this
teardown, could it attempt to suspend or configure the active channel
(e.g., in ncsi_suspend_channel()) and access ndp->active_package and
ndp->active_channel after they have already been freed?

Does the RCU synchronization in the package and channel removal paths properly
prevent use-after-free regressions during receive?

ncsi_remove_channel() and ncsi_remove_package() unlink elements from
RCU-protected lists (list_del_rcu(&nc->node)) and immediately call kfree()
without invoking synchronize_rcu() or using kfree_rcu().

Since the Rx path in ncsi_rcv_rsp() concurrently searches these lists using
list_for_each_entry_rcu(), could an incoming packet cause the Rx handler to
traverse and dereference recently freed package or channel memory?

Does ncsi_rsp_handler_gc() leak the MAC and VLAN filter arrays on repeated Get
Capabilities (GC) responses?

The handler unconditionally allocates memory for nc->mac_filter.addrs and
nc->vlan_filter.vids using kzalloc() and kcalloc(), but does not appear to
check for or free any previously allocated memory.

If a channel goes through a reset cycle via ncsi_reset_dev(), or if a GC
command is explicitly injected via Netlink, could the handler execute again
and overwrite the pointers, leaking the previous allocations?

