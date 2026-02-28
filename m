Return-Path: <stable+bounces-220342-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIV0ESU2o2nP+QQAu9opvQ
	(envelope-from <stable+bounces-220342-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 969B61C60E3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17F9932D53B8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDE639A4C7;
	Sat, 28 Feb 2026 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VU2fEvhb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E5C39A4BF;
	Sat, 28 Feb 2026 17:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300241; cv=none; b=R4TN3uot5s3tksctquw1tOW8iHpVjB37VGuVtICt6T5B43AErZeABbkcBMKNzid/p0SzAa+iVn0OiXgyJ4jTbq4QcEAR98CEQTHAd073paDipo77Xt0V+tVMIhFubEwNPe23D6Drwt0Z6LVUXk0vzQz25sS1j6dIZ7S4zjn2aok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300241; c=relaxed/simple;
	bh=I0fX+1jlFcw8DChdJT+PT3wBtP0zl/D7Tnn20vE+W3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tS4aDKZubH/GmMkBxEurlYu1KD1/fN3bk/PGB3MAZfzEKmh2igzN8h5zmnY4Mexa+Vf4L24cgSDMsxgKS4G28kgL0hAhj+3NL5neMjfccVwPNQ9Lpg+36IBo/Oyn89pcyvmcQPxkdoe1RhtaTC01uRdKZoEX3ndJ0SB4jCmC380=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VU2fEvhb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F8FBC19424;
	Sat, 28 Feb 2026 17:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300241;
	bh=I0fX+1jlFcw8DChdJT+PT3wBtP0zl/D7Tnn20vE+W3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VU2fEvhbTg0z4P10AnMNzb2lBaGSVeMgxgbf1fH8XQmOt8KfnDYnyEpdQLt5owVJn
	 M1QMdm/PPrQoUCsGkR1hg8rq6j+/jOdhvzgqFYIBednXmWfd+CHR+ic92aqabDhGNd
	 dFlN375t5ETatzA6nK4FiU4g9v+2YpnM7rA//uuW7HS+jHmoF/bMe0n/6D7RLo+CEM
	 5Z0vWfv8fjRLQ2kyvf5HOtkw8IyjuFH37Q9X6PANNyPKFYSuE1M7Y/azP/NK1fpBuh
	 u3j1b6bXKqPPXZBqNvv3H57R6uKSH+xcKs2gyD/KZhqNoB31Y4VYxslF2kcqH3JfWq
	 519j/RUqFDKtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ding Hui <dinghui@sangfor.com.cn>,
	Christoph Hellwig <hch@lst.de>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 264/844] dm: remove fake timeout to avoid leak request
Date: Sat, 28 Feb 2026 12:22:57 -0500
Message-ID: <20260228173244.1509663-265-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220342-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 969B61C60E3
X-Rspamd-Action: no action

From: Ding Hui <dinghui@sangfor.com.cn>

[ Upstream commit f3a9c95a15d2f4466acad5c68faeff79ca5e9f47 ]

Since commit 15f73f5b3e59 ("blk-mq: move failure injection out of
blk_mq_complete_request"), drivers are responsible for calling
blk_should_fake_timeout() at appropriate code paths and opportunities.

However, the dm driver does not implement its own timeout handler and
relies on the timeout handling of its slave devices.

If an io-timeout-fail error is injected to a dm device, the request
will be leaked and never completed, causing tasks to hang indefinitely.

Reproduce:
1. prepare dm which has iscsi slave device
2. inject io-timeout-fail to dm
   echo 1 >/sys/class/block/dm-0/io-timeout-fail
   echo 100 >/sys/kernel/debug/fail_io_timeout/probability
   echo 10 >/sys/kernel/debug/fail_io_timeout/times
3. read/write dm
4. iscsiadm -m node -u

Result: hang task like below
[  862.243768] INFO: task kworker/u514:2:151 blocked for more than 122 seconds.
[  862.244133]       Tainted: G            E       6.19.0-rc1+ #51
[  862.244337] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  862.244718] task:kworker/u514:2  state:D stack:0     pid:151   tgid:151   ppid:2      task_flags:0x4288060 flags:0x00080000
[  862.245024] Workqueue: iscsi_ctrl_3:1 __iscsi_unbind_session [scsi_transport_iscsi]
[  862.245264] Call Trace:
[  862.245587]  <TASK>
[  862.245814]  __schedule+0x810/0x15c0
[  862.246557]  schedule+0x69/0x180
[  862.246760]  blk_mq_freeze_queue_wait+0xde/0x120
[  862.247688]  elevator_change+0x16d/0x460
[  862.247893]  elevator_set_none+0x87/0xf0
[  862.248798]  blk_unregister_queue+0x12e/0x2a0
[  862.248995]  __del_gendisk+0x231/0x7e0
[  862.250143]  del_gendisk+0x12f/0x1d0
[  862.250339]  sd_remove+0x85/0x130 [sd_mod]
[  862.250650]  device_release_driver_internal+0x36d/0x530
[  862.250849]  bus_remove_device+0x1dd/0x3f0
[  862.251042]  device_del+0x38a/0x930
[  862.252095]  __scsi_remove_device+0x293/0x360
[  862.252291]  scsi_remove_target+0x486/0x760
[  862.252654]  __iscsi_unbind_session+0x18a/0x3e0 [scsi_transport_iscsi]
[  862.252886]  process_one_work+0x633/0xe50
[  862.253101]  worker_thread+0x6df/0xf10
[  862.253647]  kthread+0x36d/0x720
[  862.254533]  ret_from_fork+0x2a6/0x470
[  862.255852]  ret_from_fork_asm+0x1a/0x30
[  862.256037]  </TASK>

Remove the blk_should_fake_timeout() check from dm, as dm has no
native timeout handling and should not attempt to fake timeouts.

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-rq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index a6ca92049c10e..5e08546696145 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -278,8 +278,7 @@ static void dm_complete_request(struct request *rq, blk_status_t error)
 	struct dm_rq_target_io *tio = tio_from_request(rq);
 
 	tio->error = error;
-	if (likely(!blk_should_fake_timeout(rq->q)))
-		blk_mq_complete_request(rq);
+	blk_mq_complete_request(rq);
 }
 
 /*
-- 
2.51.0


