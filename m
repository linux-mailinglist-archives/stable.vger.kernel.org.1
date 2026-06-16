Return-Path: <stable+bounces-264612-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FCBNMt93MWppkAUAu9opvQ
	(envelope-from <stable+bounces-264612-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:20:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63567691F6E
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:20:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=BVV6v1bO;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264612-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-264612-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78D7C3006819
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E4446AF1E;
	Tue, 16 Jun 2026 16:20:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E13946AF2E;
	Tue, 16 Jun 2026 16:20:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626820; cv=none; b=DwJHD0OJZy8NI6B6Ha17aLttyY2oUl1f1KFKoQEdgUJB8Rdc1sGahr13CTFRY5N645uoCWzF8At8NTD+qT0D5UKlgLwaIo/qE9QBtkJThxPW/NayX5AB951x5/fsR106oDtGx3seIJVFj6pfUZMlz/CTrnz+8j6Y4g5mUveWhgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626820; c=relaxed/simple;
	bh=nAkEPVkLjE+RuDyntsQ+ti6J8pGZaR9+lq1xCdy6Q4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWyEBY4GH3ln54V83fw4AhLBKCLx9WgdaepgNWNvXuYdqlPofc8+JWljwFOS8/y316FRi5fx5NCPxV5MaEHYaa+TWdUWtdC7Ib7I9KoEKUtkURHrSUbkJOvwgVQMLFoNOGygqUrWJhkzZAtpSnHR097+yMj5UPsXwrmFne8/ri4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BVV6v1bO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFCD1F000E9;
	Tue, 16 Jun 2026 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781626819;
	bh=g+cDSOOBQpuyWpxh3QNZKhfvPbNIncdB+GOl8Yl2t08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BVV6v1bO5hb7FflNaxBDm2zpnU6nyM3wpaggnQ08fcw6S9JY0sCwn3zqPzdPwFJYh
	 8K4hYyiTwC/cqOntwp9OEq9VETyA21C7ltEBe2K0Lb2VyQLdedOO7r33CnERAwopSh
	 TeDa6W0bMes7rQ7z1co6CZNh/yiL+jiS8qb5A+dM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 077/261] ASoC: wm_adsp: Fix NULL dereference when removing firmware controls
Date: Tue, 16 Jun 2026 20:28:35 +0530
Message-ID: <20260616145048.660577660@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145044.869532709@linuxfoundation.org>
References: <20260616145044.869532709@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264612-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:rf@opensource.cirrus.com,m:broonie@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cirrus.com:email,msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 63567691F6E

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Richard Fitzgerald <rf@opensource.cirrus.com>

[ Upstream commit 7d3fb78b550301e43fdc60312aed733069694426 ]

In wm_adsp_control_remove() check that the priv pointer is not NULL
before attempting to cleanup what it points to.

When cs_dsp creates a control it calls wm_adsp_control_add_cb() so that
wm_adsp can create its own private control data. There are two cases
where private data is not created:

1. The control is a SYSTEM control, so an ALSA control is not created.

2. The codec driver has registered a control_add() callback that
   hides the control, so wm_adsp_control_add() is not called.

When cs_dsp_remove destroys its control list it calls
wm_adsp_control_remove() for each control. But wm_adsp_control_remove()
was attempting to cleanup the private data pointed to by cs_ctl->priv
without checking the pointer for NULL.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 0700bc2fb94c ("ASoC: wm_adsp: Separate generic cs_dsp_coeff_ctl handling")
Link: https://patch.msgid.link/20260604101244.1402862-1-rf@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index e69283195f362f..5d5d1c0c9b936b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -674,6 +674,9 @@ static void wm_adsp_control_remove(struct cs_dsp_coeff_ctl *cs_ctl)
 {
 	struct wm_coeff_ctl *ctl = cs_ctl->priv;
 
+	if (!ctl)
+		return;
+
 	cancel_work_sync(&ctl->work);
 
 	kfree(ctl->name);
-- 
2.53.0




