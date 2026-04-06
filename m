Return-Path: <stable+bounces-233371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKAgCFGX02n3jQcAu9opvQ
	(envelope-from <stable+bounces-233371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 13:21:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FF13A3153
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 13:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29543300FEFF
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 11:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468B031D381;
	Mon,  6 Apr 2026 11:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJtRiNKZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414B30F7EF
	for <stable@vger.kernel.org>; Mon,  6 Apr 2026 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775474509; cv=none; b=gULFhBL5hWTFj/VrwutuBko+Oem5fL+ySVklZQKq/Qiqx4Zjdeyqxw1HmpwfWPGhiMQ/a6SZY4t/nV8TTxJj/HdnTCMHVGkmCxa8EORaj4CHAsnt0Gi56wrMgcdc3IL12efrOXahgwjy+pgdGewK9D+IaU/Tzmhq0FvzZj340As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775474509; c=relaxed/simple;
	bh=Gb3nZJX08hSpzm6AWZbXNgCt91twbjLjgMG4piUjSS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPOqlJvf6fNxxpmZJhpnXkEDpuLqtthgpr1D8Bfp9LL6LK3tAuxJNWv1z3jETQp7FpqshuL+M7+m1pA48zYEmdBqK1EIp0YSZJDCmGZObQjh4ZUzHWFSHiWxSVmLmfNxbRx4meyeKL92AH4QYiJCF+gy+gvo4AEbZy6xY2gyNz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJtRiNKZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775474507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cP5EVArCawQIz7cxWEYg9C3osdTcwWJT1kUDvk6U14I=;
	b=WJtRiNKZtse6gFcyWNNH2diPRfFgivCUUsPtw5FdlTSikv/q+gsKRSRdVNK+98vlWCwZyk
	QwEB7VITceJh/8pJTFst4yMG+fMm8S5XogPbcjJ0MKlPuT90n6wkGWDI4bGvn+H+sgtQXZ
	LCsS4nQvqGbW7KqnTSnCERos31Nb0pU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-ACMuyeuWO_SqXKnXjyWWrA-1; Mon,
 06 Apr 2026 07:21:44 -0400
X-MC-Unique: ACMuyeuWO_SqXKnXjyWWrA-1
X-Mimecast-MFC-AGG-ID: ACMuyeuWO_SqXKnXjyWWrA_1775474502
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B65A619560A7;
	Mon,  6 Apr 2026 11:21:42 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.48.51])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9718A300019F;
	Mon,  6 Apr 2026 11:21:38 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH net 3/3] iavf: drop netdev lock while waiting for MAC change completion
Date: Mon,  6 Apr 2026 13:20:57 +0200
Message-ID: <20260406112057.906685-4-jtornosm@redhat.com>
In-Reply-To: <20260406112057.906685-1-jtornosm@redhat.com>
References: <20260406112057.906685-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233371-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74FF13A3153
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After commit ad7c7b2172c3 ("net: hold netdev instance lock during sysfs
operations"), iavf_set_mac() is called with the netdev instance lock
already held.

The function queues a MAC address change request and then waits for
completion while holding this lock. However, the watchdog task that
processes admin queue commands (including MAC changes) also needs to
acquire the netdev lock to run.

This creates a lock contention scenario:
1. iavf_set_mac() holds netdev lock and waits for MAC change
2. Watchdog needs netdev lock to process the MAC change request
3. Watchdog blocks waiting for lock
4. MAC change times out after 2.5 seconds
5. iavf_set_mac() returns -EAGAIN

This particularly affects VFs during initialization when enslaved to a
bond. The first VF typically succeeds as it's already fully initialized,
but subsequent VFs fail as they're still progressing through their state
machine and need the watchdog to advance.

Fix by temporarily dropping the netdev lock before waiting for MAC change
completion, allowing the watchdog to run and process the request, then
re-acquiring the lock before returning.

This is safe because:
- The MAC change request is already queued before we drop the lock
- iavf_is_mac_set_handled() just checks filter state, doesn't modify it
- We re-acquire the lock before checking results and returning

Fixes: ad7c7b2172c3 ("net: hold netdev instance lock during sysfs operations")
cc: stable@vger.kernel.org
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index dad001abc908..6281858e6f3c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1068,10 +1068,14 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
 	if (ret)
 		return ret;
 
+	netdev_unlock(netdev);
+
 	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
 					       iavf_is_mac_set_handled(netdev, addr->sa_data),
 					       msecs_to_jiffies(2500));
 
+	netdev_lock(netdev);
+
 	/* If ret < 0 then it means wait was interrupted.
 	 * If ret == 0 then it means we got a timeout.
 	 * else it means we got response for set MAC from PF,
-- 
2.53.0


