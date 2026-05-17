Return-Path: <stable+bounces-249082-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJWUOufECWpTowQAu9opvQ
	(envelope-from <stable+bounces-249082-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:38:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DF65613AB
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 15:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B99F030094D2
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042953B3C17;
	Sun, 17 May 2026 13:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JtoAjLIT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0EB3B38BA
	for <stable@vger.kernel.org>; Sun, 17 May 2026 13:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779025124; cv=none; b=gsIybpQjAq85li9Z/bL/E1wC3/4IETnfSnmusMWroh2cN+JBeLgv7CsOJi1agA4S0r2Ha+uzIH1mGbhvgTtxpv9NMyK+bM2UXxayMMGW2+fAp+Z6hPDdEFYzHxPemdnPZXVWY5tBJaUbLbaRuvogohtEEiq3zk+TqJKsQuaEZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779025124; c=relaxed/simple;
	bh=EuKieM31khw+u8GdEJQqT4/waWWNxEXp29myRduudmM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sj6UtVB85KfAIPOao7KyOmsBtTZI6IyNSsNRCQMcr6pKwidcKZyIj7GGPuwrvKMR6clPczSBpkQdbPL/k2DmEmL6eS6afB0Lr4GRhw0B5cVz7Ssl1rcfgWd/4ZY9gra67lFNPui7nhfcKaq6w7cAex8j2y2gnjEviBjb2Sf/3aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JtoAjLIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05213C2BCB0;
	Sun, 17 May 2026 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779025124;
	bh=EuKieM31khw+u8GdEJQqT4/waWWNxEXp29myRduudmM=;
	h=Subject:To:Cc:From:Date:From;
	b=JtoAjLIT0YBYW1VjR3zipHKo59+1SnZ6ZarPksbTHwXMrJTLufHcwXJYJvnnG0VeI
	 Uvu5KqkCPoC8FDEs5jaOQkqZcUpWsGg2g0D5olzJcp6tu/ldlewXXmHcnOhWrvTfSG
	 Q0qOBoopRyWngd0QLfFLLXypfE7Eg8ZKPYuldx6o=
Subject: FAILED: patch "[PATCH] HID: pass the buffer size to hid_report_raw_event" failed to apply to 6.18-stable tree
To: bentiss@kernel.org,gregkh@linuxfoundation.org,jkosina@suse.com,johan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 May 2026 15:38:40 +0200
Message-ID: <2026051740-escapist-sprite-a755@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 68DF65613AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249082-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,suse.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2c85c61d1332e1e16f020d76951baf167dcb6f7a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051740-escapist-sprite-a755@gregkh' --subject-prefix 'PATCH 6.18.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c85c61d1332e1e16f020d76951baf167dcb6f7a Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 4 May 2026 10:47:22 +0200
Subject: [PATCH] HID: pass the buffer size to hid_report_raw_event

commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
bogus memset()") enforced the provided data to be at least the size of
the declared buffer in the report descriptor to prevent a buffer
overflow. However, we can try to be smarter by providing both the buffer
size and the data size, meaning that hid_report_raw_event() can make
better decision whether we should plaining reject the buffer (buffer
overflow attempt) or if we can safely memset it to 0 and pass it to the
rest of the stack.

Fixes: 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
Acked-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index 50c7b45c59e3..d0130658091b 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -24,7 +24,8 @@ EXPORT_SYMBOL(hid_ops);
 
 u8 *
 dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type, u8 *data,
-			      u32 *size, int interrupt, u64 source, bool from_bpf)
+			      size_t *buf_size, u32 *size, int interrupt, u64 source,
+			      bool from_bpf)
 {
 	struct hid_bpf_ctx_kern ctx_kern = {
 		.ctx = {
@@ -74,6 +75,7 @@ dispatch_hid_bpf_device_event(struct hid_device *hdev, enum hid_report_type type
 		*size = ret;
 	}
 
+	*buf_size = ctx_kern.ctx.allocated_size;
 	return ctx_kern.data;
 }
 EXPORT_SYMBOL_GPL(dispatch_hid_bpf_device_event);
@@ -505,7 +507,7 @@ __hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum hid_report_type type, u8 *b
 	if (ret)
 		return ret;
 
-	return hid_ops->hid_input_report(ctx->hid, type, buf, size, 0, (u64)(long)ctx, true,
+	return hid_ops->hid_input_report(ctx->hid, type, buf, size, size, 0, (u64)(long)ctx, true,
 					 lock_already_taken);
 }
 
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 61afec5915ec..a806820df7e5 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2033,24 +2033,32 @@ int __hid_request(struct hid_device *hid, struct hid_report *report,
 }
 EXPORT_SYMBOL_GPL(__hid_request);
 
-int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
-			 int interrupt)
+int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
+			 size_t bufsize, u32 size, int interrupt)
 {
 	struct hid_report_enum *report_enum = hid->report_enum + type;
 	struct hid_report *report;
 	struct hid_driver *hdrv;
 	int max_buffer_size = HID_MAX_BUFFER_SIZE;
 	u32 rsize, csize = size;
+	size_t bsize = bufsize;
 	u8 *cdata = data;
 	int ret = 0;
 
 	report = hid_get_report(report_enum, data);
 	if (!report)
-		goto out;
+		return 0;
+
+	if (unlikely(bsize < csize)) {
+		hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
+				     report->id, csize, bsize);
+		return -EINVAL;
+	}
 
 	if (report_enum->numbered) {
 		cdata++;
 		csize--;
+		bsize--;
 	}
 
 	rsize = hid_compute_report_size(report);
