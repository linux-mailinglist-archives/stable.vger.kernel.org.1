Return-Path: <stable+bounces-241981-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PfKK92/8mlbtwEAu9opvQ
	(envelope-from <stable+bounces-241981-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 04:35:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5591E49C644
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 04:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72D1C3003D29
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 02:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C56C2853F3;
	Thu, 30 Apr 2026 02:35:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7281175A66
	for <stable@vger.kernel.org>; Thu, 30 Apr 2026 02:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516507; cv=none; b=j/6R45LWVgaWTPY8gE8Yerx2fm57xnoWUxVBW7pusUEqFqXnJ1KlSYc9kfLrjXAQHhMV+tWRaXmOp0a10KHN/liNoOczO9SUDnwljOnqP/5CDXD5vvtlZISA02Dt9D4G7fuqzDRbmWNRs2bCzbkLAZFBYYMEjEDzu7gsBFsLir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516507; c=relaxed/simple;
	bh=8DEA2aRyzP2Fnf49B+ukwQtQUCgH7uiQmXfxGvvbsJ4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F/qoSVqKFkt62sDbZEpbvJREY4xYOKJptOtADLyMczbJKV4BoQnBWZiOZjinfge+ASyg0kBMvsIVCDkzldFSA2xxeHVgtl2cj4aHIbItM8XYroGAHwwD4AWivLSr/oJeZwkzjTD4KarRtvLsYB7yKEV6f+zpY1Q3iEw4BkaSkUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-42393e9b4aeso477251fac.0
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 19:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777516504; x=1778121304;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B96zDusVi0q1sx9OddYwwyruOohvZFwt8ueENmVTnaY=;
        b=k46thXhtZcRSEIAUX1R1xaK7UUjfcSZoswSG15G8kaIemu+ZdBawN1HXXnUaBqT3kc
         rnPpQTJhcQsLMCJHU2Eeiif7E5AeuIEYRAmzf1mMmWl24nxWEffw4HS/K+l6fsFeNk1Q
         zAZWLXmCtfcOCgidILJHoqIkaDjZ5IQpyeQPY2SEicKCzszLiyp4jCjhA3e2orIUCyyE
         LjYzAdzf5YrDWSvZ1FLdRZLRxDngOAofSETWSp5ThjMZEPgfLJ3s16T+gRUWFF7AANFV
         BCfAAJ8m6KBjC9LAbp5fKGGLvpzyNLO94bMZJJrIZ0TRcPgBg2RH/mJ5c3jyVOo4WGgI
         cz6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+8mmZjQTKpT94mWiBOnDaDbHJGVMzzivSbzr+UJzvJXk9b5Xy+kZFlAlmrQnPlZjlp1683gLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOsxdD+nbfiZlXTGc+Mw3XACySArYDXGmSMt+Npynp0tP8owm
	0lbnEVYCHQACfoY4STmT0SllC+YmcXOTIVvzxACd57Z51tT/6B3Yucsiz22RtRDVtsFbO2IUqsx
	g3wD/vIC4rMdVz1wKpZggdpImQnwtwdEWVUm+qyDNvHGGqoMelmkt7xW41V4=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2086:b0:696:1fae:fb83 with SMTP id
 006d021491bc7-6967a5a88f3mr605529eaf.34.1777516504731; Wed, 29 Apr 2026
 19:35:04 -0700 (PDT)
Date: Wed, 29 Apr 2026 19:35:04 -0700
In-Reply-To: <20260430015847.110800-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f2bfd8.170a0220.3c4978.0011.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] INFO: task hung in nilfs_transaction_begin (2)
From: syzbot <syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5591E49C644
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,googlegroups.com];
	TAGGED_FROM(0.00)[bounces-241981-lists,stable=lfdr.de,62f0f99d2f2bb8e3bbd7];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url]

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com
Tested-by: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com

Tested on:

commit:         57b8e2d6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17f9d2ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=62f0f99d2f2bb8e3bbd7
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1735dace580000

Note: testing is done by a robot and is best-effort only.

