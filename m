Return-Path: <stable+bounces-223377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKgYEygWq2nMZwEAu9opvQ
	(envelope-from <stable+bounces-223377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 19:00:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 385B522683F
	for <lists+stable@lfdr.de>; Fri, 06 Mar 2026 19:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFD973008605
	for <lists+stable@lfdr.de>; Fri,  6 Mar 2026 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D907F411615;
	Fri,  6 Mar 2026 18:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IhckAdlC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ky24bw/y"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93FB841B355
	for <stable@vger.kernel.org>; Fri,  6 Mar 2026 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820002; cv=none; b=Zhb0Rw2leUpXt9FeE5vThRsHuD7HtXCOp3cOU3rw93lTggsEKpjbWHULV3TOKS+NykctykSNqHWPQraFAGvpQO1LTFFx1iaYWBx7xYYDYJw57M+crKssS0y1yJMTEzoZbBKtXaascByjXgl4OfNZMqSRh/6b5qOAivPaeUYi4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820002; c=relaxed/simple;
	bh=DBCxT/2e7ZvKmGoWfxanKmWtl22WFbPpIsfuIJZfts4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kd1/yUesi03n0BkiaNR4kLyMG3BkJ94vxJENvzG86ZV+Mt6bkhVZuY78lI/P9yDDWI3Oyzeu375k2gN3oCJTy1mo1smAqOTDbVym2uPKtjgqmOTzVI3HupPel9cBSv/KM/Iyn2h959BZgQ4wq0kkSplIgx4xfgGb0zMKlVO+48M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IhckAdlC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ky24bw/y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 626H1nwr707415
	for <stable@vger.kernel.org>; Fri, 6 Mar 2026 17:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rN+Xffu/qaR90TyG6E3RJVNY
	3wxJVrmWgqtIqzPKHx8=; b=IhckAdlCCVX/ljQjR3Q11cj/Wg00W9tBzEdscgCe
	UYqthjopON+k7PE2Xuu/JmYths9sSqHy34RnKWjgr/JO0y/DpZTbCytMMGbgLNqT
	BTiduXyAcOM9ZvFR8PGiPybv9fmgaEHkrqupMJQTzyPKEP0vAbuao5zUM/91jvz6
	mAp+Iqc1XLn6p3DR762p/lqubr+6t8EAeL80xPIVT1v9CCLdVmXRNbq/HVDlv/gq
	mO4dKj1DECwk9PPt91KYrGa5rzCuV9n5DpTDQ7aVy+C25cooZ/LZErfW+WyEVxg/
	/TaX7YZiFMHWtEUlnv908eY5sDK1SExvskO3vUUhB8/Kxg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqrukafux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Mar 2026 17:59:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso7976023a91.2
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772819998; x=1773424798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rN+Xffu/qaR90TyG6E3RJVNY3wxJVrmWgqtIqzPKHx8=;
        b=Ky24bw/ypFTA5YoGUkqpg6vzlZYEAhDmk7lewafAz/EFI+/7aZEvXILhRerSJ6IgwA
         tXE4WSRIh3CGGp1DiB6gOldai7qER+X23X+stW/O9Ht49+xfXgZPUP9Ij7ub9fbURU0i
         LFosp/4TN6KuNmegYku7JtCOmGIIy9mEOgbkb6MBt3pTc6rtMk78qlbyrYGrO5G8/Img
         WK94fZRlZmrMODIm0AKoxY4W+ipdeAhQ55woeIGbcDVI4AkhVRTayxeJii3Sn95zuVhG
         iPASkGnBySCKfoHvnqy+frd5fs+UNxlXzDlZXo8W/hEXDt+Bj0oOQKSlX1oP37fc7usb
         ho+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772819998; x=1773424798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rN+Xffu/qaR90TyG6E3RJVNY3wxJVrmWgqtIqzPKHx8=;
        b=f6IlnMzFgqMH9PWlBwh32e1JVV211b7XyNOquizylXJYnu55cvCsODltUrxLUigudF
         tO9b9Nw+wzncd3UItBAVoUpyu68St0V7z6gMNyJuYEn96bh+8PhS9W3L2xY5TRZX0Orl
         56/YQ70z9ItagnoR9vkTCHJ5OuMlTZgsAV+AVLKXTZfabFQRs9xjOoxqZsz7e9P6VhVv
         mf3Aw3UuhECWvvjwgrTdWS9hy2vFskzmZ5Y/SDPIHU7FRRn/4SZhf0ULJg/6jEDFXPnQ
         9hMbV2DWhONv7Vo80dF8JqegA33Dv99QGwp3nhM0CWbQKaElrUqzKp4Rn3pBkDMLq9NJ
         0ioQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBqZ5PpgjajM9gT5Q2dnNzXux3VuimbLXZXDW7V09Zy4lH09Z/9wmK4blQMVCbBlNLSyP2Rr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6HeEcOXlHHCwBf01bjh/jgl7ZLt1Ou31cgz9Rs8WUFyzuCdVr
	89VKoGRBlguKK0ymoRb0tH1Y9J16++kck+9yr1IpiShHsD3AoXTPOGplKC6KtBrSmjQOoqlzWKo
	Z/yd60VfSvEfrVA0f1Vs3g/MydqO7yjf5Le1ooeaFi/jHbFXdjdclD866J8w=
X-Gm-Gg: ATEYQzxP6Pthn8abXYSKOjwr7jUmfnlKYwqKmplpGBuV+hQKitCqyt297soqVxH1zXG
	RjlZDldSYstQzXTcALsp2kBZ7qUPLrfwrU5FCUdjgFrZpHWWR9TIn8Gvdj+tTynQqLIT/wC3/wq
	zGOY5De0lirECbYkRYAzT7NUTSXkGyiffhYXJlVVNyhjpUCWBG4Zpoq8pWT5aRQF4BxHJpiELRL
	RnTzySF6K1wnEqx6Vlo7k3LiRoUN37yEC60HR1RpGiFnxdL6ARFjbLWPNL9HT600Jlrnym7j89c
	Df4FNG3zQwO1eXnajJCEFCYbxR2d7y8oRUmTxJrmxwKSU0AbJhkjn2yrZyr5JoHPueH3tA44Gx5
	QNQLLQwSlsRvzrTnsGHxKcFnxRs8Yb1rUfESUq3rDc+Aw7dGC
X-Received: by 2002:a17:90b:4c50:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-359be3b9d00mr2597077a91.34.1772819998175;
        Fri, 06 Mar 2026 09:59:58 -0800 (PST)
X-Received: by 2002:a17:90b:4c50:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-359be3b9d00mr2597054a91.34.1772819997612;
        Fri, 06 Mar 2026 09:59:57 -0800 (PST)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c0154a09sm2388801a91.12.2026.03.06.09.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 09:59:57 -0800 (PST)
Date: Fri, 6 Mar 2026 23:29:51 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, Chris Lew <quic_clew@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Gokul Krishnakumar <gokul.krishnakumar@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/2] soc: qcom: pd-mapper: Fix element length in
 servreg_loc_pfr_req_ei
