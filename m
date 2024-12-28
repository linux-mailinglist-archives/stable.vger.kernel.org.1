Return-Path: <stable+bounces-106227-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4719FD97C
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 09:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6B7188577C
	for <lists+stable@lfdr.de>; Sat, 28 Dec 2024 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2283974BED;
	Sat, 28 Dec 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V1h8P+w2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hpLyxUn7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YyRFP250";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WmvTOTgn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E45035958;
	Sat, 28 Dec 2024 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735374931; cv=none; b=K9Fs7ID6dz7MZKzrSoYVbNgjFrbI3tth44m594uWlyxF1haHXj60VWYf9nJ2ZfgI8/goWU8zjzorAAuoELdpWUDWCvqoWTRfMe4fjCwpbqzqcGUEfK5Y+dXXaCtMddKfXJPZ9sRmAszNj+WYJnRM0H9d4lAmu6t7VkewFcolykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735374931; c=relaxed/simple;
	bh=600y1iPDuHws8UWHjN0T9pv6olqM7xNHRHt/dexNv+I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGYOSvWKC9FytE79fB+geVR5sLwGd4OKInCBK7fs3oL4L3+Kz+N4Cm6W7HbmY4WdXq50ZljTNcSuIL5AgzcV4VOkdm2nUaR+uVnY4VZCR+Kc0IOiC1DkZviTQ3m9Jj56545bLA6XZ3gx1FOQs77fm1Wj5H/e963tPLBRFQCE+cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V1h8P+w2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hpLyxUn7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YyRFP250; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WmvTOTgn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CD5C437252;
	Sat, 28 Dec 2024 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735374922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w7x00zvYExEVFyoNj6VSoCdCegGrroRvQ4Yp3OmuPnc=;
	b=V1h8P+w2O7fnEjAWa5cGwkEd7n5ZHiUA3AWIIvJMd0/Z0cJMUVZV4mfYeHNXiJsZwxSwcA
	VrtFio3F3mLVvR3ssKFN2ww/q+t2aH0yUx+TFcrWkiGhV7RFaw8taEGqB79KurN6IQfARp
	f3jSIB2Gcg5IuEdnswgHBfGfS8psEY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735374922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w7x00zvYExEVFyoNj6VSoCdCegGrroRvQ4Yp3OmuPnc=;
	b=hpLyxUn7gsBbRD+5A/Gk5+D4hd7Wq022iYMIUYC2ml97HGUzb2+X2weVmyjBagEiVJmkEl
	Wy3H30rovBChTnAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YyRFP250;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WmvTOTgn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1735374921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w7x00zvYExEVFyoNj6VSoCdCegGrroRvQ4Yp3OmuPnc=;
	b=YyRFP250P0bBPAoWzS3powJG22l8GHW6BIF3GefIit59GD6uS/WWbIiOCzcd9EKE5na6Nv
	F8hHKOvdgn7up0YlL8Y0aaw2yKFmmpzMwKZjd/SidV5VIaht5VpkMJiAOGF+AodUbDpR+G
	JC1EgWXyd1z4ra/Fpla3cZJ7q2KMTdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1735374921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w7x00zvYExEVFyoNj6VSoCdCegGrroRvQ4Yp3OmuPnc=;
	b=WmvTOTgnT3j7VHSuPplbsZkEW9HNfJUaJxlBwcjMw0PERJ//Xd6djN3GJJSUL0+qa2UsGc
	CHiJbIjoEtl32LDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE0AC13985;
	Sat, 28 Dec 2024 08:35:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6jdzJki4b2dRGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 28 Dec 2024 08:35:20 +0000
Date: Sat, 28 Dec 2024 09:35:19 +0100
Message-ID: <87frm8nr20.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	vkoul@kernel.org,
	lars@metafoo.de,
	broonie@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	masahiroy@kernel.org,
	andriy.shevchenko@linux.intel.com,
	arnd@arndb.de,
	yuehaibing@huawei.com,
	viro@zeniv.linux.org.uk,
	dmantipov@yandex.ru,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
	stable@vger.kernel.org
Subject: Re: Bug: slab-out-of-bounds in snd_seq_oss_synth_sysex
In-Reply-To: <13599E88-AAF1-4621-94BE-C621677D9298@m.fudan.edu.cn>
References: <2B7E93E4-B13A-4AE4-8E87-306A8EE9BBB7@m.fudan.edu.cn>
	<B1CA9370-9EFE-4854-B8F7-435E0B9276C6@m.fudan.edu.cn>
	<A2D50A73-EF90-486F-9F5C-FFC4F0906A01@m.fudan.edu.cn>
	<13599E88-AAF1-4621-94BE-C621677D9298@m.fudan.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-Rspamd-Queue-Id: CD5C437252
