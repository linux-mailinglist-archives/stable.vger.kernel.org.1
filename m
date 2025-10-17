Return-Path: <stable+bounces-186318-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F86BE89DE
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 14:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0641E1895731
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F221E2DC328;
	Fri, 17 Oct 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mo1VEyor"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19F52E5B2A
	for <stable@vger.kernel.org>; Fri, 17 Oct 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704880; cv=none; b=uWaqofrSt5XU83cKWyohHk+SuutLYTKLYzjFp3a90mjRhqL9026N8rckpAuYiQdqlvKGv8ainNuUB9L7dvL5+f9OoBaKt04MH63Uor4mvipqYUtxfiYB53Qv4K0sil5ZU4lFvCvMJC9/MtqtQYG3VRG9tY94do7q7rA5dT5K+Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704880; c=relaxed/simple;
	bh=QOmhYdUeVA3WpvWgx+h0hoshkHeKvHFgBi3ubo4tYNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKouhIdaFSPCHK/hC+c4eCylcUP2bi+6OuGipEjx3KTUzrMkbu5vbyMdG5vzEejYzTpGcwZxxPc4N+eelmyFfQtdQgrXj9DbBGp2hSJP5ZNHmyw7IRWw5QxebfytxosI256anj0tuC0u/OkFAG0IOWTG8wD3jl1QNKrL4xNvIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mo1VEyor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4EFC4CEE7;
	Fri, 17 Oct 2025 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760704880;
	bh=QOmhYdUeVA3WpvWgx+h0hoshkHeKvHFgBi3ubo4tYNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mo1VEyorAl5RHDMJiTxeaW+NQdDmeeaUmGMtR0uMQpck8CSdUUzP0NtzLTP0qJJtf
	 Ja5jGdLhUmXOo0MeBSKB5Bo5oAjmBrgGf9jTEZkIKhtl7vI8Fvijo6YDu9W6+xAia5
	 2jPm1kwq19SaG2+Iwzais9DdQE7il7D88FLxuSbIJvdrGxgU4hr5WEd2VLH3inp5k0
	 +E7LMzwO6Cg+x9+yn7ef1Uhq2CNAAfrLv1IHZBghApa4wZPGHutXByM5td/EDxtSOY
	 FpPR+3aZu5ZaJRnHxZOkzu1J5rJJF8rdRpVpY515gt7xOJzmIwJXD+b6ZWZERBYg18
	 4/dISjGa4Ta0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jason Andryuk <jason.andryuk@amd.com>,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] xen/events: Cleanup find_virq() return codes
Date: Fri, 17 Oct 2025 08:41:17 -0400
Message-ID: <20251017124117.3889367-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101626-colony-unbend-f00e@gregkh>
References: <2025101626-colony-unbend-f00e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Andryuk <jason.andryuk@amd.com>

[ Upstream commit 08df2d7dd4ab2db8a172d824cda7872d5eca460a ]

rc is overwritten by the evtchn_status hypercall in each iteration, so
the return value will be whatever the last iteration is.  This could
incorrectly return success even if the event channel was not found.
Change to an explicit -ENOENT for an un-found virq and return 0 on a
successful match.

Fixes: 62cc5fc7b2e0 ("xen/pv-on-hvm kexec: rebind virqs to existing eventchannel ports")
Cc: stable@vger.kernel.org
Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20250828003604.8949-2-jason.andryuk@amd.com>
[ converted evtchn pointer output parameter to direct port return value ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/events/events_base.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index f8554d9a9f28e..fd16b995425dc 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1210,10 +1210,12 @@ EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irq_lateeoi);
 static int find_virq(unsigned int virq, unsigned int cpu)
 {
 	struct evtchn_status status;
-	int port, rc = -ENOENT;
+	int port;
 
 	memset(&status, 0, sizeof(status));
 	for (port = 0; port < xen_evtchn_max_channels(); port++) {
+		int rc;
+
 		status.dom = DOMID_SELF;
 		status.port = port;
 		rc = HYPERVISOR_event_channel_op(EVTCHNOP_status, &status);
@@ -1221,12 +1223,10 @@ static int find_virq(unsigned int virq, unsigned int cpu)
 			continue;
 		if (status.status != EVTCHNSTAT_virq)
 			continue;
-		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(cpu)) {
-			rc = port;
-			break;
-		}
+		if (status.u.virq == virq && status.vcpu == xen_vcpu_nr(cpu))
+			return port;
 	}
-	return rc;
+	return -ENOENT;
 }
 
 /**
-- 
2.51.0


