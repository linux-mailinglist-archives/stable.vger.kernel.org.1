Return-Path: <stable+bounces-269756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l41qKXtxQmqI7QkAu9opvQ
	(envelope-from <stable+bounces-269756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:22:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8974D6DB1F6
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 15:22:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=npc-ksb.ru (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269756-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269756-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44F41307C7B6
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 13:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2614071D1;
	Mon, 29 Jun 2026 13:09:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.ksb-soft.ru (mail.ksb-soft.ru [5.167.76.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CB03FD946;
	Mon, 29 Jun 2026 13:09:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738577; cv=none; b=bknrIWZSTTgDQIKJ3oW8PvvwQeteL60hmJCv83whlwX2Ay/+nE+JIOaV9zu6vZ0eaSvLBHoDxHd5r9y7PQySvp2ODBJb1a5HiknTV22z1QvrdfFCMmKoaVTHr48DARX6RGOecY0BlshRbuZ+geCBNjIfQ4dp5I8X5t0mw0Rfi8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738577; c=relaxed/simple;
	bh=3CKsRUHSi06eB3PpG2eVo8JqcO7Ixrx6du5JIlx5lHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSKM3dn5B6CAynqf/JkzA5HdBFonEBUoO0T4MQyvS1Lt1zQkFybCVvxGpVeoYEtqIl8XhL8XOVeSx8P32WEd6B811Noy0TYu7voKHcQAOcvTVzUhotZn4uJT+H5RKP5nHH4AzzBJtKc0YPqen/HQFpKTN48WOzNdk6HyPX5C2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=npc-ksb.ru; spf=pass smtp.mailfrom=npc-ksb.ru; arc=none smtp.client-ip=5.167.76.63
Received: from ksb-289.ksb.ksb-soft.ru (unknown [10.38.22.14])
	by mail.ksb-soft.ru (Postfix) with ESMTPA id 4gpmp55Z71z4LKBF;
	Mon, 29 Jun 2026 16:09:33 +0300 (MSK)
From: Markov Gleb <markov.gi@npc-ksb.ru>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Gleb Markov <markov.gi@npc-ksb.ru>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] target: Fix an overwriting of the error status code
Date: Mon, 29 Jun 2026 16:09:30 +0300
Message-ID: <20260629130932.684-1-markov.gi@npc-ksb.ru>
X-Mailer: git-send-email 2.52.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 197590 [Oct 29 2025]
X-KLMS-AntiSpam-Version: 6.1.1.11
X-KLMS-AntiSpam-Envelope-From: markov.gi@npc-ksb.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 72 0.3.72 80ff96170b649fb7ebd1aa4cb544c36c109810bd, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean
X-KLMS-LinksScanning: Clean
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 10.0.0.7427, bases: 2025/10/29 20:57:00 #27800623
X-KLMS-AntiVirus-Status: Clean, skipped
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[npc-ksb.ru : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:markov.gi@npc-ksb.ru,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[markov.gi@npc-ksb.ru,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269756-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[markov.gi@npc-ksb.ru,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,npc-ksb.ru:email,npc-ksb.ru:mid,npc-ksb.ru:from_mime,linuxtesting.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8974D6DB1F6

From: Gleb Markov <markov.gi@npc-ksb.ru>

If the maximum field length is exceeded, the error status code written to
ret will be overwritten without verification, and data with an incorrect
field length will be passed to core_scsi3_alloc_aptpl_registration(),
where it will be truncated by snprintf() to the maximum allowed length,
without "\0", resulting in the use of truncated data.

If pr_reg->pr_reg_isid, pr_reg->pr_iport or pr_reg->pr_tport are passed to
functions such as strlen(), strcmp(), which expect a "\0" at the end, it
will result in a memory access outside the buffer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: c66ac9db8d4a ("[SCSI] target: Add LIO target core v4.0.0-rc6")
Signed-off-by: Gleb Markov <markov.gi@npc-ksb.ru>
---
 drivers/target/target_core_configfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index d93773b3227c..3385d542de62 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -2194,7 +2194,7 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 					" exceeds PR_APTPL_MAX_IPORT_LEN: %d\n",
 					PR_APTPL_MAX_IPORT_LEN);
 				ret = -EINVAL;
-				break;
+				goto out;
 			}
 			break;
 		case Opt_initiator_sid:
@@ -2208,7 +2208,7 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 					"= exceeds PR_REG_ISID_LEN: %d\n",
 					PR_REG_ISID_LEN);
 				ret = -EINVAL;
-				break;
+				goto out;
 			}
 			break;
 		case Opt_sa_res_key:
@@ -2272,7 +2272,7 @@ static ssize_t target_pr_res_aptpl_metadata_store(struct config_item *item,
 					" exceeds PR_APTPL_MAX_TPORT_LEN: %d\n",
 					PR_APTPL_MAX_TPORT_LEN);
 				ret = -EINVAL;
-				break;
+				goto out;
 			}
 			break;
 		case Opt_tpgt:
-- 
2.43.0


