Return-Path: <stable+bounces-215600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE9tCtG6imlmNQAAu9opvQ
	(envelope-from <stable+bounces-215600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 05:57:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC2116EE7
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 05:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3039C300622D
	for <lists+stable@lfdr.de>; Tue, 10 Feb 2026 04:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA7B328B53;
	Tue, 10 Feb 2026 04:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NifceJas";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JuvvWt9H"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906D25C809
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 04:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770699464; cv=pass; b=UwXroi/xrOpZPXX6+ZgD5PU1FY4rn+RHCzdJcMm5gfd9Sx8lO+a/EZE2mRMyVbae+LjTQHSBXJ6sY7nKRZfVZsFpxMkxJrpJOceXSWIYzyHLSSMegBWoq98BocwNMzigrza3tcyJkwvuC8i8NAPvdqCd8hspTsyHEV8OKyIOhGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770699464; c=relaxed/simple;
	bh=mvRCNCDWnnyTl7hSDZjHxriAP6B18Za3FG0XAiIQ0/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMz1HU+uaxlxLL96VMQrYex40a0OAVG1HYMEUn/gYJGyoyycqfws2fG8Wzh7SdkKBK9nCTjNqYVzDH7t2UPvBChxUwFUyR/s+M8QipUwDuifmBTCXZsaTFhkF2qY9tw5OK0oWojVPIPGYuatpOiEr/qmTwZsyhG2DCkV+w+83eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NifceJas; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JuvvWt9H; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619I5bbg3700007
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 04:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	q/VnniC6/jkG+UbrSHCb3Fqlsu2pmu+Q7rIfJiTi0IE=; b=NifceJasvrVhWia8
	/eVoda4vIk5jSqj1qYtsEKR9EUeOqgn6VYRplDMClN6R4oVW+OKVRaAvaA5ovNYQ
	8hQbIq+etgln8bUGvQzAnGxnZxzaBpCcPyklVFT6L+T9UTUIIUB1JKaWZ14AVBbO
	c7jiUAzvmfDCCpaWtuNUqCTn/tLZvGxEuGgad3ykBEBzUinE3d5ao2spZPlE0MrC
	YdYeWpVoD6uqQ95sOU3TPnjX1POqWfIt64L0LrVIqSt7qW3/iJMI09DZ1ET6qEwG
	3ZT4Br8OwYWGHjydfrdduarPqg+ipW/ItcCogS64SWCQEqMVXsH+1XbMjj9OU4Va
	XSxkWw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7e4mb8u9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Feb 2026 04:57:41 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2ba87c0e198so367448eec.1
        for <stable@vger.kernel.org>; Mon, 09 Feb 2026 20:57:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770699461; cv=none;
        d=google.com; s=arc-20240605;
        b=JUitoi+m8Cq3pWieVMC0s5HbMKvGU57N6sfj0h5rqdb/LKjqiUZl0sclkUojU163H6
         wtxFq8rPKkhBqqPW8KVrxyuDBbcUJFLDICP33+Erz+p0o6sMxJzeuS8uJkv2Nn+Nmrdv
         8EwQws1Nd5oiaJ1ujamp270McW/RIlH8iQQy4MMlY5A1Ami64AuAVwd7aqOZvC4UQ3En
         rWXSzZVVgFInTfmj0oiUIgmdtYc1yJNrOJPeoAhaj0JQRI0HBCYdJffI2SeHRP4xo6tl
         jev8Q0n3lgzf/9tWpYZmwK2y0iCycEIumjIXFfceFp+lkM58Yt0weV6ZbxG1kj8vKZXc
         JD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=q/VnniC6/jkG+UbrSHCb3Fqlsu2pmu+Q7rIfJiTi0IE=;
        fh=seIGe1BNU7rPzl3zqleu3/8aeFXVALNpHECwboXrGp8=;
        b=AeGEHrP3GGZ+TFPGZVqrB+r8wrmCzzDphVl36hA3hH6i1dljypYRvx0wCSXn9dneea
         yngUxJCMf7d66mH8wS5Kpe3eQi83IrHUQDfO2NKYLO9xiqQ1yTryK3K0nTkwvtoeJQrO
         sbpUrMDgHXo1rYmvAiVvH3v8TFjtuvPQG+YpFr5VDISMCRtlqaYPCCljJ8/4BAH3V8FB
         MNHjFxQx1yrvMzN+QrFeZhecN8lWh8KLHBIjU3ZI+Dkm9GJY45rmtWw4mus0sw1ZOpzg
         JIimVU7XZcVCtcIhT7ZysNgdHSLJmHVwHwT7C9bE0s53dDhjHLU5SLdcHo3lrPgZ/18h
         t3lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770699461; x=1771304261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/VnniC6/jkG+UbrSHCb3Fqlsu2pmu+Q7rIfJiTi0IE=;
        b=JuvvWt9HeojyR9sCCiyvssZui1ZYUNVw21D9vnSTAOKh+4RMZYCmm9i/Pl5qL1XnTv
         0FKKwGTCBmmTnIJ2Le6u9NLf8fUuDyDPAzy6GpNIxm/ts7f1FdVC7c+SrWFtjLCYvyVW
         DCxLxC04t7OG0Vo4VrBFbQYbfP4ztLrIJU562et2fc81kys4z+5MAhEZ1dLarMa4bKIj
         1p2IDMGMIqqvDnbEez5KeC6yhus9X2DhXuaIQ+C5b4A5gobl2p4bfJenWqlxqTLpUYFU
         6Grycgb2tJRnON6b97WT8quz0f753C8SPOhdvOoUpSECzb99GLn2Z0wPC4yRy7eun5eK
         zhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770699461; x=1771304261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q/VnniC6/jkG+UbrSHCb3Fqlsu2pmu+Q7rIfJiTi0IE=;
        b=ApdDr4+4hLYAgLmwBEzseJ8OaFQzplNqGOCdXVCJ0Ygiw84SAEKbA4FmWlP9aQpqiz
         4ubMEs+UtC1aj5aYxRIdGEtJVOkzwaYs6YtI7LeyIjxVDlI9eGxOGHD83Oy0evsSkBLs
         Xw/hgI9CiuyzmZ2a8146iNWfenq4R9bTDWxFXAqdScFUg93QrHdFqAGkuPsD64llnJpH
         QUZy8ejE9Mh2ObeKLZxSGfE0jj5YRoGR8lnrz+ENshrUgPQ23AStWeQb75PuIdEtwUCo
         5HhBez/ZkMrKbjdp2bQAP/h26uUgsqdUs8T8z4wCT0xti17ubVC9HGpxZbftcpcAH6Lb
         sNKw==
X-Forwarded-Encrypted: i=1; AJvYcCVxQkT74DRqFrYVACBZe8IaFTbeLRZDR24dT3E8NYlkQms4STd3KpNe7SCMkEN3ivNtKLKscdM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzry/fKGRaPiZ1lghMsjx5c7YHU8YwDRW8XV2Grf9X6k0G1aPv
	JJ/o7qy5FCs0+M6Y4GK44CB36NhosUAVEaoKOqiRlWPS5pyOsFVxBa3REHSukbout5o2nV0YgWc
	46GWhtXOuXC1UXpnTNve7XoNPO652zQJWBswY9wqhBj6YVajW+gFKGU9SQfpQRkHh3iyZwUrhws
	ixhUT+WJzSrH2mUxoGcm9WAaQud7kJjHQUBA==
X-Gm-Gg: AZuq6aJpRGYpJIg2IhQfXFfzdenUr39ej5L8TIZP62WoytdPiY9rkr/OBggeLgcfYYS
	g3iggtEoFcYnN7Aq2GOO9wqkmjCO+GyTPMyEvcH0mPrIIuaiPzId7d5yIxLMNs/h65R2CFCen11
	BmNbCkPzzwBx2igbPqQr4Owp/kw0Ga0b6tbbyy6D/C0EyMdJH6ta9y2rK/FgAKDTI1yeArzC3lV
	hfqXxXZ
X-Received: by 2002:a05:7301:3f16:b0:2ba:6458:b320 with SMTP id 5a478bee46e88-2ba8a64ad8cmr478981eec.7.1770699460522;
        Mon, 09 Feb 2026 20:57:40 -0800 (PST)
X-Received: by 2002:a05:7301:3f16:b0:2ba:6458:b320 with SMTP id
 5a478bee46e88-2ba8a64ad8cmr478971eec.7.1770699459827; Mon, 09 Feb 2026
 20:57:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203080712.15480-1-manivannan.sadhasivam@oss.qualcomm.com>
 <CAGptzHOfmrHeJWvMxWj_xUTt_Xn-WGX04oc5s7DvjujPUOWQZQ@mail.gmail.com> <bznckulswclw6zwaf4r524hxsimz3d2p4rk5lrnvlcgpyxqlru@nenunn2h7fjz>
In-Reply-To: <bznckulswclw6zwaf4r524hxsimz3d2p4rk5lrnvlcgpyxqlru@nenunn2h7fjz>
From: Sumit Garg <sumit.garg@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 10:27:28 +0530
X-Gm-Features: AZwV_Qj31EA1wabXFQjs_IM7u4yQr0FvN8fdYwxlE2tfWRzXNB0WGy6hWsS7ai0
Message-ID: <CAGptzHOTi=ysnYS_nXhn-m+hC969LW2tdCnU5P-y5sKaxt6MMg@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: ice: Remove platform_driver support and expose
 as a pure library
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: MRsS-FQbfrce86XWebR3-LoqSrSTKThn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAzOSBTYWx0ZWRfX5vCfmGrkIReh
 x+dYEJ9Y1yAD6Gjq7rGUAdoFURQ1XqsxVq9HVCaOvDreYcRTbtDZdBKQQMID4QUj/DzTcScfBba
 WyKqJhsUEmZxfNY6Hz0LOxbE0MPi08L4FwtnnbFgwLyPXXJkzeTl45J86kEicLkmVNwZzVjWiEL
 gWk/nHZAX531zqsI+dpXrXrXy+ydyrACej1DbwQMjA9uyWrZG1ZmDW3Zak9L+rF6GJtWNCrcMJR
 jH98e71YNjNg0+HXXa51RMXqobd6kYvNMYXfHnDRf1SxnOgoKhbN88n38H5LDkBdzE3sqimwPP0
 Xm1ZvhqHYgwtShW+483Rm4Kd1jFrg8cYIXsKnyWn2nhpRoeOVXfQ2yVCqJChS1VTEAB0D/4XAxx
 j+zptQ/8m4mr1PgRGfyEs7gPUq7qZ5sxA3jsb+vMzv5DKMM9s+8zAY2FXI3XSzQbx8TJbolsIs1
 CglFsvmseH2Z0FBa6/Q==
X-Proofpoint-ORIG-GUID: MRsS-FQbfrce86XWebR3-LoqSrSTKThn
X-Authority-Analysis: v=2.4 cv=WecBqkhX c=1 sm=1 tr=0 ts=698abac5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=PRTK_1lWvyV9fVIPR8EA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100039
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215600-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.garg@oss.qualcomm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[qualcomm.com:query timed out];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim]
X-Rspamd-Queue-Id: 90CC2116EE7
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 6:27=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.o=
rg> wrote:
>
> On Mon, Feb 09, 2026 at 06:12:35PM +0530, Sumit Garg wrote:
> > Hi Mani,
> >
> > On Tue, Feb 3, 2026 at 1:37=E2=80=AFPM Manivannan Sadhasivam
> > <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> > >
> > > The current platform driver design causes probe ordering races with c=
lients
> > > (UFS, eMMC) due to ICE's dependency on SCM firmware calls. If ICE pro=
be
> > > fails (missing ICE SCM or DT registers), devm_of_qcom_ice_get() loops=
 with
