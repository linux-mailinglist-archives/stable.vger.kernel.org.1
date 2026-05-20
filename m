Return-Path: <stable+bounces-250617-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEZDANX0DWry4wUAu9opvQ
	(envelope-from <stable+bounces-250617-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:52:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59949594C99
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E28C3353B798
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3016C372691;
	Wed, 20 May 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNabVAnf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D110436B059;
	Wed, 20 May 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295879; cv=none; b=hm4CdSgNv7PeMk76YXYuGJD4Cz0Ip6ly2244OABw81vOYQ6mAkoRVosVJ4NkejtyWI/2lgUj6sXfafF2R3PGXoUKqoQE7V9VYyE7c2iIhC05kU/Zcwnha4U42NEATt/CEGOCwiJ4felvDpiEc5A7jRSWYlheTG9E5Rc129POWrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295879; c=relaxed/simple;
	bh=7A6eL/buVAUrBev7i0lnfkxSW5aMURaiwU7yMU+QepI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dR1YDUtr+dHLmIgzAetrAJHAmlEGJWrZZXjXJsrgvfSMLyk9b5AvWk7oT7Df4qn/sZj6uHgYg3wMPmIRO4rLBvo1f6ThS+flcLBcf8B8Bf1nl/L9Ylun7FAHshCxwWcMkJR0UrIBfgOWyFK1SVkBxkLMBB92WbY+3h0RtowgOdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UNabVAnf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AD41F000E9;
	Wed, 20 May 2026 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295878;
	bh=+3FNuC4LmVl4c5S2AOEmIzeCuRpRnexLXMi4q6y79jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UNabVAnffA0YQVu/SuTEykKRGk1nURhzoQAOGgcnrKhH47HZNPQpjO7idR1Ep1Z/a
	 H0M/OLWNAckZrm/uWYZgn2iGmfTFtE45nyuT8oFkWP8n9wYJKsxpZAF3RqkSSyXR0r
	 55hWNtPdKp75/it35kY59gqztt7Y1phcS/wQ8MJU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Denis Benato <denis.benato@linux.dev>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0587/1146] HID: asus: do not abort probe when not necessary
Date: Wed, 20 May 2026 18:13:57 +0200
Message-ID: <20260520162201.462892818@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250617-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,linux.dev:email,suse.com:email]
X-Rspamd-Queue-Id: 59949594C99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Denis Benato <denis.benato@linux.dev>

[ Upstream commit 7253091766ded0fd81fe8d8be9b8b835495b06e8 ]

In order to avoid dereferencing a NULL pointer asus_probe is aborted early
and control of some asus devices is transferred over hid-generic after
erroring out even when such NULL dereference cannot happen: only early
abort when the NULL dereference can happen.

Also make the code shorter and more adherent to coding standards
removing square brackets enclosing single-line if-else statements.

Fixes: d3af6ca9a8c3 ("HID: asus: fix UAF via HID_CLAIMED_INPUT validation")
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-asus.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index d29e002c3af17..b2332efabeb57 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1312,22 +1312,17 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 * were freed during registration due to no usages being mapped,
 	 * leaving drvdata->input pointing to freed memory.
 	 */
-	if (!drvdata->input || !(hdev->claimed & HID_CLAIMED_INPUT)) {
-		hid_err(hdev, "Asus input not registered\n");
-		ret = -ENOMEM;
-		goto err_stop_hw;
-	}
-
-	if (drvdata->tp) {
-		drvdata->input->name = "Asus TouchPad";
-	} else {
-		drvdata->input->name = "Asus Keyboard";
-	}
+	if (drvdata->input && (hdev->claimed & HID_CLAIMED_INPUT)) {
+		if (drvdata->tp)
+			drvdata->input->name = "Asus TouchPad";
+		else
+			drvdata->input->name = "Asus Keyboard";
 
-	if (drvdata->tp) {
-		ret = asus_start_multitouch(hdev);
-		if (ret)
-			goto err_stop_hw;
+		if (drvdata->tp) {
+			ret = asus_start_multitouch(hdev);
+			if (ret)
+				goto err_stop_hw;
+		}
 	}
 
 	return 0;
-- 
2.53.0




