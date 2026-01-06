Return-Path: <stable+bounces-205125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA06CF9709
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 17:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A763730173BF
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F22326D5D;
	Tue,  6 Jan 2026 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H/8AgGyH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C62EACEE
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717664; cv=none; b=BlDaDDsvV4an0PYM+iVlT0W4pXWKNpJXct8/VhsiDlYnZB+D9PlPjhFNjXe5LhaBSBz153OJBnT57eXnTCx6tyW9zpWoxkYYuayxa2ti0Y89Yf4xLwxhAUlvVeX2u+eQtGzbjrArMnnUc/57glXgby0wSED2OJ2VCunP8RRpX4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717664; c=relaxed/simple;
	bh=NF9lFmdg9ZpfcMKL+FKn/TPqcl/qMDT9v/2lUQIP8Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBi3uenM4h0AQioKvL0EQJcsttqJd8MXJ0fNUNKykg++zCKYqBG0lK6QtJ2V8YM9VaDJGtfZy4iJ32w7wwcBQVj5QL1YDv1E/keskHWb+ZNkmMgCRdDPogTMRxOo1xVM/5njZ81XeCqf/Sm8an9WLE85vQ2qK4aHMwwUFwu6StU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H/8AgGyH; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-29f30233d8aso12115925ad.0
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 08:41:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767717662; x=1768322462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bCSbgV2Htb2ev3Z0vxXE9M501a8TzHgRq+yEArjcpY=;
        b=GWruSglijrI2vMJb5uuuafVj0h6eO2tAwBhDU1JrpO+kKtL/q3S1uH5xnWMFGeu/nP
         jYihcPy6PfhOoAbI3W2LRuEfgypbvu2+L/SVGNp0+LQW7faH2OWnB3B0TB2cCr+BAg8y
         q1+JD05y8p6NDmtUq9MaZIi2tle7mUBW/tXfRoUPotT+5Qqu5sa+6dehy2rUD/+rgWeC
         v6+QWMn/ekcg+NstyZSw+JbJibmP6+35p+Yf/7YFAFAQZ3vkqBT7KNQS1+cW7EY9RPwX
         8IGX8HOi+NWOcu0JNMZHEQptX9Zz1hM5nxFbfORhQSvFpNk5tPCB1ur0+p8/pa2tKWte
         1+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCX7Umm6TcwJ8Err1Emyr18dM17TcGP5ES1TA+utwY4IdgeYFEL17S/tAS4QSJ++YDZ7Lk4cvg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGihCAFZLxwZ5GZYpI8N0kW5cirR4esCV1TYybaWbYntI6adjy
	3bJ9UXOJcqI+g7IP7bGR8WWeHRqYv9Fm3H9wOopQmXko9334WLxV4dCf/gTDRKWDx30vmttL7tH
	PUfNrcDwpzvwos+dzLdH5Y/k2lQQ8NRalux4jZ2FNophSpL1DJAeVOVrhFap3GtpCIcNXaNKdpG
	YckzobVkYu/f8BYJG4Ld3mK7UhoB1mwMA0u4G2CEGH+M2D89hQ35+QKrQuvWFaqT0wc42cX/oya
	H2rAAyTKV4=
X-Gm-Gg: AY/fxX4nm5lTUGTsL1A3yBSq1H4mPcaXE0LjfYNBNVzXptgr4uqQqOIdNZgNSxnc3O1
	+suOfWsyCr9CjrDBNArqJE2TQrv4Z/qLJMifepdzr9GNYS1dVYsPjnXHZM2xsd3G1VaUnYcDpHZ
	TYiGmTALAc1SyzY4zzZpSI56lrRzXUn5n4VZiLWUExWI36wwB9uJy9MFddRa63knvFMXtAbn8mT
	fR7z/cgZmCDlgWQduBma9yv49lbX36PQj3EO3UlRKevhnNfHxV4gGEYOsswqYug3+CS2f2cceS9
	jFbjz0CnuXZu+N2V2iSEc+UDtA8bQgzrtiK8YlBhsWMwVjOPaFKkFXMAvOnezi6FQuBq4n8BAO2
	t/jYOHFJSVQmJh3d7YlAg/DistC49A71ItTacRttDBgo73mSht4CL52NQK2PATsgzO6rdm0dqKY
	lL9hl/tvtcs9i1lFOHOy4HBi9p6+8RLzd+3VDOTl873A==
