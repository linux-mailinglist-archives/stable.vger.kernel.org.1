Return-Path: <stable+bounces-166642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D68B1B9A3
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 19:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DE07AD468
	for <lists+stable@lfdr.de>; Tue,  5 Aug 2025 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC8292936;
	Tue,  5 Aug 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V5dtunmS"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361FA55
	for <stable@vger.kernel.org>; Tue,  5 Aug 2025 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754416508; cv=none; b=PDNCho+S2QiqtsXB/qaMkPyGlk4YmHz6oHJVipgHslHG25uwgFdcpjxrD/TKCO1ahV0motcBnpxgnncpcuEyWVaGsy+jgPpqT7BmPmOdPK+deTqzsjaKllkXlm316QzuH0yczc7+zEuE6YP9m+q9Jb2DiRXkb1IkimXfn3YD+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754416508; c=relaxed/simple;
	bh=TZly8mud1T3RB8nAlENz1FLPsbjtlRIUVXzbtKTHP5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQgVhAkES3R18tiaTa9cR85EGipepamvpu1prgq458DlnD1UD2c+CyrnYPLjxUm70Brhf8wKIutxPv4WbiuxdFmCLSRgrJfduJf5eBu6OKJsvmIWYtVI/KToaLJ9kR5fgRuChV/rBeW+hwEnNLC7YCAmRxtOeG7Xf2EzWwtNbdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V5dtunmS; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754416504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vulfXIFmexpfA5lwRoGk96ZZXlWrhV40376EMZHa1Sg=;
	b=V5dtunmSPVsFyztOawBJbnTGI5dGhqjdJaE8bb5+Pzlq6mrdXLk7eD/7IsU23iBkUH6fU9
	akb7ZYhXaHqkK1w84zPx0rbsX0RpjqPs5z5uierAVEB6wwMscyCtyvvW2Jwa8EQyOATjv4
	s8QaAhSD4yQS0x7xd/f/BERBA/tZVEI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] NFSD: Fix destination buffer size in nfsd4_ssc_setup_dul()
Date: Tue,  5 Aug 2025 19:53:02 +0200
Message-ID: <20250805175302.29386-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit 5304877936c0 ("NFSD: Fix strncpy() fortify warning") replaced
strncpy(,, sizeof(..)) with strlcpy(,, sizeof(..) - 1), but strlcpy()
already guaranteed NUL-termination of the destination buffer and
subtracting one byte potentially truncated the source string.

The incorrect size was then carried over in commit 72f78ae00a8e ("NFSD:
move from strlcpy with unused retval to strscpy") when switching from
strlcpy() to strscpy().

Fix this off-by-one error by using the full size of the destination
buffer again.

Cc: stable@vger.kernel.org
Fixes: 5304877936c0 ("NFSD: Fix strncpy() fortify warning")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/nfsd/nfs4proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 71b428efcbb5..32be002a248f 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1469,7 +1469,7 @@ static __be32 nfsd4_ssc_setup_dul(struct nfsd_net *nn, char *ipaddr,
 		return 0;
 	}
 	if (work) {
-		strscpy(work->nsui_ipaddr, ipaddr, sizeof(work->nsui_ipaddr) - 1);
+		strscpy(work->nsui_ipaddr, ipaddr);
 		refcount_set(&work->nsui_refcnt, 2);
 		work->nsui_busy = true;
 		list_add_tail(&work->nsui_list, &nn->nfsd_ssc_mount_list);
-- 
2.50.1


