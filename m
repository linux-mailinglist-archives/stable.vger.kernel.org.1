Return-Path: <stable+bounces-225703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNZRJNJsuGn5dgEAu9opvQ
	(envelope-from <stable+bounces-225703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:49:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E99072A0604
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 21:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C148D30B849B
	for <lists+stable@lfdr.de>; Mon, 16 Mar 2026 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9204035837B;
	Mon, 16 Mar 2026 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FfDKZnIn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60F351C34
	for <stable@vger.kernel.org>; Mon, 16 Mar 2026 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694075; cv=none; b=YQU5ZN176Q/NcJMwDWAqEbejZuFSqHSF1S4OSsjc2OiaFWss2GjYKzx1h6Cen/MRhO2gwayPcnn1nVMeXS8wJ6nHVwX+dfk1n4qxX2Jr22aXI7ocHrmeK9v+mCZUXtdqbsDAp0XuyZcDKD7QLiXhYbe8eYYwrteck7U4mpXN/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694075; c=relaxed/simple;
	bh=AvzXent5GAzYEhwtNPXvUKMvACnTTP2WbxKA8jAaQgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSmgpP+f2mP6kVZ06OEIwRi5oLrWampqC+Tq+OwUuNl/t8J87hdGj9IOQZ1MVgVEkJ1tcaOTOD3wBIhmChDe27GVbrEaSibvjU6QjOP/w3P+yvTasIh8phb6Tu3zJY4ZGOgOQ41uZMlnUd9x+ntESqa9TT12SwjVmAVO4ALCAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FfDKZnIn; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6616cb8c80cso7718185a12.0
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773694068; x=1774298868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2tF2wn//6n8gLyKh+AWrve4YV7UXxjVu+ueg8xDWvs=;
        b=FfDKZnInzdaDTl/gxLD2+HXKwYMzvAw7pZL/kNEOZScAt31uVPsPxBQxyiKF4TOZse
         G9pABfuTXjY56mOc1ghTNAYlZHIYVxh2W0yWOZ5yymEpIMGbVbE4ikg2yePEVmyCOJ5O
         Efv26JlPALPCKkpCuGEqo1E1vJcUY4uQTd35o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773694068; x=1774298868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l2tF2wn//6n8gLyKh+AWrve4YV7UXxjVu+ueg8xDWvs=;
        b=ioX7YWEGBTNH284yeDw/8D5eyuOt6y/PfHCqUM4DmqlwVDF8BAnn+I2CCKjhNIp+4F
         vruyBjdLFEP/NGSg5RGe9bU+8WL4jnuDD7mr2jMwDq0SI6dL03Ao1qyHsGS4NA4WKi8T
         jbYmyxCmwjFTajcif+b11/IukPAolBjfoActeakkaiC789f122dTb86r2GADpSfnsMjQ
         1xo3tn8Ia233khID9m3vfJddlyaCojniopyHmSyx5libiUsel5XyDptqI0G/rQcAOkFH
         BAK3c+mPRo0GCVim9GN27G3yTslPkaTWWoDFM1LEWjPh+f0DLuiLIVWa946f3PqU7G4r
         GCww==
X-Forwarded-Encrypted: i=1; AJvYcCUr5GZZpXg+bDUUdqpPYRishh1AT8R3Uj58ziWRhOynq2QvRRHpkBNRuKng0ynlBxr888sqbpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYL93QJZAO3LievcEo07FaIpyr20EJwmkNa043PjYbSnWyyDH
	b3pr0xPqD+GbT28cyF929ff25dTIUF3Fgnpw8nFcolAYW9fX2oqwsBV2NgjnqBmGkzrI0p/Lg1y
	G9YU=
X-Gm-Gg: ATEYQzyPslONJYZOLjUa9dOerZzg/x4VDaEgYk8lY3CNo7R7gdVpc2s1B8sWBhreway
	trnZnFp64OJSdVCKDLuAMSBnj+1JMvWkN80GzgIr02rgTxFBvn+mJEDpz8p6ufdtM10yc3Ka5Z0
	csz+nMTbXfgyniJ3currF8OyHAuOxOgFR5HdY8l2UgUlxlzA871e6BfMllV/VTfhw4mlLCNTUB+
	NSe1WZRSf8IfYTV7kZuho6Y9GOFWgebmakEgwxtaz1XyuRTf3V20DyVbjx9qUOmO5xN6pI/NJqL
	cF5Jwf4CSSrSdhOIZe/hCaEuI82qNvH1T2dS+wVaMutAwG0j8QfJxFbByCiMXALJ7Xb9SfnmB7s
	THxWWqU4FHIz8BMEkHy6uKhPJ7Nk8gdXpst+4gyjhU+Vimxms2XdBaE2uYJoyfxNXA56Sm2nQoH
	oALPpBfnHVi6cqRqvhF49c300nafLwRLjjlP8EQVhBi0IXI9+sp9URWorWMx9eJA==
X-Received: by 2002:a05:6402:370a:b0:665:e9f:9018 with SMTP id 4fb4d7f45d1cf-6650e9f9201mr4275027a12.8.1773694068512;
        Mon, 16 Mar 2026 13:47:48 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66350992e88sm5790381a12.24.2026.03.16.13.47.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 13:47:48 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4853e1ce427so57595665e9.3
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 13:47:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4ms4LAaslhND7fMMBTn6AzJTxCWl8Q0P0+kefPLBknoHAXLcr6/exNlMLMaiLTIXrDksPCDE=@vger.kernel.org
X-Received: by 2002:a05:600c:8714:b0:483:ad56:8d16 with SMTP id
 5b1f17b1804b1-485566cf048mr234938155e9.6.1773694065903; Mon, 16 Mar 2026
 13:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310022300.311125-1-jassisinghbrar@gmail.com>
In-Reply-To: <20260310022300.311125-1-jassisinghbrar@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 16 Mar 2026 13:47:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vusn2X=EGKeWhr+3uryvvXkc5szWxPvLCh0cpcLBOp6g@mail.gmail.com>
X-Gm-Features: AaiRm52nVZyv7SjjpcE-z4Sf2hU8Q8EtEPtuUHSfLFcL5MOyTEfSKZMW2aVc-sw
Message-ID: <CAD=FV=Vusn2X=EGKeWhr+3uryvvXkc5szWxPvLCh0cpcLBOp6g@mail.gmail.com>
Subject: Re: [PATCH] irqchip/qcom-mpm: Fix missing mailbox TX done acknowledgment
To: jassisinghbrar@gmail.com, Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org, shawn.guo@linaro.org, maz@kernel.org, 
	stable@vger.kernel.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225703-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,chromium.org:dkim,chromium.org:email]
