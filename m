Return-Path: <stable+bounces-214630-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGVTGh69hWmpFwQAu9opvQ
	(envelope-from <stable+bounces-214630-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:06:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC7FC710
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2E413073F72
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90533612EE;
	Fri,  6 Feb 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0cNdDJ/t"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C21B30F52A
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372141; cv=none; b=gcjKs1va55uQdrknu9TvqxDzzzgc6c4TJH59UDTARykVLlR93imCbtRLfjHTFNgF7ks5Fzd8rFQTPTmKntHA8YoRJLYOtsi2hJjjEKEAdhvavndDozxSaI/5OKQ3XhFiOPVLHV2dealz0kK680/Lwok/hVp+TLO0Es9GAJ/f1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372141; c=relaxed/simple;
	bh=8T6OtLRymPVfCIUBMcoeVSXu87Rl1DjP1XQL/Jy/Qz0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z2J4mYJHyNLIFLNH6nd6y13SGra3ZN4vjwRM9dLfpv6Lhk8EUAD6x784Wy5doRTl+OijdVTyuYs5S48YTH69HMGC5nRIVOyTgwUYx9u511YWBg+FAOHivhl55S9axWavDnOiQ4RGH/00ipFq6Gm/HELMGkEYAfbsnWACMlRd6UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0cNdDJ/t; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bc535546so86867a91.3
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 02:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770372141; x=1770976941; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zt0Gi8eng1ewWpbYcR2xwSSE4Oxk3JAUhhCfKODhyE4=;
        b=0cNdDJ/trXbMJOD7OCyoZXr6/dSf8yhMQnoP8BMnaUaNeJTQ4Pre5i8MtaBg8/n5qc
         /MamlF5X9/UYTXscT/SGsyTM6BMwKE09FmJClYR8MLrnzvq+a/CQOK1Uy9oVOpjzIfJ1
         V+QXt4uiw/JDLlSvrOdnfu4eEAHlykasIXJawWqtFBiSCEX/+PP9Fd2/+ncEkUD6+1m4
         wDd5vZtPhpgYKPxrjkNl90TwwO/VJhmNn/PhMPX9bOhwtBAqyDfU5jcxTTtHBD685DMU
         41yOaW9C1dgb6ZXK/Dd1hl7F2h+On7KuqyfYqWBhFA3YMFclmwpGZocqSlWyVnZ/rL2S
         Wvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770372141; x=1770976941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zt0Gi8eng1ewWpbYcR2xwSSE4Oxk3JAUhhCfKODhyE4=;
        b=gWA0LQ1Ww5s9MFhuLDLGR45zD4F0xlTAyPyDyfbyQPXGcf5BYxXoseVxwyDFUqicx4
         7F3QVdOer+BRKN19oQu1sRyjrOlqn9oaoKswFA+O3cZ7bkzX/446x0KuREtV7jRbjaSU
         femWGae/HmwEm96DIRmdueQO3hwiX/PWfVfyV1AI36sd350SDSQGo2zjBRYavAKb/ypr
         ByqF3XIZxR40AOV/DKa1dNjV4S8T+4q/1Ozg8RX3rmE5Wete4MWlUQ4pIffaHRyW8ZRW
         mnYRGtKdQ17oE7jxPFyKljlfNDFtHqhrmLONl+nVzBXZrxgNsb/b39mZ8dASKJvMZEko
         dS3A==
X-Forwarded-Encrypted: i=1; AJvYcCVJv1Mx62AjFIcrgkq9RkWBOMo4zVtO2oQzrPVXRUhPV+3Iji6i9GFbAiq8feWb/6ErrM7in08=@vger.kernel.org
X-Gm-Message-State: AOJu0YygNrw5WYB/wowuD7xJN/orqby/Cwsbp+mzaDBsScKNt0QTAMVF
	8B2R2QzCwoeovonAUFSjfnNwW+KqBH9TceOzB8WBynA1Of4q3ezGpWeVMH94zPdQuTHEGx2xX7M
	HNbd6eheiZ5VeeCEFQoNfoDCBdg==
X-Received: from pjbqx13.prod.google.com ([2002:a17:90b:3e4d:b0:34e:795d:fe31])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:350d:b0:34e:5516:6655 with SMTP id 98e67ed59e1d1-354b3c5bb83mr1709576a91.9.1770372140784;
 Fri, 06 Feb 2026 02:02:20 -0800 (PST)
Date: Fri,  6 Feb 2026 10:02:18 +0000
In-Reply-To: <CABb+yY39rhTZbtA21MecYk-R9fh7VQQr5kZUgCw4z92mWhZ1Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY39rhTZbtA21MecYk-R9fh7VQQr5kZUgCw4z92mWhZ1Rg@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206100218.4163478-1-joonwonkang@google.com>
Subject: Re: [PATCH 1/2 RESEND] mailbox: Use per-thread completion to fix
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: alexey.klimov@arm.com, jonathanh@nvidia.com, joonwonkang@google.com, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	stable@vger.kernel.org, sudeep.holla@arm.com, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,nvidia.com,google.com,vger.kernel.org,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214630-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBCC7FC710
X-Rspamd-Action: no action

> > Previously, a sender thread in mbox_send_message() could be woken up at
> > a wrong time in blocking mode. It is because there was only a single
> > completion for a channel whereas messages from multiple threads could be
> > sent on the same channel in any order; since the shared completion could
> > be signalled in any order, it could wake up a wrong sender thread.
> >
> > This commit resolves the false wake-up issue with the following changes:
> > - Completions are created just as many as the number of concurrent sender
> >   threads
> > - A completion is created on a sender thread's stack
> > - Each slot of the message queue, i.e. `msg_data`, contains a pointer to
> >   its target completion
> > - tx_tick() signals the completion of the currently active slot of the
> >   message queue
> >
> Mailbox API does not support shared channels. Each channel is supposed
> to be owned by one client. Though a client can serve multiple users of
> the channel, but then it will have to serialize access to the channel.
> The implication is mailbox_send_message should not be called before
> the last call returns (in blocking mode).

This sounds like a suddenly big change to the mailbox API after all other docs
or discussion, e.g. Link in the commit message, imply that it supports multi-
thread use case. I think it would be better to make it support multi-thread not
to cause breaking changes to the mailbox client drivers. At least, we may be
able to implement mbox_send_message() using mutex or other locks to still
support multi-thread.

> Even with this patch, consider when threadA is active and threadB too
> is waiting next. If the tx_tout races with threadA's transmission,
> threadB may timeout and call tx_tick() on the channel thereby
> affecting threadA. Which also eventually proceeds to complete on
> threadB's tx_complete which was on the stack and hence no more exists
> thereby causing UAF.

Indeed, thanks for this input. Here we need to consider how tx_tick() is
is called in conjunction with other events like timeout. tx_tick() can be
called either when timeout occurs or by client or controller. Below is the
break down of the cases.

Case 1) Thread A is active and no timeout occurs to Thread B

