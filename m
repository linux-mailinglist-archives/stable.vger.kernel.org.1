Return-Path: <stable+bounces-249078-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBmBNZzDCWrZogQAu9opvQ
	(envelope-from <stable+bounces-249078-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:33:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 810BD561365
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7B6713003363
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5D1383C89;
	Sun, 17 May 2026 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/fHE+kS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817EC36F42B;
	Sun, 17 May 2026 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779024792; cv=none; b=uL5s0lO4ua7I+rjIoRerwD1/SoXWsy+AWEwJg5NKmpjJt3Ia9qXpFLtZUzeUYTHGGkYxCP77lx5dXU2m58rabnCGYuQx8/hlm4iVMHML2v1HM41EcTBBAQr5itedBo/RLR3e8kGEV3+sPDDTWfyVdQ6VV1ucFsIFCW0ILwwxNag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779024792; c=relaxed/simple;
	bh=AiZTBlafb7z0CCv9PU+ljAA15vHw3VWuUBSm7krMXjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzvUNYrLDrMEWq5dSmcZaJTuZvtSe6yMQLHjqmKke/GGMF2ja9geacXFcYoM/zHuroVk1r8M6WiHT+1T96YtjgcIqWsBvp+kHbeh9tK8dWX+xNFoTu8geMLJZ3Uk2I7VJHJG3irtEX2a5tzvU/oG3/veZQiXJR9bp8sp/jGthck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/fHE+kS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A788C2BCB8;
	Sun, 17 May 2026 13:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779024792;
	bh=AiZTBlafb7z0CCv9PU+ljAA15vHw3VWuUBSm7krMXjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O/fHE+kSvIJQsTyn0OeZ7Bb09tAYdfYUbBE8BHjfZPbBTlx59q5/PcC4EhdmeAfdT
	 YxHiPaIO7nqR///XqhGCDaw5ja4igIjWHB7y5CM/HPccgWacYNt+B5TOfSHvR2iuZk
	 daYlLr64PGGVFxqh+viuU8pIztgt/uvhAVAds3nDizUALymmtp+sFCnNwGGOLVJ5Gp
	 LhM1uIIMaGF9tIDYQIKG3qZ4TMrQhAaN1oHaPkRVEAlZTTqfcpyMX0LHwvmie/r1Sh
	 z22jsu6ADiOWGLRHgt3EehFgZF/tULFH2ydYCwO/9bK+IvlswUrOfZc1+scKnuGRsi
	 umsnCPMU6CuFQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Peter Schneider <pschneider1968@googlemail.com>
Subject: Re: [PATCH 6.18 143/188] sched_ext: Use HK_TYPE_DOMAIN_BOOT to detect isolcpus= domain isolation
Date: Sun, 17 May 2026 09:33:05 -0400
Message-ID: <20260516170159.sched-ext-domain-boot-drop@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <508bf3b7-56c7-4290-b663-7daf8ed4e80d@googlemail.com>
References: <20260515154657.309489048@linuxfoundation.org> <20260515154700.426346174@linuxfoundation.org> <508bf3b7-56c7-4290-b663-7daf8ed4e80d@googlemail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 810BD561365
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,nvidia.com,googlemail.com];
	TAGGED_FROM(0.00)[bounces-249078-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> kernel/sched/ext.c:4924:34: error: 'HK_TYPE_DOMAIN_BOOT' undeclared (first use in this function)
>
> If I revert this patch, the build succeeds, and the kernel boots and seems
> to work fine without any observable regressions.

Dropped from the 6.18 and 6.12 queues. The prerequisite enum
HK_TYPE_DOMAIN_BOOT (added by 4fca0e550d50 "sched/isolation: Save boot
defined domain flags") only exists in 7.0+, matching the author's
"Cc: stable@vger.kernel.org # v7.0+" tag. The 7.0 queue retains the patch.

Thanks for the report and the Tested-by.

--
Thanks,
Sasha

