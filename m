Return-Path: <stable+bounces-229033-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGmdKd9rwWkVTAQAu9opvQ
	(envelope-from <stable+bounces-229033-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:35:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B92F8628
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03142305CDF9
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8AF39A805;
	Mon, 23 Mar 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WYRMYrzm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E258F39182F
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774277844; cv=pass; b=dQ9CUNW6wF25B2SpQrRRQjuHrp0i8iYoqAjw73JOMW7Vp0wR8i7hDAYTNvd786zXszOkQpEh69hv12arnXqcaO1SYLlOOVWB2qJOJlrC0W0oBigxD6n6wNDWPDv0bOh4+2vxhoRmiqE0piSZinaB3wg185fC4z5fXM95321xauk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774277844; c=relaxed/simple;
	bh=xa31X6g9BeC+IddWCeUhisgT26L5F5MAtpjLruNnmBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lp/1+/0fTaPW9g0RgfNUunPHO6RJ5ZRdKnvRxj+o/H0B0AsREOknj4X/iZwZNW8AGVpkUpAMIMNSJLne4hPugVmzOYKhLZ2IWKFuBFINFnv1i12mW85263dyrwOiBEzlbrNLmF7CDWztixwyHnPciYhhJkpBWwDj9wCLKHTOCpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WYRMYrzm; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so752129a12.1
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 07:57:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774277841; cv=none;
        d=google.com; s=arc-20240605;
        b=izaoTvqmMQHFQZWjO9N8DPlbbRZE2GOnAsViCCt5OR1nn3KAFq+dLVSfDmvIBtI8VQ
         Wg+qHRfafg9zpGo8uvypi8Krf/R1OeUKrVaDMirnf5cZNBFHNRW5r2uqXJ9rGESma7Y0
         v3UR2qXqy3lnWj78IOBtVlygXYJH1ECDtwvQtUo64UumP75Q8CoOh2fWMkuzqgzabVjK
         36WphvDfbWBXktaHZ11Fbct0prSHEWZKW1C++vvvWjZPZhzU4DU5hQk4xnolPjeNl0Oe
         fttR/ANsSNE+q2gMctB2TbuzrQlSpKzuVoxQnxoAk5s9ILEdJpSHURR3i+Zhm3y8fiWp
         5xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fvBbBNsJFcFh6LZdhMnznYYLRi36NWaZNx0WnHPdGPc=;
        fh=WeoSnkxGt25DHCuHo7JeQDeIKsFcIrZjFPuiGV5zIGo=;
        b=CNj49zlA0GRbMKlrQqYpN0QKmy2PRSe6iNKBzoRTkzZOBloTB5P0OT4N8eQ8DgxwWK
         YcFKZmP/L52NbTWfk1pzG7rEPWCmiD5PA9gclBEiJbF1MVZKqnZ9rnB6wnHmnqA5OL4S
         39VmeMbcmhpcTlxD1gU0d+XWioGGBnSbYj21GWVQsReG5oIVmvU35aPUi0AL8ugyEtS/
         YEAkA/brM3LVjEOKmghSR4nsxb2fMVcLv1QHDnRAFIQezcKwCI8vlpaYRxdxkk5rcwmX
         m11Rs8O55pZ9mkIqrgfC/gOAEiz67lmurkwFBSNXb+ZYAcG+H/stuF/cEbwzUB7xsL/s
         0dYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774277841; x=1774882641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvBbBNsJFcFh6LZdhMnznYYLRi36NWaZNx0WnHPdGPc=;
        b=WYRMYrzmfGyMdkKvz7/8NnP/GUAHAvLeL1yRSLNSzPxtrFM56adPjUFW2GpQ37Qkv8
         tkmYT0yTXg66cH/v84UFbIopJcn92CouN+Dbap7+aE214y46Q0YNQkek0aYJZhP4ZU8C
         qL+B6dRGiJ0gKKwPU1vGYl+hx77xPX3s588wzKWrJ9+WZksYTWHNRq35cKNbludmFdQa
         ABgzlunwove+zzi4OnwhNHTvJ62ZVGux6NcBLNSVBNsY9OU8GYu0H2A1VBmzeFzkaQEx
         eC9CsfjRN/P+baJiC9RJ/tcZQIspQ43GM0zzcH4QvSP1Xqgw31IXz/RQOMriOAI3Lx+2
         HtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774277841; x=1774882641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fvBbBNsJFcFh6LZdhMnznYYLRi36NWaZNx0WnHPdGPc=;
        b=iFGxIbh/UcOcaMVGiNyjgICjwun8QX0+qV3ht2pC/dO6NFikQ1T8al4HVEggehiNCm
         WJzdbR/O6ANMv1erOePy5eGCs6AHw+leOtvAdGwxZ9kD++M9AjcSdtWZFvLe02Y+ZZxg
         njncIpkFcju0UAOLt4Ltf5kHQ1pT7561XSmMK4Rt8dbPxRs+NF3kU96Cb7wibRee/Y1/
         ih53sHKR5LLqysRUTE1Krdl9I/irjyPq5vbElfzYKCzrz4XMPdnUVlYJLlxBzjejCETe
         VY+xKThG9jUbEAYJxhKgkxlKjDtKicYxfuw8pa0HhANZF227ZL+49yISIgjyIMw/HiZc
         r7dw==
X-Forwarded-Encrypted: i=1; AJvYcCXW+PLQ2FdByUYpV/Za3Fvnn2YG2rpxNPPsWU2RiE2+FUZDou457JDTCrbFNXviXA3iEgYxMt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgbxlC1tu5o048kUu8I+frfDoqiDDns+81fBKvuZjQQooXX2S
	7gL+xenmddZv1e1LhoH5scEZM29FjWfohKGIyDM5IQ+v83FM5el47/sX//sh/mVFkEr6Rd+In5n
	8DtFqWYtoBKoLcW5Deo9xQJnFZlgZ11pQb6t/
X-Gm-Gg: ATEYQzyf+UMSk1xMjCdXAJ3zz60xF+LkBLCKhn9phgMRkxC4h+SakCKJkpDmubbblCD
	+KQ7Z9MItthcRMyT8xzw0hQm8MDbbj8HxEI7x/LZAgUH0uJfaksUPI4Nc4fGbZK3PtPcgozNqyu
	bymeCvXn4Ybb/gMxWB6rKINB0UEryK1gIhV3Hu2BtRx5+y+v2n9hq+4K6oT07tV+qF0OLX876Gj
	zWSRFDt2MLqWYaQzmgLC3Z6RoXaMF9BVc23x1UrcoS5GDWukIRsO12fDO93r1Km3vN1GmcYFMGm
	OAwTh0ZS6UcPcTe+dYk=
X-Received: by 2002:a17:907:394:b0:b97:7157:e1d8 with SMTP id
 a640c23a62f3a-b982f362ce4mr665161666b.31.1774277840831; Mon, 23 Mar 2026
 07:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322171752.608486-1-jassisinghbrar@gmail.com> <20260323051359.3167665-1-joonwonkang@google.com>
In-Reply-To: <20260323051359.3167665-1-joonwonkang@google.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 23 Mar 2026 09:57:07 -0500
X-Gm-Features: AQROBzBe_IwTDmRX3xv3pKLn1drI9MBmr7nvWb2-uieo7Ubr1p6hTCoz3FnKSmk
Message-ID: <CABb+yY2aAiAFU5iCBmBdpkTM6_4VMh7BFPbwKxwt-gdN-qqLWw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Fix NULL message support in mbox_send_message()
To: Joonwon Kang <joonwonkang@google.com>
Cc: andersson@kernel.org, dianders@chromium.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	maz@kernel.org, shawn.guo@linaro.org, stable@vger.kernel.org, tglx@kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-229033-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jassisinghbrar@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 1E2B92F8628
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:14=E2=80=AFAM Joonwon Kang <joonwonkang@google.c=
om> wrote:
>
> > The active_req field serves double duty as both the "is a TX in
> > flight" flag (NULL means idle) and the storage for the in-flight
> > message pointer. When a client sends NULL via mbox_send_message(),
> > active_req is set to NULL, which the framework misinterprets as
> > "no active request". This breaks the TX state machine by:
> >
> >  - tx_tick() short-circuits on (!mssg), skipping the tx_done
> >    callback and the tx_complete completion
> >  - txdone_hrtimer() skips the channel entirely since active_req
> >    is NULL, so poll-based TX-done detection never fires.
> >
> > Fix this by introducing a MBOX_NO_MSG sentinel value that means
> > "no active request," freeing NULL to be valid message data. The
> > sentinel is defined in the subsystem-internal mailbox.h so that
> > controller drivers within drivers/mailbox/ can reference it, but
> > it is not exposed to clients outside the subsystem.
>
> It sounds that it allows future controller drivers also to refer to the
> new sentinel pointer value.
>
Sentinel value is not the problem, active_req should have been hidden
from controllers. Which is actually respected by all controllers
except the tegra-hsp.c

> >
> > Fifteen in-tree callers send NULL (doorbell-style IPCs on Qualcomm,
> > Tegra, TI, Xilinx, i.MX, SCMI, and PCC platforms). All were
> > audited for regression:
> >
> >  - Most already work around the bug via knows_txdone=3Dtrue with a
> >    manual mbox_client_txdone() call, making the framework's
> >    tracking irrelevant. These are unaffected.
> >
> >  - Poll-based callers (Xilinx zynqmp/r5) are strictly better off:
> >    the poll timer now correctly detects NULL-active channels
> >    instead of silently skipping them.
> >
> >  - irq-qcom-mpm.c was a pre-existing bug -- the only Qualcomm
> >    caller that omitted the knows_txdone + mbox_client_txdone()
> >    pattern. Fixed in a companion commit ("irqchip/qcom-mpm: Fix
> >    missing mailbox TX done acknowledgment").
> >
> >  - No caller sets both a tx_done callback and sends NULL, nor
> >    combines tx_block=3Dtrue with NULL sends, so the newly reachable
> >    callback/completion paths are never exercised.
> >
> > Also update tegra-hsp's flush callback, which directly inspects
> > active_req to wait for the channel to drain: the old "!=3D NULL"
> > check becomes "!=3D MBOX_NO_MSG", otherwise flush spins until
> > timeout since the sentinel is non-NULL.
> >
> > The only tradeoff is that 'MBOX_NO_MSG' can not be used as a message
> > by clients.
>
> The other, but I guess more important, tradeoff is that future controller
> driver developers should now know that the pointer value of `->active->re=
q`
> could be -1(=3D=3D MBOX_NO_MSG) other than conventional pointer value(mem=
ory
> address, NULL, or error-encoded pointer value).
>
That should not be a concern. Controller drivers shouldn't peek into
mailbox internals and if they do they will know the sentinel value
being used.
For example, of the ~40 drivers, only tegra-hsp.c chose to (not had
to) use active_req and it relied on the sentinel value, which will now
be MBOX_NO_MSG.

Thanks
Jassi

