Return-Path: <stable+bounces-213349-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMnXL9TLgmkYbgMAu9opvQ
	(envelope-from <stable+bounces-213349-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 05:32:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07897E18D4
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 05:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5113D30C271A
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 04:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F756334C11;
	Wed,  4 Feb 2026 04:32:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58D534DB56
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770179533; cv=none; b=p791WMQbK9HQS8CEqr8r/VuekrLZmswebRxaeikZ/WLjCbjgobUtfzDIXvHnTY4f+Ss6cVXpS8WHQ3p6lGOuGgenwfrjpH0JJgIDgIdI+vNv6JtFdyNe8M+pXdqEPMqpGgr9i7loFKSBVcre3moQsVX3Qq2juJBDiDehNIjMjSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770179533; c=relaxed/simple;
	bh=X1Kr1OyHHYSD1JHZHZgyBsiAnsBVF3CxR/1W8MyYNW0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pEJS8FE2HAvTXlyhUy+ZfMVLoxJUg4F9KvYl3WZZKmLQKibcSfTT+yOz37j1EyXEiniNIaEirLMaccnU0zDUmAgUACEOJvKeopBDhFjOIuN6Ny5V9+Hz6nyXusRYu2rxMJ2N1PuR1il8pKPu2t/a7WLjBwj+e8rsUttSIFXXzss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-66304fd62ebso2077352eaf.3
        for <stable@vger.kernel.org>; Tue, 03 Feb 2026 20:32:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770179522; x=1770784322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLOIj5H519mZHspqU5zX/aCaORqG7D8dhrXyLXEpUVk=;
        b=N9bPtb5lmeI9xTYd5LBLAcq/GO0+odJRSghHa84/xCtMVLbjr4L+rfBNh6mH3RvcDy
         uhwf1Gu3GszVT9/lHrUi58yu64RrD71wBhhQOY5bUp/oOG8B9rAz3T8jbQsuMp7LJQJS
         Y2LuwrYDu9DjnLZB3z5i+I1rFWWH3YY6xwpeqkwCmKHfC+uDAMs330qtQsib2zblF+co
         HsFSFWh4EIwRAua8UENzymVX6a3klvG1+/sPhzyEaSR+8x/CLSmHmsC7Wn8gDfuquGz1
         MphchN+w3ABAcxnGYXqWySZjBU1QjlZtahzkAl1gPcWnjJK6MKSwESmjJAN4qCYCpJ3A
         uO1A==
X-Forwarded-Encrypted: i=1; AJvYcCUZzhMCTpyJFyKwhM6KxILTYTRLnDBmas919y6ZLZjih+HGnDBRxF2ZmLyfpnqBDkYALXqSXmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr2dA31a+wVPVmpSHMrChpYYYau8ng7if99LcBstrgjmL0jM1H
	jFTGxtutO0VANmCcYibsPy59F3Xxk7tmbwgQz1qdVWE6zxsotz3k6KesEM0VnOQ5esqOrVvh9kA
	Va8bqU/t/6CkDC1dHB1cbLv6sfGH3RfnGCc9DoKlbj4oqhcJgZUnyQ7VETqI=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2291:b0:662:f74d:69f5 with SMTP id
 006d021491bc7-66a2113d4bamr1021474eaf.31.1770179522145; Tue, 03 Feb 2026
 20:32:02 -0800 (PST)
Date: Tue, 03 Feb 2026 20:32:02 -0800
In-Reply-To: <20260204032856.2561-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6982cbc2.a00a0220.37c87e.001b.GAE@google.com>
Subject: Re: [syzbot] [sound?] KASAN: slab-use-after-free Read in snd_pcm_stop
From: syzbot <syzbot+5f8f3acdee1ec7a7ef7b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, perex@perex.cz, stable@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com, tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=151a39927f1e10b4];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213349-lists,stable=lfdr.de,5f8f3acdee1ec7a7ef7b];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[sina.com,vger.kernel.org,perex.cz,googlegroups.com,suse.com,suse.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 07897E18D4
X-Rspamd-Action: no action

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5f8f3acdee1ec7a7ef7b@syzkaller.appspotmail.com
Tested-by: syzbot+5f8f3acdee1ec7a7ef7b@syzkaller.appspotmail.com

Tested on:

commit:         5fd0a1df Merge tag 'v6.19rc8-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1582153a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=151a39927f1e10b4
dashboard link: https://syzkaller.appspot.com/bug?extid=5f8f3acdee1ec7a7ef7b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a30b22580000

Note: testing is done by a robot and is best-effort only.

