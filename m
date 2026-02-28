Return-Path: <stable+bounces-220195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKYNBwwto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD901C54C8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57D2C31FF88E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D79D4C955C;
	Sat, 28 Feb 2026 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guw5q+i+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AADB4C8FE7;
	Sat, 28 Feb 2026 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300101; cv=none; b=JRKjtNUXQmIVSF2ATr06NAvMvkTaJxs36zklt98dWLV/v+P1sWaQbeOJDXCxGdtiy4SGi+hho1MRNIgSYvL1qnL+R99A6Jy1iViXsTubZoOENZ8UoFvUjowanLaExZG8ihkZ6WGd0H3NMkyF+t/6e95snxKm5PwVJ4L00cvkzmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300101; c=relaxed/simple;
	bh=yImonkXw0LmD3jgTI0jyV1ufEXShaTFRfPts7soQ5OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imWmUOc+Zewhn/2qe8eNG5yXNvTduvufK/rRZeZ5tykIwrCnEfJ9Oxjh97prs4BLPu4BIDZZwnmAfLx6fts5pDdQj1Oo/2uJLqzLorLjt5lc4QtdVfA1Kg0RdTXU/iTsq8lVNz+0EPMrK1WfPedaEwiS+j4SDjYn+QMeyEcs7U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Guw5q+i+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FFBC116D0;
	Sat, 28 Feb 2026 17:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300101;
	bh=yImonkXw0LmD3jgTI0jyV1ufEXShaTFRfPts7soQ5OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Guw5q+i+gtm7rdiP6oRlifIMNBndOlpUByBe4VRlJDbLdyrEiyG260Rjn7zuu+hee
	 Q4Bom8XN8FYs7UmaY10Iy/SYFmqm/xGCymrouHLF9lcTNqtPpiUoSyBmN2un4jzCuF
	 FWM2rQ9mMyTCuWTF0xGMu6RhAsFH7Nf+h8BQuDNqD5KnSNyY1EbL8oxuHqmH6aO7BL
	 IuupH1ReOMsfcsGaX8z5iKMWKjUBwK4MqQS+HD0ix++Sq6WMUqPrygPY+gHVv00kZD
	 8yAb72PxvALr6pvNIHMnVhK/3yp6/+1pnRKEnSxbDn81cqhrLrXf1PGRgavhPpg7mR
	 ibzKnUy6sx/dA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 117/844] arm64: tegra: smaug: Add usb-role-switch support
Date: Sat, 28 Feb 2026 12:20:30 -0500
Message-ID: <20260228173244.1509663-118-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220195-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,ulisboa.pt:email]
X-Rspamd-Queue-Id: AFD901C54C8
X-Rspamd-Action: no action

From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>

[ Upstream commit dfa93788dd8b2f9c59adf45ecf592082b1847b7b ]

The USB2 port on Smaug is configured for OTG operation but lacked the
required 'usb-role-switch' property, leading to a failed probe and a
non-functioning USB port. Add the property along with setting the default
role to host.

Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
index 5aa6afd56cbc6..dfbd1c72388c1 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
@@ -1809,6 +1809,8 @@ usb2-0 {
 				status = "okay";
 				vbus-supply = <&usbc_vbus>;
 				mode = "otg";
+				usb-role-switch;
+				role-switch-default-mode = "host";
 			};
 
 			usb3-0 {
-- 
2.51.0


