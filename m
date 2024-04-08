Return-Path: <stable+bounces-37514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1448E89C52F
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4661D1C227DE
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586447BAE3;
	Mon,  8 Apr 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X3ze11jX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F8278286;
	Mon,  8 Apr 2024 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584457; cv=none; b=EQaMdfDSjL8IlylAb7uh247gHZ2fXKvTqafCTrVtYqTwAYOlBUTwv/rgXE0UfYxziP4PBN4C6WZJ7jz3EMYRVdBcCMGpK8yIvwkaTb4r64AA1pR1Qj07qMtjVmm3fd+DG+V5ZR0J8hXXeeUiH461AVp9pA1CfgX58vP/sV0Chl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584457; c=relaxed/simple;
	bh=Li+ilXs9n2LQYMyGjFXbF5jXQuAtyH+YeG594nL+Iog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRR7YTn/UNgFbQk9mFM897h/ru7m/eHCaKIwo05c0odYMLm/D1Yl/dG5IUpzKQajANW06dttjleNiJW+WtrGXE1guDxZiNzdhyLMFPtiTgurgIemjxIni2uJ2HX8DEG2/9cAG7tDaSXTrjNjihVXQL6YNTlOSY1CNHYdwcct4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X3ze11jX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90678C43394;
	Mon,  8 Apr 2024 13:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584457;
	bh=Li+ilXs9n2LQYMyGjFXbF5jXQuAtyH+YeG594nL+Iog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X3ze11jXNbDNNY2IKMgpwEzUtr7kZyT23XYvoWm6jJgu4YvpRYLTLRL17EEk3MvOZ
	 WJQk/rp1aYwG7xZaR5YLB4Qbl4NwKy9Fsb1jxHe5TwQwHSpiGJD7zKY37BdFvJT2R4
	 6dYhynh2dgzqzgxxukjPqbSTnBeGTtwUERsDLx2o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 444/690] NFSD: Pack struct nfsd4_compoundres
Date: Mon,  8 Apr 2024 14:55:10 +0200
Message-ID: <20240408125415.728702645@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 9f553e61bd36c1048543ac2f6945103dd2f742be ]

Remove a couple of 4-byte holes on platforms with 64-bit pointers.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/xdr4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index b2bc85421b507..0eb00105d845b 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -732,8 +732,8 @@ struct nfsd4_compoundres {
 	struct svc_rqst *		rqstp;
 
 	__be32				*statusp;
-	u32				taglen;
 	char *				tag;
+	u32				taglen;
 	u32				opcnt;
 
 	struct nfsd4_compound_state	cstate;
-- 
2.43.0




