Return-Path: <stable+bounces-219115-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEmGBkNZnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-219115-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:06:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44337190900
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 36F69314BED6
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3C824337B;
	Wed, 25 Feb 2026 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA2ae4gS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41B1FC7
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 01:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984162; cv=none; b=gmRlc2U/EtpOh1vlABJbY06hp2EY6eKGJeBC1YnI2t79xEgaieh+JFg0PqZSGxjV1gdmaD6KSJc8Fta9zUTXXsphozmy4KNMg+arffcLxCknYKghsRnHBgJH1je9VujL2EHrjF9JFD9dVKjOhVWsmpRR0niSraIVtYVn1XZfz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984162; c=relaxed/simple;
	bh=rUX/K6KAxKJu81nmW960q3ODpIstJEA6r4ipi446aY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sD5vL2eoKtF7h7+RndC/KJ8FUDPepojcQNm9sLjDURmdfdfxq2f/nEEocJe1a/LaLtj2RDGgYLr3tGw3lg7W+PU3Z3f3NDnMKjwRB4O8Z0E9eGVfkcthac0TheuuPF25mhdv+3Nh7JUlx/4EDmdTB6+StdYguyKFaH326cb+GLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA2ae4gS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7B3C2BC87;
	Wed, 25 Feb 2026 01:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984162;
	bh=rUX/K6KAxKJu81nmW960q3ODpIstJEA6r4ipi446aY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bA2ae4gS1gya8zyP1MhKuUWv6jdx+sYL7WHT9B3/vmJKl7USscvjT/UVs/eEuDh35
	 1VD5N+0jQ0kzxENLpWoPz5JbDcmW/bUDJjo/Tg/gvnAf3qjyfQ0HIcRsyvZapivkhx
	 erukVP9pyLrtPnJpOxc/oc3Da5IRStf1gM5btHOhMVrR7QGgndQ+j/nLPWymD0tOqe
	 ry1w147ZoTfPYIzD7HhXddqzBgsqdf8FBcUe5TQl/4lyhcMK+OjkkYQOHXfD3n9/a0
	 5Ou7sAZDN1+lFE0qmfltQrpRMxuVHpMauI98UL1LppuurP3b11YkWqsKvSiw31gQf/
	 pX+LEqTADVbWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] usb: cdns3: call cdns_power_is_lost() only once in cdns_resume()
Date: Tue, 24 Feb 2026 20:49:18 -0500
Message-ID: <20260225014919.3767757-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225014919.3767757-1-sashal@kernel.org>
References: <2026022420-straddle-unquote-c2f6@gregkh>
 <20260225014919.3767757-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219115-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,bootlin.com:email]
X-Rspamd-Queue-Id: 44337190900
X-Rspamd-Action: no action

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 17c6526b333cfd89a4c888a6f7c876c8c326e5ae ]

cdns_power_is_lost() does a register read.
Call it only once rather than twice.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Link: https://lore.kernel.org/r/20250205-s2r-cdns-v7-4-13658a271c3c@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 87e4b043b98a ("usb: cdns3: fix role switching during resume")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 98980a23e1c22..1243a5cea91b5 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -524,11 +524,12 @@ EXPORT_SYMBOL_GPL(cdns_suspend);
 
 int cdns_resume(struct cdns *cdns)
 {
+	bool power_lost = cdns_power_is_lost(cdns);
 	enum usb_role real_role;
 	bool role_changed = false;
 	int ret = 0;
 
-	if (cdns_power_is_lost(cdns)) {
+	if (power_lost) {
 		if (!cdns->role_sw) {
 			real_role = cdns_hw_role_state_machine(cdns);
 			if (real_role != cdns->role) {
@@ -551,7 +552,7 @@ int cdns_resume(struct cdns *cdns)
 	}
 
 	if (cdns->roles[cdns->role]->resume)
-		cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));
+		cdns->roles[cdns->role]->resume(cdns, power_lost);
 
 	return 0;
 }
-- 
2.51.0


