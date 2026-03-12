Return-Path: <stable+bounces-224951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAEoAdEes2l/SQAAu9opvQ
	(envelope-from <stable+bounces-224951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:15:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F9F278A6E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 361CB3031330
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA81401A26;
	Thu, 12 Mar 2026 20:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k4u0sKdR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D744F3FF8AD;
	Thu, 12 Mar 2026 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346334; cv=none; b=GrRktwtOB5UgdpVvO+2wlVjACnu4nTlq7rbwOj09ljOuahwfoLF0ais4bDHXffJ/8Ni77xmtY3zJ9eT7wbemQjMn/2jtfEFcATsIOb3GMaw/NujSh0Co/KxJTgHih59DTMjyDeTdxkIjeeczB3YQU5DozdrZwOh0FnHJFPS0Zfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346334; c=relaxed/simple;
	bh=7Fxl7dA6uT7V2BSVPi9y90JwdzzF9W+s0Mzz5pHRUPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVK+QFminOmSFHHTQngTteRJVJLhAs+ak1AvpfOgdYLDA+nvLvpvwSepfzqn90Zb0f/HDNJEYriKyxS28p+jMPTm3xmzctUixCsHeUIFhDffGjJTL5s1lJpqaH+Dw+BxZkIy6ysVVOcCbAOFUBNxou/+Fv1CnWccMcujCN3SERw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k4u0sKdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3B5C4CEF7;
	Thu, 12 Mar 2026 20:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346334;
	bh=7Fxl7dA6uT7V2BSVPi9y90JwdzzF9W+s0Mzz5pHRUPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k4u0sKdRETXsWeAcuW8f1AJ5romjpDXhxr5kXNLe86+KRtFVofYe0ZYR3kXT0k7Az
	 WWUnLZeVTh6YHtF1q+gQ+3FdVmSM4Q3coEe4omDYTcV0tjwi4tI4lWxgDl5UO2859l
	 SL9xwiSqwr5owb7CNK2IdzaFeO0BwF6OcTfNg9yA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Salomon Dushimirimana <salomondush@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 008/265] scsi: pm8001: Fix use-after-free in pm8001_queue_command()
Date: Thu, 12 Mar 2026 21:06:35 +0100
Message-ID: <20260312201018.454970353@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224951-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 93F9F278A6E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Salomon Dushimirimana <salomondush@google.com>

[ Upstream commit 38353c26db28efd984f51d426eac2396d299cca7 ]

Commit e29c47fe8946 ("scsi: pm8001: Simplify pm8001_task_exec()") refactors
pm8001_queue_command(), however it introduces a potential cause of a double
free scenario when it changes the function to return -ENODEV in case of phy
down/device gone state.

In this path, pm8001_queue_command() updates task status and calls
task_done to indicate to upper layer that the task has been handled.
However, this also frees the underlying SAS task. A -ENODEV is then
returned to the caller. When libsas sas_ata_qc_issue() receives this error
value, it assumes the task wasn't handled/queued by LLDD and proceeds to
clean up and free the task again, resulting in a double free.

Since pm8001_queue_command() handles the SAS task in this case, it should
return 0 to the caller indicating that the task has been handled.

Fixes: e29c47fe8946 ("scsi: pm8001: Simplify pm8001_task_exec()")
Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://patch.msgid.link/20260213192806.439432-1-salomondush@google.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm8001_sas.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index 4daab8b6d6752..0f911228cb2f1 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -476,8 +476,9 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
 		} else {
 			task->task_done(task);
 		}
-		rc = -ENODEV;
-		goto err_out;
+		spin_unlock_irqrestore(&pm8001_ha->lock, flags);
+		pm8001_dbg(pm8001_ha, IO, "pm8001_task_exec device gone\n");
+		return 0;
 	}
 
 	ccb = pm8001_ccb_alloc(pm8001_ha, pm8001_dev, task);
-- 
2.51.0




