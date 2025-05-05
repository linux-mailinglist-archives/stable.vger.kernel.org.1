Return-Path: <stable+bounces-140472-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA8AAA92B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8A0188C3E6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1176A359E07;
	Mon,  5 May 2025 22:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jHPzZqd8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A443589F6;
	Mon,  5 May 2025 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484941; cv=none; b=uq1mr6Qcbzf2Xp8p++VmOYJzVtjJc4ffjJpAlTNtJYnb9VClvlOBLdvJqNCOtbOfoGKuaS35nSXSGlyHgzCkf4j2xkqdDsovBQVMncLtrI1JV23qxWDNaPmBYkK6LxX9h0/ckFNQFQrg1bmayO63amu4PQNVmRLV0MFXWhAJfCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484941; c=relaxed/simple;
	bh=wXNdFLzonYINIu4i6qQfk8fufoFk6RwZOIDwJfLI4DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O4LX0s7t858pxIAisjbfFBrdfId0AOMtmWl9jOTIPr7IaNhvJbu227eqUZQnKf/jnnMsc/duUaYm/Ne/+f9TW9y3fI/WLOo+OhdUhnJEp+x/PnzjmRu0j5d+NRQQsFwiExKIv5J3q9QkBmZHcYoeQBwdVMwUBHQNq9NFZBe8j7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jHPzZqd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760DDC4CEE4;
	Mon,  5 May 2025 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484941;
	bh=wXNdFLzonYINIu4i6qQfk8fufoFk6RwZOIDwJfLI4DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jHPzZqd80A44wJQoSZCv7ta7TxPE1xpDSNKw+TCGJhG2+080g7OmDdiAiaFdiGJtq
	 0a0ky0j/kvo8sc4LAGDr+bB3E8PmKOWIvsTATWthdCppwXiHt+iMabaMWIAqL6Kmw4
	 xNtaiG+me7NZmd09GTH1kkRaPUv8k5C0dHQ4QUNf3ENHzlIty+WTrhSJRSR+OJdnRR
	 0NH2t3TaxkV8+PGA8aU+KEyVd9WC/C9qKJFJlA6rpwgYG0BIHtIcy0bATFsD7xoaJp
	 z1Fvkxr4JrgCfUQHHZdmJ9cGhxXi8i62ijQdYyZY4u+b4Q2tNNGzG9AsqXX5JsRv+n
	 u4B+wUlOpCzYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heming Zhao <heming.zhao@suse.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 087/486] dlm: make tcp still work in multi-link env
Date: Mon,  5 May 2025 18:32:43 -0400
Message-Id: <20250505223922.2682012-87-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Heming Zhao <heming.zhao@suse.com>

[ Upstream commit 03d2b62208a336a3bb984b9465ef6d89a046ea22 ]

This patch bypasses multi-link errors in TCP mode, allowing dlm
to operate on the first tcp link.

Signed-off-by: Heming Zhao <heming.zhao@suse.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/lowcomms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lowcomms.c b/fs/dlm/lowcomms.c
index f2d88a3581695..10461451185e8 100644
--- a/fs/dlm/lowcomms.c
+++ b/fs/dlm/lowcomms.c
@@ -1826,8 +1826,8 @@ static int dlm_tcp_listen_validate(void)
 {
 	/* We don't support multi-homed hosts */
 	if (dlm_local_count > 1) {
-		log_print("TCP protocol can't handle multi-homed hosts, try SCTP");
-		return -EINVAL;
+		log_print("Detect multi-homed hosts but use only the first IP address.");
+		log_print("Try SCTP, if you want to enable multi-link.");
 	}
 
 	return 0;
-- 
2.39.5


