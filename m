Return-Path: <stable+bounces-218547-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDE1EmNTnmm3UgQAu9opvQ
	(envelope-from <stable+bounces-218547-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9877918F80C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3971E313975B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAB243376;
	Wed, 25 Feb 2026 01:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X04ujOd2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD518B0A;
	Wed, 25 Feb 2026 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983385; cv=none; b=sGnT+EWqFyUitzWC1Sm1hkSfvGMmAqE30qlNSMH3K9sHbAiAoxKQnXqvw9lTWhtXUVKSHeL3eL/fT+iwrDsbCaAvRgQDKaZHtE4Pnph+JztCcCRDu/fs0tcc1AjN62kDSBX+Y1Qhb3I2TdAat7Jvk04UXc56yePoCZgm8DP98L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983385; c=relaxed/simple;
	bh=d9g2M2xJ2utZco1uQBNCWfQCVqydpWzoNscIm6MMp/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0J7UhAMaM4dYMkcbrwDSMf7uA6+dlLI+aZZNrWMkhRTSk22Ed1HG79oL5Tat2WMhu71G1N92Tb6t2umDOgbXlR8J2etpaKK7AThAdJbX4tv7W2MenkGYzMWS7IgMz4I3hWYAn7HCnboOTIlgqDxI8vOw26dJPkmmg5IyfevuYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X04ujOd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85CDAC116D0;
	Wed, 25 Feb 2026 01:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983385;
	bh=d9g2M2xJ2utZco1uQBNCWfQCVqydpWzoNscIm6MMp/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X04ujOd2Gf9tJDqkwLqnsyuMbL1dcnyq/yet5gidsJ2y361liiEFjJt/OQWkLm9NJ
	 qKdiUA1WD8ek7NfXCxb+KoH0Q4WQhtIIeyYasR3rrTd9xF2Q09QkYyuSitKqioQANF
	 hJ4pNjd+rReJDRTToIRW08tthHzA2OKTf6n1LKTM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Felix Gu <ustc.gu@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 509/781] fbdev: of_display_timing: Fix device node reference leak in of_get_display_timings()
Date: Tue, 24 Feb 2026 17:20:18 -0800
Message-ID: <20260225012412.288589290@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-218547-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,gmx.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 9877918F80C
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Felix Gu <ustc.gu@gmail.com>

[ Upstream commit c39ee2d264f98efa14aa46c9942114cb03c7baa6 ]

Use for_each_child_of_node_scoped instead of for_each_child_of_node
to ensure automatic of_node_put on early exit paths, preventing
device node reference leak.

Fixes: cc3f414cf2e4 ("video: add of helper for display timings/videomode")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/of_display_timing.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index bebd371c6b93e..a4cd446ac5a59 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -195,7 +195,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 	disp->num_timings = 0;
 	disp->native_mode = 0;
 
-	for_each_child_of_node(timings_np, entry) {
+	for_each_child_of_node_scoped(timings_np, child) {
 		struct display_timing *dt;
 		int r;
 
@@ -206,7 +206,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 			goto timingfail;
 		}
 
-		r = of_parse_display_timing(entry, dt);
+		r = of_parse_display_timing(child, dt);
 		if (r) {
 			/*
 			 * to not encourage wrong devicetrees, fail in case of
@@ -218,7 +218,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 			goto timingfail;
 		}
 
-		if (native_mode == entry)
+		if (native_mode == child)
 			disp->native_mode = disp->num_timings;
 
 		disp->timings[disp->num_timings] = dt;
-- 
2.51.0




