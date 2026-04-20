Return-Path: <stable+bounces-239409-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHSsAIZX5ml5vAEAu9opvQ
	(envelope-from <stable+bounces-239409-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF642FE1D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B216133909BE
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F013368AE;
	Mon, 20 Apr 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xa9GPQFS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1296E33262B;
	Mon, 20 Apr 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700173; cv=none; b=Hr1N3mySUN79XffODJR9m90+ijyetY4JdJY1hWIRwBW5Z6MzqG4TtRbebvJBywrr17Z2n0NJ9upgAip79+ezYLRaT2mfkM3SFHRg3W7ae8NkxgZ0jChHJMrKz+3oQyf4VlFY1k+aZsjg42W9YkaaWktpjUyLrfl99hobwZuD2vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700173; c=relaxed/simple;
	bh=f0qH5cCh9AdINWXEB4P8SwKWWfnRtg6461RCKC4J2Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AxlbtD43R681QFOwZj10wf4GB7MQe74KGfnhvBJG+vHlYTNOemV3Lu824IZFRAnu3vyAATwr8/a4RQetIUK4hMxawmw8REOIqEaw0iMvAQ4pE8zOxSUe5IEfEzYJ7rlsnW7X5RhQwgR3mI/n8BgJLrnY9eap3NRPR5EYO46f/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xa9GPQFS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96251C2BCB6;
	Mon, 20 Apr 2026 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700172;
	bh=f0qH5cCh9AdINWXEB4P8SwKWWfnRtg6461RCKC4J2Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xa9GPQFSju59t3cp7bfWJxWMjoy+YmfXPM4lurY+gtlHwHE5C6tGMjnRkSpJji7YE
	 kWIduWYduQF1uLoJ7QZf2l1thGtKs9NyysW4ANJepJVKnAyY1d8y9kYgJ5tV2lhyHQ
	 hJSHXsqLkxcCblpoUBczCzdSnkUjafxW9zOgckD8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Imrane <ihalim.me@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 037/220] platform/x86/amd: pmc: Add Thinkpad L14 Gen3 to quirk_s2idle_bug
Date: Mon, 20 Apr 2026 17:39:38 +0200
Message-ID: <20260420153935.371006435@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,amd.com,linux.intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-239409-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,msgid.link:url,amd.com:email]
X-Rspamd-Queue-Id: 69CF642FE1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 1a9452c428a6b76f0b797bae21daa454fccef1a2 ]

This platform is a similar vintage of platforms that had a BIOS bug
leading to a 10s delay at resume from s0i3.

Add a quirk for it.

Reported-by: Imrane <ihalim.me@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221273
Tested-by: Imrane <ihalim.me@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260324211647.357924-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/platform/x86/amd/pmc/pmc-quirks.c b/drivers/platform/x86/amd/pmc/pmc-quirks.c
index ed285afaf9b0d..24506e3429430 100644
--- a/drivers/platform/x86/amd/pmc/pmc-quirks.c
+++ b/drivers/platform/x86/amd/pmc/pmc-quirks.c
@@ -203,6 +203,15 @@ static const struct dmi_system_id fwbug_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "82XQ"),
 		}
 	},
+	/* https://bugzilla.kernel.org/show_bug.cgi?id=221273 */
+	{
+		.ident = "Thinkpad L14 Gen3",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21C6"),
+		}
+	},
 	/* https://gitlab.freedesktop.org/drm/amd/-/issues/4434 */
 	{
 		.ident = "Lenovo Yoga 6 13ALC6",
-- 
2.53.0




