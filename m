Return-Path: <stable+bounces-17020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CA0840F7D
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823941F235BF
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCBE15DBAE;
	Mon, 29 Jan 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zm18pGL5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07D915957C;
	Mon, 29 Jan 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548450; cv=none; b=JQ37qjMQUwiFP2EBka8jpyFzY2Y0e9AAzwET19xudsXb/XOC0b8DrU/QdS5u1r5mgksFIjBqPjDNTqIhRqOUdWY1WSQU1rlmHoQSK0DcesVUolHkQtzOHnnQ0XTsAUN4kLR9docf1jWV0QwRPD07+mHp+6lb1CmqSQmcvtdBhKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548450; c=relaxed/simple;
	bh=kSrKuIClp7dap9JDtlZIXR/aDE0fKhEYdC6/jdbqzGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ug1vdkDxX2zkBmW3mEx4SE9oAm6QhUrdPiIRpxM1pLRcjQbMBpzzTckyVn96bb5+exL/tRGmZdmxLgBsjozv+v0VBKl9LhXXO5oWtffXdsN9Lcb0l9PfZGkJ3pgXUZDXjpJt8SkEDeH7BnbrKwu1vWjfM0ZJ5wB7OgEMd1k1/A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zm18pGL5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993A2C433C7;
	Mon, 29 Jan 2024 17:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548450;
	bh=kSrKuIClp7dap9JDtlZIXR/aDE0fKhEYdC6/jdbqzGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zm18pGL5SfpcDudr9u1FDPYscebGnsmP1EnU4QuyCKw40LjUH4Y3KQVN4aQMfY9CG
	 JyYiHK3rF3c2RSYDqW6D+ak3p4tfQ6TWb6xKAk+zDr0+bx0rvcbvRY7+oKnwUnhRwd
	 cBMOPk6Jk6y6aQqUJG2mH7XTySChdNj3bO/Nhaj8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6.6 035/331] OPP: Pass rounded rate to _set_opp()
Date: Mon, 29 Jan 2024 09:01:39 -0800
Message-ID: <20240129170015.971559885@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170014.969142961@linuxfoundation.org>
References: <20240129170014.969142961@linuxfoundation.org>
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

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 7269c250db1b89cda72ca419b7bd5e37997309d6 upstream.

The OPP core finds the eventual frequency to set with the help of
clk_round_rate() and the same was earlier getting passed to _set_opp()
and that's what would get configured.

The commit 1efae8d2e777 ("OPP: Make dev_pm_opp_set_opp() independent of
frequency") mistakenly changed that. Fix it.

Fixes: 1efae8d2e777 ("OPP: Make dev_pm_opp_set_opp() independent of frequency")
Cc: v5.18+ <stable@vger.kernel.org> # v6.0+
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/opp/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1322,12 +1322,12 @@ int dev_pm_opp_set_rate(struct device *d
 		 * value of the frequency. In such a case, do not abort but
 		 * configure the hardware to the desired frequency forcefully.
 		 */
-		forced = opp_table->rate_clk_single != target_freq;
+		forced = opp_table->rate_clk_single != freq;
 	}
 
-	ret = _set_opp(dev, opp_table, opp, &target_freq, forced);
+	ret = _set_opp(dev, opp_table, opp, &freq, forced);
 
-	if (target_freq)
+	if (freq)
 		dev_pm_opp_put(opp);
 
 put_opp_table:



