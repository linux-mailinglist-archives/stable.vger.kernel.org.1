Return-Path: <stable+bounces-220446-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLStE/U3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220446-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E69501C63B8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5CB3F30D85F7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847AF3B7769;
	Sat, 28 Feb 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcQEyMp3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FE73B775F;
	Sat, 28 Feb 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300335; cv=none; b=PgZ7PdjpjDFHK3sgeus02ObqMZbxhSS6Kk+huC1lCzVmlOfgP989x24vjeFG2BHI2fUQkpklTP7KAzjEgULXyK6dAw2yGRkluxRnRvlyZ0G9pr7bXwmLniziAWwbrb0efH3vnqaVLWR+TdyguYkSYPsR/BIgF4U5Nu3yvQdeNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300335; c=relaxed/simple;
	bh=0KWI7mRy87m/nS0+mW6q0c2VaGXP+MWdnuyz1U6iQD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qP6mW4kvH7xddJfhfVviievM3jHvpD95isFt3S8aEeUbWvq55aTTGtExRfpX9zXGkf3VFet2v8u+ukrT39z1n6BJLQf5QS99BSkqVoiWHEDWKXbz/4yCnYJP8iz3/HVSCc9rLwAkWOrRnzcsArMD8S3NpJt2SeGjAtZn5A2yycg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcQEyMp3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C202C116D0;
	Sat, 28 Feb 2026 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300334;
	bh=0KWI7mRy87m/nS0+mW6q0c2VaGXP+MWdnuyz1U6iQD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcQEyMp3cabSvRzkbNDE+PfarubyfSP1Ab+ijsX6cbYzbPVlsb2EMRyaLj7G7Zc4H
	 Ag3yke/NkaX/0IY6MtiYcfvidpMvPbrmxpKm8IajJ3RY/PvOMK+rg2SfcwsnP36BI9
	 YAG8ak6U7jvgJsJFrubCCObbAEqlConn7v12sqcV6zk2Hac1cs5gErcBi7v7sqEHBu
	 9S/vMHkEQbzlO2313eIqieUFnbTBVJkPlxAI4WudMyIbTgZn2jKF9puGblg92xTnjy
	 Dl4dWiwtiEzPkX1qipdK9ZEQwDTYOJGsuUV6BXXNtkur76+uLku9IuJXNuGfqyexk6
	 W1ZjUUew9SOXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 367/844] soundwire: intel_auxdevice: add cs42l45 codec to wake_capable_list
Date: Sat, 28 Feb 2026 12:24:40 -0500
Message-ID: <20260228173244.1509663-368-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220446-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E69501C63B8
X-Rspamd-Action: no action

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit f87e5575a6bd1925cd55f500b61b661724372e5f ]

Add cs42l45 to the wake_capable_list because it can generate jack events
whilst the bus is stopped.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://patch.msgid.link/20251215151729.3911077-1-ckeepax@opensource.cirrus.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soundwire/intel_auxdevice.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
index 6df2601fff909..8752b0e3ce74c 100644
--- a/drivers/soundwire/intel_auxdevice.c
+++ b/drivers/soundwire/intel_auxdevice.c
@@ -52,6 +52,7 @@ struct wake_capable_part {
 
 static struct wake_capable_part wake_capable_list[] = {
 	{0x01fa, 0x4243},
+	{0x01fa, 0x4245},
 	{0x025d, 0x5682},
 	{0x025d, 0x700},
 	{0x025d, 0x711},
-- 
2.51.0


