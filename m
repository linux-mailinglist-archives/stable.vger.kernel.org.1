Return-Path: <stable+bounces-214251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEk7KF1vg2lgmwMAu9opvQ
	(envelope-from <stable+bounces-214251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:10:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC39FE9F4A
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 17:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83BDC3095212
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851131C5D57;
	Wed,  4 Feb 2026 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QIzxO3/E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E3919E96D;
	Wed,  4 Feb 2026 15:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219068; cv=none; b=F29fyXvxiwq+nJP8YcrsR4qeJMaQrhaZQBvlDvwyY5EnUqJasMlA1PSpUZwKQPGxJHe1dNSlrO890ZBc5PQvFKj5SW12D65+DR2XdBARaMfQ/FkH5tlmgrjSTlZYWMhGeCxMRUVSyaj3F8eSSj830Q8i5N2doBUS2H4LceVwM6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219068; c=relaxed/simple;
	bh=BTAIEYbota6cAdxQoS/Cq+00w/Zt0Rb3z3Aao+7tKDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7sscQrZvKi0zYUQB8tgMHlWt5EtSAkZF9fuK2J4ya7kcghIS9lCedq18KVeNbBGABsp/OXsS8ihb/+GbDLtMp7Rys+dZ0XTi+yC9Czp+EqAw3vdOlDPIO9nJO2Wq7zXYlrTqHh7kbOHwbosjU+Un0wey9QmjWBHzkx3gQIvD1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QIzxO3/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560A1C4CEF7;
	Wed,  4 Feb 2026 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770219067;
	bh=BTAIEYbota6cAdxQoS/Cq+00w/Zt0Rb3z3Aao+7tKDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QIzxO3/Eo/T/URQYtUDISRhSoXfJP1+BgyTG0ooHbTZYIi+6VNPoXsBOj8NiRhivV
	 MDx9gF1AMf8oaYKPcVTePteZcSOWktRVdpsoNtUpvZB0zJHAvrYVVMnfUbAWKlx1YE
	 3ZA7zDbFw6T+6WpEqOiGQ6twI8uAAkmAXx7OFHSA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nitin Gote <nitin.r.gote@intel.com>,
	Brian Nguyen <brian3.nguyen@intel.com>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Shuicheng Lin <shuicheng.lin@intel.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 056/122] drm/xe/nvm: Fix double-free on aux add failure
Date: Wed,  4 Feb 2026 15:40:38 +0100
Message-ID: <20260204143853.870156993@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143851.857060534@linuxfoundation.org>
References: <20260204143851.857060534@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214251-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: AC39FE9F4A
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuicheng Lin <shuicheng.lin@intel.com>

[ Upstream commit 8a44241b0b83a6047c5448da1fff03fcc29496b5 ]

After a successful auxiliary_device_init(), aux_dev->dev.release
(xe_nvm_release_dev()) is responsible for the kfree(nvm). When
there is failure with auxiliary_device_add(), driver will call
auxiliary_device_uninit(), which call put_device(). So that the
.release callback will be triggered to free the memory associated
with the auxiliary_device.

Move the kfree(nvm) into the auxiliary_device_init() failure path
and remove the err goto path to fix below error.

"
[   13.232905] ==================================================================
[   13.232911] BUG: KASAN: double-free in xe_nvm_init+0x751/0xf10 [xe]
[   13.233112] Free of addr ffff888120635000 by task systemd-udevd/273

[   13.233120] CPU: 8 UID: 0 PID: 273 Comm: systemd-udevd Not tainted 6.19.0-rc2-lgci-xe-kernel+ #225 PREEMPT(voluntary)
...
[   13.233125] Call Trace:
[   13.233126]  <TASK>
[   13.233127]  dump_stack_lvl+0x7f/0xc0
[   13.233132]  print_report+0xce/0x610
[   13.233136]  ? kasan_complete_mode_report_info+0x5d/0x1e0
[   13.233139]  ? xe_nvm_init+0x751/0xf10 [xe]
...
"

v2: drop err goto path. (Alexander)

Fixes: 7926ba2143d8 ("drm/xe: defer free of NVM auxiliary container to device release callback")
Reviewed-by: Nitin Gote <nitin.r.gote@intel.com>
Reviewed-by: Brian Nguyen <brian3.nguyen@intel.com>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Suggested-by: Brian Nguyen <brian3.nguyen@intel.com>
Signed-off-by: Shuicheng Lin <shuicheng.lin@intel.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Link: https://patch.msgid.link/20260120183239.2966782-7-shuicheng.lin@intel.com
(cherry picked from commit a3187c0c2bbd947ffff97f90d077ac88f9c2a215)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_nvm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
index 1fff24dbc7cd4..6da42b2b5e467 100644
--- a/drivers/gpu/drm/xe/xe_nvm.c
+++ b/drivers/gpu/drm/xe/xe_nvm.c
@@ -153,19 +153,17 @@ int xe_nvm_init(struct xe_device *xe)
 	ret = auxiliary_device_init(aux_dev);
 	if (ret) {
 		drm_err(&xe->drm, "xe-nvm aux init failed %d\n", ret);
-		goto err;
+		kfree(nvm);
+		xe->nvm = NULL;
+		return ret;
 	}
 
 	ret = auxiliary_device_add(aux_dev);
 	if (ret) {
 		drm_err(&xe->drm, "xe-nvm aux add failed %d\n", ret);
 		auxiliary_device_uninit(aux_dev);
-		goto err;
+		xe->nvm = NULL;
+		return ret;
 	}
 	return devm_add_action_or_reset(xe->drm.dev, xe_nvm_fini, xe);
-
-err:
-	kfree(nvm);
-	xe->nvm = NULL;
-	return ret;
 }
-- 
2.51.0




