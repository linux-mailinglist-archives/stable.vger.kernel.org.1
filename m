Return-Path: <stable+bounces-229026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE5tEJlcwWlZSgQAu9opvQ
	(envelope-from <stable+bounces-229026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:30:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B092F6628
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8886303C2EA
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F477387599;
	Mon, 23 Mar 2026 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oVpkLwXe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6B2737EB;
	Mon, 23 Mar 2026 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277822; cv=none; b=OKdmso90zmOrMYLRWhXPRSnWl+Jg/VTqFjrD3APHYeqr04NXM3qecbzR2Dfx2JaPxrem5pkiWgAbCeB+Ffg+tfhypJpMVAbORrycRc9UbUNts2QAVKdgcDtGIa5F7qyLX+5TwrfJWP8jt8bR5d7A5sLwkobPZKEYuBgMvn3/v78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277822; c=relaxed/simple;
	bh=Ye33hfUDuVZmNddd8+YaKyzyl4/NbuuvGiALuqke80E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQhXjzgRFos3nVt+z7LRaWjIOO+UQoYlyueNY4kvNbEQMLt2iKfuU1ijB+4rKYA/Kvz7+o1zPqhMzU2DWVZdvpaqZliguzO1y7WCBVh9qhFVFZcTNXY8iVvpuEog0/aNry4+QzwUxYp0pq9IQKLrofq0z2HAAcxwwGvtA4vIass=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oVpkLwXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECF9C4CEF7;
	Mon, 23 Mar 2026 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774277822;
	bh=Ye33hfUDuVZmNddd8+YaKyzyl4/NbuuvGiALuqke80E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVpkLwXe/JBq9Lfra2wU16AJQgZtWFypptsfmbwb3Mp2LBC8JSrQ4kNLqXQio9OeK
	 FNrHRdVDGxQCuCwClhp/cYyzE3hTYS4wmfMdX0kGL64Sb1vG8noKRNqHncxKsU2jQJ
	 Wk8La3t+s74x4uAuAOxUQXbZnCrXA2A6GVOUKFF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tuo Li <islituo@gmail.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.6 114/567] drbd: fix null-pointer dereference on local read error
Date: Mon, 23 Mar 2026 14:40:34 +0100
Message-ID: <20260323134536.633574082@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229026-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linbit.com,kernel.dk];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 22B092F6628
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

commit 0d195d3b205ca90db30d70d09d7bb6909aac178f upstream.

In drbd_request_endio(), READ_COMPLETED_WITH_ERROR is passed to
__req_mod() with a NULL peer_device:

  __req_mod(req, what, NULL, &m);

The READ_COMPLETED_WITH_ERROR handler then unconditionally passes this
NULL peer_device to drbd_set_out_of_sync(), which dereferences it,
causing a null-pointer dereference.

Fix this by obtaining the peer_device via first_peer_device(device),
matching how drbd_req_destroy() handles the same situation.

Cc: stable@vger.kernel.org
Reported-by: Tuo Li <islituo@gmail.com>
Link: https://lore.kernel.org/linux-block/20260104165355.151864-1-islituo@gmail.com
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/drbd/drbd_req.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -621,7 +621,8 @@ int __req_mod(struct drbd_request *req,
 		break;
 
 	case READ_COMPLETED_WITH_ERROR:
-		drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
+		drbd_set_out_of_sync(first_peer_device(device),
+				req->i.sector, req->i.size);
 		drbd_report_io_error(device, req);
 		__drbd_chk_io_error(device, DRBD_READ_ERROR);
 		fallthrough;



