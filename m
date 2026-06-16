Return-Path: <stable+bounces-265052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d1RjOxSEMWqNlQUAu9opvQ
	(envelope-from <stable+bounces-265052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:12:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4D2692DD2
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:12:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=IFXsGF4h;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265052-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-265052-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE56D31F5336
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D1472767;
	Tue, 16 Jun 2026 17:00:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9A543D4E9;
	Tue, 16 Jun 2026 17:00:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629237; cv=none; b=WtT+LinUbv8zAkgN0Za+1VjS58GujfDR8E0TqilopQsKli1e3Qe7FyTNG0WazpA/WrgdKFMEXk7sVkQEiMO8xCim0TImm2zkckTPg77eHNxhE9RZIyoQ9ii1YjrDHCHK8WI/wt72oBZXaPKPUKbtmYadar2iOKLIDIKcyJkQXbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629237; c=relaxed/simple;
	bh=WBbvrpGltJDPX8mcWaAAGMYZq9Mf2IiAFmdYVjxP9Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMuQsSrUw/VfR+8Bf5opCkzZhML6vKC0Am2rqtWlx0X9gfeEjoL60JfkEkzoWhUtNmIpEAHnj9jxBn4iKL+26RSWQAvGeK0He6oN7aq1kfBpsO8QH3YNC9pUh/QqTVSaqBtEUHmtTBlgX5oz8Xhze70nYOhhixEsxsgEop5a5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IFXsGF4h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E0B1F000E9;
	Tue, 16 Jun 2026 17:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629236;
	bh=AryYfATxiyYvrd3LrzpnHpEptIERCVsQ80ziG6jvgko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IFXsGF4hAqFbvtPg2Iwajye60S5H9+Lea/2NVLiImDNYwYILI+welVWcoj1k/gruO
	 UlQkNnhJzFiaJOFK99WuvaFiKQ/q5VaNKSl07LkBloY8bHgs9bkgFAS830rbidEzLd
	 ta5lN+YXKj7tvEg064hnYFOeM+k16Aq0OU+Mz2zw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Yuqi Xu <xuyq21@lenovo.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 246/452] sctp: purge outqueue on stale COOKIE-ECHO handling
Date: Tue, 16 Jun 2026 20:27:53 +0530
Message-ID: <20260616145130.601149571@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265052-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:xuyq21@lenovo.com,m:n05ec@lzu.edu.cn,m:lucien.xin@gmail.com,m:kuba@kernel.org,m:sashal@kernel.org,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,lenovo.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,lenovo.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A4D2692DD2

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit e374b22e9b07b72a25909621464ff74096151bfb ]

sctp_stream_update() is only invoked when the association is moved into
COOKIE_WAIT during association setup/reconfiguration. In this path, the
outbound stream scheduler state (stream->out_curr) is expected to be
clean, since no user data should have been transmitted yet unless the
state machine has already partially progressed.

However, a corner case exists in sctp_sf_do_5_2_6_stale(): when a
Stale Cookie ERROR is received, the association is rolled back from
COOKIE_ECHOED to COOKIE_WAIT. In this scenario, user data may already
have been queued and even bundled with the COOKIE-ECHO chunk.

During the rollback, sctp_stream_update() frees the old stream table
and installs a new one, but it does not invalidate stream->out_curr.
As a result, out_curr may still point to a freed sctp_stream_out
entry from the previous stream state.

Later, SCTP scheduler dequeue paths (FCFS, RR, PRIO, etc.) rely on
stream->out_curr->ext, which can lead to use-after-free once the old
stream state has been released via sctp_stream_free().

This results in crashes such as (reported by Yuqi):

  BUG: KASAN: slab-use-after-free in sctp_sched_fcfs_dequeue+0x13a/0x140
  Read of size 8 at addr ff1100004d4d3208 by task mini_poc/9312
  CPU: 1 UID: 1001 PID: 9312 Comm: mini_poc Not tainted
     7.1.0-rc1-00305-gbd3a4795d574 #5 PREEMPT(full)
   sctp_sched_fcfs_dequeue+0x13a/0x140
   sctp_outq_flush+0x1603/0x33e0
   sctp_do_sm+0x31c9/0x5d30
   sctp_assoc_bh_rcv+0x392/0x6f0
   sctp_inq_push+0x1db/0x270
   sctp_rcv+0x138d/0x3c10

Fix this by fully purging the association outqueue when handling the
Stale Cookie case. This ensures all pending transmit and retransmit
state is dropped, and any scheduler cached pointers are invalidated,
making it safe to rebuild stream state during COOKIE_WAIT restart.

Updating only stream->out_curr would be insufficient, since queued
and retransmittable data would still reference the old stream state and
trigger later use-after-free in dequeue paths.

Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Reported-by: Yuqi Xu <xuyq21@lenovo.com>
Reported-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/94318159b9052907a6cbb7256aee8b5f8dfbfccb.1780510304.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/sm_statefuns.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 5e9449b0c7907e..583d83dcb8426e 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2597,11 +2597,7 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 	 */
 	sctp_add_cmd_sf(commands, SCTP_CMD_DEL_NON_PRIMARY, SCTP_NULL());
 
-	/* If we've sent any data bundled with COOKIE-ECHO we will need to
-	 * resend
-	 */
-	sctp_add_cmd_sf(commands, SCTP_CMD_T1_RETRAN,
-			SCTP_TRANSPORT(asoc->peer.primary_path));
+	sctp_add_cmd_sf(commands, SCTP_CMD_PURGE_OUTQUEUE, SCTP_NULL());
 
 	/* Cast away the const modifier, as we want to just
 	 * rerun it through as a sideffect.
-- 
2.53.0




