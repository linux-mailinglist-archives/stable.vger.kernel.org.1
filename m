Return-Path: <stable+bounces-252356-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKQfOeAkDmr26QUAu9opvQ
	(envelope-from <stable+bounces-252356-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:17:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6313A59AAB2
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 23:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6656833ED338
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE803A6B6D;
	Wed, 20 May 2026 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWeVJZTe"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990073EAC82
	for <stable@vger.kernel.org>; Wed, 20 May 2026 18:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300463; cv=none; b=nUI8QetpjDFyBWovI03h1PhHrfpQN6egYqUu2P51p8xC90/lt3Jfns9B4xR15Bs+2FeQbMJSAjQWwmjsoZkwnY64e0sB2F2daM93SSaCuZg4TmMIWxo6GcYNBBzR9YMqCcjKv0OzBxgXBxqVkvpVx+St1bI42b2CFd6XtA8OFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300463; c=relaxed/simple;
	bh=xfNlFdn1cqV9kYZZDjV/Uwxd3csiryoiiiDv+XVg55o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tGOiVOS/E7Hk/MaW1QbUmOgq2Ck7sWN9utLQKgdqfmVDV+olVzwB8NWfLRIE8LC5ZuQ0vK5Q3pKP19n5LD1xDhXHSUZyA0X8g0GFgEymY0W7DZWFgZUSCoZG2n+lcEQiDzQL+L8dqBBoZiRtBiD3lFuAynYHUQMwbwQu3XyM8xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWeVJZTe; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso5253596eec.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 11:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779300461; x=1779905261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nklZPvrJ0WfKoc1xZCOc0oOhjU6AGmqWwTNyTfjgmsQ=;
        b=hWeVJZTeigJzObalTM7AUZy47yEbDptJfL2UhHrLO2c4T4AvgZKuRNypI/yP7gPZRx
         QeUdPsyIxX8BugFuQ5mYBFH5pITc2XDpBQz5RpJt93hdvARv+mWeBdlNb/ZtTmdJs2Ms
         jCXJZ+d03cMS/w18h/pWaGORbfxKePv1hPiOatN+6VrI4vOWFnrFEsb3eIjMoMOeYD8t
         yxEFGWIKaimXpbpD8Ttd7uXRJ/JLwuFECJsDFUEC7TPRInFjAKsc+P65FiVMBzGpEq6U
         XcWfYnazumOI0ppIJGUMpSGFoACsF3qYKgeifp+l6NNj9ejdsPoxJ4xleQa5iRkY0R3k
         6KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779300461; x=1779905261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nklZPvrJ0WfKoc1xZCOc0oOhjU6AGmqWwTNyTfjgmsQ=;
        b=g7g9schrXl+cOr74yOn3Q4psq8T867fw0SL5AgVvPnUdwxViMwdc2Dw2bTcWQSVmFi
         ODuukAHSpXnd7379msepzDyEhVaH7Bp+HTFlZtnAaXrPYBPtYWxJln8i7ryIcwPD6Wnd
         Mp0OhRoI8OjsKeiyzY3a6aWyQAWm8vcdi+FD2oXoYM6qqG1AHRu01EzEWldbx4wLpM5m
         nqldYsCEpoVgvGVR7iC1TTRzlgCs7qK8YsQodYlAJsDvUWxldFQbyJGkvW0PmWm65Ldb
         gOxpGT+rpRYL8dUzfbEXdt0xpxoYtt954wEr23OnbTEMeMqT2WZpbw9suuEaECsrCrqr
         Xehw==
X-Forwarded-Encrypted: i=1; AFNElJ/n/kZ8idB4D4ZJCnllPEm4qQpy5oUVtWhF5ysQtAo6F5mOiKOmXvbCZHkF05f38wBRKPNoR90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu+T2o1b9EiUi68P34wYBRTwimc+d418Y/rc022Qk7C/Bdla7B
	IgEZnuAqTNPfhElRSBjTwvLEFDoCETIa/49V2jlonDZKq2BDJXnOhNBtV4B1OA18RhjoiQ==
X-Gm-Gg: Acq92OEYzipSXGus7XnuorzIbItaP+CpkaEQJvQ2o/plmOjiwPITM/f1FIzjkJlzFPV
	cHvoWQ6sxH75KSvLudEhfJw+IObwva0GnbGGczXr4NfyjE8clx9zsd8VkuUtrtSfcw2Lbj3Fw1i
	PlXCftgcsY34T6lOa/2wq4Vw7Kx5WzXzBSXpPJ+QYY/df1Jja8eQOAg/E9yldWemHahX/7RtFri
	mNSvaFfg1JQ2CTKScGitzDjtOM9NUJekrMiRO6y+r7EFEMxtUBtdohGEayOnHscvTIvW1z5ndjF
	YtqoQXDeEy3P1VDG4gtPtgC7r36ECldutUdT5sUOaMBVdsj3o/rGqkeSfUpdMRw1VG1wljP1BGV
	THHsW6LM85RB4i3p0GP+RctCLEkIGz03z5+w/3KiQOkIc6wcS+TfzRpW8+rJF7tyxdkS25b2140
	2C2x9AyleG/z6+kS/RKXfFduUf3jIndJcWJnK89A==
X-Received: by 2002:a05:7300:a505:b0:2e2:4979:eb5 with SMTP id 5a478bee46e88-303982b2f85mr11180375eec.10.1779300460601;
        Wed, 20 May 2026 11:07:40 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30294500726sm18183954eec.10.2026.05.20.11.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 11:07:40 -0700 (PDT)
From: Shaomin Chen <eeesssooo020@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Hopps <chopps@labn.net>,
	stable@vger.kernel.org
Subject: [PATCH net] xfrm: iptfs: reset runtime state when cloning SAs
Date: Thu, 21 May 2026 02:07:23 +0800
Message-ID: <20260520180723.965339-1-eeesssooo020@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-252356-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eeesssooo020@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6313A59AAB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iptfs_clone_state() clones the IPTFS mode data with kmemdup(). This
copies runtime objects which must not be shared with the original SA,
including the embedded sk_buff_head, hrtimers, spinlock, and in-flight
reassembly/reorder state.

If xfrm_state_migrate() fails after clone_state() but before the later
init_state() call has reinitialized those fields, the cloned state can be
destroyed by xfrm_state_gc_task() with list and timer state copied from the
original SA. With queued packets this lets the clone splice and free skbs
owned by the original IPTFS queue, leading to use-after-free and
double-free reports in iptfs_destroy_state() and skb release paths.

Reinitialize the clone's runtime state before publishing it through
x->mode_data. Because clone_state() now publishes a destroyable mode_data
object before init_state(), take the mode callback module reference there.
Avoid taking it again from __iptfs_init_state() for the same object.

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Cc: stable@vger.kernel.org
Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
---
 net/xfrm/xfrm_iptfs.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e55ba..6c6bbc040517 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2650,7 +2650,8 @@ static void __iptfs_init_state(struct xfrm_state *x,
 	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
 
 	/* Always keep a module reference when x->mode_data is set */
-	__module_get(x->mode_cbs->owner);
+	if (x->mode_data != xtfs)
+		__module_get(x->mode_cbs->owner);
 
 	x->mode_data = xtfs;
 	xtfs->x = x;
@@ -2658,22 +2659,39 @@ static void __iptfs_init_state(struct xfrm_state *x,
 
 static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
 {
+	struct skb_wseq *w_saved = NULL;
 	struct xfrm_iptfs_data *xtfs;
 
 	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
 	if (!xtfs)
 		return -ENOMEM;
 
-	xtfs->ra_newskb = NULL;
 	if (xtfs->cfg.reorder_win_size) {
-		xtfs->w_saved = kzalloc_objs(*xtfs->w_saved,
-					     xtfs->cfg.reorder_win_size);
-		if (!xtfs->w_saved) {
+		w_saved = kzalloc_objs(*w_saved, xtfs->cfg.reorder_win_size);
+		if (!w_saved) {
 			kfree_sensitive(xtfs);
 			return -ENOMEM;
 		}
 	}
+	xtfs->w_saved = w_saved;
+
+	__skb_queue_head_init(&xtfs->queue);
+	xtfs->queue_size = 0;
+	hrtimer_setup(&xtfs->iptfs_timer, iptfs_delay_timer, CLOCK_MONOTONIC,
+		      IPTFS_HRTIMER_MODE);
+
+	spin_lock_init(&xtfs->drop_lock);
+	hrtimer_setup(&xtfs->drop_timer, iptfs_drop_timer, CLOCK_MONOTONIC,
+		      IPTFS_HRTIMER_MODE);
 
+	xtfs->w_seq_set = false;
+	xtfs->w_wantseq = 0;
+	xtfs->w_savedlen = 0;
+	xtfs->ra_newskb = NULL;
+	xtfs->ra_wantseq = 0;
+	xtfs->ra_runtlen = 0;
+
+	__module_get(x->mode_cbs->owner);
 	x->mode_data = xtfs;
 	xtfs->x = x;
 
-- 
2.47.3


