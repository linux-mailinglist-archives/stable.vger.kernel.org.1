Return-Path: <stable+bounces-237098-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yN2dKk8k3WkzaQkAu9opvQ
	(envelope-from <stable+bounces-237098-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:13:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AD23F108B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8D2C310C5E1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B6F28C874;
	Mon, 13 Apr 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t3RD3q1M"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7520A1A680C;
	Mon, 13 Apr 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098583; cv=none; b=PPkwdBObOTVkOtHjMITK3CO65E302L5MSZBzJqj6c7ECPBY2vkMj8H+JTYOscJLGZjYFPFz2iqc1YletR6Bnd6yWdPasDonf0wUJhYfywP/qwtyZlUbqUOg5Ty+vnmDNTmrTEsAv7MB1wo+ZFVwYmlDKyBGrna65HjRzbBlsm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098583; c=relaxed/simple;
	bh=OwI75ENEfIAX9+a6hCbJH13PBOaV0DiXgsHNOXmQQ7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khYV7NPzGS50vl0axqhcPuMVAiI/B58UsXd1MM0962+y2GhQVhspGSOIoqYMfeP8MQvCkGC3A0KQDLtb+nrKmqTwyu0cxFcHJCGYgsU6iGyAOxHF0dqwK8dYtKDLkEthqqhRebruOTSBdnz+6sCatMh1EWkBUkHKl1I3oGQ//i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t3RD3q1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A526C2BCAF;
	Mon, 13 Apr 2026 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098583;
	bh=OwI75ENEfIAX9+a6hCbJH13PBOaV0DiXgsHNOXmQQ7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3RD3q1MFyZoSYzZ92JWl+suMrIZsd7hNUsetTEfg6hOzPh3IamvbpK8QsE1JeiHF
	 gnl+KuPdfiKRATnHlmKI8wFFD68/s6PQt6azOvHwuPQIXUpfDmAF2e0+ZEcHxNHu64
	 9BYpoT2atwKUzD8jmBU+ek6B5uwT0bslG6AMuWA4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gui-Dong Han <hanguidong02@gmail.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 010/491] bus: fsl-mc: fix use-after-free in driver_override_show()
Date: Mon, 13 Apr 2026 17:54:15 +0200
Message-ID: <20260413155819.436681483@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nxp.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-237098-lists,stable=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 38AD23F108B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gui-Dong Han <hanguidong02@gmail.com>

[ Upstream commit 148891e95014b5dc5878acefa57f1940c281c431 ]

The driver_override_show() function reads the driver_override string
without holding the device_lock. However, driver_override_store() uses
driver_set_override(), which modifies and frees the string while holding
the device_lock.

This can result in a concurrent use-after-free if the string is freed
by the store function while being read by the show function.

Fix this by holding the device_lock around the read operation.

Fixes: 1f86a00c1159 ("bus/fsl-mc: add support for 'driver_override' in the mc-bus")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Link: https://lore.kernel.org/r/20251202174438.12658-1-hanguidong02@gmail.com
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 8f7448da9258d..49eaf5bddd5ad 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -194,8 +194,12 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
 	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
+	ssize_t len;
 
-	return sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_lock(dev);
+	len = sysfs_emit(buf, "%s\n", mc_dev->driver_override);
+	device_unlock(dev);
+	return len;
 }
 static DEVICE_ATTR_RW(driver_override);
 
-- 
2.51.0




