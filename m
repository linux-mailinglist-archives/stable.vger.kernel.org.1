Return-Path: <stable+bounces-65357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BF9947521
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 08:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED686B21416
	for <lists+stable@lfdr.de>; Mon,  5 Aug 2024 06:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129E6146A67;
	Mon,  5 Aug 2024 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLIeWOrR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536DF143880;
	Mon,  5 Aug 2024 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722838632; cv=none; b=g6xd2D/uorzBRdhqZxzf2EM47LF23Oeb4b4ofDFikEZZjNZa6RcANB0OW4p6G6XfGrgDPZAVCHJ0hJpALi0lJW9N+2wuFqnegcSKSCT02mcuSCv9bG80bPWAKB8O49DqBK0YVoVRukx+/ShsU9f+GVdZLa1lFLflbq/FG0RqlFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722838632; c=relaxed/simple;
	bh=ZjgDYjq7powx6dku1RjeF1PGGwTeU3pln+4TmeKsj4w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oJN17daE/3pmlDaFXy/xC5Bz5kNUOZ8ckF0PV2d0i3GgwSKXur9IneIwoOqrdqMGyCRdgGPHr+z2CSimAjJBe7wn+VdP6Nil5FhuuXZIgxtL5Q7oKu6s1HFKUsU3b51A4H+yiGxBBhrH2zZabGTVTPHQxYxfpTWEm3nHPIw9tSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLIeWOrR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso2722857a12.1;
        Sun, 04 Aug 2024 23:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722838630; x=1723443430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZjgDYjq7powx6dku1RjeF1PGGwTeU3pln+4TmeKsj4w=;
        b=hLIeWOrRK6h9bwBVYjZQQ8pwQYG3rtWdWVa9ei+QGuUQUA7b3cE3jOkoOXgUwktpQn
         0zObKcz7gZjfNEkjySuOXw9tlwzav5ezvtW6mIlllcapp3nkbFASaie7m1L+RmooxwS5
         eor5pb4x84PpLPoOgZWQh7UvBUPzPHgdmcx8KkwuQsTKRRgHjBTFM0Dwjyz0XdZmxamM
         GALeMXVcCxesxj59U8xsDcrpxV3tzf5HD2wWDov6wJgID2dbe8x+ILWGVWvBOFuKPpBH
         xC9lLMAObv0S7/q3+L3EY7e4riI70t3wS9pDWuzd+D4jpZY3UKyqGTz49cGRUYbaIoDe
         H2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722838630; x=1723443430;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZjgDYjq7powx6dku1RjeF1PGGwTeU3pln+4TmeKsj4w=;
        b=hlZWOb0JasKE8P2prvyUmxwLtO/SVCCnIthaLHif2EMTOaO9cbBMModNcmc7LVN3cV
         xVXC/Ay0RPaW55ETYBMo7tRet3oIvrgL8/yowTKV95noWQdX9aA5biwEYj+AgWfR5ObI
         qvzgEfkJN2LIxNkLOkDhNHfJ5zV6Fp4b0IkszEBO9rojKc31EQdk97BtKbMhCeT+QPMC
         ganYeuGqqzBRRLg1GAf+/q4tUxBJlPvu5L5AHG55EXrKa3ZgcZ6eBRMgT6AoBK/1Iuad
         THTIeAbZP9xfPq6aMXOSHE/YoAhiZdiv259xEpRXWO4DhzVm7KNQmTb7xCwmgy1bupbs
         kACA==
X-Forwarded-Encrypted: i=1; AJvYcCU+qj0cRbbXiFlEcvmym+zvjfoJ82ohvPF8wjqQwrJaduyEnNaX75QnhIztnkomVHMfmDt6AyDpd35lITe8H6l2NiktDVjz+lf1mrl5pcr6jhrVpdZj8Hfm3rnBWZ+TuJ5P3wtQa+4Ss1B16Veq6C0qBdZ5Ho6179Jx0Y6T
X-Gm-Message-State: AOJu0Yw3vLThze+bjWoQ4ggzueS+todtxsdY8mRYwI/sFq/frpA9yE47
	MiWnYx4/twSX6HD2WGB778JrbVW5QQIzt2ZlRctOVD+vKVu8c2MjKDQjpduOMsX1TtRm5C6OAAe
	7cGnz+qpNvpdgcX9gXfaSLaxLgLw=
X-Google-Smtp-Source: AGHT+IH2X+IzhQIlgRtIy+23FBJcyC76pAnuCJKL1BEcOA5ltqEPwE/yzKrKToEs9l3ENoVBbVuHzWjyCgNPj4ajEAM=
X-Received: by 2002:aa7:c50e:0:b0:5a2:87d3:6ee6 with SMTP id
 4fb4d7f45d1cf-5b7f57f41f4mr7296865a12.32.1722838629097; Sun, 04 Aug 2024
 23:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Blake Sperling <breakingspell@gmail.com>
Date: Mon, 5 Aug 2024 01:16:32 -0500
Message-ID: <CAGRfhun+pAYRjS8p9066HYV+wjyvCWoLtK03Nr0GXmYHzFDPpA@mail.gmail.com>
Subject: [REGRESSION] [PATCH v2] net: missing check virtio
To: arefev@swemel.ru
Cc: edumazet@google.com, eperezma@redhat.com, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, mst@redhat.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	xuanzhuo@linux.alibaba.com, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello, I noticed a regression from v.6.6.43 to v6.6.44 caused by this commit.

When using virtio NIC with a QEMU/KVM Windows guest, network traffic
from the VM stalls in the outbound (upload) direction.This affects
remote access and file shares most noticeably, and the inbound
(download) direction does not have the issue.

iperf3 will show consistent results, 0 bytes/sec when initiating a
test within the guest to a server on LAN, and reverse will be full
speed. Nothing out of the ordinary in host dmesg or guest Event Viewer
while the behavior is being displayed.

Crucially, this only seems to affect Windows guests, a Ubuntu guest
with the same NIC configuration works fine in both directions.
I wonder if NetKVM guest drivers may be related, the current latest
version of the drivers (v248) did not make a difference, but it is
several months old.

Let me know if there are any further tests or info I can provide, thanks!

