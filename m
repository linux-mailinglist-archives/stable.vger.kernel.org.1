Return-Path: <stable+bounces-249660-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEhfLAasDGrukgUAu9opvQ
	(envelope-from <stable+bounces-249660-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:29:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE97583AC2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEF9B30839EF
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 18:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CC536997A;
	Tue, 19 May 2026 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITErD358"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230B367B92
	for <stable@vger.kernel.org>; Tue, 19 May 2026 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779215156; cv=pass; b=cFURK6CEuM7fiYvYKKcUop4BXGN1F1KNyi4DXnZ4yyN7zTAx/ilnNnLefqCed9DoHRaivKX/tKIpQYy1Ddc4v5sGILlSbosJT5WewxcrfV+xS8WxrhEf5+DkocaIfYC+ZrPzTqybIGikPvQPHL22iPp1F8mmJReyiEhVZbLqqi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779215156; c=relaxed/simple;
	bh=krRIe+SWQ9UydTxaBCAVuzteStmc8b0sHjGvDVOk5rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSQWi1tVF7pf0cpHafPwVJSfkM4rKpuJhxZVsagEUXXNgpDPN1QZamtHGpnulC//i6yuuhSviatjreBd4cERqDqFsqg/qlFDynErurR1V4DbUZwsNHcKiNhEf7rkXQLS93f98+jQjwLHqRYlXnPV9Zs11Y+i85bRn8ybmotjtPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITErD358; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7c0dea734b8so34915477b3.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 11:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779215152; cv=none;
        d=google.com; s=arc-20240605;
        b=Biwyy+ENHpaOSe4OLLjHqZWN06UdyXQYZs5nsyn+L2j2L1HnADryvkd/Ne/CXiGSlN
         r3YzDBoRNDTZ373HfFQllfyYchNeElR7TEhERovH+lMtu4f0Si/JQSCMy94pomxnDsqC
         0zxT2GzJ3+67JQ38HC0gG3vwc9XU+/GShZKVizK6TIJkY+wqZJgghc09+HIh9g18lEhP
         anIbOclkGA7Pxo+2pp8kLh0wPpu1uOEJumIfVsjBl/2qIoK46L1mG7SAd+WvHybGOhZQ
         jkUz2/D6CE3SzyGwns7RI2r7Zlvv7DLHFuRbh/nWbgG6VC2t/VRC3aik6CymEUeEzLkW
         0gqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4YqY46vlRkF4fAbfB7mhKaAw8FZ7vCsOZe9CCi7etfk=;
        fh=uKqe8OU2gKzvNvyLjHRA9sAGYykhhgIFc8MVLnpYnww=;
        b=dHslxY8u4bCDAjCtoZu9dpnalRE6NKESzPgqxmWRSusfpoZ4/mdiPGpPgqLB5Gj6NU
         bXbJ742ObqPOtIiSVzh5VCgmojsFhTHcK1M27Szs5sf+vvxcfrDsdl+opFAy0OrbzXN2
         2r3n23mncESCdfUs5Rc0/ZosQUDjrtLKmwghaE9BOe07tEx4Gfv7pc7Ibh7KVunpoFG2
         VGmjArTqbM7brqJsISVfsniISq+7uL4HyRq9D900uvyYhoJ32KRPPMVJujGlDz2OvHi0
         sTTtWE0isUohZi5wZ1CTSLId3rGIPQRoihVy9q4eN4lboMKSn80Q8VSrrT5JMfGvPwaY
         bm2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779215152; x=1779819952; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YqY46vlRkF4fAbfB7mhKaAw8FZ7vCsOZe9CCi7etfk=;
        b=ITErD358uh7yiF7OORzuATGt12jzMIsnMPzOIdNjO4O1dxYtcqJqWPWN9iXQxD0BQH
         dZKrpOO9ZAXEu9AiXomerItB659YABVzgRnCQyjfKa9LuoppI4ZyWyg7yltHzXUrqA4Q
         83NaUfM6eqm+kWHnggT3ecawMCEF6yJcHqp/eg/PEb/Y11+nKMXKYJ8nLkIC592Ev1Nq
         u9cwFNlX69PPPOVDuLvYLkzkQM7DmZ7XOX6lTOduk7YJArw5Eg8us8vfxSUuerutq/HK
         99L+WiqBcAaUw2pt1ajAfnnH0Erv+FB4J39dM/Mghw7I0TrmvOolkwnvPOSe83cy/eLT
         AUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779215152; x=1779819952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4YqY46vlRkF4fAbfB7mhKaAw8FZ7vCsOZe9CCi7etfk=;
        b=KcaIVmp35gatJ4kwOzOCwD2VBH3SBZFSQ6L5TsKawhtq5L1rsWrLSGHNxfV2dWdYCd
         9Rz3//VUsxAzVFZCZdBHtSAOa/YHQ7QTirCInl8Z5bSxndjGJTMzV4jsLKqgeK5oiT7T
         4Jvb5y0VaisWzQL1/Ia/Qjg6/PlHVwEV6+PymmIn5/yHne5n9uJIyyYtstFXhT+i8nRy
         rgFjfcBtlSzEQgvGScnVg0UHF9qbzYd52B6xK+U6wlDO0PPizEzWkSY3N4DcdDWeZzoQ
         /fPgthuPpuIsasT14dklDz4AtgM84lY+xVxtSeTwrxrv0gcx6aS/cWNIWBB+JMWCdxbG
         IRXA==
X-Forwarded-Encrypted: i=1; AFNElJ+ue7bMfyOHvA88XZzrKw5mJSfbFasUZIqcVE7Z2GmkgcHtRqhNn85jHhy6eN4+jjN5N3JaAIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSw0wgEKpGuFEl+y68KBqCE9uZ3jFc3GCZhIuYYGQIK8xrupz
	VoYfQRMTzuQk/AEfJ8qDEniXD/5srg2JFU4x3ghXu/Am2tSKJLiSVxvKxQnygyWnhZeS/Ppvcfq
	3xYJERIvHiAypPq8xizZONV5Evkj9kZ4=
X-Gm-Gg: Acq92OFjdZ1l008acmhjnHGfdG3GryZbNcwfig8bzUGszPSYSW/L72MbqJbuXZlkHEk
	Gmn2c9TxJSTWF6HV49XpdauSTdUWvivBA/kSdyg44pHhtqbScC9DPQY7ke1oDWw4Do47VNT4z7U
	ovczBtQdqrglz2DG1+Ln5XqbB+LXD5N9DLi7AtNh9JTauuldvYhaZGfAs2+SNkJTbcx0PQuN9bV
	wOlNy0U85mRgwaa6DIglfDu/MS4zafb7zkY8YU22tK53bxPN+0HJCW7soA5R6nYgkfjl8TIks+U
	/eMokALnljIofrPJvE7fR2S6uK1c21BSrVlnA3LAld/54BkNU3tj6vdMsTtExJcAO7/PvQ==
X-Received: by 2002:a05:690e:1913:b0:65e:3bde:1bc4 with SMTP id
 956f58d0204a3-65e3bde3490mr14311058d50.46.1779215152099; Tue, 19 May 2026
 11:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519042017.29564-1-meatuni001@gmail.com> <20260519181749.15746-1-meatuni001@gmail.com>
In-Reply-To: <20260519181749.15746-1-meatuni001@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 19 May 2026 14:25:41 -0400
X-Gm-Features: AVHnY4I7-gjlkVDjFs7yHIvtQGGx6X0cwJO5cT0tfa1y3yINopyHlcyV6aiZJ10
Message-ID: <CABBYNZKFZpUh-nb-8wLQ_fy1U04BAwUdjQikbuzfrzCcMe=VPw@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: RFCOMM: add minimum length check in rfcomm_recv_frame
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249660-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1CE97583AC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Muhammad,

On Tue, May 19, 2026 at 2:18=E2=80=AFPM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr * and
> immediately dereferences hdr->addr and hdr->ctrl without first
> validating that skb->len is large enough to hold the header. A
> remote device can send a crafted short RFCOMM frame over L2CAP to
> trigger an out-of-bounds read before any session state is checked.
>
> The FCS trimming code that follows compounds the problem:
>
>         skb->len--; skb->tail--;
>
> If skb->len is already zero the decrement wraps to UINT_MAX, causing
> skb_tail_pointer() to return a pointer far outside the skb and
> producing a second out-of-bounds read when the FCS byte is consumed.
>
> Replace the open-coded cast with skb_pull_data() which validates
> skb->len against sizeof(*hdr) and advances skb->data atomically.
> Save the original skb->data as frame_start before the pull so that
> __check_fcs() receives the header bytes as required by the RFCOMM
> FCS specification. Guard against a missing FCS byte with an explicit
> skb->len < 1 check. Replace the unsafe skb->tail decrement and
> skb_tail_pointer() call with a direct end-of-data index and skb_trim().
>
> Note: SeungJu Cheon posted a related patch that adds equivalent
> length checks inside the individual MCC sub-handlers
> (rfcomm_recv_pn, rfcomm_recv_rpn, rfcomm_recv_rls, rfcomm_recv_msc,
> rfcomm_recv_mcc). That fix and this one are complementary and
> independent; neither subsumes the other.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
>
> ---
> v3:
>  - Replace open-coded cast with skb_pull_data() per Luiz's review
>  - Save frame_start before skb_pull_data(); pass it to __check_fcs()
>    to preserve correct FCS validation over the header bytes
>  - Replace skb->tail decrement with skb_trim() per Luiz's review
> v2:
>  - Fix GitLint B3: replace tab with spaces in commit body
>  - Add Cc: stable@vger.kernel.org
> ---
>  net/bluetooth/rfcomm/core.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
> index d11bd5337..66eee8a86 100644
> --- a/net/bluetooth/rfcomm/core.c
> +++ b/net/bluetooth/rfcomm/core.c
> @@ -1741,23 +1741,29 @@ static int rfcomm_recv_data(struct rfcomm_session=
 *s, u8 dlci, int pf, struct sk
>  static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s=
,
>                                                 struct sk_buff *skb)
>  {
> -       struct rfcomm_hdr *hdr =3D (void *) skb->data;
> +       struct rfcomm_hdr *hdr;
> +       u8 *frame_start;
>         u8 type, dlci, fcs;
>
>         if (!s) {
> -               /* no session, so free socket data */

Doesn't seem relevant to remove this comment.

>                 kfree_skb(skb);
>                 return s;
>         }
>
> +       frame_start =3D skb->data;
> +       hdr =3D skb_pull_data(skb, sizeof(*hdr));
> +       if (!hdr || skb->len < 1) {
> +               kfree_skb(skb);
> +               return s;
> +       }

Add a empty line after if blocks.

>         dlci =3D __get_dlci(hdr->addr);
>         type =3D __get_type(hdr->ctrl);
>
>         /* Trim FCS */
> -       skb->len--; skb->tail--;
> -       fcs =3D *(u8 *)skb_tail_pointer(skb);
> +       fcs =3D skb->data[skb->len - 1];
> +       skb_trim(skb, skb->len - 1);
>
> -       if (__check_fcs(skb->data, type, fcs)) {
> +       if (__check_fcs(frame_start, type, fcs)) {
>                 BT_ERR("bad checksum in packet");
>                 kfree_skb(skb);
>                 return s;
> --
> 2.54.0

Other than that looks good.


--=20
Luiz Augusto von Dentz

