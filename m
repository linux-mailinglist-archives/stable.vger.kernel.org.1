Return-Path: <stable+bounces-237900-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJPTHdVa3mk0CQAAu9opvQ
	(envelope-from <stable+bounces-237900-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:18:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B673FBA68
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 17:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE8E9302E905
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FB63E92A1;
	Tue, 14 Apr 2026 15:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STot0z6q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6F63909A6;
	Tue, 14 Apr 2026 15:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179373; cv=none; b=Brr3qjeW39sgRKMfH1S4QvJk/jXygswDytqSYM61eCyemiA4h0Y52DpeDifdozOWxIPByKIFQPJjWs+yPwgDW9IrxJI7k4ppsLuap4y0HvGSN4za516nGkUS5ZhCz+SV02ujoeBwrh05R6vfnSFIXsp99+ZQtcQwtdawfhW/FC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179373; c=relaxed/simple;
	bh=2rhxeax1OI8uTiHdRJmuYz3GYs+VdzeWhg48SRaHWOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3qMjm5+AeLAm1pnvRmFS1bDvL4R5WudBdmmorag95FNz4GeFd8fMhAe1ciPGFWpk7n44yBujG3ZLU1lbpH0R8jFvXfee0fi6wPRqoz/uO3qBixE3BNl2fE30tCVcHNOn7vEjDwuNFY5Gl/DlwVoRO5gBtgvRB1GbhRJgRjK3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STot0z6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFBAC19425;
	Tue, 14 Apr 2026 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776179373;
	bh=2rhxeax1OI8uTiHdRJmuYz3GYs+VdzeWhg48SRaHWOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=STot0z6qolyTE/bNfqK4TV9nSboTLZmNcoNJZpUUJ90t+F9SceiYmc+aBfyolabQI
	 LUadzyEyQplhvUZQ9YBtrdukWFl8qVgitm4uTR1vImd9loJW6FAVqTqJRAOdc+m/Ho
	 li7ZEDkRxM9ajI6ifDdzxOwM21YR+OdyMmuZ6o3VeJPC4vclIy3P4tIxOMfMFa++sx
	 6PDSOFKTzzSVMKM9BWopGlLp4epodQh9l2K4tKFUAeeFepUsbuoysSP4fhxfFrcTpz
	 InIGQtqny8hJDwgIMQjXt//+VGj/dpqB6LAhZ9GiBu0NE8rLw03ZdI+qRGvXOpae9P
	 I+zggXkGcXyrg==
Date: Tue, 14 Apr 2026 08:09:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Marek Vasut <marex@nabladev.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Nicolai
 Buchwitz <nb@tipi-net.de>, Paolo Abeni <pabeni@redhat.com>, Ronald Wahl
 <ronald.wahl@raritan.com>, Yicong Hui <yiconghui@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [net,PATCH v3 1/2] net: ks8851: Reinstate disabling of BHs
 around IRQ handler
Message-ID: <20260414080931.3aef9df4@kernel.org>
In-Reply-To: <20260414125753.Im6GAIHn@linutronix.de>
References: <20260414103327.113500-1-marex@nabladev.com>
	<20260414125753.Im6GAIHn@linutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237900-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nabladev.com,vger.kernel.org,davemloft.net,lunn.ch,google.com,tipi-net.de,redhat.com,raritan.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31B673FBA68
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 14:57:53 +0200 Sebastian Andrzej Siewior wrote:
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Maybe I'm not being forceful enough.

Putting workarounds in the drivers is unacceptable.
__netdev_alloc_skb() must be legal to call under an _irq spin lock.

