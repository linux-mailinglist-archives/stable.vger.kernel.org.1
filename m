Return-Path: <stable+bounces-224584-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHBsMPqPsGkukgIAu9opvQ
	(envelope-from <stable+bounces-224584-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:41:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 286BB25868D
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 22:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62EE3204D3B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 21:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0EA3EF663;
	Tue, 10 Mar 2026 21:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmhUu5p4"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8035839E
	for <stable@vger.kernel.org>; Tue, 10 Mar 2026 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178791; cv=pass; b=N90t+/kDk1iO/ODJG25CloinvuLNLgo9uGuJGF6I+Vn4caz4MFWsPDGVynHLOHM5UXdU8iUxXmYPr1/tJMFgGuPZeo0AjFXs6d3GWyNG7K3139UwLaCbxR5uEba7dnvn/KUFDMvxO32c2xE5aHyL/See5/WppOPDTKLrbVU3xog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178791; c=relaxed/simple;
	bh=8NMqJS5FE05ScE1GVdNh/0ZxEg64+mb8VMyt98+AZXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNFiJhw0KXqAkogQrKuC9lNAsbuQK7uZ2ACH1hEkejxjpCLrEBdYZoEWv55yOJzRPS7HMHS35ziEcrrVoN9SNLNlM11CNzoZ7RpGPe9UsVMcIwxwKlySzsk8V4ychHWWp6t1PI6Hoa2dsaLqWwLRhkEeq//kmAhGdStrF/WRuR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmhUu5p4; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ad9fabd08so11819039d50.2
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 14:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773178788; cv=none;
        d=google.com; s=arc-20240605;
        b=RgkKdn/yvv872AAaItbKLvlNy+deRoWJNzLXuYQOMY4JHBF3NyBi7O0hotDeTUh43g
         kNKsBnd9sH3s2YHhpPRZuq+ctnIRlNKOqndcPPQMVChMYJQyexLuUSqqf8EAkK2yvgpO
         qZ97srp1gZsYiv4484RVNbw/5TfN179ApDgZuR8qI5lW3ORwH1092ITC2/7SXUWP/wl9
         Ks5ezhP5BglvxmhuroDGVxMuJjjtRu9Xd8ATVMEHTuGEcbZhMsSDJUpUqgHo88lSmQH8
         yukKslg+xLA/GRLJfXblPxh/Lv/fbH+Wrsmmgqo7+fWi9K8R+puRUWF1J0wTF37T69XE
         gs+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xdZ9t+WLWx1t34JQ1vsueQK3UJhCptmEn3mX3miWNpo=;
        fh=XTUuIssyuJd4qRQHDLlDV5tzqRVXesZI8iHza40in64=;
        b=ABgou9HyeMFOHjQqx19t1QCRlBd6Rqzj9zfndFlMpeGAc5oNAjWCiZiun92dxuJPMI
         t4nidmKad3R1OZK3GVhyGPeRECof1jk0Eu14qOwYo0Zxrce/DwhQa+a/5G6mEoridiNh
         SKpOF4/r0oZO1RGeH3tSPtKqVtwnUqOTIf5kaimrjZCGroUoQxt8ssLvXpjmClX3lqwo
         kuRqYjRcYdLzZHKd5xBad4TcLCWJTSUfIMaEnbGu/lsD22sYO+7HnHG7/2XbzBoJwuab
         p/am7a1zgg0eNuceakYQlY/MR6dxaXFsujNO8EjDAPSufWZyKECwKHvntW45gAmEsjKc
         c/qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773178788; x=1773783588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdZ9t+WLWx1t34JQ1vsueQK3UJhCptmEn3mX3miWNpo=;
        b=ZmhUu5p4DRH5yt1bsRm/4hmBlqVHKrtV2ROCKdX4mjJ46HG34V35fXSPlS6OG/IFsi
         xYELCCVqjGT4/WnVB/u8jPB639b+87WLJkRheuxv2Z6SJlH0ozy4IoVuamC0lPRnVhg+
         U3m38pNVW5wX/4oSUkpCrk9Scqm6rCPch5/DrANWEz2vARaNjd8EBagX5cMGTj21DVJ1
         QV4mO89TRMzvgMXAZp+7+5VFHwC61Ei3I+EhJ6xhLezTnJIuY6NGBX2+4+jXcp3XeifF
         MIbhZahjB87NbeVs8ND+MG83kLtCbBp6yqF+6mHakNwicW61eTKpxXDwFLqHn9rVgLSx
         6K/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773178788; x=1773783588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdZ9t+WLWx1t34JQ1vsueQK3UJhCptmEn3mX3miWNpo=;
        b=Zi5eDE8oUigWjO9TuTWUw8erlSPPN6bC9/ms7TBBXOf78I+ScNMVY4/HdbWAO5Gdj7
         mfSgNv0rDTEzW+rYE2vL2qant9mx89bvVOJskuc6VOPU0fpanVyGJ7SRRHJ+fEX6BqFv
         G0ioWJBJIUbq9+YM3nytdAOxHazVGMqtMFtWxtYDdWKExyvDO/v4WOPNGeD8MY6bmLZS
         Zm6T/9KMWCTz9OmS3pufgOK+SEIFenQB3zVrosNFVgXFJs7hT8emXxAFBLz6U5fUyBJ8
         SoJSpivnFuEhlfJ1Xpx1mXzcRyPLSyZTPqpDhaq37ipclpTm5MJtSHz/eosm7pBmhkGF
         zAJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTZtKhkOZvaQG/1gtsRyaFWKDm7h/iFiuOCgBUrBOlOZ9FCViKv5SmshRhVBvD1/T4xtIEriM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAgivJE4hPgobs58u5dSkWUwlZUhXqkSy3Oex4MafaUtgfSh1r
	CB06AmpaTWGUiI9WHOQmx9UpXEtIb5aG9zdESBGSRGQURRWfG3120S2Ky/vQASPoZpCLmP1iPu4
	aqSzToRCGuVGhpfEuSBt7vjTRDcgEJWQ=
X-Gm-Gg: ATEYQzwraU2xO46H+56PcJVKg4QJU+QcNSSyW4rlbLSBjgv9sJo2aLnuFi90fPEusow
	ztbonFeTPMEVDeWDPhkEYue/GTnhXg7Lmj2NKPfulsRq4pclWtkmCxRYcQXVyy9XNqTg/BiyBMB
	qfTyy0vIEU88usRqMo9O7PEZ2mSLy6iDUZVSm2aObEGY7nPMo1zr0P1ZNQmbeqfZQzXQPCae4vn
	NQrAJr3DQpmHowPpSdGTbwoay3Kv7GY3+Tnj7GnevdbWy3JNXLMD+BNFlFmlrPhos07qvfxOe86
	qtJKfcktnObTYRhrZFqIK3wiuWcbDY8uDY+owGFVOOnz50VywSVMLPvHYL7U4G/ozTb+1Sc3gxz
	lE2mT
X-Received: by 2002:a05:690e:2446:b0:649:d33d:91d2 with SMTP id
 956f58d0204a3-64d657df354mr140861d50.77.1773178788137; Tue, 10 Mar 2026
 14:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abBJh7sJ11RKVGhd@1wt.eu> <20260310212949.74577-1-research@johannes-moeller.dev>
 <20260310212949.74577-2-research@johannes-moeller.dev>
In-Reply-To: <20260310212949.74577-2-research@johannes-moeller.dev>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 10 Mar 2026 17:39:36 -0400
X-Gm-Features: AaiRm50RlGDuBkd1-y23MKWXvODtoxFrJ_tt8AUNG2bCcv2zH63eaYTWuoTG9Ew
Message-ID: <CABBYNZL9jc1yUBRj8=Dc9ajT5dgU873aTQ8CZ=pHy7XT3Z1PQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload
 length before access
To: =?UTF-8?Q?Lukas_Johannes_M=C3=B6ller?= <research@johannes-moeller.dev>
Cc: security@kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Willy Tarreau <w@1wt.eu>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 286BB25868D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224584-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,holtmann.org,gmail.com,1wt.eu,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,johannes-moeller.dev:email]
X-Rspamd-Action: no action

