Return-Path: <stable+bounces-230177-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILmFFLChwmm3fQQAu9opvQ
	(envelope-from <stable+bounces-230177-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:37:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A133630A44A
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C6B330ED397
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 14:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C88537C105;
	Tue, 24 Mar 2026 14:30:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8FC3624BC
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 14:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774362606; cv=none; b=WWD9N3qmZgOCJdSpZ7ZcGb63TQ8uNyBBL0JnNFWOaDX2x9LR+05KRSYe9wmFGqJn256u7mnZ7WyYee7AN+YtYEV6TH8A0RttFVlWXs9p0emYh2EAkYDZWn7syattYTmR3wiOKS2Fuhn5DgNBMrWk2U4Hf4aoNfySM4kPkiUOa08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774362606; c=relaxed/simple;
	bh=rQQVQ1wS9wK9ZUUlTkDgQmhQqeCu/P+o9Uf5Egje+5E=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fs7I4uSnNw9h5aEWpyCbzQxjuWvyRcN+ey62fVrZOdznUKOffj2TQhV2ytBVVCl54ot1ooUqSi56MYx9V0N8F5QKRxwyKf7dUbnLzmazTcnR2KnLWmzWRcHFVBRwWUQeI+JGa6uaXYWrDHXBi8qV2jEx3h8upWMrv5sRyJzj5Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d4c7afa9e0so52485658a34.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 07:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774362604; x=1774967404;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o5aihaodhccHD3lizpz1Dg+lR4PKzRYdB0a8QMR/Unw=;
        b=RW2th6VcI8NZhbX5CDnuVU978HfbRA2qf7/Env6TdcectlR7dKHuxvQSTfZcHmRGdy
         gmFMtgJHSS6wAwzlUSsBQIIa7VOYI5NxOHXJ2H8t5Ki234i6gYj51DElF3otA6CvKMR/
         5htk0sdpRiWBZAbhaKwENHrZYaVuA1EzkTY2/Ghdt55dc4D8pP5HxfKWQ7sPIZ2aTbru
         4SLcrwuDsyei1A7yEWBAJwcOCjnCaFCjgxx2fuAmkXPIyM680kXN0VhT8JigIxr+uX9M
         qEKAQAOBZK2NHWzlr3W4Gspcql02VIldR9Vo6cYGNzucqpEegw7wZ8GRaXA53h7Th0bl
         w9DA==
X-Forwarded-Encrypted: i=1; AJvYcCWDJ6657OCgadmfUnP+wpbcAd22kQqeib/bKGspXIio9Z0Ol8VgCdlvio8RfzpkeF09RXswDU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxrx0ULs4xMubU+WAGhZ907PubLQ5u55UnEvrRS+WMJBxyufXX
	SmDoLUgG3Brno/4mFW1jOzO2iHvzEpSv64taImeYNpX5A8d6R/XNe4/PqyWaQOD2JBDMqTwg8OG
	EeMtSRpDTbvpiEv/LjUT3R8LH3u6omr7ricFI8U49InVQGSXoB+5DQ5gZYVo=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c83:b0:67c:2c29:216b with SMTP id
 006d021491bc7-67c2c2924f0mr10301130eaf.48.1774362604135; Tue, 24 Mar 2026
 07:30:04 -0700 (PDT)
Date: Tue, 24 Mar 2026 07:30:04 -0700
In-Reply-To: <tencent_44CDECE854579C9391141AA91D89BF4D2309@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c29fec.a70a0220.59f55.0008.GAE@google.com>
Subject: Re: [v6.1] WARNING in iomap_iter
From: syzbot <syzbot+016d861797fd718491a8@syzkaller.appspotmail.com>
To: driz2t@qq.com, stable@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=2b89c38cfc7d08c1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230177-lists,stable=lfdr.de,016d861797fd718491a8];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,vger.kernel.org,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: A133630A44A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+016d861797fd718491a8@syzkaller.appspotmail.com
Tested-by: syzbot+016d861797fd718491a8@syzkaller.appspotmail.com

Tested on:

commit:         f2ddafa9 Linux 6.1.166
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16c916da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b89c38cfc7d08c1
dashboard link: https://syzkaller.appspot.com/bug?extid=016d861797fd718491a8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=168c506a580000

Note: testing is done by a robot and is best-effort only.

