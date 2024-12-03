Return-Path: <stable+bounces-97363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9D9E26F0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 755FABC708E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297142036FD;
	Tue,  3 Dec 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2KGOLMUh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D908C1F893D;
	Tue,  3 Dec 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240269; cv=none; b=EFjLHIBWmRoAPQFMnEkN/62MtoxHogGycRM2jMexqGjBvK28LMbL3ALcsfeRDpW8z8im04dZpheHx9CVXZRnJTv1p+3dpzfN9N/7sYNIKxFF8yw4FgvTtRU2JBVBg3XuihL+F2R2gfqeLG+yiiuQT07t/hEgXietXgCacvDIebo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240269; c=relaxed/simple;
	bh=DKUt3hOWurfpX9vxp/FPJ7EAdBuFKX0Pqtg5rsMSHnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+2GBR9ytbT08XmzBUakJySHk8u6B8T9VdDnPsrGi/NgUF2zNMRuE/QwRmBFnV+sn92fNVBRP8VCB6xcy3r43KkTi5nuSwlI+Vlt/oobzN8Lay6zVzuDOqxq9P87inmv56IBnAGR16tPmwOHu+Lnti7p27RZhlPOrqzKURBFnY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2KGOLMUh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B94C4CECF;
	Tue,  3 Dec 2024 15:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240269;
	bh=DKUt3hOWurfpX9vxp/FPJ7EAdBuFKX0Pqtg5rsMSHnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2KGOLMUh2J7eOQ8W3/4jXTiFdza0aSTlEtMWsaUcPrZnWBJP/RIYgEnD30FYsuDZ/
	 QNnqBOvI+DtnWK96TOuoLDcOllaV1mmAvWjVZmYkq58tnjYp6e1LcR0UQI8cnr+W69
	 +5cTzNCkedTL0V1ZR38D8sMB6e7RD/WdiQUrggFw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 082/826] thermal/lib: Fix memory leak on error in thermal_genl_auto()
Date: Tue,  3 Dec 2024 15:36:49 +0100
Message-ID: <20241203144746.919454723@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Lezcano <daniel.lezcano@linaro.org>

[ Upstream commit 7569406e95f2353070d88ebc88e8c13698542317 ]

The function thermal_genl_auto() does not free the allocated message
in the error path. Fix that by putting a out label and jump to it
which will free the message instead of directly returning an error.

Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
Reported-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Link: https://patch.msgid.link/20241024105938.1095358-1-daniel.lezcano@linaro.org
[ rjw: Fixed up the !msg error path, added Fixes tag ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/thermal/commands.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/lib/thermal/commands.c b/tools/lib/thermal/commands.c
index a9223df91dcf5..27b4442f0e347 100644
--- a/tools/lib/thermal/commands.c
+++ b/tools/lib/thermal/commands.c
@@ -279,6 +279,7 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cm
 					 struct cmd_param *param,
 					 int cmd, int flags, void *arg)
 {
+	thermal_error_t ret = THERMAL_ERROR;
 	struct nl_msg *msg;
 	void *hdr;
 
@@ -289,17 +290,19 @@ static thermal_error_t thermal_genl_auto(struct thermal_handler *th, cmd_cb_t cm
 	hdr = genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, thermal_cmd_ops.o_id,
 			  0, flags, cmd, THERMAL_GENL_VERSION);
 	if (!hdr)
-		return THERMAL_ERROR;
+		goto out;
 
 	if (cmd_cb && cmd_cb(msg, param))
-		return THERMAL_ERROR;
+		goto out;
 
 	if (nl_send_msg(th->sk_cmd, th->cb_cmd, msg, genl_handle_msg, arg))
-		return THERMAL_ERROR;
+		goto out;
 
+	ret = THERMAL_SUCCESS;
+out:
 	nlmsg_free(msg);
 
-	return THERMAL_SUCCESS;
+	return ret;
 }
 
 thermal_error_t thermal_cmd_get_tz(struct thermal_handler *th, struct thermal_zone **tz)
-- 
2.43.0




