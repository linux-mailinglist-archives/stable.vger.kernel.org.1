Return-Path: <stable+bounces-261340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XlyKNChIJWrZFwIAu9opvQ
	(envelope-from <stable+bounces-261340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:30:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9BE64FB64
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:29:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=11IyC0C0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261340-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-261340-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8F113004D3E
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77023F417;
	Sun,  7 Jun 2026 10:29:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072AF329C57;
	Sun,  7 Jun 2026 10:29:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828175; cv=none; b=EVp542EUPjNa+QKI3icH4rNI4jfw5YTaNTPs7sMJjAMbHyrHaJL2abLOM//UYZr3t94lWt28qoDv69F4+7dxusWkk9IRvoyeHAoaCQqIdajB7jCanIpIT06vkhPC3UWXAD3klGW2OCN7dkQy4in70HUsE6DGwkNJN6m1bDAN+/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828175; c=relaxed/simple;
	bh=m9xpfhA5HSKsxrOAavCS+RFywbCU1TMjwyGKJwWi2FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUuPu97js8i5tpCeGwWISbxgWPyeZZankKCU1HMm4D5XWqowBma9AM/BAbfbXlElYOoY0DW/CpLhGLj2BbWnKkcD2UtnpPYhwcWOS6qcobPeGUdRdTa3hcKEyxjkjkk8ht6ANNJWRu1Va2tyIHxa3BfQymA7wctlzJTXkIu+RGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=11IyC0C0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D1E1F00893;
	Sun,  7 Jun 2026 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780828173;
	bh=0F7PqBRsCyERf+8GJQdAJKGGHAEk5TZZml1cyyqXttc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=11IyC0C0CdIqUH4l5XMpQQz8N6XdaWpydkP+gYKg05xyNWDRJEPaY2nUgD2xJwnD6
	 NQG+5neju6N/cBLcT0MCAyCB1sPTYK2IueQPNlGTjHIV0GHYtRNEAASoO0ZWxuEjaG
	 aniR5BZ/DkicL0RVFHHyU0OazYg9Ox5d0d3Cp/7w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 117/307] HID: core: Fix size_t specifier in hid_report_raw_event()
Date: Sun,  7 Jun 2026 11:58:34 +0200
Message-ID: <20260607095732.063958237@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.647295505@linuxfoundation.org>
References: <20260607095727.647295505@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261340-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:ojeda@kernel.org,m:nathan@kernel.org,m:torvalds@linux-foundation.org,m:lee@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,linux-foundation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF9BE64FB64

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit 4d3a2a466b8d68d852a1f3bbf11204b718428dc4 ]

When building for 32-bit platforms, for which 'size_t' is
'unsigned int', there are warnings around using the incorrect format
specifier to print bsize in hid_report_raw_event():

  drivers/hid/hid-core.c:2054:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
   2053 |                 hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
        |                                                                                         ~~~
        |                                                                                         %zu
   2054 |                                      report->id, csize, bsize);
        |                                                         ^~~~~
  drivers/hid/hid-core.c:2076:29: error: format specifies type 'long' but the argument has type 'size_t' (aka 'unsigned int') [-Werror,-Wformat]
   2075 |                 hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
        |                                                                                          ~~~
        |                                                                                          %zu
   2076 |                                      report->id, rsize, bsize);
        |                                                         ^~~~~

Use the proper 'size_t' format specifier, '%zu', to clear up the
warnings.

Cc: stable@vger.kernel.org
Fixes: 2c85c61d1332 ("HID: pass the buffer size to hid_report_raw_event")
Reported-by: Miguel Ojeda <ojeda@kernel.org>
Closes: https://lore.kernel.org/20260516020430.110135-1-ojeda@kernel.org/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 3ab135238832446399614e7a4bb796d620717806)
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d9ea99cdb68e06..87d990ada8688a 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2015,7 +2015,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		return 0;
 
 	if (unlikely(bsize < csize)) {
-		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
+		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %zu)\n",
 				     report->id, csize, bsize);
 		return -EINVAL;
 	}
@@ -2037,7 +2037,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 		rsize = max_buffer_size;
 
 	if (bsize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
+		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %zu)\n",
 				     report->id, rsize, bsize);
 		return -EINVAL;
 	}
-- 
2.53.0




