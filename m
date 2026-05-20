Return-Path: <stable+bounces-250667-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC+LGVb1DWoz5AUAu9opvQ
	(envelope-from <stable+bounces-250667-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF3D594E64
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA2B31E0096
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A0A36A352;
	Wed, 20 May 2026 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c9UE5aeZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E739C00B;
	Wed, 20 May 2026 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296005; cv=none; b=cLOHx0JGayFra8tGE5/K1vaTwpRoJs52lUOnXG3MI0F2wTpGznqkCecq1Lxuq1cjSWen4ZgonoFUYRUnMz6iQaV2aUGCtDdzvgg9NzN/ndJB+nLg1Cs7OhxF3LwGG9J9aJhAufIhB4w98HiR2Clx7aug8QrU4ULlxPaYWuHi0fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296005; c=relaxed/simple;
	bh=l5HQfrLVxr/IfZoQlcsyTa093A7gAYg796tYQWQkqvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGha/imEeH7QyhE6R9GUiCfFL5JdANNtPS0GNnBSoFZJECx988k/1G91PrDi72gmVkaUaxJRrzLbLMJOq6z6RfBxg0w4kmPoaMpRyexQnCd/bcctzxN6x9fH4PlGWKUP63y2u88f8jsf6lbgXCwEYUtvmwLYHTyzR/SC7+/eCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c9UE5aeZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007201F00893;
	Wed, 20 May 2026 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779296002;
	bh=PWeqcZIHR8l0KGf8w37X4PpwaHGOB4/awueto0TrKhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c9UE5aeZbHEVdz7Ta1x2zrbveM3rqxeATnrPQJ8IO+m5SBYO6fv6p7bzDC5fh74eV
	 JorZjENLpBlXGqXrBFr2OoDmyrnesnhg5UeCQr0RneIZDY7l/DRFcKKu8GomjD+o6Q
	 ++7Ac6LzUMFIo3PcplK3JdGRsw63kXUaUzYhhzt4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0633/1146] pinctrl: pinconf-generic: Fully validate pinmux property
Date: Wed, 20 May 2026 18:14:43 +0200
Message-ID: <20260520162202.510781945@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-250667-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DEF3D594E64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

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
index 2b030bd0e6adc..6b4a794a362c0 100644
--- a/drivers/pinctrl/pinconf-generic.c
+++ b/drivers/pinctrl/pinconf-generic.c
@@ -287,12 +287,17 @@ int pinconf_generic_parse_dt_pinmux(struct device_node *np, struct device *dev,
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




