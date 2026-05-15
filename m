Return-Path: <stable+bounces-248268-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHnWCnVOB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248268-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:48:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AA7553F3D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19AB0308D1A4
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D203EFFA2;
	Fri, 15 May 2026 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBpi14RZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746D93BB11C
	for <stable@vger.kernel.org>; Fri, 15 May 2026 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861301; cv=pass; b=S4FOukiNCLPJk+Cneq4+SCSU105yiyfplvbpzU7OH0hX9lTu7PO2W2DU0SO2VRFRVoloU3a7ZA7f1lH9xWnT6TypkjgPCDc+vawELFipTsx6mG7q444acCbcBBbKRh0P5F4EW5bBS2SJWGNtBWWsneGt3COWb0TjCOfcVQ9KQuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861301; c=relaxed/simple;
	bh=7t5kLbl/UZJ6cD3DAaWZIhowuyrXFj+3XTaKtfytOsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xs6wFXs42uvrQa6AxZZlQWa5w79Y9cRt+84lVmYfz0aoW1JwvocvfmaGWK8WLruwKgvLfyu/NM0X1EAp11BecSH/UEv+3TDTvwuP+zTwWYaYqrxQaNV0uI/JAOkhHuLS/mpQaPfr9gjnpypVplRncyPUV64xY9wnDpN7PeCHj+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBpi14RZ; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-65e170f1ca5so4139031d50.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 09:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778861297; cv=none;
        d=google.com; s=arc-20240605;
        b=ctBO64wRMmQ1z/b2WPux+Ew/BeqMJ4/oBuj849q+F1JdW870osjjbcC5gr+fUFhwBl
         vfYOCjNe6uIrgJFMZL6PhwUPw9KsjBsF2pvTa5eLLfOB6Kun3bG9X0gw/vCbHbpXwHdK
         m0HdJlRX9Vz/mstlYaXwfqsWOK3c+sqwE3RmwQ0dn+ToKkR3PskX+Jc++psxFbc4w0fT
         LU+YVoW9jP0OzRPOLYeGP7R2U72TaBXTa6ALvzBppdli2dS9F+HtvFLtTZkmbP1GNIPX
         QrZW8y/l/vp9id/Eojx8EjASBcKGSO4RPMVJvBKoohmu7dUoJPkv65IvUhShdofLlNZO
         UYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=etWtIX5UhNNjCclgBMUtcF9H6RUdCFm4B4jOE4R5mSI=;
        fh=/YbuD7oWQbOAu+rBP1UDPbobz9Y00HCWtzN5+tKwxTY=;
        b=M+HWAcexvAphWQNxwSsE7Srzhyv9EW8LsHWO0XvUIlw/LbnZBDvedG73jpatkLOWQ3
         Crc8c8AJPvVbh5j9SupSjwzw5Ml9I3Ok2xM3WOorqTZB0mbtd8ze8pn8LQjuM2AuQqPP
         2WAM8x48+77Hz4DXyWvf5CL/oliWnw3AFCYusUbLfLQPepgHL1IrGZtsGSI5s3FIQOQ0
         9l9oh9Ox5I8ByQ8VbsgmBpu/7/s/Fakcyox8SV4bvV79ZIAN1lB59zIV3X/VlrulhCMm
         c0F04yIvyU0wDc5GR7yYrYvCcn7FUf1iD4MvkSr+zN7/9nkPUykQfGZqn5hnCel16Gwh
         GRDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778861297; x=1779466097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etWtIX5UhNNjCclgBMUtcF9H6RUdCFm4B4jOE4R5mSI=;
        b=gBpi14RZdhhHjNbboStTjszFKViTtvqc7Gj+6slDxI8D3JTrrE7UGI/8DDtoZFymB8
         rFlcZHiPVjSKYl3eaDgab/OGQ6VoRMQEC9K+jBbPU45lB0NIPyfx+OiK0AUDaFm6jX0s
         5v4xbB2ZNm3sy44/rlvdAZGy0hb9s+3rJEXHMdZi+YLgz3wsgnBzs7WfA3+kWmhTMkpf
         ve0Dvn7yFxIrkF+Cg11Q6V/2mIiVDHUmodGkjS8L1b1AQPebHrGqN96TGDFQUp1esT+4
         FZsdhbWFXJNxzkfLyOS1tEFZvBXS7q2D9wye7eLcPwW9zA8hc5kgE8VEfDeC6gJB0/Ew
         REAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778861297; x=1779466097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=etWtIX5UhNNjCclgBMUtcF9H6RUdCFm4B4jOE4R5mSI=;
        b=gws93kNF4v5LyAVjJOfnwNj8AADhWQc0gr31hHxBwfMtwOBBNDF5HYobHbn1nsCPYO
         ULS+ob9G6yCfIHu7EytQ4PGstB74QyCpWQorVCYz/Csx1NHJmCB+iBLq6XzW8QkXv6/d
         G5mendcrFtBDZqmeZEy2jEHuEfUq6T1DisY53s71BDZ6IqvFKaFsHNHn2CWMReyNOUey
         wx8ZQNN8SQDqYmBlTm230GTscxYD/ZN9qCnm1f8RGk3HI3Sn5GxkrcUkpqTPqeyu6Aus
         NwRaBTHQGp+iWOGzVSo5s+2hsepNg5GusjJi8iltR8JwFjWv0KE+pQmnv202VXbVWcKc
         J4+w==
