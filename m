Return-Path: <stable+bounces-255938-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGrFIVmnGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255938-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC3E5F91A0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33FA630074B8
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A73632ED5C;
	Thu, 28 May 2026 20:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2MccIRa/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77874223328;
	Thu, 28 May 2026 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000300; cv=none; b=KEvnbwl6CLqfqAnuNAQ8YWZSJjbydpba1qHfb9ByPSPY6PFsTamlrw5All67kol0boqVBElUR6/Tmf+bBHekPLB/qfVchTmxcHPcDtUP6w+TpALJCzUwB/cB+yCpqrW1xeqPZ2miVBwuXpEAEimtkL7lDRPbpxF5tckNeltczJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000300; c=relaxed/simple;
	bh=WBou93JiZR5cssQFaHJ7NhcMM4N2Gn7VPr912Q5JZ2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTDbWNZNuXVx2HNHJ8u/lV+R1wqoPLV5PCKZnU3T/5XndpI5r2AUdvOPJTe+cliNYDNnQWxZ8VVK+SbT/JuVF/Zyc4CpiYux+9WxolX/tzOgszhIMueicGYYSMlNSEIwwUXA5LFTDzWKojN4bMaiXACQPCyIP/hTqg7NDe73Mss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2MccIRa/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8892D1F000E9;
	Thu, 28 May 2026 20:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000299;
	bh=1HEi/oUb3CWW9RkkZkdF7sDygnJVnMXzR31OS1OPzPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2MccIRa/ChLHprpqcNWWHW0W4AWkTd5lXaUPgwaVMC72z+qSgAlm/aUTzTmU1xz87
	 pzZiRXGYqX0w97dOcseYsjPaWid2HdnQJR2VrpRWt54hX6C7ezfkBEnINQfE0NRnXd
	 jHL6NSOe7wngTFAaNraza1wobPefH4HzF3s6SWu4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Nikhil P. Rao" <nikhil.rao@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 373/377] pds_core: ensure null-termination for firmware version strings
Date: Thu, 28 May 2026 21:50:11 +0200
Message-ID: <20260528194649.231164086@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255938-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,amd.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2AC3E5F91A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikhil P. Rao <nikhil.rao@amd.com>

[ Upstream commit 3d4432d34c1992701289cbe12df9fd024f315998 ]

The driver passes fw_version directly to devlink_info_version_stored_put()
without ensuring null-termination. While current firmware null-terminates
these strings, the driver should not rely on this behavior. Add explicit
null-termination to prevent potential issues if firmware behavior changes.

Fixes: 45d76f492938 ("pds_core: set up device and adminq")
Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
Link: https://patch.msgid.link/20260520205842.1486718-1-nikhil.rao@amd.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amd/pds_core/devlink.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
index d8dc39da4161f..621791a3c543b 100644
--- a/drivers/net/ethernet/amd/pds_core/devlink.c
+++ b/drivers/net/ethernet/amd/pds_core/devlink.c
@@ -121,12 +121,14 @@ int pdsc_dl_info_get(struct devlink *dl, struct devlink_info_req *req,
 
 	listlen = min(fw_list.num_fw_slots, ARRAY_SIZE(fw_list.fw_names));
 	for (i = 0; i < listlen; i++) {
+		char *fw_ver = fw_list.fw_names[i].fw_version;
+
 		if (i < ARRAY_SIZE(fw_slotnames))
 			strscpy(buf, fw_slotnames[i], sizeof(buf));
 		else
 			snprintf(buf, sizeof(buf), "fw.slot_%d", i);
-		err = devlink_info_version_stored_put(req, buf,
-						      fw_list.fw_names[i].fw_version);
+		fw_ver[sizeof(fw_list.fw_names[i].fw_version) - 1] = '\0';
+		err = devlink_info_version_stored_put(req, buf, fw_ver);
 		if (err)
 			return err;
 	}
-- 
2.53.0




