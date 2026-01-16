Return-Path: <stable+bounces-209988-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC263D2C439
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 07:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D1D83036436
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 06:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B54734679A;
	Fri, 16 Jan 2026 06:01:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23381E834E
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768543265; cv=none; b=GGgXlKZXtWxgqBFgrC1BygfyrlmhUwqV20wy0SUmHRhnZjItp42u5Rh/M3RCJq1YBkHmZPeMZO1UyE7yR2cHhoPz07CCpAhkZPmmKW+ApmbP7SGnyTbjATpwEEVAxneovy4NXs42xe4z72pbFclTlC2Cr0k2NbSMDCx3+uM5bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768543265; c=relaxed/simple;
	bh=93I/oMEzhd/e3i+NwOuCZv4NZFaytmGEp7ozk/HGMh8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dS1mlnZLkQ5d6l28DdGg111ZpRFEoW18Q5fjGLVcUHbXzI0AC6nRiAb7o/L6QEIhQxnDtRrkldfb0MKrbVqofbDFWRiGeq4AzbtAMJtsihJ8nbz9Q1YMkKVFTlqzXbmsWrK1bHRWJpjFTyj8fQqQxnNF7CGQIVk8vSu/0XK3ImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-66107de5f96so4890942eaf.1
        for <stable@vger.kernel.org>; Thu, 15 Jan 2026 22:01:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768543263; x=1769148063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqxeTpOTSPSaeYMkDqzGlSX59eRy8+Mpf+mJ9vwFUWQ=;
        b=rlfsT2Ovs3GB1r5tWHWLBRQkiZ2Wa1KYC7wR0yUMxYrGOGGMQpW+JIj/bCUSDDnd4L
         bO1Pm2EsSIBwV2/gKUrjsZs4pyIHw23hKgOrLLzKK7atPnH1sdbK+kPEsEfR4VFNph54
         PcwZzgwzIkypSQUmpEb96SJGP0A0CDnMO8aKDSAWXXwtXa9lv18ne9Jt7cNhNJ/bGc76
         g1HLMWOuis5Zna4ni47Cn52YPt4QvdKsncvQkTl+/bKknvo1W9YJ7Q0/9C++zbjCNnOl
         +Zas3rKqZ/YsH9VTtHzAEVmt49KcfIVLlWsB+uGn3WP0j6fUFe15RJpEmGR1h1McOqno
         YWJA==
X-Forwarded-Encrypted: i=1; AJvYcCU878QsjhTyUF425o3duh8Hf8caet0QRjTi+BsWe9iLfIA8UqkvDphDHpKTw39aPpIiEJvu/Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJn8kA2eG+m6A+CLdslm4Qf33P+lpIEonL4VFmoKlfmndYkSoD
	APB8hp8fK63gj4l4TNfYdqFG2N4qUg9OrU8S33Q3th7hYkjbsI5jqP6lk+nhfPA2hA6VyFGXwkb
	7GRgFOqMOvOHRLDhhZp505Y+95OUBm5eCqmp8oLK26LvFV40KgmCXWxw+YQM=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ca0a:0:b0:659:9a49:8e2e with SMTP id
 006d021491bc7-6610e65373cmr3170889eaf.32.1768543262921; Thu, 15 Jan 2026
 22:01:02 -0800 (PST)
Date: Thu, 15 Jan 2026 22:01:02 -0800
In-Reply-To: <67117fd9.050a0220.10f4f4.0004.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6969d41e.050a0220.58bed.003e.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: slab-use-after-free Read in ocfs2_reserve_suballoc_bits
From: syzbot <syzbot+af14efe17dfa46173239@syzkaller.appspotmail.com>
To: activprithvi@gmail.com, akpm@linux-foundation.org, 
	david.hunter.linux@gmail.com, dmantipov@yandex.ru, heming.zhao@suse.com, 
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, khalid@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	mark@fasheh.com, ocfs2-devel@lists.linux.dev, skhan@linuxfoundation.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit e1c70505ee8158c1108340d9cd67182ade93af4a
Author: Dmitry Antipov <dmantipov@yandex.ru>
Date:   Thu Oct 30 15:30:02 2025 +0000

    ocfs2: add extra consistency checks for chain allocator dinodes

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=140a0852580000
start commit:   36c254515dc6 Merge tag 'powerpc-6.12-4' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=af14efe17dfa46173239
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13444727980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11861440580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: ocfs2: add extra consistency checks for chain allocator dinodes

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

