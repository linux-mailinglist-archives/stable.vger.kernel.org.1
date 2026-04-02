Return-Path: <stable+bounces-232888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGgYEETKzWnihQYAu9opvQ
	(envelope-from <stable+bounces-232888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 03:45:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F10382552
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 03:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A0DC301BF54
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 01:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3758D33120A;
	Thu,  2 Apr 2026 01:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVG7lgek"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6430E84B;
	Thu,  2 Apr 2026 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775094237; cv=none; b=eRggZj938uT05QTwLvwwbyRqF0o5YzZzO2PDXABr9dCEVlXVljRxnVKJp2ud1ZkxvokxszLyfa1Gk6DpwhJZh2/1uf7HN3gUMXmUkwku/e9zKSm12fG0Uz/q7E1QOQ1Ra1FcHGJ00ywSMYiemT1KbdczVWF00xmswlsGUyd7hXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775094237; c=relaxed/simple;
	bh=4rhYRtEiCn0F4txmgoZwS63pOAIHvVvVsbvrbeFVWcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSTHUr8J10JnpgetIyuOyatYw87RUPurmiM/Mp03SRHAwpw2DxOo/EtC2UZ0EKd3LPjGfKSSOBBWxH4iP0CfVqaI0JoO25khvKH3sya4bmcLZpHhbmci1GnVitOlkwyRkb2/8EmVCn7ltWThrsAMs6rNSraUZ/kW920c1munjQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVG7lgek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CBAC4CEF7;
	Thu,  2 Apr 2026 01:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775094236;
	bh=4rhYRtEiCn0F4txmgoZwS63pOAIHvVvVsbvrbeFVWcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EVG7lgeklIR2lk2B6psf2XuNf9uNZbvV9i4pIJd+9eHF1fyyk2I1ncDD55+Ij4EXx
	 y8AHWSCEqSk5855V/Wq3pUlcSqax44Et5rvangQ493jfeBijNwE5Prl2HSdmU5ikAP
	 YHEgMP68LdWmGYuXFxoK5seEnv092J4EzSbzF3LoyDwc4EI5cU697teafxZmNye69M
	 L62ORXVzqF2tFPG3RSkVPNECJZM78SYLmFV4qHgo6EkP75HFxH4uiwZzoVHBOUFxiv
	 X0xSkQ1gY2W8eGqtjTP/jW4fUa+DqvLAWltuiFkGPl19j8D7FWs64VNWKDtB3TrIRX
	 M9xihwrUr0+bQ==
Date: Wed, 1 Apr 2026 18:43:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tyllis Xu <livelycarpet87@gmail.com>
Cc: haren@linux.ibm.com, ricklind@linux.ibm.com, nnac123@linux.ibm.com,
 sukadev@linux.ibm.com, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 ychen@northwestern.edu, Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH v2] ibmvnic: fix OOB array access in ibmvnic_xmit on
 queue count reduction
Message-ID: <20260401184355.2a063cb4@kernel.org>
In-Reply-To: <20260401050845.1388145-1-LivelyCarpet87@gmail.com>
References: <CAJsYhQJm4mW1FHu2d=Pf8PfFyBWZA43QHpQ2esc0Cfuqqehh4w@mail.gmail.com>
	<20260401050845.1388145-1-LivelyCarpet87@gmail.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232888-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[linux.ibm.com,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,northwestern.edu,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.972];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D4F10382552
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed,  1 Apr 2026 00:08:45 -0500 Tyllis Xu wrote:
> When the number of TX queues is reduced (e.g., via ethtool -L), the
> Qdisc layer retains previously enqueued skbs with queue mappings from
> before the reduction. After the reset completes and tx_queues_active is
> set to true, netif_tx_start_all_queues() drains these stale skbs through
> ibmvnic_xmit(). The queue index from skb_get_queue_mapping() may exceed
> the newly allocated array bounds, causing out-of-bounds reads on
> tx_scrq[] and tx_pool[]/tso_pool[].

This should not happen if the interface configures itself correctly, see
https://lore.kernel.org/all/20260106182244.7188a8f6@kernel.org/

Please share are a repro if you have one.


