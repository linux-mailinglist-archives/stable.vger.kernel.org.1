Return-Path: <stable+bounces-272976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8ZweAmrET2pZoAIAu9opvQ
	(envelope-from <stable+bounces-272976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 17:55:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A725D7332B6
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 17:55:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=IHemkVMZ;
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272976-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272976-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6572530429A7
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 15:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC75442DA33;
	Thu,  9 Jul 2026 15:55:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.1.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778EE38C2BF;
	Thu,  9 Jul 2026 15:55:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612502; cv=none; b=rH7pCaGKZNYYcSRojPR6K3xpFyBTUUWjcUkwpo548z+C1NKYQP+vN3GSk/eiaHaleN4ojm4a80TW9ykyaAZjFajzVjprX/t1uBTDVPbMTEV6Lxc2m45GcplRHW63cDalm0hWesftcukSa0aNpIbHf9gnbQ13uVg+DblO2HboE2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612502; c=relaxed/simple;
	bh=LuXv6JcJjK6mtDWtLr8zqHDrPXzE0ewOu1aVcFSDNUs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DvBQ3FL0ul7hK83zJ2kP08RZNIs9+JyLSmFmFsE8wSny0h6wzoKd2cpadgPFKhdcfbYHHMYDNV0TO1wAnnRCUWCfzeIjwXXKityXBJhgebkUekT79iiAG7xlRMlr+ql9s+ZZihueXc6tanZXM+1r1kkAH/xm+fkafB8s+zx6ULA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=IHemkVMZ; arc=none smtp.client-ip=44.246.1.125
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783612501; x=1815148501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MS2Fs/jSRohnT1IecYb4b1QrfzuXtM/vLFmi4bLUDYI=;
  b=IHemkVMZ2wSqo1S45ViVESRsdVkkeetkA8hg75kfmdlpLWwm+2HNNwQ1
   bhAQrjocc2RRktTWb8Gc2qCHoxyeK/pMIESOrlfQf7cZMs8xFAyvs5PP/
   dLHFnR2TGCgB90C0Ij6OKTCY3LKB4JypMGCDFHM9L0ijWZKWe2CX1wnb+
   uDmfV9Nypr4u/qcE7+XDhAUn6NQJi1VmWZfkxstJ+PWbln/h2Ev5Y1KP5
   vs1pud3SWFd/0/9ti3drRAouCVMFphMWi6LoXjEsC/Bk8cf0LpXPtikMV
   6TjOnstheHKVnrTaRZJ06eiQtxN53Ade9oIrbTgrcLIoZT6kJiRSkPNvf
   A==;
X-CSE-ConnectionGUID: 3hANjMELRxCK6Tt71+VChA==
X-CSE-MsgGUID: zdHCjPkdQo2DRaNdJAMVuQ==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23385286"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-002.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:54:58 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:14009]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.54:2525] with esmtp (Farcaster)
 id 9e9060b9-9ea4-43a9-8ca2-b1243e68b4ea; Thu, 9 Jul 2026 15:54:58 +0000 (UTC)
X-Farcaster-Flow-ID: 9e9060b9-9ea4-43a9-8ca2-b1243e68b4ea
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 9 Jul 2026 15:54:58 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 9 Jul 2026 15:54:56 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N
	<sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM
	<bharathsm@microsoft.com>, <linux-cifs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <samba-technical@lists.samba.org>
CC: <stable@vger.kernel.org>, <doebel@amazon.de>, <nmanthey@amazon.de>
Subject: [PATCH] smb: client: fix DACL-rewrite heap overflow in id_mode_to_cifs_acl()
Date: Thu, 9 Jul 2026 15:54:38 +0000
Message-ID: <20260709155440.2132459-1-doebel@amazon.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[amazon.de:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272976-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sfrench@samba.org,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:linux-cifs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samba-technical@lists.samba.org,m:stable@vger.kernel.org,m:doebel@amazon.de,m:nmanthey@amazon.de,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com,vger.kernel.org,lists.samba.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[doebel@amazon.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doebel@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amazon.de:from_mime,amazon.de:email,amazon.de:mid,amazon.de:dkim,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A725D7332B6

Budget the destination buffer for the worst case in both branches:
every rewritten ACE may take sizeof(struct smb_ace) bytes (which
already accounts for an smb_sid with SID_MAX_SUB_AUTHORITIES
sub-authorities), plus the smb_acl header that
replace_sids_and_copy_aces() emits.

Fixes: bc3e9dd9d104 ("cifs: Change SIDs in ACEs while transferring file ownership.")
Cc: stable@vger.kernel.org
Signed-off-by: Bjoern Doebel <doebel@amazon.de>
Assisted-by: Kiro:claude-opus-4.6
---
 fs/smb/client/cifsacl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 07cf0e5782337..6d572dd995d79 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -1812,11 +1812,13 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 				cifs_put_tlink(tlink);
 				return rc;
 			}
-			if (mode_from_sid)
-				nsecdesclen +=
-					le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
-			else /* cifsacl */
-				nsecdesclen += le16_to_cpu(dacl_ptr->size);
+			/*
+			 * Worst case: every ACE is rewritten with a new SID of
+			 * SID_MAX_SUB_AUTHORITIES sub-auths -> sizeof(smb_ace) each,
+			 * plus the smb_acl header replace_sids_and_copy_aces() emits.
+			 */
+			nsecdesclen += sizeof(struct smb_acl) +
+				le16_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
 		}
 	}
 
-- 
2.50.1


