Return-Path: <stable+bounces-226439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHHNJeCOuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E816B2AF90C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5184A3123DC6
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B5C3F99CA;
	Tue, 17 Mar 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ioPjJEeQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F23F54CD;
	Tue, 17 Mar 2026 16:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766718; cv=none; b=Pm1RqLSX2+7Mo3bhT7667oQ2cLaS7a3uGaj8s0LGjTyCclqqfyfWyDDhA6sdnZpBA8/IKbdzDaLz9sgUpTA3fgOvPlneEPTfp84VYsBmcDaOa5hasTci9HizVObYq02AuByxVM136/KxbQO6uf9cd5YYeNxJRPqity8QCMapCiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766718; c=relaxed/simple;
	bh=yn46xAo5/YVb9aSQMbDY/jAseZjyBBN4VnPlPgriwpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/9ritrXTjMbcDhrDffOEyyj2UtRrviKAXdnTGn4LEokob2hF5YMDa0I9L/Icf/wIrEa3YUfAnMfhPFw2auGATzT0kYgZMvLidbRZxshLuWHlrcKoMusSVkVJvBafi1Tzf1vQg8UbA77E4NGUkQIEgJPhSPBzJVSXa7aOJAgDPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ioPjJEeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E92C19424;
	Tue, 17 Mar 2026 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766718;
	bh=yn46xAo5/YVb9aSQMbDY/jAseZjyBBN4VnPlPgriwpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ioPjJEeQEFrGFegFTun2dqMEDwpl7v3OgnWG7CEEmBJrBxJH80eOBu81PfDmz3AKy
	 pvs/CTepO8Hhvea+Ni45FkW4bGKclY5WZ+SoDAakYsVIX48WC/BsGK6HIXtnoHy+bS
	 lQvsqThxq12mOCnUdFiXBuaqLOxjMma1KQyfIWjU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.19 274/378] io_uring/zcrx: use READ_ONCE with user shared RQEs
Date: Tue, 17 Mar 2026 17:33:51 +0100
Message-ID: <20260317163017.088470256@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-226439-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E816B2AF90C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -898,11 +898,12 @@ static inline bool io_parse_rqe(struct i
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



