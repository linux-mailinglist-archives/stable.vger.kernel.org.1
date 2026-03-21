Return-Path: <stable+bounces-227744-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOnaHlBivmnDOAMAu9opvQ
	(envelope-from <stable+bounces-227744-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:18:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6692E4569
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14B7E3023059
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 09:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3931195A;
	Sat, 21 Mar 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck5quWWH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE732494F0;
	Sat, 21 Mar 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774084680; cv=none; b=UCYpbbid1eDMY1zDtdhBadun1CXQeJc5nZpmTD499QnOaz7VG62VAjXOGf8IrsBBw9rVpGaHqdYhDQX+i9rq1w5OLgN4ySKnbUBEEQvSo1Yb8D3WavpYHmH6jk7q2X/g62OR6JgQuMwtphE4xX8e45KWrPtY6D2KzroM2Rd7ulI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774084680; c=relaxed/simple;
	bh=oa4pCeGObUtEmfpti4pdZQ10bKk+YYr47M7vQbAVYYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7+oW6jWTVG9EoFT9/9HWt89U3cf80Ps7nL5hRQJoMOVbH0Ri/QbLC2CrU+heyWYJpDUyz1GntKBx5/KdaFcKRtaQvIXytfmljxE1YoyY620S9rTksTDfpUR7FRlGotscUZoLbFztqwsC136iVWXzdPiCz3mLiYT3I0aMXCxRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck5quWWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CFDC19421;
	Sat, 21 Mar 2026 09:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774084680;
	bh=oa4pCeGObUtEmfpti4pdZQ10bKk+YYr47M7vQbAVYYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ck5quWWHUFYlP4Evri1ddtI3Hvyf3AKxDDkWR6oOf/vzlL40QEX/GODXybpTmPHN+
	 zcBgNvuS/Q1b28wywTWhz5gKRLcKnATDnYif0RlLD6HD9sc8rm3ypfQP5bQM3ZYZXQ
	 4Wphk8whbbg3E6vpPI8bQYCk5jVyRlIYCYIfMKZ4RUIeB8phnDfydVpe+G0xQ+UF13
	 iuC3mBBFCZTCqY81qOaQqPAhsswpIAXMJlUYzevmnLcmWzofwLmRfK2Pm2OaZEBCCt
	 xGl+23YrSMocPQjJdoxpKPDxdO5trFINJU2Cj9T8mc1GLJWs4opNpReHEzTGJdOpj3
	 MJejaBfjs3cJA==
Date: Sat, 21 Mar 2026 09:17:53 +0000
From: Simon Horman <horms@kernel.org>
To: "Tantilov, Emil S" <emil.s.tantilov@intel.com>
Cc: daniel@iogearbox.net, ast@kernel.org, willemb@google.com,
	stable@vger.kernel.org, decot@google.com, bpf@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, edumazet@google.com,
	netdev@vger.kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	kuba@kernel.org, davem@davemloft.net, sdf@fomichev.me,
	aleksandr.loktionov@intel.com, aleksander.lobakin@intel.com,
	john.fastabend@gmail.com, hawk@kernel.org
Subject: Re: [PATCH iwl-net v2] idpf: fix xdp crash in soft reset error path
Message-ID: <20260321091753.GT74886@horms.kernel.org>
References: <20260319224159.23885-1-emil.s.tantilov@intel.com>
 <20260320174843.137651-1-horms@kernel.org>
 <0275cffc-7a61-46fb-9d1e-c309ac680b80@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0275cffc-7a61-46fb-9d1e-c309ac680b80@intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227744-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,google.com,vger.kernel.org,intel.com,lists.osuosl.org,redhat.com,lunn.ch,davemloft.net,fomichev.me,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,linux.dev:url]
X-Rspamd-Queue-Id: ED6692E4569
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 02:35:42PM -0700, Tantilov, Emil S wrote:
> 
> 
> On 3/20/2026 10:48 AM, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> > ---
> > idpf: fix xdp crash in soft reset error path
> > 
> > This commit fixes a NULL pointer dereference that occurs when
> > idpf_vport_open() fails during soft reset. The fix restores
> > vport->xdp_prog in the error path and updates the restart check in
> > idpf_xsk_pool_setup() to use IDPF_VPORT_UP instead of netif_running().
> > 
> > > Fixes: 3d57b2c00f09 ("idpf: add XSk pool initialization")
> > 
> > The Fixes: tag may not be targeting the correct commit. The primary bug
> > being fixed is the NULL pointer dereference crash in idpf_xdp_setup_prog()
> > that occurs when soft reset fails and vport->xdp_prog is not restored.
> 
> This is not exactly true, this is just one of the instances that would
> cause idpf_qp_switch() to be called. [1]
> 
> > 
> > Looking at the git history, this missing restoration was introduced in
> > commit 705457e7211f ("idpf: implement XDP_SETUP_PROG in ndo_bpf for
> > splitq"), where idpf_xdp_setup_prog() was first implemented. While commit
> > 3d57b2c00f09 introduced the secondary issue with the netif_running()
> > check, the main crash fix addresses code from commit 705457e7211f.
> > 
> > Should the Fixes: tag point to commit 705457e7211f instead?
> 
> The reason I chose commit 3d57b2c00f09 is because it is the commit
> introducing the function where the crash is occurring:
> [ 3179.284770] RIP: 0010:idpf_find_rxq_vec+0x17/0x30 [idpf]
> ...
> [ 3179.291937] Call Trace:
> [ 3179.292392]  <TASK>
> [ 3179.292843]  idpf_qp_switch+0x25/0x820 [idpf]
> 
> The setting of the restart variable is where the above commits "meet",
> in that both conditions - netif_ruinning() and idpf_xdp_enabled() [1]
> can be wrong:
> https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/tree/drivers/net/ethernet/intel/idpf/xsk.c#n571
> 
> which would end up calling idpf_qp_switch() instead of taking the
> alternate path:
> 	restart = idpf_xdp_enabled(vport) && netif_running(vport->netdev);
> 	if (!restart)
> 		goto pool;
> 
> Which was introduced by 3d57b2c00f09.

Thanks for the clarification.
I agree that using 3d57b2c00f09 makes sense.

...

