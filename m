Return-Path: <stable+bounces-245187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E6pD7TMAWrajwEAu9opvQ
	(envelope-from <stable+bounces-245187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:33:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2A050DE94
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 206B13037939
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 12:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202DA3FFAD5;
	Mon, 11 May 2026 12:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="lWmkcIoE";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="g+AI01c+"
X-Original-To: stable@vger.kernel.org
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755EE3FE373;
	Mon, 11 May 2026 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502417; cv=none; b=nEpoVd3TSCchnht05l/3CKVt+rz/idJCyWtkDhqoIPyHafR/3PS3VdPP9tsHne8LbwFHZTlMCyO5LC7dEg79gnklpmWbBCKRerD/zE/674u4OfVgKh3o3uByrGNmyBOxJuqF/0IT1nv5nMk6aJV9sSK7dgxXJpCRo8MOzcVwq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502417; c=relaxed/simple;
	bh=tzGSA4xuUafYNRryXRdJZsE6UAMFY0aQHpt/T3G3M08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/jmyiPVzANCJY4Svz0sPSeaDOaBCaUD9i7YLjWE0aP6rbM88pYsQRCgS7Yht86P0MBJq55Ft4qNYyCB5Jxz564Htl/cnhUC3B8k83PKmqJ4442FotM7LK2fbBj9b+67Xp0onjCMPjQUSdO7U8LuenlQo5CIR+Qc0L4pzNmNjwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=lWmkcIoE; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=g+AI01c+; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1778502277; bh=9fESPzzh5tkV6zO5hJFJCOe
	PTtrzHZaB3oLTCyImSzQ=; b=lWmkcIoEzyjy8bvXROoNfwBXyrGhaa20y19zFqK4FM9W2o3bJo
	bmA17tzwxK6BX9gMc/q/B3BN6mEvDALHtv29xMA4voHdmArQQx1ZnQGBKgJcqsBHShRrPMH6swu
	85QNS4voQIKOYlPmZ5jPJRDHrddK/H/6fVQ2Wgcit99xlDbUJ8tk3fCq6d3f8mCqwa7vgxEwAq+
	nw6FhoxdQeHaB+FxOXG3lbGro89NUnFEzRAK6WDLTwykJ21c1qAO6OPpQD1oEc/f3ihTOlNsX7w
	1yD5/DUb7nJueZ+hjQSeokOfnyyFCx1CzdyuD/55IUIexnOuPB4Dpbf8UcvDQHenBQw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1778502277; bh=9fESPzzh5tkV6zO5hJFJCOe
	PTtrzHZaB3oLTCyImSzQ=; b=g+AI01c+rPJNIAUVDnyefuvLXW6/B59JVpnacLJFCStGZIfSEb
	IsoN6SWkrogA1QaywmUSc0C0W3IOdJvt4BAg==;
From: vipoll <vipoll@mainlining.org>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Victor Paul <vipoll@mainlining.org>,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: fsa4480: Add chip id read retry loop
Date: Mon, 11 May 2026 16:22:46 +0400
Message-ID: <20260511122246.31673-1-vipoll@mainlining.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE2A050DE94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mainlining.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mainlining.org:s=202507r,mainlining.org:s=202507e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245187-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mainlining.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vipoll@mainlining.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Victor Paul <vipoll@mainlining.org>

The first read attempt may fail on some devices (e.g. Xiaomi Pad 6)

Cc: stable@vger.kernel.org
Signed-off-by: Victor Paul <vipoll@mainlining.org>
---
 drivers/usb/typec/mux/fsa4480.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
index c54e42c7e6a1..ae496c0fa805 100644
--- a/drivers/usb/typec/mux/fsa4480.c
+++ b/drivers/usb/typec/mux/fsa4480.c
@@ -256,6 +256,7 @@ static int fsa4480_probe(struct i2c_client *client)
 	struct typec_switch_desc sw_desc = { };
 	struct typec_mux_desc mux_desc = { };
 	struct fsa4480 *fsa;
+	int retries = 5;
 	int val = 0;
 	int ret;
 
@@ -278,7 +279,12 @@ static int fsa4480_probe(struct i2c_client *client)
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "Failed to get regulator\n");
 
-	ret = regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
+	do {
+		ret = regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
+		if (!ret)
+			break;
+		usleep_range(1000, 1200);
+	} while (retries--);
 	if (ret)
 		return dev_err_probe(dev, -ENODEV, "FSA4480 not found\n");
 
-- 
2.52.0


