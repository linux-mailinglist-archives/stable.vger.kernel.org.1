Return-Path: <stable+bounces-232283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H7WGw8GzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9467636EFA6
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 041BC30CFD89
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98966425CD2;
	Tue, 31 Mar 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZgE066p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D05423A7C;
	Tue, 31 Mar 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976349; cv=none; b=niTehXfe3L+PvQEUvpY+FzsmKVHLJCbr9yM8Z1ar457ioiM1KPxt53MHuL8e7NJ8D9gXcL0cH4ZWsXnnpu4CsgI+RSikddis4s1U2Mw3HjdcgGNdSaNsIzCbaLKqtc8pqr3M5O5xeFh91guclISbv5oOk9s1hQ0kagxyI3oOaEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976349; c=relaxed/simple;
	bh=aIWx4KNRVDX8AbkpOmaeMvsPhzneRDoRHPRtJE2k2Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YzIWvGpqYp5Yvypg++zp0e10vkj4/iA6HcCwyqLE6NhgdirtvanOFzPzk5dpufOg9SRKScKqPHd64+1yRrJFBQLaWenz+o5XCywdw+9UHVKH2RfUhy2eBHiybXLOFWg4N3k7+LDzfr3CQSIEmeicr2Lc6N1UiEXgp/zaKlrp6vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZgE066p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A9FC19424;
	Tue, 31 Mar 2026 16:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976349;
	bh=aIWx4KNRVDX8AbkpOmaeMvsPhzneRDoRHPRtJE2k2Xw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZgE066pHELQngzZKkfR6dT6FcxPRbN3ZcNCXBQm27/cioi/1UUrCX39Wu23ZQf+U
	 e5eN5z8rOwjAWDDgLniFGERYSwpXQYHWazew+Lq4GG4XK8k8DlhdQZnQywKhlGGfOm
	 00JbE5cVp/etNF28OQ+9vtcKSv3TFCk91Uj89aMc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yajat Kumar <yajatapps3@gmail.com>,
	Hans de Goede <johannes.goede@oss.qualcomm.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 025/309] platform/x86: touchscreen_dmi: Add quirk for y-inverted Goodix touchscreen on SUPI S10
Date: Tue, 31 Mar 2026 18:18:48 +0200
Message-ID: <20260331161754.405339978@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,linux.intel.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232283-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,qualcomm.com:email,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 9467636EFA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <johannes.goede@oss.qualcomm.com>

[ Upstream commit 7d87ed70fc95482c12edf9493c249b6413be485e ]

The touchscreen on the SUPI S10 tablet reports inverted Y coordinates,
causing touch input to be mirrored vertically relative to the display.

Add a quirk to set the "touchscreen-inverted-y" boolean device-property
on the touchscreen device, so that the goodix_ts driver will fixup
the coordinates.

Reported-by: Yajat Kumar <yajatapps3@gmail.com>
Closes: https://lore.kernel.org/linux-input/20251230221639.582406-1-yajatapps3@gmail.com/
Tested-by: Yajat Kumar <yajatapps3@gmail.com>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Link: https://patch.msgid.link/20260217132346.34535-1-johannes.goede@oss.qualcomm.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/touchscreen_dmi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
index bdc19cd8d3edf..d83c387821ea1 100644
--- a/drivers/platform/x86/touchscreen_dmi.c
+++ b/drivers/platform/x86/touchscreen_dmi.c
@@ -410,6 +410,16 @@ static const struct ts_dmi_data gdix1002_upside_down_data = {
 	.properties	= gdix1001_upside_down_props,
 };
 
+static const struct property_entry gdix1001_y_inverted_props[] = {
+	PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
+	{ }
+};
+
+static const struct ts_dmi_data gdix1001_y_inverted_data = {
+	.acpi_name	= "GDIX1001",
+	.properties	= gdix1001_y_inverted_props,
+};
+
 static const struct property_entry gp_electronic_t701_props[] = {
 	PROPERTY_ENTRY_U32("touchscreen-size-x", 960),
 	PROPERTY_ENTRY_U32("touchscreen-size-y", 640),
@@ -1658,6 +1668,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_SKU, "PN20170413488"),
 		},
 	},
+	{
+		/* SUPI S10 */
+		.driver_data = (void *)&gdix1001_y_inverted_data,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SUPI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "S10"),
+		},
+	},
 	{
 		/* Techbite Arc 11.6 */
 		.driver_data = (void *)&techbite_arc_11_6_data,
-- 
2.51.0




