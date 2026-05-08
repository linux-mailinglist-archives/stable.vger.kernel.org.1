Return-Path: <stable+bounces-244709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJs5KAOn/Wl0ggAAu9opvQ
	(envelope-from <stable+bounces-244709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:04:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2384F3FF4
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 11:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0E60303A11B
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D90A38757C;
	Fri,  8 May 2026 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VB70OUjb"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48668381AE3
	for <stable@vger.kernel.org>; Fri,  8 May 2026 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230954; cv=none; b=jR7WATLKXHo7WMU8TtFVWgqzOECCxlKFSi78wTscCJM36cgGdI1PZV1wBTbSdqqTRtizRJdxEcYZUxVcCUsM8NKHx+EJ3NopVPrsdB/EBb9DRHBVhY4RMLQSlViCw7SbL0BSUfIRugCCuwlM3oPW2xxtJJn9G0UJilHtz8sBCIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230954; c=relaxed/simple;
	bh=XhdFYMV1mZ70jv8QArNcednC0eRLKAZ5Cf5TYJyVSD0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CjxzCu5dKJH3+LF5f8EFFcRCDkml7FXExboEWjwBaLgmK7o42Au+eueOgTJNjtwrt0a7RMpgWsY9uHRZwNF4boPOqsSCUguHaR/IBSsis0oaPcT7A6U11MOjlx80SU3FcZSlNhno0sgWY4kdIVyL2MtoaSCw0qJjhxO/h2s7sNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VB70OUjb; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba268cb5e6so7548575ad.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 02:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778230953; x=1778835753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PjRSW5+i7ia4uJhUR30COro91E+rzXNQmOTzNGO1JAI=;
        b=VB70OUjbE16xhmR5o4UjiUbggeq83eWNZQA1V700g8P+r19U54NARXWPvIriCfH9UB
         CvZqppZQ4Lku8FoVHq46dAodVY05+cQtd3TYHk+o6C+Hxy2+O94OaQlwZxnW3k2U6I3c
         ainjQxCEslD1FUpeqPwmREk0kN7BHWm1YyoI9W5Uh0gAFyolz9qedjbyTXqcinkNQkqI
         7s1LHmvo3mNjxzikds3cZD+GtRAvOjOTc51gYcNkOo1TnyjtmkheqQ99JA9MxwN5fx88
         ei3DxyXX4xHru/MA4Jwh32fYTYKnuoh/s1mx59GUcHDjaBUogFBsgSsHI1vYAm7TsJ6I
         qJjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778230953; x=1778835753;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjRSW5+i7ia4uJhUR30COro91E+rzXNQmOTzNGO1JAI=;
        b=EUzt7ITXuOc78p9BGCs5SPeXgVNT8pXeH8q9NRR8z0mEzOp4Ysm4NPx2icGLdrRKyv
         0Xaw+e9QT6qGOC5PGjPs7Zr3KzstitdyIMpxKD5Uitn2PYcO4/fws0zvV2Wc1N6V0fDt
         RgRiv+gWe4X3Btko99+CcCX++UX4uVTSlB/SJSTcFt/3cU1FjIrzcj0IO0/vFoEa9uBK
         yjjtf5wGE5o7G9U7tKfBjS8ttqcY1xRSPaGFLEQi2QQ+e0Zep3mqMU8XtcI72fLBUG9N
         p4oEese/DGjHVr31V8oJWZP7CrfYu2wTjQofVdtnsAUKty5GdyhuZ5Dyp28lNsGoCFXb
         4vHw==
X-Forwarded-Encrypted: i=1; AFNElJ9f3nLTmyH0YxEZTuiQCBwlG9xWmIg5LpoGWze0jAnRZ3oNSO3foZmNUDZ+mqYWD6zvtOV3I/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Yy74bEL49h2Q6HxRAqjByWDGJ3iGPHaoW6x91eqYc9eHhAeq
	czLspYjmkB4eaMvxMyUeSip41a55Yl0CCQefsEw/TSH4QB4bzFFxSn1WVvsUH9qiuzqHwSB8Y/6
	o/kSmM+m6OpbSoR0reoT4C7+RGg==
X-Received: from plbmz13.prod.google.com ([2002:a17:903:350d:b0:2b2:5117:a3f])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2844:b0:2b7:ca38:975f with SMTP id d9443c01a7336-2ba792877bdmr87188285ad.23.1778230952448;
 Fri, 08 May 2026 02:02:32 -0700 (PDT)
Date: Fri,  8 May 2026 09:02:28 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260508090228.3796635-1-joonwonkang@google.com>
Subject: [PATCH v5] mailbox: Make mbox_send_message() return error code when
 tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com, sudeep.holla@kernel.org
Cc: dianders@chromium.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, joonwonkang@google.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4C2384F3FF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244709-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

When the mailbox controller failed transmitting message, the error code
was only passed to the client's tx done handler and not to
mbox_send_message() in blocking mode. For this reason, the function could
return a false success. This commit resolves the issue by introducing the
tx status and checking it before mbox_send_message() returns.

This commit works with the premise that the multi-threads' access to a
channel in blocking mode is serialized by clients, not by the mailbox
APIs, since the current mbox_send_message() in blocking mode does not
support multi-threads.

Cc: stable@vger.kernel.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>
---
v5: Add note to the commit message that the current mailbox APIs in
    blocking mode do not support multi-threads.
v4: Detach it from the previous commit that supports multi-thread in
    blocking mode and rebase it on the latest for-next branch.
v3: No major patch since v1.

 drivers/mailbox/mailbox.c          | 6 +++++-
 include/linux/mailbox_controller.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index b00f7a32e866..066702e5a46f 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -98,8 +98,10 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	if (chan->cl->tx_done)
 		chan->cl->tx_done(chan->cl, mssg, r);
 
-	if (r != -ETIME && chan->cl->tx_block)
+	if (r != -ETIME && chan->cl->tx_block) {
+		chan->tx_status = r;
 		complete(&chan->tx_complete);
+	}
 }
 
 static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
@@ -295,6 +297,8 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		if (ret == 0) {
 			t = -ETIME;
 			tx_tick(chan, t);
+		} else if (chan->tx_status < 0) {
+			t = chan->tx_status;
 		}
 	}
 
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index dc93287a2a01..26a238a6f941 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -120,6 +120,7 @@ struct mbox_controller {
  * @txdone_method:	Way to detect TXDone chosen by the API
  * @cl:			Pointer to the current owner of this channel
  * @tx_complete:	Transmission completion
+ * @tx_status:		Transmission status
  * @active_req:		Currently active request hook
  * @msg_count:		No. of mssg currently queued
  * @msg_free:		Index of next available mssg slot
@@ -132,6 +133,7 @@ struct mbox_chan {
 	unsigned txdone_method;
 	struct mbox_client *cl;
 	struct completion tx_complete;
+	int tx_status;
 	void *active_req;
 	unsigned msg_count, msg_free;
 	void *msg_data[MBOX_TX_QUEUE_LEN];
-- 
2.54.0.563.g4f69b47b94-goog


