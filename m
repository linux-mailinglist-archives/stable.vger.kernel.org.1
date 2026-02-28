Return-Path: <stable+bounces-220163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBB8Ancto2me+AQAu9opvQ
	(envelope-from <stable+bounces-220163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:01:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F81C554D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B04823109003
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349D3494A1E;
	Sat, 28 Feb 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad2/hYTj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EF34963BE;
	Sat, 28 Feb 2026 17:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300071; cv=none; b=Pt+OTZAU64j5UHYtCrsMOiwuv5j+h6uZo/bU1bHE7dHR9CtdBf4Z680QaqG3eQIkiyljqpX3CdcO0iG6nEajyIr/mAHGQx+idl4mXqorfgbFHJzb6fVdCwNBytvLBI23VJfFl8q82BAQR5/F4gFgGqh0B5Sw+SGRIOBozoxZNhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300071; c=relaxed/simple;
	bh=yL/3J+Kc+ufBQbQo8CUEsiiz0KXUEBwUey7O3oZpMAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVxJqkVgoygajIf8B/l8r1DiV/NQeIs6jQ4LOvr93W5PYoIWSigz68DmoBDIQtloCrR9H1lsn3+2hfpYBfpngDfAjYx4hwuleG6YaH521g7Mol0DVrnyK5+Aw+Pg9Zcvk4d8FgXHvXZyvyjo87acQCJ9WrgQyuX+eCRmPBl5gA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad2/hYTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D069C19424;
	Sat, 28 Feb 2026 17:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300070;
	bh=yL/3J+Kc+ufBQbQo8CUEsiiz0KXUEBwUey7O3oZpMAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ad2/hYTjInBeOyrWpHsERcZ2yiK9+pB84MpCKTxG54ROmfQo8FUWoPJML0Z7HGr38
	 Fqo1r4wZr1dQz3bTgOFz+sLNY7ddIoAPP4kHKaKn1EUnvna9CqG3Qv/v5dOlzbrbKo
	 v/sCimfBD8etOiGxK0tV8n7lZfkvQW6h8ZLGRMjUnJF2H+afgiAEYcenZpBRCea4tS
	 lVwSCafdHMaWAsTyAzp3DAUTPxyj6rVAFeEoPfyWIw9NsNV5ioywv19cRJxZtJRyGc
	 cRZ4TjnP6w8ZgMREpWskB51UGGmy+gd4vnZsg8MAmr6auguXYfTDRVvl1k5n3h4QJ6
	 XGdPb3Aq6Gpow==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 085/844] xenbus: Use .freeze/.thaw to handle xenbus devices
Date: Sat, 28 Feb 2026 12:19:58 -0500
Message-ID: <20260228173244.1509663-86-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220163-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 372F81C554D
X-Rspamd-Action: no action

From: Jason Andryuk <jason.andryuk@amd.com>

[ Upstream commit e08dd1ee49838750a514e83c0aa60cd12ba6ecbb ]

The goal is to fix s2idle and S3 for Xen PV devices.  A domain resuming
from s3 or s2idle disconnects its PV devices during resume.  The
backends are not expecting this and do not reconnect.

b3e96c0c7562 ("xen: use freeze/restore/thaw PM events for suspend/
resume/chkpt") changed xen_suspend()/do_suspend() from
PMSG_SUSPEND/PMSG_RESUME to PMSG_FREEZE/PMSG_THAW/PMSG_RESTORE, but the
suspend/resume callbacks remained.

.freeze/restore are used with hiberation where Linux restarts in a new
place in the future.  .suspend/resume are useful for runtime power
management for the duration of a boot.

The current behavior of the callbacks works for an xl save/restore or
live migration where the domain is restored/migrated to a new location
and connecting to a not-already-connected backend.

Change xenbus_pm_ops to use .freeze/thaw/restore and drop the
.suspend/resume hook.  This matches the use in drivers/xen/manage.c for
save/restore and live migration.  With .suspend/resume empty, PV devices
are left connected during s2idle and s3, so PV devices are not changed
and work after resume.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20251119224731.61497-2-jason.andryuk@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/xenbus/xenbus_probe_frontend.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe_frontend.c b/drivers/xen/xenbus/xenbus_probe_frontend.c
index 6d1819269cbe5..199917b6f77ca 100644
--- a/drivers/xen/xenbus/xenbus_probe_frontend.c
+++ b/drivers/xen/xenbus/xenbus_probe_frontend.c
@@ -148,11 +148,9 @@ static void xenbus_frontend_dev_shutdown(struct device *_dev)
 }
 
 static const struct dev_pm_ops xenbus_pm_ops = {
-	.suspend	= xenbus_dev_suspend,
-	.resume		= xenbus_frontend_dev_resume,
 	.freeze		= xenbus_dev_suspend,
 	.thaw		= xenbus_dev_cancel,
-	.restore	= xenbus_dev_resume,
+	.restore	= xenbus_frontend_dev_resume,
 };
 
 static struct xen_bus_type xenbus_frontend = {
-- 
2.51.0


