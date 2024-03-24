Return-Path: <stable+bounces-31224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C728893E0
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 08:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6F31F2B829
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 07:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AC6155A37;
	Mon, 25 Mar 2024 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9W8QL0i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5898D1272DE;
	Sun, 24 Mar 2024 22:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320766; cv=none; b=QcDUL7vrssCVXJusZFKAMJjgm+x3QCnlc+8hLKoEerP5AG+a8JwGHVP3kXa3fsAtHAQY8Mk0VkoOiD1SW+ODbF2qt066nlpXxc7xhfVOFjp2T22umPRgGeDMRpHKEVaP8jA2HsmUt0MmdGgYW7TxGv6Hg45TjoyVDcEWOzGK+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320766; c=relaxed/simple;
	bh=0ZbiRjqbqQPMs4lhJ5vHIlkejiYFnKo63dXZozmQ290=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/tNO2TlMcN1pls49Wz64Bj5+BeOplExEquvjsv7pNUtlq9nfaEST/YKnj3Qu6+UsSz3Hq9IOcp8o+dHcc0zdbrgmexCmXtKp7/SX0YEJaz/dRIKK5sH9A3VfpVYmkmD0Ok16xqIRmI2I7NRXnFWBhPDSxBuN63jW7xt7k3vONM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9W8QL0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F474C43394;
	Sun, 24 Mar 2024 22:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320765;
	bh=0ZbiRjqbqQPMs4lhJ5vHIlkejiYFnKo63dXZozmQ290=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9W8QL0inziEMLnsyaP3lNea/VYnYNAB2e3Eujj/i2UrDn32VnaoStLagSShKU3UE
	 SiUxL8WQZ4yOFrJxZXIiWSg7lzLqj7kSLafZdQdooxfC2ZLSJmv+wshIzbJzDS39le
	 XVBJDgaNMXJNWuFo8ppJK9jDNznwBKR+GoaHVih0PadgIdUeHpp5k1Cb4rCoyJu5HE
	 4FpziHfz8rK58ZnbG24Gqd/eZV4+F9ah7fpWmp3xa67ajfdEzZmptuEFEn+JIlpPRW
	 /40AoNnWarzm/BAXn/JosT6zeS3QGkU5M/qH5ooy4GY5L+Xi+zoEYSocPjOYgYUbys
	 1ht2XBoQMuHMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhipeng Lu <alexious@zju.edu.cn>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 329/713] SUNRPC: fix a memleak in gss_import_v2_context
Date: Sun, 24 Mar 2024 18:40:55 -0400
Message-ID: <20240324224720.1345309-330-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Zhipeng Lu <alexious@zju.edu.cn>

[ Upstream commit e67b652d8e8591d3b1e569dbcdfcee15993e91fa ]

The ctx->mech_used.data allocated by kmemdup is not freed in neither
gss_import_v2_context nor it only caller gss_krb5_import_sec_context,
which frees ctx on error.

Thus, this patch reform the last call of gss_import_v2_context to the
gss_krb5_import_ctx_v2, preventing the memleak while keepping the return
formation.

Fixes: 47d848077629 ("gss_krb5: handle new context format from gssd")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index e31cfdf7eadcb..f6fc80e1d658b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -398,6 +398,7 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	u64 seq_send64;
 	int keylen;
 	u32 time32;
+	int ret;
 
 	p = simple_get_bytes(p, end, &ctx->flags, sizeof(ctx->flags));
 	if (IS_ERR(p))
@@ -450,8 +451,16 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	}
 	ctx->mech_used.len = gss_kerberos_mech.gm_oid.len;
 
-	return gss_krb5_import_ctx_v2(ctx, gfp_mask);
+	ret = gss_krb5_import_ctx_v2(ctx, gfp_mask);
+	if (ret) {
+		p = ERR_PTR(ret);
+		goto out_free;
+	}
 
+	return 0;
+
+out_free:
+	kfree(ctx->mech_used.data);
 out_err:
 	return PTR_ERR(p);
 }
-- 
2.43.0


