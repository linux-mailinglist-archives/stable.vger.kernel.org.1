Return-Path: <stable+bounces-249454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPOsJ/rhC2qzPwUAu9opvQ
	(envelope-from <stable+bounces-249454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:07:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D4D5771DD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 06:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 116653040CB2
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 04:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627102EFD95;
	Tue, 19 May 2026 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PKT2RwJ1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fr93tShP"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C0F2C21C5
	for <stable@vger.kernel.org>; Tue, 19 May 2026 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779163638; cv=none; b=L/qrlMtzw2IBKMjejMRb/C18iYQFZQfMqRku4q4xJePu7mYomQJ+RA5FHyhnuBb/1w/OnzpMoKWqthWqAISUhJwywU0OsqoDPbIAp2Ti9tUl3uaYBVJOK23VFewmtZEudsQkq9xKn4aQf+qE9R+UJ7xkY7aJDA/Vsbg4dJfHsEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779163638; c=relaxed/simple;
	bh=dtwft2ZAn+emgpNWFam/8M0EFSFiw1kKcLaYVRyaKC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUnDkxDfJboTMRb6IdkSGQwPHCrpcY4KoTA03PrvpdOkmAWtDsGO2gkKWBqg6uNQ7i4lykIacYssD3BTp/9xAoFM73X5E6ih8SBneH5sVnfp7HFYu42WRmKGHxtWcmGVsCQ9Ip2nUHRrrt9uHBJzyRw11IvWASnf2Ewo9+mP4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PKT2RwJ1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fr93tShP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ILXXEh2892872
	for <stable@vger.kernel.org>; Tue, 19 May 2026 04:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dtwft2ZAn+e
	mgpNWFam/8M0EFSFiw1kKcLaYVRyaKC8=; b=PKT2RwJ1EDSh07DUg/jgthv571S
	CGJitNzFkNsvVyjc2eF5+yWGiLKSeAP9zC0UtXe4OoNQQqI+n2wz7kztstjFq6Ox
	DUB1PPcumZ8zBXYRjqvRL78Qk633UEBYjbj72DtCCCd+vSEZmHVWPmaBKJPvc/p2
	mO1W3nV87+j3bOXqcaJGlfuixi3K1wYZyMyznxfd7ob5EPd4hGXVV13rqushjwo1
	wh4vFsXktOrMoitQzwyKLHYtxWCB/y7VLeePepUNyPUzX7QnVjpe7g1DnrYmpYmE
	t4KPLxr+GQcVztXzyvr/Xjqro0VQylBjMW11S6VMyT+p4TIE9h/aOQX8mCg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk1c9xe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 19 May 2026 04:07:16 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2f3ec2e8d07so14058404eec.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 21:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779163636; x=1779768436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtwft2ZAn+emgpNWFam/8M0EFSFiw1kKcLaYVRyaKC8=;
        b=fr93tShPSx7YxO4lAeBBcPOz6Q1n+awEAz+ZCsYeUEMNVFFGL2z0z/f2/V90VhQs+P
         4LaWKo33zUIl5tSDD9BnlvnnsG/sGBdhMATnMQiW6qYxKcWxAceMwR71igkhZHOKotEA
         r7hZ39cUzJsZi3vcHTfb4jakao4oYDskP9BtpHIo2YD7YHYqZ+nN3GSIi8m3kCfh5NQY
         w7re6sPTycTjmxhAM65Kug9YRXaPgOs1Kd7O++Ww4ctGD+X+emKPygnZjPxw7ON7WKjz
         wk+elD8gHil+a83iCFJ0A4b8Q4a1yRdkJREAhxNVvMQhKMIWXjVlbaugGWQKqr0N+Flv
         Nxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779163636; x=1779768436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtwft2ZAn+emgpNWFam/8M0EFSFiw1kKcLaYVRyaKC8=;
        b=FAx8iQFfLbMjoX1WcKhuCI8CZyQxOAnL+bH8GuK6zxt51FrGGmNMDUkAb9ClhKuqmY
         tEymDrkR0tpPkmUjEWi/8gP2IFZQy2jou4sSIcrWHpl1fxQ0T/xkiHYgPAXBr2HW2UmK
         FzxvjGvhb0J8FNm3plMEEIt9pNBWKp30PhtTL+HogCwuPVintWAjnGd1x6bowScpLc0E
         phf+Ad/NEYGwnp/NSDpV9E25Vg5yFO8ckIVbXmk2yy8NSYNb/qddiQgOWPoico05F88P
         7SVE5C7GZIic29NjP3NLGmWXzqcwLcK9PS6T6PtxhMr1JPBksEAipmrfZxbu3YpX/5hL
         H3BQ==
X-Forwarded-Encrypted: i=1; AFNElJ8v40TE+RpnwTslJtx0Q2mcsQzLfo+mo3cAQRBxJWsNfHU6G1INZNPstFi8pAanfMgc2h0/u4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBW2dGC88S/WE1yc6U3gk5jZjhmFJt5rBWBB4nRXD2QQSzhkH7
	C7dctGh74c5Jg7OFWTLSbkdWyw/Q0j1t3NzO8eBv29zPo3fVzaPIxl7idAYPAnqyJoMeMMjCv0q
	h/Z0P4MTXbIw36mtz6CfJM8ADa9k3Q8RKRo8i/4aw/YCE7hK9gMl+rNcVNwk=
X-Gm-Gg: Acq92OG8tUS1zgWo9Q0NqoXSHT/HwMDGppD2+E7bTsQHpD/3oV4o0qmK7kXW/YPeica
	XXqOJsynKsB0BIzWCDM0C73L7FIxdSR4FOWofM9fYG7d1EZSxrx99rfMPUnfBBnwSy2fcWntmfC
	+bifr2FFeH0rocON5IB8wyVCEX+nhwNvu/q4WK2Fq5fmhs+NrrF4J2k70HHHhAnz2yIOaW4ufBa
	vEWLkP4hHAbnlmX2nsWVzLnGtmhyvIEmALWouXSFgNgpbVbWKt/9lP/Uogs/SIBgXGqBzimyUjG
	kQiy+XHnq8Hko6nRoyfoxg4JCNev3fKPYBaiNtxO1Z30IB2mvNp7MluKhdtu5aXpnxDrJO1eSS+
	CsG6D+2EDQylX34VNIbGutCcut9XyrUiv84giah9xQINyBveVVrXM5o03MRd2e1IjkXLSFQSkb5
	oijGDkGk0S/g==
X-Received: by 2002:a05:7300:dc03:b0:2f5:5907:3a49 with SMTP id 5a478bee46e88-3039867718cmr8011765eec.30.1779163635610;
        Mon, 18 May 2026 21:07:15 -0700 (PDT)
X-Received: by 2002:a05:7300:dc03:b0:2f5:5907:3a49 with SMTP id 5a478bee46e88-3039867718cmr8011738eec.30.1779163635062;
        Mon, 18 May 2026 21:07:15 -0700 (PDT)
Received: from WOSSA.na.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6e9sm18592694eec.16.2026.05.18.21.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:07:14 -0700 (PDT)
From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
To: imv4bel@gmail.com
Cc: aaron1esau@gmail.com, ben@decadent.org.uk, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, herbert@gondor.apana.org.au,
        horms@kernel.org, jiayuan.chen@linux.dev, kerneljasonxing@gmail.com,
        kuba@kernel.org, kuniyu@google.com, malin89@huawei.com, mhal@rbox.co,
        netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net,
        stable@vger.kernel.org, steffen.klassert@secunet.com,
        sultan@kerneltoast.com, tanjingguo@huawei.com,
        Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v5] net: skbuff: propagate shared-frag marker through frag-transfer helpers
