Return-Path: <stable+bounces-238541-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJyxAAL94mncBAEAu9opvQ
	(envelope-from <stable+bounces-238541-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 05:39:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B041FDB5
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 05:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9EF30305D0
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 03:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF67313E03;
	Sat, 18 Apr 2026 03:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KfubM8NL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856A7244675
	for <stable@vger.kernel.org>; Sat, 18 Apr 2026 03:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776483544; cv=none; b=X4wFlZtLvLMvCCAzcbVJI/FMFn6TIik9K+JddCj4aGDK20F7wqovBQr2nS5NVm6CxuyVI/wSwG5UYcpZqCVXEt9UCmKhXawLMxYW7CtO0yff5VUtk075WmMnmTFZgh7UOT07NDGryy6cT4u9JcEWSrUk6ThR12TCy2YiDiRQMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776483544; c=relaxed/simple;
	bh=G+ETtzwm86y2ubyHKvTZyBSdg3SjvxcOgxe973ohm5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DXxF+BFUPoZQc/PUBf1t0dt6Rj63Yphoiwf22QFJVe+MVIQP6yn+20Dczly1vPnjCrDo3a6pfjSC2E9WA8vzLy5gV/F6cOEAJjhudiZ7DBQqV+3gTVZeuNFIOjtcpyN33YFaQOrtLLwkGUDiTuL0t2/tryXakxx8VPSNRG0TPKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KfubM8NL; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354bc535546so1231875a91.3
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 20:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776483543; x=1777088343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G+ETtzwm86y2ubyHKvTZyBSdg3SjvxcOgxe973ohm5w=;
        b=KfubM8NLzlZlE1wq7b54dcvzl18ZF7uGnCXD2jDdg+S6Q/FeyVOGdhHlZGzau8vvRT
         tjNNxAK3xJX3jCxT9b9jI2muzv+DicnnU9+0tEOVGxs4hDRdJKnRL6wuPMkr8oN8guSP
         9MbTx54IduTxAaemmh2OHi9Cs8GVtWH3j4k527Mf9mU41xdav35yRf0dhmxj4DCvdvy/
         ILySRynBjfhybtb1iK7AoTLkl3JisShlzs6bmEWL47n8/H/eY1xGLG0SlZIWgW2jgCYI
         V6pySQz9k/FuGoUliD1n2mtNF9verKkDKIv8vYgACs7g1VAyXetA1ksy+2kylp9YIbBI
         yxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776483543; x=1777088343;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G+ETtzwm86y2ubyHKvTZyBSdg3SjvxcOgxe973ohm5w=;
        b=IJU/9Ly+zU6lJCu+/ctQw5wVs/rr1bqVjVoPb2uTYw/oE/jIw0vY9DkykxpFcgo/KL
         r0hUCzxUV8pTfLwwOgMDiYpOgXaSoI9NW2wuUQ1ErY49jA7mg5WljTU2aLUWlIBFunsR
         MFGgTuTNULYr44awWZGQ1TQ6FIskIjrHXvKAYchCRE/tN6YPPrOaZguAlPcv9eMp7sJn
         v9ZPoAAa4STUfXCPLfmoMofmXj50vjxha0HUxet0oivOovI0Oih8e8PiTJLauGmT00JH
         Ti9M9CNj5RX57aFdf9JzGlf8tcba7ZVj957m4t6PZPBOzWX/1pNB6+9VWZXe3xXDrBE9
         REcw==
X-Forwarded-Encrypted: i=1; AFNElJ/2oxUz2jMSGiUNf32O/F5fsGRAA1jAmoe0DaOe+5wBm3vTtvUZvHY4ayPRF5mjYisz/4TRlWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0S9BwG4ZJj/Urwwx5vcptGVefYcPjWEr3SKaz8mU3USFWNk5F
	NuLbfrYu/k6KOjr354ZBE5CSALp6snTIBbn8cU9e9NQQtjMfihb2JT16hkaaJJ6mY5q6IhjuT6r
	Sbc3ViecJvTMOCJy5pJTmbFlMSQ==
X-Received: from pgbfp6.prod.google.com ([2002:a05:6a02:2ce6:b0:c76:a6b1:ed23])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6300:8088:b0:39f:216:f400 with SMTP id adf61e73a8af0-3a08d708cc3mr4939472637.14.1776483542721;
 Fri, 17 Apr 2026 20:39:02 -0700 (PDT)
Date: Sat, 18 Apr 2026 03:38:59 +0000
In-Reply-To: <CABb+yY2yBZ+hgr-=Uh_sRk-TJZRfsk2AYtoS5rPtUN8kVsUScA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY2yBZ+hgr-=Uh_sRk-TJZRfsk2AYtoS5rPtUN8kVsUScA@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260418033900.3652042-1-joonwonkang@google.com>
Subject: Re: [PATCH v3 2/2] mailbox: Make mbox_send_message() return error
 code when tx fails
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: akpm@linux-foundation.org, angelogioacchino.delregno@collabora.com, 
	jonathanh@nvidia.com, joonwonkang@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org, 
	matthias.bgg@gmail.com, stable@vger.kernel.org, thierry.reding@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238541-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,collabora.com,nvidia.com,google.com,lists.infradead.org,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 667B041FDB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Fri, Apr 17, 2026 at 3:43=E2=80=AFAM Joonwon Kang <joonwonkang@google.=
com> wrote:
> >
> > > On Fri, Apr 3, 2026 at 10:19=E2=80=AFAM Joonwon Kang <joonwonkang@goo=
gle.com> wrote:
> > > >
> > > > > On Thu, Apr 2, 2026 at 12:07=E2=80=AFPM Joonwon Kang <joonwonkang=
@google.com> wrote:
> > > > > >
> > > > > > When the mailbox controller failed transmitting message, the er=
ror code
> > > > > > was only passed to the client's tx done handler and not to
> > > > > > mbox_send_message(). For this reason, the function could return=
 a false
> > > > > > success. This commit resolves the issue by introducing the tx s=
tatus and
> > > > > > checking it before mbox_send_message() returns.
> > > > > >
> > > > > Can you please share the scenario when this becomes necessary? Th=
is
> > > > > can potentially change the ground underneath some clients, so we =
have
> > > > > to be sure this is really useful.
> > > >
> > > > I would say the problem here is generic enough to apply to all the =
cases where
> > > > the send result needs to be checked. Since the return value of the =
send API is
> > > > not the real send result, any users who believe that this blocking =
send API
> > > > will return the real send result could fall for that. For example, =
users may
> > > > think the send was successful even though it was not actually. I be=
lieve it is
> > > > uncommon that users have to register a callback solely to get the s=
end result
> > > > even though they are using the blocking send API already. Also, I g=
uess there
> > > > is no special reason why only the mailbox send API should work this=
 way among
> > > > other typical blocking send APIs. For these reasons, this patch mak=
es the send
> > > > API return the real send result. This way, users will not need to r=
egister the
> > > > redundant callback and I think the return value will align with the=
ir common
> > > > expectation.
> > > >
> > > Clients submit a message into the Mailbox subsystem to be sent out to
> > > the remote side which can happen immediately or later.
> > > If submission fails, clients get immediately notified. If transmissio=
n
> > > fails (which is now internal to the subsystem) it is reported to the
> > > client by a callback.
> > > If the API was called mbox_submit_message (which it actually is)
> > > instead of mbox_send_message, there would be no confusion.
> > > We can argue how good/bad the current implementation is, but the fact
> > > is that it is here. And I am reluctant to cause churn without good
> > > reason.
> > > Again, as I said, any, _legal_, setup scenario will help me come over
> > > my reluctance.
> > >
> > > Thanks
> > > Jassi
> >
> > Hi Jassi, can we continue discussing this issue from where we left off =
last
> > time?
> >
> Long passionate essays are difficult to read, so I haven't yet. A
> simple description of some setup that you think is not supported, will
> keep the discussion focused.
> If your platform is supported but you think the api is not clear,
> updates to the documentation are welcome

Sorry that it was hard for you to read. The long form was to explain what i=
s
misaligned and problematic with data and examples for better understanding
because your previous long essays did not make much sense to me. Please go
through it and let me know if anything is unclear to you. In the mean time,=
 I
will prepare a new version of patch with some update to the API doc.

Thanks,
Joonwon Kang

