Return-Path: <stable+bounces-205181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0FACF9A9D
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 18:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430E330DA5CA
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 17:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CD8347BDC;
	Tue,  6 Jan 2026 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AgJFp4O1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14385346A15;
	Tue,  6 Jan 2026 17:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719845; cv=none; b=iYwiqC+b5+myWAgtYOyoc2TwYDL+Tu5DlNLlxKb602e+nWCb6/K3QQPP10LXFcLTTGt+kYQgLEdP4iB5rf/q7ZFehAFye6Qko2qGi1XZ75BidNkHf7w/ivTxM9nbT55cgJyWVwT5wSXtIsSHT8bq3nFlYpKw5xxlWDHVzq69jNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719845; c=relaxed/simple;
	bh=uVVGFqMdhcuEBBzZtoam4hyll0FmNCZhn6dMAQDeVOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lilbBrhCw7OtN8KTRi0cXCJknGfBBsrld4Ik03p+tzkTowzaye2LH60Ik1EgTd/9GMslf9OS6asaCiX3IavLPNXt37iTcuEoZDui0K2DBbIiJVF3eUBERqvqasL1+I8DBhZFKFyYks7EWQe5JYjZsgmrwG6tmvcnWzwApfoIu3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AgJFp4O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901F0C19424;
	Tue,  6 Jan 2026 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767719844;
	bh=uVVGFqMdhcuEBBzZtoam4hyll0FmNCZhn6dMAQDeVOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AgJFp4O1o8XI3kQi/94S9tgCeSVP6SqHlCVPmFHX7mKXqNWEKmiXypZY7KKRDCZrf
	 gdPqUh9nQaGWY7RjLj1LdZBx+PPM992v+rDLGrQ1i51J7Ns50/kMy67IsQXMqfpJse
	 Dce/XTl2Q1kXMJOw3GDttthkhFaPbq5CgsAmvtIU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 057/567] caif: fix integer underflow in cffrml_receive()
Date: Tue,  6 Jan 2026 17:57:19 +0100
Message-ID: <20260106170453.447276820@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106170451.332875001@linuxfoundation.org>
References: <20260106170451.332875001@linuxfoundation.org>
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

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit 8a11ff0948b5ad09b71896b7ccc850625f9878d1 ]

The cffrml_receive() function extracts a length field from the packet
header and, when FCS is disabled, subtracts 2 from this length without
validating that len >= 2.

If an attacker sends a malicious packet with a length field of 0 or 1
to an interface with FCS disabled, the subtraction causes an integer
underflow.

This can lead to memory exhaustion and kernel instability, potential
information disclosure if padding contains uninitialized kernel memory.

Fix this by validating that len >= 2 before performing the subtraction.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: b482cd2053e3 ("net-caif: add CAIF core protocol stack")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/SYBPR01MB7881511122BAFEA8212A1608AFA6A@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/caif/cffrml.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/caif/cffrml.c b/net/caif/cffrml.c
index 6651a8dc62e04..d4d63586053ad 100644
--- a/net/caif/cffrml.c
+++ b/net/caif/cffrml.c
@@ -92,8 +92,15 @@ static int cffrml_receive(struct cflayer *layr, struct cfpkt *pkt)
 	len = le16_to_cpu(tmp);
 
 	/* Subtract for FCS on length if FCS is not used. */
-	if (!this->dofcs)
+	if (!this->dofcs) {
+		if (len < 2) {
+			++cffrml_rcv_error;
+			pr_err("Invalid frame length (%d)\n", len);
+			cfpkt_destroy(pkt);
+			return -EPROTO;
+		}
 		len -= 2;
+	}
 
 	if (cfpkt_setlen(pkt, len) < 0) {
 		++cffrml_rcv_error;
-- 
2.51.0