Date: Mon, 18 May 2026 21:02:32 -0700
Message-ID: <20260519040232.1395-1-rajat.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.2.windows.1
In-Reply-To: <ageeJfJHwgzmKXbh@v4bel>
References: <ageeJfJHwgzmKXbh@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: juGOgkRLQH96VKIekb21YTXtRVBRVoMG
X-Proofpoint-ORIG-GUID: juGOgkRLQH96VKIekb21YTXtRVBRVoMG
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0be1f4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=qQm7GNJJ0ztNeIs_msoA:9 a=ZXulRonScM0A:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAzNyBTYWx0ZWRfX4dKJ2hYWyXJT
 3hJlAJc3YjRzVeGyD9nqnqndVbaFGLinHtflFudCJDkn5D4fa7bkiTau4zIIm7/VANA5I+vm11s
 rlTDwX/7Wzwo6zJ3dF6TMB/wHsEyD+s084KYgq/bRHd48k0g0JxvkfyFF5E1b+Fu9+W3jhqnUME
 iaALJIXy9YLiqoOdUwdv4rPKZKBhUUYSoQtSaX6xjisS3eWDAxwPcWu3ebvFFf7WSJLzE27BMRf
 /rN4LDmGUkzUK+2lo44Qg7nmCj123JnaK8E3t3jRzlvmO9p8TM1cgeeDq9afILbA0A1lCXro2cK
 qwBvhQLHnOV2tlheAG/TzvVswNvOV44iT3KxtAuK9nDDmNMkZuYfZi+puRptY+29AjV6bsYC1Ir
 EIVaY5xueD3wizPOTwa81P5f8SrIuX1ql6NFANwdDnofLamfD1jKljQTHEJFtsytO/tFoO8i/HP
 cxu3vjgs7sCETQspSoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190037
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249454-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,davemloft.net,kernel.org,google.com,gondor.apana.org.au,linux.dev,huawei.com,rbox.co,vger.kernel.org,redhat.com,queasysnail.net,secunet.com,kerneltoast.com,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rajat.gupta@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 14D4D5771DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The skb_gro_receive() and skb_shift() fixes look correct -- we
independently reported both to security@kernel.org with working
LPE exploits confirming they are exploitable from unprivileged
user namespaces.

Could you add the following tags when respinning or applying?

Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

Thanks,
Rajat

