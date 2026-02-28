Return-Path: <stable+bounces-220308-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAsSOqAwo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220308-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:14:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0781C592A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9000130A66D8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986F838F626;
	Sat, 28 Feb 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5ozrEm7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B21947ECD3;
	Sat, 28 Feb 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300211; cv=none; b=q/GkReCPLhUr7w+MSxk9SvGe0rNY1XQFqydKBcx8MHfNJzkRQ38YhHw+sA4UQ45la/xBvo8fpgxn2S23VCgd7moCGvFBT37YfIDL7yhRZNhyMx/wLtiqCYghQiWzGCdW8l/haGCyWUO94cju3fbpSgrT6uMNYAn8E8jOcJpUXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300211; c=relaxed/simple;
	bh=HF6QJLMj4durEMEEyikGQooFujvgeRlZgDckJosIKhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiPrz8mTBnbkBZCFkC/WzcFnJMer7CRvPbUVO97jGLBoh0ZBgMRqe+kHHFu/53h+sbMDWkhrXgdmzUPuAP897GUD1P4aPs78ID+ssPQv/wHCZklYKztnX7Ksk8F4d3NdsbemCML//KYjL27To2qGDcZaXJWGu/k4wTEyYvBsmcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5ozrEm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2067C19424;
	Sat, 28 Feb 2026 17:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300211;
	bh=HF6QJLMj4durEMEEyikGQooFujvgeRlZgDckJosIKhI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5ozrEm7yI0GipWwvlgM0pryYHGPQyMjrPo42qK/dQhnhXlwgyrjFjssiPyIxPZ55
	 UwMVhJjJ4lM7N5sX+OEPF5++VOlegjufYtrkjzhhkweF2qQuEvPXqKMEO+aAC3qYLJ
	 Z9E5tkjnECXJPdwoSDF4rISss7dbd22ImaivfzaNrIYmzcNhB3cjjaiqlXwq/A0jUY
	 xijn+Gb47hthxeT3v13ej703/Ucjj7dvoM+37e2jTGihOt81j7gdqXuiSqjiadg/eu
	 s9kgfYW4sUGPPS/YLWoWvf9dHOaEmXlx1NcI8ib/D4OmKZXe8H5CAyZvr6mtHY0Aef
	 CKDviwXJV0G5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Anj Duvnjak <avian@extremenerds.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 230/844] hwmon: (nct6683) Add customer ID for ASRock Z590 Taichi
Date: Sat, 28 Feb 2026 12:22:23 -0500
Message-ID: <20260228173244.1509663-231-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220308-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,roeck-us.net:email]
X-Rspamd-Queue-Id: 8D0781C592A
X-Rspamd-Action: no action

From: Anj Duvnjak <avian@extremenerds.net>

[ Upstream commit c0fa7879c9850bd4597740a79d4fac5ebfcf69cc ]

Add support for customer ID 0x1621 found on ASRock Z590 Taichi
boards using the Nuvoton NCT6686D embedded controller.

This allows the driver to instantiate without requiring the
force=1 module parameter.

Tested on two separate ASRock Z590 Taichi boards, both with
EC firmware version 1.0 build 01/25/21.

Signed-off-by: Anj Duvnjak <avian@extremenerds.net>
Link: https://lore.kernel.org/r/20251222220942.10762-1-avian@extremenerds.net
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/hwmon/nct6683.rst | 1 +
 drivers/hwmon/nct6683.c         | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/hwmon/nct6683.rst b/Documentation/hwmon/nct6683.rst
index 3e549ba95a15a..45eec9dd349aa 100644
--- a/Documentation/hwmon/nct6683.rst
+++ b/Documentation/hwmon/nct6683.rst
@@ -65,6 +65,7 @@ AMD BC-250			NCT6686D EC firmware version 1.0 build 07/28/21
 ASRock X570			NCT6683D EC firmware version 1.0 build 06/28/19
 ASRock X670E			NCT6686D EC firmware version 1.0 build 05/19/22
 ASRock B650 Steel Legend WiFi	NCT6686D EC firmware version 1.0 build 11/09/23
+ASRock Z590 Taichi		NCT6686D EC firmware version 1.0 build 01/25/21
 MSI B550			NCT6687D EC firmware version 1.0 build 05/07/20
 MSI X670-P			NCT6687D EC firmware version 0.0 build 09/27/22
 MSI X870E			NCT6687D EC firmware version 0.0 build 11/13/24
diff --git a/drivers/hwmon/nct6683.c b/drivers/hwmon/nct6683.c
index 6cda35388b24c..4a83804140386 100644
--- a/drivers/hwmon/nct6683.c
+++ b/drivers/hwmon/nct6683.c
@@ -181,6 +181,7 @@ superio_exit(int ioreg)
 #define NCT6683_CUSTOMER_ID_ASROCK2	0xe1b
 #define NCT6683_CUSTOMER_ID_ASROCK3	0x1631
 #define NCT6683_CUSTOMER_ID_ASROCK4	0x163e
+#define NCT6683_CUSTOMER_ID_ASROCK5	0x1621
 
 #define NCT6683_REG_BUILD_YEAR		0x604
 #define NCT6683_REG_BUILD_MONTH		0x605
@@ -1242,6 +1243,8 @@ static int nct6683_probe(struct platform_device *pdev)
 		break;
 	case NCT6683_CUSTOMER_ID_ASROCK4:
 		break;
+	case NCT6683_CUSTOMER_ID_ASROCK5:
+		break;
 	default:
 		if (!force)
 			return -ENODEV;
-- 
2.51.0