> > > -EPROBE_DEFER, leaving clients non-functional even when ICE should be
> > > gracefully disabled. devm_of_qcom_ice_get() cannot know if the ICE dr=
iver
> > > probe has failed due to above reasons or it is waiting for the SCM dr=
iver.
> > >
> > > Moreover, there is no devlink dependency between ICE and client drive=
rs
> > > as 'qcom,ice' is not considered as a DT 'supplier'. So the client dri=
vers
> > > have no idea of when the ICE driver is going to probe.
> > >
> > > To avoid all this hassle, remove the platform driver support altogeth=
er and
> > > just expose the ICE driver as a pure library to client drivers. With =
this
> > > design, when devm_of_qcom_ice_get() is called, it will check if the I=
CE
> > > instance is available or not. If not, it will create one based on the=
 ICE
> > > DT node, increase the refcount and return the handle. When the next c=
lient
> > > calls the API again, the ICE instance would be available. So this fun=
ction
> > > will just increment the refcount and return the instance.
> > >
> > > Finally, when the client devices get destroyed, refcount will be
> > > decremented and finally the cleanup will happen once all clients are
> > > destroyed.
> > >
> > > For the clients using the old DT binding of providing the separate 'i=
ce'
> > > register range in their node, this change has no impact.
> > >
> > > Cc: stable@vger.kernel.org
> > > Cc: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > > Reported-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> > > Fixes: 2afbf43a4aec ("soc: qcom: Make the Qualcomm UFS/SDCC ICE a ded=
icated driver")
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualc=
omm.com>
> > > ---
> > >  drivers/soc/qcom/ice.c | 100 ++++++++++++++++-----------------------=
--
> > >  1 file changed, 39 insertions(+), 61 deletions(-)
> > >
> >
> > Thanks for this change but we need to avoid building ICE as a module
> > too and return error code when ICE SCM calls aren't present.
> >
>
> Why built-in?

If the intention is to build it as a module then you don't drop following:

diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
index 139891a122db..bfe23cb232fc 100644
--- a/drivers/soc/qcom/ice.c
+++ b/drivers/soc/qcom/ice.c
@@ -729,3 +729,6 @@ struct qcom_ice *devm_of_qcom_ice_get(struct device *de=
v)
        return ice;
 }
 EXPORT_SYMBOL_GPL(devm_of_qcom_ice_get);
