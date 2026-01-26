Return-Path: <stable+bounces-211505-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Hq/CgXSdmmyXAEAu9opvQ
	(envelope-from <stable+bounces-211505-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:31:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B081383871
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 03:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6677D3009568
	for <lists+stable@lfdr.de>; Mon, 26 Jan 2026 02:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E752D2989B5;
	Mon, 26 Jan 2026 02:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAHZ408s"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45A1E1C02
	for <stable@vger.kernel.org>; Mon, 26 Jan 2026 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769394668; cv=none; b=DtXYBNncgAdY9fiK+ijCOckIE6WrVrD5JGHqvcIV47S5AncNkPjOBwQ+rXAKuF1OpXzSV3RcRTXmDrKe6IDwNqu90XAuYvStjxa8YsY+v9SCWyMoSiMKcYegFfJqQRrnr8UfU2c6bHbP+xS4ioOUhRWBIQ2VFUaN3y5VMqbPbuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769394668; c=relaxed/simple;
	bh=2r3QgcjH7GZMruE67ZsjvUp6p/exK5sB1NKVz9e2BfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfmDfucZPgnJyHibtS5+MbwHi96aKCNSC17e+FWEeq9nthMysxi0VoMOxe+ZpsyBjug8HKglu4DG5+SXo2DHMATkqmWi788YXL5JSN/yLkHa+Q1+mlb8XTKLHUXjVXzcGDKpgtaSLnkEE7elyHcNQt4rdi+R1BhC/UVHDj5KbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAHZ408s; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12331482b8fso1216260c88.1
        for <stable@vger.kernel.org>; Sun, 25 Jan 2026 18:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769394666; x=1769999466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0m877IielwhZYxUtpH2DsnWNPP6T5OXQthZEWEyOygI=;
        b=PAHZ408sgWRqlfTkQMqroDt+XD+0tL/RZvpJPYvVjIgKYJJ29l/xASZO6X8WVHQ3Aq
         0lEdfQQdp/ti6HvGzKgLbEFKXGSA1+s35Xw//2Lv9zu5CW1fizPPwzmVtG08GMufBOZA
         Q8T0mp5xTCpN8THVp7Ej0y+W+WRzq2CXVcUtrqbxj7v5DyAMWcOgjx63fNh7oVfsNlGM
         Y4+yWkk/jMoxbb0CDLGEAxuEPSlVRp+sJ4gqE3553l4wdESAckyHDuIlab58NVXWRoqg
         cmYKvsk4sfbklu/760JBvlpU+PWJHgV3cm2d1aVfHyiCBoiMfgfd7Lh3oQMUOfQz3OIE
         cQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769394666; x=1769999466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0m877IielwhZYxUtpH2DsnWNPP6T5OXQthZEWEyOygI=;
        b=wJRwTe95X1vPKtS19uaciEWYZxpDLH6Q6exMaOx8TYlX4Uskte/f7enY1yBuBH/yDw
         yBGRFtOR8NrxZvW90NHuPZExE4V3aNJQFJiwzVPg6zL0RmZ6uUPkhEkhugH0DhUu/NAE
         +ltsw5c+NhSdvIZDNu/A+Hq0WFXJl7eNEmpFbBismNbFE8VTZ1pKi62e6Yc+/jf6kUEX
         vz+jdlOg68ySOmuP1bTzs5x9Z83Ld7ylDkCtNfKMQW022ZTzN+HngjtI5fehv45xnP8+
         ZZxgkhPz3Dwo9U87sg8SN0d1THGBAuGgomYlwpH0XE+4z4iPjzLA5s6+ojv1ZOyNzOEu
         0mgg==
X-Forwarded-Encrypted: i=1; AJvYcCVKrzyfxzekEvsNFniekC4/e/kBJISTVyjCH455zqub5Z6MMnBr0LmBa61Fn9Fj3RfJ10iP8X0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwisByJCIqSuFC/HXu6xfX842UUzorpWy5xyPbKXJaFxivynOV9
	JwIs7tHeejn8IUQZDB12uSW8djgP1RjfOUg6ufnCQh6fdleHAc9gyxn7
X-Gm-Gg: AZuq6aIMl9WyaWR4OoKQXntme8hkMuJqjVPwYkA8MXU9l5gIZrIdk80sWSK4kIuGFY1
	FE3WYgqQBCb3xi4Qd3wWT+I9PEdDEEzMyy3mx7gwppdXklnLP8Nc9xMivO1cnEv+VusgR1cH9A9
	g5DUWX3SFNe5L1ECogTyJMPv4FN0subOiMfDfKJ3ttxApnmtspc9J9rBINMSmN/qHws+X8WEt0M
	Xu/2bpcZAvqdQkomezTp8wmDCHBQ/VXz3zwKQC+Ga6v8+Fn3oU3xM0BNAHkoSwc5USveEBs9/WI
	MuHVB7bOTZjRks0sDhEAbwCqrSbDv6cgJs/zFXKmn8ufV0AJtmN1b2NF/enkozRRUic9u9jRajU
	c2agzz0lvINtLlHtd+Mt7ITnFX017OzWFnbSSYa5gfLElorOBhwhNddMHQ7cKMxRyMphGPNoH9a
	oP3hj6uiCRaEyDvXxGzgr1ecoyinIUlyJG34hAmrsOzaAYavKYxHIk
X-Received: by 2002:a05:7022:6183:b0:123:3356:7abb with SMTP id a92af1059eb24-1248ec87252mr1826327c88.46.1769394666463;
        Sun, 25 Jan 2026 18:31:06 -0800 (PST)
Received: from luna.turtle.lan (static-23-234-93-211.cust.tzulo.com. [23.234.93.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d91c52bsm17212277c88.6.2026.01.25.18.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jan 2026 18:31:06 -0800 (PST)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Milind Changire <mchangir@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/4] ceph: do not propagate page array emplacement errors as batch errors
Date: Sun, 25 Jan 2026 18:30:52 -0800
Message-ID: <20260126023055.405401-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126023055.405401-1-CFSworks@gmail.com>
References: <20260126023055.405401-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ibm.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211505-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[redhat.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B081383871
X-Rspamd-Action: no action

When fscrypt is enabled, move_dirty_folio_in_page_array() may fail
because it needs to allocate bounce buffers to store the encrypted
versions of each folio. Each folio beyond the first allocates its bounce
buffer with GFP_NOWAIT. Failures are common (and expected) under this
allocation mode; they should flush (not abort) the batch.

However, ceph_process_folio_batch() uses the same `rc` variable for its
own return code and for capturing the return codes of its routine calls;
failing to reset `rc` back to 0 results in the error being propagated
out to the main writeback loop, which cannot actually tolerate any
errors here: once `ceph_wbc.pages` is allocated, it must be passed to
ceph_submit_write() to be freed. If it survives until the next iteration
(e.g. due to the goto being followed), ceph_allocate_page_array()'s
BUG_ON() will oops the worker.

Note that this failure mode is currently masked due to another bug
(addressed next in this series) that prevents multiple encrypted folios
from being selected for the same write.

For now, just reset `rc` when redirtying the folio to prevent errors in
move_dirty_folio_in_page_array() from propagating. Note that
move_dirty_folio_in_page_array() is careful never to return errors on
the first folio, so there is no need to check for that. After this
change, ceph_process_folio_batch() no longer returns errors; its only
remaining failure indicator is `locked_pages == 0`, which the caller
already handles correctly.

Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 63b75d214210..3462df35d245 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1369,6 +1369,7 @@ int ceph_process_folio_batch(struct address_space *mapping,
 		rc = move_dirty_folio_in_page_array(mapping, wbc, ceph_wbc,
 				folio);
 		if (rc) {
+			rc = 0;
 			folio_redirty_for_writepage(wbc, folio);
 			folio_unlock(folio);
 			break;
-- 
2.52.0


