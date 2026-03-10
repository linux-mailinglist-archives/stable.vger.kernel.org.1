Return-Path: <stable+bounces-224172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD40BRP/r2mQeQIAu9opvQ
	(envelope-from <stable+bounces-224172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 799AB24A89B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 130A530DB61A
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F138BF94;
	Tue, 10 Mar 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfrOY970"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79A313E3B;
	Tue, 10 Mar 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141302; cv=none; b=lLQqsOE5KY137QiuJYBjfhN46/JNYCjUnJ+eiGiO7QdZmWASw75Ny/bZQ69h+kk+/l6sIDTVvI3gqIdovqfp/rwG9iLH1ewptEWMLQxgTI20kJTZ+5YkyZEv0B7pG57LcFM3rOMFd8abZgpzRIpjH5wATpxZjK4kcQff3EWe01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141302; c=relaxed/simple;
	bh=Jgj6WcJHSk+ogAnQ8GF87BlSHqpkJHVxuq4jfvRDZFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZydkD+BH2T+Ea5Gu+o9RoN/XcVpzC204MJOsw6cDgm1PZ3KnD27D3EiiXX8c+VaxcZBVeY96eyEgnKa/DoGumEA+Ku+FJdsu556ZmGNYlbWrVyJ9OUZKoS7FxfuCiuR/vI03OLs4QvZxUn+/qM/Xp1We1U+jWLjuccBrjDZu/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfrOY970; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170D2C19423;
	Tue, 10 Mar 2026 11:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141302;
	bh=Jgj6WcJHSk+ogAnQ8GF87BlSHqpkJHVxuq4jfvRDZFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cfrOY9702KeHyhUOVzxLHw5UoN0XHGayLQsIoTp1LH7JMMXkYLIffQU+N9jjzM58U
	 hBOKX8hZEeT894FIsrI1HkqKE6k/0d0oTD0njV9s7QVF0SxWVyGxKUTkytQrViMqhu
	 BAcQd7clbLL3ER/5mJm3sPJX7MGPwB8+3KelHsdrmeVhN+puaHrb229Gay69uhp8sw
	 gOTNd6+2Ok8nzg2SQ1skbVNya0PW1KtkSyx4CGJWLW0tOPuPjt3KTqdFRVIVU33N2W
	 6AiUsEj6V0QZO+24iwXoz0LgclkP4Y/Iw1GCkg+7yue2LA+ecO1t2ftM7frnCmpzoi
	 GpwenSk84/KqA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 307/311] ata: libata-eh: Fix detection of deferred qc timeouts
Date: Tue, 10 Mar 2026 07:05:54 -0400
Message-ID: <bc9fda9f079448f6970a3fc8ce63c8456924618f.1773140656.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 799AB24A89B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224172-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit ee0e6e69a772d601e152e5368a1da25d656122a8 ]

If the ata_qc_for_each_raw() loop finishes without finding a matching SCSI
command for any QC, the variable qc will hold a pointer to the last element
examined, which has the tag i == ATA_MAX_QUEUE - 1. This qc can match the
port deferred QC (ap->deferred_qc).

If that happens, the condition qc == ap->deferred_qc evaluates to true
despite the loop not breaking with a match on the SCSI command for this QC.
In that case, the error handler mistakenly intercepts a command that has
not been issued yet and that has not timed out, and thus erroneously
returning a timeout error.

Fix the problem by checking for i < ATA_MAX_QUEUE in addition to
qc == ap->deferred_qc.

The problem was found by an experimental code review agent based on
gemini-3.1-pro while reviewing backports into v6.18.y.

Assisted-by: Gemini:gemini-3.1-pro
Fixes: eddb98ad9364 ("ata: libata-eh: correctly handle deferred qc timeouts")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[cassel: modified commit log as suggested by Damien]
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/libata-eh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 563432400f727..23be85418b3b1 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -647,7 +647,7 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 				break;
 		}
 
-		if (qc == ap->deferred_qc) {
+		if (i < ATA_MAX_QUEUE && qc == ap->deferred_qc) {
 			/*
 			 * This is a deferred command that timed out while
 			 * waiting for the command queue to drain. Since the qc
-- 
2.51.0


