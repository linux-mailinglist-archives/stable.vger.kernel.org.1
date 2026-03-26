Return-Path: <stable+bounces-230541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCaSJVLCxWnfBQUAu9opvQ
	(envelope-from <stable+bounces-230541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:33:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F29DA33D17E
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 00:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B34C3018287
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 23:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99483A7580;
	Thu, 26 Mar 2026 23:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKfDEav6"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119D3A6F19
	for <stable@vger.kernel.org>; Thu, 26 Mar 2026 23:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774567758; cv=pass; b=CVPWUUgx6IKg57xgs8Lkb+Ms/1aJwhfJ3NUzLotoG910XaHsu4JtqGx0CwEB/FxZGumsDXs+ftOsS31VcRZibYJ/cMMtqttevt2N9UZXIfkQ1bfoQ1HY/QEmUl0xK9po+IC1H9dU9HXKxlsUkuck7NlVUlep86pptzs69HxPLg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774567758; c=relaxed/simple;
	bh=6i565q7fXcLPFqrgBH3U/h1+sCz5KxVk4IbzWVMk0sA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O57OQolkNZAmKt40k/ZG7HUjrmgMFu+cPdrD0eI1svnbRralM4FSQXdsUhTAR3Sr1QQRGVzV5AiYrX3FzviW1KgVv2To4I7zggtbOif8ynfAorQ1vCnDk0VuSYbFRUq4V6a0m0BkL0IT0qdKHUT58bFwFLovVv/4lJNO7mi3KX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKfDEav6; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-505a1789a27so8507661cf.3
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 16:29:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774567755; cv=none;
        d=google.com; s=arc-20240605;
        b=lnnYqP8KDgkmj0a1rJYoO6NUVHFxnXSoGpefsLI1u6N/w0+GFofiij9Wjj9u1JhQTG
         bPmJ6FeZSBfZlFJOlrP/dmwue0hLxOfe2vMdWymW13cL6LCN9cpeb6aetheDr/Cohqe0
         jzB2LTFCo+erjS4OB1+OFHWbkltJR5dC7wgwfY9q0xGZBrz7K5Ltz6CdGFOCR1WSSu/4
         d3Z2onTCJhPkuhbdpoRAi9gVfAtsxHsRrt04s46nLM7b5o5y2DL5NHYCYmBV6PaI/USv
         zp3ckD4e0PDMzPMLdmfxGgVUyGtLDjtgmECdu6e6a+M6QSeXmWKFEn9F6IsDao6tV0/H
         dT+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZnXFVtU3N44+e5AvWSRM23w7ZT7/1s6IxCyauSmpLW0=;
        fh=hAdDPZHYI20nQ2/+o8dkdpju/vXijTpAm7mbGo7e0V0=;
        b=a7Cxo0SbhWZa+zemW+qfe2AVNHMWH5H9b4CEaL39zTN4jPYDCgeA+xyYldEmNPY4eR
         mVA78g/r27Do4hnP0mPGj93fEOWdMZ7K76BueY4vlhIiB7lngCa25cBCIjLwJ0ek6BGN
         jaRw5I6cCUFrZ8tZPGI+gkQdIqpCnAm2xpAEtA/AmphFUXPedRFuNi0SYe+2huMe90Bq
         OLG92EiH562nXMsEmnLu/To/JOacTUx5l6A12d1IXaDSkIF3XZ2/qRkX/UMlxxaMj961
         uc6YG6vHZzItJQ/wiqOJUkfOk6onWNYUU2kL0eed0wi7Y+uHuCJcYCTWHJa+UabypPk/
         WFaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774567755; x=1775172555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnXFVtU3N44+e5AvWSRM23w7ZT7/1s6IxCyauSmpLW0=;
        b=YKfDEav6V8i4Z48ETXE+7iYuK6O1P6tZp1M0YxT4TikfQ9l+rMBt/AGfd66TF3YiCA
         VfaALgUs/iqJmUKV8umk8E4pKgFEjJLBqyC4/ZHWYinv28ksooMJ2VxSSoZ92In7omhQ
         Ps5hvD2Yy6JLVwf9T+39/lTrF70jvuzuFA1RWzt2cU79apD8+SLbbAtLlLQT1e+yMFJP
         hkR9yr3nrEsocYmEQdOqRDino6JA6A2gAwQsEqQQHbbbYXSvmDDNcAn4mcYHX6NYnpdI
         MayQroCDaZGqaCgS/a+miE/TePnqY1clsqqwF+uXUzA0gf7IDSxbgSaT+vh5dgoZuf3E
         XRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774567755; x=1775172555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZnXFVtU3N44+e5AvWSRM23w7ZT7/1s6IxCyauSmpLW0=;
        b=mPX7FMySXv8eBO2uOZo1YOaVzDJWlEYsJeGdUSMCo5D05u+Kdhh7B4s3MXBgTRePin
         R1AunJUC/yCu+CAc4QO/ojmMOXkYfKGpEy747qAIcDLG+JlUFiLSk3OalKKihlLvsGON
         UAaHGf2bAFo360GB8gmZUSDDNRk3FXOhtU+7mcuHKjgLJeUc75J0XmD0MC7W2YHQfWy5
         3jLtihGeihn9LoeeNSLcaVwW7si/5wSPE+8867CVFKOmnP62QkA3owFdUtbKB/UhSbJl
         GkSTrlYhNWAfxRTXEi7FRsYRHaHimh+3k+QVwVi39rnm5kdm1CV8LUDWzLXtHqhhLoMD
         AbHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtv9FerHeFZMMrfbux3fwq7348zkXWus6yL7eGhgw6q5yHURtfeZNDNSPGDFAvzs/NL+4nXZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAinZ6XRMaD+VfqNwVn/qdkAYb4lb/gdFkhanySPQKEAqN+9+e
	IX5HWTuo5CQ6xTS/Hgsy4WFY5dzzL8VO9WuyQrJz6/emcPbsvPds9kF014efDXdKqMqbKwwHbru
	yk/UpYL8TzrvPFhclSgh4B9xErbl6UTc=
X-Gm-Gg: ATEYQzz1el6r9URqE/AmAEWEOIbe3pG+vdieEfDl/aVK0cT0RcrOXGchIgtfZVHE4s/
	+L0jbt0mwOH6xBbqIBSzIoUuMGtamnaqqdtxXYmmSLdmVIrRjYjEWcLa40K82fztmS09p4XASHf
	FS2idqBtuYhg36z33qSWfbp5Drs/1dIE97/c0dGDz3PCohvpPltBlbIH3uB4YdByeItgwBjLZT2
	Emk4CHUB6aEViw640hZrH0sYsJj7OMn8VVdRYEf7TW3nyuGWS4+3kDPJo7gzXEUvJwmvkUdcBZG
	/Rzd1sqX6pkxG04qXNUX4EV2W/SDvt7DTlPRrd8=
X-Received: by 2002:ac8:7d08:0:b0:509:3025:ff59 with SMTP id
 d75a77b69052e-50ba38447bcmr7756111cf.20.1774567754913; Thu, 26 Mar 2026
 16:29:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326232130.1891210-1-turyshen@gmail.com>
In-Reply-To: <20260326232130.1891210-1-turyshen@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 27 Mar 2026 00:29:01 +0100
X-Gm-Features: AQROBzDjx8ezXRoMyEZJsWkooKKULxiZKFTIJJlCbNY1L0YjZRhgjo4u7aVRZRs
Message-ID: <CAGudoHEHua4cA2-jZ0Yf54LQtuG_7=We-EMcW-yriNQ5JZzM5A@mail.gmail.com>
Subject: Re: [PATCH 1/1] fs: fix deadlock in insert_inode_locked() waiting for
 inode eviction
To: Xiang Shen <turyshen@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230541-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: F29DA33D17E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 12:21=E2=80=AFAM Xiang Shen <turyshen@gmail.com> wr=
ote:
>
> Commit 88ec797c4680 ("fs: make insert_inode_locked() wait for inode
> destruction") changed insert_inode_locked() to sleep via
> __wait_on_freeing_inode() when it encounters an inode being freed.  This
> introduces a deadlock when the caller already holds resources that the
> eviction path needs.
>
> For example, ext4_new_inode() holds an active jbd2 journal handle when
> it calls insert_inode_locked().  If a stale inode with the same ino is
> being freed, the function now sleeps waiting for eviction to complete.
> However, ext4_evict_inode() needs to start a new journal transaction via
> ext4_journal_start(), which may block in add_transaction_credits()
> waiting for the current transaction to commit.  That transaction cannot
> commit because the caller's handle (in ext4_new_inode) is still active,
> resulting in a deadlock:
>
>   Thread A (ext4_new_inode)         Thread B (evicting old inode)
>   -------------------------         ----------------------------
>   jbd2_journal_start() -> handle
>   insert_inode_locked()
>     finds old inode I_FREEING
>     __wait_on_freeing_inode()
>       schedule() [waits for B]      ext4_evict_inode()
>                                       ext4_journal_start()
>                                         add_transaction_credits()
>                                           [waits for T to commit]
>                                           [T blocked by A's handle]
>
> Fix this by replacing the blocking __wait_on_freeing_inode() call with a
> non-blocking drop-and-retry loop.  When a freeing inode is encountered,
> drop both i_lock and inode_hash_lock, yield the CPU with cond_resched(),
> and restart the outer while(1) loop via continue.
>

Please see the ext4 fix:
https://lore.kernel.org/linux-ext4/20260320090428.24899-2-jack@suse.cz/

