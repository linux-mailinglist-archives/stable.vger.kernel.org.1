Return-Path: <stable+bounces-254296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEGjGxR2FWrHVAcAu9opvQ
	(envelope-from <stable+bounces-254296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:29:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A5D5D4303
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FD733057759
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A563DCDBE;
	Tue, 26 May 2026 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TIMr2Vcf"
X-Original-To: stable@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC718050;
	Tue, 26 May 2026 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779791051; cv=none; b=Cp5Oj0mtfOxjLVkuuQxuYdLYIKQ2XUDGve1o7T/gvp0LfyzDNT5g3PbcZmYHXNlTKyduLAQiDDMQ/iCNKU4SOlor/hVsgbtR37ces2lUSgLklQmnEi3T/AeO74rQE1TFNZ0fFm7dqqL0UJHtnBf2cXNmUAEXjJ4OvEkgcumCWnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779791051; c=relaxed/simple;
	bh=okLPxCiL51RSiNMii4wqxQLtUILmJ4RghmH3tZP3gmo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TY4xY7kEz9WtOJ1zH8z1A0lCQXow3vu1lclV0J7NwVN8dMztPcT7yJFLLpaqR3LQFGLgjI5HhiCpi5greSoPr+ZpgFnTpAgqV1XRs19CWbIaCP12kXG76gfzu8WFUSKZUS2oXZb8DRnhDIHjA7FdS746Jhyyo/0mRBMIvzadU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TIMr2Vcf; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id ABDF220190;
	Tue, 26 May 2026 12:24:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2w2_dt588ARb; Tue, 26 May 2026 12:24:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 26FE920185;
	Tue, 26 May 2026 12:24:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 26FE920185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779791046;
	bh=IPRciZT8P3SLK9JWV7oW/37+pUQGNLIg1LLkGwk6Amw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=TIMr2Vcf0SdPGvZFzBdwRd/HmsdgJEKdu7W49m/RvrHSFi7DHQxATlBBiWZj1Tb4J
	 OkYb9274VZfeeYbC11kT8ZnMp5njhTST0rTEMGX9pIP/AJ3nl1iKuRQJqLflg/sDQ1
	 yfCAYB8uJw9B9LISk/wZBTTZr4uU0Jg/mqjxCFsiv20o0kMrwD8b6O0GEYUTz1TICj
	 gbruDZGF/YRejfRXshqUu5StUTGZ0GQMsaWjm9PSL7V5uh/gb0fmw3bCtzfnVR2k7x
	 KxLCu43ZMV5riJ3XsWM5FPd6PZZ6fbXRJduUvM3HCvDejp1+vje3huaN8Tx6F4aJ5w
	 NjDEYvSnX70sQ==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 12:24:05 +0200
Received: (nullmailer pid 223160 invoked by uid 1000);
	Tue, 26 May 2026 10:24:04 -0000
Date: Tue, 26 May 2026 12:24:04 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Shaomin Chen <eeesssooo020@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Herbert Xu
	<herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Christian Hopps
	<chopps@labn.net>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: iptfs: reset runtime state when cloning SAs
Message-ID: <ahV0xGfaH-eOVgGx@secunet.com>
References: <20260520180723.965339-1-eeesssooo020@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520180723.965339-1-eeesssooo020@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254296-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:mid,secunet.com:dkim];
	DKIM_TRACE(0.00)[secunet.com:+];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 40A5D5D4303
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 02:07:23AM +0800, Shaomin Chen wrote:
> iptfs_clone_state() clones the IPTFS mode data with kmemdup(). This
> copies runtime objects which must not be shared with the original SA,
> including the embedded sk_buff_head, hrtimers, spinlock, and in-flight
> reassembly/reorder state.
> 
> If xfrm_state_migrate() fails after clone_state() but before the later
> init_state() call has reinitialized those fields, the cloned state can be
> destroyed by xfrm_state_gc_task() with list and timer state copied from the
> original SA. With queued packets this lets the clone splice and free skbs
> owned by the original IPTFS queue, leading to use-after-free and
> double-free reports in iptfs_destroy_state() and skb release paths.
> 
> Reinitialize the clone's runtime state before publishing it through
> x->mode_data. Because clone_state() now publishes a destroyable mode_data
> object before init_state(), take the mode callback module reference there.
> Avoid taking it again from __iptfs_init_state() for the same object.
> 
> Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>

Applied, thanks a lot!

