Return-Path: <stable+bounces-18557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E94D848331
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517BE1C20810
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B67350259;
	Sat,  3 Feb 2024 04:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TSfiJwMT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5E81CABC;
	Sat,  3 Feb 2024 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933886; cv=none; b=Uq/6azSvcf2FthAKECOPtYvzRL2rUinAvFHUZR8ta8RgSOjnL2C1lb/Zpr0u16TjZVk1Weteh1C/8ddq6SVGtqVUkA3BLy7uW4Koi4tevzImvwNU2L4ULiBH+dah5BsKAqKsCE+uf0uXV6dvALBNWXY7VV2EZJwVxdk1DnMEO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933886; c=relaxed/simple;
	bh=TNYiAgH9fx5WtjF+2SGW8svxmRrOCN74i7pJFNXCP9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn6D8JozhRFWC0yZcVbvVcDyLLwlhylP9A0FEM/aD0rHKDdEC3vMix7FmIP6dtdlusCmRNVsaTs1oqHjH5o6fP3TTW7ESduqO7PpEfNZ+KGTyzab3qGJScW3CsoUIBWVsBge3EKg+TEoDEp1vLcKlt+u7hXqyHZ654PI3bfsN1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TSfiJwMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842A6C433C7;
	Sat,  3 Feb 2024 04:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933886;
	bh=TNYiAgH9fx5WtjF+2SGW8svxmRrOCN74i7pJFNXCP9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSfiJwMTPPt0Hj2GU3usgvxk2cOqOIsX2PFXbbRcmj2BQWrtUXMu8th/N5QnN7lZk
	 x40kHEaz8vIba4SmmXBNagNfgJMomF3SdQXdhlT8HHkzi1HcidBx4A4fBbYRMOHLg6
	 FAEhvBGATmrFx5eVM6VU3fSYyaWIPYls3suF2z4I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Su Hui <suhui@nfschina.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 201/353] media: ddbridge: fix an error code problem in ddb_probe
Date: Fri,  2 Feb 2024 20:05:19 -0800
Message-ID: <20240203035410.050271086@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 09b4195021be69af1e1936cca995712a6d0f2562 ]

Error code is assigned to 'stat', return 'stat' rather than '-1'.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ddbridge/ddbridge-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 91733ab9f58c..363badab7cf0 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -238,7 +238,7 @@ static int ddb_probe(struct pci_dev *pdev,
 	ddb_unmap(dev);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	return -1;
+	return stat;
 }
 
 /****************************************************************************/
-- 
2.43.0




