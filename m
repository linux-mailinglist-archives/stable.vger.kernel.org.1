Return-Path: <stable+bounces-230609-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCXMOHFQxmk2IgUAu9opvQ
	(envelope-from <stable+bounces-230609-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:40:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41770341E00
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 10:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BBDE3152A93
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 09:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9E8194A60;
	Fri, 27 Mar 2026 09:32:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230129827E
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774603925; cv=none; b=Ohkxhi2J44c0+nesgG8tRv1Or3QwVDFCYGMJFl9bTAU8eFlloAKP/ftbKQycM0Wa2N1nn3P7dvJuuAyqKKlzaePtoDvbagqmpZrYkmtrexQp1i0g55hvoLwiUEa0f4jLGHas2TKvmpbeFsxjgap311giinYJY56zDci1uk7hn10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774603925; c=relaxed/simple;
	bh=LC3XJqQO6ogN6D+P2sYpfny4MlGSBwxnth6zslNwYkw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hUKbB5pYnv7grq64uIpfsBwLbe+4dL1Ve2waA8B2f9TdoYsSFqkuW7R/LXa0mKdeim4AYFrXjCmfiD9jC55Y/y5UUyCsKhCGFLQGTHZlSHGxAptTHCh0AsDLdT3TkdPgj2x6AmZJzqkSsaQ8is203Fx2wtjj93VMXfSsd5xfnN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67bab42bbe3so1922687eaf.1
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 02:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774603922; x=1775208722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2FqHJq087MePJDnyS/wkwxervkU82LVSfXfQlx4yrBc=;
        b=s49EC+9QhKRZ9BPrcZdXwPjHjcuhKqZh+2BwL+G6/JmUg0ASob0zY5SMV1agxnccEY
         vYwJRSec3oqnhjc03MvcsFMl+47GstfId/QMjGKS4a8soNo5wooA00T2VGTD0OrPqVbZ
         bFYuG7/iOk2Hd0j7I7FVXcGAo0xftA41fitYKpPpa7k9J0LCmJANCuqNe6o23gEeMNuq
         OB72O2eI/rTYJgXnW8aef9hsnA12z332TScmaHZULWB4MMnUB7E+WkvOsjPNYllyQS6t
         +Xi/Yh2JbCN76ucJZBOD9Kd0qjvBKfjV+MmaD879PLorugXLrSmIVLa1SqwEMhpaxot5
         HiCw==
X-Forwarded-Encrypted: i=1; AJvYcCVkVjrx7uMFFDY9NOB1TSOyVP8sdnRXFTIvGoNhx9qZMvAfr/845/rb7S1jEnEO4qNdLcq13gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNi1oZJ5w8/Bit2E2XNXT7puTkiUkpw4VIRHIfnyLgZ2ZEQf5i
	99cmHF/4I/ASgs24ITEgjTWUaSD1S44XMtPwn/rVYBKOz/2Vy1v26GurxpvHxo26HaXByB+q/+3
	zYLinSxSgRSSpAPa46miI6WCwqgQXgxBHQdBEi2GDKRw3OP3BnQllVrk22ys=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c15:b0:67c:2c83:acf4 with SMTP id
 006d021491bc7-67e1870c298mr807786eaf.39.1774603922607; Fri, 27 Mar 2026
 02:32:02 -0700 (PDT)
Date: Fri, 27 Mar 2026 02:32:02 -0700
In-Reply-To: <tencent_2AE721E935EA3B467CAF450ADACDAB5A3B0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c64e92.050a0220.37d09.0001.GAE@google.com>
Subject: Re: [v6.6] kernel BUG in ocfs2_remove_extent
From: syzbot <syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com>
To: driz2t@qq.com, stable@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=cf30d9e358c58220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230609-lists,stable=lfdr.de,1dd53396e7124586dca9];
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
X-Rspamd-Queue-Id: 41770341E00
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com
Tested-by: syzbot+1dd53396e7124586dca9@syzkaller.appspotmail.com

Tested on:

commit:         c09fbcd3 Linux 6.6.130
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10410116580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf30d9e358c58220
dashboard link: https://syzkaller.appspot.com/bug?extid=1dd53396e7124586dca9
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11cf706a580000

Note: testing is done by a robot and is best-effort only.

