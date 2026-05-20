Return-Path: <stable+bounces-249933-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOugHKW+DWrH2wUAu9opvQ
	(envelope-from <stable+bounces-249933-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:01:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 614B858F3B4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23CB9301954E
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 14:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA593E16A9;
	Wed, 20 May 2026 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEnWpFHO"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34153E5EF2
	for <stable@vger.kernel.org>; Wed, 20 May 2026 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779285638; cv=pass; b=Pw5ZAPjgyZLdBL3i2ajNU86YI2X8Dj4N40m/1vFW48N7yk/zgNVWp7hs0poIXKDm41LFexVW0lM99/Yf07RBJd5W4MOsNrN30wzxwj03GK6SrEvVIpqkbp6pnaxZiFV7zXevLKyMAeLyhH6zAznsW1/8zK5GW9h71iY3FNK0Dq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779285638; c=relaxed/simple;
	bh=a6iXobOed3sRPLM97RG69+W2Ae5HzR387KOzpzYwEYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpCZ8N63wW/1GVoSA/LW/7wrXVQRL59dS3mIYgDUY891qH8QzOI+ndUF0t8XPrXguG1DE+N6Bymifr10DyVkea16B78chu76rh+H/RLhqoGO6lNIhctAn9cefDKRZQ7yGFX479Ua+6pLjQiY3oM5PM3DAP/5jOHjnWEgox3R0Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEnWpFHO; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-65c7492a2ceso4208170d50.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 07:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779285633; cv=none;
        d=google.com; s=arc-20240605;
        b=BBvA0zKHcHTMCZC0r8L4XncMor/uAuUlLovREpRMC7IseUt/gNozQfBC+ptg6sKA/m
         H3j7HEvtJgEplboW1d5H36ZTfyz6d8io/kbK+PXygTtVabsplKGa7GGoOVyI2GCmrbgR
         kxHsahx3We461slFdftdWtfArkSZz/WfWDI73vflkUV2XI3rNqK44hQUmrvYxUCDB7qy
         EKAe3cxN5iYVx5uOEvrPwiFeKfdQeJQWKT5Bi2UdcgnHBVVNR4ijtH7qQ6p5G65I0Kni
         cFkSzAjOmqYlPNaykJ4IikS65XJDaYgqEvH9eTSmdSBmrnkrxBrAhQvC/HuyQ++AiCnH
         ruog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/7oaXQ1qryt8g+zZj0bxtOQOINmT0mwFoGI1KqRN0Ws=;
        fh=Bqn5QoaQN+nccJtN9/5JlWCONeF6CNu0kHxk0diL+6Y=;
        b=jGAWS+75FjcU6MNR37lUkRuldR0I3NJbtvZvhHXczMeQhzdZfl+rTXq0oVaEwK2MFA
         hx982/A0B3lpiqvNWlO88/eCwPCZuXxGMo54ZDvGA12dx5WMrt2RCdyVGkovnlIyXWvt
         N5AQhiTbHjDqib2UpxqgOZ1G3jtOZXmMzxOeGIaMgzJWzgar6N0jbYmRD6GsMcxuZnB2
         4FyvQ0QMtOHqupd3UmTdr3xs8Se+GEzbPVCDK1d73ip4yyvrB6Tww3kAUbCekbKPsALo
         2u8VM8rp5z6roZAov1bOSxpBjay8z2IDHS9E4EE+bVpZdAVTC3otYQ4p3JLmTSsGBGRV
         EoqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779285633; x=1779890433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/7oaXQ1qryt8g+zZj0bxtOQOINmT0mwFoGI1KqRN0Ws=;
        b=fEnWpFHO7e2e/VG5DchH7LlYMbMdAfAmL3bznExqaIWg6YvPBBaQtm8fTLKHkukjiQ
         v7DZMO1fGA7ywqfhOKgWbL1/p/3t78DMj2sFb7cwigEZtmcJmVb3C0zcM1xV/3RHAgOY
         Mv1ooeFagkOhWQfeMaFiLJ3GjpZgCf3XEdc95ihRfUMJL6tBW/7EtPvDYGWQBh2rH33Z
         rFHzjbpldgkgchoYwUEOP5cCmkYSpLjQ3+0ZJscxLcu+3Y9CWcOh+1yeCyzYf3YjH0kQ
         ed7bBOiwf70tpeX7qjuDr2CeMGjUph1GcmuriSf/JaqILD5I4TUGi0A0aBmHVFNxCMMs
         XVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779285633; x=1779890433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/7oaXQ1qryt8g+zZj0bxtOQOINmT0mwFoGI1KqRN0Ws=;
        b=lhGe4+oNQGHoZiFjOx/1t2j1mZoCiuMzzkZKPAbrKt8UXJxJkgCjsOZvRMLjDu071X
         7Q2JjEXhkHJdu2GZzYgCOf4K2A7ahfXPPrJp1LTp53wFihMEN9/bEdMfXU+yuw53ziI9
         rsvrIU6KQdWvj1blYyaDCFByLW/juTlY/os9UYkNrsjSv+Mt7RZJCDaM0W5JczzTV0Rt
         s+cCL6I0JTx2+fUsf8xRqgUR4xcQ/elCLfptp+e4cGURO/edrvnNZVjkuiKCoJ2fzSmW
         yKcV5FVCJuJQtNA32oNx9j8n8oaAUqP7QvEKZc6XdTmq4Bs8D2VUXl3/vfGPMTecEJrQ
         BlCQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Nz+m5+NtJWHmu1mc6fSjj5p7wa22CoAuyFZBZjbfylHPHaXpaEZ+75g66LK6iDWwk7XpDJRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPGwiwGYs9ZpFu8aggWVezrHy4EsEKgYCNJMm+B20aS7AGvYJn
	zdLjELMwqVoRG8iRzkdKZJyti0FfAwh+xLJ2UDSV4WHIuiGcKVUibFSfsT/35n4GwUUzwnN3Hey
	Rc3JezUyhTwbBwirxBqxLAV0Tla+3nn0=
X-Gm-Gg: Acq92OEr38hKAiAlqhCLnt8LXJ5SocF5JFGmXRNFQWzw1J1XvHJ81IwYcB+srEx1E7N
	g1fuGz43PkIS3P9BsrGV3RT8NpiSiMgeK+XVT1fFag8qVYPOjcs2XvES0H4EMl1LpZyNRltTU5w
	3rCQgChW2GOt6w7Ttl8cQCBIaJA7d56qfzkQ9bP0emjD4By9V4uaXl+NMWjQ3/fi6UjlA54pMIJ
	U4Z2Gn3Gk6mkjVmOXSMTuCyPqJqsnN4WbKGl9rWU7UdmI+/RH0AwqwZwPOsBe1eYArGgg6ug6kG
	kRC3kj/zvES0nqfa+ezX0nAgAu10qbBpKb6aAXBHOI965l25NSM3ZBOU3m2DoFUGR6Ztpg==
X-Received: by 2002:a05:690e:2502:10b0:656:30a1:70e3 with SMTP id
 956f58d0204a3-65e228469fcmr20278863d50.53.1779285633031; Wed, 20 May 2026
 07:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
In-Reply-To: <20260520135034.1060859-1-michael.bommarito@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 10:00:21 -0400
X-Gm-Features: AVHnY4IdFrVeMyCQglDoLVCdIs5UC3o9rHcSrMblsA2cwCBRrhR-fiJEvzNPD_M
Message-ID: <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249933-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[luizdentz.gmail.com:query timed out];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 614B858F3B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Wed, May 20, 2026 at 9:50=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> net/bluetooth/l2cap_core.c:l2cap_sig_channel() accepts BR/EDR
> signaling packets up to the channel MTU and dispatches each command
> without enforcing the signaling MTU (MTUsig). A Bluetooth BR/EDR peer
> within radio range can send a fixed-channel CID 0x0001 packet that is
> larger than MTUsig and contains many L2CAP_ECHO_REQ commands before
> pairing.
>
> In a real-radio stock-kernel run, one 681-byte signaling
> packet containing 168 zero-length ECHO_REQ commands made the target
> transmit 168 ECHO_RSP frames over about 220 ms.
>
> Define Linux's BR/EDR signaling MTU as the spec minimum of 48 bytes and
> reject larger signaling packets before dispatching their commands. When
> the over-MTUsig packet contains a request command, send one
> L2CAP_COMMAND_REJECT_RSP with L2CAP_REJ_MTU_EXCEEDED and the first
> request identifier; packets for which no valid request command is found
> are dropped.
>
> Cc: stable@vger.kernel.org
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Link: https://lore.kernel.org/r/20260518002800.1361430-1-michael.bommarit=
o@gmail.com
> Assisted-by: Claude:claude-opus-4-7
> Assisted-by: Codex:gpt-5-5-xhigh
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> I reproduced the stock behavior with a real-radio BR/EDR ACL link and a
> harness that sends a single fixed-channel signaling packet containing
> packed zero-length ECHO_REQ commands. The patched code builds for
> net/bluetooth/l2cap_core.o on x86_64 defconfig. There are no in-tree
> Bluetooth selftests that reference l2cap_sig_channel(), L2CAP_SIG_MTU,
> or L2CAP_ECHO_REQ.
>
> The unrestricted BR/EDR signaling parser and ECHO_REQ response path both
> trace to the initial git import; no later introducing commit is
> available for a Fixes tag.
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
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 60 +++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
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
> index 77dec104a9c36..5417e3cb0636d 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -5626,6 +5626,55 @@ static inline void l2cap_sig_send_rej(struct l2cap=
_conn *conn, u16 ident)
>         l2cap_send_cmd(conn, ident, L2CAP_COMMAND_REJ, sizeof(rej), &rej)=
;
>  }
>
> +static bool l2cap_sig_cmd_is_req(u8 code)
> +{
> +       switch (code) {
> +       case L2CAP_CONN_REQ:
> +       case L2CAP_CONF_REQ:
> +       case L2CAP_DISCONN_REQ:
> +       case L2CAP_ECHO_REQ:
> +       case L2CAP_INFO_REQ:
> +       case L2CAP_CONN_PARAM_UPDATE_REQ:
> +       case L2CAP_LE_CONN_REQ:
> +       case L2CAP_ECRED_CONN_REQ:
> +       case L2CAP_ECRED_RECONF_REQ:
> +               return true;
> +       }
> +
> +       return false;
> +}
> +
> +static u8 l2cap_sig_first_req_ident(const struct sk_buff *skb)
> +{
> +       const u8 *data =3D skb->data;
> +       unsigned int len =3D skb->len;
> +
> +       while (len >=3D L2CAP_CMD_HDR_SIZE) {
> +               const struct l2cap_cmd_hdr *cmd =3D (const void *)data;
> +               u16 cmd_len =3D le16_to_cpu(cmd->len);
> +
> +               if (cmd->ident && l2cap_sig_cmd_is_req(cmd->code))
> +                       return cmd->ident;
> +
> +               if (cmd_len > len - L2CAP_CMD_HDR_SIZE)
> +                       break;
> +
> +               data +=3D L2CAP_CMD_HDR_SIZE + cmd_len;
> +               len -=3D L2CAP_CMD_HDR_SIZE + cmd_len;
> +       }

Weird, does the AI come up with this? The id is actually _not_
important because the error code will essentially indicate that the
entire packet was rejected. Therefore, it doesn't matter if the id is
for a request or a response, it still needs rejection if it exceeds
the MTU, so this seems overengineered.

> +       return 0;
> +}
> +
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
> @@ -5638,6 +5687,17 @@ static inline void l2cap_sig_channel(struct l2cap_=
conn *conn,
>         if (hcon->type !=3D ACL_LINK)
>                 goto drop;
>
> +       if (skb->len > L2CAP_SIG_MTU) {
> +               u8 ident =3D l2cap_sig_first_req_ident(skb);
> +
> +               BT_DBG("signaling packet exceeds MTU");
> +
> +               if (ident)
> +                       l2cap_sig_send_mtu_rej(conn, ident);
> +
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

