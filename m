Return-Path: <stable+bounces-178241-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4888B47DD1
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3DC9188F2A1
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED47B1A9FAA;
	Sun,  7 Sep 2025 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CZfnyhQv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2C1A2389;
	Sun,  7 Sep 2025 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276212; cv=none; b=mGW841sLyuCoLljaFiI3V/cRuUHX41/UX7DfP96F4hGL2J84Eeags4gC8RLiyttjYmVtzA9W3jXSokPcviuL7Gv4CYvQG/qjxKzw0WJeLqJYMyjQxD4Vd/1sxPxCTwBmkKllv9vSP0xdmK7L+0qCu6q1nHzb7XGjq43RcL++VZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276212; c=relaxed/simple;
	bh=X3PU7JZYCzDrg28GqrNpgSuD3D0eN0oECxk0In4Hc54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLM0ibv81xC/fvAtD6s22RkWbmh+C0ifu2QQKWJqSC4fFqTe2CoUTMfEcjzQXyOxK8WX0TnpKYnaOFF/GS77SGxSNixZCEqzjTEmpKIOhevgElCM4hAkCusWaU7mblm27RpbFNSuEUPu7VKbUR4+levFvjl/qxzO62QZsjZaMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CZfnyhQv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A2BC4CEF0;
	Sun,  7 Sep 2025 20:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276212;
	bh=X3PU7JZYCzDrg28GqrNpgSuD3D0eN0oECxk0In4Hc54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZfnyhQvULEYHt855mQ+cCU3mzTkDZ2eBuH+JQI1IH0N6UZxyK+jVKtorP/SwffRg
	 Q8AbT/E0SXK1bXkMWaMUSAf5YzdbJBvUmP60v0sxBUfLwVbBX+lUx+SKS5jpLTqKza
	 odH4qOahDK3P1Djuw2GjglbvF3ewe8kKatHUol1E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 033/104] net/smc: Remove validation of reserved bits in CLC Decline message
Date: Sun,  7 Sep 2025 21:57:50 +0200
Message-ID: <20250907195608.559852130@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195607.664912704@linuxfoundation.org>
References: <20250907195607.664912704@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mahanta Jambigi <mjambigi@linux.ibm.com>

[ Upstream commit cc282f73bc0cbdf3ee7af2f2d3a2ef4e6b19242d ]

Currently SMC code is validating the reserved bits while parsing the incoming
CLC decline message & when this validation fails, its treated as a protocol
error. As a result, the SMC connection is terminated instead of falling back to
TCP. As per RFC7609[1] specs we shouldn't be validating the reserved bits that
is part of CLC message. This patch fixes this issue.

CLC Decline message format can viewed here[2].

[1] https://datatracker.ietf.org/doc/html/rfc7609#page-92
[2] https://datatracker.ietf.org/doc/html/rfc7609#page-105

Fixes: 8ade200c269f ("net/smc: add v2 format of CLC decline message")
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Link: https://patch.msgid.link/20250902082041.98996-1-mjambigi@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_clc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index a48fdc83fe6b2..6ed77f02ceac0 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -422,8 +422,6 @@ smc_clc_msg_decl_valid(struct smc_clc_msg_decline *dclc)
 {
 	struct smc_clc_msg_hdr *hdr = &dclc->hdr;
 
-	if (hdr->typev1 != SMC_TYPE_R && hdr->typev1 != SMC_TYPE_D)
-		return false;
 	if (hdr->version == SMC_V1) {
 		if (ntohs(hdr->length) != sizeof(struct smc_clc_msg_decline))
 			return false;
-- 
2.50.1




