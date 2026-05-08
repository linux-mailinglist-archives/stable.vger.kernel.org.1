Return-Path: <stable+bounces-244758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHjxJRnl/WnckQAAu9opvQ
	(envelope-from <stable+bounces-244758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 15:28:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2FA4F70FC
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05CE5307E65D
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA9237FF5C;
	Fri,  8 May 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED607bGC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B449326A1AF
	for <stable@vger.kernel.org>; Fri,  8 May 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246575; cv=none; b=Tk+wVJjMaCqKWzHtLKerBq7dLzA34xtCgXSTWXX+VFXieKAoSjyBNiXsx0g3HsDYMfUjI68uue5/s8shbQoBrn+E4CKfH4+Pd497E7T4ZOV1rT+Wd8CInCSr8jviCkL4keQlC1yzE7I16NV5Q+GFRh276DDLlj8667wkQ4B1HtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246575; c=relaxed/simple;
	bh=oFuAsL8YSWB4dBi5psi4Gpr9pQr/kU50sWzQ8/b+sm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IV6U5bZj7a8f/yF1J5rPZTkCVgmuTbdIBYoZfMJ1J36/kPOhDtbuvqtku7De6N17j3UQ5gMZF8DKI9iFzHvDr8egiIIOKBZ/5Tiwe1QCaSovJ25Jo1S1qBqg/THFTseat/VlrKaMf5jdQRX6maIOIz2cR+WbZQZU+guDRi+7dg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED607bGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49A2C2BCB0;
	Fri,  8 May 2026 13:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246575;
	bh=oFuAsL8YSWB4dBi5psi4Gpr9pQr/kU50sWzQ8/b+sm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ED607bGCX/KA6UDBN7fxpYLlB0L0a07QKSFl2DalTKTTiLxyEfw8MZU72oqG3Jyl1
	 q/DiLJ9wpbEUr+BLr4VZr+Cj6KRJ/vMmaVOV46Mza8a+tOq/eW10QNYiUXzL9Fyxbx
	 M43bztPhixPNKU0o9zJadhER1KRabtt8P57wMQOwACLuy7oR3f1syc1qfinvwVFDlV
	 WvZWlfNLhT2NcyT/c0SaSbeqiPDrTioZO/q8mB913s810K6CmyaGPqxHQkSG4aQf1N
	 rrPxEVhBSEB4GpURUDyVpq6B/hvdhuokQe4XhlvOCv7mpBGZMD+J+g3gjjZyJiK/nO
	 RbxyErFYkJ71w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: fix a resource leak in xfs_alloc_buftarg()
Date: Fri,  8 May 2026 09:22:52 -0400
Message-ID: <20260508132252.1479242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050313-manmade-batting-5838@gregkh>
References: <2026050313-manmade-batting-5838@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EC2FA4F70FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244758-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>

[ Upstream commit 29a7b2614357393b176ef06ba5bc3ff5afc8df69 ]

In the error path, call fs_put_dax() to drop the DAX
device reference.

Fixes: 6f643c57d57c ("xfs: implement ->notify_failure() for XFS")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ kept `kmem_free(btp)` and `return NULL` instead of `kfree(btp)`/`ERR_PTR(error)` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_buf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 20c1d146af1da..1181108f80746 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2045,6 +2045,7 @@ xfs_alloc_buftarg(
 error_lru:
 	list_lru_destroy(&btp->bt_lru);
 error_free:
+	fs_put_dax(btp->bt_daxdev, mp);
 	kmem_free(btp);
 	return NULL;
 }
-- 
2.53.0


