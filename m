Return-Path: <stable+bounces-262175-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SwPTBcGOJ2qIywIAu9opvQ
	(envelope-from <stable+bounces-262175-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 05:55:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEED65C216
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 05:55:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262175-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262175-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB629305541B
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 03:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2D1399365;
	Tue,  9 Jun 2026 03:52:58 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ACE3BF69C;
	Tue,  9 Jun 2026 03:52:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977178; cv=none; b=XzhaIMxqo0gTo2+yLj+T0NNisHR6upGFpvlS9HHIluJKE43ifxY/Jz3rgU5QD87OwqoKKLzbTaYAyl0Fzl0TLKLZ0kTulaDNPX437iP65kLIl82SuaK+p/GypMSisSphZW/NETYeztLKK/ZaTV3dsFNV98xhIChEbtMelidV9Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977178; c=relaxed/simple;
	bh=riT7L5N3UztfxirXwAWdjKB3Ye0PfkB5zpmJwLZ/I5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Psw3yiicGwsGNqJvXohRSRZ9m1CsvLjaUxvZ+TWliRc9MEDgABDN+yHQDVYA9dSjBiKEwAxBCURSVyQF9QZMRD/RA7JyABjFe2BPGmqHLeC5DteC3vjJJEK4N2B+FJoP3ve+lC2NdixUwdkHOTqfUsg5pdncn+7jnBvCs590CFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAAnzNQSjidqKHH2AA--.12091S2;
	Tue, 09 Jun 2026 11:52:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	bmarzins@redhat.com
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] dm log writes: fix refcount leak in log_writes_map()
Date: Tue,  9 Jun 2026 03:52:43 +0000
Message-Id: <20260609035243.184530-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAnzNQSjidqKHH2AA--.12091S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xKF18Cw13ury7Cw4UJwb_yoW8Xr18pa
	yUWFyYyFZ5Kw4jgFn8Za1kGFyfua17JFW3urW8W34rXay5XF9rJFZ5ta9Yq3yjkFsrCF9x
	XF4jgryUCa1UAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWrXVW3AwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUyEEU
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwNA2onYk+eiQABsy
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262175-lists,stable=lfdr.de];
	DMARC_NA(0.00)[iscas.ac.cn];
	FORGED_RECIPIENTS(0.00)[m:agk@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:bmarzins@redhat.com,m:dm-devel@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:vulab@iscas.ac.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vulab@iscas.ac.cn,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email,iscas.ac.cn:mid,iscas.ac.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5AEED65C216

In log_writes_map(), when a discard bio is received and the device
does not support discard, a pending block is allocated and its
pending_blocks refcount is incremented, but the block is never
freed. The function calls bio_endio(bio) and returns
DM_MAPIO_SUBMITTED directly, bypassing normal_end_io() which would
enqueue the block for later release via the kthread. As a result,
the refcount for the associated pending block is leaked, and
pending_blocks never reaches zero, preventing log_writes_dtr() from
completing and causing the device destruction to hang.

Free the block with free_pending_block() before completing the bio
in the !device_supports_discard path, matching the error handling
done when page allocation fails.

Cc: stable@vger.kernel.org
Fixes: 0e9cebe72459 ("dm: add log writes target")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/md/dm-log-writes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index c72e07c3f5a0..05133b1553ca 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -709,6 +709,8 @@ static int log_writes_map(struct dm_target *ti, struct bio *bio)
 		WARN_ON(flush_bio || fua_bio);
 		if (lc->device_supports_discard)
 			goto map_bio;
+		free_pending_block(lc, block);
+		pb->block = NULL;
 		bio_endio(bio);
 		return DM_MAPIO_SUBMITTED;
 	}
-- 
2.34.1


