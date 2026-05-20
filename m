Return-Path: <stable+bounces-252271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FCqMKH7DWoK5QUAu9opvQ
	(envelope-from <stable+bounces-252271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD73595E05
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0446630A5809
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9A3E95A4;
	Wed, 20 May 2026 18:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ycaWkj3e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA657371CEA;
	Wed, 20 May 2026 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300239; cv=none; b=lot0JT/F7k8bPb0nwZNlsTttHKZoS5tYTVEY1KI6brqtTKD2DlSyjs7a9Z1DYRbm0HqRln7sQ6IzvdC4dxjUqVGp5GagsaP5P38BZ98qKT4hOe2JiwG3Id4XfgveuFaa/mESxBEZHFW7cUGNaWsCKm4g5lpQPFd4HP6RK5MZCrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300239; c=relaxed/simple;
	bh=0IDP+AtUzey/Vp9j36YQ+6jOUiUm54CqjUE4MosTB6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcaydwHwONlupknjNMthk9lbezM2lGgypndZumnMoW5PEhcjWxk7NSLyd/354GBPVmccCGa5zmt+VgLhW3rCFn+q5cGFoF5bCMNos7mQ1DV6aAuY0lv6dj+hDIqBKSykFyinZQ9Zayf1P2Jp5/FJ33oEbfhbSBZVSr5IRnpgvDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ycaWkj3e; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDA61F000E9;
	Wed, 20 May 2026 18:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300237;
	bh=LrLmIwtsOHXblShu5FrAzz66iwFg1voL64xqh6msHCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ycaWkj3eKlUvHVIwWxvQ+Si1QSritIk7K12VtddbHsXxyl/QskTn3unUEFkdd5ob1
	 UF1vV9afr2xIBVLlwskOc0ysYUIYVYvsoBSJLtzqnVTheDrJE7DE+o3Tj6NaLgrPLJ
	 0jE8EQYgmq2wdpEm/G2HWdnBd2at7ErOVm1gRDCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca.weiss@fairphone.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 099/666] net: ipa: Fix programming of QTIME_TIMESTAMP_CFG
Date: Wed, 20 May 2026 18:15:10 +0200
Message-ID: <20260520162113.369435259@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252271-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,msgid.link:url,sashiko.dev:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,fairphone.com:email]
X-Rspamd-Queue-Id: 6BD73595E05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit de08f9585692813bd41ee654fca0487664c4de30 ]

The 'val' variable gets overwritten multiple times, discarding previous
values. Looking at the git log shows these should be combined with |=
instead.

Fixes: 9265a4f0f0b4 ("net: ipa: define even more IPA register fields")
Link: https://sashiko.dev/#/patchset/20260403-milos-ipa-v1-0-01e9e4e03d3e%40fairphone.com?part=4
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://patch.msgid.link/20260409-ipa-fixes-v1-1-a817c30678ac@fairphone.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipa/ipa_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 5f3dd5a2dcf46..f374a590d1c5e 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -361,7 +361,7 @@ static void ipa_qtime_config(struct ipa *ipa)
 {
 	const struct reg *reg;
 	u32 offset;
-	u32 val;
+	u32 val = 0;
 
 	/* Timer clock divider must be disabled when we change the rate */
 	reg = ipa_reg(ipa, TIMERS_XO_CLK_DIV_CFG);
@@ -374,8 +374,8 @@ static void ipa_qtime_config(struct ipa *ipa)
 		val |= reg_bit(reg, DPL_TIMESTAMP_SEL);
 	}
 	/* Configure tag and NAT Qtime timestamp resolution as well */
-	val = reg_encode(reg, TAG_TIMESTAMP_LSB, TAG_TIMESTAMP_SHIFT);
-	val = reg_encode(reg, NAT_TIMESTAMP_LSB, NAT_TIMESTAMP_SHIFT);
+	val |= reg_encode(reg, TAG_TIMESTAMP_LSB, TAG_TIMESTAMP_SHIFT);
+	val |= reg_encode(reg, NAT_TIMESTAMP_LSB, NAT_TIMESTAMP_SHIFT);
 
 	iowrite32(val, ipa->reg_virt + reg_offset(reg));
 
-- 
2.53.0




