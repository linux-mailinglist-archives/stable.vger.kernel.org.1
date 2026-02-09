Return-Path: <stable+bounces-214991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD9AJxPviWn4EQAAu9opvQ
	(envelope-from <stable+bounces-214991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:28:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF141104EF
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78D4D300645A
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54437B3E4;
	Mon,  9 Feb 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0sSYvHOf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255135CB6B;
	Mon,  9 Feb 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647313; cv=none; b=O6Uom2gh3zFcJMWtqsS454NroR2Vq5rblwPdcebKRSuip5xo5FRfXPg75dv6lVr3DS/BXNHJCCjV1DdZJ2NuAk4+HExk5qLKLm8CeTGm8TNG3ZHx/NvonoliiD88J7EHkbSpfz46DPAi6L58/ZPjljvn9OTSor2e4zTbsMqdtm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647313; c=relaxed/simple;
	bh=w5znTUlbeBpOFh1a+btqhFtuxDRooZ2VWvbvS17cM84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lL924Kru+j1adMRwqoD/guMBPXJ6D98vywQvWorMmajNldMA7tYwQ35gZvRLks6bzOO5KYf0YtajvlBCe03E7f/NiqOUFAhbGpeohfG23RZf7lydHGRJrFKwzuBG2qe7oPyB6rKdQVgYnTJ67DjHtoIHcSxgRFOL4WASQvrrgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0sSYvHOf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4F6C116C6;
	Mon,  9 Feb 2026 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647312;
	bh=w5znTUlbeBpOFh1a+btqhFtuxDRooZ2VWvbvS17cM84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0sSYvHOf5ByxSMKFTU+DFQvmA+IwE/ijbKHL+HiQJyi2XfHD85x3VKVKVe649oWur
	 cJ4f2qXxigQTvTB1lGxyezVBekdPK0JRZ2797YYbjXEaHHipyK+gAwjzjY4V4TS+Ww
	 JHugnC/DUbZqyUwtZzfe1tOxgyxzLHmZW7pZphg8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Lixu <lixu.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 063/175] HID: intel-ish-hid: Update ishtp bus match to support device ID table
Date: Mon,  9 Feb 2026 15:22:16 +0100
Message-ID: <20260209142322.726757514@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214991-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 1EF141104EF
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Lixu <lixu.zhang@intel.com>

[ Upstream commit daeed86b686855adda79f13729e0c9b0530990be ]

The ishtp_cl_bus_match() function previously only checked the first entry
in the driver's device ID table. Update it to iterate over the entire
table, allowing proper matching for drivers with multiple supported
protocol GUIDs.

Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index c6ce37244e497..c3915f3a060ea 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -240,9 +240,17 @@ static int ishtp_cl_bus_match(struct device *dev, const struct device_driver *dr
 {
 	struct ishtp_cl_device *device = to_ishtp_cl_device(dev);
 	struct ishtp_cl_driver *driver = to_ishtp_cl_driver(drv);
+	struct ishtp_fw_client *client = device->fw_client;
+	const struct ishtp_device_id *id;
 
-	return(device->fw_client ? guid_equal(&driver->id[0].guid,
-	       &device->fw_client->props.protocol_name) : 0);
+	if (client) {
+		for (id = driver->id; !guid_is_null(&id->guid); id++) {
+			if (guid_equal(&id->guid, &client->props.protocol_name))
+				return 1;
+		}
+	}
+
+	return 0;
 }
 
 /**
-- 
2.51.0




