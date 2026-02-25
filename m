Return-Path: <stable+bounces-218862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Wr1FBnFXnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:59:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 325BD190531
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 797B23088FA2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD5C285CA3;
	Wed, 25 Feb 2026 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gIKKSAqS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2C52652B7;
	Wed, 25 Feb 2026 01:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983746; cv=none; b=i2Gnifatf6j3bn+U/ya/nlAf6gHKzCIxSU/NHOO6Mm/OA5QGp5w985oid0vrl/hss49wQCM0brySbCht16eLPKAqISp2aMrIITAESvFIpKEakH8Z2rkcvbwXI2n18nH9yf5etdbQ88VEHUBL2hRkorMsnOPCMsIZdWqK0uBogAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983746; c=relaxed/simple;
	bh=k7U0AOOy/QPMa31dF7dsLMgn66JWIFiEBO7k3FQgYRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n19WIPscBld1kagFt51+tJVBjgEQVcSxtVdEdC9PuxT8noD/9YTJqQEvPyerbYiMHIHjV7AKZiXJTfjvtq9D9oo+ChIBgZwFD6rbwR8ed+9NyPKdG0w/6s0kJMk8CN3rRO9SJiyZRIhvfVporOXBceqjURlZXrlr8+p13gwX/nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gIKKSAqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53931C116D0;
	Wed, 25 Feb 2026 01:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983746;
	bh=k7U0AOOy/QPMa31dF7dsLMgn66JWIFiEBO7k3FQgYRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gIKKSAqSX2XUfvZFdoMXf59cChrkJTsKFKrepUbh9Ey3TLUsRw455Pn5sB8LgCzck
	 KXHWZxtv1L6jaQV4Ki89SSdfwK3SilNuKKn8QG/pH175U2fSfC5GPgdZAva4rmLvkI
	 DKGmeSfuL+1UBpzHhb5i2+LsssgUq6ge+dyGor2I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 039/641] io_uring/eventfd: remove unused ctx->evfd_last_cq_tail member
Date: Tue, 24 Feb 2026 17:16:05 -0800
Message-ID: <20260225012349.969272135@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218862-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: 325BD190531
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 07f3c3a1cd56c2048a92dad0c11f15e4ac3888c1 ]

A previous commit got rid of any use of this member, but forgot to
remove it. Kill it.

Fixes: f4bb2f65bb81 ("io_uring/eventfd: move ctx->evfd_last_cq_tail into io_ev_fd")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/io_uring_types.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index c2ea6280901dc..b4d8aca3e7860 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -439,6 +439,9 @@ struct io_ring_ctx {
 	struct list_head		defer_list;
 	unsigned			nr_drained;
 
+	/* protected by ->completion_lock */
+	unsigned			nr_req_allocated;
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	struct list_head	napi_list;	/* track busy poll napi_id */
 	spinlock_t		napi_lock;	/* napi_list lock */
@@ -451,10 +454,6 @@ struct io_ring_ctx {
 	DECLARE_HASHTABLE(napi_ht, 4);
 #endif
 
-	/* protected by ->completion_lock */
-	unsigned			evfd_last_cq_tail;
-	unsigned			nr_req_allocated;
-
 	/*
 	 * Protection for resize vs mmap races - both the mmap and resize
 	 * side will need to grab this lock, to prevent either side from
-- 
2.51.0




