Return-Path: <stable+bounces-236120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOdHNssF3WkZZAkAu9opvQ
	(envelope-from <stable+bounces-236120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCA23EDAA7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 17:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A47BD301C5B3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE71A3B95E4;
	Mon, 13 Apr 2026 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJZ8s674"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25293B774B
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092286; cv=none; b=hNNkUMIEVjYF7lrbILdcrF2m2LZDsm1QbRraos2eJtBaAp/ZShNjvuUlYlmbUwTZx30vfUAcAxpeRsinUwJ+BwI5OsvgOHORf9cdvXD4fsm6SNiKnMMXvocrkLBXnJpwAW5QZsjaW3oiz2gr9eJjEIuHgS0QObJXeP6wUjOXFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092286; c=relaxed/simple;
	bh=E9ohNMj5R/r/58D/JLpDJ+ZaJ6bgO40183uua+xIBi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPUCR0Vg9ecfGEbEeQrHtmBanOOelJhCOdj/KuVTV1Tl49HceFnmYUloUJmdsGT1T2FXgAZk2u43HXA+Cix10NGmdBTL0CkO4v0R0oabgEvq+L1wU0Wd9gtn9kibibK/ZmhPbwnOuacoQWlh56GTXiPYyE31pA+leOIOmE9MRbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJZ8s674; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF21C2BCB0;
	Mon, 13 Apr 2026 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776092286;
	bh=E9ohNMj5R/r/58D/JLpDJ+ZaJ6bgO40183uua+xIBi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJZ8s674xh4EcKs/kfnwFdLItgG6on2vJ5AEQx0ZFMET6+MuxCxrxdRMoY/Gtg/An
	 9LkamNksK3hlYZV0UDrsN+/omuU+/NeRavg5HmrJzNTY5UAWaq5y24p4d5aJYD+KSN
	 fqokrzjKkPBbIuV8xmy4u05O4YobT8E05xLYVpfiJs4PSy3uNsLrq4YuJreiuwQ20o
	 fqAhagO1n+LiCBH5ZBc4/6GQVOjOM4f1qn6czfRfYCGTMU5KE6HrwkLl+ojFuT0yQK
	 z6YynO36GVLRT3QxmbXaL7c3/S4pD+34QWdQkDSqMtkBZSOmg1BXb9O38CFFD3gqo6
	 Y7U8dcnWS9C7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Martin Kepplinger <martin.kepplinger@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/7] arm64: dts: imx8mq-librem5-r3: workaround i2c1 issue with 1GHz cpu voltage
Date: Mon, 13 Apr 2026 10:57:58 -0400
Message-ID: <20260413145804.2968471-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026041310-reluctant-amaretto-6070@gregkh>
References: <2026041310-reluctant-amaretto-6070@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236120-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,puri.sm:email]
X-Rspamd-Queue-Id: 2BCA23EDAA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin Kepplinger <martin.kepplinger@puri.sm>

[ Upstream commit 1773b8d6697ac8e9380843fe5c13c25e95baa702 ]

This is a workaround for a hardware bug in the r3 revision that basically would
stop the system due to traffic on the i2c1 bus. A cpu voltage change would
trigger such traffic and that's what is avoided in order to work around it.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 511f76bf1dce ("arm64: dts: imx8mq-librem5: Bump BUCK1 suspend voltage up to 0.85V")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
index cc29223ca188c..cd3c3edd48fa3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
@@ -10,6 +10,12 @@ / {
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
-- 
2.53.0


