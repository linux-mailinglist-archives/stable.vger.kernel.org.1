Return-Path: <stable+bounces-230649-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NsZK+x1xmlFKgUAu9opvQ
	(envelope-from <stable+bounces-230649-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:19:56 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FA33441D3
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C959330F6DA8
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFED396D0F;
	Fri, 27 Mar 2026 12:14:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2C5392836
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613644; cv=none; b=gRz0NntuaQ+lgCQ73w2o2s16H0O7yZ0+iQdTh6WTyK/+WD36kC4R30hslk2pUwGrKX3Aw62T+quijctmfoPDLqOCczbT+MCHBwCwW91mOyPqKIkskbaKoLoHi9YKr1Ro1tBAhh0KZRYOvK6P4uaXV6owiKnSVdkLJ12SqrNGmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613644; c=relaxed/simple;
	bh=okNs3h4fAo11yjZpOsTmZge2N3A4XGJhqEb8wC+tykM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VV4cTqLAmos5En8qp5htS2aRp9afMlD1S8m2jSCOFvtP9IzQrajvCP6bExZ2dlg+4PyJRv58+QfzRz3EbCXfiDL7mRdytBMsLZptpRi+h+VPm4mKrcT6YR28ZiRDrQZ5/So931xwyfB7nUcmpHpYEbu0iy1FAECePbOsTFMQNfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67df0afe34fso5589699eaf.0
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 05:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774613642; x=1775218442;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iSgyg6G12jqQ7L5pa8uEZO73Z9H7gCigUdwQSvZJW0Y=;
        b=NqA9k2sm5mXIV9oIFAMt3Dpitkb6TzN9f00Fvf7Vq4FCzM9W285mpc/whkTykdCeFb
         v3J5vIP3jHmC0lWTmL/MPfi3ywm0KuqIrOuNlfbh3G6qjHPoD9/gureuD4mdbejBGgqt
         QWncflDDrXgPXzhglRjYIyPshTkngb2nvTCdZFCB50TCxBt+pWAljfFjdiuEDZDA/uhC
         o+jhPKPQpxrmuJ9MF59wf3XlZwq0QP3dDqAQ8/XqZm1O2CKmneHELx1iMHBt6feAf1Go
         w5Y1d94iHUzY63KQFw7nFlGQ8TwQoaHLKAFX4bcB+UBT5qszMOSKhRDS7PFBkjbiiUu6
         LCFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5HlyeuDUA2d1FqqdSXoFvrmYzmdsWcT9kLF47QCF4OF3HADmbtW6Dw/lnpw8lu15Rh+FTfbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRQRdpPOZbbYMpLedeOGjmz9ksuv7QQlESp4xFNQnEu7hUN/R
	pxWlmPn/H1wO8NMsUik/ui4rXXi0Jxz9R6snXjWRkA/NFQsyyU0pxilCKXagTUllAyx178NI3Uq
	G4bgk9Tp0ALSBBKopeXRkCvFHBnGNL2zPvt6vY2j4hJ9d0tIPx4JBwuV34PA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1a0b:b0:67e:8fc:2b with SMTP id
 006d021491bc7-67e185eb191mr1028251eaf.6.1774613642117; Fri, 27 Mar 2026
 05:14:02 -0700 (PDT)
Date: Fri, 27 Mar 2026 05:14:02 -0700
In-Reply-To: <tencent_1D818E8FDF0991A176CDAAC6CE0B481D8D08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c6748a.050a0220.172bcd.0000.GAE@google.com>
Subject: Re: [v6.6] KASAN: slab-use-after-free Write in gfs2_qd_dealloc
From: syzbot <syzbot+469b584076b88cbb037d@syzkaller.appspotmail.com>
To: driz2t@qq.com, stable@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=cf30d9e358c58220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230649-lists,stable=lfdr.de,469b584076b88cbb037d];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,vger.kernel.org,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 25FA33441D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+469b584076b88cbb037d@syzkaller.appspotmail.com
Tested-by: syzbot+469b584076b88cbb037d@syzkaller.appspotmail.com

Tested on:

commit:         c09fbcd3 Linux 6.6.130
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=162b8ef6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf30d9e358c58220
dashboard link: https://syzkaller.appspot.com/bug?extid=469b584076b88cbb037d
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10966f72580000

Note: testing is done by a robot and is best-effort only.

