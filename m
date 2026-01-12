Return-Path: <stable+bounces-208051-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A0D11291
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 09:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 936E53034FDD
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 08:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43E302767;
	Mon, 12 Jan 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2/UuxZ7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742C033D4F5
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205712; cv=none; b=sFrysYYrXkj32D8ipr+HoqtE+J1sWYbYXPEQDMwmabAUBDV8dMTCszRHh2kkdNVHXF1yOWctrYvZFqbVucMGeXjj4NP70dZOkPkAGXa88PnBAlAZs1bHRFSA1HWhEMECtTm4BBhc5v5jwrUjzgZKo+5t9Zz0CBtyCoLT02VowcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205712; c=relaxed/simple;
	bh=5iyGrD6t4jKVWo1soh2XCJ43j2Qzm08eL5ZkM2bIbFI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EQ4fuODIL5mKfthsCGDLZS3hrKEunzZE5DzOnrfq9w3qD3Fmv7t7ju6X0XhwXLG5jk0xc+0i/cRafHRdw6XKG+3zrMnOUqohF0aP5fPTy1mnSZMBkTUPJnQF4jUJ7bEzB8hKM+hkLyt5eRAq45nf6dTEiPfqSN3DgMTjVf56Tx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2/UuxZ7; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c21417781so4112618a91.3
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 00:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768205711; x=1768810511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5iyGrD6t4jKVWo1soh2XCJ43j2Qzm08eL5ZkM2bIbFI=;
        b=H2/UuxZ7KuYZJWTND/PR6/gWyoqJa9ysZ/WtSno6++P3QA/RtqTUfxDVUbo+1Ymi1R
         E8wu8pOwtbtMS9EIHNZ2P7SlOxxftUTZDWlKToIg6PDXlaG8v+6ruYwA1d0vpv2jrUOq
         PP+pUlMyE/C65vOckKSD5Cl/mMtlOwbIppzIKU91T74bNRGVlpkdB4hWyhmxeHw5gyLl
         EuVVxzpzsW7pjPWhzjQG8CyS3qap+qt7Ic1zmJswbuGaWvCn9KVjEQSd1/VPRe3KKQ2j
         tIeKY5tzXeeGNK7q0TLpSqxwdVqc5A+y0S0vKMDXneirke9T9QKTzYMHtlGl/pG0KjxU
         y2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768205711; x=1768810511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5iyGrD6t4jKVWo1soh2XCJ43j2Qzm08eL5ZkM2bIbFI=;
        b=sHO9AHooWaC9JFNmSM5MqkMNumFGrElvRxyWgmWZONB3fra/dLEI+qF/zHy7Prq7Rh
         gaDUPqiatPzT8hcaEHRs07nDEdEqZf92zjbaYcRE+uh+ese0VvXw6xDyzNgoeKXUyXKE
         EsG5guAfJ/eKq1v0QgxtTA76TT87yGJ8pIOkxRhOw//CGCNI8fUVSFwANGKnRa8cDQSu
         h3Ox0ut5OoGAYRtz0rLYr5dMUYEPvuCx8BU1ySm/4qgNjXXUAmwN6UTWjXICPciGtk/y
         ey46mKq961pJjueNanT5bpjXNXKprgn4G6KfuR9UJl2DXcmSrbDOAeIFL9E4x2zbUMnv
         /g/A==
X-Gm-Message-State: AOJu0Yz06BqwMgSnAEBeuhwFI0st2C4krT0ar+qiJwSQpIIH7W5oi/IM
	ZjyZVfXLGhEF+GvomcEbUTgaR7+bAm4cT/goscC2kQp3okKI05uJGqjpqtEpBsW4FTID4EQlrgO
	6n3/PW1IFyDcH3a6bF/uA2ZD6bAO1TDDwLfPYWE4=
X-Gm-Gg: AY/fxX4RrmSRX6xWFsQJ68n/rFMjqHp7EHoQAMDaDi/juAKdn1EYoaEOGK19MyPV+P9
	RgcUW3FuRGoMxPD4+x7PXYLB2cfASQNmbGN6jNVooSzvPFiK3qvvaj6KW2EaHbkFJLRuL36WUBo
	LsbCymZlHiQi6LNvC4kD0IGF1h/6Ql+UhmxdICtLnuu/o2ASODz+R0jaFvqUlqk3AgqF27eNAOG
	gir66F4AibfdbYANrpE1Xd1P0YSz5IF8c71WcWJ31ZxJh92YJl7zaHIt6ZDRrKgPC856X87dMCZ
	H6OoBd0=
X-Google-Smtp-Source: AGHT+IEO6LjtBiiTakABt83pr8vBjMWsli6acZVk0wkTf7Od07uEXvjAYcspCT/ZRXWJY1wLF7d5BoH0Kph9pg0c/zw=
X-Received: by 2002:a17:90b:2741:b0:341:88c9:aefb with SMTP id
 98e67ed59e1d1-34f68c0241cmr13310625a91.5.1768205710536; Mon, 12 Jan 2026
 00:15:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: micro6947@gmail.com
From: Xingjing Deng <micro6947@gmail.com>
Date: Mon, 12 Jan 2026 16:15:01 +0800
X-Gm-Features: AZwV_Qg4Brt-nf3YdMPJ1efWhynaAQd8e05kQhY2LdIZ369g5-5ixvAbos9jnQA
Message-ID: <CAK+ZN9rJypDknnR0b5UVme6x9ABx_hCVtveTyJQT-x0ROpU1vw@mail.gmail.com>
Subject: [BUG] misc: fastrpc: possible double-free of cctx->remote_heap
To: stable@vger.kernel.org
Cc: srini@kernel.org, amahesh@gti.qualcomm.com, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

While reviewing drivers/misc/fastrpc.c, I noticed a potential lifetime
issue around struct fastrpc_buf *remote_heap;
In fastrpc_init_create_static_process(), the error path err_map: frees
fl->cctx->remote_heap but does not clear the pointer(set to NULL).
Later, in fastrpc_rpmsg_remove(), the code frees cctx->remote_heap
again if it is non-NULL.

Call paths (as I understand them)

1) First free (ioctl error path):

fastrpc_fops.unlocked_ioctl =E2=86=92 fastrpc_device_ioctl()
FASTRPC_IOCTL_INIT_CREATE_STATIC =E2=86=92 fastrpc_init_create_static_proce=
ss()
err_map: =E2=86=92 fastrpc_buf_free(fl->cctx->remote_heap) (pointer not cle=
ared)

2) Second free (rpmsg remove path):

rpmsg driver .remove =E2=86=92 fastrpc_rpmsg_remove()
if (cctx->remote_heap) fastrpc_buf_free(cctx->remote_heap);

