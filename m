Return-Path: <stable+bounces-264271-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X2v0H7d0MWoZjwUAu9opvQ
	(envelope-from <stable+bounces-264271-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:07:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3EC691B43
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:07:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=lam7UGXd;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264271-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-264271-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70B9430409E4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999FB44CAE6;
	Tue, 16 Jun 2026 15:51:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7874615B998;
	Tue, 16 Jun 2026 15:51:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625082; cv=none; b=FbmPQkInTaDUWeCvx6RreMs1MQ63S4x0X+KJqPXS63uavxq1QCJ5s9hY/cCv8+lN2ri1nk7Z1QdnITJ6sEtqdv/r+K8D8wYDOweOqO9GscNim7Sc/TQyfUE0oHb2CUeyARWU1ugGzWKmKmyoefm/2rAzJP3TzXx05JPpDH8xJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625082; c=relaxed/simple;
	bh=OPWXm6Nl/H39Sr+fBORkSIFn6eqV6Lt497bNzh1qh40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7tdKc72cee0S2riqTOUDDAVlV1grzMeTCai+CtfQy8QaSD9sS3t+Sl5th5Vz6siYgUjsRmK0nsUeBLjSestyym7bQKDvRwLmORzy/K9qB5MsqyBAg38uuqThkd/vCZMtlkG5YGSBAhD+zD117VeyWvq7baMPv0wDgKEBkH83GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lam7UGXd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3597E1F000E9;
	Tue, 16 Jun 2026 15:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781625081;
	bh=4SN5cdQLQJ7W8QXbaKjc66DI+zGDz288b9DD+zw75n8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lam7UGXdKjVAWSwOXnD6HgZa4M8zHNaHeT8C7bXsXDePoTuJirGlI1tSfkwkQhB/g
	 sSimARkKv6pqCbaTUbpU+LKfwyxqV51S6OyW/toLqoKQKAZAbAVNc7YN4vCbVrmL6Y
	 fbCV5gwnyHzeMfQXkIMdMjmn6uoS2rPA0478imFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dexuan Cui <decui@microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 073/325] hyperv: Clean up and fix the guest ID comment in hvgdk.h
Date: Tue, 16 Jun 2026 20:27:49 +0530
Message-ID: <20260616145101.370121539@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264271-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:decui@microsoft.com,m:hamzamahfooz@linux.microsoft.com,m:wei.liu@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A3EC691B43

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 83eb00f31eb1b10735d48e469df72cc2b0e06f6d ]

Change the "64 bit" to "64-bit", and the "Os" to "OS".

Remove the obsolete paragraph since the guideline has been
published in the Hypervisor Top Level Functional Specification
for many years.

The "OS Type" is 0x1 for Linux, not 0x100.

No functional change.

Fixes: 83ba0c4f3f31 ("Drivers: hv: Cleanup the guest ID computation")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/hyperv/hvgdk.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/hyperv/hvgdk.h b/include/hyperv/hvgdk.h
index dd6d4939ea29b0..a837a6bc1275bd 100644
--- a/include/hyperv/hvgdk.h
+++ b/include/hyperv/hvgdk.h
@@ -10,18 +10,12 @@
 
 /*
  * The guest OS needs to register the guest ID with the hypervisor.
- * The guest ID is a 64 bit entity and the structure of this ID is
+ * The guest ID is a 64-bit entity and the structure of this ID is
  * specified in the Hyper-V TLFS specification.
  *
- * While the current guideline does not specify how Linux guest ID(s)
- * need to be generated, our plan is to publish the guidelines for
- * Linux and other guest operating systems that currently are hosted
- * on Hyper-V. The implementation here conforms to this yet
- * unpublished guidelines.
- *
  * Bit(s)
  * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
- * 62:56 - Os Type; Linux is 0x100
+ * 62:56 - OS Type; Linux is 0x1
  * 55:48 - Distro specific identification
  * 47:16 - Linux kernel version number
  * 15:0  - Distro specific identification
-- 
2.53.0




