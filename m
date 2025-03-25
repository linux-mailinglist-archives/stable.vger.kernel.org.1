Return-Path: <stable+bounces-126001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AC4A6ECEA
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 10:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC225188CDC2
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 09:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D211DE8AF;
	Tue, 25 Mar 2025 09:45:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx2.aip.ooo (mx2.aip.ooo [185.232.107.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475481DB125;
	Tue, 25 Mar 2025 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.232.107.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895946; cv=none; b=FRr7j7c69XmJoiFRrJycSRhzi98HI1qG3m1bVnyTMlmadEPRm5bWlMMFLmfumSsZauTr2Uz7YLzolMEay8oEOPUa9RShoi0peKB40/el+AOZkvWp0rL+s9uhrkXVQ3LdSqVd8pBR6lshRXVLg97iaUuHfjkrSM15dQnK2+SpIhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895946; c=relaxed/simple;
	bh=hHMCEXxzUqIp7Lmp8dSlKc13OfFAgtId5ffLRKJJG+8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dDVCw28jn+huseZdVgRBDK9sE2/2W44zUcWNQjW0+fYdQEC8hzGFmURbnK9bo+HqItd2Geb2aLGdUc6OZtFpjChR5rmnj10oNyaaFTrjcUzFM2I1i42xqfHyTynTg/rak1FFDC05HSRxmRYB3K9rWiWmBxSRRNqu/ZCjf87eIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cyberprotect.ru; spf=pass smtp.mailfrom=cyberprotect.ru; arc=none smtp.client-ip=185.232.107.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cyberprotect.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberprotect.ru
Received: from aip-exch-2.aip.ooo ([10.77.28.102] helo=aip-exch.aip.ooo)
	by mx2.aip.ooo with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <Pavel.Paklov@cyberprotect.ru>)
	id 1tx0VW-004s05-AC; Tue, 25 Mar 2025 12:23:38 +0300
Received: from 10.77.154.78 (10.77.154.78) by AIP-EXCH-2.aip.ooo
 (10.77.28.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Mar
 2025 12:23:37 +0300
From: Pavel Paklov <Pavel.Paklov@cyberprotect.ru>
To: Joerg Roedel <joro@8bytes.org>
CC: <pavel.paklov@cyberprotect.ru>, Pavel Paklov
	<Pavel.Paklov@cyberprotect.ru>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Wan Zongshun <Vincent.Wan@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
Subject: [PATCH] iommu/amd: Fix potential buffer overflow in parse_ivrs_acpihid
Date: Tue, 25 Mar 2025 09:22:44 +0000
Message-ID: <20250325092259.392844-1-Pavel.Paklov@cyberprotect.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-SA-Exim-Connect-IP: 10.77.28.102
X-SA-Exim-Mail-From: Pavel.Paklov@cyberprotect.ru
X-SA-Exim-Scanned: No (on mx2.aip.ooo); SAEximRunCond expanded to false

There is a string parsing logic error which can lead to an overflow of hid
or uid buffers. Comparing ACPIID_LEN against a total string length doesn't
take into account the lengths of individual hid and uid buffers so the
check is insufficient in some cases. For example if the length of hid 
string is 4 and the length of the uid string is 260, the length of str 
will be equal to ACPIID_LEN + 1 but uid string will overflow uid buffer 
which size is 256.

The same applies to the hid string with length 13 and uid string with 
length 250.

Check the length of hid and uid strings separately to prevent 
buffer overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ca3bf5d47cec ("iommu/amd: Introduces ivrs_acpihid kernel parameter")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Paklov <Pavel.Paklov@cyberprotect.ru>
---
 drivers/iommu/amd/init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cb536d372b12..fb82f8035c0f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3677,6 +3677,14 @@ static int __init parse_ivrs_acpihid(char *str)
 	while (*uid == '0' && *(uid + 1))
 		uid++;
 
+	if (strlen(hid) >= ACPIHID_HID_LEN) {
+		pr_err("Invalid command line: hid is too long\n");
+		return 1;
+	} else if (strlen(uid) >= ACPIHID_UID_LEN) {
+		pr_err("Invalid command line: uid is too long\n");
+		return 1;
+	}
+
 	i = early_acpihid_map_size++;
 	memcpy(early_acpihid_map[i].hid, hid, strlen(hid));
 	memcpy(early_acpihid_map[i].uid, uid, strlen(uid));
-- 
2.43.0


