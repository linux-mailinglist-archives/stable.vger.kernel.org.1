Return-Path: <stable+bounces-230150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLLjEXqBwmlneQQAu9opvQ
	(envelope-from <stable+bounces-230150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:20:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A55A308110
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 43551301F6A3
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374A73EF664;
	Tue, 24 Mar 2026 12:07:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE043F2115
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774354030; cv=none; b=IElvGBBRD+NDZ2PS0gAP2Svc6frqWbliHt+7L7J1xfzdpOs41vU4k2yfhxMBfy+GVqoZPc4PjotOCh+8uKMcFL5HKN7/H1KapyuTlpnnuk6A3K5q3TziR82701BcBGwIGnSups/Hxsyt/I/5YN3fXhErjlTBipjY+TzFdPfh3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774354030; c=relaxed/simple;
	bh=8KhT2Yl3FaLIOu9OEcdh0OB3bMg7pUkmy0hXGQmb9dA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=H/8wyIw2b6v8LQjnyf4RwL2rfLkcYRCAVjOJy7LGO3AYqWuJ4I7yFQTwQygPtjMXGtDCM0DO94rTrC68BKJDmQVqovoU8RiHvMnVVsDQuqmiRF87xIfX+D/phDedT0mLPZ7j5ScjjR6yKQolnqkTt6Vkfk4bsDDEA1gyrhg3JqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-67c30448569so27862216eaf.3
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 05:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774354023; x=1774958823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D16S8pxbLW4cIgoxLHHfv+nGcIkMFJSxbQ642clp/Kw=;
        b=h6lnCvEH0EiVGBUXrvm1rNVKkPX81ANgPjYVDTACTEqePMNDjVygOE0/f5mBxjrmwT
         HaD8RFKfleJaMJddUXI2UWbtoOvoYMmxBC1CLAUlPMZtIxYgHWxrY2ukLa+B88+P+gzq
         ojsJM0jlZJUQHbM1tDZ5f3RsAs/GLJ/JqOuUGkSCPajUuatK38Nhcm3VkKNWy25/QVJJ
         rGZJ0/MzeKWguvAfOVmqpLyY9xkBUwhsLQIVqHg9PzRDj2/i7L6enRjecvlx4UcyrsQd
         48S1bY/mYSOpI5CBg/wCDS5mSi51cneGsOgDQUpWqHrLkieL4o1cCz+WNPQBuZAYogAw
         IGLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxZIPKab3s6GMvKX5Ymu3rAxxd8GavFXz07AHeGusGBbtjW1AqawApK5sk2ziUeubOA7ADPDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyN0ipm3q/XYKvtglvatD8XZ0453kvoppKMCW2nAhS/hfQk301
	wfsAsAKNY0K4/6YjOZIjarabzQHSmrwiCFvh0FrJBAN239r1xNsl1RWbWmjQy4rgA50jhpyK652
	2b8YlKReZY+RGczs10BtOhbnC+e8p8HXnvuyA7o/hRBJ74mK4gcwHCv2QSWA=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c99:b0:67d:ea9d:c89b with SMTP id
 006d021491bc7-67dea9dcc27mr5850367eaf.40.1774354023393; Tue, 24 Mar 2026
 05:07:03 -0700 (PDT)
Date: Tue, 24 Mar 2026 05:07:03 -0700
In-Reply-To: <tencent_98CE0848898D658EF0DF2091F876CCAAAD08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c27e67.050a0220.3bf4de.00b1.GAE@google.com>
Subject: Re: [v5.15] WARNING in iomap_page_release
From: syzbot <syzbot+c0ffed3897231d71f047@syzkaller.appspotmail.com>
To: driz2t@qq.com, stable@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=30e28339904629ca];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230150-lists,stable=lfdr.de,c0ffed3897231d71f047];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,vger.kernel.org,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 4A55A308110
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c0ffed3897231d71f047@syzkaller.appspotmail.com
Tested-by: syzbot+c0ffed3897231d71f047@syzkaller.appspotmail.com

Tested on:

commit:         3330a8d3 Linux 5.15.201
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16f95372580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=30e28339904629ca
dashboard link: https://syzkaller.appspot.com/bug?extid=c0ffed3897231d71f047
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b4506a580000

Note: testing is done by a robot and is best-effort only.

