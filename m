Return-Path: <stable+bounces-249210-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK7rNeXDCmoI7gQAu9opvQ
	(envelope-from <stable+bounces-249210-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:46:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CFC5680DC
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 09:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4141305D124
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FE83D3305;
	Mon, 18 May 2026 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jtn0ekis"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88FC30567A
	for <stable@vger.kernel.org>; Mon, 18 May 2026 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090008; cv=none; b=oTBN3A6zZa9cE+uy47yZ0hNjbnt0B3GyimgLpKdKPbaEx5ht+/1tmTS2LL8tTSlrK2QRsGVP1OIS2B1wYMMvPYIOAzaxFsP8/TwXxh4TuujaH/O/9DxAXEdpluyD4eSi9dXZiDw5xD86Fhj6lGLGvwg1sxIi8acgutJXuOX3FXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090008; c=relaxed/simple;
	bh=XX+NCiRBpx1RRKv5/r+32dJcg+j+AcRG7OLhJl2qFXg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uqJE5vXeh2rjGsgO4JGPwmrZz0LfGSQd8qQsPn+SzT5TsIxi7U11tpkAdParzGoPbG4bJXZHRuR6zWocICVMlIuRxkNF1ZpTDdY2HpHzOfs0QYpOyVb5u566wdWd5q5aOFPMohV2RY0N8Ule3ss/NS6PNuNAnxAERm+mtl5oFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jtn0ekis; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9950C4E42CE4;
	Mon, 18 May 2026 07:40:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6666C602B8;
	Mon, 18 May 2026 07:40:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3F2411AF8605;
	Mon, 18 May 2026 09:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779090001; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XX+NCiRBpx1RRKv5/r+32dJcg+j+AcRG7OLhJl2qFXg=;
	b=jtn0ekistDGlG3TEVGexLbGAC6LLAoM1LCVTQNCSh8o4h718BX4AxRZ9/FJXvnpeUbla8X
	nuEHbo5v3sKlgyWzSJa6vBkxhoq8k0BsfEDZ0lb3MkYZByYKPUapDzdiDFwD33/bo+1RqN
	NUQQBgif23qEojb/UjgWiy9nz1pTWctxfs1iLMmuDG2NYQQJxdCXWW/r4Y1xQKvnOQ3pyN
	0mAuaf4piMoBDGtPIXuhRg7p4QvsJNh6e5k5wFV2raOTOnyZywKn60DHZ5z65y3srxHjIU
	GUyv3kmuNHD+/Zxn8we6bnAJiSFITIoUchMJbBjbPAnA5xlCHmgiGZvAExcuiA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  =?utf-8?Q?Gr=C3=A9gory?= Clement
 <gregory.clement@bootlin.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvmem: layouts: Add fixed-layout driver
In-Reply-To: <20260515-mathieu-nvmem-fixed-layout-v2-1-8ac215dd4016@bootlin.com>
	(Mathieu Dubois-Briand's message of "Fri, 15 May 2026 13:56:56 +0200")
References: <20260515-mathieu-nvmem-fixed-layout-v2-0-8ac215dd4016@bootlin.com>
	<20260515-mathieu-nvmem-fixed-layout-v2-1-8ac215dd4016@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 18 May 2026 09:40:00 +0200
Message-ID: <87ik8lupwv.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 41CFC5680DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-249210-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Action: no action

Hi Mathieu,

On 15/05/2026 at 13:56:56 +02, Mathieu Dubois-Briand <mathieu.dubois-briand=
@bootlin.com> wrote:

> Current implementation isn't working well when device tree nodes have a
> phandle on a fixed-layout nvmem node. As the fixed layout is handled in
> nvmem core, no driver is ever associated with the layout, and the device
> consumer driver probe is deferred indefinitely.
>
> Remove the specific handling of fixed-layout and add a layout driver.
> This makes the fixed-layout similar to all other layouts, fixing the
> whole issue.
>
> Fixes: fc29fd821d9a ("nvmem: core: Rework layouts to become regular devic=
es")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks!
Miqu=C3=A8l

