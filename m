Return-Path: <stable+bounces-222604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM08LTSYpWnXEgYAu9opvQ
	(envelope-from <stable+bounces-222604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:01:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 981A21DA46C
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF02B301F6A2
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873103FB049;
	Mon,  2 Mar 2026 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPu09c9E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494763A1E81;
	Mon,  2 Mar 2026 14:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460076; cv=none; b=FtYhj4nitXh9aF+9Vo5C8OKdb3oH+KbTFdytSIAee8mosYKaNA6RhDBd+bUF0UuK2sbEk40YWryj7D+Q5Yhd6aidHeZg0ry6T4u66QyhnXuf05ljGC16GZ8Kt6Uv1fR2U8LjGwW3A4TGiFPRJhlXjVRdN1XBcTnQ5qGaIyUp70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460076; c=relaxed/simple;
	bh=tUpfG0c7TtjX7Rl8Yb87VI1i/wWvp11fpw81NXXqqYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apHRg+27X7R0zT/vGMXO542zcCAAllyQ/dqiOg+QSRdBzmPn0QphERgCvTAwjUdzEKiUHXIDtjMOFyw+lp58lKtxDpatoVpMeeiYHsf1Ne04sny1P98jZ1tBkEu+zehPpfJ0kH6VDsvheoyHUCSRKDEbAPk8sqEAejpHLR4YvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPu09c9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53E9C2BC87;
	Mon,  2 Mar 2026 14:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460075;
	bh=tUpfG0c7TtjX7Rl8Yb87VI1i/wWvp11fpw81NXXqqYg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cPu09c9EzdWvAhzk0o9FL7IrrIFc40AtcRLnOL5hWUDV/4j6IjKZ/5JJVlxzKjx0v
	 Zxvop8L7J75tvxrbS0Q3QBsR2uLqGqnbadmY0zPolKwKpLWFSSQ6v2cOC1qAg1v4dm
	 DQSK9IogseuZldYsONIExQhvgfp4TVnz6Xtlz8124VbjmQ+YyxDNegpSEg/dJFR1qh
	 n1adKuHRHtwtNXem/FJ6ZNq3tOWUFIh+wB+xiNbUR3sGN92dEBlPDcvT8v54YMXvQf
	 lDnRXm+YWpurrRxmvds7kP59U1v695wR7nhYozk3a1xiXrz9id9vppWMeklRaWVKpV
	 IEKpN2wssqFmQ==
Date: Mon, 2 Mar 2026 09:01:14 -0500
From: Sasha Levin <sashal@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>, Hyesoo Yu <hyesoo.yu@samsung.com>,
	Quentin Perret <qperret@google.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 6.19 831/844] arm64: Force the use of CNTVCT_EL0 in
 __delay()
Message-ID: <aaWYKgwkuINjzFKi@laps>
References: <20260228173244.1509663-1-sashal@kernel.org>
 <20260228173244.1509663-832-sashal@kernel.org>
 <636f00d8-dcba-4724-9184-35a14426aae9@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <636f00d8-dcba-4724-9184-35a14426aae9@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222604-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RSPAMD_EMAILBL_FAIL(0.00)[maz.kernel.org:query timed out];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 981A21DA46C
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 08:07:29AM +0100, Jiri Slaby wrote:
>On 28. 02. 26, 18:32, Sasha Levin wrote:
>>From: Marc Zyngier <maz@kernel.org>
>>
>>[ Upstream commit 29cc0f3aa7c64d3b3cb9d94c0a0984ba6717bf72 ]
>...
>>--- a/arch/arm64/lib/delay.c
>>+++ b/arch/arm64/lib/delay.c
>>@@ -23,9 +23,20 @@ static inline unsigned long xloops_to_cycles(unsigned long xloops)
>>  	return (xloops * loops_per_jiffy * HZ) >> 32;
>>  }
>>+/*
>>+ * Force the use of CNTVCT_EL0 in order to have the same base as WFxT.
>>+ * This avoids some annoying issues when CNTVOFF_EL2 is not reset 0 on a
>>+ * KVM host running at EL1 until we do a vcpu_put() on the vcpu. When
>>+ * running at EL2, the effective offset is always 0.
>>+ *
>>+ * Note that userspace cannot change the offset behind our back either,
>>+ * as the vcpu mutex is held as long as KVM_RUN is in progress.
>>+ */
>>+#define __delay_cycles()	__arch_counter_get_cntvct_stable()
>
>This needs:
>e5cb94ba5f96 arm64: Fix sampling the "stable" virtual counter in 
>preemptible section

Queued up, thanks!

-- 
Thanks,
Sasha

