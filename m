Return-Path: <stable+bounces-240126-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPexMr9W52nz6gEAu9opvQ
	(envelope-from <stable+bounces-240126-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:51:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75881439C3F
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 827C33080789
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54723BD646;
	Tue, 21 Apr 2026 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JjuHkk8O"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C177A3ACEE9
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768422; cv=none; b=LjH91iipPZLRByoFVR4vq9/PU8CGVYS6RfBUKShhHOl7V/VZn+StCunQmQ/Cqbixlnt473v70jWMCJmEafA4HneS5JJ/xr4USHd3G7Pv95lj9yg92qwjTCgJHTLdyzKES0nf2/i7mPCesnFgcxTrVxyGyl59LhUTG96LpSuF0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768422; c=relaxed/simple;
	bh=jhuexCHU6ECDBpnRsUzpdW9ej8BppDujUy588VT8vHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q7NvbZZcf1mdPE6sAuFVsSfk7yIw5BJPy/QqLi4/oE1rzp3MBVDe9ShfdcYpWgUqhxeUwo9/Lu3x2VWKNkXGs25uLYxIQ2TmYhlQgnGwOUV2ghCaFGF1ewj25bJcHbYu0ETLkpLovDX7cNOpvNmup9X3U9uF1Y/LxQp376zpfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JjuHkk8O; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-35d9e67f6dcso731264a91.1
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 03:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776768420; x=1777373220; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Uq/uRpREn5XIIRm9bsEmT+nBdZqaFV7D4pSp2A3MzQ=;
        b=JjuHkk8OzyPJcgIgTRKmSkCNAvw+zStk+LWWn/9lX7yz8xTCRwy00O/lsbjCXI6IEG
         mz+GMjoD08gy6r79cOLV+4wurzS8Z/lOjw3sOGLQTYheAOYEBMmbW8U451xx/W1EzgqR
         VBM1qWvwxzlVveEQB8SRR8KKvhRoaWv9nLREer4qNz+5BA+jMZbOyGXfELYFSJgDDsWn
         b3ut6B85GzTcA/5A3SMwMBHxeOdthObudUA/MUNnOBu8TC1nSr8QHUVcqiyohG4VArne
         yE13qCCI4Bp3MAa1yH/6vLAmItvHxgSknk/os7PqRIWdzTIIuRFC+CkwMlZyP8DfKUzY
         B9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768420; x=1777373220;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Uq/uRpREn5XIIRm9bsEmT+nBdZqaFV7D4pSp2A3MzQ=;
        b=NSxaS1zRlvaA8fmeRHXJyg8hSMHNRt+TZUGOYRRFZZwyFrkkdEgYwgkni0a/uIhtko
         JFzyz0+2DT7ZCZO/rvhb43ZVNbIfZn9YQJXgmMu0mRDeRAVo5Gix0OUq88wPVUvjx8Wc
         bAAwbzBAXx58BnaAyN0wjHA2DVkew8tvQNHrXzfss+QzYonYcoHzr2erfLI75Y80z+dQ
         QMt8IkbgMq47VO4h8iO1KiXGhoBDrRCUwyoWCI/pApvfslmeC/zcfwpzeNWAvuIRJ96R
         7kVvsQpapai6hrPSS1MRjZIQP8FpiHimQdAZ4uiDiMHyCR1dltaJpObAokpofHTo0Y2d
         r3Gg==
X-Forwarded-Encrypted: i=1; AFNElJ9fiNoFrvsAZBLP3Is5svlo52QFk794uxGFQHfkLrjziAx/j2WANXetJ7SZtl8VMGPU0sRmBDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxKk19Rr6n+cAXMzSptX9i2AdIEReivsbhVlPKjGP+omxSLFMu
	BEI9yjbJ06131OpVHcx4A89fZCgyhNxM59yzf7xhgNzTWcye+SOsbpcSF6YOjbTLVxknzG3Mn3Y
	L/ABaaG2p0fFSgeORzNeDc8jHYQ==
X-Received: from pglc7.prod.google.com ([2002:a63:d07:0:b0:c76:8ec1:5090])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6a20:b0:398:9d5f:e093 with SMTP id adf61e73a8af0-3a08d74e6e5mr21273139637.19.1776768419944;
 Tue, 21 Apr 2026 03:46:59 -0700 (PDT)
Date: Tue, 21 Apr 2026 10:46:52 +0000
In-Reply-To: <20260421104652.211276-1-joonwonkang@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260421104652.211276-1-joonwonkang@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260421104652.211276-2-joonwonkang@google.com>
Subject: [PATCH v4] mailbox: Make mbox_send_message() return error code when
 tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com, sudeep.holla@kernel.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	akpm@linux-foundation.org, Joonwon Kang <joonwonkang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240126-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75881439C3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the mailbox controller failed transmitting message, the error code
was only passed to the client's tx done handler and not to
mbox_send_message() in blocking mode. For this reason, the function could
return a false success. This commit resolves the issue by introducing the
tx status and checking it before mbox_send_message() returns.

Cc: stable@vger.kernel.org
Signed-off-by: Joonwon Kang <joonwonkang@google.com>
---
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
2.54.0.rc1.555.g9c883467ad-goog


