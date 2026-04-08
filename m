Return-Path: <stable+bounces-234552-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPUbEWKj1mlUGwgAu9opvQ
	(envelope-from <stable+bounces-234552-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:50:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B22623C1B59
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 014DA30A3038
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3813624B0;
	Wed,  8 Apr 2026 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PD1EqoGo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE5D32A3FD;
	Wed,  8 Apr 2026 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673155; cv=none; b=uNHHVzcqyF/B2GySesKnEed0n5ixuIRDEhDYAMKuycMcH5UVj6w8Ronkp0eTZi8P9C7YNwWPC9t1jwXlQViEkk9gUnoRNMdeQEoT5Fsh8upE2WnB4HUy2zM5SRn9w34ir1sIy2POZZgQquicBD0f/RprxT2CGTXLjSbqiKxWJDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673155; c=relaxed/simple;
	bh=mpsGMFqTwBY58JILboCXaJLCdl5VNXLfd4V/B5n6u/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYsxj+V7VJUSF1iXf6nWBxMjGcSjvJHmEwB9E9dF2Cn+fR27qx0+fO1o/iwcE31NhCbXVgRBRSkLL3Zz07/NN5mStgnyEmNmb62vR0bdr/H5zNYwxkujggQ/qUjzuDtkzhP13G+gZ6zv/+EbUW77X0I2WUCmyL1KsgvS548U7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PD1EqoGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA535C19421;
	Wed,  8 Apr 2026 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673155;
	bh=mpsGMFqTwBY58JILboCXaJLCdl5VNXLfd4V/B5n6u/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PD1EqoGomBXODAAI06mEnW3XLyC1If1ao50C0/n3d6Y1yN+3DapVFtzBsNWTW1fAc
	 CrM4FCZ+a8Wl49dEHW6AwK1+PHM5EQNvan2BfvA5mqWzIKbYTGCLJZZmFpqjQkbfa0
	 rNLNi2eC8UehFcA2YhmM32761wPZJrD+NHuLlZy8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>,
	Shiji Yang <yangshiji66@outlook.com>,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 123/277] mips: ralink: update CPU clock index
Date: Wed,  8 Apr 2026 20:01:48 +0200
Message-ID: <20260408175938.467340847@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.836769063@linuxfoundation.org>
References: <20260408175933.836769063@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-234552-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,yahoo.com,outlook.com,gmail.com,alpha.franken.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,franken.de:email]
X-Rspamd-Queue-Id: B22623C1B59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shiji Yang <yangshiji66@outlook.com>

[ Upstream commit 43985a62bab9d35e5e9af41118ce2f44c01b97d2 ]

Update CPU clock index to match the clock driver changes.

Fixes: d34db686a3d7 ("clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs")
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/ralink/clk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/ralink/clk.c b/arch/mips/ralink/clk.c
index 9db73fcac522e..5c1eb46ef5d07 100644
--- a/arch/mips/ralink/clk.c
+++ b/arch/mips/ralink/clk.c
@@ -21,16 +21,16 @@ static const char *clk_cpu(int *idx)
 {
 	switch (ralink_soc) {
 	case RT2880_SOC:
-		*idx = 0;
+		*idx = 1;
 		return "ralink,rt2880-sysc";
 	case RT3883_SOC:
-		*idx = 0;
+		*idx = 1;
 		return "ralink,rt3883-sysc";
 	case RT305X_SOC_RT3050:
-		*idx = 0;
+		*idx = 1;
 		return "ralink,rt3050-sysc";
 	case RT305X_SOC_RT3052:
-		*idx = 0;
+		*idx = 1;
 		return "ralink,rt3052-sysc";
 	case RT305X_SOC_RT3350:
 		*idx = 1;
-- 
2.53.0




