Return-Path: <stable+bounces-249460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKo1Cff3C2o3SgUAu9opvQ
	(envelope-from <stable+bounces-249460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:41:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C655777F2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 07:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB8D8300868E
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 05:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F4332628;
	Tue, 19 May 2026 05:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDxV6rcr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC3833F5B1
	for <stable@vger.kernel.org>; Tue, 19 May 2026 05:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169263; cv=none; b=MR/f0C9MaHZbXciOU7Epr8UEDpUj31+cSHRprCby3TdKUFhKXqQjcHOHFSkRoHaGtTHJaJp479mkp7nSkdz3w+XawGpsRa+9gwOf9dctg5Wz+aHPTjt6xEgxM6ruqUs7eiCdR3sV2gwLZwv3WAWtLfZmxY7muWg8xIzrn1rk9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169263; c=relaxed/simple;
	bh=OQbleJL4yAVyUvV63NOb8s6YEAQMgMl3/cmA+8Sehjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qu/WbaQnek2+k5oj/Gci9s9Ec3MTaXRLGDtOTsThwgFVskAsxQtnCMwTQkf3AQBYouK7bkCnuy6+30dqLrqZEOdrKW2fUUJDJHBVp7kNDEWqYPw73TmPXvLKHUwenNBb6qdw7wNcS+oTrJqavMk0LzuMz3o10VxbPc9+NW06CIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDxV6rcr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7c23248f3a3so26630177b3.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 22:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779169261; x=1779774061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=43pbQ5ZD2eCg2UHToz4qgl0khUcjpV2e1snhFPWHvs4=;
        b=PDxV6rcrICoBbvAeGTlqZDOAESTe4Yoq4M7SEbaw28OAs4r9ThSAeZqDX4XxoGheCT
         6lYtGlALQcT3EQpSeIGx680qCe9F326k01RKA4QB0FJvNEzqVdRHhWhz7DDZL6q8cI3w
         tK1Z80mceBrqIjH5oKFHnT6BI0CXI+P7GKUBmd+cCnd5Zznn/lCe8+eeujkDhQgJyQmf
         1DCUk6qWqHg3k7xfI+TL8c1oIEXktfZ+ya2c7wb83IrEkKqgQsozVFILsxkUoWVqlw3m
         SFCBxYjxKApP4IdSnhIQp4EXGI72j3OBikANweOjItKbMBa5Z+cVKWO8MuWsWFJYAv9w
         cehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779169261; x=1779774061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43pbQ5ZD2eCg2UHToz4qgl0khUcjpV2e1snhFPWHvs4=;
        b=MYXyQdnxRAFMcQxgetWD5zvlvX39BJUm+sZhc0wT3fUnv5E/RX2XiMdjR9qa3Z6vTW
         /nJ0T/nILstpTD7Poee/e2szJb+5l26isM2yksUbbo2tu2WkHwJ5Px29zlZ75IfHFA1z
         qlxQTeVTySeWoG9lp44Mg4hHb85ZNYQOBreHUByYV1Usx1+cL03iooDuQtWf38/8xwaf
         /Kxqt6N4J7lSyf00uRLith1oKq7GGFPP9UIms6zfzpM1eDAS/OfoV9iE31OlbFQlGHFo
         8P9DF2fAlP5S1ZNXc1g4SArmRTl55lHDq8OanihJb3tbYN4ZdXy/p7ocsPdkUO5prAZK
         3oMQ==
X-Forwarded-Encrypted: i=1; AFNElJ9t733aq5wyYbm83z+AI61ASngvVkZDnbEr1xCcB4h1LN2DcpLuEj/0RG8wHE4D7cj72tqrihI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLOFvaTGcYiNKYmafT/vUD01a+u64dmM8HQ0eEE2d9F5hXQAXU
	ayKJk6pUmqmwUZ/gFVjtxZNeZT3HXgXk/4CjHra5BLq+Rgl9XOcAhD1M
X-Gm-Gg: Acq92OEOG7CrRmEFvZMWl/cvm6zRVxeVCuRh4AdE3PWjGTy6ntLAxzN4JlhjSjNGKYk
	eoGc4ibVF00G+UT6d6KexixRQp/vLONyF/XYKdm0AVNOeagrkG9SHqC7EiNtuLPzPr4XDd5UJpi
	y5gnoSC4CW3dUDCN3LeFauT7W6oeQ2UM4PZALJdbn8UFtpcVDTR7779bgyHzorWDXKtCgpbzITd
	LqkUc4d42IN7NHBuBXiH0SjemDDhyvazz+xuurGvf0ndMbWSCPgaZdf8iyuNkLdNrSIe+IxxRFw
	xLo8ezboJeV0XHWGplfNoDe1VpvShc/DOSsTIFOfhHJPtFts3V/rYDmL5O+Dv3JL53BHDcctVBu
	9QoiwGPK2wUSnB3rv5yNWGU0USdWusPzrWYE4JMN/GILvFyNiV8cZwfVm/fb8F770DEIApD3nTX
	/VHRh/sAsmmscweAPWDtWs
X-Received: by 2002:a05:690c:885:b0:7b2:bf20:cdc3 with SMTP id 00721157ae682-7c956752091mr206361557b3.0.1779169261234;
        Mon, 18 May 2026 22:41:01 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc991c939asm32250337b3.6.2026.05.18.22.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 22:41:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	stable@vger.kernel.org,
	Lei Lu <llfamsec@gmail.com>
Subject: [PATCH v1 1/2] fuse: re-lock request before replacing page cache folio
Date: Mon, 18 May 2026 22:28:06 -0700
Message-ID: <20260519052807.1924269-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249460-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 23C655777F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

fuse_try_move_folio() unlocks the request on entry but does not
re-lock it on the success path. This means fuse_chan_abort() can end the
request and free the fuse_io_args (eg fuse_readpages_end()) while the
subsequent copy chain logic after fuse_try_move_folio() accesses the
fuse_io_args, leading to use-after-free issues.

Fix this by calling lock_request() before replace_page_cache_folio().
This ensures the request is locked on the success path which will
prevent the fuse_io_args from being freed while the later copying logic
runs, and also ensures that the ap->folios[i]->mapping is never null
since ap->folios[i] will always point to the newfolio after
replace_page_cache_folio().

Fixes: ce534fb05292 ("fuse: allow splice to move pages")
Cc: <stable@vger.kernel.org>
Reported-by: Lei Lu <llfamsec@gmail.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index be4e66ed633c..37b11b89ce1b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1158,6 +1158,10 @@ static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop
 	if (WARN_ON(folio_test_mlocked(oldfolio)))
 		goto out_fallback_unlock;
 
+	err = lock_request(cs->req);
+	if (err)
+		goto out_fallback_unlock;
+
 	replace_page_cache_folio(oldfolio, newfolio);
 
 	folio_get(newfolio);
@@ -1171,20 +1175,7 @@ static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop
 	 */
 	pipe_buf_release(cs->pipe, buf);
 
-	err = 0;
-	spin_lock(&cs->req->waitq.lock);
-	if (test_bit(FR_ABORTED, &cs->req->flags))
-		err = -ENOENT;
-	else
-		*foliop = newfolio;
-	spin_unlock(&cs->req->waitq.lock);
-
-	if (err) {
-		folio_unlock(newfolio);
-		folio_put(newfolio);
-		goto out_put_old;
-	}
-
+	*foliop = newfolio;
 	folio_unlock(oldfolio);
 	/* Drop ref for ap->pages[] array */
 	folio_put(oldfolio);
-- 
2.52.0