X-Spam-Score: -3.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[17];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,yandex.ru];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,kernel.org,metafoo.de,gmail.com,linux.intel.com,arndb.de,huawei.com,zeniv.linux.org.uk,yandex.ru,vger.kernel.org,m.fudan.edu.cn];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,fudan.edu.cn:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 28 Dec 2024 09:07:16 +0100,
Kun Hu wrote:
> 
> > 
> > 
> >> 2024年12月25日 13:37，Kun Hu <huk23@m.fudan.edu.cn> 写道：
> >> 
> >> Hello,
> >> 
> >>> BUG: KASAN: slab-out-of-bounds in snd_seq_oss_synth_sysex+0x5d1/0x6c0 sound/core/seq/oss/seq_oss_synth.c:516
> >> 
> >> We further analyzed the issue at line 516 in ./sound/core/seq/oss/seq_oss_synth.c. 
> >> The slab-out-of-bounds crash occurs in line 509, when sysex->len = 128. Specifically, the write operation to dest[0] accesses memory beyond the bounds of sysex->buf (128 byte).
> >> To resolve this issue, we suggest adding 6 lines of code to validate the legality of the address write to sysex->buf before entering the loop:
> >> 
> >> if (sysex->len >= MAX_SYSEX_BUFLEN) { 
> >>  sysex->len = 0; 
> >>  sysex->skip = 1; 
> >>  return -EINVAL;  /* Exit early if sysex->len is out of bounds */ 
> >> }
> >> 
> >> If you fix this issue, please add the following tag to the commit:
> >> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
> >> 
> >> ―――――
> >> Thanks,
> >> Kun Hu
> >> 
> >>> 2024年12月24日 19:16，Kun Hu <huk23@m.fudan.edu.cn> 写道：
> >>> 
> >>> Hello,
> >>> 
> >>> When using fuzzer tool to fuzz the latest Linux kernel, the following crash
> >>> was triggered.
> >>> 
> >>> HEAD commit: 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
> >>> git tree: upstream
> >>> Console output:https://drive.google.com/file/d/17oCyKDW_kNhSW5Bbvm23vnpD1eo0MHFi/view?usp=sharing
> >>> Kernel config: https://drive.google.com/file/d/1RhT5dFTs6Vx1U71PbpenN7TPtnPoa3NI/view?usp=sharing
> >>> C reproducer: https://drive.google.com/file/d/177HJht6a7-6F3YLudKb_d4kiPGd1VA_i/view?usp=sharing
> >>> Syzlang reproducer: https://drive.google.com/file/d/1AuP5UGGc47rEXXPuvjmCKgJ3d0U1P84j/view?usp=sharing
> >>> 
> >>> 
> >>> If you fix this issue, please add the following tag to the commit:
> >>> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>
> >>> 
> >>> ==================================================================
> >>> BUG: KASAN: slab-out-of-bounds in snd_seq_oss_synth_sysex+0x5d1/0x6c0 sound/core/seq/oss/seq_oss_synth.c:516
> >>> Write of size 1 at addr ff1100000588e288 by task syz-executor411/824
> >>> 
> >>> CPU: 2 UID: 0 PID: 824 Comm: syz-executor411 Not tainted 6.13.0-rc3 #5
> >>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> >>> Call Trace:
> >>> <TASK>
> >>> __dump_stack lib/dump_stack.c:94 [inline]
> >>> dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
> >>> print_address_description mm/kasan/report.c:378 [inline]
> >>> print_report+0xcf/0x5f0 mm/kasan/report.c:489
> >>> kasan_report+0x93/0xc0 mm/kasan/report.c:602
> >>> snd_seq_oss_synth_sysex+0x5d1/0x6c0 sound/core/seq/oss/seq_oss_synth.c:516
> >>> snd_seq_oss_process_event+0x46a/0x2620 sound/core/seq/oss/seq_oss_event.c:61
> >>> insert_queue sound/core/seq/oss/seq_oss_rw.c:167 [inline]
> >>> snd_seq_oss_write+0x261/0x7f0 sound/core/seq/oss/seq_oss_rw.c:135
> >>> odev_write+0x53/0xa0 sound/core/seq/oss/seq_oss.c:168
> >>> vfs_write fs/read_write.c:677 [inline]
> >>> vfs_write+0x2e3/0x10f0 fs/read_write.c:659
> >>> ksys_write+0x122/0x240 fs/read_write.c:731
> >>> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >>> do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
> >>> entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >> 
> > 
> 
> Hello, 
> 
> Is this issue being considered and is it possible that the value of sysex->len in line 509 of the snd_seq_oss_synth_sysex function could exceed 127 and thus be out of bounds?

Sorry for the late reaction, as I've been (still) off since the last
week.  Will check in details later.

But, through a quick glance, it's likely the racy access, and your
suggested fix won't suffice, I'm afraid.


thanks,

Takashi

