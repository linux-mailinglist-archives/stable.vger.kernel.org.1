Return-Path: <stable+bounces-264332-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4SgxCMRyMWp1jgUAu9opvQ
	(envelope-from <stable+bounces-264332-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:59:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9232A691972
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:58:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=U299z58t;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264332-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264332-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C64C231ED133
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912D544D022;
	Tue, 16 Jun 2026 15:55:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6961244D6B2
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:55:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625341; cv=none; b=O3BU6V/0lNbmyJJRs92JWuctZuQAlsiAfrKscnMKOMXzZkVwceXgkTqPELjfQprgSqStZe/V5R8hoZU75vZgfdsmeFakYyWSPwvtnuJJVBNvhOvnx873vWIm2Ni20opMIfb2z8i6RUNe1Nh/4SNP/CMKvaquxRHmua8XtLVwBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625341; c=relaxed/simple;
	bh=FHyn7VEuIK6Tq42xdDfHnfMaLSY5qOQoWiKTDRss06g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U23cbdGqFQQ0vQZP3v0VxwkLJmgvaKNCDVO7ry95YNEgans/CD4Ak94aJifIuMHoJTms2Z47RuHLY2hruMdb7u9IENSrpgwZ+GPsNrFltVEinUZQr2eqi9fJndgKiDzUSNb559/IDRnX4cP9qp3w2vBeonmBU/1CNRZN3H3KEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U299z58t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1BC1F00A3E;
	Tue, 16 Jun 2026 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781625340;
	bh=NoAsVgVwoZg2nUHsuYG4zWtkjhTi4BQDreshzTA75qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U299z58tacFsSoFAqyBlgy8+AZ1q71JXgGCPtfkuSgHDY3lCbXROZxi+GBFC/qKaI
	 1hmtnwhbzk0+lQaJztbvP+pfDZq1bixgkLQiy2MoD0oaZ1tsthpl9SJIegz1anAnX4
	 RUWQ8Q7X5IJVc4J6WHmYd4FH3wB2tGiK87a5meMeUKJpnXxoJoqGthHeNXd8fMFLkc
	 utJ6YR7CmdYLMtOEIs8Fdbn4ASiG1wKQ9Q+/7BWQ1SaETyTu1J4FZosG57XRgEYgYZ
	 H2VvrK6dJeRIvdF/A5GnSv3dEAtIelzkJAYLbmk4/z7DUHG1LL7xfXY9R4sc6hM9tO
	 7Vqxx+VglaKLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Edwin Peer <edwin.peer@broadcom.com>,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] bnxt_en: Modify bnxt_disable_int_sync() to be called more than once.
Date: Tue, 16 Jun 2026 11:55:37 -0400
Message-ID: <20260616155538.3323509-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061544-stony-launder-1952@gregkh>
References: <2026061544-stony-launder-1952@gregkh>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:michael.chan@broadcom.com,m:edwin.peer@broadcom.com,m:vasundhara-v.volam@broadcom.com,m:willemb@google.com,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264332-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,broadcom.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9232A691972

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 38290e37297087f7ea3ef7904b8f185d77c42976 ]

In the event of a fatal firmware error, we want to disable IRQ early
in the recovery sequence.  This change will allow it to be called
safely again as part of the normal shutdown sequence.

Reviewed-by: Edwin Peer <edwin.peer@broadcom.com>
Reviewed-by: Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: d930276f2cdd ("bnxt_en: Fix NULL pointer dereference")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index fd54a194a5e5fe..ff14c44b8f2bb3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4382,6 +4382,9 @@ static void bnxt_disable_int_sync(struct bnxt *bp)
 {
 	int i;
 
+	if (!bp->irq_tbl)
+		return;
+
 	atomic_inc(&bp->intr_sem);
 
 	bnxt_disable_int(bp);
-- 
2.53.0


