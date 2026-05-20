Return-Path: <stable+bounces-251708-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MTEFS/zDWry4wUAu9opvQ
	(envelope-from <stable+bounces-251708-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:45:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E015E59479B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05681308459E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67BC3ED136;
	Wed, 20 May 2026 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EFb3DklC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB53E6385;
	Wed, 20 May 2026 17:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298686; cv=none; b=Irw5yawV4TDD276WX0XLrJeYbvhq/w60TWIurVazvUckfwllwx3QED3CIvtdlw53hDjWjxFZVpaidUTOL/5JxJJcuCb4UPvJpgpr7e0CjBd5AWyhlXxo/49+ZSInyvsYplUxe8MaMGBlCEGE9pBBD6AZGr0JPGvdTeH1zslGt/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298686; c=relaxed/simple;
	bh=oAkhHOaL3877gJ1r1lGID17ikahm4ivrYt6sRB6Boy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrsoFAbIYWnR0W0yrKXKEbYm7v8aiysbnZUjAO77Hkh6qR9kJkTrTTkRFH2JzQSaPZb6MWxrt04HPtPNt+FW5JRSHGmVN7XoXiKWwZ1y0ByZHD27wXg61UC8rukFjbLdIfFl5kQ32qyHoTM00fDVVRtZYWGU5cKB9JAY66pJjkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EFb3DklC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77F21F000E9;
	Wed, 20 May 2026 17:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779298685;
	bh=L2uxAi6W+dhoKOpvH4skqOrR50nZ9IqtYtf0ybRHG80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EFb3DklC6F2RIyuO/DTzPfMqgNU42ji47fbhR6lA1QKKYdcudbSFNUalt/Pnbwii1
	 AcrOF0Z5OwgpBOHZO5aJ1/CInVtqbaIBSJNTVDYf9saiKYm7IL6rM2nTRAZiT+46Oz
	 IO1FlLYY7iXv2uop6yH9WfmRwfTwI2+q46j7Ew4E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 505/957] pinctrl: pinconf-generic: Fully validate pinmux property
Date: Wed, 20 May 2026 18:16:28 +0200
Message-ID: <20260520162145.484059361@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251708-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Queue-Id: E015E59479B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit c98324ea7849b6e5baa1774f71709b375a2c2f9e ]

The pinconf_generic_parse_dt_pinmux() assumes that the 'pinmux' property
is not empty when present. This might be not true. With that, the allocator
will give a special value in return and not NULL which lead to the crash
when trying to access that (invalid) memory. Fix that by fully validating
'pinmux' value, including its length.

Fixes: 7112c05fff83 ("pinctrl: pinconf-generic: Add API for pinmux propertity in DTS file")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinconf-generic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
index cad29abe4050a..8f6a83fdc3844 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -261,12 +261,17 @@ int pinconf_generic_parse_dt_pinmux(struct device_node *np, struct device *dev,
 		return -ENOENT;
 	}
 
+	npins_t = prop->length / sizeof(u32);
+	if (npins_t == 0) {
+		dev_info(dev, "pinmux property doesn't have entries\n");
+		return -ENODATA;
+	}
+
 	if (!pid || !pmux || !npins) {
 		dev_err(dev, "parameters error\n");
 		return -EINVAL;
 	}
 
-	npins_t = prop->length / sizeof(u32);
 	pid_t = devm_kcalloc(dev, npins_t, sizeof(*pid_t), GFP_KERNEL);
 	pmux_t = devm_kcalloc(dev, npins_t, sizeof(*pmux_t), GFP_KERNEL);
 	if (!pid_t || !pmux_t) {
-- 
2.53.0




