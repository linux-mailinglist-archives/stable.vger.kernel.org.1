Return-Path: <stable+bounces-225054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBEMGHUgs2mpSQAAu9opvQ
	(envelope-from <stable+bounces-225054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:22:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D31FF278E24
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B59FF300F538
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFD8309F1D;
	Thu, 12 Mar 2026 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QXHa1JOE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3033F8A1;
	Thu, 12 Mar 2026 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346775; cv=none; b=Utl2AASADBn9MYXRcYSwpd+kjze9AgWdUfpSIHuIOqYVjHYGVO1LWWUEqtWAe/XsJeXvEKiUH7S0wwApXVqprgIJ2mskZuGLSa7kNu2CFRyR0toOrl7BBXQQthXfCPpKQHc38wMasJgwa7dVh0NYjNBg9BtnbVo4g5j8DeAqOI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346775; c=relaxed/simple;
	bh=6aSl9qaR0U5BpAh58lRyk87ACIiyTZVLArmZoMyZTrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGoApCPcKhSljJhDfZ/aS0lujcbPwDOaxdYA+m3a2adnq5befHtqD01h8b+sohbJPpYHX+jrypvnKogUM6lyoMYNIz1rIH4BU1FAN2LKDOS8peH9faSnYG/FQ24Uto0kJvHzo7U5oTw1y7s/3dLMOpGGnhQdHGNzhbsNJFQFXvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QXHa1JOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5088EC4CEF7;
	Thu, 12 Mar 2026 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346774;
	bh=6aSl9qaR0U5BpAh58lRyk87ACIiyTZVLArmZoMyZTrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QXHa1JOEeJMQMJUKa3RtsuyU2QIybUBLU9TweON1MaS6HTPrVzVgAnuJPwvooOpNO
	 y8P90AIfZWRRAwdxuTg0s/8ApTJI7NyoJatm+QHlTEy3vIycyIB2tjbo67fTir5Mfe
	 KmQ3dDwM9x2FfJgka+HddSwOW2659wbGrVAxpebo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 088/265] ima: kexec: silence RCU list traversal warning
Date: Thu, 12 Mar 2026 21:07:55 +0100
Message-ID: <20260312201021.399423918@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225054-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D31FF278E24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 68af44a71975688b881ea524e2526bb7c7ad0e9a ]

The ima_measurements list is append-only and doesn't require
rcu_read_lock() protection. However, lockdep issues a warning when
traversing RCU lists without the read lock:

  security/integrity/ima/ima_kexec.c:40 RCU-list traversed in non-reader section!!

Fix this by using the variant of list_for_each_entry_rcu() with the last
argument set to true. This tells the RCU subsystem that traversing this
append-only list without the read lock is intentional and safe.

This change silences the lockdep warning while maintaining the correct
semantics for the append-only list traversal.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Stable-dep-of: 10d1c75ed438 ("ima: verify the previous kernel's IMA buffer lies in addressable RAM")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_kexec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 52e00332defed..9d45f4d26f731 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -37,7 +37,8 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+	/* This is an append-only list, no need to hold the RCU read lock */
+	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
 		if (file.count < file.size) {
 			khdr.count++;
 			ima_measurements_show(&file, qe);
-- 
2.51.0




