Return-Path: <stable+bounces-227984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOWgHhs9wWk9RwQAu9opvQ
	(envelope-from <stable+bounces-227984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:16:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0992F2A3D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8C96D3007A76
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2A43AA1B6;
	Mon, 23 Mar 2026 13:16:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF837C90E
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271763; cv=none; b=b7gdJHZ6XHyLUgYP9iP9E+3KdK+qnQ97muW7IjDkYr/ZO8H9Jtp0STfUgW1tHXcV2RUv83g+oZh3fOuk63JjHPTJOfcvLpZi/Y0KXg2W90IH+fEozz7CaQmo3OXSAF1NO4fxZtvf2cff0VIsc62DH7T6FjcanWiBkSMcuB99WFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271763; c=relaxed/simple;
	bh=DOwFkLH/+i8ToV4jvDsAIUid6O7sfAILwkfOY1slIQI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ihR2mdJH0r8VewLceu91KOJI2Wpva+jKRtJ90R8Lvq9iQ7/nJFgQKHZXgz94Q60yBtupTuIQMPPArmhDk3Sprt3g7xB6t1R0UT+BMgC18C+IQasubqvjuuVKs58mvJx9XDCRbqfrLOvBJjVJvd3rjWlrl3KlBVcMk1Eh/FEUiz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-467dc3431cbso14974916b6e.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 06:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271761; x=1774876561;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2t7ZxLnNlwk4M8+t5IiNuok4Xl5BTZRXnYsSVX/rUp8=;
        b=jhE3Yh40V9xnsRuKRJblhIGe4oMarSVkYM13v/hS/1Vzdx1AEprq6EtPYa2Vkw8wE1
         LreA9FbCi9MhIfpYzKccg/kvbGK1sTzGrAEYZufDYtKryKFDy43Xawgvkx5o5Mdl7Anf
         N5Pa5dKmaM6LPTdhrQDSwMRlIU4PaQ/XFV58+d9N9qM04bQv6UH904UUmVvXCXsw0xa0
         t9oLp917EHSm+rZT5SbombZZazs8qLEVoFTTAjWyj336LBfNpm/jXVZDEs7Nk4CrBHit
         uN6QFTzyLnraHmVocTKxKRVub59nMkn1vp/0H2YI+KXGBfyZfvqv4dx5McgFwO9WNpe+
         YcWg==
X-Forwarded-Encrypted: i=1; AJvYcCXePSQXXF+CQEuMs5G/dB5NcdT+Qb6MlLybKuLmgbvNLwoGMhs4IYYcWyPJwJDGx1OPwDkNFHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE9BA3MffIN6C6+gLO9RVWkwkyxm0akzyXMvH+rAYaDgsHDO13
	eHqHrvyMRalFXOFvJWjlZ/CB/jebcuMlMKqCH83ImLLjJGJ2orX54vuHih++TwnIMsFVZActXVs
	kOj1HGj3KsZPCDXhKxK5oktvcS5XA9ifU462W43ql7bfUIYr1HbbnDQ9v1ow=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4dfc:b0:67d:730f:25cb with SMTP id
 006d021491bc7-67d746e2468mr5453265eaf.21.1774271761417; Mon, 23 Mar 2026
 06:16:01 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:16:01 -0700
In-Reply-To: <tencent_7C51DF11EF9B2F12D8AE4595C0F91009A405@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c13d11.050a0220.3bf4de.009d.GAE@google.com>
Subject: Re: [v5.15] UBSAN: shift-out-of-bounds in ocfs2_fill_super
From: syzbot <syzbot+c6104ecfe56e0fd6b616@syzkaller.appspotmail.com>
To: 1016331059@qq.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, stable@vger.kernel.org, 
	syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e1bb6d24ef2164eb];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,evilplan.org,linux.alibaba.com,vger.kernel.org,fasheh.com,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-227984-lists,stable=lfdr.de,c6104ecfe56e0fd6b616];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 6C0992F2A3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ocfs2/super.c
Hunk #1 FAILED at 2369.
1 out of 1 hunk FAILED



Tested on:

commit:         3330a8d3 Linux 5.15.201
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1bb6d24ef2164eb
dashboard link: https://syzkaller.appspot.com/bug?extid=c6104ecfe56e0fd6b616
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ce97ef980000


