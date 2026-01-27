Return-Path: <stable+bounces-211861-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGusMHbpeGmHtwEAu9opvQ
	(envelope-from <stable+bounces-211861-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:36:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2C397D6B
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 996E9300EDE2
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F03362128;
	Tue, 27 Jan 2026 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/iCpmd2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA10F27A477
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531751; cv=none; b=eeccn4aZyx5UF0NfYi8WxOdhwvxhG62c7yVJwx4goGsMoa5/ZaJn93sPzA9yZKsmX4bG/Eu6OTZPYOZisN+H8O+OSxZzh+H981Xba7yE1LGMiECnC0IrruErqoLM55CVnc2tu8KUAsyhFgIof7eExJvoAO4zqdCBsm/FVq7lz0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531751; c=relaxed/simple;
	bh=TuF0RLZSdLbu6bifPOOlLWrKN8X7jbkdkKGFZoeuSTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jdq1teSf6cNC5VaawEfwfK/JwJ0+Jetb8Ns+aywkT1WOdCpOvQ+yqfQxSrtObSAQxl1MVbKS/rHUkctNfNGndnslUI5XsX/xuBikG3NVW1kx4QAI7PWH6nBpaKU67BwSoE6m1thYE2d/7ZiiztG3UhZqB2hjcTqy46jHJxGgpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/iCpmd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEFBC116C6;
	Tue, 27 Jan 2026 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769531750;
	bh=TuF0RLZSdLbu6bifPOOlLWrKN8X7jbkdkKGFZoeuSTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/iCpmd2u7Wct8XJ9ye4HKwrMbWBNSFpX8lI78yQod+DWD9wejfP0kPh0Q63b6UWX
	 M2azb08keEvU/Xl9EHv/a+n3ZEykhnqZprC6mnLzRpdOMm0voUiGh8bxWck5VgZ1pB
	 3k+7X8XLTPJ3S2ZJzwf3bfSx+SluxQ0ZYkhtOiaKGQBVsTIJ32K0Lm0Z4x8MmqHkGD
	 Pyeey5i/RZd5oFZMmNnHka4TrjMJbCOi2MAdovOt+1CaoTaHL6j0uDH43GkINeYJuL
	 qIx2Rhg7AoWGIvTkkyLtE1Tw3bjFik9AprpoF3/kvpV3UBVt0Cq7wf52/BMEB5GO4f
	 jGhVZ3Thgj9sw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 5.15.y] of: platform: Use default match table for /firmware
Date: Tue, 27 Jan 2026 10:35:49 -0600
Message-ID: <20260127163549.2168698-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012750-reshoot-angler-7553@gregkh>
References: <2026012750-reshoot-angler-7553@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-211861-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:email,msgid.link:url]
X-Rspamd-Queue-Id: 6B2C397D6B
X-Rspamd-Action: no action

Calling of_platform_populate() without a match table will only populate
the immediate child nodes under /firmware. This is usually fine, but in
the case of something like a "simple-mfd" node such as
"raspberrypi,bcm2835-firmware", those child nodes will not be populated.
And subsequent calls won't work either because the /firmware node is
marked as processed already.

Switch the call to of_platform_default_populate() to solve this problem.
It should be a nop for existing cases.

Fixes: 3aa0582fdb82 ("of: platform: populate /firmware/ node from of_platform_default_populate_init()")
Cc: stable@vger.kernel.org
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://patch.msgid.link/20260114015158.692170-2-robh@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
(cherry picked from commit 48e6a9c4a20870e09f85ff1a3628275d6bce31c0)
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 74afbb7a4f5e..3e1be88847e7 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -533,7 +533,7 @@ static int __init of_platform_default_populate_init(void)
 
 	node = of_find_node_by_path("/firmware");
 	if (node) {
-		of_platform_populate(node, NULL, NULL, NULL);
+		of_platform_default_populate(node, NULL, NULL);
 		of_node_put(node);
 	}
 
-- 
2.51.0


