Return-Path: <stable+bounces-226758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AZGLTyTuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:45:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C512B016B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 211BA304A4B6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79E30C63B;
	Tue, 17 Mar 2026 17:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lBixH7Cj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27D82D73B8;
	Tue, 17 Mar 2026 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768080; cv=none; b=Y1gxt9BBC5Q8MFfmn0S4lSkGBzYE3AH1y3i3xX75zwe7Wbh3J/7XluIgEXUiUoUZ5Oo0Q482OPi2uS1SeiKjbpDVtquitI/lLUemo+kl46y3DjDuzULk6AxFhTppzpENSk7XK2iaFj6itZcwLFq1joIGK3RMF8b242yxOkgZC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768080; c=relaxed/simple;
	bh=ojfCWOaxbD5V5y4gIJ97OGfAJQPyUTyOsXskVa5wwL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alCDnNhB/+kUmqPMpq/GKSqgs8KVtzfyqtk9qHX6Ip0q7JLblAxv8LEzW7HArjjDGO8ylClJF9bFQrXmNZ37XAHZAPipDFbEnjl4h1oV1gDxOqiBpb2ChpauagYWI4YJ6Yq6PrcFayr0NtmJnJvo5KSwHPD2E2zLbLdVp+ba/u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lBixH7Cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6043CC4CEF7;
	Tue, 17 Mar 2026 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768079;
	bh=ojfCWOaxbD5V5y4gIJ97OGfAJQPyUTyOsXskVa5wwL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBixH7CjHtd9IzI3bgzcULlfc1LDx2PHoqtAORrz6zu4w3r6nsMKi26J1w/420OUa
	 DzT3zvmEJN7kA7yUMM1fT1X75/qDCrIT7hZoBDeHNGY1IPXIrHGrWkF5oV35S5dWMG
	 Gfphg6o/yN8hScCxqL9NFEKKD9uWFydfhzw4thto=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18 227/333] io_uring/zcrx: use READ_ONCE with user shared RQEs
Date: Tue, 17 Mar 2026 17:34:16 +0100
Message-ID: <20260317163007.782978784@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-226758-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: C1C512B016B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

commit 531bb98a030cc1073bd7ed9a502c0a3a781e92ee upstream.

Refill queue entries are shared with the user space, use READ_ONCE when
reading them.

Fixes: 34a3e60821ab9 ("io_uring/zcrx: implement zerocopy receive pp memory provider");
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/zcrx.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -767,11 +767,12 @@ static inline bool io_parse_rqe(struct i
 				struct io_zcrx_ifq *ifq,
 				struct net_iov **ret_niov)
 {
+	__u64 off = READ_ONCE(rqe->off);
 	unsigned niov_idx, area_idx;
 	struct io_zcrx_area *area;
 
-	area_idx = rqe->off >> IORING_ZCRX_AREA_SHIFT;
-	niov_idx = (rqe->off & ~IORING_ZCRX_AREA_MASK) >> ifq->niov_shift;
+	area_idx = off >> IORING_ZCRX_AREA_SHIFT;
+	niov_idx = (off & ~IORING_ZCRX_AREA_MASK) >> ifq->niov_shift;
 
 	if (unlikely(rqe->__pad || area_idx))
 		return false;



