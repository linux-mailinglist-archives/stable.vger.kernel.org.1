Return-Path: <stable+bounces-237330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PvhLuEi3WkYaQkAu9opvQ
	(envelope-from <stable+bounces-237330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:07:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2AB3F0CB6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 449FB308A7A0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE13191CA;
	Mon, 13 Apr 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2MZg1jNf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B69317152;
	Mon, 13 Apr 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099176; cv=none; b=KA8Ge+m33gUWxszaro/xcjuJWPKx8L1cEeDhrqZc+vjiC4rRZBQlOTHN1ZdSyggMi6L2ZZZQkxS7TeBW2+FDMe7gndo6mJdpI1nt5HjNhPVGYEbP41il2y9yhv6E+mcGPTHV9rFXklYF08tdJUFG7D4rYKoBEmSLeftdD8TmiKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099176; c=relaxed/simple;
	bh=jEZkPXThmJDMW3nFjghRza/E576oUWCsHzXIF54YZCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DApP+U4kpIdgeGhbMqC5Pj2W85HEACjEbDeFFFD5eN/33Bgzw+BzdTomaupK9QMltF7pT9RU7gqAYUBoWyNAGvxKCrcn1pG605BqPWR57Tmampordeu/jhjSFurYsuVz3BJDM4G/MBL2pR9Yq12KUJ3b8egg2IBFPDb9ssy939U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2MZg1jNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDE6C2BCB7;
	Mon, 13 Apr 2026 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099176;
	bh=jEZkPXThmJDMW3nFjghRza/E576oUWCsHzXIF54YZCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2MZg1jNfHnOqNxLr9yCE7uVIQEKX74/VEb2H6rZ7uWvbCh9UZLwUJVSlT2BgOnxJR
	 z9cY0onTdMRf/vf3WUI4UTk5w7V67k9PSomPIxOkp2hPmpN+MCFpQKmdhGxy7JVKPK
	 z2KRTEOh6sXfDQnI4nOzjPj5S2RBG8CCiuuYgdb0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 238/491] HID: asus: avoid memory leak in asus_report_fixup()
Date: Mon, 13 Apr 2026 17:58:03 +0200
Message-ID: <20260413155827.967917253@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237330-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC2AB3F0CB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Günther Noack <gnoack@google.com>

[ Upstream commit 2bad24c17742fc88973d6aea526ce1353f5334a3 ]

The asus_report_fixup() function was returning a newly allocated
kmemdup()-allocated buffer, but never freeing it.  Switch to
devm_kzalloc() to ensure the memory is managed and freed automatically
when the device is removed.

The caller of report_fixup() does not take ownership of the returned
pointer, but it is permitted to return a pointer whose lifetime is at
least that of the input buffer.

Also fix a harmless out-of-bounds read by copying only the original
descriptor size.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Günther Noack <gnoack@google.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-asus.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 2f82946fb36a2..9d425f81d6224 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1116,14 +1116,21 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		 */
 		if (*rsize == rsize_orig &&
 			rdesc[offs] == 0x09 && rdesc[offs + 1] == 0x76) {
-			*rsize = rsize_orig + 1;
-			rdesc = kmemdup(rdesc, *rsize, GFP_KERNEL);
-			if (!rdesc)
-				return NULL;
+			__u8 *new_rdesc;
+
+			new_rdesc = devm_kzalloc(&hdev->dev, rsize_orig + 1,
+						 GFP_KERNEL);
+			if (!new_rdesc)
+				return rdesc;
 
 			hid_info(hdev, "Fixing up %s keyb report descriptor\n",
 				drvdata->quirks & QUIRK_T100CHI ?
 				"T100CHI" : "T90CHI");
+
+			memcpy(new_rdesc, rdesc, rsize_orig);
+			*rsize = rsize_orig + 1;
+			rdesc = new_rdesc;
+
 			memmove(rdesc + offs + 4, rdesc + offs + 2, 12);
 			rdesc[offs] = 0x19;
 			rdesc[offs + 1] = 0x00;
-- 
2.51.0




