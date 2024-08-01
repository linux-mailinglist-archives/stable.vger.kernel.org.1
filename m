Return-Path: <stable+bounces-65268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80F89454F4
	for <lists+stable@lfdr.de>; Fri,  2 Aug 2024 01:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47EBCB23305
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 23:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9922B14D2BF;
	Thu,  1 Aug 2024 23:39:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3FE14AD30
	for <stable@vger.kernel.org>; Thu,  1 Aug 2024 23:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722555545; cv=none; b=Oc9qQgikaBYLnRckK6PiCbNQrY3z+1UJR056se9LKc0ETieyVzuhaxnt45JOV19GgRXFzwYbtu19Ei8hXc82LZmNBCCFbLC6aGtrWCxPxc0xgiUTp+ajcKdUoSY58PWl0Fg6u82irtkO6Wv3PjhKkrz/D2n9x9eFr6OsRQCXvGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722555545; c=relaxed/simple;
	bh=UmmXi35nfuScAHUEeIJwGppaSmZBoW8i5FyJvfJEzhE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EnVzE6VAb9vt/shJBCzHo2cvJgmgcbTxFqhA8CmW78SPwawcGZR+QyHkGI0QdPve5wApnGr+zaLiJMxlMs0xevvzYV6UpnY8fgxJCqEPndbE38J5zEjGN0D5b+2ezH1r0owsuT/JZYRTGWZXv7xcD4+OKQcSc94uEvD8RBLb3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f8d1720ebso1061033639f.2
        for <stable@vger.kernel.org>; Thu, 01 Aug 2024 16:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722555543; x=1723160343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ODcuns1LudBlqI4V0K87ttGH2rAEsrJeBiRSk4hIkus=;
        b=bjyEnZzDzSb4PompzNMXjR04KWOxr+WOL54O5g/VtGLRkSxCXZUt1rByJeyahxDqMx
         a8OyrDDVIVapkRANyvZypHXv2tlVletj9SafYkm+sq/jk4qC0CAFt2gQljTyhD0w+nID
         VpJvBXzGpf5BTOb/kSB3EDsFN5jL+x/4qacHG1qSuxZIbz4UA9sYiZvnsFLuhEMmfBz7
         8wScIgvAoJjCgT2vD9pCdXfPlGUnilimLXlyqZVrRyBKyOC8Xo91q65l2qW+liGHmRwZ
         0ItWSl3xEmKbhD01jqFQAo/nUvt486jxe9RnOkmseS4/k+FmRaP5QBMGf8JzduYWEmhd
         VaQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOKU5lAYTqQbIhzK70FBMzVxrojrcXpjNQOESlAuR9Cwjmv+sGzr9ssjnq3pf9y7LVCkKSa2Juk+Zn9xsxoDOJ3pm0BNMu
X-Gm-Message-State: AOJu0YwrnAlYVVxbgZXTIi1Un6QLNIl/icTcvYHweQXJKIRpN0ChmsbH
	8912z0+9t+N6qjTVAbZciGEjAmgHNGgGcYYMBlHfSypyCINehtY3IF4K4Fjjy0rwpzwR4HO4ncl
	lr7KqOYxjlTAzO6gzNlYrwK1QqTt8FL4ciV5zvY8fs0HhdLhXQnqF9mM=
X-Google-Smtp-Source: AGHT+IG8TxilfBblIK7ewxLG6HE/mrHKCIseSqawEomYlhrUYVYyt4OhOTyyY0tgYhO72VI3qfqc9z4ejv5s988bgf3cBNUSPSDA
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3788:b0:4c2:9573:49af with SMTP id
 8926c6da1cb9f-4c8d56f8d03mr60315173.6.1722555543269; Thu, 01 Aug 2024
 16:39:03 -0700 (PDT)
Date: Thu, 01 Aug 2024 16:39:03 -0700
In-Reply-To: <000000000000839d4d060a0fab97@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000434672061ea7b797@google.com>
Subject: Re: [v6.1] WARNING in ieee80211_check_rate_mask
From: syzbot <syzbot+07bee335584b04e7c2f8@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, javier.carrasco.cruz@gmail.com, 
	johannes.berg@intel.com, johannes@sipsolutions.net, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	patches@lists.linux.dev, sashal@kernel.org, skhan@linuxfoundation.org, 
	stable-commits@vger.kernel.org, stable@vger.kernel.org, 
	syzkaller-lts-bugs@googlegroups.com, vincenzo.mezzela@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue could be fixed by backporting the following commit:

commit ce04abc3fcc62cd5640af981ebfd7c4dc3bded28
git tree: upstream
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Feb 24 09:52:19 2023 +0000

    wifi: mac80211: check basic rates validity

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15d0b26d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59059e181681c079
dashboard link: https://syzkaller.appspot.com/bug?extid=07bee335584b04e7c2f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122bb7a5180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dfa479180000


Please keep in mind that other backports might be required as well.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

