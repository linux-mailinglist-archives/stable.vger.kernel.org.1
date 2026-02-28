Return-Path: <stable+bounces-220276-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEkuGgI2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220276-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E6E1C60A7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5748030BB959
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6210736B612;
	Sat, 28 Feb 2026 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCxR/Lsm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985236B60B;
	Sat, 28 Feb 2026 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300180; cv=none; b=J+HGlSMvIIzvWmHUzByh3G9ZtaJaJRfEj1fR/DcphRPoyeDMOhkBIwefNDBhJ8Q8ZF06GNlnNhVVd0vr6JYjMAxj7xfKd9P+K4BQEA4q0EjmbjNfNomdPi593Sem1FatlrfH+QZdNzqyMzuyY6b1yKYXLcf0OjAqbA8eCB/kwG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300180; c=relaxed/simple;
	bh=8LwpH2G/OAuJqAxHNwAbNdqyYAbb/sILHyezwUQKXMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpwf7AWEe3JQyo3vU88Up0tG9r6fEi09EZNHDNo+ReJpWWqVJhxne3FjN7oFkrtqpWjoZaoxjrd9YPxh01RhFos+4/p9axCmBpz9Jz36g0EqlxMw4F+78qnsqJVFDjcA2ISe1ROebDRTB6drlUa3OzhXgNMF9a2qoMXY8b99iS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCxR/Lsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E7CC116D0;
	Sat, 28 Feb 2026 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300180;
	bh=8LwpH2G/OAuJqAxHNwAbNdqyYAbb/sILHyezwUQKXMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eCxR/LsmjBEtKIy7kHRncLfyBTv8rN2cWacmfkpF8ME8gWrX9XEaNP2HD2iVwufyw
	 D12FrRExcXwNRuO31vnOfXFkKaExaFkYjVXn6xAAzx98QQ68NUDl1MAiise5oDBNjZ
	 fmPsvcGgkhX0RT9XfTLNzUwsWFjYJMc8OOP9KDU/YNdfijFHPHItbQ1gKMmn1Ff3t2
	 K+E4pN865vY3MNBsuz9nuIGsOjhC6RI6VCkuXFVNzkXI07JByOLDLd6e+LLIwKJ3PV
	 xwduJZ1win9BSEugc31RGtkFK3Yo7wqq6Lz08BG0/TSRA3Z7PkgxKGQGMf+S0DKevS
	 c1s87QxVyUHIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 198/844] ASoC: soc-acpi-intel-ptl-match: use aggregated endpoint in ptl_rt722_l0_rt1320_l23
Date: Sat, 28 Feb 2026 12:21:51 -0500
Message-ID: <20260228173244.1509663-199-sashal@kernel.org>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220276-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 76E6E1C60A7
X-Rspamd-Action: no action

From: Bard Liao <yung-chuan.liao@linux.intel.com>

[ Upstream commit 4fbd3b2ec04dc6ef93090ec24733a5c5671fb71f ]

The rt722 amp and rt1320 amps are aggregated in this case.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://patch.msgid.link/20260119091749.1752088-3-yung-chuan.liao@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/common/soc-acpi-intel-ptl-match.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index e297c8ecedb72..1055fb4838f61 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -383,6 +383,15 @@ static const struct snd_soc_acpi_link_adr ptl_rt721_l3[] = {
 	{},
 };
 
+static const struct snd_soc_acpi_adr_device rt722_0_agg_adr[] = {
+	{
+		.adr = 0x000030025d072201ull,
+		.num_endpoints = ARRAY_SIZE(jack_amp_g1_dmic_endpoints),
+		.endpoints = jack_amp_g1_dmic_endpoints,
+		.name_prefix = "rt722"
+	}
+};
+
 static const struct snd_soc_acpi_adr_device rt722_0_single_adr[] = {
 	{
 		.adr = 0x000030025d072201ull,
@@ -536,8 +545,8 @@ static const struct snd_soc_acpi_link_adr ptl_rt722_l3[] = {
 static const struct snd_soc_acpi_link_adr ptl_rt722_l0_rt1320_l23[] = {
 	{
 		.mask = BIT(0),
-		.num_adr = ARRAY_SIZE(rt722_0_single_adr),
-		.adr_d = rt722_0_single_adr,
+		.num_adr = ARRAY_SIZE(rt722_0_agg_adr),
+		.adr_d = rt722_0_agg_adr,
 	},
 	{
 		.mask = BIT(2),
-- 
2.51.0


