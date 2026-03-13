Return-Path: <stable+bounces-225372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGT2LFBNtGk4kAAAu9opvQ
	(envelope-from <stable+bounces-225372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:45:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53993288448
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAD99303CC18
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E93CF685;
	Fri, 13 Mar 2026 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h64PINvf"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f226.google.com (mail-vk1-f226.google.com [209.85.221.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7CE3CF033
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 17:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.226
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423919; cv=pass; b=uUDR8J/TxwH1gg88hD6+9+chlploAn4Lkq4eWaP47Pr6ccMhKF9rBCOedmsMO4UP89lYTt3IHzagQ+Y6jyi5MJjapD2y5vcgUqCJGPSdKwZ4VMBcLFDJL1X2cBBQ27VjIJ+Ymfvsotw2AuquVbgpbtUSFJtxc48xtsscAsE880U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423919; c=relaxed/simple;
	bh=OZEmfjz4mzkUQyVyiBye/ZRuj3xDIX6oensTNPL31vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pOvBGEFh5TbcNTK0fy3pY8DtgNMOy8SmgbvOLUWI99HelyPG5dV+RWlvXv3BSpXueVtiRtNSgNP3HjQrj/qPL35ogUTw+1YkCeeeHQoyZoMphIJym32IIn31Af5fbfrVneuFaOY6MzO+yDH+0Cl5hZkKH9GjnPagaZvciLh1YRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h64PINvf; arc=pass smtp.client-ip=209.85.221.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f226.google.com with SMTP id 71dfb90a1353d-56b679e72d9so315710e0c.3
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 10:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773423917; x=1774028717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZG1A/bAT6FLKS494L3H4RjVOOSz3HoBax0Y6iCHlgk=;
        b=ig94aZaFH+PQ+QduBiEkZImBtShVdk++7VDRSirikkvz0RhCOa0mZRCfYLhB5mfE0b
         2pLu0OLxxZ1i5tgRixbcoOBaBUxEWFrCnnCScbVMyvairTAjaz5wbBW4RZq/HCY8sJi8
         RmQ2V9f5n484w3f0HD8IuCjgHuM8OuYRMOq5ZqhTE22DX7wq9erQX40KlLm2F7YD1RBH
         Fd/E60jeFELxBjGtPNi6pH8MC/FHxpji8JXdaQsI8AthKrNBL8FK5y8JZRXmisSRC54c
         HDwHEKgUYJdu77HAxDD6FBMB074k784GvPGvJJ80rfpFAnJQALKhZ877bJ5PLl4p01Ml
         TD9w==
X-Forwarded-Encrypted: i=2; AJvYcCUIgkhLNGDKm+mabd+E58ieOvmt8n1otQagh3M0IAK6dS/yaQ3LpP1sAnW9yga74UUqpuqAY5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTB1Lv5afgol39HkozXahUIEuU5FYiCT2+4IKmRyAYvMYi0rku
	f6QU0Kp1+Ktt/lwnWskXE/PJYRSWcA3UCbnLs4CVuvsmqxeWJ6n4NAkC5jtJ9YAZpyFac0YGAfV
	Psex6Iw3BxeR9goQfbFR6PQN65gRUiw4T8urrAYOTwSsSjWB1UWFA/3g7Ca0LhClk5zVQR15ybc
	500biegKe47lOLHuOjAfn5IH7oUPYAbsSkJCA7nmptdPJNLANO3cKugY4JCtQcLAKyMR047aeA5
	F3WAQyU2NE=
X-Gm-Gg: ATEYQzxguIIT1h8IIKcgNtKGntMej4iOEgoRNWTCt0F+tx4xeWoie/0AR2kDmGjrwXs
	d/HGgQAjSH31EZo2srmPwWbE2IyvAnOdPSv4j3PTCrJ5JRpd4A60xO0oeVKWTPhMD8VbHpc9KpB
	r4tvDlr1tZLFckeouh2/cyco1EaaXwh8p0TVB8pcjNZD4E5+k2SSFj1J4ZbCqj3Bjs6JxoyQeD4
	fwBaNVCwTxRrEObLhOS7y7Hv/GCyv0n5A0hr8FyUHJk9bXZMiAwUd+fjdC6Z1bi5xG39a+f+svY
	/sUbR63i8rjkEgUgeBZsw/kjWSeXRJKB1Kb+pPg3K04aUseGWdw511G6htkV+jut+J9XqU4J3jU
	5jjuxAv5cu0KbwX1QG12ryOOs4fZr6tIW4efZiKAhrB6/2kz33yzAmXRyk/Z1Sflz0uvfbI+N4x
	HzY5+KNhoYx5L0br1yUxtd2w1U/acyyJb2IMoUMFSVmUDEqjBbVcnmfgYx
X-Received: by 2002:a05:6102:441a:b0:5ff:22f5:e37e with SMTP id ada2fe7eead31-6020e21eaffmr1690652137.10.1773423917160;
        Fri, 13 Mar 2026 10:45:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-94ecf9bd554sm858582241.0.2026.03.13.10.45.16
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2026 10:45:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-661ad73d41eso3460201a12.0
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 10:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773423915; cv=none;
        d=google.com; s=arc-20240605;
        b=Ib+s++A85HWlcp/jlnqnLHNXV3ZBWtY4GRlQS/nIJSZAsg+ETLc+TlyDgbs8aPywsI
         3yWCOp0el8GZpPcMe7Pa/yBmKhbHyyhQvMbvDTZd0EDlvNOCGpHhbSB32FHdf0xmFx62
         c/c06iazGv02bJeoTzgWR5Tc98G4wj6CyZpKPOfYfVmOHVcEAtrD3NtnlalhNm6MhHd4
         07B+3vWt8LU7c2CqPh5079Gq19HQP0Wv7jJx54V04YLrJAy2lvGDSuWh8UY/GuXMYz9P
         WeUdGoXA4wUZH2Mg4rx1rtrHJiCeJe/QkVFBVLtQxpjMd9f6Qk87aJL9hcdfEyAH8Q2K
         /07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5ZG1A/bAT6FLKS494L3H4RjVOOSz3HoBax0Y6iCHlgk=;
        fh=Qnhg0P2/Pvx+yXkwWSZz6QAIpZEyqIdGVWSQrqrNj2c=;
        b=ZfKniXJJq1BweSdKawEQkCuOxoGZo7IYJfaDEMy5Ak/9pIDyu4MLTEPSgXGB7PwfBM
         HyydAI3E/wuitKMO5ZcVYORx8PL74u8kf2mGOzs1NqgFbt5LKXLPKEEUn2jMOyf7U9KB
         jsS76OLOYShgztPSxxDOwRdEGnVP2/CqwhmE2R5Pjryk63mNX0WvRWYsSFUBhv3F/Ylu
         PhzhlmWiemAouO77p6VK/AdsiJA0Sp4Nv2ZTlWb4W0rnAW+LTieDQkhe5lVlPlHJPQmS
         WbYunC2jg9Qh+BuzXYmxMLQnnDq5MD7Y8V52qfJRSXQ7+kujkb5KIG3AGWOiQ09/c9Jw
         yRkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773423915; x=1774028715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZG1A/bAT6FLKS494L3H4RjVOOSz3HoBax0Y6iCHlgk=;
        b=h64PINvfscKGUZUXHA3dMOf7/IOC3NUsldJwOBe1GVvxWq1w3RID6wm3hPQpZ7yvm9
         0cHJcVIV10hm7SPrwm1hC/Na9awzyAXKblDfUBS+mLdcChqrNMXxJqzo7w1SiNusAP/3
         7VKaqOSUbrVyHAIvxFCI88+0Ru5mfrzS+Ht/A=
X-Forwarded-Encrypted: i=1; AJvYcCVoE6+eHdli0gXTA1KoW1AjdnvRdX3pB5W9uexLzubU9vM6zUK2fpwqWBEhhnjRJ2hCz71qlrk=@vger.kernel.org
X-Received: by 2002:a05:6402:254c:b0:660:bf7d:ce58 with SMTP id 4fb4d7f45d1cf-663bac00405mr2298986a12.16.1773423915500;
        Fri, 13 Mar 2026 10:45:15 -0700 (PDT)
X-Received: by 2002:a05:6402:254c:b0:660:bf7d:ce58 with SMTP id
 4fb4d7f45d1cf-663bac00405mr2298958a12.16.1773423914961; Fri, 13 Mar 2026
 10:45:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB78817D5AED8035071888D7EDAF45A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB78817D5AED8035071888D7EDAF45A@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Michael Chan <michael.chan@broadcom.com>
Date: Fri, 13 Mar 2026 10:45:02 -0700
X-Gm-Features: AaiRm50_uuNqfmkU6eHOMKOYdhTrusa65KWUECYobwzmGaQyTWtQyPRypRBd8pU
Message-ID: <CACKFLi=+RWnoKDjqpQ48cK_LDX+DhajtH2ye+a7kN1OVK3RsqA@mail.gmail.com>
Subject: Re: [PATCH net v2] bnxt_en: fix OOB access in DBG_BUF_PRODUCER async
 event handler
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shruti Parab <shruti.parab@broadcom.com>, Hongguang Gao <hongguang.gao@broadcom.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008bfbad064ceb6ee8"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225372-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:dkim]
X-Rspamd-Queue-Id: 53993288448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000008bfbad064ceb6ee8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 8:38=E2=80=AFAM Junrui Luo <moonafterrain@outlook.c=
om> wrote:
>
> The ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER handler in
> bnxt_async_event_process() uses a firmware-supplied 'type' field
> directly as an index into bp->bs_trace[] without bounds validation.
>
> The 'type' field is a 16-bit value extracted from DMA-mapped completion
> ring memory that the NIC writes directly to host RAM. A malicious or
> compromised NIC can supply any value from 0 to 65535, causing an
> out-of-bounds access into kernel heap memory.
> The bnxt_bs_trace_check_wrap() call then dereferences bs_trace->magic_byt=
e
> and writes to bs_trace->last_offset and bs_trace->wrapped, leading to
> kernel memory corruption or a crash.
>
> Fix by adding a bounds check and updating BNXT_TRACE_MAX from 11 to 13
> to cover all currently defined firmware trace types (0x0 through 0xc).
>
> Fixes: 84fcd9449fd7 ("bnxt_en: Manage the FW trace context memory")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.h
> index 9a41b9e0423c..597932cdea09 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> @@ -2146,7 +2146,7 @@ enum board_idx {
>  };
>
>  #define BNXT_TRACE_BUF_MAGIC_BYTE ((u8)0xbc)
> -#define BNXT_TRACE_MAX 11
> +#define BNXT_TRACE_MAX 13

I think you can use DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE + 1
here.  This will clarify that we support all trace types up to QPC.
Thanks.

--0000000000008bfbad064ceb6ee8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCA0FlWk
+pYWbUQnkGxw3TWOeF0fzRPmlVpHzRHRveoo6TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMTMxNzQ1MTVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBdLM0hCjhydiinfk+j0DhomgNjP5St6kaRbbKdIE4C
Fg/gXpjPLIwsI+0wQieXwticvMWVHoFpqUKkTAaushj7sY1HOp8RUgC/v3N19fbhjzE0ybiyFRhi
bvfHo3Gs6sflpabS9/dx1iKes2/pg86qt07f6jKcjn1GFW4xBvLtJ+gjR07mUem2is6dg5O32XHv
Ixbk1IsUcQOiIk0aWfhbp2nbikrpdG2trSHHcJykmKOIy68UQ0XjB7QiGV8jEQuxD4aqLDvnXCAA
AMPoAAYKifoe4DVCCY+Fzv/zLTG9RqV5T5aeyk2rSfT6Jb17aD1pYpOmhr5LrO2GjlF+UxI4
--0000000000008bfbad064ceb6ee8--

