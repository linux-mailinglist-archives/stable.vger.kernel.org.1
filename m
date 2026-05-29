Return-Path: <stable+bounces-256539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCNiMDBFGWrHuAgAu9opvQ
	(envelope-from <stable+bounces-256539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:50:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 651225FEC9B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A922D3067E4C
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700A53ACEFE;
	Fri, 29 May 2026 07:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rnLY2qa5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RsCD7dVz"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236CA405F7;
	Fri, 29 May 2026 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040901; cv=none; b=aTnjrVt3le9okhr3VhresDtzt2sKkEQCkP6FPY6zVKkYlGeUASp8QteXFeEryD0d9GcuTOiB0d7Mjq6sCzritatWtjLe9NZCIc7sscQQ1ms7mM3hU3h4OJcJoVNklmnsMaXx7pTe+ibdWAhwiN1mnPS2JaUWTzeLgvjSDooUb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040901; c=relaxed/simple;
	bh=kv31X/78h7SzduqUTT6enGHh5SPXO0ebMl/ZIIMU+xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj1VERvOriG4EitP5EdPQG595nhWHNflVyZJmI9PaN3z269yU0oUTI/sDcOdHX7NW/G58t80hj1z9D/4tUCRcwJo983mcWeWZLfPwEtLldmOPU9hS6ExvDywQBHG6ZRE9ivVNAwhnwroWvoprRLeaE6BGMAHfg+7bktbIt0GFTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rnLY2qa5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RsCD7dVz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 May 2026 09:48:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780040898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDsih4SqsFbZVSQ6/Dn2K0NJqce5HwZ23VRoi6b0lL4=;
	b=rnLY2qa54BPXzDgQe1mXijqDIefpWP8kX/cTIu052hfdonoVoGNqzJi3lF75EU0CTF83Fe
	4PRO+W6JbnM5K2+2+RdIvXajW7XD20q2daszzewpOCfup4Z/t89WzJub/qc6/RO44sRMvl
	qGFdBVRX4pmNYqRkvlIpMNDBiUBMYiZ6gdgr8QThr54Fw0ZyI84HtpUSOQtELadLHYE1cR
	iVsKPV4UQCXBiidlbJMYS8Vm6f5n1btzQZikw5YMvFGAG8Hi50526dc4tcc6cmWjw0EJeu
	JN15wuhpk41j2/tKZvhs5yvAnvhMZ0XfHmsofVPV93rwK+bz+rdG91IUAz2KOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780040898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDsih4SqsFbZVSQ6/Dn2K0NJqce5HwZ23VRoi6b0lL4=;
	b=RsCD7dVzqySTQbWDZdkyNwg2IMtYYh8D4+KJwfntZV6NgNhuaqd+3B+FaSriYcITsgphJ3
	UxZ+Sws9XIDjw4Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Maarten Lankhorst <dev@lankhorst.se>
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
	airlied@gmail.com, simona@ffwll.ch, clrkwllms@kernel.org,
	rostedt@goodmis.org, jerome.anand@intel.com,
	pierre-louis.bossart@linux.dev, tiwai@suse.de,
	intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/audio: use generic_handle_irq_safe() for LPE
 audio irq
Message-ID: <20260529074816.k1K16jyy@linutronix.de>
References: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260528154551.3708290-1-runyu.xiao@seu.edu.cn>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256539-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,kernel.org,goodmis.org,linux.dev,suse.de,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,seu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 651225FEC9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-28 23:45:51 [+0800], Runyu Xiao wrote:
> intel_lpe_audio_irq_handler() forwards the LPE audio child IRQ from the
> i915 parent IRQ path with generic_handle_irq(). The forwarded child top
> half is not an independent hardirq entry point; it inherits the context
> of the outer i915 interrupt dispatch path.
=E2=80=A6

This looks very familiar and is work in progress
	https://lore.kernel.org/all/20260310115709.2276203-16-dev@lankhorst.se/

Maarten, where do we stand on the i915 series?

> Fixes: eef57324d926 ("drm/i915: setup bridge for HDMI LPE audio driver")
> Cc: stable@vger.kernel.org

No stable fix needed because i915 can not be turned on PREEMPT_RT.

Sebastian

