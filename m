Return-Path: <stable+bounces-167571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F628B2309D
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8912D17F1A5
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE822FDC2F;
	Tue, 12 Aug 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q2agAuGB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B42DE1E2;
	Tue, 12 Aug 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021264; cv=none; b=tiyaPGGybRm3K7NqhgJlCS/fR0fuzCf9kK3NxXKYUT8GEJ5IGeh9kfId0ZS6KnQElJCt/Jse0q3w+21t+eifdtwahlhWbyWaoz3slr2rordDmtGxIyJOB8sr+08HlSsYBLMaLUeYB5duMco4wRCojurYh5zghqQ0BlJAcaHqXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021264; c=relaxed/simple;
	bh=vDhluTV0fGV2vVNKQAisHf1kJSJvYegP+6xWiAUOR1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVKOFh3BGNXwgAKRzbeqhOrzQOqoPwHmVBrsQlNCtWHYw0R7QAZ90Ldlhqg6SUOD+2oDMUMPnaMGxvw7Cw8huyz9kbixQZvRSTUByL7NCBBvrs64qolhlQCV4zzHPQpk/ja6MG/GXpekyJYL9XIdA7Hb+CVDxh4jxqAdrC+A1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q2agAuGB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053C9C4CEF0;
	Tue, 12 Aug 2025 17:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021264;
	bh=vDhluTV0fGV2vVNKQAisHf1kJSJvYegP+6xWiAUOR1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q2agAuGBxhRlnnShH93Ll/u2rgZk1mPDBurZlrY6+1fWpAFRR++YsKeVI3C5E04w4
	 MtIdtIZA3fhsFOtH1Y+JeUrYcAjJYlKm0I9Tx4qBnC2qPBmmmHNCBY+8RkCNAObUNj
	 ARx15eJ5FeVqWmE5+NgjCKI1EmfIQHFBUmF1Rvas=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Quang Le <quanglex97@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 237/253] net/packet: fix a race in packet_set_ring() and packet_notifier()
Date: Tue, 12 Aug 2025 19:30:25 +0200
Message-ID: <20250812172958.919964898@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Quang Le <quanglex97@gmail.com>

commit 01d3c8417b9c1b884a8a981a3b886da556512f36 upstream.

When packet_set_ring() releases po->bind_lock, another thread can
run packet_notifier() and process an NETDEV_UP event.

This race and the fix are both similar to that of commit 15fe076edea7
("net/packet: fix a race in packet_bind() and packet_notifier()").

There too the packet_notifier NETDEV_UP event managed to run while a
po->bind_lock critical section had to be temporarily released. And
the fix was similarly to temporarily set po->num to zero to keep
the socket unhooked until the lock is retaken.

The po->bind_lock in packet_set_ring and packet_notifier precede the
introduction of git history.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Quang Le <quanglex97@gmail.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20250801175423.2970334-1-willemdebruijn.kernel@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4541,10 +4541,10 @@ static int packet_set_ring(struct sock *
 	spin_lock(&po->bind_lock);
 	was_running = po->running;
 	num = po->num;
-	if (was_running) {
-		WRITE_ONCE(po->num, 0);
+	WRITE_ONCE(po->num, 0);
+	if (was_running)
 		__unregister_prot_hook(sk, false);
-	}
+
 	spin_unlock(&po->bind_lock);
 
 	synchronize_net();
@@ -4576,10 +4576,10 @@ static int packet_set_ring(struct sock *
 	mutex_unlock(&po->pg_vec_lock);
 
 	spin_lock(&po->bind_lock);
-	if (was_running) {
-		WRITE_ONCE(po->num, num);
+	WRITE_ONCE(po->num, num);
+	if (was_running)
 		register_prot_hook(sk);
-	}
+
 	spin_unlock(&po->bind_lock);
 	if (pg_vec && (po->tp_version > TPACKET_V2)) {
 		/* Because we don't support block-based V3 on tx-ring */



