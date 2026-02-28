Return-Path: <stable+bounces-220121-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPMXC2wpo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220121-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:44:12 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D221C511C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09F4C303E690
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A7E480963;
	Sat, 28 Feb 2026 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pSCJt1Ry"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D2534A784;
	Sat, 28 Feb 2026 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300032; cv=none; b=NBfbqbpZXkXJ9JYinoLV7cWbZ+n1HBnlpvYIdz0dfmZDygJBpwS1C33DukphwA7gQvzaCJp2Tqa0eOWdFhP8YJEmdEB6Yia5JG+/J4CjypPRcVviJoF0P+Tw+TO7RryzAgtxmBOyo/G7ux7vy58lrKXvWuwgtbsCs4flMORu6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300032; c=relaxed/simple;
	bh=O0ssoK+Ropf2+wKoGNPKJ0dRMeEOUWpGrGNqjOpJUxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=crOQBT2rnC7xCsmQSQ2Wx67jPmv3QKouccKpfQOUlW0YW7uAxaK679hMUdNvS1Lzh1eGeTyQD2vZHn1J6shM54Zb5Axfg1Zf/BwJb/Yxiy5VueI+Og3CFLEDNsWsDvKP1GQpUvvDty1B2U2nT0qvpPzYuWmdipDnGKUVR0IuwjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pSCJt1Ry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F213DC116D0;
	Sat, 28 Feb 2026 17:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300031;
	bh=O0ssoK+Ropf2+wKoGNPKJ0dRMeEOUWpGrGNqjOpJUxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSCJt1Ryy36iIml2yf/iMpGR4II51U7yKnJhpcQZnvCYCZ6nLiu5bPnTSI/JEnUhR
	 pklWLBktM9HKNn+/EurugFubkHn1oxuffREXdHVQCrfNz7d3oeoLi58awPRb5WFqjB
	 4TXTZfnkyFHjfSwvIlCLpPiWrZL1jI9QIaPNXiqrkzxap18+5vrBwgTpds8539Nkib
	 ufzXxGNeuzMwde+pbSfTkexhhIB7isWYMrPGCJmBOOyVEcBct31lpzKAaOW6lzdNad
	 awOIguG+/fSE48XwhDwwvCTR4I9t6+uNjEvCezWefV8gjm2HAP/iLEXMDiXXf8p0Sd
	 k5S69ptGpa+5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	kernel test robot <lkp@intel.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 043/844] i3c: master: svc: Initialize 'dev' to NULL in svc_i3c_master_ibi_isr()
Date: Sat, 28 Feb 2026 12:19:16 -0500
Message-ID: <20260228173244.1509663-44-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220121-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,bootlin.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: C0D221C511C
X-Rspamd-Action: no action

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 3c9ffb4db787428a5851d5865823ab23842d5103 ]

Initialize the 'dev' pointer to NULL in svc_i3c_master_ibi_isr() and add
a NULL check in the error path.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202512131016.YCKIsDXM-lkp@intel.com/
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20251215200852.3079073-1-Frank.Li@nxp.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/svc-i3c-master.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index a62f22ff8b576..857504d36e186 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -533,8 +533,8 @@ static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 msta
 static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
 {
 	struct svc_i3c_i2c_dev_data *data;
+	struct i3c_dev_desc *dev = NULL;
 	unsigned int ibitype, ibiaddr;
-	struct i3c_dev_desc *dev;
 	u32 status, val;
 	int ret;
 
@@ -627,7 +627,7 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
 	 * for the slave to interrupt again.
 	 */
 	if (svc_i3c_master_error(master)) {
-		if (master->ibi.tbq_slot) {
+		if (master->ibi.tbq_slot && dev) {
 			data = i3c_dev_get_master_data(dev);
 			i3c_generic_ibi_recycle_slot(data->ibi_pool,
 						     master->ibi.tbq_slot);
-- 
2.51.0