Message-ID: <20260306175951.v2ahxv53p4bq6egx@hu-mojha-hyd.qualcomm.com>
References: <20260202103641.3003867-1-mukesh.ojha@oss.qualcomm.com>
 <umnu5wui4cwe7udytn7scfgwxfskdy3vykex5hqerzitadpkxl@5wabu3w3amot>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <umnu5wui4cwe7udytn7scfgwxfskdy3vykex5hqerzitadpkxl@5wabu3w3amot>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE3MCBTYWx0ZWRfX+xu3IndFszy4
 Ts8LlUSUDzwmsxktrSF7LhXYONShA0KsIiC9bKEbVyVDw6tfvpJqQH/BV0dIpPX5JZSBqo2L5cV
 E//67P+hseLCYsUgD5p7V0dtRrA/6H0uy08Y+CxYwiCnCqmCZ278fmrWhtRNgbfnu7JDksAhK7T
 gck5wjsTg9ybZeEJLaGyUhcj5LTBSCrPAb7vaqlJ0vJuEd+iZfZR5Ou4eYNg8uZAK2mT0hHpa2z
 zea1idR2Curc5j98Kc0nbZ98i140c1vG0LOJ5ILjbpOCBOmiHIx3umX99BcAD7cPqct+NeUXAJA
 UaT4UefZJr+BcArllcQO/rgQ4m6qCWWRoSrh6qiGuvZfyP89GKJDngBxqzGFpk+vSDrq07DHKAL
 4Mtj0pES9sRYVujVNz/2IOcgGP5UuKfTl8IZbdCX+uFgdDYkHnrXVG/YBbPB1E4j/TRBByXVcla
 bvypLFkz2EmoO1WMR9Q==
X-Proofpoint-ORIG-GUID: FQrqVbgkdnRiNgh7A43x-QkmMBAxGl6g
X-Authority-Analysis: v=2.4 cv=DvZbOW/+ c=1 sm=1 tr=0 ts=69ab161f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=V2NRjDIt5TWjL-3IoRYA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: FQrqVbgkdnRiNgh7A43x-QkmMBAxGl6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060170
X-Rspamd-Queue-Id: 385B522683F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hu-mojha-hyd.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223377-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.944];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 02:07:51PM -0600, Bjorn Andersson wrote:
> On Mon, Feb 02, 2026 at 04:06:40PM +0530, Mukesh Ojha wrote:
> > It looks element length declared in servreg_loc_pfr_req_ei for reason
> > not matching servreg_loc_pfr_req's reason field due which we could
> > observe decoding error on PD crash.
> > 
> >   qmi_decode_string_elem: String len 81 >= Max Len 65
> > 
> > Fix this by matching with servreg_loc_pfr_req's reason field.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 1ebcde047c54 ("soc: qcom: add pd-mapper implementation")
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Co-developed-by: Gokul Krishnakumar <gokul.krishnakumar@oss.qualcomm.com>
> > Signed-off-by: Gokul Krishnakumar <gokul.krishnakumar@oss.qualcomm.com>
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> > ---
> > Changes in v2:
> >   - Given credit to my colleague Gokul.K who first faced this issue and given
> >     initial fix and that was later corrected by me.
> 
> If Gokul wrote the patch, please keep him as Author and his
> Signed-off-by, then after that you add a line "[mukesh: changed x,y,z]"
> followed by your Signed-off-by.

Sure, will send v3.

-Mukesh

