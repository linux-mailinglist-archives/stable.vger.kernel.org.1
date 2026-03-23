Return-Path: <stable+bounces-229530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iERTF5towWliSwQAu9opvQ
	(envelope-from <stable+bounces-229530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:21:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E5F2F7F42
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D610930526FB
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB98340282;
	Mon, 23 Mar 2026 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LFowTPEE"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD872737E0
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280603; cv=none; b=DuylTd6SEhZqsaaIS1L6WlRy5iYXKEeJjiB20yZeCDgCv8lkPCFYeJPnHUR8ECkN7fCz3TLC40+euZbOkAtPFb+kdlolukfJuyT7pWdabTtBe2GDPGKOO6cN9nbOTiHU8eqCxGDmU3IXcQ7gGbh4KiJKXicfXP6FWKIA3cr88BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280603; c=relaxed/simple;
	bh=WPk9hJKY9yIejC2OvAtD6PGuurXMZbYicfSRUnFT9TY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k67p/K5bKFTTmG4R3Xh2newD+qvXkiZp/bhEXMsxCl5HWn2rhgPempT0FV/sndOXedPg+Nc1FpmzNYYBAkN/vLaGkZDnsvsfrczL3GQ5XfjCXmsLADGVo1rKDMB207x0/nNBeu3Rz1X7k+eh4ffdauAVsc0UZVFfDPp7+aGCo9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LFowTPEE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c73781252edso18829959a12.0
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774280601; x=1774885401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+UYSRLmdUz8m2ECEPbWoYNIW4mZEno4VBvItMsoE48=;
        b=LFowTPEENS2C2UiRzh0I8t2VbeiSwMpu1N4ifAwnZNZZhvG1J9MOpKJuTGJ4q5e42x
         osFkqGRZfcS687Hf5nHYGbP3DAqt5h+Y1ODmRKrD4MetULUNoU2S9e9vQIUIJsYienjB
         iXWqLqpeu99zf6ge6HK8c++Mc7hfBzEonvu/H77UNJc3JORqsqBGVQ05TGq/XR6scKFC
         KvEKojBnldvnBYTw8ShR73ZM5n9eR+/z5oK6tZ1cSVtgqd/XHay4IPgLJdK6cjsV609I
         uUqKW89bwWsHTDdlH1E0zTCsYujyJR0DAYhf9+hJ/q5nL6bj4h7u7pNbk9zh33lQdIVJ
         2nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774280601; x=1774885401;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V+UYSRLmdUz8m2ECEPbWoYNIW4mZEno4VBvItMsoE48=;
        b=f+TFk/1iUOSSejDl6heY9Pqj1t1RQO2O21OxYTErWpWxCdOyKzzRDF54LtF0Dj/Cqm
         lidjuNkeoAD0DoiBayUPRx+xQcr7Is4HsWD2v1x2jsRXiidOu39VYbAv+Rkew+cQS98a
         VVKhfGf4TJwAIrobyc6gS6oCyUQkSt8nihmKfSobnNrnci7U6wZ+q0FK8qan7vYPJvI4
         j7EyB788ltTGGqGYiYEJbklv2Xk4ZuHaxUWKDtB7uq3CQxGgUvTHMOVuiVL2Yxux5qs2
         QXtu5Jaa8BxbWAOXetmwplQKG16rnMuurduHLuZjppfssGd8ovcIAJitZLxlnexDBplR
         AulA==
X-Forwarded-Encrypted: i=1; AJvYcCVh3U36xsT0EtHlVROqPZjKYJQQCOtb80nLDkBzU3+v8ILWNuaYs1ZmcF3zK+6WB1VonPqVAZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc9O/21bUNi0WwusEIuRa3J538tMap0HN6g2zZTpOMRf3y7Sik
	NuxtCK5G+ho5PKBCCgBeNtF0JuondgI9yAuMatSUoqk+SyUX7Ed+IIWphhPnRlIoDLL31K2e1Qf
	/Bs02DGCi6oOdeDaIrKrH64OTVg==
X-Received: from pgbbw35.prod.google.com ([2002:a05:6a02:4a3:b0:c73:fc44:8bb5])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7d9a:b0:398:90e5:a9b9 with SMTP id adf61e73a8af0-39bce9f7ac5mr12047793637.27.1774280601248;
 Mon, 23 Mar 2026 08:43:21 -0700 (PDT)
Date: Mon, 23 Mar 2026 15:43:16 +0000
In-Reply-To: <CABb+yY2aAiAFU5iCBmBdpkTM6_4VMh7BFPbwKxwt-gdN-qqLWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CABb+yY2aAiAFU5iCBmBdpkTM6_4VMh7BFPbwKxwt-gdN-qqLWw@mail.gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260323154319.3523356-1-joonwonkang@google.com>
Subject: Re: [PATCH] mailbox: Fix NULL message support in mbox_send_message()
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: akpm@linux-foundation.org, andersson@kernel.org, dianders@chromium.org, 
	joonwonkang@google.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, maz@kernel.org, shawn.guo@linaro.org, 
	stable@vger.kernel.org, tglx@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229530-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 01E5F2F7F42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> On Mon, Mar 23, 2026 at 12:14=E2=80=AFAM Joonwon Kang <joonwonkang@google=
.com> wrote:
> >
> > > The active_req field serves double duty as both the "is a TX in
> > > flight" flag (NULL means idle) and the storage for the in-flight
> > > message pointer. When a client sends NULL via mbox_send_message(),
> > > active_req is set to NULL, which the framework misinterprets as
> > > "no active request". This breaks the TX state machine by:
> > >
> > >  - tx_tick() short-circuits on (!mssg), skipping the tx_done
> > >    callback and the tx_complete completion
> > >  - txdone_hrtimer() skips the channel entirely since active_req
> > >    is NULL, so poll-based TX-done detection never fires.
> > >
> > > Fix this by introducing a MBOX_NO_MSG sentinel value that means
> > > "no active request," freeing NULL to be valid message data. The
> > > sentinel is defined in the subsystem-internal mailbox.h so that
> > > controller drivers within drivers/mailbox/ can reference it, but
> > > it is not exposed to clients outside the subsystem.
> >
> > It sounds that it allows future controller drivers also to refer to the
> > new sentinel pointer value.
> >
> Sentinel value is not the problem, active_req should have been hidden
> from controllers. Which is actually respected by all controllers
> except the tegra-hsp.c
>=20
> > >
> > > Fifteen in-tree callers send NULL (doorbell-style IPCs on Qualcomm,
> > > Tegra, TI, Xilinx, i.MX, SCMI, and PCC platforms). All were
> > > audited for regression:
> > >
> > >  - Most already work around the bug via knows_txdone=3Dtrue with a
> > >    manual mbox_client_txdone() call, making the framework's
> > >    tracking irrelevant. These are unaffected.
> > >
> > >  - Poll-based callers (Xilinx zynqmp/r5) are strictly better off:
> > >    the poll timer now correctly detects NULL-active channels
> > >    instead of silently skipping them.
> > >
> > >  - irq-qcom-mpm.c was a pre-existing bug -- the only Qualcomm
> > >    caller that omitted the knows_txdone + mbox_client_txdone()
> > >    pattern. Fixed in a companion commit ("irqchip/qcom-mpm: Fix
> > >    missing mailbox TX done acknowledgment").
> > >
> > >  - No caller sets both a tx_done callback and sends NULL, nor
> > >    combines tx_block=3Dtrue with NULL sends, so the newly reachable
> > >    callback/completion paths are never exercised.
> > >
> > > Also update tegra-hsp's flush callback, which directly inspects
> > > active_req to wait for the channel to drain: the old "!=3D NULL"
> > > check becomes "!=3D MBOX_NO_MSG", otherwise flush spins until
> > > timeout since the sentinel is non-NULL.
> > >
> > > The only tradeoff is that 'MBOX_NO_MSG' can not be used as a message
> > > by clients.
> >
> > The other, but I guess more important, tradeoff is that future controll=
er
> > driver developers should now know that the pointer value of `->active->=
req`
> > could be -1(=3D=3D MBOX_NO_MSG) other than conventional pointer value(m=
emory
> > address, NULL, or error-encoded pointer value).
> >
> That should not be a concern. Controller drivers shouldn't peek into
> mailbox internals

Thanks for this clarification on your intention. This resolves the afore-
mentioned concerns.

> and if they do they will know the sentinel value
> being used.
> For example, of the ~40 drivers, only tegra-hsp.c chose to (not had
> to) use active_req and it relied on the sentinel value, which will now
> be MBOX_NO_MSG.
>=20
> Thanks
> Jassi

Thanks,
Joonwon Kang

