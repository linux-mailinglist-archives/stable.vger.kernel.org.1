Return-Path: <stable+bounces-256356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFpCMRatGGpymAgAu9opvQ
	(envelope-from <stable+bounces-256356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A1A5FA114
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 23:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72498324CACE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5EC34041D;
	Thu, 28 May 2026 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="G/Kt3Cqv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50EB318B96;
	Thu, 28 May 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001471; cv=none; b=kBgZ621zlBZBvstx/ReEojhT4mnuCxpqQ/rJ4IRLscxxu078z4nGfO7TdFn97rnhQFWGdzKZFh2kD+NCsjxGHsFVqp6V23HzfZ9MQsyQUaHpofjPIMfS3zDcHGzkL2z5/mNmht4erk5bprQ+RGs9vN6ksn/lFfN71EUyAph43Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001471; c=relaxed/simple;
	bh=I1GcGmZGH2AERGxFstdO/MuLIF6fPdput2Zq5N+gU9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3jRSEFqVKICRNgRNRVHAF7I/2vsZwWqveyl0hwli2ljNsuO9T5Fl4kRsWjZxTy8HN0Ow0NK31IaSHcccco/l+Y3+2tWb+lsAqO5wqDTnD7FfJ3xyCSUrP7S6RgPNf5y8cQKpPnsrugAzvY4D5NwAlNGP96R5zIPwhBwHCZopBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=G/Kt3Cqv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 238591F000E9;
	Thu, 28 May 2026 20:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780001470;
	bh=NfoDfHaWRFOtKM+Dml/6xCbPuUMfg6I3eau8CnNUkhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G/Kt3CqvN2FnsO+CH23hqxWfD8M851xudELSWr1JTogJrRWYZoEAzEiVB9byAkrqf
	 InMi4r7V9ly2wgqp+FfXgWTG9vX9OCpvKqTLjSwU0ig7GAlesnksKk7CywkMpXHnNo
	 wjPJ/WLEEDca/EKL9pLGSq6HXm8LW3raEYZ1kgko=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 138/186] net/smc: avoid NULL deref of conn->lnk in smc_msg_event tracepoint
Date: Thu, 28 May 2026 21:50:18 +0200
Message-ID: <20260528194932.677162024@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194928.941004471@linuxfoundation.org>
References: <20260528194928.941004471@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,asu.edu,linux.alibaba.com,linux.ibm.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-256356-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 26A1A5FA114
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit 7bf563badd37cb796df5477d2b78bb64148a1268 ]

The smc_msg_event tracepoint class, shared by smc_tx_sendmsg and
smc_rx_recvmsg, unconditionally dereferences smc->conn.lnk:

	__string(name, smc->conn.lnk->ibname)

conn->lnk is only set for SMC-R; for SMC-D it is NULL. Other code on
these paths already handles this (e.g. !conn->lnk in
SMC_STAT_RMB_TX_SIZE_SMALL()). With the tracepoint enabled, the first
sendmsg()/recvmsg() on an SMC-D socket crashes:

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [...]
  RIP: 0010:strlen+0x1e/0xa0
  Call Trace:
   trace_event_raw_event_smc_msg_event (net/smc/smc_tracepoint.h:44)
   smc_rx_recvmsg (net/smc/smc_rx.c:515)
   smc_recvmsg (net/smc/af_smc.c:2859)
   __sys_recvfrom (net/socket.c:2315)
   __x64_sys_recvfrom (net/socket.c:2326)
   do_syscall_64

The faulting address 0x3e0 is offsetof(struct smc_link, ibname),
confirming the NULL ->lnk deref. Enabling the tracepoint requires
root, but the trigger itself is unprivileged: socket(AF_SMC, ...) has
no capability check, and SMC-D negotiation needs no admin step on
s390 or on x86 with the loopback ISM device loaded.

Log an empty device name for SMC-D instead of dereferencing NULL.

Fixes: aff3083f10bf ("net/smc: Introduce tracepoints for tx and rx msg")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_tracepoint.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_tracepoint.h b/net/smc/smc_tracepoint.h
index 9fc5e586d24ab..380451912c4f1 100644
--- a/net/smc/smc_tracepoint.h
+++ b/net/smc/smc_tracepoint.h
@@ -51,7 +51,7 @@ DECLARE_EVENT_CLASS(smc_msg_event,
 				     __field(const void *, smc)
 				     __field(u64, net_cookie)
 				     __field(size_t, len)
-				     __string(name, smc->conn.lnk->ibname)
+				     __string(name, smc->conn.lnk ? smc->conn.lnk->ibname : "")
 		    ),
 
 		    TP_fast_assign(
-- 
2.53.0




