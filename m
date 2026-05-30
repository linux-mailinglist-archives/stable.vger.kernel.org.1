Return-Path: <stable+bounces-258793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOq0J1ctG2qU/wgAu9opvQ
	(envelope-from <stable+bounces-258793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:32:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A8C611F31
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2945830D1733
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AD433F5A0;
	Sat, 30 May 2026 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L7qDV8K3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C5279DC9;
	Sat, 30 May 2026 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780165557; cv=none; b=iDb4JY6C6pGpnvSqHAudqvbYr5va0YSfQjcgqvr5f+lsh/dL+0x1daGqStbXG3yjgaAaEQrG+4Y3xS0DBWnxkDopSZaCtJS9+4u00DzRromdhBdUK9bacxeXcc8NYlTTJ72h01e9DvdJLOWfhsrm6YbsedNE9WaJjMhfuJ6AFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780165557; c=relaxed/simple;
	bh=iTuTvCsFc8sr6IA3VQpn4MZ0g1omJ9t4wrV+BcJ+fD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEH+SiZaR/MtKNlCbYfjC4XrHc0jGz5ajguXZbmhumojQPk9r3iBMb5nU6TM+IpREn0CNGGYxPEyPHo9YIcm4c53mHE869H3dFyOIc3sZBr/oaYK1hFwhoLsfR6gbp7/jLqCn4BIYpdPihe7+eSepH+M/93oc/+CORxzuA0dAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L7qDV8K3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CED01F00893;
	Sat, 30 May 2026 18:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780165556;
	bh=E/oU0nkpFRvsuVCZCN4yiC14sQRQuKWS2QUVA8QY2Vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7qDV8K3nWL+Q2LYPVtbDTrsprdhfBrPMMV74Gs1nixiQPjuISgajhuwQ06qJk2wk
	 +2X0K2QHkaxEFHcUsFkcphM0cbdwUCVjJRT/U4n5GcX+3vYWqC6U9RJtHxs8CBcD56
	 MHu2i+UGXzgrZoJZCIHndW5OKAmMjZFMabs2bjto=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Martin Kepplinger <martin.kepplinger@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 113/589] arm64: dts: imx8mq-librem5-r3: workaround i2c1 issue with 1GHz cpu voltage
Date: Sat, 30 May 2026 17:59:54 +0200
Message-ID: <20260530160227.728272219@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258793-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,puri.sm:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 08A8C611F31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Martin Kepplinger <martin.kepplinger@puri.sm>

[ Upstream commit 1773b8d6697ac8e9380843fe5c13c25e95baa702 ]

This is a workaround for a hardware bug in the r3 revision that basically would
stop the system due to traffic on the i2c1 bus. A cpu voltage change would
trigger such traffic and that's what is avoided in order to work around it.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 511f76bf1dce ("arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
@@ -10,6 +10,12 @@
 	compatible = "purism,librem5r3", "purism,librem5", "fsl,imx8mq";
 };
 
+&a53_opp_table {
+	opp-1000000000 {
+		opp-microvolt = <1000000>;
+	};
+};
+
 &accel_gyro {
 	mount-matrix =  "1",  "0",  "0",
 			"0",  "1",  "0",



