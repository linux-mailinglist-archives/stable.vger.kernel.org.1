Return-Path: <stable+bounces-218022-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLnCOis5nmnQUAQAu9opvQ
	(envelope-from <stable+bounces-218022-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:50:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9967918E30B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B30943056D80
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 23:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F89363C65;
	Tue, 24 Feb 2026 23:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0VwyV2g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048302D876B;
	Tue, 24 Feb 2026 23:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771976995; cv=none; b=WjgtAgBStRRwAR6RJW763YLpjBChzipDWcDPNvSSQPMGKBcd/r9m7CSVXe9TnQUueV+2i1QdiWlI5oPghTRQYgGoMJ8tZU/H21370EDtETG2DRJDkRKG2uZ7cmazWltr+UdS5kRlSOuqY9c6Fl5dkRzbAuzRdYbCcJbod2mDXiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771976995; c=relaxed/simple;
	bh=FGGuPZNGyCWAYKXaCUE/N/nQdSlJWii9ITxMe7XO4K4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZ+/jsB61xNFqO049CbNajF9uHxQ1dS9W8vt34NoPyivNJ1QbNKmOomEM7S3m8dgWXAP2USZBgJ58acwWQBp8OfPaFNCHycJwzwbA8NJhQ+FDNXwAaj24jE7qFxPvA9VAwuUFnHQjmYK5q7PEYyr25rJO7RRQgKt+btIFV7CdqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0VwyV2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2971C19423;
	Tue, 24 Feb 2026 23:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771976994;
	bh=FGGuPZNGyCWAYKXaCUE/N/nQdSlJWii9ITxMe7XO4K4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s0VwyV2gikBEjsLGksFogTimmM6tUxJmCJMjz3BXyWAcLfWNKev76S0hhr4HntBOK
	 mX8Vq73pjD34HKyrIPQd1nnHXvyHhnqXr/Y2XBY8bujPLUDGTbFMDs+isKuZt8gcVj
	 aJ8er/Gsjdxw1tTR7wYjiQ8EbL7UfN2NK4NWdf5Y95Aay7FGG2HohS/XksIzdv3Ddv
	 t/E3sD1bqOqc7ZMVMJQbfGLN6CvDUfGqZKHtmvzHjf93LPE9fML5wgCb8KEaAy5WjS
	 jdbnMfNo4rUfT1jeaKk2iH5vDwWrwv3Isya7WJjq4r6uo9m9TE9UtaByMnkzNswxLe
	 Qope5ARpakCKQ==
Date: Tue, 24 Feb 2026 15:49:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <danishanwar@ti.com>, <rogerq@kernel.org>,
 <horms@kernel.org>, <mwalle@kernel.org>, <nm@ti.com>, <v-singh1@ti.com>,
 <vadim.fedorenko@linux.dev>, <matthias.schiffer@ew.tq-group.com>,
 <vigneshr@ti.com>, <m-malladi@ti.com>, <jacob.e.keller@intel.com>,
 <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <srk@ti.com>
Subject: Re: [PATCH net 2/3] net: ethernet: ti: icssg_common: set
 irq_disabled after disabling TX IRQ
Message-ID: <20260224154953.63b558c1@kernel.org>
In-Reply-To: <57e05b57556e94ed666acd8b4c542efc28e7408b.camel@ti.com>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
	<20260220041431.372610-3-s-vadapalli@ti.com>
	<20260223184840.06069afa@kernel.org>
	<57e05b57556e94ed666acd8b4c542efc28e7408b.camel@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-218022-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9967918E30B
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 17:54:18 +0530 Siddharth Vadapalli wrote:
> 			CPU0					=09
> 				CPU1
> 		----------------
> 								--------------
> 1.	TX HARD IRQ Handler entered				NAPI TX
> Handler is running
> 2.	irq_disabled is
> set							Sees irq_disabled being set
> 3.	Starts executing disable_irq_nosync()		Invokes
> enable_irq() for TX IRQ before its really disabled

Could you resend your last email fixing the line wrap issue? It's very
hard to read as it arrived on the list.

=46rom what I gather you're concerned about the case when hard IRQ and
NAPI run in parallel. But I don't see how that could ever happen for
Tx (there are some complexities like netpoll and busy poll but those
will return false from napi_complete_done()).

