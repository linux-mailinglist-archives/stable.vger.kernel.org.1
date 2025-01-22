Return-Path: <stable+bounces-110109-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9368DA18C9D
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 08:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EB0A1886440
	for <lists+stable@lfdr.de>; Wed, 22 Jan 2025 07:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6E91A8419;
	Wed, 22 Jan 2025 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="l27EBmlT";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="g8b/d1af"
X-Original-To: stable@vger.kernel.org
Received: from mx5.ucr.edu (mx5.ucr.edu [138.23.62.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D9A170A30
	for <stable@vger.kernel.org>; Wed, 22 Jan 2025 07:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737530033; cv=none; b=bwCcv2wYBIQY6QX4liWIfQdxlwCS4XHMBWvzA+tfVuk1LpUQzjSuJNPUnEpOQrV0JtEZZEgbeH2rXwgS5ESIkci3nlBNweAOvRURlEMU7cohBa+N9PtaXMpsc6VGofGgWfVzFMp4W67syZ7h1dqMy4iq3jzhlVB2f6UXYME6HPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737530033; c=relaxed/simple;
	bh=LoGh3/SmT47JkQWbEFBNmTIWXKte0sRayQqRU0OUAqc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sSJ35T19cYUA+pmyuSOLeihN01LCWkEY4RKhtpR3SsfqANJWGqvX7jhal3luhu4r0tING65hcBpdIFxYY6YKYE8UWZhlr4SVYx/s70rU94TXt+QCei60iRTH638PETKCK64bVCqrPjMC2EVrBpfTMNnecY0qnd+Y2C2evX8uhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=l27EBmlT; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=g8b/d1af; arc=none smtp.client-ip=138.23.62.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1737530032; x=1769066032;
  h=dkim-signature:x-google-dkim-signature:
   x-gm-message-state:x-gm-gg:x-google-smtp-source:
   mime-version:from:date:x-gm-features:message-id:subject:
   to:cc:content-type:x-cse-connectionguid:x-cse-msgguid;
  bh=LoGh3/SmT47JkQWbEFBNmTIWXKte0sRayQqRU0OUAqc=;
  b=l27EBmlTZDvBr20eWrzQinCUVsPTFxnBo6SI+u2+DygehLkdnSJ71XdR
   TndL29iJgTQymhpZVovEg1Yr1GkO6vHRvXvKdpc3df+9LNFmJVUbYNroU
   D4Hf0/roVIRfVafM0v9Fl2twgD6//4Eg1rFk2akRmbPgxn+1V2gW6bTWQ
   nxqKeMPfCVEwFkduV4BOhqkOAKNWYsrXqcSbmkVXqpHsjsGe+OjhKiXcL
   Mx1rYQbID8GIeclTjEPLrc0JLwCNSO4hDH+BXMz4NA36bD94tdUBjhDu6
   IUHdsiI5muGrdFHOfutS2+fzRZPiBMBRtuIxyKVwZmZ4vWS5InWSOQK86
   Q==;
X-CSE-ConnectionGUID: SlS/ya4zQKmZMw2X1+Z9BQ==
X-CSE-MsgGUID: tBjsJ/3LSZmqOPA2GzUPgw==
Received: from mail-pl1-f200.google.com ([209.85.214.200])
  by smtpmx5.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 21 Jan 2025 23:13:51 -0800
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216405eea1fso121246495ad.0
        for <stable@vger.kernel.org>; Tue, 21 Jan 2025 23:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1737530030; x=1738134830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cZd+e9Bm6sgA/Q7lktjj1y+ZA1qolJ2/x+9a5MZ7yIs=;
        b=g8b/d1afCmsBnhJGs2X9Nu3l+X84YPrRiZ3a6umDHvHVb4nEblefkED6OTCqVlvkxv
         xyJ9OTESORoogUX+QWINZeXCVtJ9DrL9yECIDnQi3Q4EQ3CGgS+Dz0RJEa3tg+0P6z6i
         hJivueUgCnf380Yv/mVIpfROHuKL+fEcnpbx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737530030; x=1738134830;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZd+e9Bm6sgA/Q7lktjj1y+ZA1qolJ2/x+9a5MZ7yIs=;
        b=algzxmKI7QlOf8FtTZlkms7Oj8OMDtq9BlkJQYcd4+9yMJhZYBPRmc8iiVQlbc2A/d
         NTW2B3ncdD9WLTTrV47NpW74A7sXDecRJjbjS2mL80ZXOO43xLM9NZnwe4y6G6vD+SGr
         jNfwtWmOsJh4FHLDaUMJSqd7w/QDBfhLoyLEBj53L4S0ynrfc10F190rDe8epKmn8ZDZ
         LPyGyWaNUfn9EoVXOzhbXwwvv+4rX+85SiDyFDtxJe+VAxZky+rgj8pH6irsf2eeDj7u
         bGPAj1akFo5IZJVmh/jsJojjTVin4RcGuKiiUpJ4uN2ijhzExMk4mXLZqgthj79hYFzl
         kuYw==
X-Gm-Message-State: AOJu0YyLeTuac93/OIWvgZhmGvU7YFh0CRrG8171tMgM9fdMAnCHD3mq
	8MBhDgJ6N1GWOrCdJd259IOC5tRtVqIqbuQJO+qaHyVELg8gS75z0/n9pSUonmtmWra5eOnq7gS
	dXpGwHApIFQKsI6RuhU1tSbpJKP8+EOgVnq5zb+ivvNmLs4NdgXAefVQPMUlT5Oig1h3Hood3p+
	+stBz+4l3EtKKpG/+1KGp4AxZ9T32FTVN5Sx4ha8D4
X-Gm-Gg: ASbGnctLamTFw+TdgkTq95t40z2LDJQtkH3pQ64edCUB9cX6KjP7rkpLKHvU8a8b8fI
	m1Sb9xtUzPp0ddhRoukUotgXXYb8dfqrEiGEKj0fSoa+HTFsBUlEbjoNldhyHBuco+stvn2hqhF
	dInri1K4e9Iw==
X-Received: by 2002:a17:903:32cb:b0:215:54a1:8584 with SMTP id d9443c01a7336-21c35503ae9mr308370565ad.17.1737530029969;
        Tue, 21 Jan 2025 23:13:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyGSQDmKdLk3CJiGFEEeq6tgrcj/w2VL8+UGLm8XtY9xkY0CMBkPgHTMtpZkOkbzLuKk1tLWRUjm9ZoflOOr8=
X-Received: by 2002:a17:903:32cb:b0:215:54a1:8584 with SMTP id
 d9443c01a7336-21c35503ae9mr308370305ad.17.1737530029712; Tue, 21 Jan 2025
 23:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Tue, 21 Jan 2025 23:13:38 -0800
X-Gm-Features: AbW1kvaPzNZPf8MYs7dqohqD2ONT-DAoaoWd2cl3ijPiVPyfAG2fsEXnPAp-PC8
Message-ID: <CALAgD-4Wd2M01V2P8DRCMU0Lg+zJzGYSNgGQCdEpRWxrrkjHvA@mail.gmail.com>
Subject: Patch "tipc: fix kernel warning when sending SYN message" should be
 probably ported to 5.10 and 5.15 LTS
To: stable@vger.kernel.org
Cc: tung.q.nguyen@dektech.com.au, Jakub Kicinski <kuba@kernel.org>, 
	Zheng Zhang <zzhan173@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We noticed that the patch 11a4d6f67cf5 should be ported to  5.10 and
5.15 LTS according to the bug introducing commit. Also, it can be
applied
to the latest version of these two LTS branches without conflicts. Its
bug introducing commit is f25dcc7687d4. The kernel warning and stack
trace indicate a problem when sending a SYN message in TIPC
(Transparent Inter-Process Communication). The issue arises because
`copy_from_iter()` is being called with an uninitialized `iov_iter`
structure, leading to invalid memory operations. The commit
(`f25dcc7687d4`) introduces the vulnerability by replacing the old
data copying mechanisms with the new `copy_from_iter()` function
without ensuring that the `iov_iter` structure is properly initialized
in all code paths. The patch adds initialization of `iov_iter` with
"iov_iter_kvec(&m.msg_iter, ITER_SOURCE, NULL, 0, 0);", which ensures
that even when there's no data to send, the `iov_iter` is correctly
set up, preventing the kernel warning/crash when `copy_from_iter()` is
called.

-- 
Yours sincerely,
Xingyu

