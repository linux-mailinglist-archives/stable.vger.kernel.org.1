Return-Path: <stable+bounces-212529-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FWnBwk7emlN4wEAu9opvQ
	(envelope-from <stable+bounces-212529-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:36:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FAAA5E09
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 962B532D0254
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD63301465;
	Wed, 28 Jan 2026 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nf7fD37m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7D3081BA;
	Wed, 28 Jan 2026 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615824; cv=none; b=F0pMQHpd3iFnURBRz0fpGRPzvlIrzxu/PMU/KNDrX76jzLHfZNbeLJWHf0zH4chiVAZcla1f4p8Tq6LP1r5d3TumxmrrcNVj0kt0ym2+NWLD4e+9Jj8GROIkP5zeUeoe7O1Hyi3pl9LMMYoMEWCs6LZ/UpSIJcJGs/o0ruTCEE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615824; c=relaxed/simple;
	bh=ElKQek7G97kSRJgqa0curSLAnQw7f7+MjM/YrQ5Aiwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFygA6dSlDBHtf2iBMve0WcZgYzL6Jld0egMdsGxCisaexxlqxgKCLHYYm+2L31hx48zjgYX1NpBODnZ9DOO4mytUT8cCQMQRNzkOiBvgn3V/tNTitcyh1xJW0RUcqm8QY3EODA+77E0mS/a+1upkmc1vBgZ1k6MpOrMUz6RwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nf7fD37m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A21C4CEF1;
	Wed, 28 Jan 2026 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615824;
	bh=ElKQek7G97kSRJgqa0curSLAnQw7f7+MjM/YrQ5Aiwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nf7fD37mSVdJXAx8hzp9BWmvVUVNXMgrezvrSTm0Cy8dzLTeUbE52HtWaSRFkdnHm
	 cZOa8Tqmo67CPqlgDG8/8PsDecVqJx1vp45Xc65UvLRNAxu10Kf+wE3YZlRVmGCvL9
	 4GGPWDcpZLIx2YNmiI6mR/h66hRQdTmoQb+bqNi0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 124/227] selftests/ublk: fix IO thread idle check
Date: Wed, 28 Jan 2026 16:22:49 +0100
Message-ID: <20260128145348.926181049@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-212529-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernel.dk:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71FAAA5E09
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 75aad5ffe099a1b1a342257236dc260493917ed2 ]

Include cmd_inflight in ublk_thread_is_done() check. Without this,
the thread may exit before all FETCH commands are completed, which
may cause device deletion to hang.

Fixes: 6aecda00b7d1 ("selftests: ublk: add kernel selftests for ublk")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 6b8123c12a7ae..0e863d13eaee4 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -718,7 +718,7 @@ static int ublk_thread_is_idle(struct ublk_thread *t)
 
 static int ublk_thread_is_done(struct ublk_thread *t)
 {
-	return (t->state & UBLKS_T_STOPPING) && ublk_thread_is_idle(t);
+	return (t->state & UBLKS_T_STOPPING) && ublk_thread_is_idle(t) && !t->cmd_inflight;
 }
 
 static inline void ublksrv_handle_tgt_cqe(struct ublk_thread *t,
-- 
2.51.0




