Return-Path: <stable+bounces-253521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF+wIlsDD2oaEQYAu9opvQ
	(envelope-from <stable+bounces-253521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:06:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEF65A55E5
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9169432EB770
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D633D9058;
	Thu, 21 May 2026 12:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqvbAhCF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AA73D7D86
	for <stable@vger.kernel.org>; Thu, 21 May 2026 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367927; cv=pass; b=PKc5ZDM4Is7s4l2KVqVqA+unemt/WR02dyDPjeYKnUHcMXFWRoU5ULK3Ae76RNXsNfmlDn7zwUk/++SogFqMzlssYIAHfQ94fbwJSVT3IRsMVwIpWjx0CpA8LHEuSg3kJ9du68Dkx3XFnLO5X5pbA6AzdncstkalVxEIo02uMcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367927; c=relaxed/simple;
	bh=p8cc2wnGLfAwakGTNQQ7vxQ2eQ9vVWHXg2L1htWQBTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmTkXmtRGdshG2iGIRjs07lDOtWzDGP0kwuGE6KcwTmmHu+LXtNhR1rCkuf/3WcRAnmPiD2mYs5VbjLTs3f7b8vmkDu4t3vh3q8snw2OgS7oQFtMKwLPomUKTnaqv1YoVKsNOLNX4ZgU9rvS1N5ZbnJGdaPTCt4GkQ0c1luO2yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DqvbAhCF; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65890a6ca20so6803873d50.0
        for <stable@vger.kernel.org>; Thu, 21 May 2026 05:52:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779367924; cv=none;
        d=google.com; s=arc-20240605;
        b=bC660KIM75xPGIwB9XYUQlyJ8LiflH3hCWLA44TlAv9nhrHYX34yP68NH5CnVEy1MD
         iooyPOFcx+sX/komdWxzUo/y8L9ifYJFwv/hQDNkovFevxF3+EPQldwGkLw67Fb+QJ82
         kSeVrBcuiXpPFADkgdJU45fVBu5JtRRg3Tnw6Jvh3uR9jnGeGQtjK8/7yrpJlbiZ6lAY
         WuZZ58im/0ETym1k1rrV2MoLauQhIB79TlO8KjlENfi/fnjMW8QhtY96yGtnTo7uFEU/
         2M0csPxPbIET/Iq7s2AORGbcWNSxJbhlVjt8rPe6o+cOBYCHRFjWQu5jA6gCjATwQeFA
         RaFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sGwmbLN2Vtyo/TdGf+EWGxjeBtLgP+QUzHLYLGWhusg=;
        fh=0rtY3tTrt5DE+KHsHG9rDioTgTBoaPLSPyyZuPHcvOg=;
        b=URmJiKZrii51gzK8sI3NvuGPEWpnW+0VHmk/z1+Fz4oUc9JS9ADg15HdjSbmuZgfKz
         4cYVcKV7U3ai1fJx+SGqTLpqdPhvRKEiC4F9wD+jpI9k3DCuCwoXP6f3nMVolsyHfRHg
         fD/N6wDC0irU7Fw6kIAHD8LT8aNxap8c+puDHEshJENa19KkogV4oiyMGi1n3Pm/6Qce
         4GyFH1WYg98ISe8HHvxBnlm9MfcJ16/EWXmRMEuvf/JdAfAqlguPIXYDzVm3Byctcpsq
         EJvNkG7yJWI+IGHCCaQ8zD9sF0k42+8BbkHDDBSRzxiI/PK0jY0bVM+mw0b+rNCLutiG
         KBCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367924; x=1779972724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGwmbLN2Vtyo/TdGf+EWGxjeBtLgP+QUzHLYLGWhusg=;
        b=DqvbAhCF1tsPURcyVihwoBPllgzam5ckaJ9KRihwjHXpXCnzKMPWxX2/wb9tEXgrae
         0sGQysGTSmlO+u+MiECZfq94UCxy0gzAj5ReaYlUH20Qv6JLBikN4IFB/l9H+7PZap83
         SEox5fbNZZu4UKzTmnxX3D7PMLX+U0uECatzJ2m2WNMBzLfZgwPzDd1YXKBlCyd/0USR
         GpB+2j0uWkXmTSOdDcjweGysj0wJdSb5tETfYjrYjzgv2B6M7fCt6/ttgu4WtxCEnuK+
         +9vl4kuJ3kXQNkYpfa/bQYJMDGXToeVah+ViebHcqk9wd6tJBQ47CTD9WaHq2qPQWbyT
         t/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367924; x=1779972724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sGwmbLN2Vtyo/TdGf+EWGxjeBtLgP+QUzHLYLGWhusg=;
        b=D187OI0Naye0G5Av8gpqDkeZ3JXtRXz+7x1GLZN1HzNwKYk1b2MckcRsFC7XDy5nZ8
         mnGPQZnttFv86wxABAAITtinFlBDrfK13OEI5bQNoXXCcnUggsp5B1/oIV5b25UaCm7+
         E5xxv8UZTaX3MhSK2hCDXVswJNglccluvVS/soyCP16z1KXsCXkajYr4m/mocmByZ6e3
         PTCqZt+VqTNSLdZ+jY1rkZA99IZV2Fc32xgnqhMe1mbYjEzuvlD308DWXBuFa7VeOw3P
         p3T64zd82EtP8gKqx6ZhEcMugciSxCMfsXShyr1TcNKQRVXLUy/s9zyZYHLVUOhwNEtn
         CTjA==
X-Forwarded-Encrypted: i=1; AFNElJ8saU+V8pGHIAGd3JLwv2TeU2leoKYHC9Z/EWl2aQWTRmGgf/cphXD1Vfya/t74+Qnx/LI02io=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+ajYXifASu2J+rG9nVi5PHo8FUAO0vpFT0IC6fEFYMoUO3mJ
	ROaUaD75ULZAYZTZDzdWjomlRMfAG8wnzBDWt8ndeLczi2E9bWf7kwXVWPeKcIcAev/yz/3iZDM
	hVCZpcZduXPDE39+RaK/vAUJWbwlbbcg=
X-Gm-Gg: Acq92OGuSZBUg3XvD7DCcPrKjwJr/rL55iLIAOibBIJTBX2P604ewIT8LLwvDU2frgr
	kaGqKuQb+ODngwhxkJRiVFBREeRmzzaubVHLjPDOZQi5kgug93IhtUUh/1a1xNU/XOCGhWpqf7u
	6gaivFX/aEUuoyUBZrLt4wm+7LeseuLpa4X7iyoD6GQHcr4u34xXHXew9kAuPNrv9ftY/SNCkB4
	YmO4f1zcGoskUf807XJyNRFlM29Qv+Xnlx1JYy8B+W4vACflsxcttKepecUXwfB2CnAjbqD2f3u
	5kc6wDoIC4TxgOgah7E+BUM9dqW4qle9Z+ZXXvoQObJhfvwqJaAb0sceEbrOotewrCeSmA==
X-Received: by 2002:a05:690e:dc8:b0:65e:4729:75d2 with SMTP id
 956f58d0204a3-65eae282cc9mr2274633d50.63.1779367923784; Thu, 21 May 2026
 05:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com> <20260521000555.3712030-1-michael.bommarito@gmail.com>
In-Reply-To: <20260521000555.3712030-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 21 May 2026 08:51:52 -0400
X-Gm-Features: AVHnY4KCmgUUIg2J6RNcRb1EIZ4whCdQkwBUhY9eLR2VCwJJEU5jgOwxCGLGYyk
Message-ID: <CABBYNZJtN0+OkNEBh-y0y3pLQZwK=0r9Cy5Tyg7Hd-AVWdOJEQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253521-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EFEF65A55E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Wed, May 20, 2026 at 8:06=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
> signaling packets up to the channel MTU and dispatches each command
> without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
> within radio range can send a fixed-channel CID 0x0001 packet that is
> larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
> pairing. In a real-radio stock-kernel run, one 681-byte signaling
> packet containing 168 zero-length ECHO_REQ commands made the target
> transmit 168 ECHO_RSP frames over about 220 ms.
>
> Impact: a Bluetooth BR/EDR peer within radio range, before pairing, can
> force 168 ECHO_RSP frames from one 681-byte fixed-channel signaling
> packet containing packed ECHO_REQ commands.
>
> Define Linux's BR/EDR signaling MTU as the spec minimum of 48 bytes and
> reject any larger signaling packet with one L2CAP_COMMAND_REJECT_RSP
> carrying L2CAP_REJ_MTU_EXCEEDED before any command is dispatched.
>
> The Bluetooth Core spec wording for MTUExceeded says the reject
> identifier shall match the first request command in the packet, and
> that packets containing only responses shall be silently discarded.
> Linux intentionally deviates from that prescription: silently
> discarding desynchronizes the peer because the remote stack never
> learns its responses were dropped, and locating the first request
> command requires walking command headers past MTUsig, i.e. processing
> bytes from a packet we have already decided is too large to process.
> We therefore always emit one reject and use the identifier from the
> first command header (a single fixed-offset byte read), falling back
> to zero when the packet is too short to carry a header at all.
>
> The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
> trace to the initial git import; no later introducing commit is
> available for a Fixes tag.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarit=
o@gmail.com
> Link: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarit=
o@gmail.com
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> I reproduced the stock behavior with a real-radio BR/EDR ACL link and a
> harness that sends a single fixed-channel signaling packet containing
> packed zero-length ECHO_REQ commands, and confirmed on a patched kernel
> that the same packet now produces one L2CAP_REJ_MTU_EXCEEDED command
> reject and zero ECHO_RSP frames. The patched code builds for
> net/bluetooth/l2cap_core.o on x86_64 defconfig with W=3D1. There are no
> in-tree Bluetooth selftests that reference l2cap_sig_channel(),
> L2CAP_SIG_MTU, or L2CAP_ECHO_REQ.
>
> Changes in v3:
> - Drop l2cap_sig_cmd_is_req() and l2cap_sig_first_req_ident(); the
>   reject is now unconditional and uses only the first command
>   header's identifier byte at a fixed offset. Per Luiz, the spec's
>   "match the first request command identifier" rule would require
>   parsing past MTUsig, and the spec's "silently discard if only
>   responses" rule desynchronizes the peer.
> - Replace the v2 walk with a verbose comment quoting the relevant
>   Bluetooth Core section and documenting why Linux deviates.
>
> Changes in v2:
> - Replace the per-PDU echo-count cap with the MTUsig direction from
>   review.
> - Reject the whole over-MTUsig signaling packet with one
>   L2CAP_REJ_MTU_EXCEEDED command reject.
> - Add L2CAP_SIG_MTU and drop over-MTUsig packets when no valid request
>   command identifier is found.
>
> v1: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarito@=
gmail.com
> v2: https://lore.kernel.org/r/20260520135034.1060859-1-michael.bommarito@=
gmail.com
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 47 +++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index 5172afee54943..e0a1f2293679a 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -33,6 +33,7 @@
>  /* L2CAP defaults */
>  #define L2CAP_DEFAULT_MTU              672
>  #define L2CAP_DEFAULT_MIN_MTU          48
> +#define L2CAP_SIG_MTU                  48      /* BR/EDR signaling MTU *=
/
>  #define L2CAP_DEFAULT_FLUSH_TO         0xFFFF
>  #define L2CAP_EFS_DEFAULT_FLUSH_TO     0xFFFFFFFF
>  #define L2CAP_DEFAULT_TX_WINDOW                63
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 7701528f11677..0b1e062057695 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5618,6 +5618,15 @@ static inline void l2cap_sig_send_rej(struct l2cap=
_conn *conn, u16 ident)
>         l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej)=
;
>  }
>
> +static inline void l2cap_sig_send_mtu_rej(struct l2cap_conn *conn, u8 id=
ent)
> +{
> +       struct l2cap_cmd_rej_mtu rej;
> +
> +       rej.reason =3D cpu_to_le16(L2CAP_REJ_MTU_EXCEEDED);
> +       rej.max_mtu =3D cpu_to_le16(L2CAP_SIG_MTU);
> +       l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej)=
;
> +}
> +
>  static inline void l2cap_sig_channel(struct l2cap_conn *conn,
>                                      struct sk_buff *skb)
>  {
> @@ -5630,6 +5639,44 @@ static inline void l2cap_sig_channel(struct l2cap_=
conn *conn,
>         if (hcon->type !=3D ACL_LINK)
>                 goto drop;
>
> +       /*
> +        * Bluetooth Core v5.4, Vol 3, Part A, Section 4: the BR/EDR
> +        * signaling channel has a fixed signaling MTU (MTUsig) whose
> +        * minimum and default is 48 octets.  Section 4.1 says that on
> +        * an MTUExceeded command reject the identifier "shall match
> +        * the first request command in the L2CAP packet" and that
> +        * packets containing only response commands "shall be
> +        * silently discarded".
> +        *
> +        * Linux intentionally deviates from that prescription:
> +        *
> +        *   1. Silently discarding desynchronizes the peer.  The
> +        *      remote stack never learns its responses were dropped,
> +        *      so any state machine waiting on a paired response
> +        *      stalls until its own timer fires.
> +        *
> +        *   2. Locating "the first request command" requires walking
> +        *      command headers past MTUsig, i.e. processing bytes
> +        *      from a packet we have already decided is too large to
> +        *      process.
> +        *
> +        * Reject every over-MTUsig signaling packet with one
> +        * L2CAP_REJ_MTU_EXCEEDED command reject.  The reject's
> +        * reason field is what tells the peer that the whole packet
> +        * was discarded; the identifier value is informational, so
> +        * we use the identifier from the first command header (a
> +        * single fixed-offset byte read) or zero when the packet is
> +        * too short to carry even one header.
> +        */
> +       if (skb->len > L2CAP_SIG_MTU) {
> +               u8 ident =3D (skb->len >=3D L2CAP_CMD_HDR_SIZE) ?
> +                          skb->data[1] : 0;

Checking L2CAP_CMD_HDR_SIZE after L2CAP_SIG_MTU seems unnecessary, the
latter should always be large enough to accommodate a header.

> +
> +               BT_DBG("signaling packet exceeds MTU");

I'd make it print skb->len and L2CAP_SIG_MTU e.g. %u > %u, skb->len,
L2CAP_SIG_MTU.

> +               l2cap_sig_send_mtu_rej(conn, ident);
> +               goto drop;
> +       }
> +
>         while (skb->len >=3D L2CAP_CMD_HDR_SIZE) {
>                 u16 len;
>
> --
> 2.53.0
>


--=20
Luiz Augusto von Dentz

