Return-Path: <stable+bounces-204939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FF5CF5A42
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 22:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E89073020801
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 21:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26342DEA78;
	Mon,  5 Jan 2026 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXXPMzF8"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402B32DCC01
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 21:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647940; cv=none; b=TsSz4JRpuGiYFZbQHUz21jAjrostS3nNiMcQbHxGYijNkQin5ZboUVbnXWmNSyKtgFNd3cjj/qkWSKSvh3egMsBTo7IGqEE0S2/uN8scY9t4ZidWIJlxCm5IzyWRBkltCnQm9ucjq39gvFVrjFE474f06JsH0d1uy7hy6xjrUto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647940; c=relaxed/simple;
	bh=DVCupxP+x6/SB5NirDNkQjozPe2gCHPoUnDdopYyWdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MFu0BO1w0ASuoCsBDUbQDAks7ZbutvM/Fk3mYagHXlTpgcHd4HBurmQGloPaBWzvUzNeC6Sya7fdEvhshRr8K6CuZkGQ8OOfNhUQ6j+5KH4VLNv7OpGlGBe2/M++6I/wb0iz2yaRlj+9cnzELJt/IiFw/Ilnbb0yO2hjgUMAdbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXXPMzF8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so416050b3a.2
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767647938; x=1768252738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P7z9UoHroCTxVDF2qFY1VGhcuFpUDlTlobm9HJWwlN0=;
        b=PXXPMzF8GgLBATJzakjRRBd6GZ6cPBvd6xaEeqy0ef5rKOIPctBBURW7HX+l4v5F/S
         3C2qZGEuRWvkkd3eHu+Un5lnAjdQV3ZzE/xjy01eS2p9sDsMD0hlYfKAD+rTj1Ut2mUd
         gnLntOnLj/d2ZjqvGPBqHspaksPsMOAY3xHo2f0E7HVHX41zA44qA92Cv+fPVrsNYOJr
         P7g9J7FVVPDdQVnU43QbDdNmMm7/wBzMBraIcnQckupLiQ9o9E8oTuKzkU8YWrQR28nv
         02pQc0CHPMiQ25i0jVDFiaG5qU5dWPZaYm4Xtzcus7niCVYUzkopy97hOQHPnMwkrfML
         UzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767647938; x=1768252738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7z9UoHroCTxVDF2qFY1VGhcuFpUDlTlobm9HJWwlN0=;
        b=o56UyybTMiaFAwGX9tgb8sgBC+ZWtJcI5pHPOAQjwGX9McTr9E8pOFQeFPdGEBt9Y8
         KbIS5Vzs/u0BccWBkCbTx+Pi9XbGTT8waqI/nAtSbjTOhLOF7mHHl4KwepK4zZiPSln4
         iPX2g9QzS3HwpxHcnd9WB/3vwUGc2s88askXJn6mMCKiZ/5Bczo0cTRT6zQfwQTkogcY
         S3uOmdi9XD+OtfhAk6U/+edLKO1zdKsFyCtx7K6ZunblmjU2v50kU1jqzFCs2EzjY3dt
         h716t8bf1Vuavu/1Eh+n20t4fLj1iQ40UxNMsAT7Hh2C7C/ViQIhyYEn22CjHUGPnUvU
         3YoA==
X-Forwarded-Encrypted: i=1; AJvYcCWqxMpN+AFIyOQeokilaono0+A1bWYrIOxb3eugzJE2bK3gF1sxFcOhjQ2OnMiN7Lm8yODplQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycvthFFLuP8RM+8K3cNw6SE/pledKwwhFwQZz+WuFNzu5k/xyV
	hM1jhCxYkqZUOqSQRDK+6zOqz8Wr1adkh93tQE5zH/jw4ERzSGmeDLRx
X-Gm-Gg: AY/fxX5gQ/Jn8OF//7I+Dg6fjxn0vMM31Q8ibLpyqZdyEXLWpkSBCI+cpjS2HBZnFsy
	amvjFtDM4wekUsWyrz4Khagq+70iYYAdxBIN1ceXoRJQAEeo56HjWsG2/sELMIxuY2h27BSLzSz
	LMrdXU4nLnMZw8byaVT3FjTXrNNcRzDCzXvZeeMFORQKYON4JtPKKw3LdLtaz0TD+MvbCgx35kk
	F2dohHtwBfc+H0n/+jhjw+xeAATXXmOZdIp2wqUpdE/LEz+Tj5oJbvyvUiqF63aTFyI70GntN3P
	Ld1DoPRxVQnnaDKkjCUsICTyugG7fCk8YvRYveazpY4heqJCue6YrJqRXfRVY+qpAgvDN6RYLIS
	ZgsL5Xe9Y6nOBx9RQ3vMxqfcMJXdKh6+0F1MRKgE7Mc9nEFVERx8XYtCy6Bao24N7mgnwrw35e0
	jPskQ8bC2aooCFuPP2Qg==
X-Google-Smtp-Source: AGHT+IFlZ2+kUV5KG/60Xe5C7ejVmwoBKqyiJE5D5k+mdOkyc6xWlkvWTjlN7kZFePbx4PtnaXnIZg==
X-Received: by 2002:a05:6a00:340d:b0:7e8:450c:61d0 with SMTP id d2e1a72fcca58-81882ed4e7amr858139b3a.64.1767647938441;
        Mon, 05 Jan 2026 13:18:58 -0800 (PST)
Received: from localhost ([2a03:2880:ff:55::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819baa19236sm87839b3a.2.2026.01.05.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 13:18:58 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	miklos@szeredi.hu,
	linux-mm@kvack.org,
	athul.krishna.kr@protonmail.com,
	j.neuschaefer@gmx.net,
	carnil@debian.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 0/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()
Date: Mon,  5 Jan 2026 13:17:26 -0800
Message-ID: <20260105211737.4105620-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch adds a new mapping flag AS_NO_DATA_INTEGRITY which signifies that a
mapping does not have data integrity guarantees, and skips waiting on writeout
for these mappings in wait_sb_inodes(), as these mappings cannot guarantee
that data is persistently stored. This patch sets this flag on fuse mappings.

This fixes the userspace regression reported by Athul and J. upstream in
[1][2] where if there is a bug in a fuse server that causes the server to
never complete writeback, it will make wait_sb_inodes() wait forever.

Thanks,
Joanne

[1] https://lore.kernel.org/regressions/CAJnrk1ZjQ8W8NzojsvJPRXiv9TuYPNdj8Ye7=Cgkj=iV_i8EaA@mail.gmail.com/T/#t
[2] https://lore.kernel.org/linux-fsdevel/aT7JRqhUvZvfUQlV@eldamar.lan/

Changelog:
v2: https://lore.kernel.org/linux-fsdevel/20251215030043.1431306-1-joannelkoong@gmail.com/
* Add comments to commit message (David) and to wait_sb_inodes() (Andrew)
* Add Bernd's Reviewed-by and J's Tested-by

v1: https://lore.kernel.org/linux-mm/20251120184211.2379439-1-joannelkoong@gmail.com/
* Change AS_WRITEBACK_MAY_HANG to AS_NO_DATA_INTEGRITY and keep
  AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM as is.

Joanne Koong (1):
  fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in wait_sb_inodes()

 fs/fs-writeback.c       |  7 ++++++-
 fs/fuse/file.c          |  4 +++-
 include/linux/pagemap.h | 11 +++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

-- 
2.47.3


