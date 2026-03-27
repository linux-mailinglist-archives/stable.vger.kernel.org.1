Return-Path: <stable+bounces-230703-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGdiJdXFxmm8OQUAu9opvQ
	(envelope-from <stable+bounces-230703-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:00:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1439348C5A
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 19:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53ED13016530
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 17:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909EC3FEB28;
	Fri, 27 Mar 2026 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sz2m6yt5"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AAB3FE677
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634047; cv=pass; b=eJ8i66vL/7jt7eDzXypA3Ww/+XZLNHUfH/8DvkYj4PNbCZ0UW7eHIQ3T/xXlOqEYT5/4NEBmefEmcpBV/R9MCRmFJYROaqmJ4mfM4vcA5TNTx2Jp6d10DbM3tYnNcxKeBIzU7Tg/3XpbYkptQ7yWXKk2ZE+oPAh1sQq0KDKsDIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634047; c=relaxed/simple;
	bh=LmFOfz1O/NDV2XSAtVLTWjg01qByY+ybHZMlf9JXSJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/IlDzLWMS6duUbrIEBkmGn1/VXTqn2Muae84PtDa1T2I6Phe+T51qHspJDV2AsYDaksWf42msisOweQS0xGY3pzMVjg4MWm5pWpxftd/B9gkSOwBc3p6XDY04aidOHAXVfgZl1k/epg1QqpSYMU1fSam73pb5Q9uXG3RdFGhZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sz2m6yt5; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65003f40a22so486822d50.2
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 10:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774634045; cv=none;
        d=google.com; s=arc-20240605;
        b=CkbbtEbGZVNRRZdo/O66jvvwi3kYceocfTkPSe6vpTpsfh1UOybmhctzd1OMB6mFYG
         TJGhyac90Zk0EE/7z9LePyi/HYIGKb4uNK42IcwtAcwl2D1EwKOQAi/+vA5tFufnpcfC
         1br6wGqH3x8YMOvJu4edkjhUFNf5qeohgB4QD6uAth/TH2dxkg4+yEiHUOEYOGSEyqGy
         4QfIaiWXe2EDrd8zrxBGocBgBpKsxRyEB3wYMUwaN3q7rmRu4pdJM9LOjuTvVPW1h/6J
         kPkJ/HOQP07Fx+9TCGaFX/nkZK2GUTWnnLWyY1+aWC4X0XisrqLxSzay2HASw3HgygzM
         Rp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o5jvKAEq5Gk2SlSedePjyJ1o9p5DlRTHGGledO1XifM=;
        fh=eDLFDuVfgn3qJsG2gJ2rm+O8EDyQEEHewgjYjIew+vI=;
        b=TNL3QiACFZX9JN/0ybt+lkc35nN3RoIduLeDXTIXZWNAD9Fevsvss9g+0PLDhum2lb
         A0RjFbYc2xertav4824/8fLbqlkRk0mdfcKzlPkGQhIfYLdaicxjQgSn7MYtKa/H0ENh
         tUI1Kloy9piqDXV0FWRvvzxBTjR+TfmedMvLppPSw4Og/o7eYq3I8NNIC85GL1MI03Zx
         o9jtyM0PTWNzGzqZy1nPuIz8t3EHcH1zqyv1sbyHtYN/c+YxDb8JbYGzEMJbxobx4UgL
         z65n08y1JGHUyXT1Eg+SJoQCzi8NeCPXAx0L4sh8AG7YkWPgc7d4nIqjckyNbq8hDrUk
         jIyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774634045; x=1775238845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5jvKAEq5Gk2SlSedePjyJ1o9p5DlRTHGGledO1XifM=;
        b=sz2m6yt5CeNweQ1Vrop/sSc3euTWq7UUgI9DoqfPDpa4YsmPhecfKp/OEYkhmj8PBw
         zVYuOjN4lHxqhYD5Ws12HgqtTvHmbhQ6fCxZlFFwAZN1Ddvgp8zydrBRwo/2SWNCRlf5
         VBY9pGGF5zxyDlepL8UmoYU8DoFqztUOIDDoZql35cnrTmISwEoa6z4pmq1D7oes2Rdc
         dTx6k9131jR9YUkCqIXM3RLn/dx2/4AJmaL6nwCQiBwKDK03c8u51/f+U+V0Ed4I38Pi
         o5I73z2/54hiyZKfgX0kiHC8KQoJkJ9NAM9nLVdJZuzPqso7SzR2cVATQToMsZzowvmy
         7Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774634045; x=1775238845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5jvKAEq5Gk2SlSedePjyJ1o9p5DlRTHGGledO1XifM=;
        b=WS7h6cN80ft2FbWnO/7Ek0NtWRHyUiUEISXe0T1PjMFKm2AL19+AnWXaC6VpxnNKbi
         gN4IGL2gqHi9z1iEZhXTN8x0XrHwmOBypViGobdrG2OeQIeC5u09yJhVPp5zvgld3Joz
         xBc4gEqIQJKkrC5yqCS6NDC2XEJcj1Nof/0VlCE21eNM24KYJCxVo3FKKrkOOSJCVCub
         qgeuzlEY71bqbRTwd8zGBOFqlT0KQ+Hero4SmVJ77t3Fg/axb/C0D7qseB+Ip/pqTMnG
         E2LQ5sZsY/wvwmnjS50+dGVjh37C2qmEXN4in5opMrNZUpFUgIYq2ddAOGPjc4KwuwCb
         sN/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4gzJuFe1wyH+s+QYms3q3KxLr6dz5TIRJTTx+/vVHcBCPFBRTHlMmNaYzvHsh775UGm3Fm70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDC3H7fbWj+mSgwj9Sg4jBurhqPEplp/ZdiPNu4YBbAL/VTgth
	rCfpfk+uciTVLuN5+h/rQINMe2MJQUyqlmzOh+SFbFNLXXuyZ2DrgGROttCS3jjVqCPv0dz7adw
	O6PF1GvulzwWXk0VfMMoJFUfI61Rk/CA/Qmx3Zb4=
X-Gm-Gg: ATEYQzzw+tGTbOCbnPMASuPlo+G+6ygbOEQdhTHF2+9hl9RoOJURz2cmsqpGx6k095t
	KFJggaa7lOKz1ydFj0oHo9P7FQTw8EnCJRBIOd8pQXEVwgQm0ebHucPg0r4vMuJhrhk/E35tLRy
	e67nQ5y9rgkYsAYGA6Sb9avhbNpu61uusR8qger1lnfr2VkGUY/GAhLZwdby8StBVJdkpynMDU0
	++X8at8jLlfZ/GMgkkTx3H8xFo9L8iv/Hr8K9ZAoy8OKIMUfmi1NiT7eC9L0qmYJS0HHMGokDrG
	bhy5Bc8heKc/pcU6UJeTruoi+JVgVts+r+Q3T6tk5UNpvABG0YmgAQlytbz7m5WNx0L0qg==
X-Received: by 2002:a05:690e:16a1:b0:64e:8cde:814d with SMTP id
 956f58d0204a3-64ff71edc43mr3636436d50.17.1774634044730; Fri, 27 Mar 2026
 10:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Mar 2026 13:53:53 -0400
X-Gm-Features: AQROBzABUNBAq4NDI41MlQecMK1c72cnfWT1jZSJzoRfaj-V1aWkzICh_EWxFMw
Message-ID: <CABBYNZKY_-QgsenfU4hpyQ1+87rXDS13wFueN2nX6Wojy4BgHQ@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: hci_qca: Convert timeout from jiffies to ms
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, Shuai Zhang <quic_shuaz@quicinc.com>, 
	stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-230703-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,quicinc.com:email,mpg.de:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: B1439348C5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Shuai,

On Fri, Mar 27, 2026 at 4:30=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> From: Shuai Zhang <quic_shuaz@quicinc.com>
>
> Since the timer uses jiffies as its unit rather than ms, the timeout valu=
e
> must be converted from ms to jiffies when configuring the timer. Otherwis=
e,
> the intended 8s timeout is incorrectly set to approximately 33s.
>
> Cc: stable@vger.kernel.org
> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump =
during SSR")
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Changes v4:
> - add review-by signoff
> - Link to v3
>   https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc=
.com/
>
> Changes v3:
> - add Fixes tag
> - Link to v2
>   https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc=
.com/
>
> Changes v2:
> - Split timeout conversion into a separate patch.
> - Clarified commit messages and added test case description.
> - Link to v1
>   https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc=
.com/
> ---
>
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 228a754a9..d66af13ab 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1607,7 +1607,7 @@ static void qca_wait_for_dump_collection(struct hci=
_dev *hdev)
>         struct qca_data *qca =3D hu->priv;
>
>         wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
> -                           TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
> +                           TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUM=
P_TIMEOUT_MS));
>
>         clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>  }
> --
> 2.34.1
>

https://sashiko.dev/#/patchset/20260327082941.1396521-1-shuai.zhang%40oss.q=
ualcomm.com

Comments seem valid to me.

--=20
Luiz Augusto von Dentz

