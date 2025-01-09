Return-Path: <stable+bounces-108110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7034BA076DE
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 14:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7459516881D
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932592185BD;
	Thu,  9 Jan 2025 13:13:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E4821883C
	for <stable@vger.kernel.org>; Thu,  9 Jan 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736428439; cv=none; b=Jsym9Njn9w3MEhV70MsujtdqCrzzspajHdzJ2WLlmBaotrF8GZnuTDycblGWpK+C90IoY2qgu7sORxSLDyrqRHwMB/4kfb2JEf5OsXvqzm79/jg2wSzS2DHFy6Kj4qk1CtN4WOzxc+TWFwxUm17JCAJ4yyInwC7uTodDIZd+Dsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736428439; c=relaxed/simple;
	bh=z0+5c2RmuHTV+YPKMhF+ZXxB+Hexc2PeT0DRWwpdgAw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=bOvXnwMG0wIrhyyAswRPWNLTOpwrpzq3kUeUmYjbIQfIuVHv58yTlU0mEQuDLvXXOwPHiRFr8lXGsaXOVfWOSxv77vPSZW10lRjWg7MVJr+F6+Nw6YAopUT6pQoN3U6xRb9Uj101elaeTXLkKEMUsSPndzYCK66ZBZWxZBf8mAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e4bfae54so7553695ab.0
        for <stable@vger.kernel.org>; Thu, 09 Jan 2025 05:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736428437; x=1737033237;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0+5c2RmuHTV+YPKMhF+ZXxB+Hexc2PeT0DRWwpdgAw=;
        b=H8vBuFRfIHOukg4xY7suWksm+CC8huEuEw4/PefboXPv2dBBLnSqrs9rOh0ssdqHKT
         eFekfXkDzOcN389VOCNqu9X2pM+CofQ7F5ftFxk1o9MIvfC6WN1VG5wAbLyEQC/0meTZ
         6/u7aG4EY5AoG0szReql2dHotxdpge95P9ioJyTf6ZdLYcdMCT6pnqayyAX0rGeZUG+Q
         BJk3/M9/IkYozmx2x73Oo9lV5DwLIjK0qYTa0PU4wZ6hukJ8Q+DaqxmmEYLli1j8Gy0n
         ialStgB/0Pzz8BaSvc0ZefD+pAPKEewX4nMrKKd/MK4x/c03uH0CxmI+AlB8ZgNjVKSc
         nuWg==
X-Forwarded-Encrypted: i=1; AJvYcCVrQoF7wgmwq4LilOZ5T4J45zbtBQBYnGtlyK9+X0GTBQDQ6qxmbiXWH6LIcdVdiQNUnSOoTww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQMGd7UbnbZ/tsFE/xwkjpFzBMT1b0xwQnbMRW1+2mdPCOZT4v
	+J8IiQ2BjoxJFiKHhYHxgB0brYDwmPflCyPVPHAK8QC850ah4wzD+D0D+Twxyy10Q33oemdmaMD
	Jg7t/09GGc0YvrphIlLQ4ClhMl3RDD1Fin7oT6Xv1UBXaJde3KD91KHQ=
X-Google-Smtp-Source: AGHT+IHZEftS9yCEjOgAbOXZXKl4rH91/TEZKGoA12KPWHxP8RRDFPr6+pnVlgq1brJNb7suWyvYGt7rgCc4d4xxUBTT68/KO99K
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f09:b0:3ce:473d:9cb6 with SMTP id
 e9e14a558f8ab-3ce473d9f96mr24368585ab.4.1736428436988; Thu, 09 Jan 2025
 05:13:56 -0800 (PST)
Date: Thu, 09 Jan 2025 05:13:56 -0800
In-Reply-To: <CAJfpegsJt0+oE1OJxEb9kPXA+rouTb4nU6QTA49=SmaZp+dksQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677fcb94.050a0220.25a300.01c0.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
From: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
To: miklos@szeredi.hu
Cc: aivazian.tigran@gmail.com, amir73il@gmail.com, andrew.kanner@gmail.com, 
	kovalev@altlinux.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz dup: BUG: unable to handle kernel NULL pointer dereference in

can't find the dup bug

> lookup_one_unlocked

