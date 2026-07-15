Return-Path: <stable+bounces-274756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fYI6Dmw3V2r/HQEAu9opvQ
	(envelope-from <stable+bounces-274756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:31:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D9775B731
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 09:31:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274756-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274756-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E11BE3020EBC
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 07:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DEC3C1F4F;
	Wed, 15 Jul 2026 07:30:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86771312826;
	Wed, 15 Jul 2026 07:30:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784100657; cv=none; b=s4rmlokvucUyIZibsGyDiY+FMQtzmZ8OfkDeJAFU7vYVqAe+W/1a3xflH6ogi+Za9ivzsjjI+MK1U4qwfYKgCfhxLroR2xbiIuYRuJdXODMEHxSJtVQ7yRnGSy0zFNBAU+ZrjzTlgkaKGbkO7GtGDEfP8RQBqgiW7wfH/8N+K4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784100657; c=relaxed/simple;
	bh=rL8hLMujvacVYSA7witLeIejqtHG7AcgFZld+ZY6lZA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GlDlJjHlcnGtTqkAc6PdmMP4ArUBGtz6qAFpBr6m3RM6pq4Yy+i+Lo4T3cuFd3D/DpnZFVNdCgp4+wPYvT5NMK0RLUbSaDCVqneJf6UnhBu4SiPzSBdP9PBNgz5p4stU6vXc0gSG706yILa+cx6MLJv3fBQKCCLJ0LLHIMYZAkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.76.78.106
Received: from zju.edu.cn (unknown [10.190.161.1])
	by mtasvr (Coremail) with SMTP id _____wA3RhQXN1dqdhRUAA--.4770S3;
	Wed, 15 Jul 2026 15:30:32 +0800 (CST)
Received: from smtpclient.apple (unknown [10.190.161.1])
	by mail-app4 (Coremail) with SMTP id zi_KCgCn2TATN1dqaLtRAg--.7181S2;
	Wed, 15 Jul 2026 15:30:28 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH net] net: hip04: fix RX buffer leak on build_skb failure
From: Fan Wu <12321260@zju.edu.cn>
In-Reply-To: <a361aa28-7f55-4476-9072-aa392a34b735@intel.com>
Date: Wed, 15 Jul 2026 15:30:17 +0800
Cc: Fan Wu <fanwu01@zju.edu.cn>,
 netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com,
 Simon Horman <horms@kernel.org>,
 shenjian15@huawei.com,
 salil.mehta@huawei.com,
 dingtianhong@huawei.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <190A7669-E0EC-4257-B65E-817FFA1ACCDC@zju.edu.cn>
References: <20260712142729.2057636-1-fanwu01@zju.edu.cn>
 <a361aa28-7f55-4476-9072-aa392a34b735@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-CM-TRANSID:zi_KCgCn2TATN1dqaLtRAg--.7181S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?dTAZ5wXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZzFg6QqpdDXDgMm1kEV24G8cSZoMjKBt5ZSGVWwqOiPFB+t
	uHd4o4L3Eo6XtrIyZJQ=
X-Coremail-Antispam: 1Uk129KBj9xXoW7XrWfGF15Ww4UJw1fWr1fXwc_yoWkGFX_u3
	40qryUJ34kCFn7Awn5KF43AFZ7u3W09FyrZrykKwsxt348JFs8ur4vk340yrZrKw4Yyrn8
	Cryvva4a9r13uosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274756-lists,stable=lfdr.de];
	DMARC_NA(0.00)[zju.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:fanwu01@zju.edu.cn,m:netdev@vger.kernel.org,m:przemyslaw.kitszel@intel.com,m:horms@kernel.org,m:shenjian15@huawei.com,m:salil.mehta@huawei.com,m:dingtianhong@huawei.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:jacob.e.keller@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[12321260@zju.edu.cn,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[12321260@zju.edu.cn,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	APPLE_MAILER_COMMON(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9D9775B731

Hi Jacob,

Thanks for the review. I agree this is a rare allocation-failure path.

The leak is nevertheless deterministic from the ownership contract and
the driver's control flow. __build_skb() documents that, on failure, it
returns NULL without freeing the caller-provided data.

hip04_rx_poll() currently jumps to refill before dma_unmap_single().
Refill then replaces rx_buf[rx_head] and rx_phys[rx_head], so the old
fragment and its streaming DMA mapping are no longer reachable. The
stop and free-ring paths only operate on entries still referenced by
those arrays.

The fix leaves the slot, descriptor, rx_head, and rx_cnt_remaining
unchanged, and returns budget. This tells NAPI that RX work remains
outstanding and retries build_skb() using the same buffer. The additional
skb_free_frag() handles the separate case where a replacement fragment
was allocated but dma_map_single() failed before it was installed.

I hope this clarifies why the failure path is a deterministic leak even
though I do not have a dynamic reproduction on HIP04 hardware.

Thanks,
Fan


