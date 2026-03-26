Return-Path: <stable+bounces-230497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJrlKL5fxWlM9wQAu9opvQ
	(envelope-from <stable+bounces-230497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:33:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBD333871E
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 17:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A92730078E9
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 16:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD225378D8B;
	Thu, 26 Mar 2026 16:24:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CBA2C159E
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542244; cv=none; b=cdw2TcQZHeuQkmJReNjGUID2bgEBjuGBZvBrvlvu+GJlnvGHdrPD1bPWMQisB4+uoMAvD/9EojvPEeGc2UUNx2iHDx0imnrvhTQNTp+Hj9UajVvsOe8yy05mkNt+Lr8U9/FC1WTfcfvs9/pJ3jZWDqLnRJn4hlYIVueF2OZ6Fio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542244; c=relaxed/simple;
	bh=L7LNvDq4AUcUdqHRyD+lIdXTRgeNIijGF3Oy157VxMc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GK/9EjUi9dkqVFmuOVFJWxC4D/MEKdQqbNt+0Xt+D1Q+xraaWWSa4T8nxRXJf72xaJh3IAPD5GCjN5U4tWTzNGPp7e/8BPl4p9l9Xz3LPwm14mhFoylb35a48d4w58DsWQqwbDrFySHZJGf8M5sIaVFJrydDmTOPcmmOR/+UGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7d742da766aso1327815a34.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 09:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542242; x=1775147042;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ImvSPyERfdEqrQKC4pMRwk+S283WZdaufCsfCdJTq4s=;
        b=pu+BjEKwdq0EMBBHDXghuL/EOU6HCOhY1mhQvFISz3PkFKFLlTm90KEtzCWt+P9afY
         SpB/SyVnIZHsiR+8opwQUwFus81BG//gG+7pArcW+Hi/wPOA4H8jCWb3UCPA33/J0xXg
         JNm4axWbYZTfUmN2N7yyMrQ4qXw8YRFPGRs5+Uyq6ik5g5IYGOsHOmWJP2Ep2N6TvVne
         kVapllF8QTYhSQHCUabIuXcv1F9oUpzQjvlzNmkTxe5p/O7KzWL7T6W5n+5FoyN+WN23
         MG+z3e5fdoyaDsmITh1zFJ2lKCPOS6Lxlx0gmI0F/I0mnigCMb+PStSHRC+KUYCTX2gu
         R3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5YMOjiTo66HCV9Iypdo6Cuc5kVCkN2wY+U331YP9F/+++59Ge5bO0ULgJt0Kdp96EKLFu3hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXRfxObNL16ke1BBO0O/Oo1x43+82idQMqHM0CnVKkJXiGdBz
	MjlBgsZ9UbniluFVHUc+pbJcl/XlMOcxalw8ySCwF0XbcH2l7Bkt+5PTNBmiM3avJ0iYbGOuQxw
	s+yVaJExUuzLdopDsKkFvpU9jzvQ8i/eTJ25NPtJND0SKHDkxHee/Xqk+U9g=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:80c1:b0:67b:b872:7661 with SMTP id
 006d021491bc7-67dff39e383mr4364539eaf.13.1774542242392; Thu, 26 Mar 2026
 09:24:02 -0700 (PDT)
Date: Thu, 26 Mar 2026 09:24:02 -0700
In-Reply-To: <tencent_9C8D328EA8DF5C919C7662AA3CCE17486908@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c55da2.a70a0220.38a0e9.0003.GAE@google.com>
Subject: Re: [v6.1] BUG: unable to handle kernel paging request in hfs_find_init
From: syzbot <syzbot+7c669e7491fdbacd64b2@syzkaller.appspotmail.com>
To: driz2t@qq.com, stable@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=b1adc0bfde2d8a4a];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230497-lists,stable=lfdr.de,7c669e7491fdbacd64b2];
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
X-Rspamd-Queue-Id: ECBD333871E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7c669e7491fdbacd64b2@syzkaller.appspotmail.com
Tested-by: syzbot+7c669e7491fdbacd64b2@syzkaller.appspotmail.com

Tested on:

commit:         f2ddafa9 Linux 6.1.166
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=158e8eda580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b1adc0bfde2d8a4a
dashboard link: https://syzkaller.appspot.com/bug?extid=7c669e7491fdbacd64b2
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fd1cba580000

Note: testing is done by a robot and is best-effort only.

