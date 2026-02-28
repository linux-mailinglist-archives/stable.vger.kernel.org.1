Return-Path: <stable+bounces-220639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOC/DwZRo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:33:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D631C86BF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 007DA31FD99E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C94B3EC6C9;
	Sat, 28 Feb 2026 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwGzzLDW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001693EC6C1;
	Sat, 28 Feb 2026 17:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300522; cv=none; b=siv98ES8W6aLBDSt/V/pnTfP45l7Q4dLVOoV4hWzJFCGwD2TRBsT6xsM2KIUf7ZB0pph1Li5So6DYT7Tb2KATNen6wZ7Nty4azEeck6KBJAYXsDqBFUu2vq8xRLwTNYTS7pslGicGvAA3ErIMwge2N7Dcq3KWCFXuWPY8PeHlMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300522; c=relaxed/simple;
	bh=OssYHVtpqWoKQFKjafrGzXcfF6y3P6GuD0ExBSD0byU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVbq6G6sLaI3OZjxRx540OTTDq8I4iJgt1J4NQE4dRNUdqkKQlV+t7TnEX8rYCGwKYZmEL0nW8nf5R5V459q8W9wdx1xsn3XOy4FUHaAi4iDmWENP5eYs9XH+78ZqWX4/WV7U599ff7yJdgZqKUxOFJnrjZr3mWFJjumWovpisI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwGzzLDW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454FFC116D0;
	Sat, 28 Feb 2026 17:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300521;
	bh=OssYHVtpqWoKQFKjafrGzXcfF6y3P6GuD0ExBSD0byU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwGzzLDWkxrgFJr+xemMJRTqrNv+51x8Kn3wHLeq4Rn2xqv8ZXIlOoC2+vso99xVz
	 Ac5a9KVYKfW7v+pS65tFPZW2MV44Sy0Eyf2x/Sw9rgYDv8t58M0RPYNK7puZ0jPGzy
	 6O8HEeiVrdPrCRifrVxa4505URb13bAcHwy7ukmdgHyuMPNcJKmkXrGWIRL+dvQX1a
	 gRUpmXJnPpoUC3ivPgd7XriDPy9XokBdrzDZ3ATLAUbhuQUzBUbQhQ7dDThDDGrpYY
	 Am1UtKarOHv6YUGlO/VGCbN75W8o1yG8aQmH2Mw3CDZ+FyYGvp4im7MXglgTPztBQ9
	 bbgKR/8eT2hCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 560/844] HID: hid-pl: handle probe errors
Date: Sat, 28 Feb 2026 12:27:53 -0500
Message-ID: <20260228173244.1509663-561-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220639-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Queue-Id: 09D631C86BF
X-Rspamd-Action: no action

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 3756a272d2cf356d2203da8474d173257f5f8521 ]

Errors in init must be reported back or we'll
follow a NULL pointer the first time FF is used.

Fixes: 20eb127906709 ("hid: force feedback driver for PantherLord USB/PS2 2in1 Adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-pl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-pl.c b/drivers/hid/hid-pl.c
index 3c8827081deae..dc11d5322fc0f 100644
--- a/drivers/hid/hid-pl.c
+++ b/drivers/hid/hid-pl.c
@@ -194,9 +194,14 @@ static int pl_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err;
 	}
 
-	plff_init(hdev);
+	ret = plff_init(hdev);
+	if (ret)
+		goto stop;
 
 	return 0;
+
+stop:
+	hid_hw_stop(hdev);
 err:
 	return ret;
 }
-- 
2.51.0


