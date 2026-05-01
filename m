Return-Path: <stable+bounces-242246-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEUPGNRt9GlcBQIAu9opvQ
	(envelope-from <stable+bounces-242246-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:09:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2064AB2B2
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 11:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76FFB30093B6
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 09:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563437EFE1;
	Fri,  1 May 2026 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJW07Cpc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF737D13B
	for <stable@vger.kernel.org>; Fri,  1 May 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626566; cv=none; b=Q/FTCMxGb7vrWXX7HxW8r0jxoM05uX2nyXjlwa2HzJOE3wh9GVI5CrXEGab2mYoPVl9kKKtYsNkM/lkJEfZPXcp7+TRLkNK2tNqiX3WHbbuLZxMh+miMY9HkpaDBOgob9zXw/G/g6maLSmV27ygM61y5aMpFkColmNV1/iPRUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626566; c=relaxed/simple;
	bh=89jlVxW1k1DaDpOVsCpZaDI95QQVTHGjkXHGWhY6j08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fq9ZwvZioG5GDP0/JFrfgog18jIbCfr19NUtMdlwd2J0yjsafxp8Y1c7N7cSNw/Fg/quhlJR+xugmM9QG/u4lD23h42DPu+Le0IIHyM6mu1HE7VTf6ZbzSPD8N+EU/U6hMJDN+rCE46vc7SjkAOp6N9jVb4MRnQjJRJP1ZFQFvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJW07Cpc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c7b9f54d3deso1079990a12.1
        for <stable@vger.kernel.org>; Fri, 01 May 2026 02:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777626563; x=1778231363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zyTlFLeJ1G6PI38qtRjcufp4nAkxnC1Ry8Nmrz84v+c=;
        b=KJW07CpcKPsjZ7NONt6vid4z1zuUsyQF1VlkSfB/qYfG+KX63QzQVo+dcnGhaqSIwI
         Gm0h03uXIuYiiq1Mc2NIX1NxCScNJIzT5NfWtOZg9JxuQMsvDkHuN6hcfx2cWeELARGN
         1WUKO5qSpVFxdkP2ojjQ3tAuOZKyp//qPVCLwY7w2rX3DkMT8FTVB/UOR0/cUwsMqSic
         OkmZeQ0oI1vEk8mGCYlLY3VdM49NNL29dx/wIJ+ZVUDmakAlDk9blJS548bfXN8PHbsz
         EcLJfhkV5NV+gIh9hRrAePe41Rb2evl4BUuoC6HEQ7l1Q+YYKpGcH3wXbRgiM56MWdzq
         yh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777626563; x=1778231363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyTlFLeJ1G6PI38qtRjcufp4nAkxnC1Ry8Nmrz84v+c=;
        b=JggT3yz1BwlYLVco4o0LHDELqBpR5TLvo9kZUOuq4TPlIyCkV0isrYScO4M15kbNI5
         rmoi7iQspdpBab3O+HwDmgNDUHjs9iaxwwzJZg222N4Unqppfn/n/C3ziHaIhN0xsXLn
         UMx9qlu0rZCip/JJOIGwfw02Yh2qyOjcUsJ1i5D7tMkxKgfuzwiVSa3hyl43FlUlbeVI
         04DoVAiC/ucx+PyYnF3S9C7Gg4qlVi3MNgFI08Iz6+FT8m80JWLvSkQUae6msD4aT+eB
         qZ8C7B/wLHmgqiZj9YGvlbLiRbHuDPY0Ga0XmKKF/954mjybB9c+2cgDLTfWh1CdbWGP
         NS/g==
X-Forwarded-Encrypted: i=1; AFNElJ9VWcUHU+JMQhFFnMtkO/BaKB9qOASeNTtJMgdiznBXBw+vkF7iGeiQhkODvj0M4yXkb75h9pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvaoaHX79lsbqIZXDPZCryBkUvlA8WC7Ta/8mFg+0JkeCX643A
	ripW31V2wxhHTxWweptAf20p6k4WlJO1ZPJetssOF/ZmfEa4q3aoxx0B
X-Gm-Gg: AeBDietuYiYmQB0vjPSI8yfVtNEyfwoZ/CNpTPHC94LqEdnjPaZtNYJ6L6RMYTgT69q
	48c3l2ZkBYJz3lsfCTEt9P2bvrjPItjHnNlaJzkIP30QlG2Vyz6WA/3qGu+z8vxhkZS+8MIqJP0
	qyG84UWRzhzFrhP5HXhXqsmUal9xtjISu9RRW8A5siARBB6WRBSrR4Ej/BEKSGNzKBCop63LFr+
	L3nMNcy9jXtZp2K2kCdBgoT/NkNbYbXsmmm4UpKSkbDUOoGyN06hXy0Mr2vWp5lZgBax95A1BjK
	ObbwVtYtxZMxexwwKXi5u72ZYUqDRh/v40ll0qZ6WxER+c9R51cuLu0hFsCJwHRp6wCGEQvZu27
	EbRLZ90M5XsebYhuef9s1EICUmaPGiRVYSXhahjAXyRZm0XRzxORTjqLdIsnPMBBnhDCOyyD7i3
	bJzCMVDzTo1195WX0g
X-Received: by 2002:a05:6a21:e081:b0:3a2:d79c:416d with SMTP id adf61e73a8af0-3a3cf86c261mr7683626637.43.1777626562812;
        Fri, 01 May 2026 02:09:22 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::5a26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbbbc9dasm1675365a12.9.2026.05.01.02.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 02:09:22 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Abylay Ospan <aospan@amazon.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: helene: fix possible double free in helene_probe()
Date: Fri,  1 May 2026 17:06:57 +0800
Message-ID: <20260501090657.492534-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AB2064AB2B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-242246-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

helene_probe() allocates the private data with devm_kzalloc(), so the
memory is managed by the i2c client's device and will be released
automatically on driver detach.

However, helene_probe() copies helene_tuner_ops into fe->ops.tuner_ops,
including the .release callback.  helene_release() frees fe->tuner_priv
with kfree(), which is correct for the non-devm helene_attach() paths,
but not for the devm allocation used by helene_probe().

Clear the .release callback in the i2c probe path after copying the
tuner ops, so the devm-managed private data is not freed by
helene_release().

This issue was found by a static analysis tool I am developing.

Fixes: 817dc4b579d8 ("media: helene: add I2C device probe function")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/dvb-frontends/helene.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/dvb-frontends/helene.c b/drivers/media/dvb-frontends/helene.c
index 1402d124544e..1ff8c06d06fb 100644
--- a/drivers/media/dvb-frontends/helene.c
+++ b/drivers/media/dvb-frontends/helene.c
@@ -1091,6 +1091,7 @@ static int helene_probe(struct i2c_client *client)
 
 	memcpy(&fe->ops.tuner_ops, &helene_tuner_ops,
 	       sizeof(struct dvb_tuner_ops));
+	fe->ops.tuner_ops.release = NULL;
 	fe->tuner_priv = priv;
 	i2c_set_clientdata(client, priv);
 
-- 
2.43.0