@@ -2063,11 +2071,16 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 	else if (rsize > max_buffer_size)
 		rsize = max_buffer_size;
 
+	if (bsize < rsize) {
+		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
+				     report->id, rsize, bsize);
+		return -EINVAL;
+	}
+
 	if (csize < rsize) {
-		hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %d)\n",
-				     report->id, rsize, csize);
-		ret = -EINVAL;
-		goto out;
+		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
+			csize, rsize);
+		memset(cdata + csize, 0, rsize - csize);
 	}
 
 	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
@@ -2075,7 +2088,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 	if (hid->claimed & HID_CLAIMED_HIDRAW) {
 		ret = hidraw_report_event(hid, data, size);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	if (hid->claimed != HID_CLAIMED_HIDRAW && report->maxfield) {
@@ -2087,15 +2100,15 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
 		hidinput_report_event(hid, report);
-out:
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_report_raw_event);
 
 
 static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
-			      u8 *data, u32 size, int interrupt, u64 source, bool from_bpf,
-			      bool lock_already_taken)
+			      u8 *data, size_t bufsize, u32 size, int interrupt, u64 source,
+			      bool from_bpf, bool lock_already_taken)
 {
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
@@ -2120,7 +2133,8 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
 	report_enum = hid->report_enum + type;
 	hdrv = hid->driver;
 
-	data = dispatch_hid_bpf_device_event(hid, type, data, &size, interrupt, source, from_bpf);
+	data = dispatch_hid_bpf_device_event(hid, type, data, &bufsize, &size, interrupt,
+					     source, from_bpf);
 	if (IS_ERR(data)) {
 		ret = PTR_ERR(data);
 		goto unlock;
@@ -2149,7 +2163,7 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
 			goto unlock;
 	}
 
-	ret = hid_report_raw_event(hid, type, data, size, interrupt);
+	ret = hid_report_raw_event(hid, type, data, bufsize, size, interrupt);
 
 unlock:
 	if (!lock_already_taken)
@@ -2171,7 +2185,7 @@ static int __hid_input_report(struct hid_device *hid, enum hid_report_type type,
 int hid_input_report(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
 		     int interrupt)
 {
-	return __hid_input_report(hid, type, data, size, interrupt, 0,
+	return __hid_input_report(hid, type, data, size, size, interrupt, 0,
 				  false, /* from_bpf */
 				  false /* lock_already_taken */);
 }
diff --git a/drivers/hid/hid-gfrm.c b/drivers/hid/hid-gfrm.c
index 699186ff2349..d2a56bf92b41 100644
--- a/drivers/hid/hid-gfrm.c
+++ b/drivers/hid/hid-gfrm.c
@@ -66,7 +66,7 @@ static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
 	switch (data[1]) {
 	case GFRM100_SEARCH_KEY_DOWN:
 		ret = hid_report_raw_event(hdev, HID_INPUT_REPORT, search_key_dn,
-					   sizeof(search_key_dn), 1);
+					   sizeof(search_key_dn), sizeof(search_key_dn), 1);
 		break;
 
 	case GFRM100_SEARCH_KEY_AUDIO_DATA:
@@ -74,7 +74,7 @@ static int gfrm_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	case GFRM100_SEARCH_KEY_UP:
 		ret = hid_report_raw_event(hdev, HID_INPUT_REPORT, search_key_up,
-					   sizeof(search_key_up), 1);
+					   sizeof(search_key_up), sizeof(search_key_up), 1);
 		break;
 
 	default:
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b1330d23bd2d..b3ff9265377b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3673,7 +3673,7 @@ static int hidpp10_consumer_keys_raw_event(struct hidpp_device *hidpp,
 	memcpy(&consumer_report[1], &data[3], 4);
 	/* We are called from atomic context */
 	hid_report_raw_event(hidpp->hid_dev, HID_INPUT_REPORT,
-			     consumer_report, 5, 1);
+			     consumer_report, sizeof(consumer_report), 5, 1);
 
 	return 1;
 }
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index e82a3c4e5b44..eeab0b6e32cc 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -533,7 +533,7 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 		}
 
 		ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf,
-					   size, 0);
+					   size, size, 0);
 		if (ret)
 			dev_warn(&hdev->dev, "failed to report feature\n");
 	}
diff --git a/drivers/hid/hid-primax.c b/drivers/hid/hid-primax.c
index e44d79dff8de..8db054280afb 100644
--- a/drivers/hid/hid-primax.c
+++ b/drivers/hid/hid-primax.c
@@ -44,7 +44,7 @@ static int px_raw_event(struct hid_device *hid, struct hid_report *report,
 			data[0] |= (1 << (data[idx] - 0xE0));
 			data[idx] = 0;
 		}
