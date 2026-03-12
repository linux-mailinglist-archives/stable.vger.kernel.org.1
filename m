Return-Path: <stable+bounces-224772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK1yHr8CsmmHHwAAu9opvQ
	(envelope-from <stable+bounces-224772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:03:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DDD26B839
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 01:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6D2453015158
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 00:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12784224D6;
	Thu, 12 Mar 2026 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bI9Q2bL6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E82A932
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 00:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773273782; cv=pass; b=n7ffI5QUSUoXhExkku58P9OR7y/WyNae4lHu4Koc1Sn7jC9MDNXr7h9RFvX0vG1DEiZU6kmbJZBn9aA51NxgKI4ZjBm1PtYKOrS2/OlRm/kVEEQXodC64TMAI3mTChG/Wk2UCbW2ZLiStLeM82JAnkuLhicAJ4kOdeG+e+zudJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773273782; c=relaxed/simple;
	bh=FTOaeeyG93FEF2oIGgYoaY5uDWfRBHcPgEq0TxAsTUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=crbjL/9xEVXmPGZjwHUl7dzi+KJPCBEovmpoQQyRb0QGMU0g6cqbJcO7n6wuQueZ32qShq8UlaqrPeIJM85i0i6/kIl/gGfbYrEnJotNiCQOpP4a4kEMJluz7B0hgUhlDv9YrTZxtI42Yishwik/edhj1AWVgfan04uk9Uh2fao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bI9Q2bL6; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6631e0edcf1so524740a12.1
        for <stable@vger.kernel.org>; Wed, 11 Mar 2026 17:03:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773273780; cv=none;
        d=google.com; s=arc-20240605;
        b=AVyiBENYYspcKspXAzIyPJULn9UOC+YTMoYYBjQ6xiywwGQH+JS+2oqy3KPU0fzFLR
         vl58/Y5ygjjS2VK/E3TUK3HeFOn6EzZUiM4qdeZtFplmATdKz5JCQYRhyRsP8MWtDxzA
         6pAGn+BKxoRmPplSIEIen2mfRkO4LHSQ7Mvm8mVoUZA9ueS+4PBG7EexeENRQh9RE2vO
         SjE0g5u0wE8TMxOmnKHVGfNhKrTF6nUoxCagodPcj1kCanp3IDTcilW3Jx8bsUlqT8Lw
         cJPx2X6qguE4XZpRZVhbET1kni4N7xWDgZ+aPKoKP2RoWLlCkmppeBME6NjxtPdSpb7P
         ezvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FTOaeeyG93FEF2oIGgYoaY5uDWfRBHcPgEq0TxAsTUk=;
        fh=ltUr4CntRUG9C0u7d/PzIKEHzL6I7p6vaqZvmEqHAog=;
        b=MxHMz1HpBxxGNiuQp4QLyrxaOsL5FO9LS3oII2zeF6ovjBJRi2o238NvA6a6fYWaqa
         GxALejDlSUOzQJZrwWAmnROVdWp04iphWbskOKX4AqXhjwgtlkotxNFj3+tKY8L1mt6t
         j2M9WuKFlmaQcpaReT+f3+VoE7DzHbU/BgIQWWx5VCZKjNCL3bIIKqVJy9ZQ3VUNFe5V
         IutfQf7q9rD8ko5/NjgAWVwUvpAD80UPXZ9mWNJ6zPSUdH0Xs+0M+bism1BUI4csX9nh
         LLxtpw9Mx0N+o9KxVagu/ladsTfrEvpQpHbwFAc/+jlnOAxE7OSdHvxqvaZiAph4E3vW
         wCww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773273780; x=1773878580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTOaeeyG93FEF2oIGgYoaY5uDWfRBHcPgEq0TxAsTUk=;
        b=bI9Q2bL6t0IntIdPjcIXuu9eD/cl/ICISs0iUmGOCldworcV7ae9WeQ+CRMN5dqpm2
         WlfDPSAlXUV4WTzCIG2LNOWOkrsic6uDLLX56xuEHMY1T7+4HUjnlcpHOusA2tT1PoVu
         JXmPLfcMBYr+Q6fEEzdUv9OntRbzvLxegU7l9loRntfiYXRGje5HC9Pu0n8J3y3EQbgv
         8Crvy7Tq9fqneh4rXTf85GOb5cXw9l5EoBKvn8ETd0VIwHh7aAMb5IXt+WPo4nS9XVZy
         swhb+D7D5oTHWV4NONtojBxDrjKo+gBtYvCac1UjwOTNrpC/gULV7qqMcIsNCms0t/Pb
         CLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773273780; x=1773878580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FTOaeeyG93FEF2oIGgYoaY5uDWfRBHcPgEq0TxAsTUk=;
        b=am11cQCWV3Shz2XXTwQn2V+aVnPI6rd98wppDh20DLzPxlaSx6jWm7/2WQCX9IcdHa
         XL9PIHZGxJ3+ITTVQdjlXt0AWTl2GvZpRtLn0/9qoe9MH0ClvQ6JGFguKHsShsSRCvE+
         z1e5jev0DBxP7Oq9kmPxa34iPfqqf/K9iIQ3Zlj8y7UGzxmZ3HbKN1SYJUfIV/JEZH7h
         mWSVe5CKWF6YQSg/vjW40vA6+zth3soU3pM96nZLdBxYVChrZdIpjtN9WORFpyOxuDlU
         7y99M/Ar1fuEu1T33j6eB2D/QzAOpa9AnGr9nIJcYVcGI8cpXktdonUS50HZ9m3EAODh
         yw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbhEv1Ep6nsyvKA2C/GwJG8KyIFXEUzUtvtc8vXqw54ooHyS8doUlphZkvDWY38lNb9B1ydaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgeZYAyFejNPcmhklnMvVvBxTaIUjczCXK91n0quj9ZApHBaTN
	AeaLfjZ64ebyaXQrkN0yZEasIdcJD4aCBt5G/Gzv7+B4B1njtQp5sNwWcJ3R8wNpVIQaU4Ej02N
	+WiK5CFjG7MiBEUEJ3xXURnJH4mDKyOY=
X-Gm-Gg: ATEYQzwJsOuiJfNFZcjMt1rWT4+UlHysUp0YmLVyRs4b3Ny1Wu9+ry0PftZDG2lVKkU
	0OiQOBhRG9j+wFCpB5ZkjJ4vIgMAZFfvpw+1A62Ad0yQqw7vEVUUXsmlcIt3EjDrGYfyM9TpTKg
	1xqTyLxrNJFrqRAl1wTvLiwDoedK8b8qp/+UGyqfiG/bIbKK4ClSk8Do6+p1kHO+7Hd+E1ZiYdX
	cBClu6sKvueweLTZMFfPsAOu1PQCTfTBvR5RWm3jpnDm178Ce5CEY2zjMLOcpOvjXSTpWYBiek/
	lBmt1Gu0GcYaw25JPQlQcud/olYcY5YnE0HZImG0BDGB1jVb5F2y9sPYZtQ2Xa4IwQ==
X-Received: by 2002:a17:907:d644:b0:b90:35c8:d01b with SMTP id
 a640c23a62f3a-b972e2c211dmr240675866b.36.1773273779420; Wed, 11 Mar 2026
 17:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311111632.2836293-1-gality369@gmail.com> <849ac4be-b10d-4eb7-892f-4b9ee2ef5cb2@gmx.com>
In-Reply-To: <849ac4be-b10d-4eb7-892f-4b9ee2ef5cb2@gmx.com>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Thu, 12 Mar 2026 08:02:47 +0800
X-Gm-Features: AaiRm52HrIoULi8oRrw_KZxsuZhl503rFFhskRvicKXqoTqsxrnZiCjbkUhRSGc
Message-ID: <CAOmEq9WDrM=0_KbFohSxgrpMxuin8hNaro9YsY8HgVASOf4KaA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: reject root items with drop_progress and zero drop_level
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.com, clm@fb.com, wqu@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, r33s3n6@gmail.com, 
	zzzccc427@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224772-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_CC(0.00)[suse.com,fb.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gmx.com:email]
X-Rspamd-Queue-Id: 84DDD26B839
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 5:08=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> > [FIX]
> > Fix this by validating the root_item invariant in tree-checker when
> > reading root items from disk: if drop_progress.objectid is non-zero,
> > drop_level must also be non-zero. Reject such malformed metadata with
> > -EUCLEAN before it reaches merge_reloc_root() or btrfs_drop_snapshot()
> > and triggers the BUG_ON.
> >
> > Also fix the related tree-checker error message to report
> > "invalid root drop_level" instead of the misleading "invalid root level=
".
>
> The only "fix" part I can see is the fix of the message from drop_level.
>
> If you really want to do that, please send out a fix dedicated for that
> single line.
>
> Otherwise you're adding a new check. Please do not mix fix and new check
> into one patch.

Thanks for the feedback.
I'll split the message fix and the new validation check into separate
patches and resend them.

Thanks,
ZhengYuan Huang

