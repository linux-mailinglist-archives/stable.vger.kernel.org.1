Return-Path: <stable+bounces-272977-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 61JlJtDGT2ruoAIAu9opvQ
	(envelope-from <stable+bounces-272977-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 18:05:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050D3733460
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 18:05:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.de header.s=amazoncorp2 header.b=jRjuQk4i;
	dmarc=pass (policy=quarantine) header.from=amazon.de;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272977-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272977-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79E5730027A4
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 15:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0FC42EEA9;
	Thu,  9 Jul 2026 15:55:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E157742DA3F;
	Thu,  9 Jul 2026 15:55:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612504; cv=none; b=rkeqFw/b3rFU7tXZwC/j5m9Bytb5hFf+L5YwBjVuHvt03Y1/NX5dEwHNR0YjoilR901s5MoghP//3rWoNYDOzsI2Ch8YqSnNhP4iNFkIsKvVeRmlZ/b3XcYey+7MQx+KS9JkbGz+fBy6YlzC5r6dHM9WHOYvr7ODzgMds3zrnoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612504; c=relaxed/simple;
	bh=2UY2hwRLYLB8e7f2GFLkUci/X38S6EIiBO8keiN69do=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ag4B9feWmCcdt5Q/5rkXlWWGkHzHz51KB9AFyJ5jInWc4crw4b00XyInY6/4ahPtsk48GQpki5bFvz6MvnsEhBhkE9vP0UlNW1HgG5Av96yrUhm3OjNJsr2pYzpy7aHZTKV1SfihoBimbs65JC+Giq/PtPgUv1nhI7ws66zQnYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=jRjuQk4i; arc=none smtp.client-ip=52.35.192.45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1783612502; x=1815148502;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vE946ASmE2lxBNc96IRvRBu3IlQiGEZOj0kMnret4Sc=;
  b=jRjuQk4iTprYMBXgmyBtS0qxUCEg4ZKzGNoPu+s4NPhFLxpL+bb1mqlt
   cs7SlaVNoeKtiby584u7Yv6J1d0ZF6XdIQDEQVhTFnr/TamdxmKTTDlpN
   gsaNgdXeWEmBsRUOdaxLxdBDo6lxXUJQ/Cm+9+3M3WOK6isU6cn+sHXeY
   Hk82icOG6xgNPZQ3Z2TPTzhILUCTNEOSQZjmifY9t/QSPqUoUhjNsx8e0
   6hHywuimhbun0v/f9Z0eYLI4MafG1zrSl+Bql5oxKTHUFXd5YD0fJMZnt
   lxhMx5G6QsUJEeWqAccs43wJaW3vtz0yLPUmHkucadOAtKnNBGFjwgQ/g
   w==;
X-CSE-ConnectionGUID: nDKJE0QKQxSZE7qfHZmrVA==
X-CSE-MsgGUID: KLHiNLcqRX6rcpT1ULBUwA==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23149231"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 15:54:59 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:9716]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525] with esmtp (Farcaster)
 id eeb7f2e3-3e92-4c26-aca1-9580d5f33a8f; Thu, 9 Jul 2026 15:54:59 +0000 (UTC)
X-Farcaster-Flow-ID: eeb7f2e3-3e92-4c26-aca1-9580d5f33a8f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 9 Jul 2026 15:54:59 +0000
Received: from dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com (10.169.119.5)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Thu, 9 Jul 2026 15:54:58 +0000
From: Bjoern Doebel <doebel@amazon.de>
To: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N
	<sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM
	<bharathsm@microsoft.com>, <linux-cifs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <samba-technical@lists.samba.org>
CC: <stable@vger.kernel.org>, <doebel@amazon.de>, <nmanthey@amazon.de>
Subject: [PATCH] smb: client: mask server-provided mode to 07777 in modefromsid
Date: Thu, 9 Jul 2026 15:54:39 +0000
Message-ID: <20260709155440.2132459-2-doebel@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272977-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amazon.de:from_mime,amazon.de:email,amazon.de:mid,amazon.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 050D3733460

From: Norbert Manthey <nmanthey@amazon.de>

When modefromsid is active, parse_dacl() applies the server-provided
sub_auth[2] value from the NFS mode SID to cf_mode without masking to
07777. Apply the correct masking, same as in the read path.

Fixes: e2f8fbfb8d09c ("cifs: get mode bits from special sid on stat")
Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
Assisted-by: Kiro:claude-opus-4.6
Cc: stable@vger.kernel.org
---
 fs/smb/client/cifsacl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 6d572dd995d79..a0a68404fbff7 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -962,7 +962,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 				 */
 				fattr->cf_mode &= ~07777;
 				fattr->cf_mode |=
-					le32_to_cpu(ppace[i]->sid.sub_auth[2]);
+					le32_to_cpu(ppace[i]->sid.sub_auth[2]) & 07777;
 				break;
 			} else {
 				if (compare_sids(&(ppace[i]->sid), pownersid) == 0) {
-- 
2.50.1


