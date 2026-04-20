Return-Path: <stable+bounces-239575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNunFCZg5mkqvgEAu9opvQ
	(envelope-from <stable+bounces-239575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:19:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9A5430FFA
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EADCD32A56B2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A24331A78;
	Mon, 20 Apr 2026 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MPCy0drK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8820617A31C;
	Mon, 20 Apr 2026 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700604; cv=none; b=laGXtZiPh5TuJ1Rh4sB48iJvn2i17d3UlGXRzuKDbnaQRGawWwuoNMSORiGjYvujiJqqkhH6kEGf8VHMKcRSPMjQJNE6IeZZM8UvWv9GWDZ8y0+nLBlA1SNqb16OTKiEoT7IoV2e52DzYqs4iUUSnWe+sarIF6RpB7PsswASQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700604; c=relaxed/simple;
	bh=HInMtfAbYsHcx7hSxGG92bx4gL/KGXaKGM5rJRVsLFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glnaheuT58AQejQfs3mwkUxl0UY0S8hcfY4c/ECWYPF8S2iSafqkS2WXMhXMEj7D4Q1FrtfpKr8CmyOXChOgfTgDc0EZaqTlUwpHpI7B1oZpeOJ9PDvonMkRjrpeUnoJnNa7fr5EObYceDhdBBTKVy5MFjKwJD4f/NlhqTgedAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MPCy0drK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E955C19425;
	Mon, 20 Apr 2026 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700604;
	bh=HInMtfAbYsHcx7hSxGG92bx4gL/KGXaKGM5rJRVsLFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPCy0drKcgF9EBptvHuMspkamuUfjIMGqzh2nja+0oIFaYCal1Z9/2zq7auVMhZ7r
	 3YewMKPp0CJQdcJUx9qNf305U9eXDsRCEwaN+b6MgZOwmHyv/OLYpRImMj73uKGyxu
	 yW41S9VSe85QGBA27Wr6s11ZX49WVELHPDHCZYss=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	WJ Enderlava <jie7172585@gmail.com>,
	Krishna Chomal <krishna.chomal108@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 017/198] platform/x86: hp-wmi: Add support for Omen 16-wf1xxx (8C76)
Date: Mon, 20 Apr 2026 17:39:56 +0200
Message-ID: <20260420153936.237012031@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.intel.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-239575-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: CF9A5430FFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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




