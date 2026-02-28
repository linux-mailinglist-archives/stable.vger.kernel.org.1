Return-Path: <stable+bounces-220581-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EER1BA0+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220581-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:12:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE191C6AF4
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B74031E670A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4063DEA8A;
	Sat, 28 Feb 2026 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sa7WPEdk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29073DEA82;
	Sat, 28 Feb 2026 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300463; cv=none; b=QMZHojdvOnk8hW3RvGcBIUkn03JvonONpS63nsMD9LDXCAGpdryJEsF49PgnxoG+6o5du0ZiGV4XEvC8o2Hpayg95DMp1JU7CK0g6FmP+4fj0lJlnPCPVGEhrMIlJWs0JTxmiobm30xFXO/hWCL0qf+b4qIvfjhjE13OhlTumZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300463; c=relaxed/simple;
	bh=NRKqTnUJObOPjyQErjImIDJZ46r1K3jPKEhgdD/B0tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThE1gAKkXpkXmDUgyRU0fi/gL0DwZ4PgkUOhs5qs/Bev2IscUeUut3+j3QmgbznisA8Q9L94PBz2aiyi6Up6LDo94C1l8v/J5Up4z0FLkhAzsU5SVMHME8Hundnp/MdHBSXk5ayhynmmVxbvV6ifO6s4fTgs5gxC89zt7bW3C20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sa7WPEdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED124C19424;
	Sat, 28 Feb 2026 17:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300463;
	bh=NRKqTnUJObOPjyQErjImIDJZ46r1K3jPKEhgdD/B0tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sa7WPEdkHOe4P6Cd2PBHDbgQllrW4gruCAHwOex29dsya79vtJmd/4NLcuAZErG2E
	 8jffLrPc73A1m1jBWqLIvxV3wbivg2u6Igd2ejy5cbEOdhk4KpykYjkVrhK92tNEny
	 hvu0zQJvpiCM81FrrXZfsy0uoCWcNWHKk8oZxHHdCRhBumAsKs/MxdO+exXIZC4IIj
	 WssW+5sf5pwAyPcW5feKZCVTuCxNkQtIREpxulh3N/h3otol3hNmTQSWAwP4c4zFDL
	 UUtC8KJJuOFsrZh7Mrw28pKibJE9SQGbUgH++3f5Tyz7qtHYxk5DbUWK4P3+2N6w/0
	 C+46EJPMDyXVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 502/844] dpaa2-switch: validate num_ifs to prevent out-of-bounds write
Date: Sat, 28 Feb 2026 12:26:55 -0500
Message-ID: <20260228173244.1509663-503-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,nxp.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220581-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email,msgid.link:url,nxp.com:email]
X-Rspamd-Queue-Id: 9AE191C6AF4
X-Rspamd-Action: no action

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit 8a5752c6dcc085a3bfc78589925182e4e98468c5 ]

The driver obtains sw_attr.num_ifs from firmware via dpsw_get_attributes()
but never validates it against DPSW_MAX_IF (64). This value controls
iteration in dpaa2_switch_fdb_get_flood_cfg(), which writes port indices
into the fixed-size cfg->if_id[DPSW_MAX_IF] array. When firmware reports
num_ifs >= 64, the loop can write past the array bounds.

Add a bound check for num_ifs in dpaa2_switch_init().

dpaa2_switch_fdb_get_flood_cfg() appends the control interface (port
num_ifs) after all matched ports. When num_ifs == DPSW_MAX_IF and all
ports match the flood filter, the loop fills all 64 slots and the control
interface write overflows by one entry.

The check uses >= because num_ifs == DPSW_MAX_IF is also functionally
broken.

build_if_id_bitmap() silently drops any ID >= 64:
      if (id[i] < DPSW_MAX_IF)
          bmap[id[i] / 64] |= ...

Fixes: 539dda3c5d19 ("staging: dpaa2-switch: properly setup switching domains")
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://patch.msgid.link/SYBPR01MB78812B47B7F0470B617C408AAF74A@SYBPR01MB7881.ausprd01.prod.outlook.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
index 66240c340492c..78e21b46a5ba8 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
@@ -3034,6 +3034,13 @@ static int dpaa2_switch_init(struct fsl_mc_device *sw_dev)
 		goto err_close;
 	}
 
+	if (ethsw->sw_attr.num_ifs >= DPSW_MAX_IF) {
+		dev_err(dev, "DPSW num_ifs %u exceeds max %u\n",
+			ethsw->sw_attr.num_ifs, DPSW_MAX_IF);
+		err = -EINVAL;
+		goto err_close;
+	}
+
 	err = dpsw_get_api_version(ethsw->mc_io, 0,
 				   &ethsw->major,
 				   &ethsw->minor);
-- 
2.51.0


