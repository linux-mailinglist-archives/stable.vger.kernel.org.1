Return-Path: <stable+bounces-249465-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uANSOFP6C2qISwUAu9opvQ
	(envelope-from <stable+bounces-249465-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:51:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B2657794F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 981EC304FB9F
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 05:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A516351C27;
	Tue, 19 May 2026 05:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="oTsZCmG2"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824B134F46D
	for <stable@vger.kernel.org>; Tue, 19 May 2026 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169839; cv=none; b=RKRLU8XyhoFewue595XWihGXzK0pMBziQlayDKc1tM0cw85OfkwYI0hBJoETvJF0rSGivcM7IaRKYN4AqOWR9HWI5N67Xt+x9FJcRXEpEcjqyYZnZPU+mY1+25DxblhhzXtfqjeotpesrCBWbNfZuO+/OKCyRsBz7FTHOXe4vvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169839; c=relaxed/simple;
	bh=XXynUxQ3LuE8fy+pLQmYNaeVurrreAUhZ7Sxgxz5Isc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pjkSMAVu+YSfyBx4JlOQv0tHIrvH89as6hCT/5smQYkra+cgBRjsMZrpJqqQafPhRNY8YpxPUX79GfHZ7qKSHtTIjZvHD0j7Hbmfql3IJvNvrsqIWd302KwOLZ8K0c0bY+syRqCOs8WxYP3TgWlOJFRTrQra3IJdM+0jxhEEajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=oTsZCmG2; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-83659d38e38so1237428b3a.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 22:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1779169838; x=1779774638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucHECs4zlnHCRoQL7hkpDKkM89fT0NiKrOSG8N2ICv4=;
        b=oTsZCmG2fnapIvF7tzLJM2hq/Kti0z2SktEe6MYIT4Fa1120tvTOqwG2AFDDfww/+H
         JIpw/oZC3veHkJXcfTfhSE1+9EawNSxvUna/QBMMMX5b8e1EXqaiwpg5sqK4AboX6ZZF
         UnUu5yRPn2Wc57QAnvclZj6+HDLFzp5cBGjMVU6NbYwSELnTHSUW3Hu3IinbgvO4CxMA
         9DwRroVCsus2rmCdCtnlJb6v+fjlM6G67c3OS4FILa8r+8mcOiGGjWtDiqUZm2wJE6JG
         oYywmO9oSpGRiVAr8+eC7qyCfYQt50qK35FI9XfyoRS4v9gHRtKHYttPsPS9ERsiZMSC
         F7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779169838; x=1779774638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ucHECs4zlnHCRoQL7hkpDKkM89fT0NiKrOSG8N2ICv4=;
        b=q6AKmVhfwNlV1DivcmIZpIXcf1QqneBZlP2M4YvAd+Ddie78iQQ5pR6eAjcjSJR/l9
         p6cWADaSyzKiSTyKe5myWwFhFnVYA9d3bqRvywAQ/hbXjNTmP5azWrLUqexh+vDnLmMT
         qsZFZ1q6yWf7q8aFQt5cj4SWTz8iZSCG9E/ekkFegYDvTm9eQLzahG61N+PRchxOBFQ9
         9YxECnRVsDy5jS9h2UKd8gG7KQzO7GWJopSOacPO7Zqhg5+2+yWzoQL72p6WPmO6WW8u
         mfJ6NqfZLgRrmTb9Fel7cHdcposACDesTOxgWQ+pHCUbC7qlaVWCisF/2vOhbcZEGY7O
         N+1g==
X-Forwarded-Encrypted: i=1; AFNElJ/e9Fam69nOCryjWTkCq1tBVm0HEauibghl5LQ3in9yYc/0XnsGTzfTChfCmUM0Zv1njLS3EZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzbeyyiJwXvUQALnevfmqirWBkw9pWhfkBu5U5xJUxehxn8iUF
	6jqVlf1110SoUgyNBIYTu0oh8nyqGVT53sN0c6VBlnsqpF8x/VovY/h9kY9zSHlPUUk=
X-Gm-Gg: Acq92OHjG9tXSKAZPqs1Xo+1a5sHuX3nBnXFtgkCOKOlU5FuhyHBCB8THt0V0I+D2/G
	SfC0WpaUpbH63Sq4qT0dQcbEAMhgV6DWOqufhYDrVPXw8BSjr0ygy/Ie21Jvdve1bgT9CrrqGT/
	1nvPsN7H8PBKFv8HEHfzX/xycGQa3WN1GLkpyNIRtJjAZyK0u+V8F4EuXDS1xZ4Cb7fg1QdWX77
	W+5QmKVNRsh4zWbJ4GrcQ6gNvuvDPsa8eHWtxjD7WhlfqdMcPOwu3dJZ5bZADb2i37tI9lQYXpU
	Japk1icgw1zOJ6UO0QqhEAwdZmT/r8EyG7TUCGCO+vagSAmC8D93K6qPuQMV7/74DsJEb5gCr8G
	XnB4EF8LhT2xGCFiCnGMxtZFYxUxXJepPK5aqpI70N4zL68sm9srU6N5I3vOdYuzvXSXrv2ggMb
	Qc4xDSbMxgB1IUjoT1m06N7pVu/fX+0X+R9+V0ITUu7fpkhZc0JpqBXkp9vTaZ7p7OrXvcZujOW
	A94kRAWJl1YhRVoyusCjsWcofNTvKkqccBv71UEu9HH
X-Received: by 2002:a05:6a00:429b:b0:82f:d34c:ccc6 with SMTP id d2e1a72fcca58-83f33ab6689mr17997430b3a.10.1779169837802;
        Mon, 18 May 2026 22:50:37 -0700 (PDT)
Received: from [127.0.1.1] ([103.158.43.41])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-83f19664a59sm16818807b3a.1.2026.05.18.22.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 22:50:37 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Tue, 19 May 2026 11:20:13 +0530
Subject: [PATCH 2/2] nvdimm/btt: fix potential memory leak in btt_init()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-nvdimmleaks-v1-2-592300fb7a43@cse.iitm.ac.in>
References: <20260519-nvdimmleaks-v1-0-592300fb7a43@cse.iitm.ac.in>
In-Reply-To: <20260519-nvdimmleaks-v1-0-592300fb7a43@cse.iitm.ac.in>
To: Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, 
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Cc: nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>
X-Mailer: b4 0.13.0
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[cse-iitm-ac-in.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[iitm.ac.in : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cse-iitm-ac-in.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-249465-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nihaal@cse.iitm.ac.in,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iitm.ac.in:email,cse.iitm.ac.in:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cse-iitm-ac-in.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 66B2657794F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The memory allocated by discover_arenas() or create_arenas() is not
freed in some of the error paths in btt_init(). Fix that by calling
free_arenas() on the error paths.

Fixes: 5212e11fde4d ("nd_btt: atomic sector updates")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/nvdimm/btt.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index e0b6a85a8124..7e1112960d7f 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1592,7 +1592,7 @@ static struct btt *btt_init(struct nd_btt *nd_btt, unsigned long long rawsize,
 	if (btt->init_state != INIT_READY && nd_region->ro) {
 		dev_warn(dev, "%s is read-only, unable to init btt metadata\n",
 				dev_name(&nd_region->dev));
-		return NULL;
+		goto err;
 	} else if (btt->init_state != INIT_READY) {
 		btt->num_arenas = (rawsize / ARENA_MAX_SIZE) +
 			((rawsize % ARENA_MAX_SIZE) ? 1 : 0);
@@ -1602,25 +1602,28 @@ static struct btt *btt_init(struct nd_btt *nd_btt, unsigned long long rawsize,
 		ret = create_arenas(btt);
 		if (ret) {
 			dev_info(dev, "init: create_arenas: %d\n", ret);
-			return NULL;
+			goto err;
 		}
 
 		ret = btt_meta_init(btt);
 		if (ret) {
 			dev_err(dev, "init: error in meta_init: %d\n", ret);
-			return NULL;
+			goto err;
 		}
 	}
 
 	ret = btt_blk_init(btt);
 	if (ret) {
 		dev_err(dev, "init: error in blk_init: %d\n", ret);
-		return NULL;
+		goto err;
 	}
 
 	btt_debugfs_init(btt);
 
 	return btt;
+err:
+	free_arenas(btt);
+	return NULL;
 }
 
 /**

-- 
2.43.0


