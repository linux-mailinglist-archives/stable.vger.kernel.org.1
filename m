Return-Path: <stable+bounces-218052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PC8MfFPnmleUgQAu9opvQ
	(envelope-from <stable+bounces-218052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:27:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4631018EA83
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69131307815F
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817B74369A;
	Wed, 25 Feb 2026 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DfoLAF7D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551A1D5ABA;
	Wed, 25 Feb 2026 01:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982820; cv=none; b=WRsuLuVkO4BMdyOuLT995/IMYpWLavMWj3jKdDzKxo8Y1z1ZDKs7i1ZpZ6O3biu0gLyxMGXUsJG/rAM5diTnykp8o6gtGuOLDeovSP2Q7WXCiM90DXMcYyUZxsyxzzcLSQPOYvym1qKwpfx7V3sRYOp+l8iSSeOy5u1o9y16LbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982820; c=relaxed/simple;
	bh=ossK0pLQbZ3qH1K6eNeihmYGAc0DGEou+lYZBwt/TVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6enBCpu2QZ2BEe7Kl/QexfrdZpux+XnaQNlfKOj3o9hHrPJchggJ0hNC7YtKoK/VfRyPWsuLe9b8PhW/JEUfyKDP8Cje+MS5JDenIpZT3N1Kb1WkAN6xbdXwuTDTt1fTwdlTht8rDvaroGt31Cfx9WjG8ADjHVVCSwnBk7C+vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DfoLAF7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0A0C116D0;
	Wed, 25 Feb 2026 01:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982819;
	bh=ossK0pLQbZ3qH1K6eNeihmYGAc0DGEou+lYZBwt/TVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DfoLAF7DOWzl6Y3olEjZiwKE9Zwpk7Zrflj/z/IqWQ32eBAFIAWvVJwF0WmZPexqe
	 m1ggwymGqrnVmeFrzLiq/UD7gqrSMxXnjXnZFOOM41HZOUkUp426nSJ/zc7FXCtfLk
	 tv5fmUZeupZTXC7yi/SJn6mMMqKgFXSqPnAz/9uc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 015/781] erofs: avoid noisy messages for transient -ENOMEM
Date: Tue, 24 Feb 2026 17:12:04 -0800
Message-ID: <20260225012400.075613412@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218052-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4631018EA83
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit 9aa64b62a73cbca226c0144dcf3cdf97294e0641 ]

EROFS may allocate temporary pages using GFP_NOWAIT | GFP_NORETRY
when pcl->besteffort is off (e.g., for readahead requests).

If the allocation fails, the original request will fall back to
synchronous read, so the failure is transient.

Such fallback can frequently happen in low memory scenarios, but since
these failures are expected and temporary, avoid printing error
messages like below:

[ 7425.184264] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 148447232 size 28672 => 26788
[ 7426.244267] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 149422080 size 28672 => 15903
[ 7426.245508] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 138440704 size 28672 => 39294
...
[ 7504.258373] erofs (device sr0): failed to decompress (lz4) -ENOMEM @ pa 93581312 size 20480 => 47366

Fixes: 831faabed812 ("erofs: improve decompression error reporting")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 70e1597dec8a6..c62908f1ce478 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1324,9 +1324,10 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, bool eio)
 						GFP_NOWAIT | __GFP_NORETRY
 				 }, be->pagepool);
 		if (IS_ERR(reason)) {
-			erofs_err(be->sb, "failed to decompress (%s) %pe @ pa %llu size %u => %u",
-				  alg->name, reason, pcl->pos,
-				  pcl->pclustersize, pcl->length);
+			if (pcl->besteffort || reason != ERR_PTR(-ENOMEM))
+				erofs_err(be->sb, "failed to decompress (%s) %pe @ pa %llu size %u => %u",
+					  alg->name, reason, pcl->pos,
+					  pcl->pclustersize, pcl->length);
 			err = PTR_ERR(reason);
 		} else if (unlikely(reason)) {
 			erofs_err(be->sb, "failed to decompress (%s) %s @ pa %llu size %u => %u",
-- 
2.51.0




