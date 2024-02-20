Return-Path: <stable+bounces-20870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6805E85C465
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE7DB218C1
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 19:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C4F12F5BF;
	Tue, 20 Feb 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lR3tcSEM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBEA44C94
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456329; cv=none; b=fLbFQRkgeBYwszlOX68s1N2mRWaNpAAgsRZ4hEfIbbjHNbCy6cpVr384ne7/LaP9l9+ByFPoqhLQmA9JxYmErE4Z6AX2C5tldgvvz9txQGCrc3ZNBGLhAr2gx40zZvhlKQkUMrhepxJwJ3m+uS2HttM2NeHbuI4JaeK2J9vjiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456329; c=relaxed/simple;
	bh=UV5OpmpTeat3ITv1BlNGoqwicB3qNORaSpRz3WR/B0Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Qhh7FYEEzJ18mHK0ihxXhvYopjULDN1hgFszFECzoukIIBRa1KrEqDJIo5zw56Kl6DGF1W7liidD+cBysfqWRCxvaD8lM7vcWRu8uLXjSYAzGtvQ3j9DBDpvDJ91JfihAbEeqBVDzyru87tDoMxAndJ5cJHWOot6g0OJu3fjA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lR3tcSEM; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dhavale.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ffee6fcdc1so76403177b3.2
        for <stable@vger.kernel.org>; Tue, 20 Feb 2024 11:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708456327; x=1709061127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bU90kCEdhdXywfoVlc2lzAzGm8wFNOTBAuo+9ULMyJM=;
        b=lR3tcSEM91+atxZwb2pJMWNRJ1q2Lh3XLxNPB+gEXJNZ8Uf9QgW52wmFiQCpYmGRRM
         ZdOkNcgMxNbn3Z5e9qpuQF4p1oR4Y8crpqBzf+pV5oZFbk3fSefICN+R2YdB0fuYbWOK
         ZiTNhXP5pNJFfrBMMD6uvPdK/TIEqhplETjk42fF5u4INIE/UPfpf2nBXXUAi23v1as0
         +zoPJNTnGxojplmoH29ULDdT/MlmVuUs0BEVbt++owflZzkuxV8bVbyb8cGYRW7fqZrG
         dLpATMY30Xqr7RTl9sLaobjeDdyVSr839KKCl+HVE+ETZA/SuiePB+h9pOrXEyesMDed
         y0hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456327; x=1709061127;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU90kCEdhdXywfoVlc2lzAzGm8wFNOTBAuo+9ULMyJM=;
        b=WYo/JhdXENRC4kqsM4L0hJN38bHbgL/jmv9wzzjGOZpBNKk9/NkadgzPsJxRNY2W72
         L8oFelS7Dlb72l/lX0h3qEYJTh1vTjn9uKWCDbwcQWF0Wf6E9tD6tIzLl4TT7svYOgeI
         wAhZ521IuY1H4MyGR1+ouiaYwNhQtw1grDRR+M5kxRC+JmYdkul+Vexsl1h9PgxLkAal
         OszwJlxFqDj3WbBl4SNIcxTrRek8pRlY95F/Gw/MyExBNCaJPAwOR8DQFZdfuU1MuVaR
         m+v+LEqqDLRLKv+YC7zJ346vy2So6EY3N0RZC3qfcLOFYplttE9JCTkVuW8qbv8IE/Ig
         7ujA==
X-Forwarded-Encrypted: i=1; AJvYcCVViWT/3dDhJVKWxPEBl4fml0GieRw6x3MyfLm3t6eJLFc1IVOkEfgsPxPjyApBesUiQh36ZVQBTHD71Wd3w7UxSPS1li/9
X-Gm-Message-State: AOJu0YyYh1Ck9iigKMVbDaEewgrSkGBcTx6PM3musw5VXLxgeI2ftFEE
	sYkj7qoAP7PL+CeFUDw54i8zlDZeXsXM/HXygQXd/pnBYmPwdt61DvleCXeGz6+gONcxOmnbmck
	Aa+pSqA==
X-Google-Smtp-Source: AGHT+IFgWEyzh6gqAlMtSgK/wXXqU4pIoql4Z5IpkPLY2RoDnc1t6RBLCmFcVpYqnlcf+nvulgO8DKFOkeQR
X-Received: from dhavale-desktop.mtv.corp.google.com ([2620:15c:211:201:e64d:5a86:7ce2:3f59])
 (user=dhavale job=sendgmr) by 2002:a81:fe07:0:b0:608:22c7:1269 with SMTP id
 j7-20020a81fe07000000b0060822c71269mr1506123ywn.0.1708456326859; Tue, 20 Feb
 2024 11:12:06 -0800 (PST)
Date: Tue, 20 Feb 2024 11:11:13 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240220191114.3272126-1-dhavale@google.com>
Subject: [PATCH v1] erofs: fix refcount on the metabuf used for inode lookup
From: Sandeep Dhavale <dhavale@google.com>
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <huyue2@coolpad.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>
Cc: quic_wenjieli@quicinc.com, Sandeep Dhavale <dhavale@google.com>, stable@vger.kernel.org, 
	kernel-team@android.com, linux-erofs@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In erofs_find_target_block() when erofs_dirnamecmp() returns 0,
we do not assign the target metabuf. This causes the caller
erofs_namei()'s erofs_put_metabuf() at the end to be not effective
leaving the refcount on the page.
As the page from metabuf (buf->page) is never put, such page cannot be
migrated or reclaimed. Fix it now by putting the metabuf from
previous loop and assigning the current metabuf to target before
returning so caller erofs_namei() can do the final put as it was
intended.

Fixes: 500edd095648 ("erofs: use meta buffers for inode lookup")
Cc: stable@vger.kernel.org
Signed-off-by: Sandeep Dhavale <dhavale@google.com>
---
 fs/erofs/namei.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index d4f631d39f0f..bfe1c926436b 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -132,7 +132,10 @@ static void *erofs_find_target_block(struct erofs_buf *target,
 
 			if (!diff) {
 				*_ndirents = 0;
-				goto out;
+				if (!IS_ERR(candidate))
+					erofs_put_metabuf(target);
+				*target = buf;
+				return de;
 			} else if (diff > 0) {
 				head = mid + 1;
 				startprfx = matched;
-- 
2.44.0.rc0.258.g7320e95886-goog