X-Google-Smtp-Source: AGHT+IF3fRDHXR8yCOpKeiedLo2S076jYSnKlXfFJb/Fu7FBg12CKr31LwyW4yky+tRE7G9vXayfoDOjg995
X-Received: by 2002:a17:902:ce84:b0:2a0:909a:1535 with SMTP id d9443c01a7336-2a3e2cae061mr31825435ad.11.1767717661897;
        Tue, 06 Jan 2026 08:41:01 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-1.dlp.protect.broadcom.com. [144.49.247.1])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a3e3cc4cb7sm2944595ad.51.2026.01.06.08.41.01
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jan 2026 08:41:01 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a09845b7faso16050315ad.3
        for <stable@vger.kernel.org>; Tue, 06 Jan 2026 08:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767717660; x=1768322460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1bCSbgV2Htb2ev3Z0vxXE9M501a8TzHgRq+yEArjcpY=;
        b=H/8AgGyHjS/JFbZ97lUF5xq7DT1KtZVvjGU2FWXU/IHqve/dCry+uXms6wECEpo9WN
         R7tE54Rndk5itKtQjdCgbeA63ZMY8w28OHLhfmwgFRMbPRxMRnfUtJAjh81b8Q+p+Apj
         3wU5oqdVvUdT6NMDe000VWr+euRJ5vS23Gi5g=
X-Forwarded-Encrypted: i=1; AJvYcCVf1rm4J85B4Wcx2ba6oxVoL9e6nrgz8RjtvAO15XSzaNXKhb79cGglP+qmVzKumaIfrGrom/s=@vger.kernel.org
X-Received: by 2002:a17:902:eb8b:b0:29e:9e97:ca70 with SMTP id d9443c01a7336-2a3e2cce21cmr32265585ad.25.1767717660301;
        Tue, 06 Jan 2026 08:41:00 -0800 (PST)
X-Received: by 2002:a17:902:eb8b:b0:29e:9e97:ca70 with SMTP id
 d9443c01a7336-2a3e2cce21cmr32265415ad.25.1767717659928; Tue, 06 Jan 2026
 08:40:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106-bnxt-v3-1-71f37e11446a@debian.org>
In-Reply-To: <20260106-bnxt-v3-1-71f37e11446a@debian.org>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Tue, 6 Jan 2026 22:10:47 +0530
X-Gm-Features: AQt7F2qIjVSFmMfnnBdtTvY1qN3sCke7ouWEZOHPzpPp15NFsglEpm6gp7mhJU8
Message-ID: <CALs4sv2aZUs097NXxNDyy7xJbdurPzFbODeFX5dJ=GBO5s3+Ew@mail.gmail.com>
Subject: Re: [PATCH net v3] bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
 during error cleanup
To: Breno Leitao <leitao@debian.org>
Cc: Michael Chan <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003a1c810647bad757"

