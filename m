Return-Path: <stable+bounces-219122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPTxFO1bnmlrUwQAu9opvQ
	(envelope-from <stable+bounces-219122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:18:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBB7190D00
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CB9A31EF8CA
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE5D2550D7;
	Wed, 25 Feb 2026 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHHh7Dpd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDE1FE45A
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771984818; cv=none; b=rJJUkdlTMUaEHNeXYcWas4YtFCn/F94Yyg32GGyGwT0ubgsfu3JmZuPXQXnKaMY3vXmwSlwlsDvP4SCXzveJvC4I5BDhYNRYF1Yx8ZXLk5y5Gzoas28FHhDGWr20NYK8h5FOaCOB9D5xDvITMN0qRgUi2CXGpCwkx4142ZG/ttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771984818; c=relaxed/simple;
	bh=rUX/K6KAxKJu81nmW960q3ODpIstJEA6r4ipi446aY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCCCEnjsTvjkz0uIYzdpi0i5ZturPlZghqRfgESg6QCg/ZEqgpnU8eVA8mfMi+4BGxdjzTwuRbZ419Iqtlw4ADBqdogvvBBcyy+XuRhrCG3phOYRE/npDRBiGJnuhfAN6Kreimea/4wbnccExP6k+jy1xrcsW/vIXtmYOHJivuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHHh7Dpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3731C2BC86;
	Wed, 25 Feb 2026 02:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771984818;
	bh=rUX/K6KAxKJu81nmW960q3ODpIstJEA6r4ipi446aY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHHh7DpdkAc9XKkpE3xC8sclRqhfw+RcJwf67DHBGoU1tW9Bh6ZSydwT0NnRDpZf9
	 XjGj7m1Kb0e05kZuVKT/BGWSOZwglT2cpEOKreiQtiLr7lISXUWRYGnUlC/90IqLni
	 //LrYv0DIxl0TtfcHyyFKE4NfPzv2C4zMeLJ1A2iS+vAl9+/Zz6hhINyxnwaTqspj0
	 SEQ5AmPILgj/xS9leRaScK9tYy9vU8GZtNrgmN5MWPKse6XhXa+ufjLsRNGH0s4U81
	 ieQcI58NQDwLwGozRNHSclOZtLWhfTSvhREkyLenYFbgZGeQ2qEuPyPpW/CW+KZ7j8
	 bV+o93h4hdeJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] usb: cdns3: call cdns_power_is_lost() only once in cdns_resume()
Date: Tue, 24 Feb 2026 21:00:14 -0500
Message-ID: <20260225020015.3779380-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225020015.3779380-1-sashal@kernel.org>
References: <2026022421-folk-jaywalker-5996@gregkh>
 <20260225020015.3779380-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-219122-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DDBB7190D00
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


