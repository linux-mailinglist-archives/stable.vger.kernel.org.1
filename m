Return-Path: <stable+bounces-241462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLNuM4QZ8GntOQEAu9opvQ
	(envelope-from <stable+bounces-241462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:20:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2A647CB07
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E98C303181E
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A1390986;
	Tue, 28 Apr 2026 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNPJukUJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742EC2DB7AE;
	Tue, 28 Apr 2026 02:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342848; cv=none; b=ZOjfkl6t/bQ6QnJzLdBLNKQ5kKdWIvf/4LLFEm4PjwacPC6rdJ4LOlPFYmJhwbfKJwkORui/beRYrn6r5qS8gj3Ri00pMZVEWQSwnbH5siT86AVYbUyA69LsafOiKkAnQZJVqV0zGIZf62l26bgURLvfszG7tFufVIcaFf0Bnn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342848; c=relaxed/simple;
	bh=Gu6KcT5kMSGfIXHS8LsPjrLPCL3C4f6PCQ+8/Bvo0KE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NgNF8DE8sVvM7c1jLd5ognLUPl7U/8thKI46ZhNcYUIjzRdhmFm2Q/oz7k+smic5JAY0HOOln5fQiUEgqJFSjhuOy1U+pO/kPu9Bj5lTAFRVWLj+yW8Y74fd++OdusW6erQG9jz7vQwo1dnbPEUWdclkI2o9Av4ghUUQcEjSnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNPJukUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E22EC19425;
	Tue, 28 Apr 2026 02:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777342848;
	bh=Gu6KcT5kMSGfIXHS8LsPjrLPCL3C4f6PCQ+8/Bvo0KE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BNPJukUJ1g1XKPobe0KiW0gzD+pJ4qyPNDFq8O1825Xop64UkXBtcUaoaqQbMjNW6
	 8OuOUwOjLtMJP+G0GUptpR2+iuMiH/rIMfzCrERSc71UALUUKKp3IXt7kve+brdfji
	 ras4Sey0KGO8DJYUc5CLBafYKOUxFIFBnkBeevvjHVd5IMLfVTAZIsZ2ekivqCo7i/
	 Fubps5DV/i+wawOveF7MRR5sMvr5kS1cbYIGF4slJZU43ft3i5kKrvfea6zJUgsHOa
	 r3Z4C2h6ePeA4x8XioCZCSKl6b5T9FgqRy2bmrCot2zc/UJrONMz4k1IM49KWul811
	 CdvvYAGRidjfA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E7D392FFDF;
	Tue, 28 Apr 2026 02:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] ibmveth: Disable GSO for packets with small MSS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177734280556.205517.1747939663275050652.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 02:20:05 +0000
References: <20260424162917.65725-1-mmc@linux.ibm.com>
In-Reply-To: <20260424162917.65725-1-mmc@linux.ibm.com>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bjking1@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 shaik.abdulla1@ibm.com, naveedaus@in.ibm.com
X-Rspamd-Queue-Id: 7A2A647CB07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241462-lists,stable=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Apr 2026 09:29:17 -0700 you wrote:
> Some physical adapters on Power systems do not support segmentation
> offload when the MSS is less than 224 bytes. Attempting to send such
> packets causes the adapter to freeze, stopping all traffic until
> manually reset.
> 
> Implement ndo_features_check to disable GSO for packets with small MSS
> values. The network stack will perform software segmentation instead.
> 
> [...]

Here is the summary with links:
  - [v3] ibmveth: Disable GSO for packets with small MSS
    https://git.kernel.org/netdev/net/c/cc427d24ac64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



