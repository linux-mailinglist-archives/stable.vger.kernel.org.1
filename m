Return-Path: <stable+bounces-238583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKKnAK5o42n2GQEAu9opvQ
	(envelope-from <stable+bounces-238583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:19:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB109420F26
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 13:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A32F301070F
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64622BE04C;
	Sat, 18 Apr 2026 11:16:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582F12AD2C
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776510965; cv=none; b=SBfFPPM5bknBj9+I9DjYgHSh3e2kXt3aWhUGoOyli+dpVet19LPAcBwqi06L5QDH7nYBbBS1lSm6DF7aKDmDcobCGMPi7ttOnwH2mcWyOlEH47KUk2imtxdKpavwAGJ+E2UHjH2nba3u1yPXkS9WnK2P28hpwIpJaGxoZYnLdtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776510965; c=relaxed/simple;
	bh=EnXuC2aIgj/DYCXF6jphd+aNcLszzhtH4ur7BhrVnN4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QwNPdDvcr+STLCqdVwRAcYUVzzzUGjL7CUTm0fHu72uOOoTmeS/5FMBFGVkA3dcj3+4gfwplDeoDaRJ6XNnViy+ungXtKSVHKZ7W17GybiPzg0CdlNQZe1e+NPe0Abtn9DXY3DRfSijdBqQW1sN+1D8OdEgfWtYSEAWX8NmSZgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dbc56f5290so3955886a34.0
        for <stable@vger.kernel.org>; Sat, 18 Apr 2026 04:16:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776510963; x=1777115763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BedyzC3R9sRzp33Yy1+22zl7QgnAOKK0zGsbfvcUni0=;
        b=rb43ClGEWwkPcvea8OqoKLVEHDX4z/Qn2QQeUz4j2WTglmUvIFx8zEpkZYWvQ3xXnU
         9rm/h0lnd7qkG0oQrNcgCCPSuNYxKEDTY7zd0mqcHVIVSFMHZk4p7ZK7AqwSNAVh30MB
         u6x+Pctg3ulSrRPDt5WYRpqE0Ti4xN2MvrI2iYo+beNXgsJGRFL33VIHl51ozowtSsfp
         In+D2RKaLAY0ssYM6XTl6wNpGrqRkNTFzaEBeyjkTbBpb3wzLYe7BPdy3qbZnsfx3pK5
         o33sPZfqVr/Jkb8BQP2rqfRgcDd3THXG4N9yTmTuV6tbUC6GTa0u84tufvktKjqKw9PZ
         zsqw==
X-Forwarded-Encrypted: i=1; AFNElJ+KCwq7bYvHn0nK41qcM8A/Kahcq6woT3fpOnK75InCGwuRAvRPEsWJfDoMqeYW6ouHkPDVAEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAE56UYO5InzOc7YvpL6gIVSYZRl3Kkzy6tpLz3kBEBNUSdcQ
	pgYl7LWyaf7R0ty/eOWgVTQx14Ipz8wgOUpajiADQk4CaucfjejIU3fxeQ+aAYpk0/1m9ewIOlU
	Y4i89ZidhEBw800QXjyNP13T/L+rRBw63o0DL1SYd0Mmt9qKcq06bC1dz3ek=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4cc7:b0:67e:2ff7:2a6e with SMTP id
 006d021491bc7-69462e5e0e4mr3579217eaf.18.1776510963443; Sat, 18 Apr 2026
 04:16:03 -0700 (PDT)
Date: Sat, 18 Apr 2026 04:16:03 -0700
In-Reply-To: <tencent_989CB790921B3B1D37BEDB2231ED08549F09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e367f3.050a0220.24bfd3.0004.GAE@google.com>
Subject: Re: [v5.15] KASAN: use-after-free Read in __nft_trace_packet
From: syzbot <syzbot+2a8850ea36efb12f5aed@syzkaller.appspotmail.com>
To: driz2t@qq.com, stable@vger.kernel.org, syzkaller-lts-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4d3fd5cca89ae935];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238583-lists,stable=lfdr.de,2a8850ea36efb12f5aed];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[qq.com,vger.kernel.org,googlegroups.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: EB109420F26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file include/net/netfilter/nf_tables.h
Hunk #1 FAILED at 1338.
1 out of 1 hunk FAILED
checking file net/netfilter/nf_tables_core.c
checking file net/netfilter/nf_tables_core.c
checking file net/netfilter/nf_tables_core.c
checking file net/netfilter/nf_tables_core.c
checking file net/netfilter/nf_tables_core.c
Hunk #1 succeeded at 244 (offset -10 lines).
checking file net/netfilter/nf_tables_trace.c
checking file net/netfilter/nf_tables_trace.c
checking file net/netfilter/nf_tables_trace.c
checking file net/netfilter/nf_tables_trace.c
checking file net/netfilter/nf_tables_trace.c
checking file net/netfilter/nf_tables_trace.c



Tested on:

commit:         3330a8d3 Linux 5.15.201
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d3fd5cca89ae935
dashboard link: https://syzkaller.appspot.com/bug?extid=2a8850ea36efb12f5aed
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1192c1ba580000


