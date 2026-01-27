Return-Path: <stable+bounces-211862-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GS2KC/qeGmHtwEAu9opvQ
	(envelope-from <stable+bounces-211862-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:39:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0639C97DB9
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16F2F304C044
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465B309F1B;
	Tue, 27 Jan 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8xmlgFt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B0421CC7B
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769531916; cv=none; b=dXx1MqS8pmO8soGvCIlaJOZP+Z2W5ToVK1pUmimTT4r89kKHC6wNd6e6OHrOkj9EeWxIERmdqIlPcgIAc0kqaXW3XR2YGiRGY2Px9NwUVFYD3FgVqgqDeQabRbXqmvsewrQb9R/+bwLbdlrlvFJGTc5NRT9UzbXwXVJavDLEdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769531916; c=relaxed/simple;
	bh=4+jHjO1n3ObS0chi2VCvSvbXygoDEt8IrJm6jlR6jgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKctYsxgeVVdhsTIQQiTPQ4JSJWysIBsYZcDpyHxOrvSKf6uh0GgMbtl/ExXmIWTv8vBPeIV1a/bcdfR5SIbgjxFDrBUAXMiGNkUOedRZTuON2P0015iNJKIKmhYuyo2hZCoVvlLoonCK0Km+DlWVj2tUuUhJlZLjwqUaKaSl2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8xmlgFt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6819FC116C6;
	Tue, 27 Jan 2026 16:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769531916;
	bh=4+jHjO1n3ObS0chi2VCvSvbXygoDEt8IrJm6jlR6jgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8xmlgFtzOHtuskoTWr2ai88eEGc3LyS82tfYDqiAZ2ERG1/GaJvJjhZCClNQSrt1
	 jCvUCp7tcKL0If01k3+gJxw9asRCwfrVOlJa4Bvx4tJ7pu4FMIPn5CEk5FQHDj41Gp
	 De09+nCFp9idDtWmRdIbtJSdoijToB40jUhhl8jLg3r/iGEE5CjfAaE4qhv2RuzRUL
	 8g+kUHa/unBv3hAbncKc3KxCRY70mXdTpR+Ys0g9tOTTJHKXE7/M/aMuSln6nA6GGu
	 TWFOixaMAYErSm/lo+Lg6a/8NfTV6pBd3oIz2w6dumABlS56/GK1+vxZDWImoXYHHF
	 /5fV68IxvHP6Q==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: stable@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 5.10.y] of: platform: Use default match table for /firmware
Date: Tue, 27 Jan 2026 10:38:35 -0600
Message-ID: <20260127163835.2198157-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012751-crescent-atlas-e3e1@gregkh>
References: <2026012751-crescent-atlas-e3e1@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-211862-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,arm.com:email]
X-Rspamd-Queue-Id: 0639C97DB9
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
index 43748c6480c8..9ad6224afa9d 100644
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


