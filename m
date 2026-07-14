Return-Path: <stable+bounces-274106-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K8uzI+6tVWqUrgAAu9opvQ
	(envelope-from <stable+bounces-274106-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:33:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD00750A7D
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 05:33:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A8qROFM1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274106-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274106-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91A0F303641F
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 03:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFC13446DE;
	Tue, 14 Jul 2026 03:33:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D339228469A
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 03:32:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783999980; cv=none; b=nPWdWkITMPB5Vq30GubzLn8lotVLbzHoIPHCgjHzmE/vWnAG/gYwwo7IUEubhNBIy3tudvOU28KdrgYQ9LXhIMUFDdk/Kdo2AdHkwx/Ouk7OMWy/LoxJnJICScga4GPPE6IzwX9NVMrDQGObmPg1yeAhgve1540xHuIt9cMpHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783999980; c=relaxed/simple;
	bh=aCvxA+n0GdZpiaaP9v6dNnq8/dzGweZgs2er/VZwDr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxhJdGWB1qqBdMxv8z34rNEG116NO31PJNz/d+tDXvJtKTd3dwC3p2Ql0/SGQ1nGk80sASFCUWnu+dx+vajFF/Hax9C0Ty4bhuzXiqWBx/EotVenR0N5VQ7ADuuciowGVpDXvnjWmV2Sz8fgOjOzARcl5JdWraZy+n6CWaBg9do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8qROFM1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E8C1F000E9;
	Tue, 14 Jul 2026 03:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783999978;
	bh=zwLe3qhaWQM7uKnjzOL8a8hdB4kZ986vnSvIap7r8iI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A8qROFM1E52Big60BJ+XwcE9vInvaaRQzWYR6d3aYnH/pKH8UEL1s5D8hNlyoalVc
	 5ulEHSP7ua53rvutR9k7Chdf2PLbzDL+fMPnYvllG7QpMldGjjKUwgrZMdUgH0wrUM
	 ecVb5imJ/IeipXYKXjYmPOyLAh9k+IlR3uIpMAH2QjAHsX/8NaAcgTReewWdqUiAv2
	 vzxVxtk2T8TA/8Y68VtK4ssEUUrZkKaXJ00NnR+f71a9zKLBdffxYfttxwgfeSJxtp
	 ZI1ialwN6wqemy9LCuZFx6p3gC69XJGCDv/YpvEI1dLeX4UMQp/WpFCZD4S0V0g+TG
	 NFgupka1mTHUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?C=C3=A1ssio=20Gabriel?= <cassiogabrielcontato@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 1/2] firmware_loader: Add cancel helper for async requests
Date: Mon, 13 Jul 2026 23:32:55 -0400
Message-ID: <20260714033256.2396704-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071331-subarctic-arrival-f0d8@gregkh>
References: <2026071331-subarctic-arrival-f0d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:cassiogabrielcontato@gmail.com,m:tiwai@suse.de,m:dakr@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274106-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BDD00750A7D

From: Cássio Gabriel <cassiogabrielcontato@gmail.com>

[ Upstream commit b9bdd68b8b979c7e9de58b2e7d21e1d7d932c755 ]

request_firmware_nowait() keeps the callback module pinned and holds
a device reference until the firmware work completes.

Callers still have no way to cancel or synchronize the queued callback
before tearing down their driver-private state.

Track scheduled async firmware work in an internal list and add
request_firmware_nowait_cancel(). The helper cancels work matching the
device, callback context and callback function. It cancels work that has
not started yet and waits for an already-running callback to return. If
the request has already completed, it is a no-op.

