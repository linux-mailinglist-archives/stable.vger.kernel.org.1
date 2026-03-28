Return-Path: <stable+bounces-230767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKNkNuJfx2ngWAUAu9opvQ
	(envelope-from <stable+bounces-230767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 05:58:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B934D4A6
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 05:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C376F30236AC
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 04:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2CE31F9A6;
	Sat, 28 Mar 2026 04:58:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1369131717C
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774673886; cv=none; b=RPrgf/hmVyyt/rNf+sCalJeeE5SUSCA/5TZpdNNkolT1aoMl1Lmeay75hC1wW++/UO2AIfN96mSC1TNQ1TAy4cfIDmDI0uoVrN6yyS7MhCvLnBppjqs4zbXHiut7c4INo2Sb2XVsO+wPXetr9s8p1ueqxvfDaowol/n+DWqy4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774673886; c=relaxed/simple;
	bh=6MxmAuL+olnrPfJimyYZFJp6soAGmvW2iAOs6KngBYI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lD4J+Jpo/P+yIl/qiVak9hPetvZsdXx+xxcjjBvLKtC67dNdrBpzWdwhXe8Vuhd370XXoN93E8OkW3qL2C9eAJ0ok31yl+Zp3td9iLXKGsGv/dVPvst+FgN0lyZczb4x741CAY8Yz1O9j2GKbgkuVcN6Mk7+SoMX50nuEz37Ds4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67df63d61e0so9866009eaf.2
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 21:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774673884; x=1775278684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWXTN0ZZ70dc/Umrga+d96FUtkZpdVDz0urw2DXvwQQ=;
        b=V0Y34AK8UfSVa8ve+njaEKAwO9YrWECY87Qry2MGKVCYPhzgkjLNTLHnzjM6na55Gf
         2Ugcn6AgZtS2QjkH0bz7S/uzCqt8Zjbt3APJENoYI3gEbVyvd3/WSr9t7OUbFKRtPgVD
         R4G5H2pawZE2wIVNcDgxrPdCxJ8sZ6UpGhHiaepW3jYV8rSN/Z40zGBEehlWVMVIbV15
         6wvDgsV8SFidqOObVG0sfYghYlctGzaHfB2Cmw6Lbg+byvwN5ITQfr0bm+P3RKpMDmJC
         v8PKWTyc9nVy+du7OUOfD455hYIyx0MXhXowWr2BDO8bgdzArLYx/oYwW7kKwTbkp7HD
         YZyg==
X-Forwarded-Encrypted: i=1; AJvYcCVcwmw4w9qyUEoBfnBuyrksprOf7Hvey4XTl5EhWt76j6rVqCzRpgwwF0zucSI9e6OepmTyoNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU9ga3HKoJR0FZZ8d/LnTzgSpB+i747aE0VIFT3QGq+Qz70hC2
	hx5MdOjDdQ7fIp8HAxap0SrLiCBPuBEWgoYZAbQBWHeo5u0AYcmkdSa9uKbrZsu/QUqivxyh9Q7
	7WR8PJKZw7HYKkdx2AX3iffK4K+b4qucSeORlpqKV/ChxIr88u2kaIxaVvbU=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:987:b0:67c:2204:9477 with SMTP id
 006d021491bc7-67e18756f94mr2465453eaf.56.1774673884163; Fri, 27 Mar 2026
 21:58:04 -0700 (PDT)
Date: Fri, 27 Mar 2026 21:58:04 -0700
In-Reply-To: <tencent_06F5ABA639DB23E136CE383A7D834772DB0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c75fdc.a70a0220.128fd0.0019.GAE@google.com>
Subject: Re: [v6.6] WARNING in v9fs_fid_get_acl
From: syzbot <syzbot+f8f9591a0de3737013ab@syzkaller.appspotmail.com>
To: driz2t@qq.com, stable@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=cf30d9e358c58220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230767-lists,stable=lfdr.de,f8f9591a0de3737013ab];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,vger.kernel.org,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email]
X-Rspamd-Queue-Id: 738B934D4A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f8f9591a0de3737013ab@syzkaller.appspotmail.com
Tested-by: syzbot+f8f9591a0de3737013ab@syzkaller.appspotmail.com

Tested on:

commit:         c09fbcd3 Linux 6.6.130
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11605cba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf30d9e358c58220
dashboard link: https://syzkaller.appspot.com/bug?extid=f8f9591a0de3737013ab
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17a77f52580000

Note: testing is done by a robot and is best-effort only.

