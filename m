Return-Path: <stable+bounces-239573-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHYOHdZl5mlmvwEAu9opvQ
	(envelope-from <stable+bounces-239573-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:43:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3790431EF4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 559CF316E176
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB1122259F;
	Mon, 20 Apr 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YBpn1gkn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BE322749;
	Mon, 20 Apr 2026 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700599; cv=none; b=ltT100e3nCEkIO3BMvj8Y57uVPbg9+ID8Tbxvxo1+iJrISqEas3K34EoCWztTMw5rBL6DdhD9yz7nA3fxwW7JsxFAW+0Vogcru4XYQz5nBK9KyrQoaJIGLT5XdFHnnb2PNRhBtSKbslIoRlmZRnNWEIYZe69J8w2falx8FJDUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700599; c=relaxed/simple;
	bh=XPRRB5yWtMSGu39NxauxbWtVa4n45Lvl4ImRoh3tRE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rtxJSHip/usTnnU2BS8TjkDPxEglr+APixTNJ3Yf9sMS+VZx58VNkYzEsTTx8uFk1ndUxUZrsYYfW3fBQ/y9kktlzr60Kxiyu3rgMjB1aze0ua9IGC9nhFYfOxijdolLqi5l4NIenDsXkBNNI4PQEF7jYC+tCEf2uBSFRJyNHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YBpn1gkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071B8C19425;
	Mon, 20 Apr 2026 15:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700599;
	bh=XPRRB5yWtMSGu39NxauxbWtVa4n45Lvl4ImRoh3tRE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YBpn1gknYLaw6AO+vsT1ns8CKuoZSQQ+98uv72pKuMQDoNZZTMRBVD/6EUwuarJ/t
	 AcfscLpF0cSsh4vxR5pBgN3bhvhV1hcuAI8iwff29bYjG26IIO6t2RLzllb2qeO6NR
	 8cqVz9qFFq8BB4ghzT9eWqHbOLlHi3yB4KZkJOSs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Denis Benato <denis.benato@linux.dev>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 015/198] platform/x86: asus-nb-wmi: add DMI quirk for ASUS ROG Flow Z13-KJP GZ302EAC
Date: Mon, 20 Apr 2026 17:39:54 +0200
Message-ID: <20260420153936.165615305@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239573-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D3790431EF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Schwartz <matthew.schwartz@linux.dev>

[ Upstream commit 0198d2743207d67f995cd6df89e267e1b9f5e1f1 ]

The ASUS ROG Flow Z13-KJP GZ302EAC model uses sys_vendor name ASUS
rather than ASUSTeK COMPUTER INC., but it needs the same folio quirk as
the other ROG Flow Z13. To keep things simple, just match on sys_vendor
ASUS since it covers both.

Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Denis Benato <denis.benato@linux.dev>
Link: https://patch.msgid.link/20260312212246.1608080-1-matthew.schwartz@linux.dev
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 6a62bc5b02fda..8dad7bdb8f612 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -548,7 +548,7 @@ static const struct dmi_system_id asus_quirks[] = {
 		.callback = dmi_matched,
 		.ident = "ASUS ROG Z13",
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUS"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "ROG Flow Z13"),
 		},
 		.driver_data = &quirk_asus_z13,
-- 
2.53.0




