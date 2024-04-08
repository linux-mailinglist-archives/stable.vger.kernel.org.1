Return-Path: <stable+bounces-37600-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966889C68A
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD4DFB26BFF
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23A67D085;
	Mon,  8 Apr 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uQ99t2mN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D379F0;
	Mon,  8 Apr 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584709; cv=none; b=SiPVpUARDBFbTFtaXzU7E5FV+4pi3rmz10LTPIZr+oP1iKLoFGdBEoHjZ9srpHSMEhALjq4cSNC4aFHP2OYlXYkqStpbz6az5TOrUJvEmml6hE0SQNqEsM/pNJZSMSIrHRO2O46g1ghZAs4hBK8CnQdGaIaNisc8DTyO2ufhCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584709; c=relaxed/simple;
	bh=MJmFSvqLDes/6pX/CF89ef6EOx6+hOvMuUaTQZTOFQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpadJDzN3s8/sUKzR+wHRKap9r+A+HWgWS8K1J3KNyaVwt9FdFgub/oGFnOqfryfv5dS0suSlGFoMm9fDCJDypBGgtdQekmvq1EQ0YXRDvzRd7YHj0P2WCfWeXW5j4uv8NYy4zAaKMYsRjZBLfGXDM8dJWWtGu1eS5S6/VhNQQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uQ99t2mN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15485C433F1;
	Mon,  8 Apr 2024 13:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584709;
	bh=MJmFSvqLDes/6pX/CF89ef6EOx6+hOvMuUaTQZTOFQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQ99t2mNI4rZaypAmsNP80xFWafHL2P5xplZaZijLuNIhH8//+KtazCrJlMlUQqPx
	 HCx2avvwh7a73hFLC4HDiPovQlm6RP0Rqw0Nf1V8XZYqEYU3jimaorMoprkKRIj57m
	 i34dEbJ+37tDqzU7RNeh0KCeHtytbANsglPGWkhM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 531/690] nfsd: simplify test_bit return in NFSD_FILE_KEY_FULL comparator
Date: Mon,  8 Apr 2024 14:56:37 +0200
Message-ID: <20240408125418.894156889@linuxfoundation.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit d69b8dbfd0866abc5ec84652cc1c10fc3d4d91ef ]

test_bit returns bool, so we can just compare the result of that to the
key->gc value without the "!!".

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 4ddc82b84f7c4..d61c8223082a4 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -188,7 +188,7 @@ static int nfsd_file_obj_cmpfn(struct rhashtable_compare_arg *arg,
 			return 1;
 		if (!nfsd_match_cred(nf->nf_cred, key->cred))
 			return 1;
-		if (!!test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
+		if (test_bit(NFSD_FILE_GC, &nf->nf_flags) != key->gc)
 			return 1;
 		if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags) == 0)
 			return 1;
-- 
2.43.0