Keep the existing request_firmware_nowait() lifetime model manual. A
devres-managed variant can be layered on top separately if needed.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20260505-alsa-hda-tas2781-fw-callback-teardown-v4-1-e7c4bf930dc8@gmail.com
Stable-dep-of: 5367e2ad14f0 ("ALSA: hda/tas2781: Cancel async firmware request at unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/firmware_loader/main.c | 68 +++++++++++++++++++++++++++--
 include/linux/firmware.h            | 10 +++++
 2 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index a11b30dda23be5..78c5f05a2ec101 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -1132,6 +1132,7 @@ EXPORT_SYMBOL(release_firmware);
 /* Async support */
 struct firmware_work {
 	struct work_struct work;
+	struct list_head list;
 	struct module *module;
 	const char *name;
 	struct device *device;
@@ -1140,6 +1141,17 @@ struct firmware_work {
 	u32 opt_flags;
 };
 
+static LIST_HEAD(firmware_work_list);
+static DEFINE_SPINLOCK(firmware_work_lock);
+
+static void firmware_work_free(struct firmware_work *fw_work)
+{
+	put_device(fw_work->device); /* taken in request_firmware_nowait() */
+	module_put(fw_work->module);
+	kfree_const(fw_work->name);
+	kfree(fw_work);
+}
+
 static void request_firmware_work_func(struct work_struct *work)
 {
 	struct firmware_work *fw_work;
@@ -1150,11 +1162,15 @@ static void request_firmware_work_func(struct work_struct *work)
 	_request_firmware(&fw, fw_work->name, fw_work->device, NULL, 0, 0,
 			  fw_work->opt_flags);
 	fw_work->cont(fw, fw_work->context);
-	put_device(fw_work->device); /* taken in request_firmware_nowait() */
 
-	module_put(fw_work->module);
-	kfree_const(fw_work->name);
-	kfree(fw_work);
+	spin_lock_irq(&firmware_work_lock);
+	if (!list_empty(&fw_work->list)) {
+		list_del_init(&fw_work->list);
+		spin_unlock_irq(&firmware_work_lock);
+		firmware_work_free(fw_work);
+		return;
+	}
+	spin_unlock_irq(&firmware_work_lock);
 }
 
 
@@ -1164,6 +1180,7 @@ static int _request_firmware_nowait(
 	void (*cont)(const struct firmware *fw, void *context), bool nowarn)
 {
 	struct firmware_work *fw_work;
+	unsigned long flags;
 
 	fw_work = kzalloc_obj(struct firmware_work, gfp);
 	if (!fw_work)
@@ -1196,7 +1213,12 @@ static int _request_firmware_nowait(
 
 	get_device(fw_work->device);
 	INIT_WORK(&fw_work->work, request_firmware_work_func);
+
+	spin_lock_irqsave(&firmware_work_lock, flags);
+	list_add_tail(&fw_work->list, &firmware_work_list);
 	schedule_work(&fw_work->work);
+	spin_unlock_irqrestore(&firmware_work_lock, flags);
+
 	return 0;
 }
 
@@ -1259,6 +1281,44 @@ int firmware_request_nowait_nowarn(
 }
 EXPORT_SYMBOL_GPL(firmware_request_nowait_nowarn);
 
+/**
+ * request_firmware_nowait_cancel() - cancel an async firmware request
+ * @device: device for which the firmware is being loaded
+ * @context: context passed to request_firmware_nowait()
+ * @cont: callback passed to request_firmware_nowait()
+ *
+ * Cancel a pending request_firmware_nowait() request for @device, @context
+ * and @cont. If the associated work has already started, this function waits
+ * until the callback has returned. If the callback has already completed, this
+ * function does nothing.
+ *
+ * This function may sleep.
+ */
+void request_firmware_nowait_cancel(struct device *device, void *context,
+				    void (*cont)(const struct firmware *fw,
+						 void *context))
+{
+	struct firmware_work *fw_work = NULL;
+	struct firmware_work *tmp;
+
+	spin_lock_irq(&firmware_work_lock);
+	list_for_each_entry_reverse(tmp, &firmware_work_list, list) {
+		if (tmp->device == device && tmp->context == context &&
+		    tmp->cont == cont) {
+			fw_work = tmp;
+			list_del_init(&fw_work->list);
+			break;
+		}
+	}
+	spin_unlock_irq(&firmware_work_lock);
+
+	if (!fw_work)
+		return;
+	cancel_work_sync(&fw_work->work);
+	firmware_work_free(fw_work);
+}
+EXPORT_SYMBOL_GPL(request_firmware_nowait_cancel);
+
 #ifdef CONFIG_FW_CACHE
 static ASYNC_DOMAIN_EXCLUSIVE(fw_cache_domain);
 
diff --git a/include/linux/firmware.h b/include/linux/firmware.h
index aae1b85ffc10e2..0fa3b027f02f16 100644
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -110,6 +110,9 @@ int request_firmware_nowait(
 	struct module *module, bool uevent,
 	const char *name, struct device *device, gfp_t gfp, void *context,
 	void (*cont)(const struct firmware *fw, void *context));
+void request_firmware_nowait_cancel(struct device *device, void *context,
+				    void (*cont)(const struct firmware *fw,
+						 void *context));
 int request_firmware_direct(const struct firmware **fw, const char *name,
 			    struct device *device);
 int request_firmware_into_buf(const struct firmware **firmware_p,
@@ -157,6 +160,13 @@ static inline int request_firmware_nowait(
 	return -EINVAL;
 }
 
+static inline void request_firmware_nowait_cancel(struct device *device,
+						  void *context,
+						  void (*cont)(const struct firmware *fw,
+							       void *context))
+{
+}
+
 static inline void release_firmware(const struct firmware *fw)
 {
 }
-- 
2.53.0


