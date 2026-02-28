Return-Path: <stable+bounces-220215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNgaNl0uo2me+AQAu9opvQ
	(envelope-from <stable+bounces-220215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2951C5658
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E250303B97E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7B64DBD81;
	Sat, 28 Feb 2026 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pPXweO4p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B24DBD75;
	Sat, 28 Feb 2026 17:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300121; cv=none; b=W9h8+60yyEGRm270HkbZw4zmHD4DPE2uOrV1Y+DaoC8FsIf2VhcLxSoH7KAoHiP+TN2fNs5epyAAVeXPG1qJrC5a8swU1sJ3D5YQ3lZAtkFAKZQjbfdc2J8gLJdC8860o3QyZtcjtCenfP6p6bOUdOXZVNA2LCFQLkeS7N8i0Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300121; c=relaxed/simple;
	bh=r4mqs94xvraAjLpwrzacbIkmYCZB0A7V9JtP283uhv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULhq+A+phdytZdt1awUtsMFOl6ilviuV5vDQPB6QVfKDZV4Mw3kST8FaDLEDPzTjd1y8WmOAln3iu5enYXr9CzgQT5kW6fO//TrPvEn0PSmsUFhbvoOIdBP/l4G/GPMJeMHG2OojjJrtUVpM8Y5Vre0e4bZLdBhjpbgegdbgBQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pPXweO4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33268C19424;
	Sat, 28 Feb 2026 17:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300120;
	bh=r4mqs94xvraAjLpwrzacbIkmYCZB0A7V9JtP283uhv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pPXweO4pJR3vB3Ha6eRIEP8rpD6OeGfm4TZtC1ft9/Ubn5IyPowujNVBZlspmLn4Y
	 MEIGAh8LlFXXc1SnbNNGrQ52Hs1bZ9pLKDnKDUnJaVoMCJPcquwDhRPPgrxEGWpNAW
	 CR78bXUzBx1vIdbkLZ99+4EVxUwIFbOCW03098avyS4XStoUMyOln7XgVzbFnyhOEG
	 2gL1SQ1XCjVSIaN/+t58JBar3uhjByXknPEey61KHd7FxuG9hoEKfjraIMiw4+g8A5
	 wMUQOKPvyQleNYowWAi3/JdMmkU+i1IpWdpAHzmxNRtlXo5gMFnQKd+S6sx0kBYK4U
	 Zl3naI0gmXg5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Val Packett <val@packett.cool>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 137/844] drm/panel-edp: Add AUO B140QAX01.H panel
Date: Sat, 28 Feb 2026 12:20:50 -0500
Message-ID: <20260228173244.1509663-138-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220215-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,chromium.org:email,packett.cool:email]
X-Rspamd-Queue-Id: 4E2951C5658
X-Rspamd-Action: no action

From: Val Packett <val@packett.cool>

[ Upstream commit bcd752c706c357229185a330ab450b86236d9031 ]

A 14-inch 2560x1600 60Hz matte touch panel, found on a Dell Latitude 7455
laptop (second-source with BOE NE14QDM), according to online sources it's
also found on the Latitude 7440 and some ASUS models.

Raw EDID dump:

00 ff ff ff ff ff ff 00 06 af a4 0b 00 00 00 00
00 20 01 04 a5 1e 13 78 03 ad f5 a8 54 47 9c 24
0e 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 f0 68 00 a0 a0 40 2e 60 30 20
35 00 2d bc 10 00 00 1a f3 53 00 a0 a0 40 2e 60
30 20 35 00 2d bc 10 00 00 1a 00 00 00 fe 00 36
39 52 31 57 80 42 31 34 30 51 41 58 00 00 00 00
00 02 41 21 a8 00 01 00 00 1a 41 0a 20 20 00 a1

Don't have datasheet access, but the same timing as for other panels from
the same manufacturer works fine.

Signed-off-by: Val Packett <val@packett.cool>
[dianders: Moved to the right location in the table]
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20251206173739.2222940-1-val@packett.cool
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 2c35970377431..85dd3f4cb8e1c 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1880,6 +1880,7 @@ static const struct panel_delay delay_80_500_e50_d50 = {
  */
 static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x04a4, &delay_200_500_e50, "B122UAN01.0"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x0ba4, &delay_200_500_e50, "B140QAX01.H"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x105c, &delay_200_500_e50, "B116XTN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1062, &delay_200_500_e50, "B120XAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x125c, &delay_200_500_e50, "Unknown"),
-- 
2.51.0


