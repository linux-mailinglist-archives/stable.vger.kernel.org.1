Return-Path: <stable+bounces-160989-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3AFAFD28E
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2547AFEBD
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECD17C21E;
	Tue,  8 Jul 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hn/4HkD7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246092F37;
	Tue,  8 Jul 2025 16:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993276; cv=none; b=GPW0gBwE69qoAjwpgKjhHSOZKBnBYjM6hg2O99Hr7XY6b//PdwHyS0nRHd1GaVN19W2Sv0bjPbaU0MC7ppp8MbxJPRGIcutPAL2Gs+Ucb6sZ5/IjeUXcAjOMa98UWwDvypJRkSuUyE/mw3sPi6IX5WmtCY9eQWKUclwQiz/hNRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993276; c=relaxed/simple;
	bh=RSvMVWKIJBIIknUtvXALlvb1lmOyqVYkbIVdulo6b0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyyJv9riArhJTxsYWYTIlp2A9hf/Aj/xpW49OYUYFgYJalA5Hlr57kWmIYjvNQgfisxrDXGOZX2KVvIleZNnx08uxogBD8J2eztFo8G++1juHrH01MsCunM2H2Vo21a1+kO63ZF6Xsr1jDnqC9paGO5bOWrq0kkwKIHdO8hrn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hn/4HkD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BCDC4CEED;
	Tue,  8 Jul 2025 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751993276;
	bh=RSvMVWKIJBIIknUtvXALlvb1lmOyqVYkbIVdulo6b0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hn/4HkD7QTXWE5mQRbNAHNGGYbERLMvPznPS8QAL4O5jxXSpYr4tn/sqkxTz4PvnY
	 aJ+1GtbqPb0xWhMxjIDdAqTlGdBvJPJMFeJ1tRMstuTqv0xNvlGbAWIa0QvAG/H/CF
	 lae3d3msX3OWZRHfXxxNgpAxx/ozHGHCHmo1EU88=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.15 019/178] mmc: core: Adjust some error messages for SD UHS-II cards
Date: Tue,  8 Jul 2025 18:20:56 +0200
Message-ID: <20250708162237.050624923@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162236.549307806@linuxfoundation.org>
References: <20250708162236.549307806@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Victor Shih <victor.shih@genesyslogic.com.tw>

commit 14633da0f416fdbb6844d1b295cdc828b666e273 upstream.

Adjust some error messages to debug mode to avoid causing
misunderstanding it is an error.

Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 9a9f7e13952b ("mmc: core: Support UHS-II card control and access")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250606110121.96314-2-victorshihgli@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/sd_uhs2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mmc/core/sd_uhs2.c
+++ b/drivers/mmc/core/sd_uhs2.c
@@ -91,8 +91,8 @@ static int sd_uhs2_phy_init(struct mmc_h
 
 	err = host->ops->uhs2_control(host, UHS2_PHY_INIT);
 	if (err) {
-		pr_err("%s: failed to initial phy for UHS-II!\n",
-		       mmc_hostname(host));
+		pr_debug("%s: failed to initial phy for UHS-II!\n",
+			 mmc_hostname(host));
 	}
 
 	return err;



