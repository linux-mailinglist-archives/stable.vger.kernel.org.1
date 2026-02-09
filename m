Return-Path: <stable+bounces-215018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJRNEQ3xiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89621110873
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F05BC304F36C
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827B237B3E9;
	Mon,  9 Feb 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jv+6nCQy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C1437AA7E;
	Mon,  9 Feb 2026 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647398; cv=none; b=Vu55scAWhTdJ3QztgIWx4QnrWlKB8HsvikdhC3s1PLajQXVd8NaMyZAFSuYRrF/xNDOx8cDzwNhWP4AffrDNzIS/P4H+6UjPnMolBKqbgAi/Yk2WpBli7ii0EeBRomEFwSC14CVKzf5mhqC6wl08jzFi8VQ/6OOA/ynQQsOlpZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647398; c=relaxed/simple;
	bh=mpXruYHluAmCpZdps/0S872dFp+1R+4ckRvuAGWNu00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+9G6K0wDyrWHhZmqOQIazpKu9oBSwy44W12j4qbNxI9PFXIkRM+h3ovApMki5ZS67wFr+yE5NRy5hVdGHSGYzsGOIm/X2TlTrQEHgSpkk9jK7qWh5uuKAi7h0JAks/9kKtcUuCMfUB9Tj6NHwUJ5LyhECOwlpG1Tbm1KS66dy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jv+6nCQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8336C116C6;
	Mon,  9 Feb 2026 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647398;
	bh=mpXruYHluAmCpZdps/0S872dFp+1R+4ckRvuAGWNu00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jv+6nCQy3zxfX2mDPIfbEg35/ewDXgIsVH8Fso0yUmKbepeFdxybUifYufzhrNguE
	 JZtkF0Jx2XaiXcuH4qmZwTLZvkUdsPPErRfkcvK6cT1El/6CrhOX3uKBdhqsUCy8Jz
	 oi6cW/WXwwyXojyQ04T1pcfzHjOqCc+7I/YUKEcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yu Kuai <yukuai@fnnas.com>,
	shechenglong <shechenglong@xfusion.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 054/175] block,bfq: fix aux stat accumulation destination
Date: Mon,  9 Feb 2026 15:22:07 +0100
Message-ID: <20260209142322.412751369@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
References: <20260209142320.474120190@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215018-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernel.dk:email]
X-Rspamd-Queue-Id: 89621110873
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: shechenglong <shechenglong@xfusion.com>

[ Upstream commit 04bdb1a04d8a2a89df504c1e34250cd3c6e31a1c ]

Route bfqg_stats_add_aux() time accumulation into the destination
stats object instead of the source, aligning with other stat fields.

Reviewed-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: shechenglong <shechenglong@xfusion.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fb9f35331502..6a75fe1c7a5c0 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -380,7 +380,7 @@ static void bfqg_stats_add_aux(struct bfqg_stats *to, struct bfqg_stats *from)
 	blkg_rwstat_add_aux(&to->merged, &from->merged);
 	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
 	blkg_rwstat_add_aux(&to->wait_time, &from->wait_time);
-	bfq_stat_add_aux(&from->time, &from->time);
+	bfq_stat_add_aux(&to->time, &from->time);
 	bfq_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum);
 	bfq_stat_add_aux(&to->avg_queue_size_samples,
 			  &from->avg_queue_size_samples);
-- 
2.51.0