--0000000000003a1c810647bad757
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 8:01=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> When bnxt_init_one() fails during initialization (e.g.,
> bnxt_init_int_mode returns -ENODEV), the error path calls
> bnxt_free_hwrm_resources() which destroys the DMA pool and sets
> bp->hwrm_dma_pool to NULL. Subsequently, bnxt_ptp_clear() is called,
> which invokes ptp_clock_unregister().
>
> Since commit a60fc3294a37 ("ptp: rework ptp_clock_unregister() to
> disable events"), ptp_clock_unregister() now calls
> ptp_disable_all_events(), which in turn invokes the driver's .enable()
> callback (bnxt_ptp_enable()) to disable PTP events before completing the
> unregistration.
>
> bnxt_ptp_enable() attempts to send HWRM commands via bnxt_ptp_cfg_pin()
> and bnxt_ptp_cfg_event(), both of which call hwrm_req_init(). This
> function tries to allocate from bp->hwrm_dma_pool, causing a NULL
> pointer dereference:
>
>   bnxt_en 0000:01:00.0 (unnamed net_device) (uninitialized): bnxt_init_in=
t_mode err: ffffffed
>   KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
>   Call Trace:
>    __hwrm_req_init (drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c:72)
>    bnxt_ptp_enable (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:323 dri=
vers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:517)
>    ptp_disable_all_events (drivers/ptp/ptp_chardev.c:66)
>    ptp_clock_unregister (drivers/ptp/ptp_clock.c:518)
>    bnxt_ptp_clear (drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c:1134)
>    bnxt_init_one (drivers/net/ethernet/broadcom/bnxt/bnxt.c:16889)
>
> Lines are against commit f8f9c1f4d0c7 ("Linux 6.19-rc3")
>
> Fix this by clearing and unregistering ptp (bnxt_ptp_clear()) before
> freeing HWRM resources.
>
> Suggested-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: a60fc3294a37 ("ptp: rework ptp_clock_unregister() to disable event=
s")
> Cc: stable@vger.kernel.org
> ---
> Changes in v3:
> - Moved bp->ptp_cfg to be closer to the kfree(). (Pavan/Jakub)
> - Link to v2: https://patch.msgid.link/20260105-bnxt-v2-1-9ac69edef726@de=
bian.org
>
> Changes in v2:
> - Instead of checking for HWRM resources in bnxt_ptp_enable(), call it
>   when HWRM resources are availble (Pavan Chebbi)
> - Link to v1: https://patch.msgid.link/20251231-bnxt-v1-1-8f9cde6698b4@de=
bian.org
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethe=
rnet/broadcom/bnxt/bnxt.c
> index d160e54ac121..8419d1eb4035 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -16891,12 +16891,12 @@ static int bnxt_init_one(struct pci_dev *pdev, =
const struct pci_device_id *ent)
>
>  init_err_pci_clean:
>         bnxt_hwrm_func_drv_unrgtr(bp);
> -       bnxt_free_hwrm_resources(bp);
> -       bnxt_hwmon_uninit(bp);
> -       bnxt_ethtool_free(bp);
>         bnxt_ptp_clear(bp);
>         kfree(bp->ptp_cfg);
>         bp->ptp_cfg =3D NULL;
> +       bnxt_free_hwrm_resources(bp);
> +       bnxt_hwmon_uninit(bp);
> +       bnxt_ethtool_free(bp);
>         kfree(bp->fw_health);
>         bp->fw_health =3D NULL;
>         bnxt_cleanup_pci(bp);
>
> ---
> base-commit: e146b276a817807b8f4a94b5781bf80c6c00601b
> change-id: 20251231-bnxt-c54d317d8bfe
>
> Best regards,
> --
> Breno Leitao <leitao@debian.org>
>

Thanks, Breno!
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--0000000000003a1c810647bad757
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
/HTPxpDrr4vzZL0yoc9XefyCbdiwfyFl99oBekp+1ZxXc5bZsVhRPVyEWFtCys66nqu5cU2GPT3a
ySQEHOtIKyGGgzMVvitOzO2suQkoMvu/swsftfgCY/PObdlBZhv0BD97+WwR6CQJh/YEuDDEHYCy
NDeiVtF3/jwT04bHB7lR9n+AiCSLr9wlgBHGdBFIOmT/XMX3K8fuMMGLq9PpGQEMvYa9QTkE9+zc
MddiNNh1xtCTG0+kC7KIttdXTnffisXKsX44B8ECAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUxJ6fps/yOGneJRYDWUKPuLPk
miYwDQYJKoZIhvcNAQELBQADggIBAI2j2qBMKYV8SLK1ysjOOS54Lpm3geezjBYrWor/BAKGP7kT
QN61VWg3QlZqiX21KLNeBWzJH7r+zWiS8ykHApTnBlTjfNGF8ihZz7GkpBTa3xDW5rT/oLfyVQ5k
Wr2OZ268FfZPyAgHYnrfhmojupPS4c7bT9fQyep3P0sAm6TQxmhLDh/HcsloIn7w1QywGRyesbRw
CFkRbTnhhTS9Tz3pYs5kHbphHY5oF3HNdKgFPrfpF9ei6dL4LlwvQgNlRB6PhdUBL80CJ0UlY2Oz
jIAKPusiSluFH+NvwqsI8VuId34ug+B5VOM2dWXR/jY0as0Va5Fpjpn1G+jG2pzr1FQu2OHR5GAh
6Uw50Yh3H77mYK67fCzQVcHrl0qdOLSZVsz/T3qjRGjAZlIDyFRjewxLNunJl/TGtu1jk1ij7Uzh
PtF4nfZaVnWJowp/gE+Hr21BXA1nj+wBINHA0eufDHd/Y0/MLK+++i3gPTermGBIfadXUj8NGCGe
eIj4fd2b29HwMCvfX78QR4JQM9dkDoD1ZFClV17bxRPtxhwEU8DzzcGlLfKJhj8IxkLoww9hqNul
Md+LwA5kUTLPBBl9irP7Rn3jfftdK1MgrNyomyZUZSI1pisbv0Zn/ru3KD3QZLE17esvHAqCfXAZ
a2vE+o+ZbomB5XkihtQpb/DYrfjAMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMClwVCDIzIfrgd31IMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCB3EZB5
wYgm8PLTNVllrSsxID9sUoCbXnyBWoquuQ9KrzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAxMDYxNjQxMDBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBIN2G3/azDb+1GwA1pCK71+e/ypvCjxO3342YdnyTR
Cax5/x7aA/wIFRQ1UdnEN+O5fPpSd5rY9yn79jmGOmX+06Ka+aDJ3/G8cXopMe44kXlWm1ugwzQy
iF4X1s824T/h8NdFfJxsI+jfhFbr+NfXnrED0IYbtlHkszUWQ1cmWnLRBatUWWCoOHYRcdrFck66
jsu7ZqG/SdqetaaOoYfFm9snDsAoV9cVkFSiMevjvNgqUVuXWLwiM7jX6TDnQEfIbYP+1EvD6C41
krnjcgrrh46JkQjHT23iaOR8pk/N4xdKzYelPsR5brRHuB9NTOu+jYxXKcNO0mP31CpAPu8B
--0000000000003a1c810647bad757--

