Return-Path: <stable+bounces-245231-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCEeJ7HpAWohmQEAu9opvQ
	(envelope-from <stable+bounces-245231-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:37:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A13D95104BB
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 16:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6F313028555
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E033FCB34;
	Mon, 11 May 2026 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6/mdimA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B583D9DD7;
	Mon, 11 May 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509320; cv=none; b=FLOgFh/oaGrDQG2MhiJKxi++oavGS0d14FrksrqQA5wQIfL7t8DJm8erC2Ju5PAWo9nWrk8dqVWE1iADNkfw25gXwqAkjC0Gi/+jg85N0jQKhO6cu/TFfe+Oh2837cDADsCT4xtRf+aZg57pJYZpBwrgi4jK/eeq1E8rBn70gBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509320; c=relaxed/simple;
	bh=UWwlvz/FBg65FNAhHu+MP/kqeZ/hILQT6+2DtYu8mYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzTWnHYnZXsyHACELya63EyzSK8RyaqCbPFF5Ol+hnTaQDtQ2mu0NHuSholkSimPVbK9+IfeSJZUNaHAcBx+df0wKdDEGvZDITZwkmQGp2Vxml20I7HQcppuHhH/VPpzZP04DMRNFS8PLCi2hZu1/HKbaH+wHKpFDaI4A7XWh50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6/mdimA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF1DC2BCF7;
	Mon, 11 May 2026 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509319;
	bh=UWwlvz/FBg65FNAhHu+MP/kqeZ/hILQT6+2DtYu8mYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S6/mdimA/Varc6IDGxnvDIUXKWhsf+TjpoEuSUKTty5eHbDf3BHRJ05RVz0nbrw2l
	 JKM2EUD5ZGAy4owhWqPD8rfRwXjNfr7v6AlMulsyuHNMZNZ53Y11hFAaN8Mf+l6s8u
	 qrUuKTtiINSIrMhG3O4u833YpyF5F3lHFk6WFM0X5HzPNcf3xfB1tL7jbicc/xSYko
	 TjW5/YrbyjUnZgS5EIRzR66K1m+Cy/rJwvWiO3G8Ks+1+2vLR6x1uMmkpKYfSIcIu1
	 dlQKOlFGBMMfqoYxy76aBvdh2medwWbFkRXd+98QUTyom97t9igqIgtvAKkIZOYmhz
	 wHXnwSgla+SIw==
From: Sasha Levin <sashal@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev,
	stable@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Lukas Beckmann <lbckmnn@mailbox.org>,
	Mike Galbraith <efault@gmx.de>
Subject: Re: [REGRESSION] 6.12.y: d66792919d4f (sched/deadline: Use revised wakeup rule for dl_server) causes latencies up to 50ms with PREEMPT_RT
Date: Mon, 11 May 2026 10:21:50 -0400
Message-ID: <20260511141441.stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
References: <04657838-46d1-432d-95e1-eb73b930b032@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A13D95104BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,mailbox.org,gmx.de];
	TAGGED_FROM(0.00)[bounces-245231-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 10:57:46PM +0200, Lukas Beckmann wrote:
> I am reporting a regression which was introduced by d66792919d4f on 6.12.y.
> Since this commit, cyclictest reports latencies up to 50 milliseconds,
> on kernels with CONFIG_PREEMPT_RT=y.
[...]
> Is it possible to revert the commit?
>
> I can provide traces or help with testing if needed.

Thanks for the detailed report. Before I revert d66792919d4f from 6.12.y,
I'd like to confirm whether the underlying issue is the missing dl_server
rework chain on 6.12.y rather than the revised wakeup rule itself.

Mike's reply notes that his local 6.12-rt tree carrying the following
three commits in cannot reproduce, while the same tree without them
reproduces quickly:

  cccb45d7c429 ("sched/deadline: Less agressive dl_server handling")
  4ae8d9aa9f9d ("sched/deadline: Fix dl_server getting stuck")
  a3a70caf7906 ("sched/deadline: Fix dl_server behaviour")

d66792919d4f's upstream commit message explicitly says it relies on the
state established by a3a70caf7906, and none of the three are in 6.12.y.

Could you give those three commits a spin on top of 6.12.y (keeping
d66792919d4f in place) and see whether the latency goes away?

-- 
Thanks,
Sasha