-		hid_report_raw_event(hid, HID_INPUT_REPORT, data, size, 0);
+		hid_report_raw_event(hid, HID_INPUT_REPORT, data, size, size, 0);
 		return 1;
 
 	default:	/* unknown report */
diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
index bf734055d4b6..b12bb5cc091a 100644
--- a/drivers/hid/hid-vivaldi-common.c
+++ b/drivers/hid/hid-vivaldi-common.c
@@ -85,7 +85,7 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 	}
 
 	ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
-				   report_len, 0);
+				   report_len, report_len, 0);
 	if (ret) {
 		dev_warn(&hdev->dev, "failed to report feature %d\n",
 			 field->report->id);
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 0d1c6d90fe21..a32320b351e3 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -90,7 +90,7 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 			kfree(buf);
 			continue;
 		}
-		err = hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, false);
+		err = hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, size, false);
 		if (err) {
 			hid_warn(hdev, "%s: unable to flush event due to error %d\n",
 				 __func__, err);
@@ -334,7 +334,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 					       data, n, WAC_CMD_RETRIES);
 			if (ret == n && features->type == HID_GENERIC) {
 				ret = hid_report_raw_event(hdev,
-					HID_FEATURE_REPORT, data, n, 0);
+					HID_FEATURE_REPORT, data, n, n, 0);
 			} else if (ret == 2 && features->type != HID_GENERIC) {
 				features->touch_max = data[1];
 			} else {
@@ -395,7 +395,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 					data, n, WAC_CMD_RETRIES);
 		if (ret == n) {
 			ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT,
-						   data, n, 0);
+						   data, n, n, 0);
 		} else {
 			hid_warn(hdev, "%s: could not retrieve sensor offsets\n",
 				 __func__);
diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
index 1f58c907c036..f1f9f6fbc00e 100644
--- a/drivers/staging/greybus/hid.c
+++ b/drivers/staging/greybus/hid.c
@@ -201,7 +201,7 @@ static void gb_hid_init_report(struct gb_hid *ghid, struct hid_report *report)
 	 * we just need to setup the input fields, so using
 	 * hid_report_raw_event is safe.
 	 */
-	hid_report_raw_event(ghid->hid, report->type, ghid->inbuf, size, 1);
+	hid_report_raw_event(ghid->hid, report->type, ghid->inbuf, ghid->bufsize, size, 1);
 }
 
 static void gb_hid_init_reports(struct gb_hid *ghid)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 442a80d79e89..ac432a2ef415 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1298,8 +1298,8 @@ static inline u32 hid_report_len(struct hid_report *report)
 	return DIV_ROUND_UP(report->size, 8) + (report->id > 0);
 }
 
-int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data, u32 size,
-			 int interrupt);
+int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
+			 size_t bufsize, u32 size, int interrupt);
 
 /* HID quirks API */
 unsigned long hid_lookup_quirk(const struct hid_device *hdev);
diff --git a/include/linux/hid_bpf.h b/include/linux/hid_bpf.h
index a2e47dbcf82c..19fffa4574a4 100644
--- a/include/linux/hid_bpf.h
+++ b/include/linux/hid_bpf.h
@@ -72,8 +72,8 @@ struct hid_ops {
 	int (*hid_hw_output_report)(struct hid_device *hdev, __u8 *buf, size_t len,
 				    u64 source, bool from_bpf);
 	int (*hid_input_report)(struct hid_device *hid, enum hid_report_type type,
-				u8 *data, u32 size, int interrupt, u64 source, bool from_bpf,
-				bool lock_already_taken);
+				u8 *data, size_t bufsize, u32 size, int interrupt, u64 source,
+				bool from_bpf, bool lock_already_taken);
 	struct module *owner;
 	const struct bus_type *bus_type;
 };
@@ -200,7 +200,8 @@ struct hid_bpf {
 
 #ifdef CONFIG_HID_BPF
 u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type, u8 *data,
-				  u32 *size, int interrupt, u64 source, bool from_bpf);
+				  size_t *buf_size, u32 *size, int interrupt, u64 source,
+				  bool from_bpf);
 int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 				  unsigned char reportnum, __u8 *buf,
 				  u32 size, enum hid_report_type rtype,
@@ -215,8 +216,11 @@ int hid_bpf_device_init(struct hid_device *hid);
 const u8 *call_hid_bpf_rdesc_fixup(struct hid_device *hdev, const u8 *rdesc, unsigned int *size);
 #else /* CONFIG_HID_BPF */
 static inline u8 *dispatch_hid_bpf_device_event(struct hid_device *hid, enum hid_report_type type,
-						u8 *data, u32 *size, int interrupt,
-						u64 source, bool from_bpf) { return data; }
+						u8 *data, size_t *buf_size, u32 *size,
+						int interrupt, u64 source, bool from_bpf)
+{
+	return data;
+}
 static inline int dispatch_hid_bpf_raw_requests(struct hid_device *hdev,
 						unsigned char reportnum, u8 *buf,
 						u32 size, enum hid_report_type rtype,


