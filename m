Return-Path: <stable+bounces-103171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5539EF730
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5014167FBB
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA249216E14;
	Thu, 12 Dec 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yv6JlDHV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938312165F0;
	Thu, 12 Dec 2024 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023758; cv=none; b=uMbw4sa91XifA9FrfJQzZen0iLVyvs/YpvalIf3yKDOf+xFD/sjIZvl41JekykQSzbIYf1LimFFvVFkQE6c1sCwrhOwXLMP+u+pkE3LvpoSpYf90n8bDRGCCOhpCks1zQTRN+X1A/h9ys7jsD6HlXNeYatExRY/FVITM7f1K7E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023758; c=relaxed/simple;
	bh=tIUtHpcACms0X59mwwrDJzWI4KrKfMoJYw6SchcAlz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTQbodwbGo6E5SMeIO84o7JxAqdBPYif2Ru5lPRINjPhNUqvPE9lucm/gtWb54fUQfbLRyaiHgEkq0qoLWa4iZgaFyzDj7D5YtaLmUWDNLdu0zlbDxrXTBPjz5mo/IL5Eeq5BT87YFQF0bJKSyxwfIzQebOUVe06k6U3FWsxYgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yv6JlDHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17374C4CED3;
	Thu, 12 Dec 2024 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023758;
	bh=tIUtHpcACms0X59mwwrDJzWI4KrKfMoJYw6SchcAlz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yv6JlDHVqcjSHbzqyMWaVg6qH+19dYWyCF6/Bo1nevfoyXPUIRqK3lzvq7F9U53lA
	 Scvne5/ECCbubUhtHTxrFUtoGViLa5G3pYHHe8Mpmwoymxs5iSqZLnQUKrimbn5mRc
	 ikZ88Oizq7UPHQJbftuRTi7G4RmWPwn5/gw5kFmw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Everest K.C." <everestkc@everestkc.com.np>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 072/459] crypto: cavium - Fix the if condition to exit loop after timeout
Date: Thu, 12 Dec 2024 15:56:50 +0100
Message-ID: <20241212144256.368165865@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144253.511169641@linuxfoundation.org>
References: <20241212144253.511169641@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Everest K.C <everestkc@everestkc.com.np>

[ Upstream commit 53d91ca76b6c426c546542a44c78507b42008c9e ]

The while loop breaks in the first run because of incorrect
if condition. It also causes the statements after the if to
appear dead.
Fix this by changing the condition from if(timeout--) to
if(!timeout--).

This bug was reported by Coverity Scan.
Report:
CID 1600859: (#1 of 1): Logically dead code (DEADCODE)
dead_error_line: Execution cannot reach this statement: udelay(30UL);

Fixes: 9e2c7d99941d ("crypto: cavium - Add Support for Octeon-tx CPT Engine")
Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/cavium/cpt/cptpf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cavium/cpt/cptpf_main.c b/drivers/crypto/cavium/cpt/cptpf_main.c
index d9362199423f2..b3db27b142afb 100644
--- a/drivers/crypto/cavium/cpt/cptpf_main.c
+++ b/drivers/crypto/cavium/cpt/cptpf_main.c
@@ -45,7 +45,7 @@ static void cpt_disable_cores(struct cpt_device *cpt, u64 coremask,
 		dev_err(dev, "Cores still busy %llx", coremask);
 		grp = cpt_read_csr64(cpt->reg_base,
 				     CPTX_PF_EXEC_BUSY(0));
-		if (timeout--)
+		if (!timeout--)
 			break;
 
 		udelay(CSR_DELAY);
@@ -395,7 +395,7 @@ static void cpt_disable_all_cores(struct cpt_device *cpt)
 		dev_err(dev, "Cores still busy");
 		grp = cpt_read_csr64(cpt->reg_base,
 				     CPTX_PF_EXEC_BUSY(0));
-		if (timeout--)
+		if (!timeout--)
 			break;
 
 		udelay(CSR_DELAY);
-- 
2.43.0




