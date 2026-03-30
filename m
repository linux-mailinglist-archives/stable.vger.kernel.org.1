Return-Path: <stable+bounces-230997-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id x4iVBDjqyWmf3QUAu9opvQ
	(envelope-from <stable+bounces-230997-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:12:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B7354FB4
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E9363006B3C
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 03:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A5934CFCF;
	Mon, 30 Mar 2026 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="PyKLoa1F"
X-Original-To: stable@vger.kernel.org
Received: from mail115-171.sinamail.sina.com.cn (mail115-171.sinamail.sina.com.cn [218.30.115.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703A526FA60
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840371; cv=none; b=XlCu10O8C1s8MOp6gfH/KF4su53R8Ysxn0PAIcKAsLd/Swutz4LqlSx7B4qORpwZaHRy0eb/Ny4KiUlfmqTm8eoYznJ5HIvLIlg8r1bKOYo1rClthtr6DU2PdtC558CZETaTcZE3g/YAH2LSpAcp8I2SFPD27nqCc9p2YTexgcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840371; c=relaxed/simple;
	bh=RFRkg9vvZtCs5ostsZHn+LIqfiDU8ZmDXzwHELhjShI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fj1WwivvwpSk8jJzM+FJ+dJD50tzNO80KkxQ/eWpyT13IsucbfDTVta6WVnnhDyMBNcyJ1/g+Y1kAf120Bq2VE+Qp7ZyEydSwp/AuNFtp0bLHpoLeu0t3KwoRVLzvFWVa58M9GJK2hdohix6/WTBa3zSMFSrWOm3T547vf+FGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=PyKLoa1F; arc=none smtp.client-ip=218.30.115.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1774840367;
	bh=HZgwcokYZGMuI58MErcHrI7GQr11ufDPTKrmq95paWw=;
	h=From:Subject:Date:Message-Id;
	b=PyKLoa1FRlAw3AQMdJp8/SQtQV0FzC2RX53XHbWXJfRqz95SeU5ZPpVn0dZ3390Ny
	 FC9TGLsVrxBYDRoAIbyi0P2Qu6dLl62fNaPJ42jOcIoAUw3ILwdWyfQNNQju6S6LbS
	 83lOyMJNoqsVjZtCfQhXkIOb0JVX2dijSlJrxYHU=
X-SMAIL-HELO: pek-lpg-core6.wrs.com
Received: from unknown (HELO pek-lpg-core6.wrs.com)([60.247.85.88])
	by sina.com (10.185.250.24) with ESMTP
	id 69C9EA2200004926; Mon, 30 Mar 2026 11:12:38 +0800 (CST)
X-Sender: johnny_haocn@sina.com
X-Auth-ID: johnny_haocn@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=johnny_haocn@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=johnny_haocn@sina.com
X-SMAIL-MID: 0100810747979
X-SMAIL-UIID: D7FF5ED97C9940BFA791BE59584EAD51-20260330-111239-1
From: Johnny Hao <johnny_haocn@sina.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Navaneeth K <knavaneeth786@gmail.com>,
	stable <stable@kernel.org>,
	Johnny Hao <johnny_haocn@sina.com>
Subject: [PATCH 5.15.y] staging: rtl8723bs: fix out-of-bounds read in rtw_get_ie() parser
Date: Mon, 30 Mar 2026 11:12:31 +0800
Message-Id: <20260330031231.1411491-1-johnny_haocn@sina.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230997-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,sina.com];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnny_haocn@sina.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB2B7354FB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Navaneeth K <knavaneeth786@gmail.com>

[ Upstream commit 154828bf9559b9c8421fc2f0d7f7f76b3683aaed ]

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
[ The context change is due to the commit 4610e57a7d2e
("staging: rtl8723bs: Remove redundant else branches.") in v5.19
which is irrelevant to the logic of this patch. ]
Signed-off-by: Johnny Hao <johnny_haocn@sina.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index b449be537376..fad2004ec59b 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -141,23 +141,24 @@ u8 *rtw_get_ie(u8 *pbuf, signed int index, signed int *len, signed int limit)
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
 		} else {
-			tmp = *(p + 1);
 			p += (tmp + 2);
 			i += (tmp + 2);
 		}
-		if (i >= limit)
-			break;
 	}
 	return NULL;
 }
-- 
2.34.1


