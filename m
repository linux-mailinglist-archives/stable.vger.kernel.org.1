Return-Path: <stable+bounces-245362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJpyNftxAmowtAEAu9opvQ
	(envelope-from <stable+bounces-245362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:19:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0BA517D11
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DED7D302D5E6
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDE21EE7B7;
	Tue, 12 May 2026 00:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EktVZkIk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012DC4D8CE
	for <stable@vger.kernel.org>; Tue, 12 May 2026 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545107; cv=none; b=nk+L1r6iqAAKfJBj3Q8hmSK8FhhU2o7yChxC5T5SM2h5TonTr0LBPt+LBoSzJHyzqirA9rCvuc11XuX9RrUG44hcyP4rsLz1jydmqv+Atppu2JGwQOB6ymQHd1/FH1s12b0Iqna0KR0LeNU7Fm+hxUa6wyYjTSGX7mA3dxQsuZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545107; c=relaxed/simple;
	bh=8V4gNaR/m0NUamH9mTAaMyli4FjffIa1hXkz3kSG284=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpWPuzwGJ+QIo621HjrNM3StdLkYeGqiSrjuqfxfZ5LUEjeziML3keWw8GS0W4bLaaWu5QaEi4CVd80YMOn9EEyA7edhWfCkzBXopbMfL/X1kwsYlppXQFYXFJrNjZdXGUjFQO4RYJ3G+m9q5cDayIcTURfE7VFQnBrqaLMs7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EktVZkIk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77059C2BCB0;
	Tue, 12 May 2026 00:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545106;
	bh=8V4gNaR/m0NUamH9mTAaMyli4FjffIa1hXkz3kSG284=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EktVZkIk1PJGr1EFL1r0O9fB5Exjbhc43nrv7HSAFcoB1ysi4EUKGtPHavKAtoaS6
	 EgXA68RLixyzF60Pmjmr28YFcQYeeHjqXFyquM0TaltJ4Im0xXBFPUcbgSWpKzmcdc
	 I0v0YviBU2baYlIgydmq7b4V7U/mk326OQ/kP2wNTfR351XF61n1DsnPNMevQmwykQ
	 POi5tgS4OHYIwz7U9/z6KtYI3MO+Q8kQejmFrF4mda1YY1arnv5Ph68s/gIyOJygz3
	 NxCdYjKbZ48cMRANEFrVUNzzyLfEUmDBW5nonb1vbu3xt0vyS4L3GiXfoqE0A4+f+9
	 J64PBCDKIhk9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Levi Zim <rsworktech@outlook.com>,
	Paul Chaignon <paul.chaignon@gmail.com>
Subject: Re: [PATCH 6.6.y 00/10] bpf: fix precision backtracking instruction iteration
Date: Mon, 11 May 2026 20:17:53 -0400
Message-ID: <20260511220000.stable-reply-item002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778516196.git.paul.chaignon@gmail.com>
References: <cover.1778516196.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F0BA517D11
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,suse.com,iogearbox.net,gmail.com,epfl.ch,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245362-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 06:21:22PM +0200, Paul Chaignon wrote:
> This patchset backports commit 41f6f64e6999 ("bpf: support non-r10
> register spill/fill to/from stack in precision tracking") again, but
> this time with the subsequent commits that improved the efficiency of
> the verifier. In addition, the last two commits fix and test a
> regression that was later found in commit 41f6f64e6999.

Queued for 6.6, thanks.

I also separately picked up 69772f509e08 ("bpf: Don't mark STACK_INVALID
as STACK_MISC in mark_stack_slot_misc") as a follow-up to patch 3/10
(eaf18febd6eb).

-- 
Thanks,
Sasha

