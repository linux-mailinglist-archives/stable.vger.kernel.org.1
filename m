Return-Path: <stable+bounces-220126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +F6vEtEpo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E00B01C5150
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C04B630AE6B2
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A834C155;
	Sat, 28 Feb 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgfCQbkF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC3434C128;
	Sat, 28 Feb 2026 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300036; cv=none; b=I6YxlbVjOj0wgJuoABV59KxTh+MZMEagdstxbUQrzF8VgGIG6cRnY2P0yuvlKiabLmJzpfltOH9a4de85HWQvUAUDeH0s+Ht2kRU0Qt1LfTHXM0tLzhxK45nxdNglOx5WjCnq6dzehdECXTWEYR4IP7ikrxk0gosUhy3UTXt9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300036; c=relaxed/simple;
	bh=qFxe7UMVks0SzFECFu0TKvPZLn9NTWwEwRkXjs1MK28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fj/JjEdKRAZD+7aOBWY7G+vRMsU3AKz4DAJApTQnb1NSDMhFtFle1eO76UnLmJq0qbQywn04gxbZ7zsjOdVtsqnl6/QwlsBV30kGvG9kt4RiQsmPZs41c9TGiKm3qEb6heZyR4n5LMNiTCK6JnW4TGVgHPqCCtED89Ct6H3v/3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgfCQbkF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EC6C116D0;
	Sat, 28 Feb 2026 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300036;
	bh=qFxe7UMVks0SzFECFu0TKvPZLn9NTWwEwRkXjs1MK28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgfCQbkFIveFgOG5kcSRWNONWA5k8VtyfEoCk+Lk1TXuxbN93WlBsr1ilIXz4xklT
	 9p1R1uqeYRjDe2cMu8FPoWbjRDKP1RncUSBYeIbfd4QsjZrslryoeoBEm8y7JTY28v
	 buiSIZQUIuuQJE7H1QMHRm+yWRV9pGLZTk501fGsKSgbKVlcwuV+Iihvg4z+eoXyAg
	 ErJFERHs2apVNXOHv218cr1McwRslSrKsL1ce0pX/PKB0ZlJNG7VCUqUxa+Xy1gGxe
	 j2uER0kpiRZgBzzwYcIY3HaliiwllDvektK+PXt0nnzdthMZIcxYvlJpaKuzUjRLzH
	 1QCFo431os46g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ezrak1e <ezrakiez@gmail.com>,
	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 048/844] dlm: validate length in dlm_search_rsb_tree
Date: Sat, 28 Feb 2026 12:19:21 -0500
Message-ID: <20260228173244.1509663-49-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220126-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E00B01C5150
X-Rspamd-Action: no action

From: Ezrak1e <ezrakiez@gmail.com>

[ Upstream commit 080e5563f878c64e697b89e7439d730d0daad882 ]

The len parameter in dlm_dump_rsb_name() is not validated and comes
from network messages. When it exceeds DLM_RESNAME_MAXLEN, it can
cause out-of-bounds write in dlm_search_rsb_tree().

Add length validation to prevent potential buffer overflow.

Signed-off-by: Ezrak1e <ezrakiez@gmail.com>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c01a291db401b..a393ecaf3442a 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -626,7 +626,8 @@ int dlm_search_rsb_tree(struct rhashtable *rhash, const void *name, int len,
 			struct dlm_rsb **r_ret)
 {
 	char key[DLM_RESNAME_MAXLEN] = {};
-
+	if (len > DLM_RESNAME_MAXLEN)
+		return -EINVAL;
 	memcpy(key, name, len);
 	*r_ret = rhashtable_lookup_fast(rhash, &key, dlm_rhash_rsb_params);
 	if (*r_ret)
-- 
2.51.0


