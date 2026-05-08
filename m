Return-Path: <stable+bounces-244778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJ6ABPL4/WlilQAAu9opvQ
	(envelope-from <stable+bounces-244778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:53:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175B4F823B
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4122C305CB94
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DBA3F54C5;
	Fri,  8 May 2026 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9HckgL1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D13F65EF
	for <stable@vger.kernel.org>; Fri,  8 May 2026 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251929; cv=none; b=RzLDqyjVmPF2BAKa6JgCdI/eQNrkMbOU9kb8JVjTDT1cqbaZywbs2/AhiH/jMUbb5/kUUQmzs4YxEx37fbcuhCjMg6PkSOR10VW3DHA3fyocMvzvcHftpciQbuEFbKlOJiDaNGyimL/xYzjODQsgwqWQJU6r4voZpALbkzm7QPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251929; c=relaxed/simple;
	bh=U6+s7VNGFOqhekbVCtNTfZ3+2uDzQgOI6g2f2RGRu8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbYKwdwRkX8Kfvglwcyrh1D8RlHfLd/XBjkz6w106JHMKQGKgoXzq/PWfgYU4aiU9Gu7U/UyfUE4bwYjWklouoqitdInBGREbFYBkptqAGRXF+VmrVQgg1kX2IUJ5pBhUpmSKr4WHDIKccb0Q8OEgq0DJxXDKqfjh+7eTe082Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9HckgL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CA4C2BCC7;
	Fri,  8 May 2026 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778251929;
	bh=U6+s7VNGFOqhekbVCtNTfZ3+2uDzQgOI6g2f2RGRu8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J9HckgL1ODU95iHCqirtE/gOuQK/PF7l4WXmKiosYPysGYvk6JuOErZveYoPxEUfj
	 RHMi0HtWjG0CIQXEkTRNXTqtUbiIW3t7OFjb1ZPEJe1j0/6nhZV8CG2mzx9gSPrMgJ
	 mEGy/XELUD/4DhrakdmTL/Z9mMikvup2M9RV3krivghtxxKrh2zH7vyCurKOvRBkGZ
	 ZqjHiMC5Lv6/ROkaBPS6u8TPGW/cKKtPUbvKVBDQnoixo9nyaXi0m9qd1NuO4yf8LZ
	 z4A0gAeOuuVKIA+8w1vJfYMDhbUhemPlxxl8FIa4zWvv0pgwixmJii9I8jSy3yANXR
	 hPnmHeYyxSJHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: fix a resource leak in xfs_alloc_buftarg()
Date: Fri,  8 May 2026 10:52:06 -0400
Message-ID: <20260508145206.1512706-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026050314-humming-baboon-4d05@gregkh>
References: <2026050314-humming-baboon-4d05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8175B4F823B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244778-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
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
index 257945cdf63b8..34e476301342c 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -2036,6 +2036,7 @@ xfs_alloc_buftarg(
 error_lru:
 	list_lru_destroy(&btp->bt_lru);
 error_free:
+	fs_put_dax(btp->bt_daxdev, mp);
 	kmem_free(btp);
 	return NULL;
 }
-- 
2.53.0