X-Forwarded-Encrypted: i=1; AFNElJ/2X0KQj+OupcZY7lN7+jgCYulzCTY7XMVJjzns43pD6j9KqO7+K4EcGce6Zrq6ls1qOQOyhtg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw370/9S18FowA4xJpurdxrK0vu7Igj5g8i7wEmO3Zp96Q0vdhX
	L6W123HWXEzujlBPm+kD5z7K4fcsYR1SYL6r63ksPDbQs1WdWr3BgwPldjVxrGI3o3bq8JayyfT
	pDMVWDSZyVbq83ILdyu6BYxwIrV1tKCI=
X-Gm-Gg: Acq92OFDAOzC8T+U0yZ2Kfur7yd58eg4ki4mftZcedWHOVyJfUIDbChb3+7dxbuQs5I
	mBE9pGFUchB39mzpUDlK6xJW8Q1hnjIWC38GbfjtvW+O79Pc4/Bq4wIjoLvpi8/Qq0AbcOJULbJ
	z93jvnQ894Vxy/t2V0y0icuj+5ZGCJqfcrmWMSplCOey0m6bsInWNwZesMb8MGuZldDWPtlTjNZ
	AqS1wcbZVag11CyD7pcbaZWnabWLBRipvvqMC5p3+gIij0KYRUnIeYxIApAkm4KMHg3Q+p/7S4l
	OvVnLJ8DKMnDLjk/An3iuCpxTJP0g1Qz1eEzBgilUz8gTle7/25W/EoHt6tEjfpvWPRG7Q==
X-Received: by 2002:a05:690e:43d3:b0:658:ac79:ad4d with SMTP id
 956f58d0204a3-65e22869b53mr3588378d50.47.1778861297407; Fri, 15 May 2026
 09:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABBYNZLjreYY_BczAQr2G6L=iJjBYKksFp53CairG-6V0Cb0EA@mail.gmail.com>
 <20260515140548.393865-1-w15303746062@163.com>
In-Reply-To: <20260515140548.393865-1-w15303746062@163.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 15 May 2026 12:08:05 -0400
X-Gm-Features: AVHnY4IVRNEVNxNgiAR03-73eocXaRC0pMA7aacCJ9NkP_1-TTMuYszH23iee7E
Message-ID: <CABBYNZ+r3gm37FW5WqE79bRp+x9UZsaCtyvfz_FdixqEucAxGw@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: hci_uart: fix UAF in hci_uart_tty_close()
To: w15303746062@163.com
Cc: pmenzel@molgen.mpg.de, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, greg@kroah.com, stable@vger.kernel.org, 
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 81AA7553F3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248268-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,xidian.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

