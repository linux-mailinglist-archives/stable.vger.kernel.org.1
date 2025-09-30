Return-Path: <stable+bounces-182578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F2CBADAF3
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF245169E9A
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2E7302CD6;
	Tue, 30 Sep 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bVDmP4Q3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579BE29827E;
	Tue, 30 Sep 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245401; cv=none; b=SYFvgUzUaPSXE1aZtVI6WaED0w+WjzUW7Id/zxtrHKVZT/JKmRZs5/7R9jPmSbWYQGMH2IsZ3aEsfQVMLCbkTdheMN0+AjDt5xXx/73vbodZ62jDcjfJ6SWgcC8h8De4YGrQsAzpKU2E+9fac+C9xlPWt7ooSs6bax1WKa+Dpbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245401; c=relaxed/simple;
	bh=FGpYr5jFf4+KCRFp4zS8v2WKJxQNlE6/8FcT6j4CI7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFLJN/3A37kcqIwPvVkdanJODbhrzz3gnsrW4nS4hNS87Vx8a5bJVtPbNSzW/dmQUMLsq3gT2GuvTyN1twesSWheLeQNCbMteGdZ4HzDuaXsI6EQdCfZqGMMoyJWNnqg4qYJwnt3deqTX0FhzLl7xzbtKTPiUJVJ43F7WVgr1Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bVDmP4Q3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841D3C113D0;
	Tue, 30 Sep 2025 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245400;
	bh=FGpYr5jFf4+KCRFp4zS8v2WKJxQNlE6/8FcT6j4CI7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVDmP4Q3s0P41iXJJTNjnB4crtOHmo01fx5ihqxoOdwCqUfo4i41hv8ORdsaO02zg
	 zgQspz627ju4TSuk7UOYqE9O0Dr2/utyRs9x72qbmPHq077LDAwtExk2EeKlGnOoD+
	 fcgXhVldM67SQ4RtVnYhTH+BlNMGgiiK0jGhAVrw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 129/151] bnxt_en: correct offset handling for IPv6 destination address
Date: Tue, 30 Sep 2025 16:47:39 +0200
Message-ID: <20250930143832.741346289@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143827.587035735@linuxfoundation.org>
References: <20250930143827.587035735@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit 3d3aa9472c6dd0704e9961ed4769caac5b1c8d52 ]

In bnxt_tc_parse_pedit(), the code incorrectly writes IPv6
destination values to the source address field (saddr) when
processing pedit offsets within the destination address range.

This patch corrects the assignment to use daddr instead of saddr,
ensuring that pedit operations on IPv6 destination addresses are
applied correctly.

Fixes: 9b9eb518e338 ("bnxt_en: Add support for NAT(L3/L4 rewrite)")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Link: https://patch.msgid.link/20250920121157.351921-1-alok.a.tiwari@oracle.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
index b3473883eae6b..0dd393a4fa80c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -244,7 +244,7 @@ bnxt_tc_parse_pedit(struct bnxt *bp, struct bnxt_tc_actions *actions,
 			   offset < offset_of_ip6_daddr + 16) {
 			actions->nat.src_xlate = false;
 			idx = (offset - offset_of_ip6_daddr) / 4;
-			actions->nat.l3.ipv6.saddr.s6_addr32[idx] = htonl(val);
+			actions->nat.l3.ipv6.daddr.s6_addr32[idx] = htonl(val);
 		} else {
 			netdev_err(bp->dev,
 				   "%s: IPv6_hdr: Invalid pedit field\n",
-- 
2.51.0




