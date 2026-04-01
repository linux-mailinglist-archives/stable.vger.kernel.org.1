Return-Path: <stable+bounces-232642-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBwENtx1zGn1SwYAu9opvQ
	(envelope-from <stable+bounces-232642-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:33:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2F937381A
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 23B4F301C59B
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 01:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912842D2486;
	Wed,  1 Apr 2026 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzSGxm/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CAE282F1A;
	Wed,  1 Apr 2026 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775007172; cv=none; b=jfkP3SVxfEAkaADb4OX3LmZhtbqlHDZySVdmTOUdBcT5BZpz+UzGCDW/5tCuVJisr1I4KVhe1P0XMvpaDHDr+JNOKliXIsCjagQ52TUbG4Mp4lG/8yk7Zvq31X5hWFqVvV0yiogd87sefjDqFHBfQIrdEQleizF4AqIVWd58Wdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775007172; c=relaxed/simple;
	bh=jXZfk1mQPfK1IJl13J6c5AH6YpYSd06uZnkSiI5+/Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLF184uA/se0SFTEKr7Hnpo4tiaMzIjBB9Wcxw/KJ9iHjGCG2KeQIfmsEJJuhSO+/2ScBuu4tPzatmH1CBa9J+rJe45o5dX5pFuvpQdJ27bwcqiJE8Vx9xONUsXsCMK32sNRQR/V+Mj5JHqrCi87Vo5RzozRToatmMPwXCzGByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzSGxm/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 885D2C19423;
	Wed,  1 Apr 2026 01:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775007171;
	bh=jXZfk1mQPfK1IJl13J6c5AH6YpYSd06uZnkSiI5+/Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzSGxm/YXsYrSnsIGTiO722hvWDxeLVFmyn0TeukvOA192Z2O0S/92vynODty1E99
	 ooiy23VGQnQsCWlx+SelpYT5euY4WiA0qnUQx/RlqMw/9xgWUGuLNqhODRklf/iOQO
	 k7B1bMGaf5uSK5XGBRX8sy4FaIBczCQmBHnsk89gKZeB21nb3R74Nl0+cw/1J30z6e
	 4jfZXDVQYH12XX0tl3FLXuUyblWplTmwV+18un109j/qti6tNb6mf/CU+Ef0AFCjo/
	 thQqDA2FOayjKvZqU8lbZ2G12iH+Gyq8Qahp5HgcvTIBRdFO5vMRrKcBN/eL2sJDpR
	 vlLcFLidg9qYw==
From: SeongJae Park <sj@kernel.org>
To: Jackie Liu <liu.yun@linux.dev>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	damon@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/damon/stat: fix memory leak on damon_start() failure in damon_stat_start()
Date: Tue, 31 Mar 2026 18:32:49 -0700
Message-ID: <20260401013250.90153-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331101553.88422-1-liu.yun@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232642-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email,kylinos.cn:email]
X-Rspamd-Queue-Id: DD2F937381A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+ damon@lists.linux.dev.  Please Cc damon@ for all DAMON patches.

Hello Jackie,

On Tue, 31 Mar 2026 18:15:53 +0800 Jackie Liu <liu.yun@linux.dev> wrote:

> From: Jackie Liu <liuyun01@kylinos.cn>
> 
> Destroy the DAMON context and reset the global pointer when
> damon_start() fails. Otherwise, the context allocated by
> damon_stat_build_ctx() is leaked, and the stale damon_stat_context
> pointer will be overwritten on the next enable attempt, making the
> old allocation permanently unreachable.
> 
> Fixes: 369c415e6073 ("mm/damon: introduce DAMON_STAT module")

As this is a memory leak, let's add Cc: stable@ too.

Cc: <stable@vger.kernel.org> # 6.17.x

> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

