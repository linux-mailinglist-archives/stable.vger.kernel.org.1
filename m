Return-Path: <stable+bounces-222930-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHbZNY0xp2kjfwAAu9opvQ
	(envelope-from <stable+bounces-222930-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:07:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDB11F5A92
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 20:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7A7B315BA35
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 19:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144C1377EA1;
	Tue,  3 Mar 2026 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pYa8kbRm"
X-Original-To: stable@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B86377ED1
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772564665; cv=none; b=ETubgO9yAPmmrhqISKpZGZLHKaXSzpETbX/Ed/SmNson9Wc22Ic0/WkyjdNKrjiTTf8nDUcDwzUhRr6PRUd/+PkQnd97PyIGQvzrubI9p50LzCjJWPwnZEzwki/AvxcIo/I6/2lB7ZL46L+/i+Ngb6Hk/4rknYoPsjkPNQakA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772564665; c=relaxed/simple;
	bh=J1T0/w77N82i3fDl6/jJNURBpbu56FG8aL1FCLge2EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VDZv9OWA+tzg+CCLS92mZl5l9hNwpBySW8/fVoX9NvXyLxBFATz+H5NUSdT+xl9BCee3s9NfyHE6mY4mceOJmzD9Bf9N7KHj003swVo+832Lg3UbVcTHgChiqScan8D0dgS6ZX9FxunmvZ/c836niqOjIDPx873bqqUd7Orju3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pYa8kbRm; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772564661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qQr9ZqAyM8io49WgQ8vaaIUK9upELLZWbIDcV54JoHg=;
	b=pYa8kbRmvIJbC712lvFNCjfQXGOOj5FABHqsC4TOPemBYI70+lEGTUToAJG7A12c9efEvo
	2O+455jx6BUk7ZFdXxQGniNsitRo1mIJIEGHmn5AQkKl5Ge7fsxwK3LApKjCvXjLuuA4Qn
	rrU4WnQZ9trUTPYBX48zYgMOxNQpV6w=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] nvme-auth: Don't log shared secret in nvme_auth_dhchap_exponential()
Date: Tue,  3 Mar 2026 20:03:48 +0100
Message-ID: <20260303190350.78705-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3CDB11F5A92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222930-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When debug logging is enabled, nvme_auth_dhchap_exponential() logs the
DHCHAP shared secret. Remove the log to avoid exposing key material.

Fixes: b61775d185a3 ("nvme-auth: Diffie-Hellman key exchange support")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/nvme/host/auth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 405e7c03b1cf..5e4df2ac3cc0 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -655,8 +655,6 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return ret;
 	}
-	dev_dbg(ctrl->device, "shared secret %*ph\n",
-		(int)chap->sess_key_len, chap->sess_key);
 	return 0;
 }
 
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


