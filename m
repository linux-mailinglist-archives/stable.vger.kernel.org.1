Return-Path: <stable+bounces-49765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92B8FEEC3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5324287CA6
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581D31C6888;
	Thu,  6 Jun 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RIf92Kbk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E441C619B;
	Thu,  6 Jun 2024 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683698; cv=none; b=bV1G3FqznklZS3zGJAv0mNdrXCxXLraQJb0Noz2nbjv4sOYSXyhsOh6JK+CdTP3s9VAe+JjOHyV+LjokG56noxl3KGct9s9unyy4rnIhW9X1tyA3+fSZgfiiGaJPy4+uWOmNNCDiDdDSIRBFJEWsZ4wMmwXoD1HB5Xtb3ietgq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683698; c=relaxed/simple;
	bh=pDNy0F4+3XWYsiB3JlS2zGxRy6KqLKuHgJQdhT9oFLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwf34/PQVPRU+10H71M4sUvuUyrBS4UkIIMtfxUjbY1rocZ2CYQNI6PwxbHJW6Z+YLcZ63GGlbeq3sHwx41BaUG8QlXxpkiMxRNSFnoX3NtPyzGhqRlXx6mD6gnZpfzLaA0IkR7mz5S7EECIgj9w+H5fTP0nZSr1vypkC5rxHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RIf92Kbk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96D6C2BD10;
	Thu,  6 Jun 2024 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683698;
	bh=pDNy0F4+3XWYsiB3JlS2zGxRy6KqLKuHgJQdhT9oFLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RIf92KbkRLG7F9J/dIRhfr3OEIW+fe0luQNUxl1i3mbWXlfTRiL9Xqg9Zy6Ta7Ftt
	 r/PIblXMKJttKk1sdaLC9QYapca7ehppSk+2PeieE8pJI6tYkXIqlGSm7KHQd2POti
	 hC8Xkj8vCwI8zska2SS4QhJ9ctlbvdNybvKdGtf0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	"Yang, Chenyuan" <cy54@illinois.edu>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>, Yang@web.codeaurora.org
Subject: [PATCH 6.6 609/744] media: cec: core: avoid recursive cec_claim_log_addrs
Date: Thu,  6 Jun 2024 16:04:41 +0200
Message-ID: <20240606131752.019524687@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 47c82aac10a6954d68f29f10d9758d016e8e5af1 ]

Keep track if cec_claim_log_addrs() is running, and return -EBUSY
if it is when calling CEC_ADAP_S_LOG_ADDRS.

This prevents a case where cec_claim_log_addrs() could be called
while it was still in progress.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: Yang, Chenyuan <cy54@illinois.edu>
Closes: https://lore.kernel.org/linux-media/PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com/
Fixes: ca684386e6e2 ("[media] cec: add HDMI CEC framework (api)")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/cec/core/cec-adap.c | 6 +++++-
 drivers/media/cec/core/cec-api.c  | 2 +-
 include/media/cec.h               | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 99c14942f2813..c15abee3e9bc4 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1547,9 +1547,12 @@ static int cec_config_thread_func(void *arg)
  */
 static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 {
-	if (WARN_ON(adap->is_configuring || adap->is_configured))
+	if (WARN_ON(adap->is_claiming_log_addrs ||
+		    adap->is_configuring || adap->is_configured))
 		return;
 
+	adap->is_claiming_log_addrs = true;
+
 	init_completion(&adap->config_completion);
 
 	/* Ready to kick off the thread */
@@ -1564,6 +1567,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
 		wait_for_completion(&adap->config_completion);
 		mutex_lock(&adap->lock);
 	}
+	adap->is_claiming_log_addrs = false;
 }
 
 /*
diff --git a/drivers/media/cec/core/cec-api.c b/drivers/media/cec/core/cec-api.c
index d64bb716f9c68..3ef9153443044 100644
--- a/drivers/media/cec/core/cec-api.c
+++ b/drivers/media/cec/core/cec-api.c
@@ -178,7 +178,7 @@ static long cec_adap_s_log_addrs(struct cec_adapter *adap, struct cec_fh *fh,
 			   CEC_LOG_ADDRS_FL_ALLOW_RC_PASSTHRU |
 			   CEC_LOG_ADDRS_FL_CDC_ONLY;
 	mutex_lock(&adap->lock);
-	if (!adap->is_configuring &&
+	if (!adap->is_claiming_log_addrs && !adap->is_configuring &&
 	    (!log_addrs.num_log_addrs || !adap->is_configured) &&
 	    !cec_is_busy(adap, fh)) {
 		err = __cec_s_log_addrs(adap, &log_addrs, block);
diff --git a/include/media/cec.h b/include/media/cec.h
index 9c007f83569aa..ffd17371302ca 100644
--- a/include/media/cec.h
+++ b/include/media/cec.h
@@ -247,6 +247,7 @@ struct cec_adapter {
 	u16 phys_addr;
 	bool needs_hpd;
 	bool is_enabled;
+	bool is_claiming_log_addrs;
 	bool is_configuring;
 	bool must_reconfigure;
 	bool is_configured;
-- 
2.43.0




