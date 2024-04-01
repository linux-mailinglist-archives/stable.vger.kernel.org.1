Return-Path: <stable+bounces-35470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74A894482
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 19:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B251D1F222AE
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAA64D9F0;
	Mon,  1 Apr 2024 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="usjril7F"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3E24D5A0
	for <stable@vger.kernel.org>; Mon,  1 Apr 2024 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993993; cv=none; b=iQTFeIZGM+fKHWYxUvWFjz4KXD+8gY65Ii3PHOYDZNBIc0kuk7/qneQUrpbMevG9sqN1oqZ6QpoR8MkxR8dG3Hz1tB23F8PFGmCzBUawn9jr+Oe8LJQJ5ZUvF7ynbMxlCId8HEAhN5nBK8xjAcHcbPn5EskAf5kKUbLYQWjuya0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993993; c=relaxed/simple;
	bh=QMcG4jx1tBIDBQBqjiX5YjBseHoAec8UDDjX9cHOu+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sS+AF31Dvg4H3jbxe5BCPteQzeMZiiA1HMzcg8QNiVYX7xPy289SGuw+ep/EBgR+Aw3c0DDi+MHITH0IJIHdZEcq1j5rSI6v22G7iTT/xtGJHyhfarIxlJVeRfgyeBVzrLKecPPQy8pkQz49CLtV3A6AHAYxWItxCUM9ytFANI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=usjril7F; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso85890739f.0
        for <stable@vger.kernel.org>; Mon, 01 Apr 2024 10:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711993990; x=1712598790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1LVcHg6RD6pOvGDHs5bk1+ZbPdnQyvBrliIb9jmOn4=;
        b=usjril7FFA2Vlj+bcHuufGxCsiimIVohh/UPmoTWCWW8GGRKbEmNdHDscoPG7QL9XP
         BghVasoK9Dv/xcB2SiICX0inxgbTvZdfxB+6v754V43654iFgMtMCTUERpkiOADzuE/P
         HbN7HAyoDyUovds1RoW77QRad30rW7vbSW0oI7wtDRzEFqN3XGvbhNKhpWZoxe6zyPJa
         rx27+1/2Hpycfdlp/XddM6SwJPHTM5m4FNo9h6V2pcPxBUTnxkYNwlYFktpWilcU+TKs
         X+mZ3X/KHjH9/YRtEpQ8u2ttCnHJahC+HYItqYCtb0tywevJBrYriVQm0euqMAEQfs9b
         lAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711993990; x=1712598790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1LVcHg6RD6pOvGDHs5bk1+ZbPdnQyvBrliIb9jmOn4=;
        b=i8NhyOpBwJRuSQwBdZOQcks0dnHqarUe7ahHhf92b35kDmmh6bey95MZBSzh0D06yq
         X+3lvIqmGhYofIsInLYf7ayPaJmHHR2dZQOg4yAYnxQeh8FGyti1KzjLWF+DURg2jCYs
         uAxzjz5ELbgXt6Eytanets/ZdT9tiNDG25mYX8Cvh4tcPuwGEDIx2lsCey9aPDguqudc
         bRPFlTrtvtF2juWc6e+ONueQiMvflIQcj1z1NGDnlTB6YXZlqXPdptxjZDx7tGcFmy6O
         j1SRytmwVHaEdwMi/r9I6fxPpIGPrT9Zww6oNUvRyKOj7VS3BK5OwKSyB5G5zLr4r/mX
         Tylg==
X-Forwarded-Encrypted: i=1; AJvYcCWse4GErehtFBHyKENLW9+9VBJtQZzbfJoeRkcJFHCB7oSkhNifYtzkIcBH1KBF3yZF62ZT9iDzJkUeEOMuwlygavc5SLpE
X-Gm-Message-State: AOJu0YycHRiAxPfK/W7VNF7LCCG06RLIh3zphywGQQBssBmbjnEgzxLD
	La1u+MP0xERL6X+NGjgN9NF38U9XjgcwyFwemgYm6+hkVQkBteFxkEtFUkTFPrVHP50wG2tSYFE
	y
X-Google-Smtp-Source: AGHT+IFdi5QSuH9n05fGrgfGEbwql/F+8F+UVYT6gjOh/L3/sEdcGMV+OGZD6GOm2/y6Y+StSk2jYA==
X-Received: by 2002:a05:6e02:221a:b0:368:b52b:b449 with SMTP id j26-20020a056e02221a00b00368b52bb449mr13044392ilf.0.1711993990480;
        Mon, 01 Apr 2024 10:53:10 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id gm14-20020a0566382b8e00b004773d7a010dsm2663829jab.76.2024.04.01.10.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:53:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] io_uring/rw: don't allow multishot reads without NOWAIT support
Date: Mon,  1 Apr 2024 11:49:15 -0600
Message-ID: <20240401175306.1051122-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240401175306.1051122-1-axboe@kernel.dk>
References: <20240401175306.1051122-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supporting multishot reads requires support for NOWAIT, as the
alternative would be always having io-wq execute the work item whenever
the poll readiness triggered. Any fast file type will have NOWAIT
support (eg it understands both O_NONBLOCK and IOCB_NOWAIT). If the
given file type does not, then simply resort to single shot execution.

Cc: stable@vger.kernel.org
Fixes: fc68fcda04910 ("io_uring/rw: add support for IORING_OP_READ_MULTISHOT")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/rw.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index 0585ebcc9773..c8d48287439e 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -936,6 +936,13 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 
 	ret = __io_read(req, issue_flags);
 
+	/*
+	 * If the file doesn't support proper NOWAIT, then disable multishot
+	 * and stay in single shot mode.
+	 */
+	if (!io_file_supports_nowait(req))
+		req->flags &= ~REQ_F_APOLL_MULTISHOT;
+
 	/*
 	 * If we get -EAGAIN, recycle our buffer and just let normal poll
 	 * handling arm it.
@@ -955,7 +962,7 @@ int io_read_mshot(struct io_kiocb *req, unsigned int issue_flags)
 	/*
 	 * Any successful return value will keep the multishot read armed.
 	 */
-	if (ret > 0) {
+	if (ret > 0 && req->flags & REQ_F_APOLL_MULTISHOT) {
 		/*
 		 * Put our buffer and post a CQE. If we fail to post a CQE, then
 		 * jump to the termination path. This request is then done.
-- 
2.43.0


