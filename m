Return-Path: <stable+bounces-224514-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEmOE6dGsGnFhgIAu9opvQ
	(envelope-from <stable+bounces-224514-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:28:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D42B254BF5
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 17:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE0AC31E8D76
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C363161BE;
	Tue, 10 Mar 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dFSOrwfX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3840C30FC06
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156162; cv=none; b=mb2A3hkI5Ln4Jr0TRQuVqgTuGGoV2K5nLGWpzKqzqiOw30N9CrliEwquTXEHxhmrqMz1N5WE29I4/G7WIuxLHLSB4CXAcYC7SfSkuIktE+JdIOWVkRc18ztWb7emzp6PnJVLtZD+sQT9rIOufcu9JDBdKrDfn5WaoxZqR83Ezz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156162; c=relaxed/simple;
	bh=0B5D+xcZnYpODXXTE/w/ZKzIe3Lk711aU4jM5s38GCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBi6IwcLyvC0Ha6N1orsBBhVggJF9Z0jDH8Qy3ppbUFBiD/TPWYmdm2KIz5Rt3Zt3FhSbcrOVXcfrC326UVgQwzCNKQQqbxAFt6iNHmcttRjY7B3qRzfqQvwZDkHfjbCyAF7IWyqkPBVKYarcZXh9r+4YBAZsLUxyEcGlEPYtmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dFSOrwfX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-661b08b04deso4660972a12.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773156157; x=1773760957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXqWkcr2J0YLzB75Md3f2DD8lWCxZB7UrtOSQKxl2i0=;
        b=dFSOrwfX0lPuiizdnbPrCy9eCQRpPti1j83tfmDHtRteTtDSOaOA6KeRSOm4Vb+zgu
         zavwc64D7Fq4MY8F5Sk9SZruGM+AZM4RdBhIcq6TXIlKJb9/JEBLMD821o5DSHCBXffr
         4N1kjoxQnoZL4kmCwNSPZWPyXPVhsccCj3hJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773156157; x=1773760957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pXqWkcr2J0YLzB75Md3f2DD8lWCxZB7UrtOSQKxl2i0=;
        b=w2X1+WBD4L2bbFPh5CXztpXYQBoFaS56xRFZG7W7RBc27bz3bhd0OUgQJcyyu/rsWf
         fkv8fNRs/TLrdGw3Ttj482N+jCDRWmT1NnvbIjW73VZ3bLyKjRhmcA0ZD5F0mFGn5I8N
         D9ZXTrlt++ddUupKqUQ64pIqOyjmq5zGgEAczED+t7u8s/lBy2VFq4MAUUocPCcQZ0/d
         Dk6t4grEtFa8PjRZa2XMxDZPEHfKs4DnoTtFSUkp/hC4ndpAAjfmUDeMNDd9zRtVhkre
         +YFs0pm1VGKmrVW6GMdgsLB5K84Tpw3ksIbXjakq6mSG0WscBQuyy/Dld00UanVbZmRL
         sCqA==
X-Forwarded-Encrypted: i=1; AJvYcCX30dtO8TqZ85sLH3o2qoSuXGYh5DHF2EEkX0kdybaUZi2SfdCcXgCHEj3JDtvsTvotV8QWyzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgE0Mz5Tyhw3LO9Bjx7xsTFWZ/27fiNPVdVsJSsDjF1C9JR/n
	kE3kXR07w8Wuu6+0Rzy9AZ+WykxqbELlumItPjpjN3legHehwxmNmO7a+jGAzv6p4Ql3VHuVjQd
	9HbQ77ysq
X-Gm-Gg: ATEYQzwMljfGlcv4qxtTTo1bh0GTn/ZJfOi82VBGtHeGcFIHhXnB6eqAXuez2OmyqcJ
	6JIBK7VgOBDESRrj3hjRsRrpkYUXMeOT768TjFaxQWoJ1hRz/AAjTQ/dIdG4Zyi95IMqwnKfhWp
	mgZ+vBCbMTJ7AaikZxzYx36IhDuVQbjHE5iB5GtII4ugSXZipa1vAOl/abvMK9EM5K7PP4+TUc9
	ZXYYC7ssTQmAoxhgzbv5+aYj13Aacxic+Hqbcli5KXO4UXNhwVeDMa34EtJpgytI1yPe5rk+/tw
	IeUYxNhUeiNeWCCR0xgQw8RhwgdZv+se1ZKJ5up4vi+Jka68qpdI6VIxnjLlJgQYRcSl0Se/Sed
	XhGHZrIcMX7RXYcxlmMZymq0BE/DTaUjYRZs8e6sPaChHBgTKYb9VzUlclllxBrlM89np80sgam
	+PrNS1NlxPq6TBYTW9T9as/zxbYS0Qk4OAXhA3RiOXiA8IFnHkmmo27MzZ7R2HEA==
X-Received: by 2002:a17:907:fd18:b0:b96:f863:deb8 with SMTP id a640c23a62f3a-b96f863f2f7mr452957766b.53.1773156157060;
        Tue, 10 Mar 2026 08:22:37 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef8b8absm498355566b.17.2026.03.10.08.22.35
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 08:22:36 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso15711825e9.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 08:22:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXFHuxBX6kbEj5xF368IKb3i5IJiP7LaRMKKCrCY+cl2Keihsl9TrScJ/uypwLhEp4avGBszE4=@vger.kernel.org
X-Received: by 2002:a05:6000:4308:b0:439:ccec:fcd0 with SMTP id
 ffacd0b85a97d-439da88bce0mr28625198f8f.29.1773156153747; Tue, 10 Mar 2026
 08:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310022300.311125-1-jassisinghbrar@gmail.com>
In-Reply-To: <20260310022300.311125-1-jassisinghbrar@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Mar 2026 08:22:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=USFLx1J1+maF3KraYEMPJNq-xjqGLkb_bfozO2LykbAg@mail.gmail.com>
X-Gm-Features: AaiRm52sFhfgXaKy11zfc97LD3nUTKnamhyLGT4mfiWTWXwVCrZCzPBHRzN8S3M
Message-ID: <CAD=FV=USFLx1J1+maF3KraYEMPJNq-xjqGLkb_bfozO2LykbAg@mail.gmail.com>
Subject: Re: [PATCH] irqchip/qcom-mpm: Fix missing mailbox TX done acknowledgment
To: jassisinghbrar@gmail.com
Cc: linux-kernel@vger.kernel.org, shawn.guo@linaro.org, maz@kernel.org, 
	stable@vger.kernel.org, andersson@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4D42B254BF5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224514-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,chromium.org:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

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

It's up to you, but according to all the research I did w/ NULL
messages, the mbox_client_txdone() didn't really do anything useful in
this case so we don't _really_ need to add it. The fact that it
historically did nothing is one reason why the new
mbox_ring_doorbell() series explicitly documents that you need not
(and, ideally, should not) call txdone() for doorbells.

Specifically, mbox_client_txdone() will just call tx_tick(). That will
set `chan->active_req` to NULL (it already was). It will call
msg_submit() which likely doesn't do anything (since we don't queue
NULL messages in normal situations). It will notice that `mssg` is
NULL so it will return before calling tx_done() or signalling the
completion.

If we make this change, then I'll need to spin my mbox_ring_doorbell()
series to delete the code. That's OK with me if that's what you want
to do, but I don't see a lot of benefit.

-Doug

