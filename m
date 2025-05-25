Return-Path: <stable+bounces-146287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D33AAC321E
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 04:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F4E173A40
	for <lists+stable@lfdr.de>; Sun, 25 May 2025 02:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EDD54279;
	Sun, 25 May 2025 02:03:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7151E219E0
	for <stable@vger.kernel.org>; Sun, 25 May 2025 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748138584; cv=none; b=TR5J6CLcOF5Q9qMB5RVJiQ/9WLVF0u8nsz8uXqceWqNymA/QHxdLm3p7nhSSZUAHYUJH9tGOeHsZUVG5jgKw8rghdixpSdSeHFGLNmJAib2qKGJH2Vpox1wTjhMjZeHbwjtH/ND6zID+f2MoIjixLDRBUzwUDibjHAxjI0u/zH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748138584; c=relaxed/simple;
	bh=mIwIq9csUCbYIa5JwR59zeSsHmN9250kQ9AODSs2xFU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CT+mmbc1ZDqE4C0tx76Sg86bneaSzf9QJG7WjOvr6u7hUk9QobWDxKg4qb4S0/3WclKk9Njs2VRt0JCvR/kzp4WE3NNnL8gMAJ7tdrZZ4kru7xKUZk1cDgfEEqNn1OpjCgPTiAh/aRMmcedtOVaYeNCXaKJxAtAM+n1to1s39ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86176e300fdso114096639f.1
        for <stable@vger.kernel.org>; Sat, 24 May 2025 19:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748138582; x=1748743382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xqwBE7NrD1Kufa5s4oZy50TlLnntMQm9pBp/V84mvy8=;
        b=bKlo6Z/Gd8Joyx40M+iPEfc9w6dCZ8+i2dPrYQeedoh47r2ugtf0pZZstBNVhDDmwI
         6VvdDGA3wD/2o+rjBGEAAGMabYI0lDMsDinxR/ibT3+UDtBERD4MXYU0hz08iQ3FSHDm
         LomMUtXKgPzTgJOBpt05RFYXK4+45Hvg46a9epoklR7KVYZYUJc8Xu7+I6n3NLd+flbe
         zKFFZ2Vc/DeE5AUVbX3rBfYAxMF/aqd/UBXpJihnTa99JL6G8t3Ke1MgeoKJxOFJb8qz
         cpPdXkdBb/NGlDguySHsXMhifqaQrwhpvf50jL/C/3lv2UnkfkvmkPU3ebU3dBxiWxMd
         vCAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3gQn6yVVB861qHUNKhr4fNaK3hs3VRxHfVzTas+rpaxnlAa+BB6SXQmKEHlZ4lxw1Qq4XUeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRbifLyzHfE8Uu8BjBM8ZI1p4ADBCyrU0/7jXfgUgJX7YOfDis
	+BdAE2KfFJk6u6B5lMMFx5kaXB9sedmlkcf+a3AXNtElpWCuU3aaNw4CfBJvWRIHo5jZ2zUmQUv
	eT4ppY8VX33HN1GYAeLATPEWvvNjDxO4LxQwPQz01kBzKYKDvU9e89+wWoxw=
X-Google-Smtp-Source: AGHT+IGwwU+ncHev+YJC1P/NAvgpkbXzBLDQ67Y3hqwwBYDABZVgs+9V3HnLzuT63uQqOG5/uSEeL1aNAGafwsyOB4bKptXcShHT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4c85:b0:864:627a:3d85 with SMTP id
 ca18e2360f4ac-86cbb889a02mr386102239f.11.1748138582604; Sat, 24 May 2025
 19:03:02 -0700 (PDT)
Date: Sat, 24 May 2025 19:03:02 -0700
In-Reply-To: <6831b67f.a70a0220.253bc2.006f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68327a56.a70a0220.29d4a0.07fc.GAE@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Write in binder_remove_device
From: syzbot <syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com>
To: aliceryhl@google.com, arve@android.com, brauner@kernel.org, 
	cmllamas@google.com, dualli@google.com, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, joelagnelf@nvidia.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, maco@android.com, stable@vger.kernel.org, 
	surenb@google.com, syzkaller-bugs@googlegroups.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 12d909cac1e1c4147cc3417fee804ee12fc6b984
Author: Li Li <dualli@google.com>
Date:   Wed Dec 18 21:29:34 2024 +0000

    binderfs: add new binder devices to binder_devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=107228e8580000
start commit:   176e917e010c Add linux-next specific files for 20250523
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=127228e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=147228e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7902c752bef748
dashboard link: https://syzkaller.appspot.com/bug?extid=4af454407ec393de51d6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108b55f4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1145e5f4580000

Reported-by: syzbot+4af454407ec393de51d6@syzkaller.appspotmail.com
Fixes: 12d909cac1e1 ("binderfs: add new binder devices to binder_devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

