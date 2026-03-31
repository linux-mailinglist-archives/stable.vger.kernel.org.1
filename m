Return-Path: <stable+bounces-232009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN0jGhkBzGk8NQYAu9opvQ
	(envelope-from <stable+bounces-232009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:15:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9834936E4DF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D167F306183C
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF6E41B342;
	Tue, 31 Mar 2026 16:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZyzteeJp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68EF2D1F40;
	Tue, 31 Mar 2026 16:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975639; cv=none; b=cA/uFvBpBiURBLFjvG/pFgwqaA0zVsjsi6DA9zMJekNpWYuXAMC3RM/l3Hn20AkxHJuijWTH/HedRqjgpvvxal2wWhFzJ2e14jqwMpTVVtk5SZ0yyqX/uaHC0rS2gK57IgfuL6ytXhgi+b3vZevawAgcr7EVHzazRqO8sVihXOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975639; c=relaxed/simple;
	bh=80HFVsVIEV2t/qXgGsQv7za8DYHy0jwmTIGZPTLd01o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lg4fLQiKozIukHU/8EVBU6wNybpE0oVDNR2UnZJf0EGKsWduor2qrazsI2SFRWObtTo5NG166rcR4IZJBjxMu3mSTTZHjm4cUXUGz18CCSEnDV8BasDdwf7VuxG8yAW3WCIn1J6T63HQlu+uREV3siXDDqFexGGnyuHFLcWEFCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZyzteeJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C97AC19423;
	Tue, 31 Mar 2026 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975639;
	bh=80HFVsVIEV2t/qXgGsQv7za8DYHy0jwmTIGZPTLd01o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZyzteeJpwaYwOtz1lEChdNj0VCVwrZ9DBZU6An97IpuSbMG5sm2+XRIR58smrhhhd
	 yoEYrMgRYIIAXqgt3/vFnNwbrpYafGEnhAA1ggNzivZnFOCphHlOpoItgSjdfGsKwI
	 jNBl/EdeFcGXwmZ7dKH6IypDUH+QcVu8szwhOXKY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fuchs <fuchsfl@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 029/244] scsi: devinfo: Add BLIST_SKIP_IO_HINTS for Iomega ZIP
Date: Tue, 31 Mar 2026 18:19:39 +0200
Message-ID: <20260331161742.778208735@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-232009-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oracle.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,oracle.com:email]
X-Rspamd-Queue-Id: 9834936E4DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fuchs <fuchsfl@gmail.com>

[ Upstream commit 80bf3b28d32b431f84f244a8469488eb6d96afbb ]

The Iomega ZIP 100 (Z100P2) can't process IO Advice Hints Grouping mode
page query. It immediately switches to the status phase 0xb8 after
receiving the subpage code 0x05 of MODE_SENSE_10 command, which fails
imm_out() and turns into DID_ERROR of this command, which leads to unusable
device. This was tested with an Iomega ZIP 100 (Z100P2) connected with a
StarTech PEX1P2 AX99100 PCIe parallel port card.

Prior to this fix, Test Unit Ready fails and the drive can't be used:
        IMM: returned SCSI status b8
        sd 7:0:6:0: [sdh] Test Unit Ready failed: Result: hostbyte=0x01 driverbyte=DRIVER_OK

Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
Link: https://patch.msgid.link/20260227181823.892932-1-fuchsfl@gmail.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_devinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 90f1393a23f87..3cdc4cd4b1639 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -190,7 +190,7 @@ static struct {
 	{"IBM", "2076", NULL, BLIST_NO_VPD_SIZE},
 	{"IBM", "2105", NULL, BLIST_RETRY_HWERROR},
 	{"iomega", "jaz 1GB", "J.86", BLIST_NOTQ | BLIST_NOLUN},
-	{"IOMEGA", "ZIP", NULL, BLIST_NOTQ | BLIST_NOLUN},
+	{"IOMEGA", "ZIP", NULL, BLIST_NOTQ | BLIST_NOLUN | BLIST_SKIP_IO_HINTS},
 	{"IOMEGA", "Io20S         *F", NULL, BLIST_KEY},
 	{"INSITE", "Floptical   F*8I", NULL, BLIST_KEY},
 	{"INSITE", "I325VM", NULL, BLIST_KEY},
-- 
2.51.0




