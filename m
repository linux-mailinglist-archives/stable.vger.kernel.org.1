Return-Path: <stable+bounces-245252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDkiM/7uAWpHmQEAu9opvQ
	(envelope-from <stable+bounces-245252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:00:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD38510BBE
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 17:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36DDC3064640
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE10401494;
	Mon, 11 May 2026 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZ/ytBvo"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68E63FF8BC
	for <stable@vger.kernel.org>; Mon, 11 May 2026 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511202; cv=pass; b=MtVaLqKBcTdOb21xcJMyXUfBjyaX33Fn1gK7Y26X0Mb1C6mM0dvacBHpp+asDPiWyMlqibebRmL8IkXMOwxs3tw9O5BZuOtUOPSfX9AtUdDb4ytPOXR9YMfYMxOQQnhKT2wqKVWE8XVVtqMIVD7XDDrSM0fX8sO/GZ+Z0ZSLcQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511202; c=relaxed/simple;
	bh=q2TCtoSLf2PLJkmKD3x1+eVXl13mdaDYWUrpr08E9W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o32nOwJhiF027nthLFq6gwP3gswurKwv7oSrNNfhu+Qv1qZLXSIihVoYBONP5KmPZ7lu/1UBsZNqHIHFZELk17KYxlsMArRBVjsP42XGTECA75mPtMHUC6XxzYx9VzwDWySAab5Vd03nkut7AkVAy70txkMBWgtroD0nNvAd+jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZ/ytBvo; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65c364b893aso4226775d50.0
        for <stable@vger.kernel.org>; Mon, 11 May 2026 07:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778511199; cv=none;
        d=google.com; s=arc-20240605;
        b=Uxze+PoIW0IFYFHWBzV7inuVqBgkX4IpCvUuzObDxuYrcTUDuLWc0pPlvi7EFRbbxa
         v+4wl2xT/aMdeiDr/9PFapNuCvEf/kUX4IEj0jIvfnZkUXQpbff3bXQxWOmy+0qad1i3
         iPhhNy+TOcSLFmXtvjoWntMQWvypOKbiGSNlO7cs098PL7k7mYYJGbVjgsDs5H+TaEGj
         Y/sDBvlMywgFmxFZP72M8gyUxKToU/3hZdCuAZBgtFQSyPJMYd0INwAg71dvP4SoSD5/
         e4dqvwnMo5x8/GNii72f9V7oTC+Hzxa/SYPIU3kHxJWwZe0KDhTHa1iFPF1TYAMrQo76
         OIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mH7N4j++r3IaudrlTt6rvym5myFHJfjExvIPYpFZaxQ=;
        fh=Sx4h0sO6iXI+bUCal90DOqD2ajcGh/gpH8FlMzLZR4s=;
        b=Y4oPhRE6dQl7aGvYnlinhXijGrm1q8KWW8agsCZaumHlQDaDYBMHkjpK3BN13TsFmh
         Usn2GRrne18YqvR9y1oRDbGDT0LtkrRka7ybfLd5ImIIrDTMfUIauaIK45mysK8x4SEr
         QgyyScV2g7lfFrvKv3RyLR7gmQ8Z6YkPlTu2ZniL5AxDY2L59yBhqMRNsZJQ683cqR+f
         7yhnUmhKALBW2okwkTmoKgVT/0CGF58Jb6J4v4GjSGbtxOOAgkkcAQ0wuztxfgghvldn
         za5zZM56zoWGKlVwlvaAU69ocNkrp6/vmQEPxgElKUVgqMGYcf2HmbNPbUNEeiJPBHfA
         Mz+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778511199; x=1779115999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH7N4j++r3IaudrlTt6rvym5myFHJfjExvIPYpFZaxQ=;
        b=hZ/ytBvo/pzqfEAa31ZkNcjZ0PTdYSDkFCCDo6o0tMj2aPedQ1lxUpS51MXkssVl2p
         u8KgFkv1uFM8EILRW3IAM5acmBYygxsxmnQRboXps0XOFxxrprDO+GdgRshNuHbPwecW
         azkDgakwyCre9jli/iI+CiquoLpdtpnjEXYl0VQOoFNVMAuIlSkQQd+GhnjYSnGDlwHd
         A+KdG8lsSzuCy0waoXWtoGtjT0lhwTT5g5WDIGSGqhZHq+sBF3uc0kvaH5BcHwQ3w++l
         0zPZjcd6aBnD4etsPNq1XRigdY4ctQyaM1f400JGl4tABLUd7sKkNltkNvv9fB9DMQol
         1Jfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778511199; x=1779115999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mH7N4j++r3IaudrlTt6rvym5myFHJfjExvIPYpFZaxQ=;
        b=ff3CM+mV+Yb9ba/putVC5repT4LfvLnO6lkKA1Xc1Sbrl8RUPEoD1Kmn4vWQM4M7AF
         X7QBECZbz4EZHuSw2tQHmdmhh5JEOqzQbf9rMkWR/zMGOVUKkR9bkNRa5RCLwP/JD3uY
         0iC4Ix0C0e+H3TtlMxxiLzXlwcch+++qv9r6pDCFjfCkZ1eO5BSu8DzxXe6YD6rhCcUC
         iccIAZkJPAf0V8JVWl1JB1Xh0MJflW4f9Imj4jbLEEOGqKZXs24rR3Vp9qjoC2rPEU4M
         tMDagZLOxYTr7xMBt+pzGCnBJShxgVlBaJwCLaPoEtTyV3PT8k5e3FZ8Xw+yW0DdNJB1
         lKQw==
X-Forwarded-Encrypted: i=1; AFNElJ97qTg7FRIyQ3PPXDYJw1728aNO8OX6n+5U2bGnI2vPdbCyKnI5XwGmmetYzkXX7Zc9SPFa62g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkWINbNgQh/DCEnEk530wAYFvwAVZXLeeZRiapRLLAKxcrElk
	8ONX9YRwW4aTP07qpD4+PuHFIqhY7LYhv5CHj5wZVCiZu5Zq2rb/EceJ2Q47QE4D69LdLDJaF3R
	fSCZHZZpJZHcpQEpZwHl/uL03GZ42pKI=
X-Gm-Gg: Acq92OHVYOi6iMepqlor5+1dKLsv66qO0kXJQsZNDP2rhD7wWhjgDl0GvsMpip71bpT
	HIvunL/aYZ00hy7hawFf/rITL17mDVtHqScX0BqCYsqP/FlOTO0diiKrhFrqV+VkzeCKDbtYE7L
	iQNKwwmV55OV3CWDPbKFG7aEwBy7q/2H5PEU225r4w9VPxNTaUgJhXMgHI6zY4uNM2i3P6j6/Ea
	9aWQ9JRLBt2FYHZgmguVxqgfM/SbOTqii6R3ofd01S0CpL0UHGoGsFu3D7DpWrjJJToTS8+aIVc
	wg0wdmEzL7E2ABdIz1k6N8srxg1ReLVweg/UIv/bfj/JGAbgq1lK1T8NEhbPQ8uh0sw=
X-Received: by 2002:a05:690e:b4c:b0:656:ad2e:98b5 with SMTP id
 956f58d0204a3-65d94c4c72emr14661107d50.35.1778511198684; Mon, 11 May 2026
 07:53:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778506829.git.michael.bommarito@gmail.com> <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
In-Reply-To: <490e228dd02983fb1530fb114d4174148f810261.1778506829.git.michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 11 May 2026 10:53:07 -0400
X-Gm-Features: AVHnY4KdJ6uIUItlvWVm4hjtGOIr8Ds-NBKNTO6jvd9cqCVO4aKGk0OqFI1lRGw
Message-ID: <CABBYNZL-f+AzFWdhvLcxdf0oCXbgr3AXqM1W2npOPZEv0gRA6w@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: hci_sync: pin conn across hci_le_create_conn_sync
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mat Martineau <martineau@kernel.org>, netdev@vger.kernel.org, 
	stable@vger.kernel.org, Pauli Virtanen <pav@iki.fi>, Aaron Esau <git@aaronesau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3DD38510BBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245252-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Michael,

On Mon, May 11, 2026 at 10:34=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> hci_le_create_conn_sync() runs from the cmd_sync workqueue with a
> struct hci_conn pointer it interprets out of the work item's void
> *data argument. The hci_conn_valid() check at function entry is a
> TOCTOU: nothing prevents hci_disconn_complete_evt() (executing on
> hdev->workqueue rx_work) from running between the
> hci_conn_hash_lookup walk in hci_conn_valid() and the body's first
> deref. hci_disconn_complete_evt() -> hci_conn_del() -> hci_conn_cleanup()
> unregisters the device and drops the final kref, which kfrees the
> hci_conn slot. The cmd_sync callback then writes through the freed
> pointer (clear_bit on conn->flags, conn->state, the four
> le_conn_*_interval fields).
>
> A KASAN slab-use-after-free splat in cache kmalloc-8k confirms the
> bug on linux-next tip commit bee6ea30c487 ("Add linux-next specific
> files for 20260421") under UML+KASAN, matching the slab geometry of
> the syzbot trace fixed in commit 035c25007c9e ("Bluetooth: hci_sync:
> Fix UAF in le_read_features_complete").
>
> Follow the reference-pinning pattern from commit 035c25007c9e
> ("Bluetooth: hci_sync: Fix UAF in le_read_features_complete") and
> commit 0beddb0c380b ("Bluetooth: hci_conn: fix potential UAF in
> create_big_sync"): the queue site takes a reference via
> hci_conn_get() so the slot is not freed between
> hci_disconn_complete_evt() retiring the conn and the cmd_sync
> callback / completion handler returning. The completion handler
> drops the reference on every exit path, including the -ECANCELED
> short-circuit.
>
> Introduce a static helper hci_cmd_sync_queue_conn_once() so the
> get/put pair is not open-coded at every queue site. See the
> helper's kerneldoc for the -EEXIST contract.
>
> The hci_conn_valid() check in the callback body is retained: a
> logically-deleted-but-still-referenced conn has stale
> hdev->conn_hash.list state, and continuing to drive a connection
> attempt on it would be a logic bug even though the memory is safe.
>
> Pauli Virtanen posted a series-wide variant of this fix as
> https://lore.kernel.org/linux-bluetooth/e18591f264c50e15917cb8b9e5f9798d9=
880979d.1762100290.git.pav@iki.fi/
> (PATCH v2 8/8, 2025-11-02). KASAN reproducer captured under
> UML+KASAN (linux-next tip bee6ea30c487).
>
> Fixes: 881559af5f5c ("Bluetooth: hci_sync: Attempt to dequeue connection =
attempt")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  net/bluetooth/hci_sync.c | 41 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index fd3aacdea512..b20e07474257 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -786,6 +786,31 @@ int hci_cmd_sync_queue_once(struct hci_dev *hdev, hc=
i_cmd_sync_work_func_t func,
>  }
>  EXPORT_SYMBOL(hci_cmd_sync_queue_once);
>
> +/* Queue an HCI command entry once, pinning a hci_conn for the duration.
> + *
> + * On success, the cmd_sync queue owns one hci_conn_get() reference;
> + * the supplied destroy callback must hci_conn_put() to balance.
> + *
> + * On any failure return (including -EEXIST, where
> + * hci_cmd_sync_queue_once() neither invokes destroy nor consumes the
> + * data pointer because an existing entry already owns the slot), the
> + * helper releases the reference before returning, so callers do not
> + * need to discriminate failure codes to keep the refcount balanced.
> + */
> +static int hci_cmd_sync_queue_conn_once(struct hci_dev *hdev,

Id suggest we dropped the once at the end so just hci_cmd_sync_queue_conn.

> +                                       hci_cmd_sync_work_func_t func,
> +                                       struct hci_conn *conn,
> +                                       hci_cmd_sync_work_destroy_t destr=
oy)
> +{
> +       int err;
> +
> +       err =3D hci_cmd_sync_queue_once(hdev, func, hci_conn_get(conn), d=
estroy);
> +       if (err)
> +               hci_conn_put(conn);
> +
> +       return err;

Then we incorporate return (err =3D=3D -EEXIST) ? 0 : err; logic above, so
I don't think any caller should require queuing multiple procedures
for the same conn.

> +}
> +
>  /* Run HCI command:
>   *
>   * - hdev must be running
> @@ -6982,36 +7007,38 @@ static void create_le_conn_complete(struct hci_de=
v *hdev, void *data, int err)
>         bt_dev_dbg(hdev, "err %d", err);
>
>         if (err =3D=3D -ECANCELED)
> -               return;
> +               goto done;
>
>         hci_dev_lock(hdev);
>
>         if (!hci_conn_valid(hdev, conn))
> -               goto done;
> +               goto unlock;
>
>         if (!err) {
>                 hci_connect_le_scan_cleanup(conn, 0x00);
> -               goto done;
> +               goto unlock;
>         }
>
>         /* Check if connection is still pending */
>         if (conn !=3D hci_lookup_le_connect(hdev))
> -               goto done;
> +               goto unlock;
>
>         /* Flush to make sure we send create conn cancel command if neede=
d */
>         flush_delayed_work(&conn->le_conn_timeout);
>         hci_conn_failed(conn, bt_status(err));
>
> -done:
> +unlock:
>         hci_dev_unlock(hdev);
> +done:
> +       hci_conn_put(conn);
>  }
>
>  int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
>  {
>         int err;
>
> -       err =3D hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, co=
nn,
> -                                     create_le_conn_complete);
> +       err =3D hci_cmd_sync_queue_conn_once(hdev, hci_le_create_conn_syn=
c, conn,
> +                                          create_le_conn_complete);
>         return (err =3D=3D -EEXIST) ? 0 : err;
>  }
>
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz

