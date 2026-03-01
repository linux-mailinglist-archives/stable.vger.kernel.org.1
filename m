Return-Path: <stable+bounces-221329-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FEqFZ6Uo2l7HQUAu9opvQ
	(envelope-from <stable+bounces-221329-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:21:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 218DB1CA42D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 02:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA704300C6E5
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9A126F2BE;
	Sun,  1 Mar 2026 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G11a5KEa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D60B2264C7;
	Sun,  1 Mar 2026 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772327995; cv=none; b=nIXT6QMdHrhtJbJl8dZ/9pAqH+TTorYOv/DE/LxIXmU73q19PEJnNRAgYE56ZZYRgWPOxHWRPyms6hx0dNTT4rnGosgZRoBWvUgnKQhvHpR0aTepd5dgkqKLCMw5NP80MAkjmhMQqmYrQfN4qfjcmSBvcTb2hcaXVbXoHwyX3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772327995; c=relaxed/simple;
	bh=jadiB0yW3uO8J+QL+4iMJ6wlcWoajahTOaVMpdWeG9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hpukTGjerPhd1V+erETqYv4Bj/iUtv/CcX9o9/Len6WInjhRiJdp8JDIfUli6RvF4o79rfBNEegSXYsTDpbSeIxOJaPh+5aetiL6m+ud4yQxWlKjh4JRj4GxmdGiJqYN8W8/PLdx7Z5mbIDQNR3Dzo/vG79ak/cAw9D+v7jdBR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G11a5KEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0621C19421;
	Sun,  1 Mar 2026 01:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772327995;
	bh=jadiB0yW3uO8J+QL+4iMJ6wlcWoajahTOaVMpdWeG9U=;
	h=From:To:Cc:Subject:Date:From;
	b=G11a5KEagZBNjnzeQYJ2l9CSMzhmFpd1krl29oUZf19gs2bciaBOoq0VTTOZ+GTaT
	 3r+7j/lTiL3z1fjR48DeDGPqtvWz1mRAsBha3A8T0O9e0hoHfbBQmBipfId2UjA9l2
	 qmSDKddtZBcW9HsqaEBI6L0RgdmZhpjwsC8VnQqtFfJF4eIgG3Kg3LJ2C7dzTuoKhR
	 K8odFeUya2LWnKixuqL+zUTMrnem+Dq6Lhtc3Y05+aZ9U917wNx8sVBzHigT08PSt/
	 haJmJUbXXl89BEcOWLfN4N3VksIzk7EJ/BSXXZPo2PuUI24RcNZlqviasEjWMY0uTQ
	 1Z6xkl4cWEgww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	oneukum@suse.com
Cc: Jiri Kosina <jkosina@suse.com>,
	linux-input@vger.kernel.org
Subject: FAILED: Patch "HID: hid-pl: handle probe errors" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:19:53 -0500
Message-ID: <20260301011953.1675193-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221329-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 218DB1CA42D
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 3756a272d2cf356d2203da8474d173257f5f8521 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oneukum@suse.com>
Date: Wed, 19 Nov 2025 10:09:57 +0100
Subject: [PATCH] HID: hid-pl: handle probe errors

Errors in init must be reported back or we'll
follow a NULL pointer the first time FF is used.

Fixes: 20eb127906709 ("hid: force feedback driver for PantherLord USB/PS2 2in1 Adapter")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
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





