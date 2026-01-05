Return-Path: <stable+bounces-204864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A997ACF4F8A
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 18:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D07A30C2B4D
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 17:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EEE3376A9;
	Mon,  5 Jan 2026 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iJK2TIcE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W50QYJVP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58606337BA3
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 17:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633371; cv=none; b=Fs3OCIQHDTWIjdPQ+Tr8as4NakdvhOmE6bQdsJsZ7rCqHPNgMD3nC1mWJo4fWUcjduteN3vQnFxX7B0P0gRvhXYmD+9A+jwxBSYvTkiUimPco+Cmhzc4FUO58ZkZcgoClLbsXqxa9l3L2mld7AskC3ZsM/kb+NAhLB6jVT3jd4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633371; c=relaxed/simple;
	bh=hpKIOZ5A3Cxt7CeuAF9TvNrJ9+kmSTfm9eb1T3pjX2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9SmqV0zeG53lea6zJXq5PJwycgwhZmNZ0EH0rTIbeCkINctTBi6vafrPtgOT02TMlaHe1NIopSFjtCLIxOwR9tDnOt0GYSLzhYXHEoPGjwGoOcoYxPB2lfWIJjod6SxMu3M2NQiUfJG7Z+Rrar1akK7ZHVQBSmZPlF/tG3ik+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iJK2TIcE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W50QYJVP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6059vnkX3541351
	for <stable@vger.kernel.org>; Mon, 5 Jan 2026 17:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BP6Gu/c4u72ZuJtLgtoBCZcMdP8EzVQc6SErXMu+NVM=; b=iJK2TIcElu/UfXQV
	UvzgwnNdTKPmjV+ldOkt+wmncU7M/+LJK8zj7oxg0lQnKO9M3nVatd5QseCCMdlm
	v6Gf9MfKK1QWOptn1ZfV4OUGZGA2OawuLhP1qZo1TY9E493FDAbuSi8QlWI7eVFr
	0nd6Ie6hremkkOfX5HjfV8L80MUEVI2cu/4akS8xssybFVCiurZ2NnXhfUVhV4cs
	jEyavDC65WsZZdtzEGDX/Xw0oQcuXrHVEgEzUIu8UWAEdUn0jX7Y/Vmk7z5v3GXM
	6M1Nk/2oSjIfJIH2QVS+1xTieirzDgWkStxqNKs36epIh5mF/T4c2inJeobU0BMo
	Od8Z8Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg57sj94x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 05 Jan 2026 17:16:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a0a4b748a0so2087895ad.1
        for <stable@vger.kernel.org>; Mon, 05 Jan 2026 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767633364; x=1768238164; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BP6Gu/c4u72ZuJtLgtoBCZcMdP8EzVQc6SErXMu+NVM=;
        b=W50QYJVPZT5wKcjumeHMjxGGNSJN9WKF5hXHZc70dx5uYWFWrt0J1JQkWzEbkRuuKR
         3szlEgfCsSagHfFXnSRjMpjp21Gcu2ax2Zat82+lhYsS2Xbuwahp7cP2pSijBX++Yx8R
         3N3r5+lUo5sSHfd9pNPtFAasnYwacwwdoJ4Qs1gJVQltYKVdB9I+mRv7YAX0k/UYkkbm
         2+8Mn7Xkvpn5k5LybFqPDunTPTPobG+QIwk3M5edj+UdNgAVSmQcKOCRZtHTBwpcEKVC
         RydAnwZR7WH7sK6aOCd4enH6CBV6E7hvetrIGS0cwZ5VHwfi4GRqr679bLP4Nf+NqM4/
         QyRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767633364; x=1768238164;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BP6Gu/c4u72ZuJtLgtoBCZcMdP8EzVQc6SErXMu+NVM=;
        b=ctESd5hmcPHMSfu9rjqJOcxAVeTQuXzNiLzmVF8akrBOUGRfKrx7Xv+MyFEpCjpxnb
         VHTOwvagDe9XNGAdgvmN/JSR7SfmqbVN6WmrU337l5zZSgKwAJqdFlfvJePBJ4019cdw
         MZ0Pb6At2KbXmEJ1jbhcYj1G3WzMllbO9QZU0FrjdH+BX0Ix7osFsflwxMPP46M6qB6u
         a22orXsLez2J/XaDwPlqxKxXmbAe7hiB9FgC2O31+0ZWUZLT91SAonOxRQwSDmeMjCNF
         qfUw+Ub630JU2VnEEibT4eXhxYkcTR1Asx75jB/SzhO+oOSUY0MqfkIyMmkQzHhmBuwc
         40iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBhBJsKvx3RrVgZYsGqhw7DdcVZ8j0SLHCbVD/Wu/iD5Muo5EG1T6MtOwGDHRCYQLlpG/HdcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbFYsLDrdVx3OzgaFhm/0UAZt4OYPomdb89YGwxjdOJWvVkiek
	k0k3Opep/lPUaRBdynedhgelX5UK+2BIVpdrZbkWGDXA2mxDcd0sKE5W+R0hHpDzNJ8aLUroGN+
	UDzuH5l/X17XruVV1aBkjNrFhTbuuW3p286omFUSxXzMn/3DOdmnolN6szCg=
