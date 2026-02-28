Return-Path: <stable+bounces-220296-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFzAC3o0o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220296-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FCF1C5E62
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 619E632D8355
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8EF388ED8;
	Sat, 28 Feb 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et7cVMy1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E3388ECD;
	Sat, 28 Feb 2026 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300199; cv=none; b=n9Qo7n32Bi/kbz+G/ap1jrKZFicElKSwJgcImxe11o6D8ip6mpr+7X6+La5V2VNL1aHK6+uyez6N3aZw0TzdErfYJ/fG33nRapgV0FZjOG88nYFIyFtfUl8XfoTPutGRO/1OpTgns8nLxOa3mFiBC8w8DWq+KxLGd638tPJ7Hrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300199; c=relaxed/simple;
	bh=QBh4SxHLt1xI6PMRW4JLJQxEAh+26aoB97GHXl5dVXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxcycj1K3+uYY6eUzRs3vX8Hu7veYVbd68F+8WwG0993zMOx0SQTEoAEATcMIc65oGVHS6DmBZMZoQYBdMCGsEVfQaKZre1eC/vc6XkK6t6OSPQzHISpP8BwX/aPfmBlbY/OAUbIlgDcVtGCgPB/2RtfXpGWVQ1zI8PlDMPuehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et7cVMy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25369C19423;
	Sat, 28 Feb 2026 17:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300199;
	bh=QBh4SxHLt1xI6PMRW4JLJQxEAh+26aoB97GHXl5dVXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=et7cVMy1T8TBu08dg1bodKi+XgxsNa5fJAx91XSAeh0wCicIQWgkW8m4JTZtjvcty
	 9cGaFAreQpDwnfTmGKWWG4N98MUy2JGYMSZXDmRNONEExRuYq+8biBKZ45TI1ZOhvc
	 R0EYQWmu/BFPuJVwWVLpfXl3xw3iN96D/iC92wq2Kr0e2oA8dHN6fti96rq01UX6uj
	 z6pQ36yIhzSEXy8lfT7C8CPM8NwT+kWqirat1jICmZjrwrjvmumcE3yO6T1XP3yzKZ
	 K82HtkNOjbzP5NWtNsurBaTNz0VeLpzgvn9ax1ZfkG8KWulvriJE45namy1QhAv012
	 0tUBFCdXSuBlw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 218/844] ASoC: sunxi: sun50i-dmic: Add missing check for devm_regmap_init_mmio
Date: Sat, 28 Feb 2026 12:22:11 -0500
Message-ID: <20260228173244.1509663-219-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220296-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 86FCF1C5E62
X-Rspamd-Action: no action

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit 74823db9ba2e13f3ec007b354759b3d8125e462c ]

Add check for the return value of devm_regmap_init_mmio() and return the
error if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Link: https://patch.msgid.link/20260127033250.2044608-1-nichen@iscas.ac.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun50i-dmic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sunxi/sun50i-dmic.c b/sound/soc/sunxi/sun50i-dmic.c
index bab1e29c99887..eddfebe166169 100644
--- a/sound/soc/sunxi/sun50i-dmic.c
+++ b/sound/soc/sunxi/sun50i-dmic.c
@@ -358,6 +358,9 @@ static int sun50i_dmic_probe(struct platform_device *pdev)
 
 	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					     &sun50i_dmic_regmap_config);
+	if (IS_ERR(host->regmap))
+		return dev_err_probe(&pdev->dev, PTR_ERR(host->regmap),
+				     "failed to initialise regmap\n");
 
 	/* Clocks */
 	host->bus_clk = devm_clk_get(&pdev->dev, "bus");
-- 
2.51.0


