Return-Path: <stable+bounces-230674-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPuOAiWaxmnrMQUAu9opvQ
	(envelope-from <stable+bounces-230674-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:54:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112A3465F7
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 15:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2567130EAEB2
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C2C308F05;
	Fri, 27 Mar 2026 14:47:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D6822301
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622824; cv=none; b=YHOcegIK0NhAN1zapJgjturV4uss0ieUcfhS8oGp8kWwCApJeMweD8DEW8G4t1en3zl4WBhUxtib3mOScOBbemRES7xEmB5luaifMU82tvKkVRUyMHF0h3HGa6ESFJoHuP0fGY4RGospV+sYBD4I0TxcYVRPycDxYsTpqDcG9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622824; c=relaxed/simple;
	bh=WLn2zyW3Cjz7444yP7pGewGQX/LINt903vkH9AyGBJw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pdvM/RrM5DNsXow409SlrxjzLHlbsGua72pHgMqPtPCtXpr6yQbB+d2sKF/WiLmBrhWMmL7ZuHEQOYz4WSLjHUNWJVzrjtCLgnTRabNZFrMyLxztHTT37/VNdUL9cZjKNf6cvaT9ewYwjUT/nXklEhUE3nPCh0NdwCxgdnHdCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d7fd0be5e3so7489438a34.0
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 07:47:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774622822; x=1775227622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PTvUe3C4NBsmSPFdJyRs/yi9faWxyh5kdUzFjrKZnA=;
        b=WkUy4spy8D5FCFIoH7uTeNYC2Jges3u6L+4ebO5FDQT45ZI3BLSf4npgDmaOqbFCnM
         uOt4aiZLwiVXETGRNIqHAftiyE/lsHfVeg1yPfH2Ex7vdQO2/H9p2gtFy712C/4RXoIY
         MUHL/Ii9ac5p4k6FqEctdl9HOlDyIwATjfrFzpjvfqThtywtmdbTe53sKoyTYEVEfT1p
         HBydjio2BjoFQWiKvEuYVBZjTThlcdzM3T3xLSApKwDg3SNvtHFqPEt3wY1kSeYNabv/
         qqria55vM3SZwelcOSdxb0RVz+5tOFnfyuMHDhq39C/bAXqWz53DqK4x9KigHQWBmBIc
         gf8A==
X-Forwarded-Encrypted: i=1; AJvYcCUXdlYfxOQihg6+eIukIDmomjHDh8wIFzgyWTnrty9hVwH7ZHYf9kH413OarzW/3NdeMjoL6Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvY7gxLjBjIQNM7g7c0KncsAL+yJ1SNk89bHrCTVsdhMtkQis8
	hBCX9A5SyT9LIX0p59ZjOGmqNuziJ3ChubtYgjJD4M0twspI2Wb3WYyblXGrczlxdKZ4g+brF/B
	qmZbTCnMcrRuWoI0mAprEE2VyNt/0kTt9S4s/Y0Pl8KfiSltcbcxpfOyQp+A=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c2c8:10b0:67e:17fc:787d with SMTP id
 006d021491bc7-67e17fc7c70mr945812eaf.18.1774622822337; Fri, 27 Mar 2026
 07:47:02 -0700 (PDT)
Date: Fri, 27 Mar 2026 07:47:02 -0700
In-Reply-To: <tencent_3A22B535EA39B67E9B4402D84DAA4E3B8B0A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c69866.a00a0220.2a1a21.0005.GAE@google.com>
Subject: Re: [v6.6] INFO: task hung in iterate_supers
From: syzbot <syzbot+739c128b5557abb9f816@syzkaller.appspotmail.com>
To: driz2t@qq.com, stable@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=12606d4b8832c7e4];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230674-lists,stable=lfdr.de,739c128b5557abb9f816];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,vger.kernel.org,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5112A3465F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/9p/trans_fd.c
Hunk #1 FAILED at 654.
1 out of 1 hunk FAILED



Tested on:

commit:         c09fbcd3 Linux 6.6.130
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=12606d4b8832c7e4
dashboard link: https://syzkaller.appspot.com/bug?extid=739c128b5557abb9f816
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14523752580000