+
+MODULE_DESCRIPTION("Qualcomm Inline Crypto Engine driver");
+MODULE_LICENSE("GPL");

-Sumit

>
> > So following diff on top of this patch works for me, feel free to
> > incorporate it in your patch:
> >
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index 2caadbbcf830..db528104488b 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -283,7 +283,7 @@ config QCOM_ICC_BWMON
> >           memory throughput even with lower CPU frequencies.
> >
> >  config QCOM_INLINE_CRYPTO_ENGINE
> > -       tristate
> > +       bool
> >         select QCOM_SCM
> >
> >  config QCOM_PBS
> > diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> > index 8640e05becd1..139891a122db 100644
> > --- a/drivers/soc/qcom/ice.c
> > +++ b/drivers/soc/qcom/ice.c
> > @@ -563,7 +563,7 @@ static struct qcom_ice *qcom_ice_create(struct devi=
ce *dev,
> >
> >         if (!qcom_scm_ice_available()) {
> >                 dev_warn(dev, "ICE SCM interface not found\n");
> > -               return NULL;
> > +               return ERR_PTR(-EOPNOTSUPP);
>
> This makes sense.
>
> - Mani
>
> >         }
> >
> >         engine =3D devm_kzalloc(dev, sizeof(*engine), GFP_KERNEL);
> >
> > -Sumit
> >
> > > diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> > > index b203bc685cad..b5a9cf8de6e4 100644
> > > --- a/drivers/soc/qcom/ice.c
> > > +++ b/drivers/soc/qcom/ice.c
> > > @@ -107,12 +107,16 @@ struct qcom_ice {
> > >         struct device *dev;
> > >         void __iomem *base;
> > >
> > > +       struct kref refcount;
> > >         struct clk *core_clk;
> > >         bool use_hwkm;
> > >         bool hwkm_init_complete;
> > >         u8 hwkm_version;
> > >  };
> > >
> > > +static DEFINE_MUTEX(ice_mutex);
> > > +struct qcom_ice *ice_handle;
> > > +
> > >  static bool qcom_ice_check_supported(struct qcom_ice *ice)
> > >  {
> > >         u32 regval =3D qcom_ice_readl(ice, QCOM_ICE_REG_VERSION);
> > > @@ -599,8 +603,8 @@ static struct qcom_ice *qcom_ice_create(struct de=
vice *dev,
> > >   * This function will provide an ICE instance either by creating one=
 for the
> > >   * consumer device if its DT node provides the 'ice' reg range and t=
he 'ice'
> > >   * clock (for legacy DT style). On the other hand, if consumer provi=
des a
> > > - * phandle via 'qcom,ice' property to an ICE DT, the ICE instance wi=
ll already
> > > - * be created and so this function will return that instead.
> > > + * phandle via 'qcom,ice' property to an ICE DT node, then the ICE i=
nstance will
> > > + * be created if not already done and will be returned.
> > >   *
> > >   * Return: ICE pointer on success, NULL if there is no ICE data prov=
ided by the
> > >   * consumer or ERR_PTR() on error.
> > > @@ -611,11 +615,12 @@ static struct qcom_ice *of_qcom_ice_get(struct =
device *dev)
> > >         struct qcom_ice *ice;
> > >         struct resource *res;
> > >         void __iomem *base;
> > > -       struct device_link *link;
> > >
> > >         if (!dev || !dev->of_node)
> > >                 return ERR_PTR(-ENODEV);
> > >
> > > +       guard(mutex)(&ice_mutex);
> > > +
> > >         /*
> > >          * In order to support legacy style devicetree bindings, we n=
eed
> > >          * to create the ICE instance using the consumer device and t=
he reg
> > > @@ -631,6 +636,16 @@ static struct qcom_ice *of_qcom_ice_get(struct d=
evice *dev)
> > >                 return qcom_ice_create(&pdev->dev, base);
> > >         }
> > >
> > > +       /*
> > > +        * If the ICE node has been initialized already, just increas=
e the
> > > +        * refcount and return the handle.
> > > +        */
> > > +       if (ice_handle) {
> > > +               kref_get(&ice_handle->refcount);
> > > +
> > > +               return ice_handle;
> > > +       }
> > > +
> > >         /*
> > >          * If the consumer node does not provider an 'ice' reg range
> > >          * (legacy DT binding), then it must at least provide a phand=
le
> > > @@ -643,41 +658,43 @@ static struct qcom_ice *of_qcom_ice_get(struct =
device *dev)
> > >
> > >         pdev =3D of_find_device_by_node(node);
> > >         if (!pdev) {
> > > -               dev_err(dev, "Cannot find device node %s\n", node->na=
me);
> > > +               dev_err(dev, "Cannot find ICE platform device\n");
> > > +               platform_device_put(pdev);
> > >                 return ERR_PTR(-EPROBE_DEFER);
> > >         }
> > >
> > > -       ice =3D platform_get_drvdata(pdev);
> > > -       if (!ice) {
> > > -               dev_err(dev, "Cannot get ice instance from %s\n",
> > > -                       dev_name(&pdev->dev));
> > > +       base =3D devm_platform_ioremap_resource(pdev, 0);
> > > +       if (IS_ERR(base)) {
> > > +               dev_warn(&pdev->dev, "ICE registers not found\n");
> > >                 platform_device_put(pdev);
> > > -               return ERR_PTR(-EPROBE_DEFER);
> > > +               return base;
> > >         }
> > >
> > > -       link =3D device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_=
SUPPLIER);
> > > -       if (!link) {
> > > -               dev_err(&pdev->dev,
> > > -                       "Failed to create device link to consumer %s\=
n",
> > > -                       dev_name(dev));
> > > +       ice =3D qcom_ice_create(&pdev->dev, base);
> > > +       if (IS_ERR(ice)) {
> > >                 platform_device_put(pdev);
> > > -               ice =3D ERR_PTR(-EINVAL);
> > > +               return ice_handle;
> > >         }
> > >
> > > -       return ice;
> > > +       ice_handle =3D ice;
> > > +       kref_init(&ice_handle->refcount);
> > > +
> > > +       return ice_handle;
> > >  }
> > >
> > > -static void qcom_ice_put(const struct qcom_ice *ice)
> > > +static void qcom_ice_put(struct kref *kref)
> > >  {
> > > -       struct platform_device *pdev =3D to_platform_device(ice->dev)=
;
> > > -
> > > -       if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"=
))
> > > -               platform_device_put(pdev);
> > > +       platform_device_put(to_platform_device(ice_handle->dev));
> > > +       ice_handle =3D NULL;
> > >  }
> > >
> > >  static void devm_of_qcom_ice_put(struct device *dev, void *res)
> > >  {
> > > -       qcom_ice_put(*(struct qcom_ice **)res);
> > > +       const struct qcom_ice *ice =3D *(struct qcom_ice **)res;
> > > +       struct platform_device *pdev =3D to_platform_device(ice->dev)=
;
> > > +
> > > +       if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "ice"=
))
> > > +               kref_put(&ice_handle->refcount, qcom_ice_put);
> > >  }
> > >
> > >  /**
> > > @@ -713,42 +730,3 @@ struct qcom_ice *devm_of_qcom_ice_get(struct dev=
ice *dev)
> > >         return ice;
> > >  }
> > >  EXPORT_SYMBOL_GPL(devm_of_qcom_ice_get);
> > > -
> > > -static int qcom_ice_probe(struct platform_device *pdev)
> > > -{
> > > -       struct qcom_ice *engine;
> > > -       void __iomem *base;
> > > -
> > > -       base =3D devm_platform_ioremap_resource(pdev, 0);
> > > -       if (IS_ERR(base)) {
> > > -               dev_warn(&pdev->dev, "ICE registers not found\n");
> > > -               return PTR_ERR(base);
> > > -       }
> > > -
> > > -       engine =3D qcom_ice_create(&pdev->dev, base);
> > > -       if (IS_ERR(engine))
> > > -               return PTR_ERR(engine);
> > > -
> > > -       platform_set_drvdata(pdev, engine);
> > > -
> > > -       return 0;
> > > -}
> > > -
> > > -static const struct of_device_id qcom_ice_of_match_table[] =3D {
> > > -       { .compatible =3D "qcom,inline-crypto-engine" },
> > > -       { },
> > > -};
> > > -MODULE_DEVICE_TABLE(of, qcom_ice_of_match_table);
> > > -
> > > -static struct platform_driver qcom_ice_driver =3D {
> > > -       .probe  =3D qcom_ice_probe,
> > > -       .driver =3D {
> > > -               .name =3D "qcom-ice",
> > > -               .of_match_table =3D qcom_ice_of_match_table,
> > > -       },
> > > -};
> > > -
> > > -module_platform_driver(qcom_ice_driver);
> > > -
> > > -MODULE_DESCRIPTION("Qualcomm Inline Crypto Engine driver");
> > > -MODULE_LICENSE("GPL");
> > > --
> > > 2.51.0
> > >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

