Return-Path: <stable+bounces-223918-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mONMAN79r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223918-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7393A24A520
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12FA8304FA66
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBCB38423F;
	Tue, 10 Mar 2026 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJ0f4Dto"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF62D978B;
	Tue, 10 Mar 2026 11:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141054; cv=none; b=kU/TEWk/KuGsBCWBke5znJep8r4KoBi4kW3eGWgUiAfF6urRhq4ivRxGs42ITaA66MWPwrboLbMYiK9xg4zDH6dXlYTtGmHOS82aVzqCgy/h8oCLzI/VHkDraMcdR46xgPMd+vQ75iMR12CPSNBPc64d8mz9yy85/faEsl1AfG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141054; c=relaxed/simple;
	bh=yZ4LolPGDrGt2PS/75qDDPXFJHtVNQRXtgi+I43FtNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIBP+CCHYJu9tKzLSFfi9uTz1zCciH6v6ikQkuJkX9CEOs1wj13ED7xuIXoPxqE3rXtG2F9kfHGWXil5TKkCVRPcmc+1r4jll0vUsi+RgwSt6gbHmPKBuKh7C5biwh90F59if1cwkCiv8MFAP1+dKgWYu9J5q903T2Rr5uST3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJ0f4Dto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65FDC2BCAF;
	Tue, 10 Mar 2026 11:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141054;
	bh=yZ4LolPGDrGt2PS/75qDDPXFJHtVNQRXtgi+I43FtNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GJ0f4DtoTl7EeivTBwu0VLTFErARX5Yxg9EBf8e+85DpodOxCcGS+qELFxb7+/za5
	 u2nxUv5vKMuiDIASbr8gmhejwHokPUiPF9VO/No6uVPZElO0SDx/zGQv0LuoUXv7xY
	 64usdvjpSKmeyZS6LkgmaKzzi/XnTfjWBHyJgr86JwR8MnsCDDvmeaD7zJSzu0EsA4
	 OeaT9egVt7ihvfDgFNtQq8i9jkqK6QNWlD/zkPeUAWbrDnICSYw9VwpNv34giWB+wP
	 6w+iH8t+5n+8FXnwWS38e+ea1cKhD7MNdyrp31hw/9oT/jUMcbm9s9DgJSQca3dd4g
	 +HUzoJiUSRpsg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 053/311] io_uring/cmd_net: use READ_ONCE() for ->addr3 read
Date: Tue, 10 Mar 2026 07:01:40 -0400
Message-ID: <098869323522cb30fd476082953c8a50921f588d.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7393A24A520
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223918-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kernel.dk:email]
X-Rspamd-Action: no action

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit a46435537a844d0f7b4b620baf962cad136422de ]

Any SQE read should use READ_ONCE(), to ensure the result is read once
and only once. Doesn't really matter for this case, but it's better to
keep these 100% consistent and always use READ_ONCE() for the prep side
of SQE handling.

Fixes: 5d24321e4c15 ("io_uring: Introduce getsockname io_uring cmd")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 io_uring/cmd_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/cmd_net.c b/io_uring/cmd_net.c
index 3db34e2d22ee5..17d499f68fe6d 100644
--- a/io_uring/cmd_net.c
+++ b/io_uring/cmd_net.c
@@ -145,7 +145,7 @@ static int io_uring_cmd_getsockname(struct socket *sock,
 		return -EINVAL;
 
 	uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
-	ulen = u64_to_user_ptr(sqe->addr3);
+	ulen = u64_to_user_ptr(READ_ONCE(sqe->addr3));
 	peer = READ_ONCE(sqe->optlen);
 	if (peer > 1)
 		return -EINVAL;
-- 
2.51.0


