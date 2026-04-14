Return-Path: <stable+bounces-237871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IONJCFc/3mlJpwkAu9opvQ
	(envelope-from <stable+bounces-237871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:21:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8EF3FA6D3
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EA3E303CD0C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2923DB630;
	Tue, 14 Apr 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="SYstfTm7"
X-Original-To: stable@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08C225775;
	Tue, 14 Apr 2026 13:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172668; cv=none; b=HT3dhVF8wZAaRwej+xaYr/h3S64bP7/iR/SIonaZL5v5CfIJQEaNIUbQsnbtN/BPUEviRvOdTv3Q0TQQtl0dqn+ceKBmRcgDZrdXmvA1y3bUGkTMrpgwra3qPATmNSuuvQE+wGRUKZjvmU0kIrQXuTmcYf21kyepviATk1XrDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172668; c=relaxed/simple;
	bh=TfTq1Q0iYn5QolfIKQn3GKbi8/ALLbVLx9L9Ojb8eWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiTYkcxRsWKjOWzxGvadrwqMbfpms1Q7Aq6Sx4nZu4XdvfUR22PB2bwDNCK6rN2xNQhBjq+jDYLvrcqm9tGNRvTDphUjIBHSECHDrKYh4yQ3LbDRH1RmrHQn3i+msQwzVL5WgStUs5BJAEPth2L0FbEiJlfLG+eu6EtihCTxs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=SYstfTm7; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1776172654; bh=VypS8x873n89tzMGtqOFlk/RKy1+0ZIM5Gf+NcGD2Fs=;
	h=From:Message-ID:From;
	b=SYstfTm7qLYk2Aki3dS28tDghg4EhNjX37wRWCa57gYhi42gnaoJFKlBYargTUxqg
	 Nf4ewlBn3OVAk80UurSyK9q5gg2oEoD7QhFcNlM4GEnn82EL9xS2PZejgBY7q6jok0
	 4V9fvrdvkCmZ07ZCByU19M7RAbRe4lAqrTsqRkjg=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id EF3ABC06F2;
	Tue, 14 Apr 2026 15:17:33 +0200 (CEST)
Date: Tue, 14 Apr 2026 15:17:33 +0200
From: Willy Tarreau <w@1wt.eu>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Pavitra Jha <jhapavitra98@gmail.com>, chandrashekar.devegowda@intel.com,
        linux-wwan@lists.linux.dev, netdev@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] net: wwan: t7xx: validate port_count against message
 length in t7xx_port_enum_msg_handler
Message-ID: <ad4-bTbjtxbUXDU9@1wt.eu>
References: <20260411083957.567676-1-jhapavitra98@gmail.com>
 <3b67dedb-3472-4322-9a30-32bf8e3cef99@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b67dedb-3472-4322-9a30-32bf8e3cef99@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1wt.eu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[1wt.eu:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237871-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,lists.linux.dev,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w@1wt.eu,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[1wt.eu:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1wt.eu:dkim,1wt.eu:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE8EF3FA6D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 11:41:54AM +0200, Paolo Abeni wrote:
> On 4/11/26 10:39 AM, Pavitra Jha wrote:
> > t7xx_port_enum_msg_handler() uses the modem-supplied port_count field as
> > a loop bound over port_msg->data[] without checking that the message buffer
> > contains sufficient data. A modem sending port_count=65535 in a 12-byte
> > buffer triggers a slab-out-of-bounds read of up to 262140 bytes.
> > 
> > Add a struct_size() check after extracting port_count and before the loop.
> > Pass msg_len from both call sites: skb->len at the DPMAIF path after
> > skb_pull(), and the captured rt_feature->data_len at the handshake path.
> > 
> > Fixes: 1e3e8eb9b6e3 ("net: wwan: t7xx: Add control DMA interface")
> 
> Wrong fixes tag:
> 
> fatal: ambiguous argument '1e3e8eb9b6e3': unknown revision or path not
> in the working tree.

Interesting, there isn't a single digit correct here! The matching one
I'm finding based on the subject is:

  39d439047f1d ("net: wwan: t7xx: Add control DMA interface")

Willy

> > diff --git a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> > index ae632ef96..d984a688d 100644
> > --- a/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> > +++ b/drivers/net/wwan/t7xx/t7xx_port_ctrl_msg.c
> > @@ -124,7 +124,7 @@ static int fsm_ee_message_handler(struct t7xx_port *port, struct t7xx_fsm_ctl *c
> >   * * 0		- Success.
> >   * * -EFAULT	- Message check failure.
> >   */
> > -int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg)
> > +int t7xx_port_enum_msg_handler(struct t7xx_modem *md, void *msg, size_t msg_len)
> 
> Undocumented new argument
> 
> /P

