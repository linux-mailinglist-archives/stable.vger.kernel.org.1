Return-Path: <stable+bounces-238506-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KVvM5Je4mlM5QAAu9opvQ
	(envelope-from <stable+bounces-238506-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 18:23:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2E41D0FF
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A607B3045016
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 16:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5208434DB72;
	Fri, 17 Apr 2026 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="Y+Mx2vPY"
X-Original-To: stable@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D734B19F
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776442858; cv=none; b=JullPlUapLlJRvjlalhNlr64SuXrb3IRaJ4iSGFrSrKyj3RZL13mCFgNj4Ih1s7QK0NHclP90wrmBWr1P8SxZQPL6zHxLROfRM36N/bdKiRUIeEOULkY6v5BTm6/L2L4vxTbJo9oXTGRTWKXPYqe26qxm2ezan/3mlYZdfbWiGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776442858; c=relaxed/simple;
	bh=LahCPMaNW4+EJMQUur8o6yJaL/QVwiKBq9Lz/a9CeHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KURx112fdqnrV2cL7MYF049r1ndCAFF42jjBs8VIE+G+G5vmfAJGUbtcyl/Oj8HAcCX4atgnrKGmbjcT0XCOcsng4ecdE1iJ+Jxyx0mSm219DFKPtxoH9sJ/ib1BUSou8vRhdafREdjKDLt/GDC9ey9KV1FZKPIkdxTlONTxZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=Y+Mx2vPY; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63HGKjCb019556
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 18 Apr 2026 01:20:46 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=aucRIRNpULh5tCJF/CYGnKrKwCbL4hITukOd5aDy3lE=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776442846; v=1;
        b=Y+Mx2vPYR6FTXpkb33ZpRugexom9CWm7BDSsBqR+SdVVyW9OlWjqxIONLeAEuAv4
         jL5h5XmSGXtHWES+olWwYkinXRchl2oZ4eyaLDebPL8fvRVF1voyFVbQuYnr8Sn6
         49VNsX5CPrUgwMSJcI2wJmY8AljkpL8kvQKveUE2VVjqsWlu5b4e1bWGe59Um8Us
         mSQ1T81rroaqUMtzK8xEsX/PNSwTibmHJpMYTf+C3guA82TLK7MLBjGfMUENfni1
         41mE8tLFyXK49VCmhH42iI8n3jIC8FPBdb+HGzee4xuqSSuqnFRSQIaICnbn2sNL
         QqTi5nSlwq6PdR7lpE27Ww==
Date: Sat, 18 Apr 2026 01:20:44 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Simon Horman <horms@kernel.org>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
        kohei.enju@gmail.com, stable@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] igc: fix potential skb leak
 in igc_fpe_xmit_smd_frame()
Message-ID: <aeJdUhe7_x1ZKFzX@x1>
References: <20260415025226.114115-1-kohei@enjuk.jp>
 <20260417115122.GA31784@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417115122.GA31784@horms.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238506-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.intel.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,enjuk.jp:dkim,enjuk.jp:email]
X-Rspamd-Queue-Id: 5CD2E41D0FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/17 12:51, Simon Horman wrote:
> On Wed, Apr 15, 2026 at 02:52:18AM +0000, Kohei Enju wrote:
> > When igc_fpe_init_tx_descriptor() fails, no one takes care of an
> > allocated skb, leaking it. [1]
> > Use dev_kfree_skb_any() on failure.
> > 
> > Tested on an I226 adapter with the following command, while injecting
> > faults in igc_fpe_init_tx_descriptor() to trigger the error path.
> >  # ethtool --set-mm $DEV verify-enabled on tx-enabled on pmac-enabled on
> > 
> > [1]
> > unreferenced object 0xffff888113c6cdc0 (size 224):
> > ...
> >   backtrace (crc be3d3fda):
> >     kmem_cache_alloc_node_noprof+0x3b1/0x410
> >     __alloc_skb+0xde/0x830
> >     igc_fpe_xmit_smd_frame.isra.0+0xad/0x1b0
> >     igc_fpe_send_mpacket+0x37/0x90
> >     ethtool_mmsv_verify_timer+0x15e/0x300
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 5422570c0010 ("igc: add support for frame preemption verification")
> > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > ---
> > Changes:
> >   v2:
> >     - change to idiomatic style with goto (Simon)
> >     - add Cc to stable (Alex)
> >     - add reprodunction steps (Alex)
> >   v1: https://lore.kernel.org/all/20260329145122.126040-1-kohei@enjuk.jp/
> 
> Thanks for the update.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Sashiko has comments about a potential existing bug in the same code path.
> I'd appreciate it if, as a follow-up, you could look over that.

Thanks for the heads-up. I'll look into it.

> 
> Thanks!

