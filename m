Return-Path: <stable+bounces-216256-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBtyKfRMj2nnPgEAu9opvQ
	(envelope-from <stable+bounces-216256-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:10:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 212F8137D70
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 17:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BC863055029
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA10364059;
	Fri, 13 Feb 2026 16:10:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B14426FD9A
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770999006; cv=none; b=iMfNSq58vIyAMFqZBNaZLJ4Hx1T33Gj76FyDYf3m5RZMIyl0e84mm9PLJlhTKPvKpJUVYS3c7C1v88D6jpCgn55R4wkF6x8CuDZvKwKVss2znUZX/cc14PRfSeZpMfMfhzybqGphZMNVyPiVndj3Lf+t5UEf98gx3EXlLbG09DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770999006; c=relaxed/simple;
	bh=PaTE+hUFJrW/q2RrVjCX1ypAv799ScOA0C5Hk7SjdAY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HQeb3/6PyJlJPzPEVwKAEHP2rtKBvtvwn7sZrvjxpg0KYtbIiitrUYWrEeTv0YgD2rhTaY7yZd2oLpx84PKZZ1ultmwvh32PHYC3cVpbjcEzh2xS6zZE8Ae19H9OW2P8WD1dySgQCFGN7HNw+TVOa8fDQO51Se8TB8rN+Tv1dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6751720c676so9067467eaf.3
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 08:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770999003; x=1771603803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yJRfcvfsXqKwKjWVZJwXtfVR/ggV9iIh5LOGQMM+Pxo=;
        b=u/+LGchWXbPE++t2kIpbgWpRrDnPhAgPNIXUIjO6xK6D8agsqTqJZUUZcjf5Lb0UyI
         feqaGLTcP/bfnDCxwUub1nYoY2kQhF/hZxYa65UXN40k1do9zvYSr7vbQYVPRySG8lHS
         9vJIyy51H9YoJj+wNjLxP/qJiAs8QyFGzXmuxrQbmrBYaCdeWH/iIEplDKwTyD/mTaak
         seUPdZ/o+wBMNV5xb6dHzp0MW2geX2ssl4dNA2JF2squAaobwU04pHt9v9GwDUQug9BB
         1xIEWqvN6bC0AhAaSL1Z0XaMNYJ2Rw1QXGIBHqYC/1Ki/yKtb67U9frzrIkGNzzrLq2R
         CaxA==
X-Forwarded-Encrypted: i=1; AJvYcCUsSaU4kEXs1BvB9XC1yaUhXLdp4GEf5YxnP2iRGaDLcp6tEcJVatB7XLd1M80KWVzMIDlXcuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBtpL/cy04ti/Ll34cwQgb6e13uLYZw9Jo4gVkC7UN3ylBAdLO
	fDTH6WDsNgwHL+I//4BeDmFxiLNQomMBdcklb/60ZqmKFUVLOLZenmwZ6Gs+4hzge3d+kEtTyBp
	z80wxLpMJjs0fFHwQHyIjEKguicIXmz5J/Sucv4rPOhDwFhh800pJ4/KtvrM=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16ab:b0:662:facc:529f with SMTP id
 006d021491bc7-677675807fdmr919935eaf.28.1770999003544; Fri, 13 Feb 2026
 08:10:03 -0800 (PST)
Date: Fri, 13 Feb 2026 08:10:03 -0800
In-Reply-To: <20260213154336.434008-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698f4cdb.a70a0220.2c38d7.00c8.GAE@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_gmem_fault_user_mapping
From: syzbot <syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=3c6097f9f42b05eb];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-216256-lists,stable=lfdr.de,33a04338019ac7e43a44];
	RCVD_TLS_LAST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,googlegroups.com];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 212F8137D70
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com
Tested-by: syzbot+33a04338019ac7e43a44@syzkaller.appspotmail.com

Tested on:

commit:         cee73b1e Merge tag 'riscv-for-linus-7.0-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121b2994580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c6097f9f42b05eb
dashboard link: https://syzkaller.appspot.com/bug?extid=33a04338019ac7e43a44
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13e342aa580000

Note: testing is done by a robot and is best-effort only.

