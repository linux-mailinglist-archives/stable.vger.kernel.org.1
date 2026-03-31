Return-Path: <stable+bounces-231454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB/SFFvvy2m5MgYAu9opvQ
	(envelope-from <stable+bounces-231454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:59:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD1036C3E5
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF5A931BE8FA
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B6641322E;
	Tue, 31 Mar 2026 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkOO1ubW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB523FF8BF
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971618; cv=pass; b=L7DI8vekwiw1NPCC5AbBbmYKdmE9T3F8/XVAj0FptAzoIheVzzgda5tMNnIl8i0yG5cxUzTc8cDgVBtX+dSO9GU2o5aFPk9L5K4nAb7lK9113VGAGm29QQCM7RDaX9dqtedkVGpKpzgA+YH1Oi3FX9zEAou/IosuQBV59JAuQeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971618; c=relaxed/simple;
	bh=M86POBW/a3TsEts6tVZ7TB0EfrjJxMIvFGo4HhkDcK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvzUGTRtLC2KRjOSTkZuhzg2QNIarIDPRMTvJZbJVJqELfQl1w532YE2ivTs2UjaVclBzh4OqJ5MTzT27glK0XkpQMIiWrV2LaufAatkria+JoC+qBE+z3UX2LeDUQxIp0p2Gi4n9njkhndZqiXB4MkwvmmVad7gZZoTm2XfHqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkOO1ubW; arc=pass smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d86eb7c854so3086805a34.3
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 08:40:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774971616; cv=none;
        d=google.com; s=arc-20240605;
        b=YDkoZAoQXXWMdhQdlunJweA8/cWbVyvev2knMmsh2g3OFVkGJho7M92SpCOVCbWeMM
         xu9OYyIaYjKHJsDQbWdI1DKphUPTpgE9RRQe3JARWxG85i+ovTNbzEd8E0PqbhParbF1
         WZCr2Yr6ND2afKjh0Y1FAfnXtjXH4cE1LjbZZHO8WqSQhj9EV4UilYc/rfiDjc/ku/Ic
         5AMmrduI8WJX3Eb9MNqZwbfQSfQWVenX+pdiaqr5Ks0Rq94ddrlx1vyp86crLKvchjPe
         wmTG3ZGnQkxq1pv8l+vwer5KwEZFnZz4T1t64QqIUWI7s35kSD3+3rPYr9Vah0BDsLGC
         0Ngg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u8qcruLr1TaN4a3nPxJC8zeje2SUnWQJ8J8aOZ6a6Fo=;
        fh=20JaHP+r9w/TX4pcZL3n5dzOP++LzO1svWU977HtyHM=;
        b=R7Z7CnC8sQXwXHBtGIntHjfRa2bNWmgzdTU2arKxK6k0yXXmSHx00YNLmcm+9eCQ7m
         Uka9Ajdgk2uYUX1iNhqoKxGvA0lG7NWKf1zXOAmDE5xAcYiQD3LFqyB0aBtdq5gmqg/c
         a28oNAR+47yLzlFHTRd551SBDQ8uo+LPnbxWXPL6zxQt82wyDBKxUBlPguTsSfOWiBMX
         D/TWzYMzJuAQyWtNB3sgfx7m5OBwR45UQ3RavCdrd8SU4RLF7GKLr1NyTVLRMmN8tGhN
         VvuH8gZCcyDSQfdBoysPummj8ND/ygSmRsaCyaveXVvFwum3R+qGHXTfPlZc8+5EJ70R
         aUGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774971616; x=1775576416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8qcruLr1TaN4a3nPxJC8zeje2SUnWQJ8J8aOZ6a6Fo=;
        b=nkOO1ubWeSgBynejD6YjsUMf4rGxqUG52/z/ZMrxG8uCSmw+eUI0nRSh6ranGg7xjA
         zliEmUdzHmYndZvYeOoDTCTqQV6YtkKQI8Rnmf5fPEXX7mMhcQoZyGpEYT57WMAf5M8p
         /GOTZ8DxjEy4Yf92ts63IfA0BrZEvshDztmLNQoQ1zFzhxslHxcE55TNepseMr7TTjJU
         MgLjevZbRop1ZLsN1V0uGh/mMoDei9iXcetugblwbhv8ARWQcF0AQPFS+IhHnPxyX19S
         ytE1bpXUTWJ99bEuKIbTUGW57qbJjQTft/dziHHrKkdB7NsRazbpj+sKVoUHjUX5PGbe
         Ch4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774971616; x=1775576416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u8qcruLr1TaN4a3nPxJC8zeje2SUnWQJ8J8aOZ6a6Fo=;
        b=QWJlJJROSGP8pgpBrh6zo/T86U+FcxjYTh4KEnpSqrPX5ZJYd/mPTtOTjyczd/3unG
         SHy5Vw7iYY7Pv6yXt9BfVBSfTcm5g/KENIAy5CkBBl+JXgOv78+FNdGyz4SD5d8DLDXN
         jHXj8TFcdBTONrlTYSY9HDGbIvNxyX2HXATgewQ7tL15YVYpJw61YE9bpdC3+BtcgMaT
         f0bqQzKKBujIpL7LHSvOJbfytHKUig1QI0fiuRtZZO2nwluBuZilrwWCMs8qTie5OqSw
         IF6PJwQnWLzHK9Rw8qjBkK5iXC2//mqrMJFozTDIWCOIHLAvPIEAiEpzmvbiWRn88T9W
         RhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4g3QS7AMzKwCyaUxKxQAaVW5G6BnsYCtZwnKs/SH3lR0wPcCm3Am3YZ758XRyg/Qxe4zMdQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3fGgTFg/Jt8K+rd9DQxpcHuW94lAIc7c8mnP/9no2wI+Uw2C
	FhcxpeO/ohWI5SkQnfWKisrrG+CB/pCNEKz50rKyFnjsv8Tf5CEJnu+1h1l8npUCkYIA8LGx+5D
	xsw2eOpuFYIxytnB/ZyXv6xe63vHduK9HFm2hFac=
X-Gm-Gg: ATEYQzzIPaGZfOFcAWXMz+nY7uEtLjwxxrsDmzPSkKFaRYc/6EGb29+Q/PmawbdbLW2
	Uu162X32I0sX52pe/TkwEmaolwDcuCPpIgRQV/AoxGCoZGX05LXDf4vaa90EAgIiuRNQ2tSBgmk
	yCQiN8TRYQAZeFRcrvZukYN2hTmMtq+0dFV1zwJBVtzOVZlqaEDQKdJ6RLgAcJS4+eZzOp1ykR4
	uv9r/ixnVcYVOBH9rCKEG58JxvFg6bDW3jRVGDKHb/eK+pGmEEtE+AIPhu5+EIJUwd5yfpr6xMi
	eHmtrIKUIkxi/qFW0u4o6SmsRNkDY8nHjQgpW8NtQRr5Tb8=
X-Received: by 2002:a05:6808:1718:b0:468:48d:8075 with SMTP id
 5614622812f47-46a8a395fb3mr7995552b6e.8.1774971616516; Tue, 31 Mar 2026
 08:40:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-p14s-pm-quirk-v1-1-cf2fa39cc2d5@gmail.com>
In-Reply-To: <20260330-p14s-pm-quirk-v1-1-cf2fa39cc2d5@gmail.com>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Tue, 31 Mar 2026 08:40:05 -0700
X-Gm-Features: AQROBzAt-wrDIMtX7p-AOcDjVXjahzEybmuxfvEKnbowGjaS1uRal6qZfRUGMgw
Message-ID: <CAOPSVF3tbkTVjW1o1NfrgbOA9v163n_QuDR4ay2ggdMs5f9Z0g@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: apply existing PM quirk to ThinkPad P14s
 Gen 5 AMD
To: kfarnung@gmail.com
Cc: jjohnson@kernel.org, mpearson-lenovo@squebb.ca, stable@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231454-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lenovo.com:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CFD1036C3E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 11:18=E2=80=AFPM Kyle Farnung via B4 Relay
<devnull+kfarnung.gmail.com@kernel.org> wrote:
>
> From: Kyle Farnung <kfarnung@gmail.com>
>
> Some ThinkPad P14s Gen 5 AMD systems experience suspend/resume
> reliability issues similar to those reported in [1]. These platforms
> were not previously included in the ath11k PM quirk table.
>
> Add DMI matches for product IDs 21ME and 21MF to apply the existing
> ATH11K_PM_WOW override, improving suspend/resume behavior on these
> systems.
>
> Tested on a ThinkPad P14s Gen 5 AMD (21ME) running 6.19.9.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D219196
> [2] https://pcsupport.lenovo.com/us/en/products/laptops-and-netbooks/thin=
kpad-p-series-laptops/thinkpad-p14s-gen-5-type-21me-21mf/
>
> Fixes: ce8669a27016 ("wifi: ath11k: determine PM policy based on machine =
model")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireles=
s/ath/ath11k/core.c
> index 3f6f4db5b7ee1aba79fd7526e5d59d068e0f4a2e..21d366224e75904feeae6cb9c=
93d9ef692d127fe 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -1041,6 +1041,20 @@ static const struct dmi_system_id ath11k_pm_quirk_=
table[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
>                 },
>         },
> +       {
> +               .driver_data =3D (void *)ATH11K_PM_WOW,
> +               .matches =3D { /* P14s G5 AMD #1 */
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "21ME"),
> +               },
> +       },
> +       {
> +               .driver_data =3D (void *)ATH11K_PM_WOW,
> +               .matches =3D { /* P14s G5 AMD #2 */
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "21MF"),
> +               },
> +       },
>         {}
>  };
>
>
> ---
> base-commit: dbd94b9831bc52a1efb7ff3de841ffc3457428ce
> change-id: 20260330-p14s-pm-quirk-0a51ba19235f
>
> Best regards,
> --
> Kyle Farnung <kfarnung@gmail.com>
>
>

Apologies to everyone, I realized that I lost my CC list in the sending
process. I wasn't sure what the right fix was so I ended up posting a v2
patch [1] instead.

[1] https://lore.kernel.org/linux-wireless/20260330-p14s-pm-quirk-v2-1-ef18=
ce07996b@gmail.com/

Thanks,
Kyle

