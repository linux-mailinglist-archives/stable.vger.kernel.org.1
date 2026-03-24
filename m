Return-Path: <stable+bounces-230149-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK6eDIuAwmlneQQAu9opvQ
	(envelope-from <stable+bounces-230149-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:16:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24576308044
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BED9F3013C8F
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F97D3DFC7B;
	Tue, 24 Mar 2026 12:01:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF9D3EF0D4
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 12:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774353667; cv=none; b=AGo/mkjRGFHFHOxhTZ1AXfn6ovZX4wSnRpmrkzWK41eECd3J5gZBwr2uSrdKHmSXaDB3WdpfpKiDMH8/YmKNXl+KG9jjgxOk+DkfS+9TezMYwjSXXSZE0/nQJ/oGIYIujj2s+JWk3N2chMiLgLsVos3xBbhyZB+j7CTl2OowfZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774353667; c=relaxed/simple;
	bh=NZdgAdznHpDbsb0SoRtymRAclQN4M4YzjI0NpfykQW8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rt8bZ3Txd4a5Dtpv8JWQzOkDvB24f87Ib1bGTuVJASa3BrkjEr967iPmo0HjqCXbsvWlMDVfr4VbwyZHEGKKWWL3riFHPYtFOolTzOBxgAgstFZZWtd0AwnHtmpPfy7kq8u0kug8d81YO3Mvqp8VoBXIxPUnldiefcHtu1Ho9Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-463a075e177so16945278b6e.2
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 05:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774353663; x=1774958463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eq+NSgDd45IxmtwonKl+qVks/DSrzpVI0yR9kUnzlGs=;
        b=iFOF/hDFBv43Pk64pqIz5zn1jltT+a0lxsqlc+Oe1ZbBtD+Y65vle7m91SiDLMWKaZ
         Lrl2drFbWrrcIePGKfdEJa2pE23Ye5kJxscBD/ctC9eiGZbFw5MUuf6/YE5XRnGfRFS2
         /csWkhnWdNq1gJRiYyx9BhuAGE6kLHRdgIZIVmG3dv1L1Ww3NACqkjMlIuhYhLbIfRoo
         TuQFK74bRoz/IAsqtOoIdIm8px/lftZJ6VkGuMyH6MMo8LTMwcSZ9oAfpgE06aUuGSTP
         cdF5lFllycdT2VZRGvyEZsBm+TsP1jljQQJpcmSfRGEDobtSflQCF+2BpythmEr7vPXi
         zNAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW85RoONm/YOGmpv1FsoV2+lpeTAiCe2t+VmGmSzjmVWYbv5mPRQlo0UrRHkpaPJGvN69mZa3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDCjFJS4tdzdlL72Eh8G+DTfkUFEtZaF8c5Yk1zUBNV39xr+A/
	PMGObiW5F/C3DDpINVtpxxtOJHLC/A2lGkqSm6zSvstPmFrkvYvZUfirNGOEnLkWgEMPGHFr1xV
	sZHgSeo7KS86WW3xHjO59wIIt7ZID6XT14/EajSqL5TtyCCu9NMmePQvzs/Q=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1a07:b0:67d:e505:cf5f with SMTP id
 006d021491bc7-67de505d224mr6123511eaf.1.1774353662909; Tue, 24 Mar 2026
 05:01:02 -0700 (PDT)
Date: Tue, 24 Mar 2026 05:01:02 -0700
In-Reply-To: <f75eb907cfe0944a5cc3bd02d137fce8.junjie.cao@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c27cfe.a70a0220.59f55.0006.GAE@google.com>
Subject: Re: [syzbot] [nilfs?] WARNING in nilfs_ioctl_prepare_clean_segments
From: syzbot <syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com>
To: junjie.cao@linux.dev, konishi.ryusuke@gmail.com, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, slava@dubeyko.com, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=a1eff8566a28238e];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com,vger.kernel.org,dubeyko.com,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-230149-lists,stable=lfdr.de,466a45fcfb0562f5b9a0];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 24576308044
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com
Tested-by: syzbot+466a45fcfb0562f5b9a0@syzkaller.appspotmail.com

Tested on:

commit:         ebd34541 nilfs2: skip blocks with no bmap entry in nil..
git tree:       https://github.com/Lukaaa525/linux-kernel.git nilfs2-mark-blocks-dirty-fix-syztest
console output: https://syzkaller.appspot.com/x/log.txt?x=1100d6da580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1eff8566a28238e
dashboard link: https://syzkaller.appspot.com/bug?extid=466a45fcfb0562f5b9a0
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

