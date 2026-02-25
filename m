Return-Path: <stable+bounces-218081-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM7uGnVQnmmNUgQAu9opvQ
	(envelope-from <stable+bounces-218081-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D86E918EBF0
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD2433051592
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9FD251795;
	Wed, 25 Feb 2026 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pz7s95fD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3224A06D;
	Wed, 25 Feb 2026 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982854; cv=none; b=M8ul+J4/St/AdL8yrq6b4LY5S9vEjMId27qGRe76VTupjDaXaxq1AVtXX673BVBT42azw0w2FDy4oUJYG+ywDX6gWx0TksLcNwy1xkpAHKhJ+tIU9Z7NBnf563PVTpfcaEVO25b/Nq6B5NsfFDTwr8LcTGPwU9FBwvGDp2haTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982854; c=relaxed/simple;
	bh=HOJ1ke+mbnTsfjSUH80Ots1o/KEm7ZPRqzo3WctfT9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sq5qp2fb+dVIkXPcshBOxUwXwt7kffswUfeH0vBSkcVj5jHrzD1+FkUVVho++jePyNoH1G2BF/zwt5yO09G11u9Cses2TBTmoj+/yXT1VH7hcMZEXKHFr56S8EDmtSpDpdU1YDhT7PchAvw8mbaXpUGTigZ2K5YBtSpXU3MWMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pz7s95fD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01C8C19423;
	Wed, 25 Feb 2026 01:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982854;
	bh=HOJ1ke+mbnTsfjSUH80Ots1o/KEm7ZPRqzo3WctfT9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pz7s95fD9gSQJvdCwurxQDYQhSnbbOGB/MGGDmQVPGCpEooxqC9W3Ju7qO0pwlR1z
	 vnTA/d+X1mqxmsZPAFMTxXLa8HgiQPjNx0wK1ExBpkCIYa3jNffNLpMM6pqL8PTz3S
	 +DGmrKb15ykiixromsPj9VkExYBSnjWrBg4Buk70=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 043/781] io_uring/sync: validate passed in offset
Date: Tue, 24 Feb 2026 17:12:32 -0800
Message-ID: <20260225012400.760850872@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218081-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D86E918EBF0
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 649dd18f559891bdafc5532d737c7dfb56060a6d ]

Check if the passed in offset is negative once cast to sync->off. This
ensures that -EINVAL is returned for that case, like it would be for
sync_file_range(2).

Fixes: c992fe2925d7 ("io_uring: add fsync support")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/sync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/io_uring/sync.c b/io_uring/sync.c
index cea2d381ffd2a..ab7fa1cd7dd63 100644
--- a/io_uring/sync.c
+++ b/io_uring/sync.c
@@ -62,6 +62,8 @@ int io_fsync_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EINVAL;
 
 	sync->off = READ_ONCE(sqe->off);
+	if (sync->off < 0)
+		return -EINVAL;
 	sync->len = READ_ONCE(sqe->len);
 	req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
-- 
2.51.0




