Return-Path: <stable+bounces-238461-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKLCME7y4WmKzgAAu9opvQ
	(envelope-from <stable+bounces-238461-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:41:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 85020418D10
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8C1A3006B47
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 08:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CEC19CD03;
	Fri, 17 Apr 2026 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/GHo6Px"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E336A027
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776415299; cv=none; b=QTGkKzLZIm8TxorRxziDCWmJCSo8pB/RbT9VTMUU9uoO8v13I0kG4DDoFMuV1C/FymICXzcSl9ObNnWekqLM4leVOu51lao1KBZ7oYUzkg9DXooqENjIJAh3WX9Xmx++JT6wWXyOQO4qzwZTo9D55R4t9EKKK0Jz2XZ0TpWmh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776415299; c=relaxed/simple;
	bh=E4ApuJ8oAQ/4OyUGknCmHnGsjWagqHfRqgj6PgH/Fjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VJ6k/AlyLPUb+tVmqG0MSy9eIi0rnzYoyoIPs+14nu2+YSJ0X9vpymweUu73tG2eWFyRnq4FyicXcuU+D5rpOzUGAsLgKNLA+YNK3/8oCEolwOsqAW0w85o1bfzG18r0XqYpKKsQk+B2KG7UPCy54wKVv25vnySlR4fBVA5ReG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/GHo6Px; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82a77f807e4so633970b3a.3
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 01:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776415297; x=1777020097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+m189FrlHvlQluxfIKHyqtB0jWSsQDaVuzIa8Tqb+g=;
        b=e/GHo6PxWVN3/Ai3QfURQKCP1xfsnHg7vDzfsNK08fM0WmOyAjI7qQOK3I0GdPBlpK
         kI/Pij1nWgqBCfiEwk8qlIevLJ2JisqlOyFCtM9/cfnlC4ZWFEt5DR/1cx4zIIiKM7id
         DtlHZEhr5qQtIqb7QqF3OCIbt/rRGvmP13OEOVemLq57XcH059t7GPUXFPmVWvhBPye2
         xszg+mc5jTkj7vMck2So1xQkT4ceR9mWWB990DZMwqB8tIbModDyouXkj0kHPGPwPUza
         FXqvnJPcXRvkusXNADwByyeJuqXuU9+1yekEPVrnS8dt8sAvXPFBOhl9db+iMzTlVkLL
         Wc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776415298; x=1777020098;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6+m189FrlHvlQluxfIKHyqtB0jWSsQDaVuzIa8Tqb+g=;
        b=XhS086ShDrU4SQoVhRwUCjfCGEwmgf36gKJFSSsbIS/sdhPeNNn5km7D3eqKQfdsZb
         EdamwNZaibv0on1uiIXjY/hMMY3Y2dnXNk7ieJMUvwVP9MOb5BR/g2WsGdw5JohXNdO7
         qVcenk2Ha1CciO27pP2Om8SIApGVJNTNwrqN3qJuvSmg9zrrf3Skp9hxRnmCTnaqLIG0
         1KarGs4YkYbtWREp82scHqttOMFnj+LHw4cd42C80KSzmGeRYz+5hiLbySiaB0fNKE0B
         8ENvPw9nCcqGC6PnhpTgrngE1SwpijwgFk6it62zBNradrqC2x3DOAZXtUAYnmO1oA+R
         BJxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wm8FbtUV69deI452SRyAI5Mvee3dXsjT4ZummdqIDx3Rix/XUFKMS5gZaerCAbHN6iQjKNIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+s6MtucOOgnUIa3GtC0JHZfdRTGgxfE/poUBocBnA8krbfhwz
	j3DCZvGYn5CAIPEpPg2VnCEJJycJRasB7CBHJbdP33qyTcYl9WPicxPTon3D49CgwYYNu2B1Mn+
	YSDQGpnZol1MBZ2DwVoMH2sDGWQ==
X-Received: from pfblu1.prod.google.com ([2002:a05:6a00:7481:b0:82f:24a1:2b5a])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3cc6:b0:82f:111:61d3 with SMTP id d2e1a72fcca58-82f8c970802mr2065492b3a.44.1776415297277;
 Fri, 17 Apr 2026 01:41:37 -0700 (PDT)
Date: Fri, 17 Apr 2026 08:41:34 +0000
In-Reply-To: <CABb+yY0uDQh-3cadPQONV=NJKjMtc4mJekgjmHYVaHnfHXvGZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY0uDQh-3cadPQONV=NJKjMtc4mJekgjmHYVaHnfHXvGZQ@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260417084135.2091007-1-joonwonkang@google.com>
Subject: Re: [PATCH v3 1/2] mailbox: Use per-thread completion to fix wrong
 completion order
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: angelogioacchino.delregno@collabora.com, jonathanh@nvidia.com, 
	joonwonkang@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-tegra@vger.kernel.org, matthias.bgg@gmail.com, stable@vger.kernel.org, 
	thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,nvidia.com,google.com,lists.infradead.org,vger.kernel.org,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-238461-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 85020418D10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, Apr 3, 2026 at 9:51=E2=80=AFAM Joonwon Kang <joonwonkang@google.c=
om> wrote:
> >
> > > On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@goo=
gle.com> wrote:
> > > >
> > > > Previously, a sender thread in mbox_send_message() could be woken u=
p at
> > > > a wrong time in blocking mode. It is because there was only a singl=
e
> > > > completion for a channel whereas messages from multiple threads cou=
ld be
> > > > sent in any order; since the shared completion could be signalled i=
n any
> > > > order, it could wake up a wrong sender thread.
> > > >
> > > > This commit resolves the false wake-up issue with the following cha=
nges:
> > > > - Completions are created just as many as the number of concurrent =
sender
> > > >   threads
> > > > - A completion is created on a sender thread's stack
> > > > - Each slot of the message queue, i.e. `msg_data`, contains a point=
er to
> > > >   its target completion
> > > > - tx_tick() signals the completion of the currently active slot of =
the
> > > >   message queue
> > > >
> > > I think I reviewed it already or is this happening on
> > > one-channel-one-client usage? Because mailbox api does not support
> > > channels shared among multiple clients.
> >
> > Yes, this patch is handling the one-channel-one-client usage but when t=
hat
> > single channel is shared between multiple threads.
>=20
> hmm.... how is this not single-channel-multiple-clients ?
> A channel is returned as an opaque token to the clients, if that
> client shares that with other threads - they will race.
> It is the job of the original client to serialize its threads' access
> to the channel.
>=20
> > From my understanding, the
> > discussion back then ended with how to circumvent the issue rather than=
 whether
> > we will eventually solve this in the mailbox framework or not, and if y=
es, how
> > we will, and if not, why.
>=20
> It will be interesting to see how many current clients actually need
> to share channels. If there are enough, it makes sense to implement
> some helper api
> on top of existing code, instead of changing its nature totally.
>=20
> Thanks
> Jassi

Hi Jassi, can we continue discussing this matter? We can start from the rec=
ent
comments from me.

Thanks,
Joonwon Kang

