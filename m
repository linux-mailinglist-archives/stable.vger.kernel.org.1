Return-Path: <stable+bounces-261491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UvYvOwBLJWoqGQIAu9opvQ
	(envelope-from <stable+bounces-261491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:42:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EE464FEC4
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:42:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=PuhELuvp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261491-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-261491-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73001304C047
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25313254A9;
	Sun,  7 Jun 2026 10:39:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A023A212564;
	Sun,  7 Jun 2026 10:39:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828759; cv=none; b=o3bOpiWNH4q/ElKif27UmIT+5A9WFW/KZO4D5aAii3nZY7jz5ha3XYyWWQntXpUFuA7jRI0f/0pNl5glYKPJ4txZGiwFaf19Ad/eMeQamF4/JREKQkEqN2MhVtA+tKMMdlZrRgHzvRu8V6VscF9PYpaHOBjWAfl5x4jI/qkj/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828759; c=relaxed/simple;
	bh=F2PQ7SRML4egY9v1teQGMsaipWQ8lIC5M0guJ7Jmseg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYJvRHWUi588uCK2F7SoDsAaegKMJvVLR+CpBMbxwEogWtYb1jwXsR46YsbAmTePGvcmrU5NH3b7x5oRlJ617KDSpCnrnN827dytjLixd9tnROtfBnLPdOyzvEgnvkSNE/bC562aSDD2TiX78BaZGyLHTKLbRfYnLBRxb1PMvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PuhELuvp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20751F00893;
	Sun,  7 Jun 2026 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828758;
	bh=i2fQr/RuZBgGOlvHIrAsBb8Npkv1bG/lxiPWZRhzfs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PuhELuvp2TM2lfbzYPhyi8jAOIfVuFKHzdHDJv+wE5mKL5RjWrvcvF3oeBXehPMLP
	 eZZeW7hlrQkD2vPwRhYRBbCL4npOtlldI7AS56FkUUWY+ao/20sEmLln7Lm3nhm7bc
	 6sO4rtG2k7cm/oNM2raJ4QcFjeg/6tPzPD4HABvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>
Subject: [PATCH 6.12 140/307] hpfs: fix a crash if hpfs_map_dnode_bitmap fails
Date: Sun,  7 Jun 2026 11:58:57 +0200
Message-ID: <20260607095732.872941711@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261491-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mpatocka@redhat.com,m:farhad.alemi@berkeley.edu,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,berkeley.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41EE464FEC4

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 974820a59efde7c1a7e1260bcfe9bb81f833cc9f upstream.

If hpfs_map_dnode_bitmap fails, the code would call hpfs_brelse4 on
uninitialized quad buffer head, causing a crash.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/hpfs/alloc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/hpfs/alloc.c
+++ b/fs/hpfs/alloc.c
@@ -372,8 +372,8 @@ int hpfs_check_free_dnodes(struct super_
 				return 0;
 			}
 		}
+		hpfs_brelse4(&qbh);
 	}
-	hpfs_brelse4(&qbh);
 	i = 0;
 	if (hpfs_sb(s)->sb_c_bitmap != -1) {
 		bmp = hpfs_map_bitmap(s, b, &qbh, "chkdn1");



