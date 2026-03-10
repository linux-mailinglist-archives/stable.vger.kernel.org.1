Return-Path: <stable+bounces-224018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MlaOCT+r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:19:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B41F24A5DC
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB8A93085A6E
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9E236EA89;
	Tue, 10 Mar 2026 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDDFO2ct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83722BF3E2;
	Tue, 10 Mar 2026 11:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141150; cv=none; b=L5+4vWBtjfGkRbJB6fUJoKkG57drSHWqu6l0MgvzgaAbEdS6tEllx/jIf2/RDTYFHKPxWBL7Ym/Fj07t8+vcPW5e12j8DOzxk0lE69mbJC8JN3wGVjK70vlZWSctlfAgERqfS0hzFbHHCLiggndUILrZUV8hwkZETNoKyggoFbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141150; c=relaxed/simple;
	bh=ZDXwzOlmMuGWr2psv5sKf6OmzobVpBYWZQIIdIvMzTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igcj2YkjZyKtEJZU/bMaFSCzgvD37HmNlLmRoYChaFTfNRrKfri3O6TmUeTnqr49AuBcAaJWmRh9catTkOZrLDHnzdiNKHSEDvRgWxvTuLtyllN6vqA7c+Schizy5VIDb5pK9eTRM5K8NrMxSIFMw92x+yN1/YI+q+3SGn8dMwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDDFO2ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A653C2BC9E;
	Tue, 10 Mar 2026 11:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141150;
	bh=ZDXwzOlmMuGWr2psv5sKf6OmzobVpBYWZQIIdIvMzTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LDDFO2ct3K+FNRyKfya7mHnz9hDrJFTltDgDaznV8j4a4O0H9+TXhggQZyJh0ctMl
	 TXGP2zOBKZ3ypFI0N06wrpPRdfISGdpBaFpTJVlVhe7+q1kr+G5UfrD5dEinoywOso
	 LFrqfgIxXDcgrBvPphfwi08b2ISokvPD/q6IDZa1YyXrC3fEFJvhz1he4fj0SOnY3w
	 nj5poGdz1mAb1gEZXqpl5VMCZF/LmsvYkp8QnzkRFbHjYP9gh+JF39FlMZOFfC7BSv
	 ItOmTSk2FI7Uri7GZtawMO/aFIu5vmzjEWGkD3sz7RtyGhOxYRJ29zA4Jon4VeIDCt
	 y29pilpuh1kpg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Tuo Li <islituo@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.19 153/311] drbd: fix null-pointer dereference on local read error
Date: Tue, 10 Mar 2026 07:03:20 -0400
Message-ID: <c122b2486eeed840b6be5c5f155816d3befd12ab.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B41F24A5DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linbit.com,gmail.com,kernel.dk,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-224018-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,kernel.dk:email]
X-Rspamd-Action: no action

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
 drivers/block/drbd/drbd_req.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index d15826f6ee81d..70f75ef079457 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -621,7 +621,8 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		break;
 
 	case READ_COMPLETED_WITH_ERROR:
-		drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
+		drbd_set_out_of_sync(first_peer_device(device),
+				req->i.sector, req->i.size);
 		drbd_report_io_error(device, req);
 		__drbd_chk_io_error(device, DRBD_READ_ERROR);
 		fallthrough;
-- 
2.51.0


