Return-Path: <stable+bounces-272102-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YA+8CeDMSmoJHwEAu9opvQ
	(envelope-from <stable+bounces-272102-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 23:30:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D9C70B776
	for <lists+stable@lfdr.de>; Sun, 05 Jul 2026 23:30:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=HIVPF8zS;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272102-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272102-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73A5A300B9CF
	for <lists+stable@lfdr.de>; Sun,  5 Jul 2026 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE13370AF8;
	Sun,  5 Jul 2026 21:29:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327C236E495;
	Sun,  5 Jul 2026 21:29:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783286972; cv=none; b=rdlea413MLzsxvsKeYnLIYQ9F1Uw2YIWeMilCQe6wb+SlPX5Zp3Z+iW0HcDnP1Uj2xL1MqpXUwL2sm89aVry2BlJcx+Fxsca2VYqzFd5AwKhYdE3QoehkVsR/+ZoWVOYwjCXaInb5/UVBbp0NqhP4iJ2TiVpDBmfz1IKBczlrkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783286972; c=relaxed/simple;
	bh=WiE7MLUiL4dVrEJGHf/ZKlyKHqtDhP+rQSqZzKM1ZGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQfEIRjKp3vWSw7Wk+M7pfnR+rjJ1z4EXR9+qcjKFbtFOrfJeUpaoXszZcxrEsD//GdsHGY7Ip5kqG3P2/fjtuQ+0Wm2wciijWrIlpQAnTeTXxasdIwqk3Hm31B4gxiwri+FzxT0lhkEq86ZglzUef8SYDMYd0M+RaoPvNqEtRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HIVPF8zS; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id EF8D51A0DAB;
	Sun,  5 Jul 2026 21:29:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBBCF601A2;
	Sun,  5 Jul 2026 21:29:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 185A111BB8700;
	Sun,  5 Jul 2026 23:29:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783286969; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3cdlrCY/UEDs7e2DAYmtfE/8rLu7qhR+PO/mhXoMVhs=;
	b=HIVPF8zS9nm5chch6plmYTDopvc6FH2ehboCIBkTfZleuBRJ0mjFt/0yrd7OD8wcQBBj6h
	F08p7hv4htD0QwBIEDokk3fR2v9UDy8mxcQGKF1RrOBwu9wYQMPHkNZSywDoDvT61IQHCh
	bJYh5phVF5bc/aDgNIjZs5s3F00bctNeqmjpdkNNGHe2GfnMJBqulQjkBglJ/67cI9WQHB
	wVEdB/PggUfUiWEgISpTzWqJlfeIU+FXL6cZ0NE+tj5DWXFia1x2AxN5a+Hxyk6PDyuPNs
	2fK2xwePNctZDSOmVCbFjAP3OSJRz/GMrOwEtAw54BQHnHH0dDTM7V4846xYBw==
Date: Sun, 5 Jul 2026 23:29:24 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jorge Marques <jorge.marques@analog.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Frank Li <Frank.Li@nxp.com>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH] i3c: master: adi: initialize the lock before enabling
 interrupts
Message-ID: <178328692971.58266.7124035364355611229.b4-ty@b4>
References: <20260617150138.628578-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617150138.628578-1-runyu.xiao@seu.edu.cn>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272102-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jorge.marques@analog.com,m:runyu.xiao@seu.edu.cn,m:Frank.Li@nxp.com,m:linux-i3c@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alexandre.belloni@bootlin.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandre.belloni@bootlin.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:url,bootlin.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52D9C70B776

On Wed, 17 Jun 2026 23:01:38 +0800, Runyu Xiao wrote:
> adi_i3c_master_probe() requests the IRQ and unmasks REG_IRQ_PENDING_CMDR
> before the controller's IBI state, transfer queue list and transfer
> queue lock are initialized.  A pending CMDR interrupt can therefore run
> adi_i3c_master_irq() and take master->xferqueue.lock before the dynamic
> lock has been initialized.
> 
> This issue was found by our static analysis tool and then manually
> reviewed against the current tree.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: adi: initialize the lock before enabling interrupts
      https://git.kernel.org/i3c/c/7296f6898b6d

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

