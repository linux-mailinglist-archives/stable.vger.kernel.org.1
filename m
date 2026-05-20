Return-Path: <stable+bounces-252062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AewNpwhDmqI6QUAu9opvQ
	(envelope-from <stable+bounces-252062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:03:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A00C59A67B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC65937BCE4C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B195D3F20FA;
	Wed, 20 May 2026 17:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OaBe66us"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642973F0A83;
	Wed, 20 May 2026 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299646; cv=none; b=enXKu77hNVQDtRb4h3i4dF/YyDjlU5nh+3aX0/+bTtKh6H8Nzi9W0h3lwMcNX/KS9EC6un6WcVSqyYhdsjRYW3/IHAjKcGpH8LGEBg6+eYeifdTruyMFdJ1Wg9Qo8AV/Y1XEoBvq7hGu5ZB702Un16bDRHHxdyiLh6Hx6dwNiQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299646; c=relaxed/simple;
	bh=r3N7liI9tYr7B/dQOQCe5HDiM5oQ05NJej+7nCpAF6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUI40upBHaRYShJkj/6/LxvEw+nmerGOVrDLNWLNQ90YAtb7Zku/8FkdQm7dMbHahiu72WFAr1RR2zCiSuv/NiaKwosyO8CnW77rzugBN/oFCkuJkzWTt390MvqTL46MZnIowrWLiwRAhXv0G/Unoy0IfTmNU9DysRD8FpWZSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OaBe66us; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13451F000E9;
	Wed, 20 May 2026 17:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299645;
	bh=cr36dTYBYEW/rsUBhWICZyKt8p4dlDCYTzcXbZ91kXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OaBe66uss32ZW4D22b/pRzzKZUhR0cK9G5vnNc8cSH5S5n5dhvj7ANFMItS8F2rVI
	 oCtQyv5z+5BQZsUqM255Vz/NV2EgUVgUnJV1DydSRmY6d8cyA5nIF+eGRyOrGgsIhb
	 MI75LYQDmy/RDMwMfL6MipmmUPABS61VK2gabXgA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Ivan Vecera <ivecera@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 852/957] dpll: export __dpll_pin_change_ntf() for use under dpll_lock
Date: Wed, 20 May 2026 18:22:15 +0200
Message-ID: <20260520162153.043870973@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252062-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,intel.com:email,linux.dev:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 2A00C59A67B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Vecera <ivecera@redhat.com>

[ Upstream commit 620055cb1036a6125fd912e7a14b47a6572b809b ]

Export __dpll_pin_change_ntf() so that drivers can send pin change
notifications from within pin callbacks, which are already called
under dpll_lock. Using dpll_pin_change_ntf() in that context would
deadlock.

Add lockdep_assert_held() to catch misuse without the lock held.

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Link: https://patch.msgid.link/20260427-jk-iwl-net-petr-oros-fixes-v1-9-cdcb48303fd8@intel.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 9e5dead140af ("ice: add dpll peer notification for paired SMA and U.FL pins")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dpll/dpll_netlink.c | 10 ++++++++++
 drivers/dpll/dpll_netlink.h |  2 --
 include/linux/dpll.h        |  1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index fe9c3d9073f0f..de8b065280d15 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -823,11 +823,21 @@ int dpll_pin_delete_ntf(struct dpll_pin *pin)
 	return dpll_pin_event_send(DPLL_CMD_PIN_DELETE_NTF, pin);
 }
 
+/**
+ * __dpll_pin_change_ntf - notify that the pin has been changed
+ * @pin: registered pin pointer
+ *
+ * Context: caller must hold dpll_lock. Suitable for use inside pin
+ *          callbacks which are already invoked under dpll_lock.
+ * Return: 0 if succeeds, error code otherwise.
+ */
 int __dpll_pin_change_ntf(struct dpll_pin *pin)
 {
+	lockdep_assert_held(&dpll_lock);
 	dpll_pin_notify(pin, DPLL_PIN_CHANGED);
 	return dpll_pin_event_send(DPLL_CMD_PIN_CHANGE_NTF, pin);
 }
+EXPORT_SYMBOL_GPL(__dpll_pin_change_ntf);
 
 /**
  * dpll_pin_change_ntf - notify that the pin has been changed
diff --git a/drivers/dpll/dpll_netlink.h b/drivers/dpll/dpll_netlink.h
index dd28b56d27c56..a9cfd55f57fc4 100644
--- a/drivers/dpll/dpll_netlink.h
+++ b/drivers/dpll/dpll_netlink.h
@@ -11,5 +11,3 @@ int dpll_device_delete_ntf(struct dpll_device *dpll);
 int dpll_pin_create_ntf(struct dpll_pin *pin);
 
 int dpll_pin_delete_ntf(struct dpll_pin *pin);
-
-int __dpll_pin_change_ntf(struct dpll_pin *pin);
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 34b005bb4df6f..480ea3cbe709b 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -260,6 +260,7 @@ int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 
 int dpll_device_change_ntf(struct dpll_device *dpll);
 
+int __dpll_pin_change_ntf(struct dpll_pin *pin);
 int dpll_pin_change_ntf(struct dpll_pin *pin);
 
 int register_dpll_notifier(struct notifier_block *nb);
-- 
2.53.0




