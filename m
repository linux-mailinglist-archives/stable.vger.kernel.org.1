Return-Path: <stable+bounces-248712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM/4BehZB2orzwIAu9opvQ
	(envelope-from <stable+bounces-248712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:37:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AADEB55551A
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE4313254E50
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC003C0607;
	Fri, 15 May 2026 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OV1IE7Kg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C46C3F927C;
	Fri, 15 May 2026 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862435; cv=none; b=TNLsflwoZ/qPD46cLjOcYymvjmyi9oANqXsNU0J/lnn9ZAOvyzcK9v8ap/eiB0HMUfYTeY8eHxFMxTtAzYxTYNqoYlUXtnwD33xUhAoy7p2yZ5zmuqYsi2fB+fmaYb6uysWBvHuzOqTi4EpROfQPeTSAPBjlWUgWYD2WATVa0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862435; c=relaxed/simple;
	bh=m3YgQNgtvoeBJdZSsVjXk7d5lSFR0s5MjCoZboKa3p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAecm1jSv3ZXWlqqjHV9x1nI4r6kdiSGL48DG0ADPVNvbzE1Oj46qthupfMnXorUclIV8iRHHaeGsb8drLsLnAGq2efvOW9O1IrBsEBjSEc5TlRiKr2XYKC+8AMixE5+NTU2rXpQEALt9OY1S5sNJ7zKnRJrlh9O8PzrcgUqKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OV1IE7Kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026E9C2BCB0;
	Fri, 15 May 2026 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862435;
	bh=m3YgQNgtvoeBJdZSsVjXk7d5lSFR0s5MjCoZboKa3p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OV1IE7KgEfnTiBmzO0/LQhdHLIg7YsWZE4dBhUxGtV/iT3ai0UFctRY4nHACw934k
	 I+znKjzmoGMxPPXuimCamkTpxj1Tv5Kz44Y3jUpFBNgVxobuQSgbnh3/x+qWk57AAC
	 PXW3oDvrcNGeVX7hf+bDzM6Z+2KFSBeGcAAHeWAg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Morgan <macromorgan@hotmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH 7.0 040/201] regulator: bq257xx: fix OF node reference imbalance
Date: Fri, 15 May 2026 17:47:38 +0200
Message-ID: <20260515154659.401210690@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: AADEB55551A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,hotmail.com,chromium.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-248712-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 7ea07bc030d8d6395524dec22ff3267441a28c0d upstream.

The driver reuses the OF node of the parent multi-function device but
fails to take another reference to balance the one dropped by the
platform bus code when unbinding the MFD and deregistering the child
devices.

Fix this by using the intended helper for reusing OF nodes.

Fixes: 981dd162b635 ("regulator: bq257xx: Add bq257xx boost regulator driver")
Cc: stable@vger.kernel.org	# 6.18
Cc: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260408073055.5183-2-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/regulator/bq257xx-regulator.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -142,8 +142,7 @@ static int bq257xx_regulator_probe(struc
 	struct device_node *np = dev->of_node;
 	struct regulator_config cfg = {};
 
-	pdev->dev.of_node = pdev->dev.parent->of_node;
-	pdev->dev.of_node_reused = true;
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(struct bq257xx_reg_data), GFP_KERNEL);
 	if (!pdata)



