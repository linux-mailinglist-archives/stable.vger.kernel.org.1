Return-Path: <stable+bounces-242339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJMLOSOQ9Gn/CAIAu9opvQ
	(envelope-from <stable+bounces-242339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:36:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3BB4AC141
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 13:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC71A30160E7
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 11:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AA633F8DA;
	Fri,  1 May 2026 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6Cj7R93"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11722EDD62
	for <stable@vger.kernel.org>; Fri,  1 May 2026 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777635359; cv=none; b=oM5nuEPPhL8kfpcQif1dYzThW5YGzHPO82Q2pavM+1+4vQIV0BpVddB0+HZDB3aWSwh8di4YKBLKXOdI3+SHKW5BH2j0dYnJxX4MszHhvTk8VlxcFSuZVge+oPv6MsOgHekpqYuDPcdNxVc7S+6usuBSLyhGI4LE28u3dZZLcIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777635359; c=relaxed/simple;
	bh=0AbSj7+lU7b+idRd0jLGQb1ct9/qFkVQrVzwvR+URjY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sBgB1XkFxrx2ybvzQCZwD9VzduYnMErvL+QiMeHiVBOlLNdPm75YSdL+2HaMuiG33B+zh68sZCC1YdOVyKfMD74yneFc2NdPqcFtff23g9V6UcsuBcqFT+zvKIJU8P+FJ1rwNj2fydfVVZT+T0eZ+VlJT+UAyvJVZXkf7aFK/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6Cj7R93; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F9BC2BCB4;
	Fri,  1 May 2026 11:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777635358;
	bh=0AbSj7+lU7b+idRd0jLGQb1ct9/qFkVQrVzwvR+URjY=;
	h=Subject:To:Cc:From:Date:From;
	b=N6Cj7R93CmZ9RZarZ2Ke8VPR24T5tu+UEQRecd39NG77mTftFEqvsEefA5uonGVmM
	 kIMEtOqhHzxTW6z1tQ1+GRzQma+R5weAIpV5IlgYKU3jheTUqa48mwREMPCu5A3wzj
	 F1ksOXgrfeFqZ6fvHRHUX777d3JauUO3SR8lpKyY=
Subject: FAILED: patch "[PATCH] io_uring/zcrx: clear RQ headers on init" failed to apply to 6.18-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 01 May 2026 13:35:56 +0200
Message-ID: <2026050156-bungee-quarters-ab9c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5C3BB4AC141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242339-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,gregkh:email,kernel.dk:email,linuxfoundation.org:dkim]


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 4f02cc4071a18c78bfff571d796edef055d57daa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050156-bungee-quarters-ab9c@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f02cc4071a18c78bfff571d796edef055d57daa Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Tue, 21 Apr 2026 09:46:44 +0100
Subject: [PATCH] io_uring/zcrx: clear RQ headers on init

It might be unexpected to users if the RQ head/tail after a ring
creation are not zeroed, fix that.

Cc: stable@vger.kernel.org
Fixes: 6f377873cb239 ("io_uring/zcrx: add interface queue and refill queue")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://patch.msgid.link/331f94663c3e8f021ffa3cb770ca2844a07d4855.1776760911.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index fab3693ecb0d..2eb09219f0a0 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -396,6 +396,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 	ifq->rq.ring = (struct io_uring *)ptr;
 	ifq->rq.rqes = (struct io_uring_zcrx_rqe *)(ptr + off);
 
+	memset(ifq->rq.ring, 0, sizeof(*ifq->rq.ring));
 	return 0;
 }
 


