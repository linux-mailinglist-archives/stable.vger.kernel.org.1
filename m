Return-Path: <stable+bounces-227884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEMYDR/MwGlwLAQAu9opvQ
	(envelope-from <stable+bounces-227884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 06:14:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A253A2EC97C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 06:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C72C30062D6
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 05:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE64329DB64;
	Mon, 23 Mar 2026 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jASpxxYf"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770B0299AAB
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774242842; cv=none; b=GAxN/wCs1T+XjqbPGyxuiRasY5PKrGzavImdqiLP8NjN60crRn7r5WLGjsGGbr4BHuZT7SHFSQ6Jvt54ljwbEQdkA+MjxcylsqrWEtAbuQUxxg5IGK6tHBVnNeaZbhbxiKVhmalwm+Nd0ucewNDTwd+s9RzURVjC1++pCpwsYL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774242842; c=relaxed/simple;
	bh=z6Zcgc+MXbi/QN7rQlvUnN2XBI1eboxvkMdP4BVwfr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=h5+X/1eGhjn5hMVylkq1QsOKezcNr9SiCjUi3nFsL45ezITqpv1HFugZX1ujR9oTh3iVcPLVhnCQWHClYLtp4hsf+GTAHcu4r+RSQgfLLRwJsxWyUfeO+eqkjt5dFRoUobTY5tXH3pdi14qSnaKNjsoJavJ7qGF8LldZDod2GoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jASpxxYf; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b0601ff3d9so52995175ad.2
        for <stable@vger.kernel.org>; Sun, 22 Mar 2026 22:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774242841; x=1774847641; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J6K2uMlwdA0abghu8MqcrivTleBIcvizA9okA+4Axro=;
        b=jASpxxYfFk6r4L7Bz1+MgIAB3upjqnlHURnED2UvAsXuGpFdU/A6Ya7Yw2benaHXRq
         PHjqbWEBJb/ElpZYRfQlyQbh/G4UP9fApX98VyOmxIREE6/BYFfc0LIIH2tY0emfCGpO
         nbNdWwsocuYU9mGqrxI9MzdRviXOs6JfWFdjcUvXBvHbtnRa+5vHs3GmlECmgsDVsVBv
         9aSXrJiF2/4UYeRuJ7aoPutaeqSvgN24GUVjhjrQtSQHYdOmuWJjphFEMbUwQ5Bfjcc7
         9JvQ6+V/7fKP2EW+p7Ycr674amde0eE0Jfx+yEzZdW2yvVqUEJZ5piAtYqTK9SQJNnz2
         HeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774242841; x=1774847641;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J6K2uMlwdA0abghu8MqcrivTleBIcvizA9okA+4Axro=;
        b=aFjD8hoyR/FgVWdu1jCKwU/fgjojqczrRZf6r/sgYm+YiUqJ7Z7hIwgT12FkTy4oop
         5df55YwxW+voddzM9htZUY3XnJjtcfglsj2+wS1Nh2enDs8GejaIzDITVcxe7yIJTuGW
         qHGd2OvcMh5ieefLRe+jDPBBCUVdPrW0I1B0IpzyMTaE3CJc24ucd/BdIVZKCA1qJMCX
         ypgu5yBKb0rEgkFydjwmMAzseumqOIwrLV8vh9y+KTQHhE+IoHCHiViIxYJtQZz5fqST
         El0KOKRWujcUVJybkW9nGWUnitKtoJ0WjtaRzvNqbaeSij4LuLA/hPi5c9OhiKfEU8q+
         7h6g==
X-Forwarded-Encrypted: i=1; AJvYcCX0mF2FN4bzLrq2qNJrfGEcTKaUTCoO2DUsIelLgy0f6x0fuOspy3s17HgwsIPzJuEJyOKI9k0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7GpmZgh59mx4f8acrrwJ128J5V1w9mRvRGJMKZckywBlhGFDD
	iX+0zcr1ePcu2sDIWZJLqhfcDfgSFhcx8Meetm0LPPCEzXraFFdtApdUQT3i3s7WrlEglNX98Is
	olmeCt6lRJKXv+cWADPVtV80uFg==
X-Received: from plha16.prod.google.com ([2002:a17:902:ecd0:b0:2b0:5538:b55d])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e5ce:b0:2b0:59c4:e9dc with SMTP id d9443c01a7336-2b08271d4ecmr101423305ad.22.1774242840657;
 Sun, 22 Mar 2026 22:14:00 -0700 (PDT)
Date: Mon, 23 Mar 2026 05:13:59 +0000
In-Reply-To: <20260322171752.608486-1-jassisinghbrar@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260322171752.608486-1-jassisinghbrar@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260323051359.3167665-1-joonwonkang@google.com>
Subject: Re: [PATCH] mailbox: Fix NULL message support in mbox_send_message()
From: Joonwon Kang <joonwonkang@google.com>
To: jassisinghbrar@gmail.com
Cc: andersson@kernel.org, dianders@chromium.org, joonwonkang@google.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	maz@kernel.org, shawn.guo@linaro.org, stable@vger.kernel.org, tglx@kernel.org, 
	akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
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
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-227884-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joonwonkang@google.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Queue-Id: A253A2EC97C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> The active_req field serves double duty as both the "is a TX in
> flight" flag (NULL means idle) and the storage for the in-flight
> message pointer. When a client sends NULL via mbox_send_message(),
> active_req is set to NULL, which the framework misinterprets as
> "no active request". This breaks the TX state machine by:
> 
>  - tx_tick() short-circuits on (!mssg), skipping the tx_done
>    callback and the tx_complete completion
>  - txdone_hrtimer() skips the channel entirely since active_req
>    is NULL, so poll-based TX-done detection never fires.
> 
> Fix this by introducing a MBOX_NO_MSG sentinel value that means
> "no active request," freeing NULL to be valid message data. The
> sentinel is defined in the subsystem-internal mailbox.h so that
> controller drivers within drivers/mailbox/ can reference it, but
> it is not exposed to clients outside the subsystem.

It sounds that it allows future controller drivers also to refer to the
new sentinel pointer value.

> 
> Fifteen in-tree callers send NULL (doorbell-style IPCs on Qualcomm,
> Tegra, TI, Xilinx, i.MX, SCMI, and PCC platforms). All were
> audited for regression:
> 
>  - Most already work around the bug via knows_txdone=true with a
>    manual mbox_client_txdone() call, making the framework's
>    tracking irrelevant. These are unaffected.
> 
>  - Poll-based callers (Xilinx zynqmp/r5) are strictly better off:
>    the poll timer now correctly detects NULL-active channels
>    instead of silently skipping them.
> 
>  - irq-qcom-mpm.c was a pre-existing bug -- the only Qualcomm
>    caller that omitted the knows_txdone + mbox_client_txdone()
>    pattern. Fixed in a companion commit ("irqchip/qcom-mpm: Fix
>    missing mailbox TX done acknowledgment").
> 
>  - No caller sets both a tx_done callback and sends NULL, nor
>    combines tx_block=true with NULL sends, so the newly reachable
>    callback/completion paths are never exercised.
> 
> Also update tegra-hsp's flush callback, which directly inspects
> active_req to wait for the channel to drain: the old "!= NULL"
> check becomes "!= MBOX_NO_MSG", otherwise flush spins until
> timeout since the sentinel is non-NULL.
> 
> The only tradeoff is that 'MBOX_NO_MSG' can not be used as a message
> by clients.

The other, but I guess more important, tradeoff is that future controller
driver developers should now know that the pointer value of `->active->req`
could be -1(== MBOX_NO_MSG) other than conventional pointer value(memory
address, NULL, or error-encoded pointer value). Although I am still not
sure if this is better than changing the type from pointer to integer
index to make the intention clearer, could you add API doc for
`->active_req` that it may become MBOX_NO_MSG when no active request
exists? Otherwise, it is likely that the future driver developers just use
NULL to check the channel emptiness and also are not aware that this
pointer could be assigned the unconventional value -1. Just like this
mis-use case of `->active_req` was not caught in tegra-hsp.c in the first
attempt of this patch, it could be hard the same way for controller driver
developers to avoid/prevent the mis-use without proper API doc.

Thanks.