X-Rspamd-Queue-Id: E99072A0604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, Mar 9, 2026 at 7:23=E2=80=AFPM <jassisinghbrar@gmail.com> wrote:
>
> From: Jassi Brar <jassisinghbrar@gmail.com>
>
> The mbox_client for qcom-mpm sends NULL doorbell messages via
> mbox_send_message() but never signals TX completion.
> Set knows_txdone=3Dtrue and call mbox_client_txdone() after a
> successful send, matching the pattern used by other Qualcomm
> mailbox clients (smp2p, smsm, qcom_aoss etc) of similar controller.
>
> Fixes: a6199bb514d8a6 "irqchip: Add Qualcomm MPM controller driver"
> Signed-off-by: Jassi Brar <jassisinghbrar@gmail.com>
> ---
>  drivers/irqchip/irq-qcom-mpm.c | 3 +++
>  1 file changed, 3 insertions(+)

OK, so it sounds like the consensus [0] is that we're _not_ going with
my mbox_ring_doorbell() approach [1] and we're instead going with some
sort of patch that makes NULL messages just like all other messages.
Maybe something based on Jassi's patch [2], or maybe something based
on Joonwon's patch [3].

Given that, then I think we'll need ${SUBJECT} patch. Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

get_maintainer says that this driver goes through Thomas Gleinxer's
tree, but I didn't see him CCed. I added him to the "To" list. Seems
like he'd either need to take it, or Ack it to go through the mailbox
tree?

[0] https://lore.kernel.org/r/20260310234616.334498-1-jassisinghbrar@gmail.=
com
[1] https://lore.kernel.org/r/20260208040240.1971442-1-dianders@chromium.or=
g
[2] https://lore.kernel.org/r/20260310234616.334498-1-jassisinghbrar@gmail.=
com
[3] https://lore.kernel.org/r/20251126045926.2413532-1-joonwonkang@google.c=
om/

