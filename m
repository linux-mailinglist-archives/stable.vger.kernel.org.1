Return-Path: <stable+bounces-206219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C2FD00180
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 22:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3634630B42BA
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC502DC337;
	Wed,  7 Jan 2026 21:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J53VGxvM"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826C2D73A8
	for <stable@vger.kernel.org>; Wed,  7 Jan 2026 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767819736; cv=none; b=KrofHC9Vt/B2sIuWFY48DUO6vFAX1B6YotVeg9wV6uTeSic4XdeFL+RrB7Z0pMv6+dF2UXFMyWpmHiifGCKVcp+RWET1kdvJEdW/xSWXSRaVGEvHEBQ4dS+x8US7qnELbNafBA1yTuMCNPWrpjP8jShWpOnL8o2U9A1iNPh9i6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767819736; c=relaxed/simple;
	bh=OToRqjvmUYJ/hQ/uywMC5tHsYvK3gXP3yNUZuoCsk/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N50pf0P10t5953hSpHRbw1iPAUEcNEFYDVUJ6INs3AGBn5xwuXyBtxLlXOqFE8TIKYYPqBByWVnahUbAWf5KzZQ/s0ymMn+i6yJoXzD78o5QGXoh4gYFc5SstPShNebJ1FaQorZZwTjUxXKK9Zr0XQUbPsVnUW5Malas/xxHaz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J53VGxvM; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b05fe2bf14so2530481eec.1
        for <stable@vger.kernel.org>; Wed, 07 Jan 2026 13:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767819732; x=1768424532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StC5RRMJpz+kQrLWAhYbYP3HFYIHTdt3vEQL2gvPaOI=;
        b=J53VGxvMIZxqirtQX3wYHg+/odvWOpaJHAskxJ3YBshcYnKwwF3R4WbljGmaRUg+Qs
         /xM/QUDAH2e4UOswRlUSenqeRQHu9du25kCP8hgxpxODXi+BCkpSLQ6SqFg425Uc3h/h
         FvT75zjj1BcV2WJ0n3YOWALK11q/QXQXdrkarHvM9KjaW+OmVv4BSNpY3JzubrEcPwbc
         myhm6x5d3G3GaVDNxgHulCWD37Uh0mcDQFfjgC47Giq4JtqmVCyNjFKHe4zio9wqD/lm
         TS3qlJpzAhkku6vYjEHjy3j9CKPkdJ0Bo0iu34g73a5cVVd1STbIUpHtOub7fNjfbiEo
         VeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767819732; x=1768424532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=StC5RRMJpz+kQrLWAhYbYP3HFYIHTdt3vEQL2gvPaOI=;
        b=IL7spTCu0CRexWeb4LFoa00S2mhs9M6F8CDqTUn/zfZ/Nmrgcq+ljIC6wMEsVBSvCi
         diu0em6WN0XQwthUg2Ja7vH4+ybWibuPTgX9utDd8H4T01DstVBClcwq4PZPQ/IXDPGu
         o/Ern1qg3RdHs1jiiJhscHMFnka8MAmwzpu0UZnCo68a1/hKUltjLuZ5zETW/hD96Ivr
         GqHc0JYA4cBMlcsMJA6OryNkQ8jw5wbYOqndyvAbZ18TDUs7bPrecCderjwV9Sej3ife
         gbesbUhi9WxEPIlnlNm4VlG/JMXSuItorvM61we358M46GfS08ly/TU9+OQfnrviYQ01
         3JzA==
X-Forwarded-Encrypted: i=1; AJvYcCXr8y965t+bi9hSOag+zhoOuBBFLzuEpbjJ2XG7nP3sWsZtbkagx2Xu0aw1Zj7h77K9tPJFiYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTX3dB0yeK47dxIZYxn1t6THWCGK5DD9eMaTNJte+uYkWCnwt8
	Mxdw6OISPDhCYoPZ8TRPqX7hNGrsAww+RuTP+BuhwsSrvzYeEnuEnx9Revcdmg==
X-Gm-Gg: AY/fxX5Ju4oESVcgw4HGzRRvFMXrVK8qVeqk7nH7g/EajJUieAG0ltqzPUe3dNx6HNs
	r820vHsnUejmeRSXToM+8/+3Mpb6Y2SvAFo4xi7vo0ROQsQbMSyNmlfc9Xt3qE+wXSmXCcwZh2X
	seH3U2OoAW3Ow4fO6Y7n1rJb73kUaavfUdrGb3Abny5wDFDl3PaQgO4Bia+BuwV82brwJKQB1m3
	9TzUMlEz223q400N0cL2tgrdmN+Dw7vgl/5C8+Eco3eW25vnTSKwKENv17OibNBuG8I10RdpJtj
	XIq+Aej+Vh8cI1E+nT1HBLE6cH9l26n2oJAO5dLZpvzM6pMx9bh18cfD1ogX/aBRwyAOvi4AWuo
	y68PBD0VGZk8s94tAszXhHT4dCbCcWsot8+fBFkQCeXXjri5B0eI6gJ3cWPRPtBvj3wv9gi+eTS
	kZAb0sXedJfZYMQfTVP6S3WvwogxeTFSOpYB3qpD5XUXHsNVzJ2B2Va/sVtcfX
X-Google-Smtp-Source: AGHT+IHsusTxGdP1PS4z/IoCh9itAIP1JdP4x5wJw6BXtiBXvisAnQNe01ae9GbbYPWzAyzvMWqFZw==
X-Received: by 2002:a05:7301:e2b:b0:2ae:5ffa:8daa with SMTP id 5a478bee46e88-2b17d200bc3mr2817972eec.5.1767819731857;
        Wed, 07 Jan 2026 13:02:11 -0800 (PST)
Received: from celestia.turtle.lan (static-23-234-115-121.cust.tzulo.com. [23.234.115.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673b2esm7730320eec.6.2026.01.07.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 13:02:11 -0800 (PST)
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
Subject: [PATCH v2 3/6] ceph: Free page array when ceph_submit_write fails
Date: Wed,  7 Jan 2026 13:01:36 -0800
Message-ID: <20260107210139.40554-4-CFSworks@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107210139.40554-1-CFSworks@gmail.com>
References: <20260107210139.40554-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If `locked_pages` is zero, the page array must not be allocated:
ceph_process_folio_batch() uses `locked_pages` to decide when to
allocate `pages`, and redundant allocations trigger
ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
writeback stall) or even a kernel panic. Consequently, the main loop in
ceph_writepages_start() assumes that the lifetime of `pages` is confined
to a single iteration.

The ceph_submit_write() function claims ownership of the page array on
success. But failures only redirty/unlock the pages and fail to free the
array, making the failure case in ceph_submit_write() fatal.

Free the page array (and reset locked_pages) in ceph_submit_write()'s
error-handling 'if' block so that the caller's invariant (that the array
does not outlive the iteration) is maintained unconditionally, making
failures in ceph_submit_write() recoverable as originally intended.

Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
Cc: stable@vger.kernel.org
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 fs/ceph/addr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 2b722916fb9b..467aa7242b49 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1466,6 +1466,14 @@ int ceph_submit_write(struct address_space *mapping,
 			unlock_page(page);
 		}
 
+		if (ceph_wbc->from_pool) {
+			mempool_free(ceph_wbc->pages, ceph_wb_pagevec_pool);
+			ceph_wbc->from_pool = false;
+		} else
+			kfree(ceph_wbc->pages);
+		ceph_wbc->pages = NULL;
+		ceph_wbc->locked_pages = 0;
+
 		ceph_osdc_put_request(req);
 		return -EIO;
 	}
-- 
2.51.2


