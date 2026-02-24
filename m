Return-Path: <stable+bounces-218023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDh3DT06nmncUAQAu9opvQ
	(envelope-from <stable+bounces-218023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:54:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC818E33D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62202301A7CF
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 23:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA71363C67;
	Tue, 24 Feb 2026 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYEB647E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBE61F09B3;
	Tue, 24 Feb 2026 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977274; cv=none; b=WI1cVV4j7Ue0fUg8CcDUsKQ9lbESMDohEHHbLaLzRQddEZRaf8vvDXrhbEPPom5uOlqxwSjk/Qy2B5G024/3pz+9frCG1xle45agPQIwuTNTRwvMfnB3n4+UL0eMgqVTOW0LFjZFscfDYdBPmOETFHZf4viWxBqL4Ypp1B8DoIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977274; c=relaxed/simple;
	bh=qexNreA3noaNpoPwWdD70RuBwyt5EeVZfegYyF8m7cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krmPNeJD1azk0Fdxqf4AjMCZYmE2ZkV2yoU/ZwD8Bt7nSdEqFt64qp1vdPDd+QAI6/eWOKK2XXSYt6mHzQ/mqhtBVH8SCpmsQhzaIZSb5yRdE/sbcY8OxkmtmT06G/+UxwLV7LxH83Xw/CmfCQvSuzJoesSQB5KjdECKhoCj8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYEB647E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04A3C116D0;
	Tue, 24 Feb 2026 23:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771977273;
	bh=qexNreA3noaNpoPwWdD70RuBwyt5EeVZfegYyF8m7cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oYEB647EzJmppp/2RB2bNjz4U0zSLzPjLUfECABrKnqfFxl+OI7hqQFEcBtVo9iGy
	 Idk9r8iZ+MvGV0MybLailS6CIxs+/gpyO0kpcx3H10OyQLE+xCA8YRRMCBXQaShI3D
	 l1cTz7x1yqwpoiFcS0MOLS1s56hTRM5u5hUYf4wxv733xFiJJayQ9Rt72FeuUxpaD8
	 EvAO92aDeQmyq/dRGZfDsT0CCqH/nYSmuwGj8ZcR8eG1uP235JgGTURChoN+K52SxF
	 ATa7KpKdkHeN4IVT23VYAh9l1qkyeqQjwrwkeDEhFUuDtraPFBwIuZ/ye62yniLf3v
	 /dPrkRzEjGJhw==
Date: Tue, 24 Feb 2026 15:54:32 -0800
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
Subject: Re: [PATCH net 1/3] net: ethernet: ti: am65-cpsw-nuss: set
 irq_disabled after disabling RX IRQ
Message-ID: <20260224155432.15ded392@kernel.org>
In-Reply-To: <c9b1c5c2c5f9587c31132586fddb1921ff6824a8.camel@ti.com>
References: <20260220041431.372610-1-s-vadapalli@ti.com>
	<20260220041431.372610-2-s-vadapalli@ti.com>
	<20260223184803.739c17a7@kernel.org>
	<c9b1c5c2c5f9587c31132586fddb1921ff6824a8.camel@ti.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218023-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_TWELVE(0.00)[21];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8FBC818E33D
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 10:40:05 +0530 Siddharth Vadapalli wrote:
> CPU1 sees irq_disabled being 'true' and before it updates it to 'false', if
> CPU2 also sees irq_disabled
> being 'true', both CPU1 and CPU2 will enter the IF-condition and eventually
> invoke enable_irq().

I think the races are just between NAPI and the HARD IRQ context.
There can only be one NAPI scheduled for a queue, I assume.

> Please let me know if this is what you were referring to. I will use atomic
> APIs at all places to update
> 'irq_disabled'.

I recommend a spin lock, unless you can measure as significant
difference. Locks and atomics have similar cost on many CPUs.
And juggling local state, IRQ state, and NAPI state atomically
will get tricky.

