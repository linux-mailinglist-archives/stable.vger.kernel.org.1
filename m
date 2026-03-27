Return-Path: <stable+bounces-230681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGzvIeOnxmk4NQUAu9opvQ
	(envelope-from <stable+bounces-230681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:53:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300DB347062
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 16:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24C98304052A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAA42701DA;
	Fri, 27 Mar 2026 15:53:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076F930FF31
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626784; cv=none; b=ek4ai5jgNZ4Xd7GNy1PjGd9qXUSXMwYUewHXwb8zO2NUYl3FiP7XPlwiJ39CDVI6AwOoyDK57s2ACrHttShDnoxlsKU0y2cr0+NLFSmmjfpObIRg5wsjlQYsE5/xXk+c9zBuzF2dXJ0O8QoeSshpj91P57R/zJ41liSkRCQ7418=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626784; c=relaxed/simple;
	bh=sqgD7n4E+G7kK2FLGVJgfjwEwXLTfGdlhNtz9eFPjwI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Kxegq0xI6xYmjM5iB4xH1V0EhM1jiKh0rq3qTGOzVKwkqOPN+DZJe6ZCHqvQqsa74YTY1OSqaidB6DVsemuscfBVGL65YRIiAczNbx7AKyrXMfyT+9X4fDVK38WuOy98DWn7SElTENlvq2egGKI5/C+nUoiCDQvHBQB9XqzIulQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-67e0df20fc1so6442721eaf.3
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 08:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774626782; x=1775231582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97gkp0zqpKahc3g/30i80ImvAreG2sOY7hRSIoyL5n0=;
        b=nJCFMlAj3ylBhj/fhj+oO+kiV8G1PYzFrU0vKFQCIsV2mm0A7WgJfTN3u323WNKfm8
         5BRxaVNExalyIw5uz0oXA/o3i3pKRyXW/gMIcIhMggbRwRjBtDxo5nfc6Y27UQaAQnqb
         zWl7kUbMKvoy1OCxsKxnGwq2TSKZKylrdk/yGdZIm9nEAdvMnLsOFv1ouAu0LOHWbYTY
         G4PFiwBE5rY5HqKIb4Y5MhZLs686JDXWuQCDSBR832afwvjfrmjWMm9KTgrWhRRExLNV
         hkRvmBIjpytoZ2Ys8jrw7ajjGJ0jEL3YsK4RaHBGC6RTj6hRcdreeXfIRwEfj4Acnrbk
         vkHg==
X-Forwarded-Encrypted: i=1; AJvYcCX7FfPQXtvF+CDaxxTM8teruWsqRdQdAohTu92Z3MOUsORt8I9WfMZ7+oI0sGyY7msfppXQneY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdxXAvwSUTLapHrqAQZOHYVLQO/+wVWdduybj4HOoHk6eEigg4
	9iYDOyrxa4/h3IZFwjt6ozwDhmQVYJqE+pZDmWWd1HMjCBbHsyGTAvQqMlDCJsnfCUK4BQdP4W7
	8bh9KQJRhNjxyuvYx5i8lm8p3ovNpU44DycmL7DTHqZReP5ihVix6kLgMt2Y=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c89:b0:67e:d62:3d16 with SMTP id
 006d021491bc7-67e185dc374mr1595957eaf.12.1774626781960; Fri, 27 Mar 2026
 08:53:01 -0700 (PDT)
Date: Fri, 27 Mar 2026 08:53:01 -0700
In-Reply-To: <tencent_3E39327F0345F6D90DAB823B4B23D1357A0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c6a7dd.a00a0220.2a1a21.0009.GAE@google.com>
Subject: Re: [v6.6] WARNING in em_nbyte_match
From: syzbot <syzbot+aa4eb7c67913dbd88f56@syzkaller.appspotmail.com>
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
	TAGGED_FROM(0.00)[bounces-230681-lists,stable=lfdr.de,aa4eb7c67913dbd88f56];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 300DB347062
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+aa4eb7c67913dbd88f56@syzkaller.appspotmail.com
Tested-by: syzbot+aa4eb7c67913dbd88f56@syzkaller.appspotmail.com

Tested on:

commit:         c09fbcd3 Linux 6.6.130
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1440e1d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cf30d9e358c58220
dashboard link: https://syzkaller.appspot.com/bug?extid=aa4eb7c67913dbd88f56
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12692aca580000

Note: testing is done by a robot and is best-effort only.

