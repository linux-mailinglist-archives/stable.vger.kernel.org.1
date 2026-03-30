Return-Path: <stable+bounces-231158-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H46JzBYymn27gUAu9opvQ
	(envelope-from <stable+bounces-231158-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:02:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 433C0359DB1
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 13:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 473B730B444D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317433C2773;
	Mon, 30 Mar 2026 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KWLNfZyT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6913C2768
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868161; cv=none; b=F7bHNr+9B4XdUsJ3R3c92mLJnzBeeJ6KaqBK9VnFdGnsCPj3IeWbnWSQQrKXyivc0xixXlruk8nEYUP+W4Dj+CRPEw8Nhlc2/OQqjkD7+o2MUMHQ4nol4wjlQ0kc/VI6A3/rV25SdmUlojyXl1cX8NjUvOUca4Q25Hb/Y+/Bfcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868161; c=relaxed/simple;
	bh=ztpxb9hQu5tkAcfN8a3ttcSKgHCqdHEOgG+ht9Crucs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=syPjoQJ1r7WsCQriapRV6/h1WVgxUK36LiwjaeN2D2Zd/svgqamnJXyRW9cAG0uxfWCzgRiB9YfH8OhgkbR4TX723Hvpgij9WUgSNtJO3QifljUSrNteR07nc/RtXdISwZb0mzb8G0zFSAeojtpcI40Zag2Z5mWCBPjPDC28bZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KWLNfZyT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf906b007so738441f8f.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1774868156; x=1775472956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RqgOUnrTeGkoKfySHKsNvdoK2i879eNBFvf4HV8oBRY=;
        b=KWLNfZyTUDew5pKHGEzu5wIh8obf9BqzptRNC3vIFgpX3OGXUGiEEKsVgsQVNq0bWq
         ecgW4Y8M03OHJ91GnxGf0Mrp/dVNNioYYp1O4NW7URegBp0Jj0cMgcYVqDMBL33Zgfs5
         MJ+Lcwnq5+f7V+ui6zg+u62bqhsgJ2RJNNIebiTHBsSeEEZ309V7YzaMjEbJiLU7qkne
         fO/99ktPPRcJkKp8M8XHjDWqApGCdxFfY3sa6oN4RCf977JN+XdZrdqKDG58xp3jVHZE
         y/Su+JlXEehLWODdC5h6kO/jteqKofiihGyztQ86NY55YWNZHugoMeo26AOxbVALqHzX
         FQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868156; x=1775472956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqgOUnrTeGkoKfySHKsNvdoK2i879eNBFvf4HV8oBRY=;
        b=K+YBOdHJf/jL+lmqhGwHHnYg0jHxD9mPpnvLsJGv7+SFIjRKobqrwpXmLP0y1RFTy1
         p+womZvCgSl36qe2CIJFEf8NcPz+wLIIAXnF9xvM4oCIiqyz4zEcC2xj0buBf0bdbMkZ
         SWoqAZEuBwLRTmomayq0u66dexqe8bwf9jP2Jw/LRMyPlXk+0rYFQRyFGK0hLO8D5jJ8
         1XkJZH86tD/V3Hp6Mh/eEUbU12RBR16qGfXfewfVY3qQHyRXMtY3Fpk30/uufUxg2JPV
         4mvtk5oEeI/y1WZfnsNaxWQ+Vu0H7a6KFb1iHrDbIhIhxs6aP+yoRgmSuEnkFjqmZDqZ
         zwrw==
X-Forwarded-Encrypted: i=1; AJvYcCUklaRhrwEG+KngyUL8kCCLFR73WMZByKNoMsNkDHSjBTy9ykY+vZ5zVmFZz7mxTk9KEmpbP6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJf58neBWkntQXpDVkThY/4h4pZLbrTmFGNr4l6W0zpUcI7vMA
	0+BOy0Ppy7Sjljhpjoo4Rk4ScrFU+U9rNGZJc85ik181XppHoXfZqBxRCHkwHY97JHs=
X-Gm-Gg: ATEYQzxLHnVajwKOVE+tA7BSycnG72M6KDkpVXqJhQE3kIotZJXBcIDLc1s/dks9F/g
	rByZSe4rj5WDUckPY365xbvfMssJa0WR5KH46DujYvZXS5BUTmVxsxkbNy7bzjQUV4ODTR8JayE
	Q/xSIO89IPWBVKbbfLXBSynxORoSenoggLmD9Dl08wPCP0KnJKupiDxa0+p5g6dcCSG/3DvYjNS
	Cj9t08lS3Dp2TMpdZBWGhiOuyZEhTd3UnadbsUEsl09Q6MZvYoUD8w50HYOZRppBy0NtJlwZ+o7
	0ikBhO1s5Ym3auv81WDwr8PcpgmOY8GFC+PmYfIUcqlvwqu4gUcSRVvT6VukXn3fjN3/Ylmpav/
	SB+XPeoPD//gbk4Sfm0OPnIyZj8DHjdR1hA1+IGLB0+qtMgjofRVw3zybGiVvG1AvjjdmnDGkQK
	rc+znH2v56Nrs86f3YrkSwkZoWACD/29yzksE1uyBHBJB99DPfGzXOsxX75RaZ2cL7bgf0YnjzO
	PW2IG/DH+KH85iv54GSD2iO5I9O6HdTQAeMaA==
X-Received: by 2002:a5d:5308:0:b0:43c:ef4f:79de with SMTP id ffacd0b85a97d-43cef4f7b6amr11247379f8f.16.1774868156221;
        Mon, 30 Mar 2026 03:55:56 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f2b4400023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2b:4400:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf330872asm16371655f8f.17.2026.03.30.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 03:55:55 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: dhowells@redhat.com,
	pc@manguebit.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] netfs: add missing folio_end_private_2() to netfs_pgpriv2_copy_folio()
Date: Mon, 30 Mar 2026 12:55:48 +0200
Message-ID: <20260330105548.1371339-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ionos.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ionos.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ionos.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231158-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[max.kellermann@ionos.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 433C0359DB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This deprecated PG_private_2 copy-to-cache path can leak folio private
state on rolling-buffer allocation failure.

netfs_pgpriv2_copy_to_cache() sets PG_private_2 first, then
netfs_pgpriv2_copy_folio() tries to append the folio to the tracking
buffer.  If that append fails, it just returns without calling
folio_end_private_2().  The folio is then no longer tracked for copy
completion, but later invalidate/release paths still block on that bit
in netfs_invalidate_folio() and netfs_release_folio(), so the folio
can become permanently stuck/unreclaimable.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/netfs/read_pgpriv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/netfs/read_pgpriv2.c b/fs/netfs/read_pgpriv2.c
index a1489aa29f78..ab73fa62378b 100644
--- a/fs/netfs/read_pgpriv2.c
+++ b/fs/netfs/read_pgpriv2.c
@@ -55,6 +55,7 @@ static void netfs_pgpriv2_copy_folio(struct netfs_io_request *creq, struct folio
 	/* Attach the folio to the rolling buffer. */
 	if (rolling_buffer_append(&creq->buffer, folio, 0) < 0) {
 		clear_bit(NETFS_RREQ_FOLIO_COPY_TO_CACHE, &creq->flags);
+		folio_end_private_2(folio);
 		return;
 	}
 
-- 
2.47.3


