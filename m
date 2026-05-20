Return-Path: <stable+bounces-251827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yM0jI0r8DWru5AUAu9opvQ
	(envelope-from <stable+bounces-251827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:24:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF2596067
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79DD13687F82
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F963ED5C8;
	Wed, 20 May 2026 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gcab69bh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36AD3EDACC;
	Wed, 20 May 2026 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298992; cv=none; b=oL75pBNLDTB/EXdwqNYd0ae7j31I4beSOgqvDSk9d3unpnUE0klQAoHA3hq/g1tD6UpzgpxkXluOHuGtSpqkgW2vBxM1VDz2gHpsW7I5YhtkXH8DS/fsC36thTvVan151oC4IHkaj75lj0XE67z2SYwoHRXovvV5WGq2Hjf5kqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298992; c=relaxed/simple;
	bh=h4WyGgBazxHcUGs9QLC9KkG9n70xGtytQQWaR714Su8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjidRkdxlrFUnuFlq8MejAPPMZnJlocxFdcPJQj4hrPI+chPbU1eUutFp+Ik1i/pVmil8LhBYtGTdLSz6JofYiOncRpZRtSU0pxH4/h7P4bgZQHkFrYhCcJBNgRQe8peA0R0q8PCD3O/rZ11iKpZ0KdBZEeZRQWQd9yLp4vg0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gcab69bh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFED1F000E9;
	Wed, 20 May 2026 17:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298990;
	bh=/NdUEoC2MY9oiS1BUYCbYxQ4iIn+TdEtuN0gqcjW7do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gcab69bhdCLDay0m2SiMgPpKq5jUQOrL7ZaMsDgu+MdXz1F48abKzFPrrtUu/HBPo
	 JtR0gUSZTaTAz1kcG1AD8BroWsIvTprwcu673eoVmsfevqPXqfskdSWctSTQ3Lc/MD
	 5h4hjsPwNIzF//rocFEQuKxIXDNf97Y1+4ex5JHg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shuwei Wu <shuwei.wu@mailbox.org>,
	Yixun Lan <dlan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 580/957] clk: spacemit: ccu_mix: fix inverted condition in ccu_mix_trigger_fc()
Date: Wed, 20 May 2026 18:17:43 +0200
Message-ID: <20260520162147.109025023@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251827-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 15CF2596067
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuwei Wu <shuwei.wu@mailbox.org>

[ Upstream commit 54e97360b44bed6b4399dd3be3d65f392df940fa ]

Fix inverted condition that skips frequency change trigger,
causing kernel panics during cpufreq scaling.

Fixes: 1b72c59db0ad ("clk: spacemit: Add clock support for SpacemiT K1 SoC")
Signed-off-by: Shuwei Wu <shuwei.wu@mailbox.org>
Reviewed-by: Yixun Lan <dlan@kernel.org>
Link: https://lore.kernel.org/r/20260305-k1-clk-fix-v1-1-abca85d6e266@mailbox.org
Signed-off-by: Yixun Lan <dlan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/spacemit/ccu_mix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spacemit/ccu_mix.c b/drivers/clk/spacemit/ccu_mix.c
index 67f8b12b4f5b7..9a3fc9ea1ce56 100644
--- a/drivers/clk/spacemit/ccu_mix.c
+++ b/drivers/clk/spacemit/ccu_mix.c
@@ -69,7 +69,7 @@ static int ccu_mix_trigger_fc(struct clk_hw *hw)
 	struct ccu_common *common = hw_to_ccu_common(hw);
 	unsigned int val;
 
-	if (common->reg_fc)
+	if (!common->reg_fc)
 		return 0;
 
 	ccu_update(common, fc, common->mask_fc, common->mask_fc);
-- 
2.53.0




