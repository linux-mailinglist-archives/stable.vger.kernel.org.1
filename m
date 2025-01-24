Return-Path: <stable+bounces-110381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14733A1B75E
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 14:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B69A7A6168
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8BA86343;
	Fri, 24 Jan 2025 13:43:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6F284D29
	for <stable@vger.kernel.org>; Fri, 24 Jan 2025 13:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737726186; cv=none; b=UMzk1jcbVtGLquCSzG9VtHH+I4AiYLjKDnTr4N9sPKU43F5+3CSq0KU8e02epN+Go8Q6XtbjNNlagRtkeJGMJkL8Q5IGs+ZBMiQCj2IkobNFLHLGt9TWbgAMsTcjfe3+GK7dJDY5W0x3S+VLeA7o6ObNamDo0fY7hT6CmSaJZ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737726186; c=relaxed/simple;
	bh=n8OZ3b/yHRWJF9A8gcfHJ7tGWiWPREHXqrj4JQyfRFs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=R2TVRaEEMZQUmGXj5XisSGtoAoKKCpuC5GCmwENuoJ0i56P3jvxoqzZKo6KYHwqnziaQWTGWhNvtg2ZGQsfH7U02W8kdhAYRfWr2t58389vdb+JVS5ujXFtoN9axOmXoQI9MTVKz1NHZCWpPU7suw6U8m5/Q78cZ8ep6dqp/Tuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-844d54c3e62so268760639f.2
        for <stable@vger.kernel.org>; Fri, 24 Jan 2025 05:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737726184; x=1738330984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pZe/q9uQMTJ1h6+AXXu51oqWvY3EGvpD1rhxTUhiCw=;
        b=V5S6ZU3LA+3J60PPUeoLt4uFTdHMitSxDjxBbnv8Is0jOGluKm5nayq2U6BWDRd1+/
         WTjUh8U93BUIQQIJREuwEf6KJ8NJr/8yVEVZJ0jR+bli7Xomy6KplgbQL33YpmcDebPV
         x3T4ac7Ge75YFe6F1f1XTeViQ/ncIcBvROys8lnDCZaHR0CjEP/GZT0SVt1REY1qZd1y
         a41Lz1Av4pb1AMxanG/uQS10Cx/64eo6L8o793aQNxHA6LuAYycqpfF/xwF/yBwuWBcx
         nxLHcoHZ0+4EW40uZojgHnCpHcHzWkwelKDCTFA5/I5/NAPVKrSy1DIHgDoRRDemI7CK
         dX5w==
X-Forwarded-Encrypted: i=1; AJvYcCVOa4s09+UYPoprkPWRZeeCfwYFovQ/olLvv/a+yri02ht/8djRuCpREi5kVdpvcHBeOXb80OI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxURw7OR+VJsSiVa7D0ZgT9fb8VKPp9+PHB5up6eXNaobLyA8I8
	c9dWO5z7zDSdosRKDdSPL0F8IIxDvpideyASegGdhgNzpuJ1k1jmQdII0S1uwNK/QZCaCaT/Rvv
	pvIB73h5AgPHdQVhfrgX5QKb9BPwcfzkJWkUJnirDcoBdU0FZsI3MyQo=
X-Google-Smtp-Source: AGHT+IHK9J8OswljrqskgVtLCWuKfDYf9V/LMLUGMG1IR6LhNN3Im86vudLsPDVLvtHBMCmDTGo+FZJvCui01vqHBrHYGxG8x3MI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4918:b0:3cf:b2b0:5d35 with SMTP id
 e9e14a558f8ab-3cfb2b05ec7mr102563925ab.7.1737726184066; Fri, 24 Jan 2025
 05:43:04 -0800 (PST)
Date: Fri, 24 Jan 2025 05:43:04 -0800
In-Reply-To: <6786ac51.050a0220.216c54.00a6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <679398e8.050a0220.2eae65.001d.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] WARNING in mptcp_pm_nl_set_flags (2)
From: syzbot <syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 322ea3778965da72862cca2a0c50253aacf65fe6
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Date:   Mon Aug 19 19:45:26 2024 +0000

    mptcp: pm: only mark 'subflow' endp as available

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f0bab0580000
start commit:   d1bf27c4e176 dt-bindings: net: pse-pd: Fix unusual charact..
git tree:       net
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16f0bab0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12f0bab0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=cd16e79c1e45f3fe0377
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11262218580000

Reported-by: syzbot+cd16e79c1e45f3fe0377@syzkaller.appspotmail.com
Fixes: 322ea3778965 ("mptcp: pm: only mark 'subflow' endp as available")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

