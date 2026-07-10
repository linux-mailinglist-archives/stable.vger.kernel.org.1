Return-Path: <stable+bounces-273244-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YYCqMCT6UGpl9QIAu9opvQ
	(envelope-from <stable+bounces-273244-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 15:56:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 611C473B7D2
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 15:56:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=lYSfWl18;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273244-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-273244-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97766302549F
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 13:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C412561A2;
	Fri, 10 Jul 2026 13:56:44 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB2245005;
	Fri, 10 Jul 2026 13:56:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783691804; cv=none; b=GipXXnX5belmdu9bH7cdUsjhE03FZCVZLFBkCsdoITFhxC0BNxp0hQ2SoosOEj9wVDzfOG2mDsruCrYtIxJEpDb+I/2bNJuJ9spI8qosayHwqcNML15OC4gpZwccxabbM9joMaOCn/agjp6NlEwWcDRsJYhxpIh94bWQ+6+dV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783691804; c=relaxed/simple;
	bh=y1CsSYxn7k8Sym/SqxZiv9G+Dx1evFl+iOAQWnylrJc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VsFMSZyMLHmR1t0EUmLDN1ZGDnJuOSp1TPNC3jbOuoPLfw//2WUUuFfaoX2unOv/F9qziQxsP5MWOLnhys+Kf+Xb+cZ9zW+OINieAR0fjIscs4tf1VXp7JDGDpeJc5j7YJKPe55IziC5Iu07DLNcPTY8NwNjOXR9UuNDQPUz21M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lYSfWl18; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B9D404E40D46;
	Fri, 10 Jul 2026 13:56:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 64E5760342;
	Fri, 10 Jul 2026 13:56:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8854411BD0D31;
	Fri, 10 Jul 2026 15:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783691799; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2OSTNQqfELNvmzMkFQM5JXNMKTpBUTAoxKAHE2qMMVA=;
	b=lYSfWl18zW98syJyEZSj2Iq3gvp2ffBcTEnxk8tqULho9A02U4iNcaFidhErCHWcWtTzkF
	dY+jGxB6eyw9cV6fKtDcwAGeO8hk/i2lprLOBDDtVpBFgYcsmWW+3mtdHaKaRFnUv531Mu
	zPjjS4yRphMyR0y5aPOhiPrZHMPA/u9vpGIEp19Rr78NbT9iGKf8BpeZd6yb6UH8Yfv3uT
	lKJVWFNC1FeVmrTH9Tm0jkOhfRWq3rBx+LE8rw8qIZTQ+UgA7/5RDjFVQDNNMmOpD7iBJF
	bGZVhHG1hHkY68QdwfgbKeMKzqJv7/G42EoQOXLINfdRYBGLwtXeyQtHuU5huw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 15:56:32 +0200
Message-Id: <DJUXYXEQMUJ4.31H82KQMG29UC@bootlin.com>
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the
 TX ring on link-up
Cc: <christian.taedcke@weidmueller.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Robert Hancock"
 <robert.hancock@calian.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 <stable@vger.kernel.org>
To: "Kevin Hao" <haokexin@gmail.com>, "Taedcke, Christian"
 <christian.taedcke-oss@weidmueller.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com> <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com> <akzDQrmdYwHAMMmw@xiaowei> <8d53c3d9-7918-456c-8c27-e9d73c896452@weidmueller.com> <ak2-XJHVc3Cg6ZEk@xiaowei>
In-Reply-To: <ak2-XJHVc3Cg6ZEk@xiaowei>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273244-lists,stable=lfdr.de];
	FORGED_SENDER(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:christian.taedcke@weidmueller.com,m:conor.dooley@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:robert.hancock@calian.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:stable@vger.kernel.org,m:haokexin@gmail.com,m:christian.taedcke-oss@weidmueller.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,weidmueller.com];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:url,bootlin.com:mid,bootlin.com:dkim,amd.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 611C473B7D2

Hello Kevin & Christian,

On Wed Jul 8, 2026 at 5:05 AM CEST, Kevin Hao wrote:
>> I agree that the TRM says the transmit pointer is reset while TE is low.=
 My
>> question is whether this describes an internal pointer being reloaded fr=
om TBQP,
>> or whether TBQP itself is restored to the original ring base.
>
> The Zynq UltraScale TRM [1] describes the receive-buffer queue pointer as=
 follows:
>
>   An internal counter represents the receive-buffer queue pointer and it =
is not
>   visible through the CPU interface.
>
> I could not find a similar description for the transmit-buffer queue poin=
ter,
> but I believe it behaves the same way. From a software perspective, it sh=
ould
> be safe to assume that the TBQP is reset to point to the start of the tra=
nsmit
> descriptor list upon reset. This assumption is supported by the descripti=
on
> of the transmit_q_ptr (GEM) Register [2]:
>
>   Reading this register returns the location of the descriptor currently =
being accessed.
>   Since the DMA handles two frames at once, this may not necessarily be p=
ointing to the
>   current frame being transmitted.
>
> [1] https://docs.amd.com/v/u/en-US/ug1085-zynq-ultrascale-trm
> [2] https://docs.amd.com/r/en-US/ug1087-zynq-ultrascale-registers/transmi=
t_q_ptr-GEM-Register

For what it's worth, I agree with Kevin.

It should be rather easy to detect if the patch is needed, with more
logging. Dump TBQP before link-down & dump it at link-up. The code
expects TBQP to reset to the ring start automatically whereas this
commit message says the TBQP after link-up is some offset into the ring.

Lastly, the cover letter mentions that [PATCH 1/2] alone isn't enough.
But it doesn't mention that [PATCH 2/2] alone doesn't solve the issue.
This would be a useful test as well.

On Tue Jul 7, 2026 at 3:36 PM CEST, Taedcke, Christian wrote:
> Thank you for the quick review! This is my first Linux kernel
> contribution, so I appreciate your feedback here.

Welcome!

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


