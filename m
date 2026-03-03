Return-Path: <stable+bounces-222932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCY4GOExp2kjfwAAu9opvQ
	(envelope-from <stable+bounces-222932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:09:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B81191F5AB8
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25A94319143F
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ACE3B5825;
	Tue,  3 Mar 2026 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tiu0oRni"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CDD39479E
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564694; cv=none; b=ux78N1UWyD7IKbNOZDjuAZqLtTPHcphIgf9OgUUlQCkbOMUU5XJ/ad/IbCub6XsQDG14OqcEo4wshbS2bx2Kc6R8uD55FMbqlSzE+wtcl9SycBF6SN9PQ6uDeCsL0V71yojrlhuhVsap6ofeaG/dPWZ308q4vcgij8x8dbiULcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564694; c=relaxed/simple;
	bh=4Ms8HD/6XgvKYZKrwR+AL/ik5bN//WiIN/+BzYznhI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeUauRewWWS/0g6pwnF7k44o24fN4KQ3klcUo6mneHiBp42UEydyokqRuFk6Kd/12MLZ4Sf/aMLRLQ26lRPtZUSpA9Qc3fwe5hSrZQjBCzK3Tz1KdAv/r2MUv2UI/eW08xJ6LHll8E9ASQm0N/sU1N1O0fBXQpj/4OrOhaVwLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tiu0oRni; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772564691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=opdxGJM13ZFy1KCnDwkudhw7lgp4YhVPho/P8SgqAqE=;
	b=Tiu0oRniwgyKa27X9c8I5pMzcniRKdYo9/3j//kRwN4ghRreWQSAgJqfk8y+5K5DFAtaAN
	xFQIdk5CuLxStdWGDByWg8KhxW1OVUvlG+I4KeUApAjbOj000E5KQoylaVy3nzyTRqZwp9
	Z9lMGxpiL0EJdifpTZm9/qVsNXo0vG8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nvmet-auth: Don't log DHCHAP shared secret in nvmet_auth_ctrl_sesskey()
Date: Tue,  3 Mar 2026 20:03:52 +0100
Message-ID: <20260303190350.78705-6-thorsten.blum@linux.dev>
In-Reply-To: <20260303190350.78705-2-thorsten.blum@linux.dev>
References: <20260303190350.78705-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B81191F5AB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222932-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When debug logging is enabled, nvmet_auth_ctrl_sesskey() logs the DHCHAP
shared secret. Remove the log to avoid exposing key material.

Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/nvme/target/auth.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index f24add0bb86f..f62fed6bd897 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -544,10 +544,6 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 					  req->sq->dhchap_skey_len);
 	if (ret)
 		pr_debug("failed to compute shared secret, err %d\n", ret);
-	else
-		pr_debug("%s: shared secret %*ph\n", __func__,
-			 (int)req->sq->dhchap_skey_len,
-			 req->sq->dhchap_skey);
 
 	return ret;
 }
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


