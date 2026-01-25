Return-Path: <stable+bounces-211475-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMAUDhB1dWlfFQEAu9opvQ
	(envelope-from <stable+bounces-211475-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 02:42:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A25DC7F6FB
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 02:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B8A3300B84C
	for <lists+stable@lfdr.de>; Sun, 25 Jan 2026 01:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E4E1C84CB;
	Sun, 25 Jan 2026 01:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1gN4lrq"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9911A76BB
	for <stable@vger.kernel.org>; Sun, 25 Jan 2026 01:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769305353; cv=pass; b=H7E8kZ3Z2raAltlzcQkWllmZdJxwsU4L0QMKa2i9kMsbjb4gsaG9zEIjyFAYzYTMZrX2tCjslJ8NxitDkLHo92oCvc/zAgmrAa+hBIRDtHhYQ1qQl4n0PGWFsBy7TSqQvO8qIhGAAac6u4KCSG41K4EZa+Srpe4+lkLpVM+9Hcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769305353; c=relaxed/simple;
	bh=o62QWtWcle4DY/qGkFRQ4LThvoa5UF61oBPpFQEHMy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCDRT8amapOhL/a9EpC/qPizMGMAhLovJChKgKqJxsKe3H2Vl8WfbSxiUIC76ZiUovUy+RgPYj+xyKszqY5sAkSYt9rjgpEAJNM2NKJ/4cIW6CkduIeGUP3kfDerrNlZZUGNKepBB9OVLbcjitkIi7ejzLkF30C9Dzz3kogWFZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1gN4lrq; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b883c8dfb00so714795666b.1
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 17:42:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769305350; cv=none;
        d=google.com; s=arc-20240605;
        b=QhWGM6yL7lCyan9AmGWvGf052g6EboHJLt9NAvfFufkMPpKG7qH4SfcS3gSQ0IZhWS
         sEOsYS877kfkQYI6iPcyKc35ozxH9sSnLmHG8D59imAcpNcptr/0BL8JcQqUNkswex6W
         FwvAPC+QXzW6M2/GhZO3+Aa19pSV7uXaSpnWSW2SiHjyS6Uge5EP1Pus5ZscUwoqJMhy
         SE36u1LDooYsiRa27ZFBrWz96rH0n3EktWYuHKT0TPoPfYXVPDro+zSLNqrB/Hv4qhkO
         xReniAm2CcvAqf+wRHChbB31fGRwnrJttmqMdA1HY8Q/ifSYP3B6COlOI6dneaLhZsCR
         VYWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zLvoAJ9PRCVQHW3muNClNeM72pKgSuHCyQxqvs2XN7M=;
        fh=weBd/FlJyMojcFXVCIEGqpm6BC9Gl6CEnsBQBhh0GdE=;
        b=j9GrnDT3MTBUDbbHfHF2uTYaK1Ib523RQdhzet/FInjZKgo3RCWaioGsAI3XoT7zXA
         FKdLVkOOVL5vZl83AEraa4ULQac0ZHzmHp1Gp6H9w5qnmCHtl6smkQ+oWxLEUujNKUQq
         KZb1B1Uhmfms7Yntusf2V5fQOgHawWn2G3GWq8tZxk3qTP+SOJvxMeX6IfybKCf/thc0
         uJtPPpyHgYz4th/PBFS/uzmsUaxOYjwF1EE7tgP9qjGUNZjSa9kb7IRtlW+GCWHwqEaB
         jiIKtoXt8e9l8Mnk2cASYbfXv0yQs/9mx4NsKz7k5kJAq5fPzZ1cFCwEP/GWaPRlASgr
         PwnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769305350; x=1769910150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLvoAJ9PRCVQHW3muNClNeM72pKgSuHCyQxqvs2XN7M=;
        b=Q1gN4lrqzD+6W0GvKXwUZkZ7B7zFGgAgDNAwOTK5gd8e8b06uAuKF2WEag6/cR0DIX
         Z4DJbPq3Z0Ebz8kQYCKxJ41iWatKrnY1z/h937QW3YTP42g2uzDbF6cOmD6nGcCyz3GN
         SuV8KqupqPzsbD1/V5dHvuRnvK+Na1+sQrWFChcHR4NQqSeyWNeJ7qktJgUOW1Y93vU0
         aqFvRAJ4hnZ104G7zImKPK7JrnBfL5W5sQpNPoWWciUhNPzgKyV2E9hWkBQEtobhoigP
         eRRoXCT8m24cQILCszKf0iypbEL0FK8vm80YA6UJ72pO8dNhHZwIDfcbNp9louts/2OU
         3JlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769305350; x=1769910150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zLvoAJ9PRCVQHW3muNClNeM72pKgSuHCyQxqvs2XN7M=;
        b=LRPi/QNBlVOoy41jNJmvDftysDsHAceczyjazBdq4li9hF1Un1HAM91LrqLKgANYfo
         dAsPnkhCRV1HtkNGPlz+Vrahs1ATjf9VAoVIPrGcrXma6EYv+qjsDbBrrCJXE7o7YQcZ
         fdIz73m6eeokRDF+SGqdQDiRPpIKFcPoF+iPAps6wVKgDw1Lb0gKyo3csA13XXgbR2R+
         H1JSqlFRiM5I9nb953JzNVne6Aw4y2OSwbI0cBgF7bpMba9PFpqyCJcWwcYDjcif3K6y
         ioYVdo+qbrgCq9jlYjaqVGGHHJju44IBYVOspxUJo+d4wkZSLUBAFxlJn/LYJTQzcxXj
         zC8w==
X-Forwarded-Encrypted: i=1; AJvYcCWnivFYziYyUuExMfNm7bS/VUtasIyzWipmjjq/LdQi+OJ9ifh8qJa3qoR4aPahMvI6pPpaAgc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hyIV6GIUap/ol8rtun+LATLYLhtWmvLE0DnVycu5dENcRo87
	vk9fssaXfaHe48fadCVjlOrTZF//U+Q4YspNeYBb6sh2GJ3QeD9eWw3uzf9pDdYmjti1oSFSG29
	rZUxjLhIk4zj+G3Ev9snw5mznWaZh9MTlGFu8
X-Gm-Gg: AZuq6aIYlBiuNan1rjdAF594g9ooOmcVC7dJbd5N4840dpXKswICHAlachiMNPDt6Rf
	4QGszBYcrCwJjLr7z/Aj/BM6yBl+7T6b3fVMlriebKqE7dF7CqLbR0YQOrfAfQNvXBmjaKtVZ4n
	w/Uw1xDZMnqfYfpIg9jgmn9JFzi00TgGl4C9fZ/SNDF5cbiOKxLfUxPV1iePrh3fdP6qLp+N9nN
	wZZUdl054Z3NvNfUGeAeoODeLXj/3wVOQgtTmPZFKBcZ6OfLp54+wiWt/7MPGEhXgS4AbNo
X-Received: by 2002:a17:907:3f0e:b0:b87:1e50:95c2 with SMTP id
 a640c23a62f3a-b8d20b4f2a3mr26845466b.3.1769305350219; Sat, 24 Jan 2026
 17:42:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216084334.903376-1-joonwonkang@google.com>
In-Reply-To: <20251216084334.903376-1-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Sat, 24 Jan 2026 19:42:18 -0600
X-Gm-Features: AZwV_QgijN2oexrG2LfmfcIUkp1z36F-46iHu5_OKT2Q9YLc-TzhUJUCi6aKPJo
Message-ID: <CABb+yY39rhTZbtA21MecYk-R9fh7VQQr5kZUgCw4z92mWhZ1Rg@mail.gmail.com>
Subject: Re: [PATCH 1/2 RESEND] mailbox: Use per-thread completion to fix
 wrong completion order
To: Joonwon Kang <joonwonkang@google.com>
Cc: thierry.reding@gmail.com, alexey.klimov@arm.com, sudeep.holla@arm.com, 
	jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211475-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,arm.com,nvidia.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: A25DC7F6FB
X-Rspamd-Action: no action

On Tue, Dec 16, 2025 at 2:43=E2=80=AFAM Joonwon Kang <joonwonkang@google.co=
m> wrote:
>
> Previously, a sender thread in mbox_send_message() could be woken up at
> a wrong time in blocking mode. It is because there was only a single
> completion for a channel whereas messages from multiple threads could be
> sent on the same channel in any order; since the shared completion could
> be signalled in any order, it could wake up a wrong sender thread.
>
> This commit resolves the false wake-up issue with the following changes:
> - Completions are created just as many as the number of concurrent sender
>   threads
> - A completion is created on a sender thread's stack
> - Each slot of the message queue, i.e. `msg_data`, contains a pointer to
>   its target completion
> - tx_tick() signals the completion of the currently active slot of the
>   message queue
>
Mailbox API does not support shared channels. Each channel is supposed
to be owned by one client. Though a client can serve multiple users of
the channel, but then it will have to serialize access to the channel.
The implication is mailbox_send_message should not be called before
the last call returns (in blocking mode).
Even with this patch, consider when threadA is active and threadB too
is waiting next. If the tx_tout races with threadA's transmission,
threadB may timeout and call tx_tick() on the channel thereby
affecting threadA. Which also eventually proceeds to complete on
threadB's tx_complete which was on the stack and hence no more exists
thereby causing UAF. So if you have multiple users in blocking mode,
have a local queuing mechanism.

Thanks.
Jassi

