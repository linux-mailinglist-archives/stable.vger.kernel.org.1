Return-Path: <stable+bounces-230542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKwsBp3ExWlHBgUAu9opvQ
	(envelope-from <stable+bounces-230542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:43:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C49A33D2D6
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 641A130215EE
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFB73C060B;
	Thu, 26 Mar 2026 23:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWSjIKGz"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415693BED26
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774568586; cv=pass; b=H2knTIuQKiEKdRh9qbMPw9R/wBst6tQt2vUN9YE7b5CQ7+NmJXnYlBTMqI46s/3KrZ16Sm/IXZT5FqlV5S03syOpBDpW/Zz63ndAPkYvNwgCCIdlHMDqQCMlu2VgAHW4jDZZdEA5JLt2el30IWK+LxfnSayzoLUuHN0puQewDnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774568586; c=relaxed/simple;
	bh=te2zT25Ks5cVGGQRJFsQTdoq7+P8sIjDPy3cnuoauho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTrMKEyi+C5ozXfSaioQW7kc7JpUvx91KfcRnBmYu8zBCbhI5Y16Vvsuh41KEzCWicFaUaljUJYE4Pq+VGI/sVQQOC/hXbx4u8S2JpCRUyxecZ3bdGumqSm6X15o9tpuXKBXGAmX3F+9gF9dE2CnwbYKmrmmBDyK7tkI7XevE14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWSjIKGz; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-40423dbe98bso620533fac.2
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774568584; cv=none;
        d=google.com; s=arc-20240605;
        b=LQebIc7WV3LTwtFajgcuVcCXdJWRA+tkNpxMYjeBBIdrNKzwAalcM7iSWOWWZ6BaxS
         ThBp4JNTfs1SyTvq44qPQDvu74Hg3lUyCKLNUB2QjPa31WQio1slCeuHFGScJj+gUXbt
         /dE+DbyNAgdeYuefANTk+fZDnZGPA4I1IBUvGRGhn34UD6b0E/I9h+LdND9swaqjh+bk
         C79gu4a0paty0CLd7FF6Be+qH7zXIqrzrT8pfk645TSfkfz62BjFiNNC6nCEtkGFLmoV
         W6ZTDn4u456WkPRiKijf+P0Votcex8SsJEu+POwJZbxMWMa3MlU/lTIQaQjC6G0+cfxN
         yIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fSIfNjZqpVj/kLdEFTF+RYLofN7r0K6iJ3P130bnlx4=;
        fh=sHnnYPggsTsd+j29WNCF4Dwvdz8S4phHu/9qp4Ga2aE=;
        b=jL/nfh3tdRdJlBVR9Et4xUl0OrvhH/WK+9VWepyqRoefDKxHp3/gZF7MpBpyAlpq6X
         l+9rOTxL9l/6zBtpsGsyIRrl0ZXI9y2Y7+5jfoHXeOgCS6TDgS5s4IaAnC+S+3FZC2U1
         ZqNZ0Rew7vD2U4MEUOliyDJupfvFE1svF+Jj63ZDTzvTlBQJLVeVfUxMx7EShhJPJkha
         SjOQBCTACSntkOQHxsFS/tK+aYXb5aq9/fh7KbXQNJ5D8rC//rQPY/CQbNOY0n3p59f3
         qkjPCG0zsFctbBjjMkJ1kYDIyg3Ykwj///r+42szRRA1Yev+vGdPzYZdarbTzZjVyrwD
         BTpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774568584; x=1775173384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSIfNjZqpVj/kLdEFTF+RYLofN7r0K6iJ3P130bnlx4=;
        b=mWSjIKGzFiCSbkxf8rWm/BhkuVKi5x2mXuypXZ4g1n99NqcgZMgYdB6H5+n8ysDaxJ
         U1VlLKerOdc8Qrr+ShrRYgGb5nu3Q8XYKdFgVr01J+JUWXm6Vz9uQ2D/kRQoORYtEa4M
         3lcFBDEga88crEo2GDz1EkNKSYF4S62yvQg91RBAhBhuNZtgwaYSpvYn3fkUxmgSbSCf
         d6GnInIP8wkkPXfS+Ev84lieQkg/D627wpaxZOtqvKVR+Utf1Q9OTVopTaZR32R7ZFK9
         OOIBR4benxqkmQwppSA8DmQo0kOd5vlDOSXtXT3F/5O2L61u1d2+uDiZVbH4bf4UUmbM
         Ik/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774568584; x=1775173384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fSIfNjZqpVj/kLdEFTF+RYLofN7r0K6iJ3P130bnlx4=;
        b=Kflq7nL5xh4sNJbYJY5WPHL7AjBXbbWg+jPtkuqlr9iJA0r7/u4qiRX0U68GC+iqsu
         dHOwUWcGuJBPOOT5zINJnXmoxcO+bqM+72vXWntsSqEsjjCrOmuRkEwIi3sMnVsrEKLP
         4Hny8BqvbuJAikUxvQTpJ8Wh1VUlL+GLRLZfQBNr+7k/Rl7BJsz0GE1kA/iHSJ4iFYfL
         rSTiJZtdy4naD33N4M2i06vGNc+ijXgidXYsauwKtXZiedN8f101czBWpvzkd8mw8Mhn
         +9mVufXOW/y+5OXWTedGkrntF5iBfOEp7Sff/A6qTrmwHbUyrvHY5shzTMiASsLSPWDs
         NeYA==
X-Forwarded-Encrypted: i=1; AJvYcCWOeKEYVj1AbRqN5vQ0JsOZvOSP+c6kb1JUsp09R6++mZkb1NpxTwQKd4BoYwt9TfGZO4TcDkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx078OhRKlm/gJ/t6U6hdNIsxn4izFV8Kyo+ZbQ80cKbEOtYoJW
	7ckRQBoJhPklR7as3Wt3b44s4ZfzRzwF03votswCbGCLWHx75itCQ8vB3QJ5cCBEZJwHvXLHk4H
	xf7A+aGw91YqeHIZxYM+W7D877zohiGs=
X-Gm-Gg: ATEYQzxNctemzpbAcfkB4cfIBhMSM+kkyYij1jQ0UilwOnOQEBHftGHxlzl9aKvXdA6
	hlGzSql1bC2DwU7376zlfDMCg/S1ryAR5zXU1QI/evt30lHOHc0roGW1jw/bC0qiaZAiqZXL0PY
	NEOpKNwdoGfz2vFKNxB/w5q6EsQ0WgyXACkoni4Ze2at6pLX/WY22OGqPZ6LCRaf1JkG30pcIIV
	LVge8qwfwyobRC71j3/Xd1nzXTkkRWpbg1yDbbYKDSXu06f+IE2lYKS21GH5DJMOZhE2KMoXaSC
	i4B71xKFdH2YAkjtAlKh5BvXOu10HuV1XPGXNvEH1Da2nS0xia2cbzwXdZ8lbUj2RHZv
X-Received: by 2002:a05:6820:4d0a:b0:661:1188:4b99 with SMTP id
 006d021491bc7-67e185f1ec8mr255826eaf.3.1774568584236; Thu, 26 Mar 2026
 16:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326232130.1891210-1-turyshen@gmail.com> <CAGudoHEHua4cA2-jZ0Yf54LQtuG_7=We-EMcW-yriNQ5JZzM5A@mail.gmail.com>
 <CAHLHtjzi5uKrNDyjL60nZ6TUZnae5gDaEHL8dwbMECBT1L6tdg@mail.gmail.com>
In-Reply-To: <CAHLHtjzi5uKrNDyjL60nZ6TUZnae5gDaEHL8dwbMECBT1L6tdg@mail.gmail.com>
From: Xiang Shen <turyshen@gmail.com>
Date: Fri, 27 Mar 2026 10:42:53 +1100
X-Gm-Features: AQROBzBxfKPTlZW-oKH8yCwx7Z5uui51ndN6KoM4FAQWEm_yzWqtuMga1zg0_-4
Message-ID: <CAHLHtjyOim1QrH_xdaePDPqG2XdAeme7=1ZT8_gfr7phBnjfdQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: fix deadlock in insert_inode_locked() waiting for
 inode eviction
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230542-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[turyshen@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C49A33D2D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Withdrawing this in favor of Jan Kara's ext4-side fix.

Sorry for the noise.


On Fri, 27 Mar 2026 at 10:40, Xiang Shen <turyshen@gmail.com> wrote:
>
> Withdrawing this in favor of Jan Kara's ext4-side fix.
>
> Sorry for the noise.
>
> On Fri, 27 Mar 2026 at 10:29, Mateusz Guzik <mjguzik@gmail.com> wrote:
>>
>> On Fri, Mar 27, 2026 at 12:21=E2=80=AFAM Xiang Shen <turyshen@gmail.com>=
 wrote:
>> >
>> > Commit 88ec797c4680 ("fs: make insert_inode_locked() wait for inode
>> > destruction") changed insert_inode_locked() to sleep via
>> > __wait_on_freeing_inode() when it encounters an inode being freed.  Th=
is
>> > introduces a deadlock when the caller already holds resources that the
>> > eviction path needs.
>> >
>> > For example, ext4_new_inode() holds an active jbd2 journal handle when
>> > it calls insert_inode_locked().  If a stale inode with the same ino is
>> > being freed, the function now sleeps waiting for eviction to complete.
>> > However, ext4_evict_inode() needs to start a new journal transaction v=
ia
>> > ext4_journal_start(), which may block in add_transaction_credits()
>> > waiting for the current transaction to commit.  That transaction canno=
t
>> > commit because the caller's handle (in ext4_new_inode) is still active=
,
>> > resulting in a deadlock:
>> >
>> >   Thread A (ext4_new_inode)         Thread B (evicting old inode)
>> >   -------------------------         ----------------------------
>> >   jbd2_journal_start() -> handle
>> >   insert_inode_locked()
>> >     finds old inode I_FREEING
>> >     __wait_on_freeing_inode()
>> >       schedule() [waits for B]      ext4_evict_inode()
>> >                                       ext4_journal_start()
>> >                                         add_transaction_credits()
>> >                                           [waits for T to commit]
>> >                                           [T blocked by A's handle]
>> >
>> > Fix this by replacing the blocking __wait_on_freeing_inode() call with=
 a
>> > non-blocking drop-and-retry loop.  When a freeing inode is encountered=
,
>> > drop both i_lock and inode_hash_lock, yield the CPU with cond_resched(=
),
>> > and restart the outer while(1) loop via continue.
>> >
>>
>> Please see the ext4 fix:
>> https://lore.kernel.org/linux-ext4/20260320090428.24899-2-jack@suse.cz/

