Return-Path: <stable+bounces-256924-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFtEE8oGG2o4+ggAu9opvQ
	(envelope-from <stable+bounces-256924-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:48:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CB460DD42
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45F05302F6B9
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB8F30674D;
	Sat, 30 May 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/Jd6AOt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5769320CAD
	for <stable@vger.kernel.org>; Sat, 30 May 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156103; cv=none; b=aRvIXny8soxuAeh1CDiM0IwB5Wk0vjM1AeLEvm6DG4ux2YxegKyZqrTXIksRBz9UmDgf/hZmzMkkokHwCOV2h3j1O/Yv5Bp4ndSpcLP0ECKYR3vP5KhUCF912td1e3EiQY/dHcSPFgeWqHPbBOfIiicT/tawEoqLxDm5ThJFDkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156103; c=relaxed/simple;
	bh=3QNS3ZbuDwIk75R0KuRN0Ufpv70QDuRJTF2bWR1s/dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/iNoeaw2FgtQ0hL1uVRaN+LC3k+wX54Y7Dj491GS6fsCB3IiQl0jdO0NhurgT9XW7baYyHzyRt5e8RWkZ3TyY3rhj9khne/HcH46xOwvfBZGbmPkjIsSmqGp9wtRhBHMxoKgl3S+xNpUJJ/q8SxU3ZirSOncINyLhpp1U024t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/Jd6AOt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E3A1F00899;
	Sat, 30 May 2026 15:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780156102;
	bh=3QNS3ZbuDwIk75R0KuRN0Ufpv70QDuRJTF2bWR1s/dI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H/Jd6AOtVpgGZ9yDiQKCxkSEAWPUNAqy9q8qCfJhhi+vnmKonVj1Ugpmym+jYcPYh
	 LOGqG+f1T20k6L8BWBU+l9DQDckXM5+f8bqggDx9UUr8qt3hrDRPhqAX181v2B6PKK
	 2gHuVr9iWPwEyLT3jhrnKJnVeP1Mt+VtbowlzxnsEEwTGNl7BfJGg7PhlJCpd/aQQW
	 /l32kY3ZVPCzilQbg6JlyWMGr4jbjQMELG1OSUIVoV+6wGKrc2UGwJCCw2oVkrKD/P
	 ozGrTTWkYMzUwG11ApjI5ZWHgaqSF8HSc38ysf1JGkgq4IGe/FDF5hd34/3+6Oakh1
	 5gct+RCOWouNw==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	gus@collabora.com,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-5.10.y: (build) use of undeclared identifier 'BPF_PSEUDO_FUNC' in arch/arm/net/bpf...
Date: Sat, 30 May 2026 11:48:18 -0400
Message-ID: <20260530150204.bpf-arm32-pseudo-func@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178014234420.7843.1328062815700584977@330cfa3079ca>
References: <178014234420.7843.1328062815700584977@330cfa3079ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256924-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D8CB460DD42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> New build issue found on stable-rc/linux-5.10.y:
> use of undeclared identifier 'BPF_PSEUDO_FUNC' in
> arch/arm/net/bpf_jit_32.c

Dropped the offending patch from the 5.10 queue. Thanks!

--
Thanks,
Sasha

