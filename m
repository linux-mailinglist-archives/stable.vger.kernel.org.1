Return-Path: <stable+bounces-237768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMiSEKAH3mlRmQkAu9opvQ
	(envelope-from <stable+bounces-237768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:23:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 916AC3F7D74
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 11:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CADF3045211
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 09:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078538B7A6;
	Tue, 14 Apr 2026 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BR99RwhU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D3B3939BA
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158409; cv=pass; b=NV0R1Wr/rVytlTqmU8AnricPL3O2/Az+mbnvazDqjKmg3IWO1WKvON/rgJAgiB7sxyIAqKYzmegHieTo4V5vd+u2uB+6w8F4dqi29+WUOMpzzJfubH7KyTVYN4xkbbEclzTTQlcX+MPF+BhoebNoaRXVeGOMIF8NMQjVK67XQIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158409; c=relaxed/simple;
	bh=4UeRTk6XVFXxaP2oyTPR7G5egkYbQ0KeVNxRT8gj6Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNlaNq49eIE68EK3+EghQypLqnqQegKOVsgRfe0r0d44gahllF4zHqsrJfZQ69Q/9QJijWpaprXYj8YIausXCGrc6Z34CQBtcaR4GTWa2oW4fzvOWetFz9wyjzOXQxptTNC6gddh08vGpOqU0XOa+G4SWr7ndbHYIkbiGRHbO2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BR99RwhU; arc=pass smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso61137836d6.3
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 02:20:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158407; x=1776763207;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gT32oF8VxQ0HnBiYZp5tQOFAr0rlIKOVU7Lh+cuOwGI=;
        b=UebhuGCN1LAGvq6iTmedd6z+mHcqp4lZuzVHz87a297nm1ri+mCWCQBSu4ucPGGBPR
         EDVtIMuPWp8Jj8bxh4w78tiGZTl8BTKddu3S/gzNYu7WD6kf8+yiIpBegpLLZwd340X1
         bGCJ/vtTb6aE3P1j/y2R0rGo9m6ZDPC4ZhD5cXa8polmF8NOWGJWebKJzPNfkamkttrJ
         MVk5ohLR/GL+KE81IRQhzPb3mTWbhLZ3LspL0eVaauVDQFxMF9aoCL89YaUza4XuJsPJ
         wFvf0HTbcVfZRItJ5xD/bp9YIwgoOS0YxF1kJ/ytPQ81kd/8ECqkOlZQarnNUVWuk8AI
         mB0w==
X-Forwarded-Encrypted: i=2; AFNElJ9Kr27Nu7Zx3szWyStjM6ebQ8GMQgRgZ/OPsFDwSRVkGYy/lfG6rKAgwAcTKl/u6bZlrbseBmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsEJGVZZGkztvcbG9m85oJ0nFvjMzObjjhwyIHt+xbTshd9chJ
	T3FnPG0KG5JpmVLGAML7nN99znQdWb7GjnBcpBsFwvT/foDrNs5e/9jjRH+xxTkFT2zmuaXkriY
	lFDhPZg9AZOjCIIgGOG7hoRpWVX5XTp9AuXxtDfcs3zTTduXkZWwhIXXZOZIpmFo3F3o7MicrlJ
	gE/apuDPJxx2X/K/yvuRXnFVUxRevhORYCRiHQ/7fzM3Y6ZJ/2SWPQwGrdrqpIeGUX8tK/8iAY5
	Hs4rgSffJU=
X-Gm-Gg: AeBDieu+zAc+nv9UTu/BARFioudknKSVswZPUzWPa4FmQF5KVSx6sMvVmFLBneirqGL
	rwYcSz+OEW+qKMSRwYLPBTL6jUoCSAZNLpVDCUPSAkIsBV/wbcz9v9OK2G/jHcA1rQ02HOuMApe
	Id/ecaFD6POzG4EQgMun/XObFQCrUUBBvf1mMxYqex8t/ldH1oFC1zCe+l/S3mpOFI0xyM5hn2w
	MmGKj7+wcZB1rzBVT/teVDQ0zxHNmsTvnFXFNs7ky/a++Ft/k6LTIat129pNPtPptMiXjI+PnX5
	ei62iKjKxBo14PhUDcM0mcZ45Ul60qqN2za3HhDtPBPA1wSLstaN7mAWiDz795A/KLgJZqsvFAg
	B3wpFrTkZbGVjVXegwHjHeI4r90TZuFqDD4HtF17KAz+mBQRYOM44SO5B68l68cHNv0JBOLz7A1
	Xu1vLPGmpvwoAwYa5jRjgvSsfDDN/qvcpHCOVFq+xi3yoMvqlD6/Jbw14G
X-Received: by 2002:a05:6214:3016:b0:8ac:ae21:462 with SMTP id 6a1803df08f44-8acae211074mr109494306d6.27.1776158406965;
        Tue, 14 Apr 2026 02:20:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ac84c63561sm9632236d6.16.2026.04.14.02.20.06
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:20:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b9deeec7fafso138300666b.2
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 02:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776158405; cv=none;
        d=google.com; s=arc-20240605;
        b=BsH7DPiSo9eOYAgx6keXwuS0EiaspnnfBnkrgrhu8RMja1cuf2DiIOdoDmFEmiQkm5
         zzn0zAP1NM7Qg7SmAgucGFdqrtgjoHh1JGcJR/3SOl5TFR4d4WEkKUgw2Zcp5R/rPCDZ
         oGI8Q2+qmXqYdEm+qsJqXArgv6DJmTN/Ec6tGJFRABJrG/dFj/9M/PWpdSP5XqfxCoeL
         qf2U0/9fVIjAZH2XNuc54y5qoD359MYtiRsSvDPE5JJYSPps6BsL4LOFa4DYZ+4GMBD5
         btAEWzT/lAsr376YibXzEUnb55CaHFJddRmEozK2D/uTOTehB0uQPhzib4LBiO8W+zvx
         0lGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gT32oF8VxQ0HnBiYZp5tQOFAr0rlIKOVU7Lh+cuOwGI=;
        fh=aPLfixK5wydDyECNuzhDsmJjIuFLd1BIEMWCdc4cEXU=;
        b=iQZER3S4h/Q/K2LzRBhCnZZSuCGH6/B2mJVi9Y/xiIvn0gvlTzykyjviq84r18rG3w
         arxc/QW4HsK0UZdQ+v6WACL35bQMYVVUsYSPNvTB3rEAN0srxo5zvUyOEiuF4FJETWO6
         uhJj94sEB9+SFf+GFD4V+7Afd+rtWGigJTvVemOmvsvehAryo+VofJCekyEXipopBUyA
         Uq7vfoaIe6Y9MGdEAwWkFEDz5DI/RDTzNk+ukRNh3h70H3Oz9DXnWOY4a2gyT4q/Hr1K
         FYfujVXmD+guloSrXApKWWMPqrXljpRHdNxlzVByc9renxyQAzecWmqj6Gxgc0Aom4qK
         aFpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776158405; x=1776763205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gT32oF8VxQ0HnBiYZp5tQOFAr0rlIKOVU7Lh+cuOwGI=;
        b=BR99RwhUU4dyGo6iCCQ5dA05HprvMKbF4q2pxIfYmja5BIxu3wXXj6kg2KnbuIUUkl
         j/Z74b+5h5zdfV71LChujv+UMq82tW4FfKQHD26MNMLHoAXAT/sGhui7wUT9caxGLpHs
         iLX1UZnxRIo3CWuMMcNjMMj5oEyqgIWeIkgbk=
X-Forwarded-Encrypted: i=1; AFNElJ+PoomQlEvxkkRJlzCiy9GDtrTREX/Os2ujyV6x9HI6W22fDTAIOr5IDdsx4OmMk5t0PLdshIQ=@vger.kernel.org
X-Received: by 2002:a17:907:8b8a:b0:b9c:c5a2:c82c with SMTP id a640c23a62f3a-b9d7267eedamr997548766b.40.1776158405073;
        Tue, 14 Apr 2026 02:20:05 -0700 (PDT)
X-Received: by 2002:a17:907:8b8a:b0:b9c:c5a2:c82c with SMTP id
 a640c23a62f3a-b9d7267eedamr997546066b.40.1776158404288; Tue, 14 Apr 2026
 02:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413180003.76489-1-ranjan.kumar@broadcom.com>
 <20260413213335.4010d8f2@pumpkin> <5ecd8d50-d7dc-43a3-b157-8717c6fc02d4@kernel.org>
 <20260414081210.2b63e350@pumpkin> <a7101526-3b23-4474-afc8-bd39e7e3646f@kernel.org>
In-Reply-To: <a7101526-3b23-4474-afc8-bd39e7e3646f@kernel.org>
From: Ranjan Kumar <ranjan.kumar@broadcom.com>
Date: Tue, 14 Apr 2026 14:49:48 +0530
X-Gm-Features: AQROBzDsPVEBLUcXgLkxLJNBeXQCV_8Vydhz7BNt8ge18DBwz0C0MP31y-mYtBY
Message-ID: <CAMFBP8O9oxBiYVHChBjdAQpca3P6wU=jSMHGexxKYXYPHQGL8A@mail.gmail.com>
Subject: Re: [PATCH v3] mpt3sas: Limit NVMe request size to 2 MiB
To: Damien Le Moal <dlemoal@kernel.org>, David Laight <david.laight.linux@gmail.com>
Cc: linux-scsi@vger.kernel.org, martin.petersen@oracle.com, 
	sathya.prakash@broadcom.com, chandrakanth.patil@broadcom.com, 
	stable@vger.kernel.org, Mira Limbeck <m.limbeck@proxmox.com>, 
	Keith Busch <kbusch@kernel.org>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d55f35064f681afb"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237768-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ranjan.kumar@broadcom.com,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 916AC3F7D74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000d55f35064f681afb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Damien and David,
Thanks for the suggestions.


On Tue, Apr 14, 2026 at 12:51=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org=
> wrote:
>
> On 4/14/26 09:12, David Laight wrote:
> > On Tue, 14 Apr 2026 05:41:59 +0200
> > Damien Le Moal <dlemoal@kernel.org> wrote:
> >
> >> On 2026/04/13 22:33, David Laight wrote:
> >>> On Mon, 13 Apr 2026 23:30:03 +0530
> >>> Ranjan Kumar <ranjan.kumar@broadcom.com> wrote:
> >>>
> >>>> The HBA firmware reports NVMe MDTS values based on the underlying dr=
ive
> >>>> capability. However, due to the 4K PRP page size and a limit of
> >>>> 512 entries, the driver supports a maximum I/O transfer size of 2 Mi=
B.
> >>>>
> >>>> Limit max_hw_sectors to the smaller of the reported MDTS and the
> >>>> 2 MiB driver limit to prevent issuing oversized I/O that may lead
> >>>> to a kernel oops.
> >>>>
> >>>> Cc: stable@vger.kernel.org
> >>>> Fixes: 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP")
> >>>> Reported-by: Mira Limbeck <m.limbeck@proxmox.com>
> >>>> Closes: https://lore.kernel.org/r/291f78bf-4b4a-40dd-867d-053b36c564=
b3@proxmox.com
> >>>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git/commit/?id=3D9b8b84879d4a
> >>>> Suggested-by: Keith Busch <kbusch@kernel.org>
> >>>> Signed-off-by: Ranjan Kumar <ranjan.kumar@broadcom.com>
> >>>> ---
> >>>>  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 14 +++++++++++++-
> >>>>  1 file changed, 13 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt=
3sas/mpt3sas_scsih.c
> >>>> index 6ff788557294..44dd439e6f17 100644
> >>>> --- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> >>>> +++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
> >>>> @@ -2738,8 +2738,20 @@ scsih_sdev_configure(struct scsi_device *sdev=
, struct queue_limits *lim)
> >>>>                            pcie_device->enclosure_level,
> >>>>                            pcie_device->connector_name);
> >>>>
> >>>> +          /*
> >>>> +           * The HBA firmware passes the NVMe drive's MDTS
> >>>> +           * (Maximum Data Transfer Size) up to the driver. However=
,
> >>>> +           * the driver hardcodes a 4K page size for the PRP list,
> >>>                                              ^ buffer ?
>>>> I will change page size to "buffer size" .
> >>>> +           * accommodating at most 512 entries. This strictly limit=
s
> >>>> +           * the maximum supported NVMe I/O transfer to 2 MiB.
> >>>
> >>> Doesn't that make max_fw_entries 4096/8.
> >>
> >> What is max_fw_entries ?
> >
> > A mistype for max_hw_sectors :-(
> >
> >> What the above explains is that a single NVMe page (4K) can store 512 =
(4096/8)
> >> PRP entries, each pointing at a 4K nvme page, so 512*4096=3D2M maximum=
 size.
> >>
> >>> Assuming 4096 byte sectors the longest transfer is then 4096/8*4096.
> >>
> >> Yes, that's the SZ_2M Bytes.
> >
> > So write it as (4096/8)*4096
>
> See below.
>
> >>> So none of this has anything to to with SECTOR_SHIFT.
> >>
> >> Apparently, nvme_mdts is in bytes, even though the documentation in
> >> mpt3sas_base.h does not mention anything about its unit. So yes, we ne=
ed a
> >> SECTOR_SHIFT to convert that to 512B sectors unit.
> >
> > It is all very confusing because of the 4k and 512 byte sectors and the=
re
> > being another 512 constant.
> > Perhaps the best expression is:
> >       (4096 /* NVMe page */ / 8) * (4096 /* hw sector size */ >> SECTOR=
_SIZE)
>
> Yes, we could, but I think the comment is clear enough, so I have no issu=
e with
> the code as it is. But I will not fight this though. I will let Martin & =
James
> decide.
>
> >>>> +           *
> >>>> +           * Cap max_hw_sectors to the smaller of the drive's repor=
ted
> >>>> +           * MDTS or the 2 MiB driver limit to prevent kernel oopse=
s.
> >>>> +           */
> >>>> +          lim->max_hw_sectors =3D SZ_2M >> SECTOR_SHIFT;
> >>>>            if (pcie_device->nvme_mdts)
> >>>> -                  lim->max_hw_sectors =3D pcie_device->nvme_mdts / =
512;
> >>>> +                  lim->max_hw_sectors =3D min_t(u32, lim->max_hw_se=
ctors,
> >>>> +                                  pcie_device->nvme_mdts >> SECTOR_=
SHIFT);
> >>>
> >>> Why min_t() ?
> >>
> >> max_hw_sectors is unsigned int and nvme_mdts is u32. Not sure if that =
bothers
> >> min(). Worth trying.
> >
> > It doesn't bother it (any more).
>
> OK. Let's drop the min_t() then and use min().
>> I will drop min_t() and will use min().
>> I'll include these updates in the v4 patch.
>
> --
> Damien Le Moal
> Western Digital Research

