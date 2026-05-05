Return-Path: <stable+bounces-244220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBO8ItMm+mmHKQMAu9opvQ
	(envelope-from <stable+bounces-244220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:20:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAF04D1F39
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 19:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A2E03056609
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02754A2E18;
	Tue,  5 May 2026 17:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mP6VW3C6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QLffbfO/"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9B480947
	for <stable@vger.kernel.org>; Tue,  5 May 2026 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778001606; cv=none; b=H7lciPZ0kx0a856ltOGh+KogrIElbh8wX3NsuWpNY9AB9KegnyYcosK6WhQYKAyyWKRe1NU8FYZ0rYbqTKpTCwTXbZfv1GlLX16+6fhTublAdK1mmwyKTOFtaqpg97RC4GD00PtpVXizrvpuY56tVQ16rjWbY7PhFWb0LRZwCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778001606; c=relaxed/simple;
	bh=Mibi20GbdEpVZ30vfo88+fh/vIUl1z1OmOI9By34Vps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVJry5414tDqMxG90oFQ9r4ALR3AYxb5P0YYp+BHgiS9HVaTPmE/OUJSFo0c/H3hy8BVAOxNpIQYDxqxJdhXFfJ5FQmirK1kFppRwu+xQJSjFYjNHFhHBEH2FHqD4E3PbAgkOMSSczmNoEfOpfqx5u4SQlOUZisIcTU5Xt1SCLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mP6VW3C6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QLffbfO/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EK0pa912107
	for <stable@vger.kernel.org>; Tue, 5 May 2026 17:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=5+dbc3v3OtmBl3m6PxPaJUCW
	h3BmROrwWQqLBIPzX2w=; b=mP6VW3C6CQRjZ6exLKI8+tEqoW+5Gt3Eg8GRENBB
	Uij9G0SWox1ecPB336oLLe3usbjRLn4i+yfMt5aJQcLoelDB3oc3HO4LFnnNMC2y
	ju3cfbqVNctTk8dy0nRu1YwtFQaTsKr5inlg1mCPQvBA40Jn442XXBJg3NOLIWqp
	07Z+j72cQINOMX1PMTF5XCgUd/Oh+XEj2KQ9F3Z8HY77kc28Mls8ZcLrh8C5UQ2W
	KHymiLQtlo4QsDMVuhVc4KwoCt9pTmDfCKTp0nfJB4FTeAMyyzzB0zwQgrmNLctX
	0Sak6xuzw25EXWpDTny8ozLqiNsb/wnN4Wzi/Gi2zME58Q==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyj7jgsyb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 05 May 2026 17:20:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2eba42b8dso51405385ad.0
        for <stable@vger.kernel.org>; Tue, 05 May 2026 10:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778001603; x=1778606403; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5+dbc3v3OtmBl3m6PxPaJUCWh3BmROrwWQqLBIPzX2w=;
        b=QLffbfO/uZlHBjCCPPUGB0m92m4qgxXKyT31BJuNRLCj+ERpKse5WmjYlLUTjqXfBs
         2J91Oh/WXCWneGXWGCMedk6a/x0i5fLNlWZmgG2tpO6IU+JL18D4r1lJmoh1VKg0ymnQ
         Ne1G6TnBwZvHSQTJYXXhlwIXNJ9PpZdHuxRckRQ281jcOiuC42DuOxFJKxwUEZVK92zN
         9oNKxs8Qr06AXFPjInfR/c7hJB1J8Fqh6gjqghC0BMwoDBSxcLvUjtRKbNfUselswW+m
         wI5Nj5H2pXPt+ORb7S82nzsRM5aUzgVgSHwiebeCv4IHW7Be6jqixQ0L/zpV0jF7kGkc
         zeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778001603; x=1778606403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5+dbc3v3OtmBl3m6PxPaJUCWh3BmROrwWQqLBIPzX2w=;
        b=RPZ3MPQwmM6DgYJcI96g/YooVH5qRc4Bu8UNPl1RoAqjbPilpWyeBee9cQ5/err0EF
         kURJpwkrPdAncvkW9LE1NdU8Wyh3VlJV86OwxY2755asIi4Pgbn4uMtbywyn96Xx5efr
         eqkVcqSgsfCVOBhCKM96k/B2C4T22DcK8KIvzXdZg6/9zuDQVZfmBrBtPZhbGXvBjR3g
         vrdxNRQVeYfDEOPs4PLOz1IUb50Lm3rSSI4mueS9Qkk6pI1BzVeYpmfRYADsc5B+NF8g
         nE/8ZVWytSffzkYFar41XZQSugoRQQG3LH4mbjJYGdg2PGFku2EEqQznM4p+N9O1f9Ra
         idPg==
X-Forwarded-Encrypted: i=1; AFNElJ/jt2nu/PHoW4gc++Sk4XKhbdWO6FqzvNDniwUe/UiHkOigAOcZ8xql/YRT7DihZ2Mnc2IY6Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCJi1gRyHuYmWEROYgsSFWHs7lOPI+137VyRmD3MkJqEUcsry
	ifVGbRBKDRJ6Mdrca+pyuV80gAUEDu+DRQIUXYE4iiRnBi0EB3WuGH5jQjVOlpaWIkrwojlJ8BI
	JPNMLdCj30MtGdGU1kFgsjEcmQZAhHBzS6YQRATUPC5xbqwCgVxrPDksIcBo=
X-Gm-Gg: AeBDiesI3FC0Xm0n+c6YsSls2M6fFHEw0HFIew21eq4h7hdMl6dN1tyMgOGh0EN9zsK
	QGcOG6kcefZHyhPSZrIdzZ2n3YIbD+Wpxz4g3bMGE48PGryYPFdJ00WaX9okjMqGCy7/enwz7dD
	iRQ/Nlo7wwnwfkbt+A6G9JSOz2y291fhZN/caaumuOWjq0GlZ3ukh3D6X07m9pwuDDNk5dsyeKj
	5WUcNcVyXC7H59aNMWFTi4OyMoL5UyDKskUbIeitckhHjEMedOQW8k4sj+rDqzfs/a7/TICwsdZ
	t25rpEoZLbiwfwFnoKEUf8Xw76Fz/XOhiGLgezmGsG7Et8DXiuddxhzqHwBn+i17h8rrpCcCskh
	lpPgoYQtfOB9n4gjgitggUpwjaGGNlLAN3DUn69d2AMr3OmsuHdQjMrIe2OE=
X-Received: by 2002:a17:903:22c6:b0:2ba:6bd7:8efc with SMTP id d9443c01a7336-2ba6bd79004mr14146915ad.40.1778001602475;
        Tue, 05 May 2026 10:20:02 -0700 (PDT)
X-Received: by 2002:a17:903:22c6:b0:2ba:6bd7:8efc with SMTP id d9443c01a7336-2ba6bd79004mr14146395ad.40.1778001601913;
        Tue, 05 May 2026 10:20:01 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e791sm145314855ad.7.2026.05.05.10.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 10:20:01 -0700 (PDT)
Date: Tue, 5 May 2026 22:49:54 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] misc: fastrpc: Fix NULL pointer dereference in
 rpmsg callback
Message-ID: <20260505171954.uto4a7jmxptlaa5v@hu-mojha-hyd.qualcomm.com>
References: <20260504171701.18164-1-mukesh.ojha@oss.qualcomm.com>
 <afjprOhBhP15-2lU@baldur>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afjprOhBhP15-2lU@baldur>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2NyBTYWx0ZWRfX3GL09tXhoVRC
 ygUdbrEpX4l17d1X29raXuQLJiJBiMkKmXTkO7KqARQgYg5/Fd4eJlPL2JLflHxMqudO48tG3Cq
 I/o/Sfj3cM46OuTEVtDkJRZ3AqmXZgxxhFLwHLRJIgEtDJDR6p8NLW0yWEU91jXoInKzDXTsgw0
 zY1Ge/UpD/PuAmG4I5MW8MstsLiAqOcZIfW0oGD7+VDzKpLHD2lj1mlyu9Dr14HZEDO5v9axBdO
 EoXxARpbjybuqvXGoLR7v0COtWAoEbzlKeYvN1hLoytXz5ES6OCpgjXOdx94d3Rha0U8lpaKlSz
 NkKATOGNJosirBikKJbN1smkv2+jHXSI/ZIGjiqj68ijrn+i6qXs7XclS2/VN3zxSrnplHzjU85
 FyjMXmqVXzgOURwwUsaoL2eJX5+GPIkuVC2EqJ0PS4pBC/N0DKSGntazXgWCHx7qinDOvanYjqZ
 mJahldD3sU0FR78+JOA==
X-Proofpoint-GUID: hCLxMsKnlcB-NUxCnjKSv3m88GyJSoa4
X-Authority-Analysis: v=2.4 cv=FpA1OWrq c=1 sm=1 tr=0 ts=69fa26c3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_ffyFokNbbV7GOtJ6hsA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: hCLxMsKnlcB-NUxCnjKSv3m88GyJSoa4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050167
X-Rspamd-Queue-Id: DAAF04D1F39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hu-mojha-hyd.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244220-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]

On Mon, May 04, 2026 at 01:53:37PM -0500, Bjorn Andersson wrote:
> On Mon, May 04, 2026 at 10:47:00PM +0530, Mukesh Ojha wrote:
> > A NULL pointer dereference was observed on Hawi at boot when the DSP
> > sends a glink message before fastrpc_rpmsg_probe() has completed
> > initialization:
> > 
> >   Unable to handle kernel NULL pointer dereference at virtual address 0000000000000178
> >   pc : _raw_spin_lock_irqsave+0x34/0x8c
> >   lr : fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
> >   ...
> >   Call trace:
> >    _raw_spin_lock_irqsave+0x34/0x8c (P)
> >    fastrpc_rpmsg_callback+0x3c/0xcc [fastrpc]
> >    qcom_glink_native_rx+0x538/0x6a4
> >    qcom_glink_smem_intr+0x14/0x24 [qcom_glink_smem]
> > 
> > The faulting address 0x178 corresponds to the lock variable inside
> > struct fastrpc_channel_ctx, confirming that cctx is NULL when
> > fastrpc_rpmsg_callback() attempts to take the spinlock.
> > 
> > There are two issues here. First, dev_set_drvdata() is called before
> > spin_lock_init() and idr_init(), leaving a window where the callback
> > can retrieve a valid cctx pointer but operate on an uninitialized
> > spinlock. Second, the rpmsg channel becomes live as soon as the driver
> > is bound, so fastrpc_rpmsg_callback() can fire before dev_set_drvdata()
> > is called at all, resulting in dev_get_drvdata() returning NULL.
> > 
> > Fix both issues by moving all cctx initialization ahead of
> > dev_set_drvdata() so the structure is fully initialized before it
> > becomes visible to the callback, and add a NULL check in
> > fastrpc_rpmsg_callback() as a guard against any remaining window.
> > 
> > Fixes: f6f9279f2bf0 ("misc: fastrpc: Add Qualcomm fastrpc basic driver model")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> The fix looks good to me.
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> 
> But I can't help wonder, what's in that message? Should we make sure to
> handle it, longer term?
>


4.662080] fastrpc_rpmsg_callback rsp->ctx: abcddcab ctx: ca

It looks bogus to me, as no ctx id allocated from your HLOS.

-Mukesh


> Regards,
> Bjorn
> 
> > ---
> > Changes in v2: https://lore.kernel.org/lkml/20260417200146.184425-1-mukesh.ojha@oss.qualcomm.com/
> >  - Added stable mailing list and fixes tag.
> > 
> >  drivers/misc/fastrpc.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index 1080f9acf70a..a1a54453bb7e 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -2431,7 +2431,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
> >  
> >  	kref_init(&data->refcount);
> >  
> > -	dev_set_drvdata(&rpdev->dev, data);
> >  	rdev->dma_mask = &data->dma_mask;
> >  	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
> >  	INIT_LIST_HEAD(&data->users);
> > @@ -2440,6 +2439,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
> >  	idr_init(&data->ctx_idr);
> >  	data->domain_id = domain_id;
> >  	data->rpdev = rpdev;
> > +	dev_set_drvdata(&rpdev->dev, data);
> >  
> >  	err = of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> >  	if (err)
> > @@ -2513,6 +2513,9 @@ static int fastrpc_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
> >  	if (len < sizeof(*rsp))
> >  		return -EINVAL;
> >  
> > +	if (!cctx)
> > +		return -ENODEV;
> > +
> >  	ctxid = ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
> >  
> >  	spin_lock_irqsave(&cctx->lock, flags);
> > -- 
> > 2.53.0
> > 
> > 

-- 
-Mukesh Ojha

