Return-Path: <stable+bounces-98625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD589E4956
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069D81881B24
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A39420D4E9;
	Wed,  4 Dec 2024 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afD3bLPb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242420CCF0;
	Wed,  4 Dec 2024 23:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354928; cv=none; b=O/qcyeVaFAXgpkIGMjFcCIDW5sD8EOBocTdc1iSX7lPikJc99ckyD+1x6XwsE5s8qS0izH5lceZVlxUWlxAw1nO1VvsJIzZnfDUEMDRZpIc8EG+jwLuyTXqP0GL70fuo2eu7c0i+4Q8pKJdNwu3IWY2Cn8dGHcycxn43JhcJDX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354928; c=relaxed/simple;
	bh=Ie3lvEhPMxm73YOaPHKCim46wo18T87L7WqqHIwzjDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOcCC0tkfUrz70rYEa3rvUCgxntdjCGTQNgFna/k6cArnjQHZ2JByLDj506Ve7+FF7dhgUCRDOJdbEeIVAx1OEpes2Wc8LEhH4BXAEyBhb8TKfDOnJ2tz8fzJmgD9o/va5KJqzThOnUNFtCxkar/FWG9voizlUgWN36mcpkoTsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afD3bLPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAD9C4CED2;
	Wed,  4 Dec 2024 23:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354928;
	bh=Ie3lvEhPMxm73YOaPHKCim46wo18T87L7WqqHIwzjDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=afD3bLPbfjLhiA/02M2lh+V+OCtZ3ztmoXGjIp05aPG8TnEqNaN5NRD/sa7TkcExF
	 zqRBXUGCsA+zAXNEZ2Y4+bKjGsXC0cJWKWPSkdxB0UTyuvmudK+kJVNw3iEuy4kG1q
	 Opkhj71D0yxWh9C6YYORbzY5r+CVv8aP/Fzs2rXZWJOfkwxaKRijGn1hfRVQsWinnQ
	 mh0yrtc4GGb98OMfBXrQSXmSdyY+6ZPHV+pCTYbUN/9Tpb8IFrKBkZUiblEQSMWIBe
	 xfQxkbih2PJHA9Lfn1tnCq7CkDoaUV3M3h/lfpOBWk42T97X6LB4UsZFSlFTQjO+qy
	 CjRva5m0za0Hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Yang <xu.yang_2@nxp.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 02/15] usb: chipidea: udc: limit usb request length to max 16KB
Date: Wed,  4 Dec 2024 17:16:56 -0500
Message-ID: <20241204221726.2247988-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204221726.2247988-1-sashal@kernel.org>
References: <20241204221726.2247988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Xu Yang <xu.yang_2@nxp.com>

[ Upstream commit ca8d18aa7b0f22d66a3ca9a90d8f73431b8eca89 ]

To let the device controller work properly on short packet limitations,
one usb request should only correspond to one dTD. Then every dTD will
set IOC. In theory, each dTD support up to 20KB data transfer if the
offset is 0. Due to we cannot predetermine the offset, this will limit
the usb request length to max 16KB. This should be fine since most of
the user transfer data based on this size policy.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20240923081203.2851768-2-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/chipidea/ci.h  | 1 +
 drivers/usb/chipidea/udc.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/chipidea/ci.h b/drivers/usb/chipidea/ci.h
index e4b003d060c26..97437de52ef68 100644
--- a/drivers/usb/chipidea/ci.h
+++ b/drivers/usb/chipidea/ci.h
@@ -25,6 +25,7 @@
 #define TD_PAGE_COUNT      5
 #define CI_HDRC_PAGE_SIZE  4096ul /* page size for TD's */
 #define ENDPT_MAX          32
+#define CI_MAX_REQ_SIZE	(4 * CI_HDRC_PAGE_SIZE)
 #define CI_MAX_BUF_SIZE	(TD_PAGE_COUNT * CI_HDRC_PAGE_SIZE)
 
 /******************************************************************************
diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
index 69ef3cd8d4f83..d3556416dae4f 100644
--- a/drivers/usb/chipidea/udc.c
+++ b/drivers/usb/chipidea/udc.c
@@ -960,6 +960,12 @@ static int _ep_queue(struct usb_ep *ep, struct usb_request *req,
 		return -EMSGSIZE;
 	}
 
+	if (ci->has_short_pkt_limit &&
+		hwreq->req.length > CI_MAX_REQ_SIZE) {
+		dev_err(hwep->ci->dev, "request length too big (max 16KB)\n");
+		return -EMSGSIZE;
+	}
+
 	/* first nuke then test link, e.g. previous status has not sent */
 	if (!list_empty(&hwreq->queue)) {
 		dev_err(hwep->ci->dev, "request already in queue\n");
-- 
2.43.0


