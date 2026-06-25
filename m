Return-Path: <stable+bounces-268564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LGEHAS83PWrqzAgAu9opvQ
	(envelope-from <stable+bounces-268564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:11:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A786C671A
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 16:11:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eBRSKGfN;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268564-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-268564-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66EAA30762A1
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 14:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C9349CDD;
	Thu, 25 Jun 2026 14:08:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4E33A9C1
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 14:08:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396530; cv=none; b=MJBI/5BQPlRMGs+I3MIlJfs6T3k42ZupnN/0l/5xWPACu4jdxGtpAre4UQrykFm8OBiP5PS2HtWPp3VhO3kwY2FdDRp/wy67mwU8p2Rn/Ef3Odx08v3So2p3XZYn7a11f6z3+YfVf3uctkjpZI0ZjYHa8KEZJ6mIOscu/Ktoysw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396530; c=relaxed/simple;
	bh=e+LB9Ng7AfWE0VrirBnjaMnai5lwWRz2NgjKBBfvq0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnE/uixEJSG22/DgU2jsd5NL5iYF6Rleq+TL9396mX7rWBOuQeP8cN1FxaudEhR6YWdEauFpcTTl1X/8B9cOsZJM4D7vWxY82vt2zHx2SCjX+6T4GRc1OhvdSdP3YiidLBgTxx0fttslQLVdyemZdIHori1Zlpp1If7AsVD4SKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBRSKGfN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823C41F000E9;
	Thu, 25 Jun 2026 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782396529;
	bh=+1Z39oebowKJa8AoRY71b0apZRv9y2iBGu2XE2LPg7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eBRSKGfNBAmSSJj1L6gmn1ydDUJBBWqDBqyCJDtFEkROys3/LWqMTTSi6udlc5IfB
	 xUIuS5QjaCHdLJDOmrIYMnmlsoHvFyJEMv0KblT1mdirPOgM647reRWVR2u7VNaB+I
	 rf5GKR8IsqaRMKT8FQqR2oNDoAh/groSGYsXpEcxYqIOyjoQYIMIfVdvGKSItQrLkC
	 SCEnXQo2Lmx3BC1EC5sanI8+IaLSUtMknrxP7ZqJW/soiP+oineZQkNIsiQeVJ1Wu+
	 /h/RX2fnfWcrsPV3xjBQ1Zldzc93AMymuMsQ4qLDEuJ+WgfXfEWSVg/OvB2nmq2Zhk
	 t7znGCCv0Il1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] Documentation: ioctl-number: Fix linuxppc-dev mailto link
Date: Thu, 25 Jun 2026 10:08:42 -0400
Message-ID: <20260625140846.2431963-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026062532-unpaved-jujitsu-26c1@gregkh>
References: <2026062532-unpaved-jujitsu-26c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268564-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:bagasdotme@gmail.com,m:haren@linux.ibm.com,m:maddy@linux.ibm.com,m:corbet@lwn.net,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,linux.ibm.com,lwn.net,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,ozlabs.org:email,lwn.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92A786C671A

From: Bagas Sanjaya <bagasdotme@gmail.com>

[ Upstream commit 3dfa97bd93614c15418ba7b5c727f6c5bb617174 ]

Spell out full Linux PPC mailing list address like other subsystem
mailing lists listed in the table.

Reviewed-by: Haren Myneni <haren@linux.ibm.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Link: https://lore.kernel.org/r/20250714015711.14525-2-bagasdotme@gmail.com
Stable-dep-of: d237230728c5 ("crypto: qat - remove unused character device and IOCTLs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index e4be1378ba26dc..c6931c4ceb56d9 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -358,9 +358,9 @@ Code  Seq#    Include File                                           Comments
 0xB1  00-1F                                                          PPPoX
                                                                      <mailto:mostrows@styx.uwaterloo.ca>
 0xB2  00     arch/powerpc/include/uapi/asm/papr-vpd.h                powerpc/pseries VPD API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB2  01-02  arch/powerpc/include/uapi/asm/papr-sysparm.h            powerpc/pseries system parameter API
-                                                                     <mailto:linuxppc-dev>
+                                                                     <mailto:linuxppc-dev@lists.ozlabs.org>
 0xB3  00     linux/mmc/ioctl.h
 0xB4  00-0F  linux/gpio.h                                            <mailto:linux-gpio@vger.kernel.org>
 0xB5  00-0F  uapi/linux/rpmsg.h                                      <mailto:linux-remoteproc@vger.kernel.org>
-- 
2.53.0


