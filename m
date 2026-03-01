Return-Path: <stable+bounces-222481-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5lUeIqCqpGkNogUAu9opvQ
	(envelope-from <stable+bounces-222481-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 22:07:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BB21F1D1978
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 22:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5DFC6300F94A
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 21:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8852C32E696;
	Sun,  1 Mar 2026 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJwuXD4I"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153C11DF980
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772399260; cv=none; b=axZKEHAwLhGH7BFf86Kmu1cVhyxmqVTUydgRS8FOD9Emz1+7nrXUqCxQbxhulhVeej5FfdXWPWXmT0LYKjYWWJlspzxngDmNdDxsrpP/HVlQ1YByJuVXHfr66LVPb5oi2JqmjWxAUww4DN1BCZ0G8VFPE7ALNVNLH4gfHWGlA0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772399260; c=relaxed/simple;
	bh=tn7ik9AyBb0NPDqOj5PKOQkDMxeMJ5eXuXxBu+YVLZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GJZszPzZ0bRWlcmJRfgb2Xhks5cVuBYWWdNhrweneSFhcmvhRnxIgYIlihukaFw+IbY1PPW3JdJgm6euHjDLvkENKvebYvuid213oailKGJ5ETfJ8m0ctVmjttHNjfxZjxD2MhHEXaC8JGWkxsybsdFjSz3To+y/TQO1vqtsvLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJwuXD4I; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4833115090dso38193205e9.3
        for <stable@vger.kernel.org>; Sun, 01 Mar 2026 13:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772399257; x=1773004057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgyk8pX/VzX0B/Mf+s7nhMSchzyVmAxwHP9JMWom8BM=;
        b=cJwuXD4IyGpz5kCC0HshUx5ELeyVVZT7uMYbrkOBPtJTlsxYSH3tMF+be5T+tSsmLA
         wGTIt6TF1YdvM+QfGKfYMnu+WRyP+PXrtd9j4kcSfPDkmDkz63K3QWYyFPuQOtIPdNwk
         6k1n6fLrQQ+v2wgiUWkVWFfjZaCZjY25sWIPDiGSJU83rkVO2CucrQSNBHhHCfj1M16c
         80WwufzhsrAyxLcyyMlSSg0X7xzK7KqMiBgb7kI/HwyywU6LT0aVnX0WbkFFaBc6h6+T
         vdManudwOOGU1URUcmXEE1HqBn/v858FFCntLTC2aW8q+ugbkTXQwxCPmxb/AJEcuHxO
         lePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772399257; x=1773004057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgyk8pX/VzX0B/Mf+s7nhMSchzyVmAxwHP9JMWom8BM=;
        b=NJ2o8zgEYhpFoSsbE04OQsnO/WCI3DdJ7hEmIzT9YKAV6GN52CS5F2zIcZ+7qsY4lH
         pQDNw2+/YTpSwN4h8RwoEiRBYFRhJPHrN0ehWv12ypRNEyRdwa5oEHYr6sV3ySygoA6r
         7Q/TlIXieJOF3iwIA61tZghc1XGg/RYzIBFlPOxsPPCxNZa6IJoOzHqCTwxDEVNgN+9U
         2N7XpvEx7PvBDGsq9EsAqvgkglCS+PIf4JpDaHlTDWqS4dWezn4OjXVx9p1iMm3TSgxt
         Mz2kdChmuxI8FEuj1vnh2vt0hpXSURL45eqvU4XQ4bA3eCeIxatzfyKWTb0tAibnWss0
         oAng==
X-Forwarded-Encrypted: i=1; AJvYcCUva/N2jdEkOiqZ9kLUT4IhsHLXZ998tsU+nSduKlXflo3pJphXuBgLBcD6DXopx6LO+L7BZ08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgPWC3yoT20gkfd4BHNNepKYWpNiqRDdsK2pJhwzZkT9yglNs+
	dloPfmT1iBPj8V+64Q2C8SBufbUltRBKliHK3VxOV06O5BNf49lLQDiL
X-Gm-Gg: ATEYQzyd+NQcJ20VxHtNcKqfV1wL6nScHc67UoyFxEprhs8UOs3nkmR9DIsr0tJStCx
	zR9sOo+Skxpe5Zn1xkPWp4MxV7qc+SRKONNtWb/LwnSEfCJQDtItxmj+rxfw9nD8sQO0nJ9xiVn
	lJteUZgd1YhZN1QGkwuLbZqttFsWT80L1s9PC8YHt/WdOr183a/VDzq8n1MFi9QpFhPex2oaiJU
	+VuD29a2wGe3gnTA4Yqhczk61H8haKLF+IMnBV1dOK+msQbXaiS4ZJkyu7HoOXrWSimld3YKnqm
	xjijEABi6nZTT+qLZ7dqUcHiVpZjixYbnxkrN4IuVWiSDaOH+gFO8/SWr1vZDQ184Fp+tVMKL27
	aZLo51oOJ/G9fyQ2GhImRH0fyFPOEX6NUwjufmGTVlHJBQFabNjpoIOtakXzXU2qc+cwUWNomJQ
	==
X-Received: by 2002:a05:600c:8b30:b0:483:afbb:a086 with SMTP id 5b1f17b1804b1-483c9c0e31amr163966695e9.29.1772399257214;
        Sun, 01 Mar 2026 13:07:37 -0800 (PST)
Received: from kimsufi.. ([2001:41d0:303:6f54::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6f26d7sm378556845e9.3.2026.03.01.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 13:07:36 -0800 (PST)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: syzbot+639ebc6ec75e96674741@syzkaller.appspotmail.com,
	"Daniel W . S . Almeida" <dwlsalmeida@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Ruslan Valiyev <linuxoid@gmail.com>
Subject: [PATCH] media: vidtv: fix nfeeds state corruption on start_streaming failure
Date: Sun,  1 Mar 2026 21:07:35 +0000
Message-ID: <20260301210735.334110-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <698aaf77.050a0220.1ad825.0033.GAE@google.com>
References: <698aaf77.050a0220.1ad825.0033.GAE@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,gmail.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222481-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linuxoid@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,639ebc6ec75e96674741];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: BB21F1D1978
X-Rspamd-Action: no action

syzbot reported a memory leak in vidtv_psi_service_desc_init [1].

When vidtv_start_streaming() fails inside vidtv_start_feed(), the
nfeeds counter is left incremented even though no feed was actually
started. This corrupts the driver state: subsequent start_feed calls
see nfeeds > 1 and skip starting the mux, while stop_feed calls
eventually try to stop a non-existent stream.

This state corruption can also lead to memory leaks, since the mux
and channel resources may be partially allocated during a failed
start_streaming but never cleaned up, as the stop path finds
dvb->streaming == false and returns early.

Fix by decrementing nfeeds back when start_streaming fails, keeping
the counter in sync with the actual number of active feeds.

[1]
BUG: memory leak
unreferenced object 0xffff888145b50820 (size 32):
 comm "syz.0.17", pid 6068, jiffies 4294944486
 backtrace (crc 90a0c7d4):
  vidtv_psi_service_desc_init+0x74/0x1b0 drivers/media/test-drivers/vidtv/vidtv_psi.c:288
  vidtv_channel_s302m_init+0xb1/0x2a0 drivers/media/test-drivers/vidtv/vidtv_channel.c:83
  vidtv_channels_init+0x1b/0x40 drivers/media/test-drivers/vidtv/vidtv_channel.c:524
  vidtv_mux_init+0x516/0xbe0 drivers/media/test-drivers/vidtv/vidtv_mux.c:518
  vidtv_start_streaming drivers/media/test-drivers/vidtv/vidtv_bridge.c:194 [inline]
  vidtv_start_feed+0x33e/0x4d0 drivers/media/test-drivers/vidtv/vidtv_bridge.c:239

Fixes: f90cf6079bf67 ("media: vidtv: add a bridge driver")
Cc: stable@vger.kernel.org
Reported-by: syzbot+639ebc6ec75e96674741@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=639ebc6ec75e96674741
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
 drivers/media/test-drivers/vidtv/vidtv_bridge.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vidtv/vidtv_bridge.c b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
index b6203e10e37aa..a8a76434989c2 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_bridge.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_bridge.c
@@ -237,8 +237,10 @@ static int vidtv_start_feed(struct dvb_demux_feed *feed)
 
 	if (dvb->nfeeds == 1) {
 		ret = vidtv_start_streaming(dvb);
-		if (ret < 0)
+		if (ret < 0) {
+			dvb->nfeeds--;
 			rc = ret;
+		}
 	}
 
 	mutex_unlock(&dvb->feed_lock);
-- 
2.43.0


