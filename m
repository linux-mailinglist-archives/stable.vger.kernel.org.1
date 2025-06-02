Return-Path: <stable+bounces-149227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DE8ACB197
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 16:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7C43A97CC
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AA122257E;
	Mon,  2 Jun 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BpqI0EHc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7871DE881;
	Mon,  2 Jun 2025 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873308; cv=none; b=fhHCbymR8sVXlrtF/AXGjWCdvgnJdI8mJ/2j2zg5OAp+07GvUj3WYIDZ8DrqR/2c0y8sjTObOZLRMUobww/RkEBaLlWqTDKY7iuiaHpERwHoMd3rDB/OoM+seWFMJPeDFWT6pD6IvjDmLkTtly3eLs2tSD0IEXALMKHGs0g393g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873308; c=relaxed/simple;
	bh=3Ujss56qwzxo0ue8NPu75Go++yPuLvCnC/FygHnKVww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7DAHyUYveLyZ/TllsnOUZYxNRz3ildIXhpCtYrWhJZpvT6fIB3lULKqhgX6ATrCkebuBOCiKMPwgDHufC5q1eDaYygfapyJ5QxZXg0ogMp94oZ49nbP/CDDcQpBRuVemav+cfhTaDBkUVqO8WzdjBVaM3ClkNp7DrxcZGqr4+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BpqI0EHc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5865FC4CEEB;
	Mon,  2 Jun 2025 14:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748873307;
	bh=3Ujss56qwzxo0ue8NPu75Go++yPuLvCnC/FygHnKVww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BpqI0EHcnmwQtR3LO1+i774MToaPGgSNz3ViAPYmGTgr7BNRdfTBwhxGECZVFMvpm
	 iT+aLsMYN7/oQz9FhE7JnuwwRJ9wfhuxmZNWtZCMPcxXphzKXxfm2Cnta1BAYyLNeo
	 AuCNft0Vo+L8sgcRKxt0kJUbRVblRjYiNLTrr3dM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shashank Gupta <shashankg@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 100/444] crypto: octeontx2 - suppress auth failure screaming due to negative tests
Date: Mon,  2 Jun 2025 15:42:44 +0200
Message-ID: <20250602134344.962786853@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shashank Gupta <shashankg@marvell.com>

[ Upstream commit 64b7871522a4cba99d092e1c849d6f9092868aaa ]

This patch addresses an issue where authentication failures were being
erroneously reported due to negative test failures in the "ccm(aes)"
selftest.
pr_debug suppress unnecessary screaming of these tests.

Signed-off-by: Shashank Gupta <shashankg@marvell.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
index 811ded72ce5fb..798bb40fed68d 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_reqmgr.c
@@ -410,9 +410,10 @@ static int cpt_process_ccode(struct otx2_cptlfs_info *lfs,
 				break;
 			}
 
-			dev_err(&pdev->dev,
-				"Request failed with software error code 0x%x\n",
-				cpt_status->s.uc_compcode);
+			pr_debug("Request failed with software error code 0x%x: algo = %s driver = %s\n",
+				 cpt_status->s.uc_compcode,
+				 info->req->areq->tfm->__crt_alg->cra_name,
+				 info->req->areq->tfm->__crt_alg->cra_driver_name);
 			otx2_cpt_dump_sg_list(pdev, info->req);
 			break;
 		}
-- 
2.39.5




