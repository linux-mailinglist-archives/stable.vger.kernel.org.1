Return-Path: <stable+bounces-224705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDgjKWKKsWnkDAAAu9opvQ
	(envelope-from <stable+bounces-224705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:29:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0102668CF
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 16:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3C613041B54
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2650D3DDDD6;
	Wed, 11 Mar 2026 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TLfp3kH0"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262A3E025A
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773242751; cv=none; b=XiYvCK5SJDVhaPieXjchZJhVUOHYM2+d3vymljw7oz+A0rEanp9d+DexpM+jI1v2HiZ9dWJzCjrHMVWl8/QFOUlqgDqcdqp6IY4XwX8Zuybjwl6yq2g1RzUAa8lWX8a++jg/a5ZgyciYJmUpLMS7yV4ij5cTkv19xz4ox0FcNzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773242751; c=relaxed/simple;
	bh=bkiaz6E0edhrQwGbk3gSBTj8xTEGXUpPIZT2T6dSeTI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CVblY9QblctyqhqdRe5esD/KpTFCJVKaucvKYObejySKbKFoAGd37t3ZRYlnGb9RL+cy8kf/EUoMGWRgz7JGZu9ht+TQBsw+ZPWAAR1L0Oir/zf1djIWhPYcIrRO665CjVdvtRAeAXfE2ZGL/gYE6dZFkFkY7FEihVVeAVeAAFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TLfp3kH0; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 05A7C4E4261C;
	Wed, 11 Mar 2026 15:25:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D053860004;
	Wed, 11 Mar 2026 15:25:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5731510369CF8;
	Wed, 11 Mar 2026 16:25:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773242748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5OW0hen2X3xumMz6+CDqqdmFSpIU00t+KoX9yDahxZ4=;
	b=TLfp3kH0ueoIj2SYieOv0YwFeZu04U9mFbIokviX28QNyVtNv6MRXHdT0jb495ed2JZufB
	JEqaFK8XkhHq939WY4fwToSVVNhr+CQz0k154YwWnq8AHRh0ZZ8tykPGqPghXASEGTTY8k
	10Np6qL44bRwCLpeKiGMpfpMRzj8OxB+kWmbmqpjfRy0t5abxu9TcSdPRyOPuhXEM5u/fN
	UbyTDoSw175FYGGdIQ3FoO0zuzfh4xTuVkxGLm0IcWcbcjkRSz0xBs2/x9DW3ewZax3ZlB
	5hD/vecKIJ1t52ZwkO+pjhfHzHn33/zTXWRHeW8cwmhweQ+L2zBKatDfbfRO5g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: robert.jarzmik@free.fr, richard@nod.at, vigneshr@ti.com, 
 James Kim <james010kim@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260309060512.3634570-1-james010kim@gmail.com>
References: <20260309060512.3634570-1-james010kim@gmail.com>
Subject: Re: [PATCH] mtd: docg3: fix use-after-free in docg3_release()
Message-Id: <177324274715.685435.11891174430507900267.b4-ty@bootlin.com>
Date: Wed, 11 Mar 2026 16:25:47 +0100
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224705-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[free.fr,nod.at,ti.com,gmail.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BE0102668CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 09 Mar 2026 15:05:12 +0900, James Kim wrote:
> In docg3_release(), the docg3 pointer is obtained from
> cascade->floors[0]->priv before the loop that calls
> doc_release_device() on each floor. doc_release_device() frees the
> docg3 struct via kfree(docg3) at line 1881. After the loop,
> docg3->cascade->bch dereferences the already-freed pointer.
> 
> Fix this by accessing cascade->bch directly, which is equivalent
> since docg3->cascade points back to the same cascade struct, and
> is already available as a local variable. This also removes the
> now-unused docg3 local variable.
> 
> [...]

Applied to mtd/next, thanks!

[1/1] mtd: docg3: fix use-after-free in docg3_release()
      commit: ca19808bc6fac7e29420d8508df569b346b3e339

Patche(s) should be available on mtd/linux.git and will be
part of the next PR (provided that no robot complains by then).

Kind regards,
Miquèl


