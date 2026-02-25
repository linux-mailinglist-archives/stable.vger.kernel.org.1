Return-Path: <stable+bounces-219669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCrWAv8on2nmZAQAu9opvQ
	(envelope-from <stable+bounces-219669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:53:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7987E19B008
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 17:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FC093024A1C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506CA3E8C4C;
	Wed, 25 Feb 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PlWQJmgf"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542A33D9052;
	Wed, 25 Feb 2026 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038194; cv=none; b=L53s7T54mkgq009IcF7+QDzOsgkikwpmC6e7xOpNIxki3YMQc2fjd+Kd/bBD5y2TD5z1OSEfMjXP34Z6vO/PrSjN5Pjbm6NFntGKLK7jE/SnAEKRidyyWIX/vy2bTgyJxouimHKaHetHV+tndLMeWljaUbW+uOR0CIlrZGA94pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038194; c=relaxed/simple;
	bh=eBN/LQaDqEg9TMbX12mRTIKS4fJfRm78/RNdOGnI2ys=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xskv2ssPfOp3YWgO5TmIiISmLJxSL5u/IF8lh7k1qnZ997uOvi+QXj297gqV/75Sfw8URpGmxkq8iDClz4inm3kVrZrg6HiQQTpC3RBYkxdUkvcHbuTSkYU1J0gdoz3Jb7VhMtRKZfUt52tQZwq9ILOsiNgGcJ5Fj7ZofvnfqcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PlWQJmgf; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 68EA1C143FD;
	Wed, 25 Feb 2026 16:50:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3F1BA5FDE6;
	Wed, 25 Feb 2026 16:49:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 09B1010368C53;
	Wed, 25 Feb 2026 17:49:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772038189; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vnlHTw1jpJ7y/IagyfDJhS5F+PIUOtK6DIED1cOc3Rw=;
	b=PlWQJmgfErQnZfaLbvak6rXaJSVWitrl9TTwjyixqnMq8ecms3Xe/ib4+zl4t5iKn+e0it
	3D+uEdXlY1Gl/sHyMjBJUoGGPkuOXGZb0b/0R1QslWCm45f1udnGSjVzU5oAA+VY5V+oiu
	iHeQeHoeOH6obaE9I1FA1BGYhxiziMa7OOy7HPFJtmpkLiMYpEli+jUGosIFMIb5jRpT72
	Jjoe3GrkZjYwd+Mlx4ONXGgOANCb5XmDh48ZDeXauW86bxTNETj/vEKAfpJn2jbENOujgD
	JLgEdFnXRE/SeK3lozvEerw06vgRUQssqaHQSgLiiXGhlSWhMP5xXyJP/69F9w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Finn Thain <fthain@linux-m68k.org>
Cc: Kees Cook <kees@kernel.org>, stable@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <e11761ba31af4fd1d310f40f9b6a1753a0227025.1771225290.git.fthain@linux-m68k.org>
References: <e11761ba31af4fd1d310f40f9b6a1753a0227025.1771225290.git.fthain@linux-m68k.org>
Subject: Re: [PATCH v2] mtd: Avoid boot crash in RedBoot partition table
 parser
Message-Id: <177203818789.1988281.623199213497482365.b4-ty@bootlin.com>
Date: Wed, 25 Feb 2026 17:49:47 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-219669-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7987E19B008
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 18:01:30 +1100, Finn Thain wrote:
> Given CONFIG_FORTIFY_SOURCE=y and a recent compiler,
> commit 439a1bcac648 ("fortify: Use __builtin_dynamic_object_size() when
> available") produces the warning below and an oops.
> 
>     Searching for RedBoot partition table in 50000000.flash at offset 0x7e0000
>     ------------[ cut here ]------------
>     WARNING: lib/string_helpers.c:1035 at 0xc029e04c, CPU#0: swapper/0/1
>     memcmp: detected buffer overflow: 15 byte read of buffer size 14
>     Modules linked in:
>     CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.19.0 #1 NONE
> 
> [...]

Applied to mtd/fixes, thanks!

[1/1] mtd: Avoid boot crash in RedBoot partition table parser
      commit: 8e2f8020270af7777d49c2e7132260983e4fc566

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


