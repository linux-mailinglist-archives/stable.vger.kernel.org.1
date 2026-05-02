Return-Path: <stable+bounces-242565-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPaYMKM+9WkzJwIAu9opvQ
	(envelope-from <stable+bounces-242565-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 02:00:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E52F4B06A9
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 02:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69E4D30091ED
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 00:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377CF40DFD8;
	Sat,  2 May 2026 00:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbeGw7X/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0812BFC60;
	Sat,  2 May 2026 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777680029; cv=none; b=Upo6Y3mQgD6BfNJlKeZRcj/3ya8D0KiNhWoCJfrmWID9OUYBaX87COAFgCUacpT/0vQeKJzLmMej61luDCW3eG/6dsI+ojKPswRVicQZ4H6XF0kBT2k950b6MjKBBIpc0uvE+KjvCwND4pZl361eVsPfS+coXn1n5vgrPTBzPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777680029; c=relaxed/simple;
	bh=EKoHZzA+zQAMhXC+YozWh1Hk1ILV33sRj7TP+xz0HCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzAG0vQbcCPGfcSBOvqYhQj1U0/xT+BT/VuWmo0Qx43Qb/tF/fjIyPDme5Uyo/BktKtXT0ojWESlSLXhFib1wJttZOrPWvc8Zf8X1CyTCLo0p5zjyhDMA2q1lIVz1PMNSi0LfCEc6DcRvGCpc+LnK94IfzpmeJk/IksL7hXXeh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbeGw7X/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16AC8C2BCB4;
	Sat,  2 May 2026 00:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777680028;
	bh=EKoHZzA+zQAMhXC+YozWh1Hk1ILV33sRj7TP+xz0HCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gbeGw7X/e+03Vf7TKS7+w89zUYT/SWF25BtVsPh8m6IEjMOpnvEOBW/b90IlOzM2U
	 2dkwbF3YkD2BZ4hYkCghUtMxK52mLihSL+YjccwbNyFueBTL6zDJEoi6q4XYPs0pw3
	 hFUUT1IKsdJ3oFvxodgnrgrbjUY/ay7wHDDdHkjvLxrBr4wYjf4ZGpccWZYXBHCYs2
	 6kml2ZkDoUijknBd9SAr2QHbtSvrTRw+qTc5gKi9gc1RMFIwq/BXMUrHiMUEnutqol
	 8AzW2rT/AIJxRR9+XaaEWYR3342pa6u0DaqugDxxUXXPg7lqCsrlWHjjJJJuEP43dn
	 cW6tcqmaE2Gfg==
Date: Fri, 1 May 2026 17:00:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: David Carlier <devnexen@gmail.com>, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, raeds@nvidia.com, kees@kernel.org, cratiu@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] psp: strip variable-length PSP header in
 psp_dev_rcv()
Message-ID: <20260501170027.55516142@kernel.org>
In-Reply-To: <ba78786c-881e-4cf4-91d1-7e9d21194454@gmail.com>
References: <20260430062033.20428-1-devnexen@gmail.com>
	<20260501130046.16008-1-devnexen@gmail.com>
	<ba78786c-881e-4cf4-91d1-7e9d21194454@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2E52F4B06A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242565-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri, 1 May 2026 10:13:52 -0400 Daniel Zahka wrote:
> nit: int psp_hlen might be more consistent with the types/names of the 
> other local vars.

Ah. :)

