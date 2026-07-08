Return-Path: <stable+bounces-272672-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sooTDpJwTmoUMwIAu9opvQ
	(envelope-from <stable+bounces-272672-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 17:45:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957F728352
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 17:45:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Rs6Jod4N;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272672-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272672-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EA5A30FCBA6
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC093B47FD;
	Wed,  8 Jul 2026 15:21:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A233E360
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 15:21:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524073; cv=none; b=LQ7fTx1+54Uck0oW//Feaj5nxKJ1wwmeoUtUPPgoNQCgKlYRhaImjpB8WLY8cWHkG2i3bWArXvG0CKhUpo5K6KRp2CkU4gVK1cGa0LhtEXGuaz9Agz9c4SagiSW0L/a5wzGrkc3eER6kXyyCIcp6Ba+BlMzcAbwiOxNfTpLIhN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524073; c=relaxed/simple;
	bh=WKBcHTgaZtpNkKKi2sgsqXtCohviIlzQuMwKPXfIX68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITUdVb+O21bwS/Cjd5YI5sTU1dWv76PxUCvevU5Viw/hPS3fOAIay60wV+44e1cQGQU9OMDGAGtHl6N/sblJuaYGedMPE7DN8u3cDnONjHPG4WkkBHtJYkiPx3qq2qfw8/2xnPuHzSXyRt59Fa+HJJEeqzFSa/HABP+PMIMuZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rs6Jod4N; arc=none smtp.client-ip=209.85.214.182
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ca70925c25so11532395ad.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783524072; x=1784128872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o36UxtuiqCAJdwEuwaBvvEJ+v2c/EEKhjYP437s9xVk=;
        b=Rs6Jod4Nzyh0EzlLOlKQs5kTJRy8RbX1dbYtradlIQFb3sOtyCSyjN2sFkn1IHY/Ao
         s3QnJLd/AaZHCL5tP+hVTpANuirRM+/lUl7BEkHr8POFqPL9EZqFcascOmcSmmC+Ozs5
         CAU7dNym0BIwFO/JvQ9F1m+sOOq+uvY9/GiJWHfVANxxKy0Cjj3I9JL35Ps/eh8dV+dl
         ffW3ySGLUW9RYgcqy/WmJzPcqe8CCNF5g+LwwU72CNhwBZTaHnGAp2StfzcZZ7D+LSJi
         ub2N89lRrz0hMfEVyHVjDrC9et8pzjrPhnSDdZIZNjuMnFXM/CaUyhal/osJjMCQ89os
         3ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783524072; x=1784128872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o36UxtuiqCAJdwEuwaBvvEJ+v2c/EEKhjYP437s9xVk=;
        b=O/ejee+iTJXqXPiEwiLcxKOr4E9nkroV78NgMQCVyTFcf9ttkAEztLrCbJGQmycMx1
         9OUC+oys9TNy+IczY5h8oBoDwxQvdKODqfur25t+J7TB/sAmwIP2mpzGXc7e96Uzn5EK
         Y5R1gTNzEbA339qWU7K956m1JFHyUtsxC1tTda3Vk+4GJTx/qFuPDVE092e6aW1L9IkK
         zkrlW7igPghwSlRpk0voCq/iHEdewhQvqPl7c6TlOijPt/dgt8QnGfnkeBlHmRXVurOr
         Bbg/dBJ57V5Cdg7YaQGpiUzZO5BCH9T/knn46TD5hbHVnjdHYXqxMwD94MAy2mtqRmax
         ZW4g==
X-Forwarded-Encrypted: i=1; AHgh+RoY/zg92r2eOmmLDCqewFeq1svN3fk1dtQQ4XSQ8fRm/KC+BU1PeQ9C3hSJ0Ydu07nW8x1rOLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaDCKyQDfXKrN0Fqqsyg9HggGhdk8spq4WRR7GyrotJWFZ4JWw
	BkhgcWNHGPgcTEeswCXmwDDK7Py1+OlfxSeZqC8lS5iteo7enN7GCL6r
X-Gm-Gg: AfdE7cl9vJFizrrWJvQGCpDBTgtsL7SqIF3gN2A3HstrMBynpNZYX7c1JlTtc6uP2Cv
	QjdCVEurg0bBqNbqv+c9ai0CeunsE4jScV0I+v8+DXZlvAFX5V3uKvbnG1pgdQRqYI5wOUKF3oX
	lhu7Pq0JZi4mIg5LCu06QHvm1y5GjK+NhebT+Wb+ZKzkPcJ+kwvNKTxBftwSwQ14EOHMaOF8bAo
	p8zGjawIYk92RMZAXyvZSl+2MCkPHMcKa8eWtxG0oR2WopKZkTGEyvN5TtRu04vXBKi+XXZDa2M
	14kl23DjvY+HD/BeG0baD3N29W8vOyvcp5knX/+/NpZl7PRjRjF4ShlJwi24/bjFGkKdqXqAAxZ
	Urf1fVnCQDo/Cgl9r/ncnNCCGrd534VxwMtP5SWLMzGBIa568ny/6/wCxLXZKXlP/y/eAZdpTxk
	BC6pp8o2If6n7GHDRZ6PFm13k3fcSqu7/oW4uGHtuNWXQ=
X-Received: by 2002:a05:6a21:62c6:b0:3bf:6237:b1b3 with SMTP id adf61e73a8af0-3c0bd1a827fmr3540218637.42.1783524071668;
        Wed, 08 Jul 2026 08:21:11 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6596681fsm24544817c88.8.2026.07.08.08.21.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 08:21:10 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: v4l2-core: Fix memory leak in v4l2_fwnode_parse_link
Date: Wed,  8 Jul 2026 20:50:54 +0530
Message-ID: <20260708152103.49371-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272672-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sakari.ailus@linux.intel.com,m:mchehab@kernel.org,m:linux-media@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:birenpandya@gmail.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[birenpandya@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[birenpandya@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9957F728352

In v4l2_fwnode_parse_link(), the remote endpoint fwnode reference is
acquired using fwnode_graph_get_remote_endpoint(). This reference is
properly released in the error paths, but it is leaked on the success
path. Add the missing fwnode_handle_put() before returning 0 to prevent
the reference leak.

Fixes: ca50c197bd96 ("[media] v4l: fwnode: Support generic fwnode for parsing standardised properties")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 77f3298821b5c..93ef83c591ef2 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -633,6 +633,7 @@ int v4l2_fwnode_parse_link(struct fwnode_handle *fwnode,
 	if (!link->remote_node)
 		goto err_put_remote_endpoint;
 
+	fwnode_handle_put(fwnode);
 	return 0;
 
 err_put_remote_endpoint:
-- 
2.50.1 (Apple Git-155)


