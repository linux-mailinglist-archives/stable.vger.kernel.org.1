Return-Path: <stable+bounces-233190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INkhCPfTz2kQ1AYAu9opvQ
	(envelope-from <stable+bounces-233190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:51:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA72395610
	for <lists+stable@lfdr.de>; Fri, 03 Apr 2026 16:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D75C3025F4C
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313613C4568;
	Fri,  3 Apr 2026 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KFEIvQTc"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB50E39FCD1
	for <stable@vger.kernel.org>; Fri,  3 Apr 2026 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227883; cv=none; b=lPRF3prb3udWblPC+7BzmeBog4ALWslf1vFahDtTtZoWCLpuYP2Wj+qdLVgBx4iyYLJqOYCCb/tEkSFuWuK98gRZphClrvvaVwI85B49/Y6/9R1diKtRc9h5YxhXngahtEeW5kZNvuPk7McBOJszd6Av56bXKCNJjzBNTjwpYhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227883; c=relaxed/simple;
	bh=lzi8vanqoY23RZvoxmfl6DfLoVT0+U5Of4Av0npR8KQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nDoJZIpM8EMJAe48aptnJ0gA5JX5Erd8nyDlDIbi8yTqcv+D5GjBn+Zbu7SWQwIjzqaoQtenFB2sXg/ICXVHtkeJ2dzLkjx4McwXJ7UfZSAFOFyzCrvVaNubbszT9NUXk2Pqm2xDUbGtyidnkDX0CxoHppLb9PV/2y+1wG79YPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KFEIvQTc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b24af7ca99so23416395ad.1
        for <stable@vger.kernel.org>; Fri, 03 Apr 2026 07:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775227881; x=1775832681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsueJAB8iWMZmH12hTqYKPYVxfUoBPtsPuD5qctzJns=;
        b=KFEIvQTcxayFA/382PfH+WayA5yJekNqxGLlSBajU76J27sEf46lei5Xn8zQp6OeUH
         KcZ9BhTcHPVTIclssmpgmbDtjcubOh9DafzEdXeOdKl7gHH0FeWYqI5NSm3cpOKbWEr9
         g3dDWzcg4VmaapDUKTcDPLUr5KMiKBFnjnA6Ch7XDYdA3EUDl0gJvSYnjhkA83Ue/kYi
         6T+U7b9OPCkDeff3OtbBCIpxETm7ZUxBlUeFEVKoKWg8ar4InveULdQjyVpD5zKBWJwu
         bIJDhSlOvohto8w6zSO9T1c2TlYp/Puc6DPLAscxTH5dNXTpCF2kErmxfqJoaPdroSJ+
         kU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775227881; x=1775832681;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UsueJAB8iWMZmH12hTqYKPYVxfUoBPtsPuD5qctzJns=;
        b=sWeAxEfI7ztHd4/KHPP20NbzTHGU77DXhKdfWziYapQX/KoIMqLS62VWUjGbxvPP8L
         OnYJ7ZbNcEcL3xULieoGQenIyFyszIgvRIVAiCWqYWdY/WptUkPK6Z9seSMtObKCk9m+
         oVf2fSc83FIWbdT729xInbfWJVcgtMZ05E+zb1L4TIWlFFKz92PZsJuMtThNHdh4c3SL
         gVuGZasaRAj1BmKuP2HFYF1FxucFe35Bxjj5O+H/ix8gENH52YTV5IamsWejcBqxJpU6
         /aYg4Ny929xsSkRXkKH5YWZDB1fgZkPx4XSICyIk0gR0gzFDeIaq4ZpcAo5ruucCR+26
         z5sg==
X-Forwarded-Encrypted: i=1; AJvYcCXYRtDh6Ui2knO1ZfrkgsQktIbhulJmLFIilZzsokH1fTAg49C6BLkH3s0/uLqSrk/Rj9g3Jsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRzcS9Q2Ik0Ex1C5tQo50IhnhpaXUXxqbbqn4+9cRiFYZVDiHC
	cN22sIUrehqqONolGVpxRi1z4VaeshoywbbioOZcNlhbakEUa9R5hR4mAIcPuGxyG+aAj/s42hM
	LW86ia59b9oqVlmUVc54aGKJmnQ==
X-Received: from plblw8.prod.google.com ([2002:a17:903:2ac8:b0:2b0:af9b:aa3c])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2ac5:b0:2b2:42da:25cc with SMTP id d9443c01a7336-2b28163ad55mr35530115ad.1.1775227881118;
 Fri, 03 Apr 2026 07:51:21 -0700 (PDT)
Date: Fri,  3 Apr 2026 14:51:18 +0000
In-Reply-To: <CABb+yY0ub51k-eFpPfgARXtwYjWzRSjbPDLtoMD77YQR8JH+=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY0ub51k-eFpPfgARXtwYjWzRSjbPDLtoMD77YQR8JH+=Q@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260403145119.2581034-1-joonwonkang@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[collabora.com,nvidia.com,google.com,lists.infradead.org,vger.kernel.org,gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-233190-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8AA72395610
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang@google.=
com> wrote:
> >
> > Previously, a sender thread in mbox_send_message() could be woken up at
> > a wrong time in blocking mode. It is because there was only a single
> > completion for a channel whereas messages from multiple threads could b=
e
> > sent in any order; since the shared completion could be signalled in an=
y
> > order, it could wake up a wrong sender thread.
> >
> > This commit resolves the false wake-up issue with the following changes=
:
> > - Completions are created just as many as the number of concurrent send=
er
> >   threads
> > - A completion is created on a sender thread's stack
> > - Each slot of the message queue, i.e. `msg_data`, contains a pointer t=
o
> >   its target completion
> > - tx_tick() signals the completion of the currently active slot of the
> >   message queue
> >
> I think I reviewed it already or is this happening on
> one-channel-one-client usage? Because mailbox api does not support
> channels shared among multiple clients.

Yes, this patch is handling the one-channel-one-client usage but when that
single channel is shared between multiple threads. From my understanding, t=
he
discussion back then ended with how to circumvent the issue rather than whe=
ther
we will eventually solve this in the mailbox framework or not, and if yes, =
how
we will, and if not, why. I think it should still be resolved in the framew=
ork
for the reasons in the cover letter. Could you help to give a second review
with regards to those aspects?

Thanks,
Joonwon Kang

