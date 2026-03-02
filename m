Return-Path: <stable+bounces-222618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCf5AlGkpWngCwAAu9opvQ
	(envelope-from <stable+bounces-222618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:53:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 416461DB344
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 15:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8AE73019E0C
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 14:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0BB4014A5;
	Mon,  2 Mar 2026 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nUpyE3X7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V+Jf0ztr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C67401491
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462719; cv=pass; b=DWYDRtZ8shjC/KQhpHQ0kDoi7Wmt7vNkUe3E9oghwzhFa4q+ya6QQTEfZ2XIOKbhWDd8jp0WqBvkLANMIahjbJfbYSVAE4ySeRLUXmZQQLlw7HkQBpuIrC9L11xuumJFLXotx0iH+zxKHFH2dGoTA1PncQ3iaIKM+Mr1X+dNlv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462719; c=relaxed/simple;
	bh=hMGFPbgcy/TDy785SFcklcPbDYptUIGhTow4s756vO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmPdK/30b6wPqXIYrqlBT32SPqzqrVaRWjeMcCkBYVPn/Z4I/AYcwNbrkJsL/6qIX+NqeqxGLMIK6ZBi15q1IZrJLgWXNpK77n4x5cWw/fSVip48cekOF2vG4KG+xOfPqyTnxLKMMen0iODRm/n/fRyzJFvncUAam9dAnoGaGJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nUpyE3X7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V+Jf0ztr; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229JYtX3741939
	for <stable@vger.kernel.org>; Mon, 2 Mar 2026 14:45:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r8WwZvM7F0v0xEHh0vy84aspSZXuF+1K2PAn1h9/oWc=; b=nUpyE3X7u+6y/0JT
	NVH/iPuT7cBuBVhVQSQkhyxSohal/Tu5MmTgSUobzaBnEbRx2QQlpsg5B69VMwJE
	B7xdcbkEOnd2Rq6BYO+p70sJCeibJ+Gv0veeDElUqJcbAhab1XRGGAb8nKWmpY7z
	bUFC9AYyZ/CZnmWyCtFiOSGjmgPg6n1LmLIwCantWjI9qCRuJ8si7IrsVTxtJO97
	m0TVVQnmPvQsmAmPmRUTRjMWpe1WkacbI2rKD3cLdV+RHq5h9kYJP8TgGh1ZLVNm
	iupqrOwMZuqZ08iamhD4fMRY28rdTi6s4NeJdNjXMA6U5V2QWolFQdwCDlaJLRuq
	dxSv0w==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7trh2ct-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Mar 2026 14:45:17 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-89463017976so433005936d6.2
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 06:45:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772462717; cv=none;
        d=google.com; s=arc-20240605;
        b=IN+Qj6sFWCrFPXCeCIfUELXLq0dkpJjkJPV0bK6uHZ6jzEDSeSvcESHunrsU9Lqa7i
         cO5kJ1cDqrakMDEY+/ZVXcqfrTGi9JF3v4bWZ6ghuHSCPtX6eOVhAaPkXjjWrxayAjiK
         OryvX3zx08D0l0x3q8eGIwSaaMC9by0tC27cwG1MBJam2AIO8VEMvSYesEzdoypR03F2
         jGuHMfEsaHRdWBDKii9OVlSTJIXxgT54fRT2AIWjz+BiRpcxIUno1/qVVWZwlI3ZVpJe
         RQp58zQHIOkOut4sVevycdYtRWNZB/LMI0ZX/73yC0nr2h7YcMgfVTr+dKrBkAKJbz0q
         zcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=r8WwZvM7F0v0xEHh0vy84aspSZXuF+1K2PAn1h9/oWc=;
        fh=AuhhzXvVaX2o+8rNXkpJDt7DG8l5g1zgKLXCT6UOhqw=;
        b=l1DyJSwpXYB/2c2eV8xDBlVk4Phlop7aZmof0vAL371sNJmrRi4I221w6lCVX0qexB
         oMQEnweFkOSDEmMPzzzh2AWQa39JUETPLrYyKGmff1vrNrcXTW1Dc1yXExhgMercBkmU
         8J+4vgnCU2E7AJijEHdIUMM4fAEMwFS6UxGmL6wLCEZ0CPQngUvLB1vFB7C+K5cBMltw
         MpJkJLU2k65uO7p7vkFOKcE2RQ0r0QUn0cjzl5LnOkHnCDUkD/DtqRKMMDY15viiZ+Xq
         EJg7jnjhIF+P6xNrWyNQnNTILHB8zunVAWLf9/P13wQZeZ2ZCCPvXlfbrRdOXpI0rqff
         xV3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772462717; x=1773067517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8WwZvM7F0v0xEHh0vy84aspSZXuF+1K2PAn1h9/oWc=;
        b=V+Jf0ztrw3WdOUaCcR+FP1R9xV6+WKrTpnhNTIcgyWlX2Mme1uIgOAW85Wz6ArVPJj
         mCmFmpc9otUuPVsqapILKzXCWpfHKLbHxUyT/eOPr8YFd71T36QxLEQ4HW/FKzLJcKOU
         6KMR4b1mAiQ8It9vhg4qKK+h8T3F3mtiurWY64IURHOylo7y+mqLMyzVD82RByXF7lsK
         JRxjC/dI9nXx4qSqnEjh4/jPkf3wsFa0eD/uIEISBZ7a8kqOKM6QygxnY7mrli/ZWoCp
         51NKpfTq4v9C3JlWktWPhhLI6bPqfugnprdCscnHY78FvdSDdiCH3XEIeqHqlksxuR2x
         QQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772462717; x=1773067517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r8WwZvM7F0v0xEHh0vy84aspSZXuF+1K2PAn1h9/oWc=;
        b=Vte54TmO72wjhIvtzzT/CHQilvLj+yGsISvShzbn6KqRc1RFAN5JCovC/XnuqPntLM
         dVkjofYmEMXnV46hMOZF7Qd2yt6bFggWThqFcqgOrEkjR55IW0nx50U7Aa3pBSaoiKqj
         snmba/TKcUotP/MA4sgFw2n9KjgQva3v2MU51hFBuKHRu0I27g8LjP8eDf0ZVYN7Wh7I
         iJ2kZc3hoOS8I+JgNIpcVdQXa7fSFVItS2pa450PyCpQSRlfC6mqhoYb1qy2OLTY3awU
         5CxJuwCdsyLv+Ycf5Uhil34LwRFJxLM+l4yAs6yKiBygpPuqncpo/Y472UxEHWQ9NRhQ
         imgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHL1nOSszIeFntOD81BZEXn3L2JBR/EHhdpJDDY2HbZZCYTCuGnjjHhZ+WyMSlZztpapW7tY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFST7Y2q/ckuuneZvWqBHKHNvCXWvSc2WeiXv2y9RZBfS0Gd0k
	VKY/Eiz57gsDssm3PvedPglv+f2z9NFN7Y0PIe4GF3K40wlU1Z8Dz+Qt6q05LmfrSa/3TCnr7Sj
	xF9wLXR7fhNJafTmUhUC8w7MRwCKo9hmMNI0NWoryIPBKyVnotvSmAiw0uIE4Lpg15eYNG2hw6E
	ZBIdxKjq7gzZ7iWIYlFAnRcJ4f6LwtGOqmtA==
X-Gm-Gg: ATEYQzwq+Z1HAYaHm3Gj/sRCoShqsx/Pmy9rvQ/Lonukkvcyum2okpQ4eGelLU30H83
	ANMobS4/FJFFe1Kp+HdMZJbzOD6lC09Nl/3lfw5VwByOBgSHCsMiPvY4t2tUMTJWw+erjoZg/Ka
	j2bYeUbXJWUj1fONj23JyO49pq3dvqL9biwxHlJ9BWLh/ncI19Pe9Lo6/faShe2lUq7NnFrcB2m
	vMB5KKeDebhhJT05beKICsgKaQnaRmBGDaSenpB
X-Received: by 2002:a05:6214:21c6:b0:896:a693:743a with SMTP id 6a1803df08f44-899d1da886fmr198072996d6.5.1772462716657;
        Mon, 02 Mar 2026 06:45:16 -0800 (PST)
X-Received: by 2002:a05:6214:21c6:b0:896:a693:743a with SMTP id
 6a1803df08f44-899d1da886fmr198071806d6.5.1772462715780; Mon, 02 Mar 2026
 06:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302134116.18960-1-manivannan.sadhasivam@oss.qualcomm.com>
In-Reply-To: <20260302134116.18960-1-manivannan.sadhasivam@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 2 Mar 2026 15:45:04 +0100
X-Gm-Features: AaiRm52g_q-9ut5YRuzPfVjc9YOUMUhXK_-usBrh4QiYg5o-Hkom2vB8v_yqFfY
Message-ID: <CAFEp6-3iU6XEcwqkX4erAEPpgFubWMoihQy1DFyKmLtFOM_uvA@mail.gmail.com>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Resume the device before
 executing mhi_pci_remove()
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: mani@kernel.org, qiang.yu@oss.qualcomm.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEyNCBTYWx0ZWRfX6sJY/3i6fGDI
 TJgqTAhZddO/yVblqBv1476lheMpo1SlPAMyvSATnNBvlch1FN03wDi/vDsnsz2hWHrUrUOFBXa
 PcXUmm+3LWaTVBYcpZHD6CRtiVLEtI3NS8srmaFuJLXgXKMxmzU9kjX4raPGmfX5cpyuNnddZ+h
 yxiWcxnAW9q90kpoAYDy0o4XH7NfDKgjqLL2rp1jiO/ztCwbwGDZ8GhYRyQ7C5nmNDW3VhiaIGK
 0TXTrZNgBsENDLDtMocKJRQZ2rjkg4rN1XDCzBVbhIqakVRCkFROc0ZryMMBtURkdHbAZppblGg
 v46sQsN6TYQKBELm5nwR5yQ0ZlvIqmbOGf2yaHglrqYHPvK8Bz5/sKbpHUjbjlype1pU8LD1M6D
 V/SvtHTPwsNwFrkkpp/Vj1llfJEDeYcfLECNkm9AkQcpdAWnvtjFj2VDZ4UvqhSebEnFdeGoald
 mo3ec7OnUUxF6jFhMvw==
X-Authority-Analysis: v=2.4 cv=TNhIilla c=1 sm=1 tr=0 ts=69a5a27d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=o1KvY5UHcyvAiU2fnK8A:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: TPXo54j0BxfqZVkKhjGH-UhF6fvu6mUX
X-Proofpoint-GUID: TPXo54j0BxfqZVkKhjGH-UhF6fvu6mUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603020124
X-Rspamd-Queue-Id: 416461DB344
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222618-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,qualcomm.com:dkim,qualcomm.com:email]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 2:41=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> wrote:
>
> mhi_pci_remove() carries out device specific operations that requires the
> device to be active. But pm_runtime_get_noresume() called at the end of t=
he
> remove() will not guarantee that.
>
> So use pm_runtime_get_sync() and call it at the start of remove().
>
> Cc: <stable@vger.kernel.org> # 5.13
> Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

> ---
>  drivers/bus/mhi/host/pci_generic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pc=
i_generic.c
> index 425362037830..fe3aefa15966 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -1440,6 +1440,10 @@ static void mhi_pci_remove(struct pci_dev *pdev)
>         struct mhi_pci_device *mhi_pdev =3D pci_get_drvdata(pdev);
>         struct mhi_controller *mhi_cntrl =3D &mhi_pdev->mhi_cntrl;
>
> +       /* balancing probe put_noidle */
> +       if (pci_pme_capable(pdev, PCI_D3hot))
> +               pm_runtime_get_sync(&pdev->dev);
> +
>         pci_disable_sriov(pdev);
>
>         if (pdev->is_physfn)
> @@ -1451,10 +1455,6 @@ static void mhi_pci_remove(struct pci_dev *pdev)
>                 mhi_unprepare_after_power_down(mhi_cntrl);
>         }
>
> -       /* balancing probe put_noidle */
> -       if (pci_pme_capable(pdev, PCI_D3hot))
> -               pm_runtime_get_noresume(&pdev->dev);
> -
>         if (mhi_pdev->reset_on_remove)
>                 mhi_soc_reset(mhi_cntrl);
>
> --
> 2.51.0
>

