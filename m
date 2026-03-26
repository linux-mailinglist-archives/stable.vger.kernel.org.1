Return-Path: <stable+bounces-230518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFRvMtGFxWlc+wQAu9opvQ
	(envelope-from <stable+bounces-230518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:15:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3921D33ACB6
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 20:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA88731BC19C
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 19:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538E1347BBD;
	Thu, 26 Mar 2026 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b="TjMDUMtI"
X-Original-To: stable@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443E34F48E
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551835; cv=none; b=IPQgVdqLxQQ1rtSwzh2bzDfnWMasu3QlcxfDze23Y5RqWykTnQ4Q6xfhWErb8aNkAg4B86pTI28ed3Hno9OllKPBrQRW5hCzHpeBe0U7HYgQ/jwtpIGDDhT6juAwgF/lPYS+UpOjJvFPNMA23KE2Q8v0qNHXLhwGpMjYlJUd0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551835; c=relaxed/simple;
	bh=vBUk8AlvIl2Sm9Ya8jdpATcn3CTWo+D4uwNu5b4d3xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hmCHg3+eXGza8xp8vkEhGcb/dU+TllWWWrN5odZjPL21hbq0ZqV3lxtWYQHsEJDL91rIKNMCFdMv6XLACnnMiTNyc9R9LvTO+tsK4QDhL++hQwHyFWmjbAxxNNcDUpZ+SxlS++gzCSxvwpUOin+VgHypBgD1PsnWXoxVVoBK1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca; spf=pass smtp.mailfrom=justthetip.ca; dkim=pass (2048-bit key) header.d=justthetip.ca header.i=@justthetip.ca header.b=TjMDUMtI; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=justthetip.ca;
	s=key1; t=1774551831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2nKOrQu/q+fU5meJzN4ZZdsdpjtXwGQWpbKXuDrdLOI=;
	b=TjMDUMtIJ/7IoigppoL+DTJfUqlnRSf24SQVC7lanDwzSqZxyQBsw+n1+8rndwlh1yijiK
	Riz+vX7YLNG/U1IWLFmMMJL6mqCF7JRrj+Yw5pBOtFzDuPlY+iDlAFMN/zOISl7q3cjaHb
	ttHK6cEq/t6K06Mjc+HlIOtb9XhZBnPmNfA7cKq+Heshge4pY2bcBjvf1xFD81gzA26s8I
	BoqVg/LTaesJZrN44CwR+sHYVNI8S77aXS3WLqOA3H7Xo2Ze1XghhtjKHND9IGSar13iYF
	ouOue0c9C5v7Ea0SUIzzb/C6+QEX79WMP8yiBfsY3q966LQ3tXGYbM5eyM1ylA==
From: Lucid Duck <lucid_duck@justthetip.ca>
To: nbd@nbd.name,
	lorenzo.bianconi@redhat.com
Cc: sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	morrownr@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH wireless-next] wifi: mt76: mt7925: add Netgear A8500 USB device ID
Date: Thu, 26 Mar 2026 12:03:46 -0700
Message-ID: <20260326190346.415226-1-lucid_duck@justthetip.ca>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[justthetip.ca,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[justthetip.ca:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mediatek.com,vger.kernel.org,lists.infradead.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-230518-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[justthetip.ca:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucid_duck@justthetip.ca,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3921D33ACB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add USB device ID for the Netgear A8500 (0846:9050) which uses
the mt7925 chipset.

Cc: stable@vger.kernel.org
Signed-off-by: Lucid Duck <lucid_duck@justthetip.ca>
---
 drivers/net/wireless/mediatek/mt76/mt7925/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index d9968f038..e44f0cafd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -12,6 +12,9 @@
 static const struct usb_device_id mt7925u_device_table[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7925, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
+	/* Netgear, Inc. A8500 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9050, 0xff, 0xff, 0xff),
+		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
 	/* Netgear, Inc. A9000 */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x0846, 0x9072, 0xff, 0xff, 0xff),
 		.driver_info = (kernel_ulong_t)MT7925_FIRMWARE_WM },
-- 
2.53.0


