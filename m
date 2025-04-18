Return-Path: <stable+bounces-134641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC1EA93C64
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 19:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BB88E446C
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0216421D3CA;
	Fri, 18 Apr 2025 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wqUmGP+G"
X-Original-To: stable@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A79A21CC4D
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998864; cv=none; b=E+P14mc3PKPJOgYJlOmPZJn08u8SRXLNI25xAyfw78w20qJzAv/zwUX4q1dtyYy1AShxGMws2fScQVYXlHncJdIPc4uQ88TE+nMDHCjLUltjxHj7tGI6Y1cko24grvE+brx0HtHGWnzl7xF2na9z6Sc6E8K1Tsh6s+V3ibMRPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998864; c=relaxed/simple;
	bh=/bzp5mfsVmbl1XdrrJCam+sFaW1g7tBsRojjbHpigiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uvW/vYeqypuI4BQE60sTolr48ctAJTsvxotR27S5yKpocBH/CIJxZsjNce9n2HDPoOFPxZADoOUgFL7ZMpfCyEgMsrUKEV8/UgV+O02umyL6zke/qt/U1XTcqwrSmsN+3nbMNY2+IcRskr61Knycxe2NXVcONQhPpTEfH1VhPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wqUmGP+G; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZfMpP6Dr6zlxW5M;
	Fri, 18 Apr 2025 17:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1744998860; x=1747590861; bh=vig5p
	2vmfejLGp13/fJTZPaJT/1cWoyDyAw30Mj4M5M=; b=wqUmGP+G61h9InVAilCyh
	z6vnFaE0/N9RjexROZ2MS/aL15HhvsVgMTQyhR0UYdqlAXXYPENpzWVdsHPqjt3E
	bx8Vz6wMtSnPMrELCrtMz17tpVXU4a+E20D7dEhV6KXVrCgBla3Yv8g9KJ3DjWcb
	Gdlbqd9q/nKvnTRMlvEx9nS6wYlaLGcTrgDPNNsyEqiQHGF28O7CWUoS/EMoq2jI
	WprxsEqWayaniZ28bSW8XZC7B3G5QdNj2sCMrhs/3k9mVDD+Gz4wD5TPCLmkVQJl
	8jOWZKPUKMh0mqfzC6yR6ZwJVxTBOY04SIayOtipHCV1iGDSBP0gvGQ3V8QcugW6
	Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id x3IV9zBsvV_c; Fri, 18 Apr 2025 17:54:20 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZfMpG3sg8zlvkSx;
	Fri, 18 Apr 2025 17:54:13 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] block: remove rq_list_move
Date: Fri, 18 Apr 2025 10:53:59 -0700
Message-ID: <20250418175401.1936152-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250418175401.1936152-1-bvanassche@acm.org>
References: <20250418175401.1936152-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Christoph Hellwig <hch@lst.de>

Upstream commit e8225ab15006fbcdb14cef426a0a54475292fbbc.

Unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20241113152050.157179-4-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blk-mq.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 7b5e5388c380..cd04e71ecb88 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -269,23 +269,6 @@ static inline unsigned short req_get_ioprio(struct r=
equest *req)
 #define rq_list_next(rq)	(rq)->rq_next
 #define rq_list_empty(list)	((list) =3D=3D (struct request *) NULL)
=20
-/**
- * rq_list_move() - move a struct request from one list to another
- * @src: The source list @rq is currently in
- * @dst: The destination list that @rq will be appended to
- * @rq: The request to move
- * @prev: The request preceding @rq in @src (NULL if @rq is the head)
- */
-static inline void rq_list_move(struct request **src, struct request **d=
st,
-				struct request *rq, struct request *prev)
-{
-	if (prev)
-		prev->rq_next =3D rq->rq_next;
-	else
-		*src =3D rq->rq_next;
-	rq_list_add(dst, rq);
-}
-
 /**
  * enum blk_eh_timer_return - How the timeout handler should proceed
  * @BLK_EH_DONE: The block driver completed the command or will complete=
 it at

