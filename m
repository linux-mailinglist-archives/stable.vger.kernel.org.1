Return-Path: <stable+bounces-239406-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPVeGzBf5mndvQEAu9opvQ
	(envelope-from <stable+bounces-239406-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:15:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6C430D40
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D4CF34ADF38
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96358332919;
	Mon, 20 Apr 2026 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pZrnqP5u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592AB313547;
	Mon, 20 Apr 2026 15:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700165; cv=none; b=b0ckU0oTs9KjlwLTY6INjS2XlrkyM+wWM0z790Lh9KIPmPFmB1Sbx6+aFENZDZamdh/uiQYxAhQOsevuYQdYaZwME1QKyXr0+vhG5NVD4plh1ZRwfkiz1fnA/QfnGgXz7bmZh4/md3RQCHudVEnmG6VDE/BdwNFMSPEmSkKAyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700165; c=relaxed/simple;
	bh=nG4/m947HB5ljrEDJ0aPKZXl55vg2X5uX+FntOPp9o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edtQUBbbOJwFlBHYgPgV8fKf8cslZHmPpq6f/Kx/AgidCuDo3EzAh5XYitwC+fjXjbJy0SnrazU1HIFQtkfRHROLRlCUxRO75u1T60AzSmjHEBYgJVYvECFRJgVwewMd6U/ThGq0YhTC4DajxV4eQis10rbpXAEMtHQKPLuDLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pZrnqP5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44DDC2BCB7;
	Mon, 20 Apr 2026 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700165;
	bh=nG4/m947HB5ljrEDJ0aPKZXl55vg2X5uX+FntOPp9o0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pZrnqP5uCyANelajqNQlTrlZcH306DCzpj3CPlyH5aeHDmswAm/YdVpWiUP9r8SZR
	 B/AiEiUe0f6/uvZKwgNVroBy+Tzxltk+uzrg5l49j79PdKqnlVL+JlW6yveWb5dsyE
	 WBbSKJKWyMw823l5ifUmFMY3iQDj1sfqb+wcsnUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Casey Croy <ccroy@bugzilla.kernel.org>,
	Maximilian Pezzullo <maximilianpezzullo@gmail.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 066/220] HID: amd_sfh: dont log error when device discovery fails with -EOPNOTSUPP
Date: Mon, 20 Apr 2026 17:40:07 +0200
Message-ID: <20260420153936.417682535@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,bugzilla.kernel.org,gmail.com,amd.com,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-239406-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,amd.com:email,suse.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 99B6C430D40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maximilian Pezzullo <maximilianpezzullo@gmail.com>

[ Upstream commit 743677a8cb30b09f16a7f167f497c2c927891b5a ]

When sensor discovery fails on systems without AMD SFH sensors, the
code already emits a warning via dev_warn() in amd_sfh_hid_client_init().
The subsequent dev_err() in sfh_init_work() for the same -EOPNOTSUPP
return value is redundant and causes unnecessary alarm.

Suppress the dev_err() for -EOPNOTSUPP to avoid confusing users who
have no AMD SFH sensors.

Fixes: 2105e8e00da4 ("HID: amd_sfh: Improve boot time when SFH is available")
Reported-by: Casey Croy <ccroy@bugzilla.kernel.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221099
Signed-off-by: Maximilian Pezzullo <maximilianpezzullo@gmail.com>
Acked-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index 1d9f955573aa4..4b81cebdc3359 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -413,7 +413,8 @@ static void sfh_init_work(struct work_struct *work)
 	rc = amd_sfh_hid_client_init(mp2);
 	if (rc) {
 		amd_sfh_clear_intr(mp2);
-		dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
+		if (rc != -EOPNOTSUPP)
+			dev_err(&pdev->dev, "amd_sfh_hid_client_init failed err %d\n", rc);
 		return;
 	}
 
-- 
2.53.0




