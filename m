Return-Path: <stable+bounces-202698-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 82585CC311C
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7918F3030B91
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498F03624D2;
	Tue, 16 Dec 2025 13:01:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8877235F8B1
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765890066; cv=none; b=IORCHBlsjCK08+Psd772uR9OPk4qRkquHQA95LLXSWfYuh/y0uHsRlvW1DptvFLXM+hDt52byWkHDTzB2C58j1jrx0eG2V9J+Lmks9HPBsTovByZfcDr+Xt3WMwROcWNSEKMDYSO8aXVWThFziRHGlZFdYzmhaK3bh54d1PLczQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765890066; c=relaxed/simple;
	bh=9zDCwuDgNMG6h3AjyD9IHCEigC8m2xyf6MCl/gSe4qI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jqbkKGKwlFrjpAS9qUuxzzR+xC8NEGXkMbdeFk1WPmFBOwJJvBIr9zLJ5pNRr6s3I7+KZvwvRtSQXmr5UEFfIIECShB4xOUIYv7UpndHYXZ2u7Oo+YQhtNA2qjMm9Ob2Yal/BKAAoQUFw9jzgkaGwGxhId585qdwMJtiVVWV63M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6579875eaa2so6941450eaf.3
        for <stable@vger.kernel.org>; Tue, 16 Dec 2025 05:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765890062; x=1766494862;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2Taqr5vQd2sMyst2B/qYCYcDh6CGKRhPPKI/kFYv3I=;
        b=Sn36m1SgLYGbvEk5T4+dYG11nFGsOWYecr5N6zJx33BuCHaTD3ctJ7pl5LoG2peO6o
         QtWXPcYhyOMqW3rg2k7ERXJoWbMf5/BnbBrN2ETvGSuJWaCLXKexMK2A3qlVo+TLilbc
         nj7y+EslpJ/zrmJl1OXvT/yzhu4oKQbaLipzXtWYPcBlakT3wlrHjBU6QKpNwVy/Ur4L
         D0se0RpuwP/Lrdpz88Nt3c4ughB0ShDf4BIh9DtrjNRMihX+jckF6NG7ix1jQ7BUemMX
         hJN8tlTr+6uPjWNZkdRXBYagcvXKy7wcTc+QqdRZjssYdvtqk2Lv9bx4u9fhFssUG22r
         uHFw==
X-Forwarded-Encrypted: i=1; AJvYcCUxr3Lb38szSYMALZPp/1Vi9CzQxTlizRd/sQae1uDHW6InZkqDFFblwyctKcpd/nEevjJ2zCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRopNIK0lJ63G53Aq46SOaxXEFvXVOyHeWO3eJrhja1yG09ewO
	LBAEFfDJsKQ94Mttgj0wFDvjVPuzGpVNjyfAQQRWurHM9qJPzHnrO4LJJcS7sE40M2fHcdt9OXx
	szsi30G+4iMgNltYnYhYV02vO6f9zE2evybHUfYYoOs6duX/oixtfKEqf6ss=
X-Google-Smtp-Source: AGHT+IEs+SxaZ2dr/jxYk0Fhhe73/s0hs2dNum6MxBmZsjr+c7FOUWYjBbgPOWdQ6sPiny2jOF3nZuERhsGhERjngUif6XZ1eh+h
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1891:b0:65b:31e2:2e24 with SMTP id
 006d021491bc7-65b452c887bmr5278958eaf.81.1765890062497; Tue, 16 Dec 2025
 05:01:02 -0800 (PST)
Date: Tue, 16 Dec 2025 05:01:02 -0800
In-Reply-To: <20251216123945.391988-2-wangjinchao600@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6941580e.a70a0220.33cd7b.013d.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: out-of-bounds Read in ext4_xattr_set_entry
From: syzbot <syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wangjinchao600@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com
Tested-by: syzbot+f792df426ff0f5ceb8d1@syzkaller.appspotmail.com

Tested on:

commit:         40fbbd64 Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154c931a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=72e765d013fc99c
dashboard link: https://syzkaller.appspot.com/bug?extid=f792df426ff0f5ceb8d1
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118de184580000

Note: testing is done by a robot and is best-effort only.