On Fri, May 15, 2026 at 10:06=E2=80=AFAM <w15303746062@163.com> wrote:
>
> From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
>
> A Use-After-Free (UAF) vulnerability and a subsequent kernel panic were
> observed in hci_uart_write_work() due to a race condition between the
> initialization of the HCI UART line discipline and concurrent TTY hangup.
>
> This issue was triggered by our custom device emulation and fuzzing
> framework (DevGen) on the v6.18 kernel. Due to the highly timing-dependen=
t
> nature of this race condition (requiring a precise interleaving of
> TIOCVHANGUP and protocol setup), Syzkaller failed to extract a reliable
> standalone C reproducer (reproducer is too unreliable: 0.00).
>
> The crash trace is as follows:
>   ODEBUG: free active (active state 0) object: ffff88804024e870 object ty=
pe: work_struct hint: hci_uart_write_work+0x0/0x940
>   WARNING: CPU: 0 PID: 338273 at lib/debugobjects.c:612 debug_print_objec=
t+0x1a2/0x2b0
>   ...
>   Call Trace:
>    <TASK>
>    debug_check_no_obj_freed+0x3ec/0x520
>    kfree+0x3f0/0x6c0
>    hci_uart_tty_close+0x127/0x2a0
>    tty_ldisc_close+0x113/0x1a0
>    tty_ldisc_kill+0x8e/0x150
>    tty_ldisc_hangup+0x3c1/0x730
>    __tty_hangup.part.0+0x3fd/0x8a0
>    tty_ioctl+0x120f/0x1690
>    __x64_sys_ioctl+0x18f/0x210
>    do_syscall_64+0xcb/0xfa0
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
>
> The issue arises because the workqueues (init_ready and write_work) are
> only flushed/cancelled if the HCI_UART_PROTO_READY flag is set. However,
> during the protocol initialization phase (HCI_UART_PROTO_INIT), the
> underlying protocol may schedule work. If a hangup occurs before the setu=
p
> completes and the READY flag is set, hci_uart_tty_close() skips the
> teardown of these workqueues and proceeds to free the `hu` struct. When
> the scheduled work executes later, it blindly dereferences the freed `hu`
> struct.
>
> Fix this by moving the workqueue teardown outside the HCI_UART_PROTO_READ=
Y
> check. Furthermore, use disable_work_sync() instead of cancel_work_sync()
> to unconditionally disable the works. This ensures that any pending works
> are cancelled and no new submissions can occur before the hci_uart
> structure is freed. Note that hu->init_ready and hu->write_work are
> initialized in hci_uart_tty_open(), so it is always safe to call
> disable_work_sync() on them in hci_uart_tty_close(), even if the protocol
> was never fully attached.
>
> Fixes: 3b799254cf6f ("Bluetooth: hci_uart: Cancel init work before unregi=
stering")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
> ---
> Changes in v4:
> - Adopted Luiz's suggestion to use disable_work_sync() instead of
>   cancel_work_sync() to prevent new work submissions during teardown.
>
> Changes in v3:
> - Added 'Cc: stable' tag as requested by the stable bot.
>
> Changes in v2:
> - Added KASAN/ODEBUG crash trace.
>
>  drivers/bluetooth/hci_ldisc.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.=
c
> index 275ea865bc29..333c1e1503e8 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -544,14 +544,20 @@ static void hci_uart_tty_close(struct tty_struct *t=
ty)
>         if (hdev)
>                 hci_uart_close(hdev);
>
> +       /*
> +        * Disable workqueues unconditionally before freeing the hu
> +        * struct, as they might be active during the PROTO_INIT phase.
> +        * Using disable_work_sync() instead of cancel_work_sync()
> +        * ensures no new submissions can occur.
> +        */
> +       disable_work_sync(&hu->init_ready);
> +       disable_work_sync(&hu->write_work);

Looks like sashiko has a problem with these being after hci_uart_close:

https://sashiko.dev/#/patchset/20260515140548.393865-1-w15303746062%40163.c=
om

>         if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
>                 percpu_down_write(&hu->proto_lock);
>                 clear_bit(HCI_UART_PROTO_READY, &hu->flags);
>                 percpu_up_write(&hu->proto_lock);
>
> -               cancel_work_sync(&hu->init_ready);
> -               cancel_work_sync(&hu->write_work);
> -
>                 if (hdev) {
>                         if (test_bit(HCI_UART_REGISTERED, &hu->flags))
>                                 hci_unregister_dev(hdev);
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

