Return-Path: <stable+bounces-210994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPmUMmEvcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-210994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:56:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 414585CA84
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CDBFA84B10
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39E0366572;
	Wed, 21 Jan 2026 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1ub2OrDr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158B237E31E;
	Wed, 21 Jan 2026 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020080; cv=none; b=SjFxfF+5Bym1i1PSGP6+EMGGnCVncQTtQA2uNcOe6XX6+bqiSw0xjcou2ELLGMDkfvvQTdhDwCVILjAkcOCEilxQiDW0Lleeg31MFFkj87a8mwbjTsRthTJRu6D1RnJYfN3eojrtqjqkv392wLOmtdPdMKCJNofpmb8utKmN2Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020080; c=relaxed/simple;
	bh=KeTYk3xEg+FL4z9mNvZTe5M6hbHPu2zyi5Bgo5FMy+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7L58kUrwF+Cacs1MaDt1zRb2j1gkdDUuinaLcDHXAbM0WGYGhhq91eHuFPZQGdPz2jzSHQLs9wxrHp+tqx2SlU8xO7zKhCUgYnPsXnSLuqVlem/DTAAp7p1ZxPgLzaFnRebg12HqAUYL9XQd7W0AqYOfxyWN7gaDcorqq83yjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1ub2OrDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46108C4CEF1;
	Wed, 21 Jan 2026 18:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020079;
	bh=KeTYk3xEg+FL4z9mNvZTe5M6hbHPu2zyi5Bgo5FMy+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1ub2OrDrQRXNQSEmQlQ5SrbnSOX2KJypGLy/whTcKWeYSUjcKk4uZZgJKCICTFEdV
	 M3Hr/PiJ6mGY0feZx0AeqKnUMWMYLc4lJWxvUvdwVsSHh1JH/VCRej5JdrF8fEj+o6
	 SWyhZogGeuuNky+4J86OAxVdIGJLPH2KiAVPl/Zo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nimrod Oren <noren@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 053/198] selftests: drv-net: fix RPS mask handling for high CPU numbers
Date: Wed, 21 Jan 2026 19:14:41 +0100
Message-ID: <20260121181420.462963296@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	RCVD_COUNT_THREE(0.00)[4];
	URIBL_MULTI_FAIL(0.00)[dfw.mirrors.kernel.org:server fail,linuxfoundation.org:server fail,msgid.link:server fail,nvidia.com:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210994-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,nvidia.com:email,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 414585CA84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gal Pressman <gal@nvidia.com>

[ Upstream commit cf055f8c000445aa688c53a706ef4f580818eedb ]

The RPS bitmask bounds check uses ~(RPS_MAX_CPUS - 1) which equals ~15 =
0xfff0, only allowing CPUs 0-3.

Change the mask to ~((1UL << RPS_MAX_CPUS) - 1) = ~0xffff to allow CPUs
0-15.

Fixes: 5ebfb4cc3048 ("selftests/net: toeplitz test")
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260112173715.384843-3-gal@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/toeplitz.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/toeplitz.c b/tools/testing/selftests/net/toeplitz.c
index 9ba03164d73a6..5099157f01b9a 100644
--- a/tools/testing/selftests/net/toeplitz.c
+++ b/tools/testing/selftests/net/toeplitz.c
@@ -473,8 +473,8 @@ static void parse_rps_bitmap(const char *arg)
 
 	bitmap = strtoul(arg, NULL, 0);
 
-	if (bitmap & ~(RPS_MAX_CPUS - 1))
-		error(1, 0, "rps bitmap 0x%lx out of bounds 0..%lu",
+	if (bitmap & ~((1UL << RPS_MAX_CPUS) - 1))
+		error(1, 0, "rps bitmap 0x%lx out of bounds, max cpu %lu",
 		      bitmap, RPS_MAX_CPUS - 1);
 
 	for (i = 0; i < RPS_MAX_CPUS; i++)
-- 
2.51.0