Hi Lukas,

On Tue, Mar 10, 2026 at 5:31=E2=80=AFPM Lukas Johannes M=C3=B6ller
<research@johannes-moeller.dev> wrote:
>
> l2cap_information_rsp() checks that cmd_len covers the fixed
> l2cap_info_rsp header (type + result, 4 bytes) but then reads
> rsp->data without verifying that the payload is present:
>
>  - L2CAP_IT_FEAT_MASK calls get_unaligned_le32(rsp->data), which reads
>    4 bytes past the header (needs cmd_len >=3D 8).
>
>  - L2CAP_IT_FIXED_CHAN reads rsp->data[0], 1 byte past the header
>    (needs cmd_len >=3D 5).
>
> A truncated L2CAP_INFO_RSP with result =3D=3D L2CAP_IR_SUCCESS triggers a=
n
> out-of-bounds read of adjacent skb data.
>
> Guard each data access with the required payload length check.  If the
> payload is too short, skip the read and let the state machine complete
> with safe defaults (feat_mask and remote_fixed_chan remain zero from
> kzalloc), so the info timer cleanup and l2cap_conn_start() still run
> and the connection is not stalled.
>
> Fixes: 4e8402a3f884 ("[Bluetooth] Retrieve L2CAP features mask on connect=
ion setup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lukas Johannes M=C3=B6ller <research@johannes-moeller.dev>
> ---
>  net/bluetooth/l2cap_core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f8ed03095592..93e41d9ac124 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4616,7 +4616,8 @@ static inline int l2cap_information_rsp(struct l2ca=
p_conn *conn,
>
>         switch (type) {
>         case L2CAP_IT_FEAT_MASK:
> -               conn->feat_mask =3D get_unaligned_le32(rsp->data);
> +               if (cmd_len >=3D sizeof(*rsp) + sizeof(u32))
> +                       conn->feat_mask =3D get_unaligned_le32(rsp->data)=
;
>
>                 if (conn->feat_mask & L2CAP_FEAT_FIXED_CHAN) {
>                         struct l2cap_info_req req;
> @@ -4635,7 +4636,8 @@ static inline int l2cap_information_rsp(struct l2ca=
p_conn *conn,
>                 break;
>
>         case L2CAP_IT_FIXED_CHAN:
> -               conn->remote_fixed_chan =3D rsp->data[0];
> +               if (cmd_len >=3D sizeof(*rsp) + sizeof(rsp->data[0]))
> +                       conn->remote_fixed_chan =3D rsp->data[0];
>                 conn->info_state |=3D L2CAP_INFO_FEAT_MASK_REQ_DONE;
>                 conn->info_ident =3D 0;
>
> --
> 2.43.0

Ditto, send to linux-bluetooth so it can trigger test automation.

--=20
Luiz Augusto von Dentz

