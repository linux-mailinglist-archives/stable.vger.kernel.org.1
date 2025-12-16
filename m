Return-Path: <stable+bounces-201299-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65ACC22DD
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACC71303AA9A
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC689341ACA;
	Tue, 16 Dec 2025 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QiMmMJhU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC8341645;
	Tue, 16 Dec 2025 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884185; cv=none; b=q8O06LGF2L1lMnw0Z8NgP6UAASSIbGsSjTJC/c8ksy9G48KBf1IGTMeUzHbO7sHQOx6uAUJcRhCyrMEX2SPMHbyp4TX3WboXr+vgv2nVKaLNoftxcRagID6jroyUMFOXoqCkPRUoZGGVerWrfzpgSqHqkBTFh/QPvBzBtv3YA7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884185; c=relaxed/simple;
	bh=cyVAnYmDIt/py3x+dWB1bx8Y+lCe68jIR6zJJd4RIrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GslIKlKrZQeafAUv92Z1jhyAsKdOtH/Okg1gy6eqGTiN2yvCA2ws4KphHJ5OB7R8O6Pvw9LrTpnJFmReATes3hwe3S+ElxToWwzOSGsya41FP+XqQwPZA5roOp4LSQo++/8EaID60Fq99hbmLNKDY51hOQf0ucX3Fz7U3Hc8obY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QiMmMJhU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B255C4CEF1;
	Tue, 16 Dec 2025 11:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765884185;
	bh=cyVAnYmDIt/py3x+dWB1bx8Y+lCe68jIR6zJJd4RIrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QiMmMJhUw3KEZ0XL7c8gBUTYrE7vjfx82WFo7F4TqM/MR0PiklxA70QdR+IUNKbH7
	 16Dw/3l/HLd85Pn8YVjiExkV58uExIvfBh8DNweyUN9DRjVTy6GdbBoCmBObe1SFgp
	 3isuR1hLJ7Kfzl5uAsfVFJk/nOMgjBhrloqmWFis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alan Maguire <alan.maguire@oracle.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 118/354] libbpf: Fix parsing of multi-split BTF
Date: Tue, 16 Dec 2025 12:11:25 +0100
Message-ID: <20251216111325.199049046@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111320.896758933@linuxfoundation.org>
References: <20251216111320.896758933@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Maguire <alan.maguire@oracle.com>

[ Upstream commit 4f596acc260e691a2e348f64230392f3472feea3 ]

When creating multi-split BTF we correctly set the start string offset
to be the size of the base string section plus the base BTF start
string offset; the latter is needed for multi-split BTF since the
offset is non-zero there.

Unfortunately the BTF parsing case needed that logic and it was
missed.

Fixes: 4e29128a9ace ("libbpf/btf: Fix string handling to support multi-split BTF")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20251104203309.318429-2-alan.maguire@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b770702dab372..56935f86a6963 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1046,7 +1046,7 @@ static struct btf *btf_new(const void *data, __u32 size, struct btf *base_btf)
 	if (base_btf) {
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
-		btf->start_str_off = base_btf->hdr->str_len;
+		btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 	}
 
 	btf->raw_data = malloc(size);
@@ -5504,7 +5504,7 @@ void btf_set_base_btf(struct btf *btf, const struct btf *base_btf)
 {
 	btf->base_btf = (struct btf *)base_btf;
 	btf->start_id = btf__type_cnt(base_btf);
-	btf->start_str_off = base_btf->hdr->str_len;
+	btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
 }
 
 int btf__relocate(struct btf *btf, const struct btf *base_btf)
-- 
2.51.0