In this case, tx_tick() will be called once the tx is done for Thread A and
then Thread B will go next. So, no problem.

Case 2) Thread A is active but timeout occurs to Thread B

This is the case that you pointed out. In this case, we could cancel the
request for Thread B not disrupting the active request of Thread A and it
should be okay to cancel it since it is before sending it to the controller,
i.e. before the call to mbox->ops->send_data(). By not sending it, tx_tick()
should also not be called either by client or controller. So, it should be no
problem.

Will create a new version of patch with this change.

Case 3) Thread A is active but timeout occurs to Thread A and tx_tick() is
called for Thread A

Case 4) Thread A is done with tx, Thread B is now active but timeout occurs to
Thread B and tx_tick() is called for Thread B

These cases could occur, e.g. when there is no way for controller to know a tx
done interrupt that it receives is for the currently active request or for the
previous one, or when the timeout occurrs just before the controller is about
to call mbox_chan_txdone(). If it happens anyway, it could also cause
inconsistency of the mailbox internal status, but UAF will not occur with
the patch which handles Case 2. However, these cases are out of topic for
multi-thread support. It is more about the timeout support. It could occur even
in a single thread as follows.

- Thread A is active with a request and timeout occurs.
- Thread A goes with the next request and is active again.
- However, the controller calls mbox_chan_txdone(), thus tx_tick(), intending
  for the first request.
- The mailbox internal status goes inconsistent!
- The controller may soon call another mbox_chan_txdone() for the second
  request.

So, these timeout cases are existing issues regardless of whether it is single-
thread or multi-thread and should be considered orthogonally.

