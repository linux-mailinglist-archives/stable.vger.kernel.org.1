Return-Path: <stable+bounces-240287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG5DCNZ36GmVKgIAu9opvQ
	(envelope-from <stable+bounces-240287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:25:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CE7442EBC
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 09:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F625304AAD0
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 07:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2A9370D43;
	Wed, 22 Apr 2026 07:20:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6734E35AC3E;
	Wed, 22 Apr 2026 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776842431; cv=none; b=ioZpB34nIpvQkDqlUc/bCHWQ4vH6suYwvG/NI9cefP0G6uPwPw8+qynN3SWSRneZp8gZe3XfJBJT7zmUhdLwLXgToDpQiTAHP1oiuwancOgWsSo4w6q3oWMP2BeZktamM5w345pl7P+zNxCBfG8sViYm1xoom7V2z1FoGMSI2KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776842431; c=relaxed/simple;
	bh=QRtIgV4x9+6CYTWFtHRGgz6SzZpqQ+7fNEGQxfdJHZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sQ5OI3M/eb735i0Txbr4ytSmDF9ASRE9xKgBnyQduDIe22zSU3FePPUneTyWGoA3SrhNzn7NEuO1vYv+iQ4Dg1NoKxoZuBdPCcSmoBLQ3cNXZw9lHwcmV0Kl7YTPHA8uusUOaFAhVVskJvH0WtGRziLIpgZx5w/+Q205ehe6tY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpsz3t1776842330td48872f5
X-QQ-Originating-IP: v0j4EOrzRINB0pfmcQ4ZtBVVfMZ/+x7k2qt+NRXUHWA=
Received: from w-MS-7E16.trustnetic.com ( [36.24.64.215])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Apr 2026 15:18:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1675610184200092300
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: txgbe: fix firmware version check
Date: Wed, 22 Apr 2026 15:18:37 +0800
Message-ID: <C787AA5C07598B13+20260422071837.372731-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: OPHbpUvlYj5kH4k9x256hTf6+Ec5qQunaVEmOLKBxuAFzmZGhwARQlXz
	JKXLMci8Al7LOybI/39YX2LiT7fALQazGThmjnyuojZdsPgmWNg8NG/d4qbLd3uTX2RGuIf
	eL7+QPJZ+yi7OcjdSvaxqU+B6sE1ZPSxNZyxe0kJWeW3+yU4UQnpnRu35A88wtlAm4mLjzR
	rYUNpcanNTSN2KimG28zoIJSZBsswHSBG58mOelkiW7BrJ8xuO0JxBoEZ1Im2blDLEzxSNy
	q0WJJ1xqHU9a67XMMKb7FZvApkiy2Wyr5bKvAbsnobNlnGexYtFHb+EWO+W1BRefIUg5IUc
	d/tIVC15GzuwxLjd/F51hsMM/G2YQM/TVwrzW3yjVJlMLZ/LjxNDSQ7CFvbBdueBXvEZoGI
	jPHzZwGQ0Tljp/oAxc8mPkR/NFhLxZrs5ZbhWEBKlcEm6USke6p+muGi0x0Mr0jxf2QHdOC
	WApkowWLi0G/q1rBViFk7uJY7WNUe32Aw1ks3Bh1aznHZXFl0FiJpVNqB/zYpaOcSUOlwk3
	r+6cl5+PJh8s/5WNwiHv8SvSMDDYQQWHL/KGdAg2cQ6BPONmQ5j6YzJrjeTEuieRNDZ6uYq
	oVv9V9VaJEjXxzBx6jqWb+ct7EsgxT1MS+dBJPmi1D8lMDgI5qYLHCYQY8eUBxHQiF7xoyT
	0ikrGAQkwUSWtuD/AQ0AUObRaoT/mxj6Kk8F62RoVLQvZrOdiWLEpzOyF3AaMk0l3fLCnQE
	cSoH3aDit/hfR/efb4qw+f+CAF3dm2FWWnSe5xx18aVxH0EY3W3fB3Wmby9xwwOGOIg4Oze
	jBvdO/kPweLQJJIyZXCULdT2zx9CBljqyk2I/VGng4K9oMCcH0o4mXGbeNjDrA8fWmySGZG
	AqfSHZT8xSXIT8QujKL9ewtcSkI7qvhZxOY5iM7X5X71jQTo4OvmJ0lYTmaSDl90Vq3Wpmk
	nUsbyKqIuwP4QfWz9FK2xIh8eMjfL4uZXHSXBe/M87Ef2YN6aSLE0J+/TzD3s7EpT5ii5KG
	Wp2v6W4n6axmFtbRGzzrtq+XOPml6qkvuhOmECwdgfcoQYIyrd2OvSADvTo7k=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240287-lists,stable=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid,trustnetic.com:email]
X-Rspamd-Queue-Id: 77CE7442EBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For the device SP, the firmware version is a 32-bit value where the
lower 20 bits represent the base version number. And the customized
firmware version populates the upper 12 bits with a specific
identification number.

For other devices AML 25G and 40G, the upper 12 bits of the firmware
version is always non-zero, and they have other naming conventions.

Only SP devices need to check this to tell if XPCS will work properly.
So the judgement of MAC type is added here.

And the original logic compared the entire 32-bit value against 0x20010,
which caused the outdated base firmwares bypass the version check
without a warning. Apply a mask 0xfffff to isolate the lower 20 bits for
an accurate base version comparison.

Fixes: ab928c24e6cd ("net: txgbe: add FW version warning")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ec32a5f422f2..8b7c3753bb6a 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -864,7 +864,8 @@ static int txgbe_probe(struct pci_dev *pdev,
 			 "0x%08x", etrack_id);
 	}
 
-	if (etrack_id < 0x20010)
+	if (wx->mac.type == wx_mac_sp &&
+	    ((etrack_id & 0xfffff) < 0x20010))
 		dev_warn(&pdev->dev, "Please upgrade the firmware to 0x20010 or above.\n");
 
 	err = txgbe_test_hostif(wx);
-- 
2.51.0


