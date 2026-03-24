Return-Path: <stable+bounces-230185-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULxWH4KrwmkyggQAu9opvQ
	(envelope-from <stable+bounces-230185-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:19:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AB6317E56
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F8A3004C6B
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 15:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94300405AD1;
	Tue, 24 Mar 2026 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rR+tXm6y"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD704035AB
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364815; cv=pass; b=eAij+LWvGn+Em06VnI6XqasWrXA7ATI8VXQRpByZgxlKfaiSHKoNxRdFIhac+rIFFzJCtsNHQ6PvpUVYIPv5Z0Hie/8+2/CzVHriOWdxiIJq4MCgw3WQ0wz9WjkSPZ+FABzSKfb/e5xhNJJxvtwKlO9jNYOVerBCowGDEgXYP/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364815; c=relaxed/simple;
	bh=NaD7W/0+/AzDjzU/YomN7iJVaisIpYn4PnL1wKtQJr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4vCTi6mAD6Jg2igDWh+fqrp+jGThl/I+5y8J/A0NmlAMtxNzD+WiLIf4lZLPStexcGcaps7GZcNBC/BZ+i3GOIxrfBLTqNPkFKEBo+PjFFJkM7oBkbRQ1pKF3FO6cVs0dQWlBnCPDMDMR9bMXHxSMDmy+XODXBrR0STxUjfJMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rR+tXm6y; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-46808125d28so889708b6e.1
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 08:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364813; cv=none;
        d=google.com; s=arc-20240605;
        b=bQrqMBtM+fKgSYFJMfcIXt6X3TNdhyuPNRy+kL2XGvzbFcqDhqmZI36eC1voMNPM0U
         a9uVOxbUKG85M6VDA9edBiBqQuaK4MAoKyvDQBkRSogwUeJLjt65zTW5//zAsoiSK75N
         colwbMM4OmjAEX8/7mBr6Vtkb3jp9cWGLQNf2ssEuqltc61ect5bHniV0kJEjd85yTlO
         lXThJDCvXgYxPXrSKUo3Kv65iDi7vcwB79rISuN3HzM6MjLSgVJCX7QRSXiw0fnFubOv
         NjSCUGdSDggge+qicAiU4Ru0ZfhNRth7937qGW//tOozhbNiEnKcLpRO0NQYiWzv8nZ+
         3eCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h35MYrusxiN2Jc9fAg2QnigGOyjGG2azumkiw02qMJI=;
        fh=lvPuTDorf46fDXMNMLfM0zACUn8l2NsLjHWXe7yWN3w=;
        b=JHxMRLj/cLQXhm7SZdywKr0lKMyyceV4S6dtpiJSfSu/rP3xRljdUP5Yj89OawvuEE
         ifSC6ISEgi9YjOJAw0D6k2GA70PT1eMdDkuJtwiuOGfzwINrqoDCWU2niZSH+jAcVIno
         t7QpLbgAaplAS/yC9z3z7z+cf61gUrr571lN2bKSAhhCiZjY95d2XVmCvYjwonZVbjmr
         xm8Fnl10yDqxpegEc4YKF2LQNILqsS1mdsmjhcSyHoYP+T2JtFYr15dDgqAazVr50mr7
         sMZ0gzGxgV4NkPA87GFuqX1m/z0EAkvyAseP/2iZ/4+Acp+3IE1iYqi217aDK79RpOSS
         0a/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364813; x=1774969613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h35MYrusxiN2Jc9fAg2QnigGOyjGG2azumkiw02qMJI=;
        b=rR+tXm6y6iCgE0Vjkthvf1r6zNd7xd8Eyi1UFu77fJe38f7NACpyUwdhmectg5vqiq
         mAxzMNTtzGqndRI2C8SsDjqz55JdpBNerqGUaychw5dnoiff56XDDInjMk69poXEveF/
         OtKQ7heTbw3S4G4Nn+39hL6BRazlvbx//ZrO6KheZYWUQxJ9afASW9KO18QTn+K4/xml
         heYNmAP1q7q0rL96h1mmrDdnl6y0YrODEx8WiFnZ2MvHUYpizej/vJ84mr1Ed0Cv5juW
         AYJgxwjZgbgbJAbdDNAhNIuHe5e3fP3K7Woz/gV1lAtXZSzuzBRsN3vu/lWfPKIPAfc3
         YCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364813; x=1774969613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h35MYrusxiN2Jc9fAg2QnigGOyjGG2azumkiw02qMJI=;
        b=LTTMrSqJWYqxNnWJPpOQ2jd4UAxy6kIRmnebephFuYq+45LJljRALGid+y2kSqsqiW
         19MiUBkxD9QTxeLVHwgpoxbbcnslFc6KWmjT8HmoXRyZNKMzvhwx569Lp0MbfdQVY4VU
         ndaH/Ld1hcCnkwdQRRXxisBXtbQ2+yHn0mcagnQje3rIRIWc1wNlh7GVhQM4Xv2VMlh9
         IeqMCDM+7CSYTiXcDdT8bkJzd6gTL8/1RZHI/PoBiSbHAWepAyq9DN8IcIIsGb6S4QyB
         YeseCdZXvRjzaaRs3n9gq596h4tlvSgv7QM0PfdF8/QH7Yl2N9gacP4srCwz3GuYrfo/
         0QSw==
X-Forwarded-Encrypted: i=1; AJvYcCWPYb6OF/CUNSDLl44q0KYnTpscoNTid4YuG/tSEu46Kl0EYLsC9Jwi5/8la2Uz0R/FlT1YiCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymFqjkZ1jq7mu2ydaNBmyzI5qwysBdpQ7teEwd4N0NcoL9PsWV
	QlJoSmAjmAezea8kcwBGhxOPqXA3OygSI0Lvt3W4kAQzQ2VX6m+BUIMJ36LgxHpukxq1ujta2Ip
	kR2Dnq89Rpg9S1YZ5elZdGu7wT+KOdmk=
X-Gm-Gg: ATEYQzzGPvh9LV8zw/p/ge/ma9F7533p9h6L6SOKevkzUAJMbHLn6vJ5ipQSSdurLFI
	VTPjseAhC9ecbCr8wgAY0CehCSnsIJaqu7Ew/yWGge+KP6p8YNjuiKq5ElwsCHYQ0pUOT1bA/H1
	xi2Wm+u6GekNGzKkigCELUhBa80XXPcyVV4UZeE8WDIdMVB6CVtDJCfUU8IzG6cyGdEH+IU9j+V
	jbftPfpN08nWdgnriYFG1P8HJTb+tEYKwEGPvogAAYCR+vJ0LnDrIZ/OZ3UCTH/jouo9fc3WWZ1
	zcnaEZ6VfD67jAMh6UFpCZ2v7tWwE9w0EksTb2iNd3rC7fh706vG5GLpb/a4wZrxY6w=
X-Received: by 2002:a05:6808:2222:b0:467:5571:1b0a with SMTP id
 5614622812f47-467e5ded2admr10127904b6e.26.1774364812967; Tue, 24 Mar 2026
 08:06:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB7881B5254647551279894DCDAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB7881B5254647551279894DCDAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 24 Mar 2026 11:06:41 -0400
X-Gm-Features: AQROBzAxx1Dwwwx89HNgrvwdudAStUv3q7i0ZyWK39fM8C86JX9g0AfOCSmbYD8
Message-ID: <CABBYNZ+Mo-UWu3Z-rg2JMzEbU=GXB3bizVcGqyJnkUfkJabAAg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix off-by-one in RX queue
 bounds check
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Tedd Ho-Jeong An <tedd.an@intel.com>, Kiran K <kiran.k@intel.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230185-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[holtmann.org,intel.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: D1AB6317E56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi @Kiran K

On Tue, Mar 24, 2026 at 9:27=E2=80=AFAM Junrui Luo <moonafterrain@outlook.c=
om> wrote:
>
> btintel_pcie_submit_rx() reads frbd_index and validates it against
> rxq->count. Since rxq->frbds[] and rxq->bufs[] are allocated with
> rxq->count entries, valid indices are 0 to rxq->count - 1. The current
> check uses > instead of >=3D, allowing frbd_index =3D=3D rxq->count throu=
gh.
>
> This causes an out-of-bounds access in btintel_pcie_prepare_rx() when
> writing to rxq->bufs[frbd_index] and rxq->frbds[frbd_index].
>
> Fix by using >=3D so that frbd_index =3D=3D rxq->count is correctly rejec=
ted.
>
> Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe trans=
port")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 37b744e35bc4..cbadcfe86321 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -460,7 +460,7 @@ static int btintel_pcie_submit_rx(struct btintel_pcie=
_data *data)
>
>         frbd_index =3D data->ia.tr_hia[BTINTEL_PCIE_RXQ_NUM];
>
> -       if (frbd_index > rxq->count)
> +       if (frbd_index >=3D rxq->count)
>                 return -ERANGE;
>
>         /* Prepare for RX submit. It updates the FRBD with the address of=
 DMA
>
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260324-fixes-8c301e8881f0
>
> Best regards,
> --
> Junrui Luo <moonafterrain@outlook.com>

This one seems valid as well.

--=20
Luiz Augusto von Dentz

