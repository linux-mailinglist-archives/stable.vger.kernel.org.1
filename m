Return-Path: <stable+bounces-238952-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFSUFwgz5mlqtQEAu9opvQ
	(envelope-from <stable+bounces-238952-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:07:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F09FB42CA39
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9DF0B320CE57
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7BA3E928E;
	Mon, 20 Apr 2026 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dad+UJS1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F703E869E;
	Mon, 20 Apr 2026 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691501; cv=none; b=UudgCljOz/dIbqEDCJEufkR9gXvbuYQrEqErERNA/i/R5wuLwjJbnoSo2tvUfR6s/ROfLZF+i8GgRLqn28Bwh+Nxppx4QpLyhKjlPs5MyFBWsf4O4LAadNHc/+K8fX/Dl3dhDDMt8p9mH+C5eFtca8EXZDwRnF8eS8m6IjxPHfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691501; c=relaxed/simple;
	bh=T1/QlGHkJlYLWWiWa3UxuOGCI5dveXwK/BEDomLE/Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swIT4yZzJAeUCBzdlH2EkSN2cXaCMnHol4RPJXzMRbIysg8tR/m/FBLcTzAaOQGhkLfHSTX39p9oHp1GmK+FfGQQT15+L1sd88TsEfUiPTO4K9rWei8Fb3kfH+prxaXPtdcAUXxt8cMEoSDrNGCw9gmBUsu3nqXTMeAZ4brtL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dad+UJS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC7FC2BCB6;
	Mon, 20 Apr 2026 13:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691501;
	bh=T1/QlGHkJlYLWWiWa3UxuOGCI5dveXwK/BEDomLE/Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dad+UJS1Jm8WqoM86dRnd4YJatbvGDDEmK+/kxWBtfNu6zYxmeqlJwKwWqzLScudp
	 7O1tuLKgy8VXFzIM/s2eXtPmMemkxXlgepPjEgSerU9itzGItYi1t7O+giMqQzGiI/
	 FXcEi8RXlQAeZqCjHqQfrD6drP3HzXCf6p6Fp81iD/kf4R1e50sNb6VTWX+rF5vPwI
	 uOyKbxikDGYRCIUfdJJJg+4iHKITbkLy/TdFWtfPwejTaO/grVaFeYtSRvevjsVUt8
	 B7gx3oVNJauLrBmXSJPM4ddY97wKgGi7W+1/pOXBHBQHN6JYfRP222kzVjfrzvyFGM
	 J27suqiGj1G6Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Krishna Chomal <krishna.chomal108@gmail.com>,
	WJ Enderlava <jie7172585@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hansg@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] platform/x86: hp-wmi: Add support for Omen 16-wf1xxx (8C76)
Date: Mon, 20 Apr 2026 09:17:41 -0400
Message-ID: <20260420132314.1023554-67-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,kernel.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238952-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F09FB42CA39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Krishna Chomal <krishna.chomal108@gmail.com>

[ Upstream commit 84d29bfd1929d08f092851162a3d055a2134d043 ]

The HP Omen 16-wf1xxx (board ID: 8C76) has the same WMI interface as
other Victus S boards, but requires quirks for correctly switching
thermal profile (similar to board 8C78).

Add the DMI board name to victus_s_thermal_profile_boards[] table and
map it to omen_v1_thermal_params.

Testing on board 8C76 confirmed that platform profile is registered
successfully and fan RPMs are readable and controllable.

Tested-by: WJ Enderlava <jie7172585@gmail.com>
Reported-by: WJ Enderlava <jie7172585@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221149
Signed-off-by: Krishna Chomal <krishna.chomal108@gmail.com>
Link: https://patch.msgid.link/20260227154106.226809-1-krishna.chomal108@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 drivers/platform/x86/hp/hp-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 008f3364230e2..31d099bd8db43 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -174,6 +174,10 @@ static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8BD5") },
 		.driver_data = (void *)&victus_s_thermal_params,
 	},
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C76") },
+		.driver_data = (void *)&omen_v1_thermal_params,
+	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C78") },
 		.driver_data = (void *)&omen_v1_thermal_params,
-- 
2.53.0