--000000000000d55f35064f681afb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVWQYJKoZIhvcNAQcCoIIVSjCCFUYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghLGMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGjzCCBHeg
AwIBAgIMDcMaKRu9LrbAxERoMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MTExMjEwNTEyN1oXDTI3MTExMzEwNTEyN1owgdcxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEOMAwGA1UEBBMFS3VtYXIxDzANBgNVBCoTBlJhbmphbjEWMBQGA1UEChMNQlJPQURDT00g
SU5DLjEiMCAGA1UEAwwZcmFuamFuLmt1bWFyQGJyb2FkY29tLmNvbTEoMCYGCSqGSIb3DQEJARYZ
cmFuamFuLmt1bWFyQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ANU1+gHSXTPOrlGv+UuunlNQN2KF2E+urHhOSMTNfJNlV8yamZrqBRa0885oOCCXL7UP9hG+1Zi1
zZSItX49nLoa4TBbzuCzoINrv59QeSCVlVdAYussUS3840ZjvcYHSQx3tqYcBN+an07lDASmGEM5
7PEXJPVInjl/Fva3ksL3r8anR4PWc3Xz5jLD8Xg6BU4zmIcR/t1GlqWuz8uTWmQtm40C9m91Q9a+
2alIIV6BTs8IG2ELtt4EfcVvi5af+Hu878sGeBtMx6Z9ljoKl3MfvDdtUNO4bkJ97a7PXy/CKxiy
TApQj4qg9SKQcsH0xzQan67XeXjkvk4frNDhRikCAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZcmFuamFuLmt1bWFyQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUfLdm66N7GfDsoL8cYp3s4YdO
isMwDQYJKoZIhvcNAQELBQADggIBAA/lnAxDb9jbesclnBxWIKUSxAMIrq4XKO5WKHUYIOOzd2sL
o59fH9AWg1AfVONfWIUNdWDrmNNLs0+drSKaZbGx2RWMbaL9ubo7+BTQV33ZRBxnnkmc9QszlOo5
m6FB9uPOGB9LvJMCkJ8S7hNc9G/p7dB79s1IKc8JGEDIrsgX3s4xSCJA20WdePHY5rLh5ySwXyI2
3sVTUC+oK0HJFRo+TpdMMtdpOetWzIkUbGceiOA2ur8372+0KOmvlIHA/jEnW3BRfmB2vmdk+raY
C/xbXY9JEfS6D881+X/90w+cCQ7nuA1OELebS1RbSdXT6YkRDPWYA/DPFhOYCAiMwVAPRaAH1AQc
8J8yTDigwRUCq4qKCYU9YnqQh3YZRbUYnW+i3+rAO2SUbKl0VM5y0tq+GOGLC7w+v6yGossZmy+6
3w72qp/Colr4r5ZaROb+L2FXqk4tL/HfkRhliyPPPNIjre2mIkvFuShk5A5FcvQYCzDtejAz9JHq
ZVJ1ZD+auQDbIUxT+Dn9bI5XkQnWJ9KrlcORtztdYTDafN8VQuweS3JY0X/VCNBNZkiYXd7fzOza
hvkw/S+v8cIfiakLKBREtiBHqWLdVf5CNDVYpd17yz0LGz0TKARbfuK/EiKflA10pnnnOB33Ru9D
WPp9aHW3szGYr3+H9AHS6IDwkIxyMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMDcMaKRu9LrbAxERoMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDho65j
BmL5iLCJLVxSGZhBcZ/V919noes6VWBSUu0oHTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjA0MTQwOTIwMDVaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQA6VDiGLeYEDonDyXmE5C55didHPs+GcwyruILPJTpK
I0KyO88gSMGphC2aQEGUW+baDnltdQ9OVF01/ROs1s5Kxdh4SQA704c68AhVox+dXprpYvJcwW76
MDvmsmM6AWCuJf4dpvAIjG48cveMnJng9cz5oV7SQkLG7u2s7mLpWZDxHvEX8ep77gc1jo4Qo48p
HM3Ecj8gA1qPpRqY6NfVkCdNvPHVxTgGqXOEl/fiGaYNxgRoZeu8A8tcJRY5QnNdl50qMnvAQchT
xLpeyMPCueUogPgYgDzyGbMCeo9ppdi6ZAqROZj07csCWnCAK+zxouVS12rDpOr4NzN2w9jR
--000000000000d55f35064f681afb--

