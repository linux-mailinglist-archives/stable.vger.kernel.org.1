Return-Path: <stable+bounces-98850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AAC9E5A39
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 16:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F369616191F
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 15:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965321D589;
	Thu,  5 Dec 2024 15:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="KXNBQZTA"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09B421C16B
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413798; cv=none; b=OI+HkZlxXSzsCGIKNn+4dQom1mO5SmbrcY+83biLFp3zugqB0QnbJsAmJZD8+diE8wzPGA97GiZaX4TU+mwnNwdSzjHl+vMpeu1dOfFH072e6SvNGggIqDXB9JC9SLxMRn+nJrqa3OPOKowY3yYFsap2miqAqZwvy/wx0NywoK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413798; c=relaxed/simple;
	bh=QJh0SocakRQFAItV+WIZs0QtfPK9Gb+2/saeLJIXm0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTEtrkGOH1QerOCH0GoleZtL9jJn+4MGXhj1ErAAqsQ/pk6NtFwyh1eIq9tpw4eOHClNFYQkPEUouEafD6BShzJqmjCIA5AjkxCcvm5HNtnTEVpDeZt6P5B2h1wx/0CQtabsIZWZ8cLp7Ver7YjLQOAHwjDwoozPomh3TwfukyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=KXNBQZTA; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5ced377447bso1684417a12.1
        for <stable@vger.kernel.org>; Thu, 05 Dec 2024 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733413793; x=1734018593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwnaybcL2baNYeNlHgBi1xq+W7PQq1z/cLM7e155nn4=;
        b=KXNBQZTAR8I08avEHQdxB7EMte+ZfpmY/g+DZQoQFq+XmRCrsIAvTHksMXhDjsAB4H
         IloJ/Askvfysn9nr7sGRLr9Ci8zx9Ca/EWl21OLvmIOhujfDkPNjD0jlIaUUfYdkRFyq
         3d4lOH7sqVuQZMcVzoZkirLl0rGX+tN3IP+rRFxejOOvBhLI2JrdLhadToW4WoVQvYUc
         N5luOfQBg6joQMghHQPKjW/0HbYsQPNkmjQHjAnGhry5UUDbhGy6KVJ0aIUCEZvLet3a
         GTkY41kx/NbLnuFIQUufuvom3b49BSbGir0FUUEsR8IPFajy+50BzdZwaOHUaX+QHbPk
         aw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413793; x=1734018593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwnaybcL2baNYeNlHgBi1xq+W7PQq1z/cLM7e155nn4=;
        b=Y8+2R0EU5QfV/iKdO3G9RLX9lmBzk426TV5sGocQ50nnWBbZQlaBBw11MTwZhHaQPD
         3y0C0FhZhYNzVgQW/fac2KFQ9iG/ctDg4f/wEX2lP/RSv6rWyxzyaJoBk+rRhY58NPUK
         uUhASxAuLPgq4zy1dXM14hAph2UPdZGIhCByBZRX5bKD8sNo9ZvfpBgvonZfgSnacyku
         l1TaFpHyL3+c382xkGpfi/Cpi0QqnScdoUkwxSzGwEyRiNsNXKvvmXMJvSUyfUB70SeC
         yOqIn0SO/Dl8Mem070JXT6CGb1i5K3CgJDjnzOGcC6SALrujIzWEnun6OY9/ie8pmjzu
         bKzA==
X-Gm-Message-State: AOJu0Yy9RxPH3DDjTVT+pLgOAEIGuFxB+EzxdSrUzitzpcMjeNXUpuuU
	hS2ocuGBXNcJh/ZEDcXuSM6FiphNS/bQyyz93wtGA3YlmEpaaFBdweX4n08tcBs=
X-Gm-Gg: ASbGncvuWJDbq9p4toRPcLyaM/v8h3HBlg6Aamkf46qI0Emt2cf+3pYrnciT/etMF/J
	42YlFnb82paH8JlzdWl3QRwjwlcRMJMTiF8wfNOoKkNFKYF95haaOtwTc0ZGJnPFn39Hu7CbsOb
	zereJp1+c7CQaiL7CyDdyKDfg92RsSakQK1fQOG/dyJ4XGuiNSwvU71mOtxA8DjIZJtqydwTx1g
	s3icNTQSjm+lB5pIjmT3FtaMY96xRZ/PFnY/GHOar2JsmMJLq0nOAE+Hkf0XU0FUQyMVlgzCLkt
	d2gg6cd0PkfW4zE7PWMwK8LamHuqLf9lYMVFX3W8Cunaphv6EA==
X-Google-Smtp-Source: AGHT+IE2OSa7ZjCjHWl3RYhlRyZyKlZnSLP+x1YzEi8/mKnAl0lFCce0mHxT24btJrTigdztogh09Q==
X-Received: by 2002:a17:907:9713:b0:aa5:c9f4:7bb9 with SMTP id a640c23a62f3a-aa60182367dmr1087692866b.35.1733413793311;
        Thu, 05 Dec 2024 07:49:53 -0800 (PST)
Received: from raven.intern.cm-ag (p200300dc6f2c8700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f2c:8700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e58dffsm107575866b.13.2024.12.05.07.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:49:53 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: amarkuze@redhat.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
	Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2] fs/ceph/file: fix memory leaks in __ceph_sync_read()
Date: Thu,  5 Dec 2024 16:49:51 +0100
Message-ID: <20241205154951.4163232-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <CAOi1vP8PRbO3853M-MgMZfPOR+9TS1CrW5AGVP0s06u_=Xq3bg@mail.gmail.com>
References: <CAOi1vP8PRbO3853M-MgMZfPOR+9TS1CrW5AGVP0s06u_=Xq3bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In two `break` statements, the call to ceph_release_page_vector() was
missing, leaking the allocation from ceph_alloc_page_vector().

Instead of adding the missing ceph_release_page_vector() calls, the
Ceph maintainers preferred to transfer page ownership to the
`ceph_osd_request` by passing `own_pages=true` to
osd_req_op_extent_osd_data_pages().  This requires postponing the
ceph_osdc_put_request() call until after the block that accesses the
`pages`.

Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 4b8d59ebda00..ce342a5d4b8b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1127,7 +1127,7 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 
 		osd_req_op_extent_osd_data_pages(req, 0, pages, read_len,
 						 offset_in_page(read_off),
-						 false, false);
+						 false, true);
 
 		op = &req->r_ops[0];
 		if (sparse) {
@@ -1186,8 +1186,6 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 			ret = min_t(ssize_t, fret, len);
 		}
 
-		ceph_osdc_put_request(req);
-
 		/* Short read but not EOF? Zero out the remainder. */
 		if (ret >= 0 && ret < len && (off + ret < i_size)) {
 			int zlen = min(len - ret, i_size - off - ret);
@@ -1221,7 +1219,8 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 				break;
 			}
 		}
-		ceph_release_page_vector(pages, num_pages);
+
+		ceph_osdc_put_request(req);
 
 		if (ret < 0) {
 			if (ret == -EBLOCKLISTED)
-- 
2.45.2


