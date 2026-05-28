Return-Path: <stable+bounces-255857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM9SJbyoGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:42:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B685F95F7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADBB0302834B
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16699301472;
	Thu, 28 May 2026 20:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LduPH1TH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F322E7379;
	Thu, 28 May 2026 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000071; cv=none; b=AJEsonW2Tkp8Hzwf3K/Eogt03gWYvrYIlxsx+xkcCLXOsrry5BiHhf8Wp4mQSoEL+6YyE4XirvULql93GtJrN/hOP4qjsLsBJgWT2oFFsq2T8RRAgpbQUeZO0DLBmVQbv9xpFw81h5ArRaZDGvRpBBrGNSrcnkkagbAN/QDTR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000071; c=relaxed/simple;
	bh=pOUbmcUVF983iuXdbHFte8XQ1oVo7Nv0Gn5nTfcRXaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj8rdh/uiGc7Vo/JkBtw2XaiE0Y+kl+jZ2GnxNtujw4yCbmzcVbvMzt+/sUeGciRTVM1QZYSjOSe1yWoofHrS9fLSnrUpdRF0d8UpISN6vCrhpZ1zLTqGsHFqN60artzqd/PgqbCZONmj/riLnXaRaKqIKt7DG2qQQY9/SV0QnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LduPH1TH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503CF1F000E9;
	Thu, 28 May 2026 20:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000070;
	bh=Vg+M71KiyBhCMKb4DfGmLtg3Rhcs1h5rLEGkw72CIAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LduPH1TH3UrRx6OWfQ4gIhWXqp7k88EY0rebd5LNLUAEBhUb5Dx/NQLBXESNiapMO
	 QjBoCPM5zdSzu7i5IXjRymyGMXWUGzh5t5/UoCVVBxvzo9wamEPtpFC1ME9RrDC+KV
	 mdp8QKMEcvLJd8scIP/tya8R2WqD/e0S2mnxR0A8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <error27@gmail.com>,
	Mike Christie <michael.christie@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 292/377] scsi: sd: Fix return code handling in sd_spinup_disk()
Date: Thu, 28 May 2026 21:48:50 +0200
Message-ID: <20260528194646.801736709@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oracle.com,acm.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-255857-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,acm.org:email]
X-Rspamd-Queue-Id: 11B685F95F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit 6ea68a8dc7d2711504d944811981a5304af7d7a9 ]

As found by smatch-ci, scsi_execute_cmd() can return negative or positve
values so we should use a int instead of unsigned int.

Fixes: b4d0c33a32c3 ("scsi: sd: Fix sshdr use in sd_spinup_disk")
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/linux-scsi/agFbI7E6JQwd3wGW@stanley.mountain/T/#u
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Link: https://patch.msgid.link/20260511175317.114007-1-michael.christie@oracle.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 072d4c4add334..d9bae23cb929e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2398,8 +2398,7 @@ sd_spinup_disk(struct scsi_disk *sdkp)
 {
 	static const u8 cmd[10] = { TEST_UNIT_READY };
 	unsigned long spintime_expire = 0;
-	int spintime, sense_valid = 0;
-	unsigned int the_result;
+	int the_result, spintime, sense_valid = 0;
 	struct scsi_sense_hdr sshdr;
 	struct scsi_failure failure_defs[] = {
 		/* Do not retry Medium Not Present */
-- 
2.53.0




