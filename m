Return-Path: <stable+bounces-212501-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DxBMf0zeml+4gEAu9opvQ
	(envelope-from <stable+bounces-212501-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1833FA5133
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2014A31E4EF9
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E534D309DD2;
	Wed, 28 Jan 2026 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1YAYR66Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974611D6AA;
	Wed, 28 Jan 2026 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615729; cv=none; b=ea4qxPN168YgRZy6R4IgYvLKOyENQU4tFuALE46BRgpIF8lcj68qGUNALnPS4zxqn70fETVnw65RxaZbK/hHT/h3NMr7ZpFZOAx/AkvMqCKgBkRM/yPIvghhak8KrHfNRnCbYML4WxOq1iu9fcT0gzjI9AlY/Ci53aQpQZqQ5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615729; c=relaxed/simple;
	bh=VlLJrFSmb4RZadccmNbTvsOK3aTaIf4UEpgTT78RKto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5/YfOs+iE31NJGrDEYE+dE9kCpphjv67NJhfqYRvoU+VuhR9tD6CtXPGDnLD5ozN+TySkXtqGYbcXmHYQE7ZtjudArVV2mqyYufjhnafOUXWVQG+fg0+poWa11zpUcGGKDs+MYiTLyJfI4FHOBXL62irGORkG9kGxnfRtb8mhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1YAYR66Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2531C4AF09;
	Wed, 28 Jan 2026 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615729;
	bh=VlLJrFSmb4RZadccmNbTvsOK3aTaIf4UEpgTT78RKto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1YAYR66Yj5hRk3NJ+Lkl2zW+l9fC84X4WcD7nW2KEuFMKv6z6gdWYc5ofC1kCQfEz
	 UI7jMna2+IjKVjd46tIgNphrRYWaWiWP8JQ68svCHB9tHTM7jk8SwoKWsdb4ILU4il
	 4uz169/vZYTkF7lLQaSoSj28KIELYyqwh7OzP5rU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	fuyuanli <fuyuanli0722@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jon Mason <jdmason@kudzu.us>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 095/227] ntb: transport: Fix uninitialized mutex
Date: Wed, 28 Jan 2026 16:22:20 +0100
Message-ID: <20260128145347.751674336@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,kudzu.us,kernel.org];
	TAGGED_FROM(0.00)[bounces-212501-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1833FA5133
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

[ Upstream commit 2ccb5e8dbcd2dedf13e0270165ac48bd79b7f673 ]

When the mutex 'link_event_lock' was introduced, it was never
initialized and it triggers kernel warnings when used with locking
debug turned on. Add initialization for the mutex.

Fixes: 3db835dd8f9a ("ntb: Add mutex to make link_event_callback executed linearly.")
Cc: fuyuanli <fuyuanli0722@gmail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/ntb_transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index eb875e3db2e3b..71d4bb25f7fdd 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1394,6 +1394,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 			goto err2;
 	}
 
+	mutex_init(&nt->link_event_lock);
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
 	INIT_WORK(&nt->link_cleanup, ntb_transport_link_cleanup_work);
 
-- 
2.51.0




