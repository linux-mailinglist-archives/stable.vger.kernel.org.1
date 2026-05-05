Return-Path: <stable+bounces-243981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN00LIOB+Wn/9AIAu9opvQ
	(envelope-from <stable+bounces-243981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:34:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCF74C6ED1
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 07:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A0663004CB7
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 05:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6CB3BF66E;
	Tue,  5 May 2026 05:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gg5mQB2u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE73B636A;
	Tue,  5 May 2026 05:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777959292; cv=none; b=YSf4XtEaTvrRuChqaRqSf+hR18PAwnbFcKMJ3/nRNJHgaJQwFOgJqgijIPHz+ZBEQmISB8OzDNH3O3Ha5msq6UoUH4sXpEuyAlDDdPIQaNVnJU8wHQyKOP3Wm97AuOtLrLE5nQUWcCgkwWB59eHJH7KmoGL7BVVsd3tD5msELZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777959292; c=relaxed/simple;
	bh=92MPgt0TkWK6DqtE/boH8NkhA/qv07BS4lclxeEb1Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8CfiBacmdkPEZnuOYmisU0dfzSsOdEZIWu8j10lGwF7UYz9yrLz0QHFd7wPve7ZFVvUJRLM403bqGOHIBfZNfbzZt+OVHclRii4BOXTgX/apS9fGIANmp+sBKnE/qs10qSuMDcTXzY6PZhQxsaZy9iCCSGlsC8LwK1MeFehiCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gg5mQB2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440F0C2BCB4;
	Tue,  5 May 2026 05:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777959291;
	bh=92MPgt0TkWK6DqtE/boH8NkhA/qv07BS4lclxeEb1Ug=;
	h=From:To:Cc:Subject:Date:From;
	b=Gg5mQB2uGuM2yaD3zvX2evFZnmm992Gz5PzgPwmOnyyH8Ng/k/d4+9ZvwjvPQMTD3
	 42+N0CF6yAi8M/GFgRYd71VnMixaZLg8+roexyGvffNt6XMxuD9G4sC4agZFikL5y3
	 60PWDZHmae3BlFXlgYwntitQjfG20D0avx4BTZ6tcvxfPxfUClrqWrSVKGZ7y9A8gK
	 /uUXG/OfJNI+lNcBvHsPNlF1nxwWFjMJoHVnat6Zn3GoO1is6PkgPQfuEQOhiVJ+oq
	 zoz6orFQjM5RzZSjnuvS+f4+j2k8J98hUYXi/lW2ojfgz1LfjYSwMJ2vg/cTNndOj4
	 pDVNwpNFPL5gw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Benson Leung <bleung@chromium.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Andrei Kuchynski <akuchynski@chromium.org>
Cc: tzungbi@kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec_typec: Init mutex in Thunderbolt registration
Date: Tue,  5 May 2026 05:34:03 +0000
Message-ID: <20260505053403.3335740-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ABCF74C6ED1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243981-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tzungbi@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

cros_typec_register_thunderbolt() missed initializing the `adata->lock`
mutex.  This leads to a NULL dereference when the mutex is later
acquired (e.g. in cros_typec_altmode_work()).

Initialize the mutex in cros_typec_register_thunderbolt() to fix the
issue.

Cc: stable@vger.kernel.org
Fixes: 3b00be26b16a ("platform/chrome: cros_ec_typec: Thunderbolt support")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 drivers/platform/chrome/cros_typec_altmode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/cros_typec_altmode.c b/drivers/platform/chrome/cros_typec_altmode.c
index 557340b53af0..66c546bf89b5 100644
--- a/drivers/platform/chrome/cros_typec_altmode.c
+++ b/drivers/platform/chrome/cros_typec_altmode.c
@@ -359,6 +359,7 @@ cros_typec_register_thunderbolt(struct cros_typec_port *port,
 	}
 
 	INIT_WORK(&adata->work, cros_typec_altmode_work);
+	mutex_init(&adata->lock);
 	adata->alt = alt;
 	adata->port = port;
 	adata->ap_mode_entry = true;
-- 
2.54.0.545.g6539524ca2-goog