X-Gm-Gg: AY/fxX5cDmrcOf2/bmZOA7SGkXPEBtUOnaQdDl2m0h3Om7jEL+6PU9JMYXRKN8Ifr+e
	dO1UKN6iG0mPW65QpYT/tz2bSkLvVgQGdBWzaXYJ74nXi2ir4c6kwfLAHXgP8AHpWFq+bulIMjR
	Dyya45Z6URFSkbN6kIvu6NT+0r1WSk0Am6OU/NDR1oUUD/wuwgc2QulGIacNa4IOVHOsFMdPe3y
	40YInXdcfKWd7Mo78it0scyMBhGKLyUoCW/8DmfXXITHMs6qFAA96QuPTFN4/l4ShzU5Hz4unXa
	gxaF8gpKrDZOlHhLy/r39TG2vT5uq0+Ds4mxaczPZ33IrPM3DuAp3s3Y/hYHA5s47Dw4TUtAUeF
	yRF5oXmgPCgWwpSLSxbpmvnm6Kw==
X-Received: by 2002:a05:6a20:3c8e:b0:371:53a7:a4ba with SMTP id adf61e73a8af0-389822fca65mr45907637.30.1767633363783;
        Mon, 05 Jan 2026 09:16:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDb3ibB9yyf+XjsFBKFvP7NjPBf6cbuRzUcRVAfkOINXdA704jnRwHCauACbYKxkz5R4nWrA==
X-Received: by 2002:a05:6a20:3c8e:b0:371:53a7:a4ba with SMTP id adf61e73a8af0-389822fca65mr45883637.30.1767633363170;
        Mon, 05 Jan 2026 09:16:03 -0800 (PST)
Received: from work ([120.56.194.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4bfca6fbccsm199197a12.3.2026.01.05.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 09:16:02 -0800 (PST)
Date: Mon, 5 Jan 2026 22:45:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: Yue Wang <yue.wang@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Linnaea Lavia <linnaea-von-lavia@live.com>,
        FUKAUMI Naoki <naoki@radxa.com>,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        stable@vger.kernel.org, Ricardo Pardini <ricardo@pardini.net>
Subject: Re: [PATCH] PCI: meson: Remove meson_pcie_link_up() timeout,
 message, speed check
Message-ID: <2veit3krpnauq67smexshnknbahup4yuckjgd6bxqisfqswkqe@dbhcgpiaajga>
References: <20251103221930.1831376-1-helgaas@kernel.org>
 <176603796183.17581.9416209133990924154.b4-ty@kernel.org>
 <CAFBinCAPpiq=M00ZQXAB4Pu2Myjo8gpXC7DByKkGN6Z_Ahqafg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCAPpiq=M00ZQXAB4Pu2Myjo8gpXC7DByKkGN6Z_Ahqafg@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=UJ/Q3Sfy c=1 sm=1 tr=0 ts=695bf1d4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=3dEILRYKsVIWdVk4w2Qziw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6FUes5m74a-6EvCHSkUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE1MCBTYWx0ZWRfX33p/tSMG/1a5
 sXnvxqHwu29IuiPICuIvNA8ftE/OZIhQ9BGggMPsZzGBe+78H4EwB6QDbb7YG2aopwpJx2rMCbl
 E12GzoPd+2ogkIvVDvcUr0+yAKyqwSRfpNgx8/pflnEOs9WLNHESLGwsaIoyhE8Ej4VPnMaaxAo
 Xg7GgpvPsx2DTIHHqQOY13+M5NLO+V2N32p3VmDTgtLGrxFu8svb7hquPdKkAAsEi3sJcPjg1Gs
 wfXHpxnGOu+kVKSYhvp0/gtXu2S9xizgCdj/RjZD3xGt4A9ktg8GjotnZqMzk2VuolaMmyswp6p
 IPZd8rvJknyEL7lLD4i5Bw85+iLV9KkvW7dU3r0EJF9wHNlyt9kYzMNFf/L2JZw8ju00KfdCgSX
 I79zbXkyK3PLoVjTyb5Jx+U9qf9DlID1sCvOlKKW+W7QmFAbyUTZumOuFqMB2Uh6jNjKl42erNl
 sV6+oGK9SMvu8fET+Uw==
X-Proofpoint-ORIG-GUID: xx6SRYyvbsXRsNvF7lkQeT5MIWyjWKOP
X-Proofpoint-GUID: xx6SRYyvbsXRsNvF7lkQeT5MIWyjWKOP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601050150

On Mon, Jan 05, 2026 at 05:49:00PM +0100, Martin Blumenstingl wrote:
> Hi Mani,
> 
> On Thu, Dec 18, 2025 at 7:06 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> >
> >
> > On Mon, 03 Nov 2025 16:19:26 -0600, Bjorn Helgaas wrote:
> > > Previously meson_pcie_link_up() only returned true if the link was in the
> > > L0 state.  This was incorrect because hardware autonomously manages
> > > transitions between L0, L0s, and L1 while both components on the link stay
> > > in D0.  Those states should all be treated as "link is active".
> > >
> > > Returning false when the device was in L0s or L1 broke config accesses
> > > because dw_pcie_other_conf_map_bus() fails if the link is down, which
> > > caused errors like this:
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] PCI: meson: Remove meson_pcie_link_up() timeout, message, speed check
> >       commit: 11647fc772e977c981259a63c4a2b7e2c312ea22
> My understanding is that this is queued for -next.
> Ricardo (Cc'ed) reported that this patch fixes PCI link up on his Odroid-HC4.
> Is there a chance to get this patch into -fixes, so it can be pulled
> by Linus for one of the next -rc?
> 

Hmm, I looked at the Fixes tag and mistakenly assumed that the issue existed
from the beginning.

Bjorn, could you please include this patch in the next fixes PR?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

