Return-Path: <stable+bounces-222769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wH34N808pmmpMwAAu9opvQ
	(envelope-from <stable+bounces-222769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 02:43:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9351E7C5A
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 02:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 515C430338A4
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 01:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EDF373C14;
	Tue,  3 Mar 2026 01:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdKPqX1K";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aRTecvAN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9463633B6D4
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502219; cv=none; b=iunV9RS/Nno1P0fyAPbPgohp7XqcCr9P3xFeAzTZh5YV47QhtaMGu7msdkF2eoXQIIQXVAXUxj1jeI54ymBFfEC6OcxPYqGI6yyUk7e9bu2UJK2Y57zWd62+3F4lNL71m9q8r/KtkQBHhVxLXF/VE/kaHtvn4NciGUhQ7D6QLJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502219; c=relaxed/simple;
	bh=i4jKsvabsQ1+RXbVYAM6h40AITuGmmIfVt7gRKhfmLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvIFpr7ITCezvjKmCLjEXzDDe0xje8lXSbj9rJdv3Ruvw/zah2ztEO1z89LHaqsJwKiwWsV3H7QoSa5LbHcsrYU2ISgIzseSy6TeapDgrFr96TBQ+f1r3fTwChWUhAcBkqQfVHCZlkCxsco3AAScfi+c5ZTwXxbINzGYlmRy+VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdKPqX1K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aRTecvAN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6230rNtb669661
	for <stable@vger.kernel.org>; Tue, 3 Mar 2026 01:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Wa8JYJ97vCRvUAnb2y8s1hFO
	Xb0oIDwDms0q0c0b36w=; b=JdKPqX1K9NM9kN6DfxloxPkOSgLkwDNhsSwci01Z
	IPnRnC2BkxwjXR1MPo1m/pYjSV5PMyzTaueRt6wEpR+2kgZDDceDDMYslCjUOz7Z
	pryos0GeeXlRU49ghlHBTmy417PvmpHG9HEBljJw8zZI+9ZA8qYmLJg9fGseYyjx
	k0jRmdYZIPvjQZfeSPD6552wyfWpaQRSskNbWwQYcB3issI7yRScaXLrZX+MDlK+
	R7CjBp3l7RQUw72TCyLZuoz/TAR+7ex+buvotD8GNuk9oT2TnqAIyru+X7p9jOWi
	Q8wPjmJkSJez46/JVKEOSlkvMvLwSqMFYsV6uXtSneeucQ==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cnngg85ke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Mar 2026 01:43:36 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-45f07dad7a8so20483664b6e.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 17:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772502216; x=1773107016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wa8JYJ97vCRvUAnb2y8s1hFOXb0oIDwDms0q0c0b36w=;
        b=aRTecvANjB5x6SPBsSjR2uWX5Alk5Gnn6oEzpoMVlw3KOP0wFIZiZNlIsacmxOrP0+
         YvwZ3DzIHIshblu6a8tErCMtD5aXdmF2MiHHZFJ6tVQjWwmGCZ22cKWCGt+dVYYYj5xx
         sSDVhNmkwOGd/QBgAZHxbQvzmLcyrTGdI4HhRUaTcAU6V9lB2RnxuEwpbTdxB1d+tdLt
         RId3jArBo70y2KySCwSn37gEJsWQ80ppxBinD15N2SOOt3XpPlaODUrHHkVQi4CertwH
         MghK+zSa1DVqph1evqfLaujIYSMnNibmuRGB0+F0hYtemd39gq0SgTHm4Pf3UyC5nU4e
         Ny6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772502216; x=1773107016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa8JYJ97vCRvUAnb2y8s1hFOXb0oIDwDms0q0c0b36w=;
        b=m7b93RMKiAI1sjRTRnPH1XAnkeCWbOIOVYYdgA/MK/ajoOeVer7zHZF7EZRDwOnxBm
         a9Qjz9l4j7hWESz+ui8tT87yL8M23fqi1oscwtHkL5JblffG7ON2fQq1u0DgvhCGFxGG
         y9npyYNSMAfRioCWDoDkTOU9d07v/0LyTGM0nMXv3ebD8nnwmUgcWJnaoNuqpn5IaKdn
         ose4Zh4/659galCxX/yTOxkkFu8Fc4sYPuQkphmayPd+1snhb/2Nnz6f37Jw31qzJ3I5
         jXqsfLfGqJJ5v3B9vlhDXmchL7efTZp1KntFWA398wqDtj/LTk8He2U9LhOug2dF16zb
         75Vg==
X-Forwarded-Encrypted: i=1; AJvYcCVcPyETs56p6s2exZ8Jrzw0XAjMwPRMgHBF0NkYx/YM/vHDcRJavUxT8VdmplfYMibS5YpjttA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllGlcTBEQvcm7iJKqH1sFaFkpoSmXd/tKYY6i2Sajgb410s+A
	pEHkogZcG3Fj7JGPvXaa8elJU3JmSVdnDLVrq/X0yloMmT7IHw0YyOLkRSXa3iLYz65kZNpn6UO
	pDsDjW9/Gg7FdxpdKVklwC61igA2Gc5WnKG5gx1RK8pRYi5svAd/PIXlilw8=
X-Gm-Gg: ATEYQzyIkk1wD6ap0ABtrNQWaRa9Emh9PQAnQjDa4pR0K7qughmgdwDMwgPZeerMIb7
	EG8O4QHyC6NUCPsKIA97vun+N5TcB9AgkmZYwXFQt/zF8XeQ00zrVPDY2qgOFAjwsKDWcrLbzxK
	6K3yjRztpjdH087xCSdta+DrvSI/H0F8LwenTQByaMrfmcQPCG78yc2S4Yk1IpoVMRUMOex+4oh
	Y8SZfwKNpIlj3Esma9EiGdgm7fjuKocREgCPu3ml7bGLrUdvfA3zaO2zOAh9m2wg8jZv7Ra2HqO
	8Q6tBHuyytt9qxOdjl3BY0MW4lEiXgIXanFE5cr5qzQi74Ms4uVvmDXBULxSkppo1MawpGETQ3X
	93wyqZj72lMFONYEHVlPZgalDic+Q4dY40zLlkmuRahN8cGHkoDOWgmipuHM/VuzC8D21
X-Received: by 2002:a05:6808:1b28:b0:45e:dbc8:7b18 with SMTP id 5614622812f47-464bec215c4mr8174457b6e.13.1772502215893;
        Mon, 02 Mar 2026 17:43:35 -0800 (PST)
X-Received: by 2002:a05:6808:1b28:b0:45e:dbc8:7b18 with SMTP id 5614622812f47-464bec215c4mr8174452b6e.13.1772502215536;
        Mon, 02 Mar 2026 17:43:35 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb5d0a8csm8509256b6e.14.2026.03.02.17.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:43:35 -0800 (PST)
Date: Mon, 2 Mar 2026 17:43:33 -0800
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: mani@kernel.org, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: Re: [PATCH] bus: mhi: host: pci_generic: Resume the device before
 executing mhi_pci_remove()
Message-ID: <aaY8xfPF9j83aM5X@hu-qianyu-lv.qualcomm.com>
References: <20260302134116.18960-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302134116.18960-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=P7E3RyAu c=1 sm=1 tr=0 ts=69a63cc8 cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=mZK3EA3oJS9YODrgi44A:9 a=CjuIK1q_8ugA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22
X-Proofpoint-GUID: RqOfVdJ4za4VZ4ukmeFKfKWozAEapUUZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDAwNSBTYWx0ZWRfX6dQzfhPfq0sE
 kv1ITpipUbTgF8GmiYv8pSKi22CJWqWMOJn8BwkyMXWBAIb+iwAG9g4GWgR6xZUeeB9wVbzzDFT
 vddWInBNn8p4Fg0fcd0z1ZNpoanaS1ve4mfFxTS7HXOjA6DNuwIi9Zm3n+41+yA88o5dDV4XI16
 RoUR30V5DL2tm5Op6QZjfM3Qob2dsgBRe3mZiKMDr1t0J1ZXcxkR2IVC3EDMH4FvUQDoIe6N2Ns
 acsVNNbdD+qBHrUHP3UQgLC9S+NyLCTJfJ2t66H0//x56zY4zMak7XDt96fwz7CLeyRymGd+8Y6
 sLvM9Cc4HcdjTpHHDFn6kDmm4SelwraWHdG37YzhZ2YO4egf4AWtxAFQP05Dc/LLZwOnBqHXoEH
 58/viN0cgXKhsFAWs0H/ueYLcg9Uwjz/RKIjBrpmipoggt5O7SGxt8C34wmf+YKb3qJqKZ7E0s3
 6mVM3UJi6WKK3x8iA2g==
X-Proofpoint-ORIG-GUID: RqOfVdJ4za4VZ4ukmeFKfKWozAEapUUZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603030005
X-Rspamd-Queue-Id: 5D9351E7C5A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hu-qianyu-lv.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222769-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qiang.yu@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 07:11:16PM +0530, Manivannan Sadhasivam wrote:
> mhi_pci_remove() carries out device specific operations that requires the
> device to be active. But pm_runtime_get_noresume() called at the end of the
> remove() will not guarantee that.
> 
> So use pm_runtime_get_sync() and call it at the start of remove().
> 
> Cc: <stable@vger.kernel.org> # 5.13
> Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/bus/mhi/host/pci_generic.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 425362037830..fe3aefa15966 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -1440,6 +1440,10 @@ static void mhi_pci_remove(struct pci_dev *pdev)
>  	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
>  	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
>  
> +	/* balancing probe put_noidle */
> +	if (pci_pme_capable(pdev, PCI_D3hot))
> +		pm_runtime_get_sync(&pdev->dev);

Mani, I don't think we need to resume here. See drivers/pci/pci-driver.c.
PCI framework has called pm_runtime_get_sync before drv->remove(pci_dev);
Is there any other thing I misunderstand?

static void pci_device_remove(struct device *dev)
{
        ...
        if (drv->remove) {
                pm_runtime_get_sync(dev);
        ...
                pm_runtime_barrier(dev);
                drv->remove(pci_dev);
                pm_runtime_put_noidle(dev);

- Qiang Yu
> +
>  	pci_disable_sriov(pdev);
>  
>  	if (pdev->is_physfn)
> @@ -1451,10 +1455,6 @@ static void mhi_pci_remove(struct pci_dev *pdev)
>  		mhi_unprepare_after_power_down(mhi_cntrl);
>  	}
>  
> -	/* balancing probe put_noidle */
> -	if (pci_pme_capable(pdev, PCI_D3hot))
> -		pm_runtime_get_noresume(&pdev->dev);
> -
>  	if (mhi_pdev->reset_on_remove)
>  		mhi_soc_reset(mhi_cntrl);
>  
> -- 
> 2.51.0
> 

