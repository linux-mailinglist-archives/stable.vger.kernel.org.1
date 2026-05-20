Return-Path: <stable+bounces-249960-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE/yAPjHDWr93AUAu9opvQ
	(envelope-from <stable+bounces-249960-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:40:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F558FD3E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8511D301065F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5379C27B353;
	Wed, 20 May 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jCswURbx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681D3ED138
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287940; cv=none; b=b8cwLROk31yWKVTWbigUJfU6qaDqufMoWRXazevhfTYwMd32Bpaha0Obf8cmjuSrZv0O2aK1dxLAP+fh1HR/KyYS8JOybbtk9rv7l9qrUUmQpDkeCkxnoJ2WCJjr92HOiVmgzFs9hfWZhpupThMTr/MPSweojV/HpkMIt0lQHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287940; c=relaxed/simple;
	bh=qhaIquGFdJaoe5OBs7Hb3wyKYm9RTD1CI+sl5tDy+Ps=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gXbupFmpRbkd3rBhUf6dc0blYa7T9hkma7cfPVwny6zq0D37QBQwxk08YpNoFcaGpt13B/CV/kAcHK8F/xdsCTp/TG3bsUupPO0OKco8ZF1mpqmh8Nc4mg/hUBfnSz/qc4rppbbhFtDycNWteWMYD1QBlUjDcAhZlnbYwqfGupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jCswURbx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1156C1F000E9;
	Wed, 20 May 2026 14:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779287938;
	bh=b8sSUssSXsv3eBVLJuY/cTCqwkkWwF/EHlXahphVkwc=;
	h=Subject:To:Cc:From:Date;
	b=jCswURbxh7melnW5Gd1puO2mhb/6yuLNaiCHIoC26c3Se5TnNZmMI4rR3dOx3sbOU
	 PA43mRmAPx3YLxPFIm3ibOAmSLIpqXN4fcZK2zKQweK5IL0neWcx2P8pKcO6bjkMUB
	 HBkyY42BA1+6IyJJ9iUqQXQOp+goPTF7q+fK0o7Y=
Subject: FAILED: patch "[PATCH] platform/x86: lenovo-wmi-other: Zero initialize WMI arguments" failed to apply to 6.18-stable tree
To: derekjohn.clark@gmail.com,i@rong.moe,ilpo.jarvinen@linux.intel.com,mpearson-lenovo@squebb.ca
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 20 May 2026 16:39:01 +0200
Message-ID: <2026052001-striving-endocrine-d192@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249960-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,rong.moe,linux.intel.com,squebb.ca];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gregkh:email,squebb.ca:email]
X-Rspamd-Queue-Id: 957F558FD3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 816fbd5dacee977ca56bab79bf97f71f2f7ac24e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026052001-striving-endocrine-d192@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 816fbd5dacee977ca56bab79bf97f71f2f7ac24e Mon Sep 17 00:00:00 2001
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
Date: Sun, 10 May 2026 04:25:34 +0000
Subject: [PATCH] platform/x86: lenovo-wmi-other: Zero initialize WMI arguments
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds explicit initialization of wmi_method_args_32 declarations with
zero values to prevent uninitialized data from being sent to the device
BIOS when passed.

No functional change intended.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Fixes: 22024ac5366f ("platform/x86: Add Lenovo Gamezone WMI Driver")
Fixes: edc4b183b794 ("platform/x86: Add Lenovo Other Mode WMI Driver")
Reported-by: Rong Zhang <i@rong.moe>
Closes: https://lore.kernel.org/platform-driver-x86/95c7e7b539dd0af41189c754fcd35cec5b6fe182.camel@rong.moe/
Cc: stable@vger.kernel.org
Reviewed-by: Rong Zhang <i@rong.moe>
Tested-by: Rong Zhang <i@rong.moe>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
Link: https://patch.msgid.link/20260510042546.436874-5-derekjohn.clark@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

diff --git a/drivers/platform/x86/lenovo/wmi-gamezone.c b/drivers/platform/x86/lenovo/wmi-gamezone.c
index c7fe7e3c9f17..098239c9311a 100644
--- a/drivers/platform/x86/lenovo/wmi-gamezone.c
+++ b/drivers/platform/x86/lenovo/wmi-gamezone.c
@@ -201,7 +201,7 @@ static int lwmi_gz_profile_set(struct device *dev,
 			       enum platform_profile_option profile)
 {
 	struct lwmi_gz_priv *priv = dev_get_drvdata(dev);
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	enum thermal_mode mode;
 	int ret;
 
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index 70fcb8406c27..c1b429269f89 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -166,7 +166,7 @@ MODULE_PARM_DESC(relax_fan_constraint,
  */
 static int lwmi_om_fan_get_set(struct lwmi_om_priv *priv, int channel, u32 *val, bool set)
 {
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	u32 method_id, retval;
 	int err;
 
@@ -775,7 +775,7 @@ static ssize_t attr_current_value_store(struct kobject *kobj,
 					struct tunable_attr_01 *tunable_attr)
 {
 	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	struct capdata01 capdata;
 	enum thermal_mode mode;
 	u32 attribute_id;
@@ -838,7 +838,7 @@ static ssize_t attr_current_value_show(struct kobject *kobj,
 				       struct tunable_attr_01 *tunable_attr)
 {
 	struct lwmi_om_priv *priv = dev_get_drvdata(tunable_attr->dev);
-	struct wmi_method_args_32 args;
+	struct wmi_method_args_32 args = {};
 	enum thermal_mode mode;
 	u32 attribute_id;
 	int retval;


