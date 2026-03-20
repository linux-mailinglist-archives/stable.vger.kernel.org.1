Return-Path: <stable+bounces-227449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LpZAn36vGmd5AIAu9opvQ
	(envelope-from <stable+bounces-227449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:42:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E8A2D6BB5
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 08:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7501F3010B8C
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 07:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C210D339B3D;
	Fri, 20 Mar 2026 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YIOJN0Gf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ElOMsQcl"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B49346AC5;
	Fri, 20 Mar 2026 07:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992570; cv=none; b=onQl5DOOqfu/YOTDOULC77tDKXq8IX38TUXRmGaHufwTRuqdq6EkS8bmATULaTe1gvfzQRKHip/DcgffwdLpGgEdijoTV0mmWHMDh3TK6klpK7da8mGL/HmDva3qxvmfYy0oOZw9ygW3MCf8ReZ0Ib1T1+L7bgzQeD7NxO0KiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992570; c=relaxed/simple;
	bh=0dCgqHkboWZHR92xSaIEcbRDFKUPTTR6UrXrj/yEGWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jss+xCWRo5+krNewR+S4WYi8ty9SnNiH6s6G9vRbhPMlf2OAumQeo5+bukvuM5CEnzcHrosRg3PiXPKSxoNjz7GTbH6YuWgn3JmQItXP75b6HkUqLTOyrsnl2xOmfL8EyVuflmKnlsRMpx0eV2u1l49s+2VjGTMRQa3BzaGUzdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YIOJN0Gf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ElOMsQcl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Mar 2026 08:42:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773992566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MshMtRZGT4p94HZtMOMgVziJMH9fBPmkrzXedqSzHHE=;
	b=YIOJN0GfnmtovTSZTpcfroGQxeM66sH4Yrhdl5VvWOh9FQo4A7czDOMHHQohWcSBK7m3EP
	R8gV8i4mcq+sWBedgy9kV8liceIdoB91dmT2/axGJr90Jrq4HM/fvEcVlk2sAPCtOwmqXu
	dxeAeOQBbBtmmcNl5ATN1MP63yRgc/XdoTFIYJCRF76pdAY3g9+N0pU9HdHVOBrYTwAOoC
	R0EyuU/ONlLVqNLZCWSmugffS0I7rECLSfyn3mbeo9XotGS7gZA3z1RtmO2Gc+Bv5VEpE7
	nYUZxplpa5Y0odolF7hNasjFNxtNc/UOwkyHqgduL1txuGG6UgKe/dLAm7m60A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773992566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MshMtRZGT4p94HZtMOMgVziJMH9fBPmkrzXedqSzHHE=;
	b=ElOMsQclM26S3Ox7+9FT1+gr1Xuy1uzdrOR2tkwl7bvcxy7j3TCN9R1jfYyQER4pH5rhWS
	4gecTzup0E+/A9CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, clrkwllms@kernel.org, rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev, sgzhang@google.com,
	boolli@google.com, stable@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 2/3] idpf: improve locking around
 idpf_vc_xn_push_free()
Message-ID: <20260320074245.f8dPuv4j@linutronix.de>
References: <20260319211335.23236-1-emil.s.tantilov@intel.com>
 <20260319211335.23236-3-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319211335.23236-3-emil.s.tantilov@intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227449-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.952];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 93E8A2D6BB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-19 14:13:34 [-0700], Emil Tantilov wrote:
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 582e0c8e9dc0..fbd5a15b015c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -402,7 +402,9 @@ static void idpf_vc_xn_push_free(struct idpf_vc_xn_manager *vcxn_mngr,
>  				 struct idpf_vc_xn *xn)
>  {
>  	idpf_vc_xn_release_bufs(xn);
> +	spin_lock_bh(&vcxn_mngr->xn_bm_lock);
>  	set_bit(xn->idx, vcxn_mngr->free_xn_bm);

If all of your bit manipulations happen under the same lock you could
replace atomic set_bit()/ clear_bit() with their non-atomic counter
parts __set_bit()/ __clear_bit().

The lockless alternative would be find_first_bit() +
test_and_set_bit() loop. Probably another atomic op for salt. Using the
__ is free with this change.

> +	spin_unlock_bh(&vcxn_mngr->xn_bm_lock);
>  }

Sebastian

