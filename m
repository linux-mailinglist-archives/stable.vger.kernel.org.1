Return-Path: <stable+bounces-229456-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKCFDL5kwWkjSwQAu9opvQ
	(envelope-from <stable+bounces-229456-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:05:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A49A2F78A9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 850C8308B1C7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ED63B8BDF;
	Mon, 23 Mar 2026 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lnl8o8OZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F83B8BA4;
	Mon, 23 Mar 2026 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279291; cv=none; b=uxy/4a81CMlCSzVJ9oLrnPbIo0/HXuuU0qjwwM/QKHyKfm3yDMJXkwWxVDBfuD/2DKuXwRV+qydqM7MdzmwqgL6v4dLFAPcc9EYChF5krkbBf6qjNYNZY9BCuOetjWURJE8Jl+qaoubMmNcX4ykfeiv31iburYOobZa++Vk5Iqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279291; c=relaxed/simple;
	bh=jdLC6YuO8fOq/YYALT0DQtrmaqGYkcFtR2u1wz9Tv+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBcQr9SBkQ0zFjRnxcIiUL4SFlpNiad87UawTq0mWpzSzVDyrvQKN2ec/YeCU5PdrIbRlKHKyNLf616NdBHV0BLLroaPwOcCXsPEUA5Hi4RHvRoCLByBvxt3aXP2MTkcHoCJ1L3vNFyLRcXmcMunxEabRGMACFL27OqxU9ztecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lnl8o8OZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37BFC2BCB1;
	Mon, 23 Mar 2026 15:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774279291;
	bh=jdLC6YuO8fOq/YYALT0DQtrmaqGYkcFtR2u1wz9Tv+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lnl8o8OZKLUIVjwKSln60lNL3J+4VZ7InZWSbh4B6dvnVg4av33TuJ9uP3rxOE6Nd
	 UDDlNW7/yNiwUy230uLPGUj5++7pJJFff2IKlU9gVIXJ7Ai0eC0cIqGVPoyMsa9R6U
	 j77T7P9yt0fq/M+CnhQnrE1CRzhg0/VHY88X/7Ok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 536/567] ACPI: processor: Fix previous acpi_processor_errata_piix4() fix
Date: Mon, 23 Mar 2026 14:47:36 +0100
Message-ID: <20260323134547.264581110@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-229456-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,roeck-us.net:email]
X-Rspamd-Queue-Id: 9A49A2F78A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit bf504b229cb8d534eccbaeaa23eba34c05131e25 ]

After commi f132e089fe89 ("ACPI: processor: Fix NULL-pointer dereference
in acpi_processor_errata_piix4()"), device pointers may be dereferenced
after dropping references to the device objects pointed to by them,
which may cause a use-after-free to occur.

Moreover, debug messages about enabling the errata may be printed
if the errata flags corresponding to them are unset.

Address all of these issues by moving message printing to the points
in the code where the errata flags are set.

Fixes: f132e089fe89 ("ACPI: processor: Fix NULL-pointer dereference in acpi_processor_errata_piix4()")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/linux-acpi/938e2206-def5-4b7a-9b2c-d1fd37681d8a@roeck-us.net/
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/5975693.DvuYhMxLoT@rafael.j.wysocki
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_processor.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 5e409f86f0709..55f0ea3535055 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -102,6 +102,10 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 				     PCI_ANY_ID, PCI_ANY_ID, NULL);
 		if (ide_dev) {
 			errata.piix4.bmisx = pci_resource_start(ide_dev, 4);
+			if (errata.piix4.bmisx)
+				dev_dbg(&ide_dev->dev,
+					"Bus master activity detection (BM-IDE) erratum enabled\n");
+
 			pci_dev_put(ide_dev);
 		}
 
@@ -120,20 +124,17 @@ static int acpi_processor_errata_piix4(struct pci_dev *dev)
 		if (isa_dev) {
 			pci_read_config_byte(isa_dev, 0x76, &value1);
 			pci_read_config_byte(isa_dev, 0x77, &value2);
-			if ((value1 & 0x80) || (value2 & 0x80))
+			if ((value1 & 0x80) || (value2 & 0x80)) {
 				errata.piix4.fdma = 1;
+				dev_dbg(&isa_dev->dev,
+					"Type-F DMA livelock erratum (C3 disabled)\n");
+			}
 			pci_dev_put(isa_dev);
 		}
 
 		break;
 	}
 
-	if (ide_dev)
-		dev_dbg(&ide_dev->dev, "Bus master activity detection (BM-IDE) erratum enabled\n");
-
-	if (isa_dev)
-		dev_dbg(&isa_dev->dev, "Type-F DMA livelock erratum (C3 disabled)\n");
-
 	return 0;
 }
 
-- 
2.51.0




