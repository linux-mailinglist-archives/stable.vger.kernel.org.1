Return-Path: <stable+bounces-207244-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D2D09A72
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D61A30EA2FF
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0EF35A933;
	Fri,  9 Jan 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P/Oyn3t2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0BA1531E8;
	Fri,  9 Jan 2026 12:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961504; cv=none; b=YodR19ewlol654/Wn9mDFRFrLwT7f5QzNE1s617+Oz+nR9/MTzBBubBt40LEV+Ct6OZmC72lPpFkBD5xAq3ASIduewvp3a6RChKlPOduifLMt2nF5lDCmWqeIrlgJ7QNKMfgQj2st1cKYt3UZnOETqrBKlC6cbfTEjc8bZZ1t9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961504; c=relaxed/simple;
	bh=UV35zs1fZVvJEBGx3Ghf2ll63yNdzr103/Nq8QaqSsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cedr0FhZA/qBf47e9AdaSejIwdA3M4xSxSV/dBvqmSn117Qk7wFuxFllTAnpakbG1pei49iwK7XWGHeMmsTq77c488d3uZ1u7ZGUqydzeFqX94NwLiGGGAxL/kK9nu3avSlw6QsLOY/2oqsIXs620dmCm8/TCc5NGHr10HI+Iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P/Oyn3t2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC66BC4CEF1;
	Fri,  9 Jan 2026 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767961504;
	bh=UV35zs1fZVvJEBGx3Ghf2ll63yNdzr103/Nq8QaqSsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/Oyn3t27+BDDcSgyHOY1hdMQ8ML+xen6PvcErWZIWbjAKGVvcEltxAW2gIOhVAQB
	 2oScn2Bbma3VoHG0aMURKE5NaV++OsjA5S0SnHgXJX0tt6mFWGMcSXgOmmohYYVT1b
	 NVbhrUyXw1HsaAOYBCkCch9y/GOcPYnFzGiGSPNk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Navaneeth K <knavaneeth786@gmail.com>,
	stable <stable@kernel.org>
Subject: [PATCH 6.1 038/634] staging: rtl8723bs: fix out-of-bounds read in rtw_get_ie() parser
Date: Fri,  9 Jan 2026 12:35:16 +0100
Message-ID: <20260109112118.881648966@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109112117.407257400@linuxfoundation.org>
References: <20260109112117.407257400@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Navaneeth K <knavaneeth786@gmail.com>

commit 154828bf9559b9c8421fc2f0d7f7f76b3683aaed upstream.

The Information Element (IE) parser rtw_get_ie() trusted the length
byte of each IE without validating that the IE body (len bytes after
the 2-byte header) fits inside the remaining frame buffer. A malformed
frame can advertise an IE length larger than the available data, causing
the parser to increment its pointer beyond the buffer end. This results
in out-of-bounds reads or, depending on the pattern, an infinite loop.

Fix by validating that (offset + 2 + len) does not exceed the limit
before accepting the IE or advancing to the next element.

This prevents OOB reads and ensures the parser terminates safely on
malformed frames.

Signed-off-by: Navaneeth K <knavaneeth786@gmail.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -139,22 +139,24 @@ u8 *rtw_get_ie(u8 *pbuf, signed int inde
 	signed int tmp, i;
 	u8 *p;
 
-	if (limit < 1)
+	if (limit < 2)
 		return NULL;
 
 	p = pbuf;
 	i = 0;
 	*len = 0;
-	while (1) {
+	while (i + 2 <= limit) {
+		tmp = *(p + 1);
+		if (i + 2 + tmp > limit)
+			break;
+
 		if (*p == index) {
-			*len = *(p + 1);
+			*len = tmp;
 			return p;
 		}
-		tmp = *(p + 1);
+
 		p += (tmp + 2);
 		i += (tmp + 2);
-		if (i >= limit)
-			break;
 	}
 	return NULL;
 }



