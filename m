Return-Path: <stable+bounces-263338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y5yvL10hMGo6OgUAu9opvQ
	(envelope-from <stable+bounces-263338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:59:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384B68801A
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 17:59:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=kxl4yGpH;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Opj+o78+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263338-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263338-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1037308F508
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854803AB27D;
	Mon, 15 Jun 2026 15:50:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70C4071EA
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538619; cv=none; b=okjHWkYtpDjobbrUBs2G5yWU3aK1pphpgMEiehBVVRaY3fozMJulQvwZUz8BqxUFIt0T8gK2xNb8YPgBGPIaAL6MSx8gXr0N0z5g137zgJ9uWcGNx6HvxpgBQVbdRZOPVdI/FjoXutWkx2xYSy0Tks8mKdVax/IK3GoRu8NsZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538619; c=relaxed/simple;
	bh=ISiRgivrUNgXOhGrRFrPfm9qU6CKJwmw7F3QXOx8h3Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RRi+WaKxZ60Ur+TTI5v1CgTIQPjFjDkllyRr0AjGrJZ93IDCEUUHTpFDbzVWqWr2yUPv2Q2T5akb2QRJRd+u46RJS99nABWkkO8Ob/MNEwFoLZpLugVTgGGigNS60XL7P4Zkqa2L/K8IxvhmxJedOeRmAlO/7WPCTt2QGGaP8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kxl4yGpH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Opj+o78+; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFhLYN414024
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hgBdpyflpofnvhZU51hgad
	KfJjYrEnSPY4mzVt1yhrU=; b=kxl4yGpHFV3A7/QIyIfrXxy2i66HFpv7NnoiuD
	QuSP5tJZvg7a8eYfZYBRG3rvM58XzUqs774jovj0HjsS6FTsEtTXD9tZqoazUWPu
	9Lyt6Wq7mIG5DDpVSEzA760mv6Ws3eHfnnURYYE/mta68O1DP872ko1ad56yWThv
	nEsgkJNr0ZfXWzu1YmdJlZSV6Ch+d5JttM4KVP9uvbFDDpMxIy6FOLFrsrBv0NdX
	R5jKn+310f7sTwov3Z+PvHvCvq4WRnVBtHRLNZM+OsZqXw4X834+7KHzXPNxGpnQ
	+11ElaOcJiDKbrOez3gJeJilCNT7yEkst7ocSGXcWGfXTK+w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter01hnh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9157db42dd8so668752285a.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781538616; x=1782143416; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hgBdpyflpofnvhZU51hgadKfJjYrEnSPY4mzVt1yhrU=;
        b=Opj+o78+v0wOppterPAvaqr/GUm1+k+c6H3G+ThDGHKB9CXcG4cp5sroSlI8MPZWaQ
         LzlszCNqesP2BCp1GLVS87oRoZuKCCyVF9dg+Bybuoa6mJ4khBRHgvULsIdrPHwm7ppQ
         bDuKc5JGBtShtbB6MQjw1FqFvEOvV0ALH35ijJVCN4GC07KJ+YB8T4mC6pLmvdGtstrr
         eUZX/mE0g1BGfgm/4drUQLTnTJnSP4tVn4Vrkwsl2ah9q0Hoc/uOUP9qWiTomUJkCT9G
         +6fE3D/nOXGg/8rt0KWg1L/UH4AlU3NLs0gjKMfT463bwmbMcKJlULkrC8ugGj83A1wf
         hF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538616; x=1782143416;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgBdpyflpofnvhZU51hgadKfJjYrEnSPY4mzVt1yhrU=;
        b=csizwWnGQKTPGtiOpc7jgx3i09bW65PWzmg0kebg/pm9Kd5JqAjOkIFRWETBLxS1c0
         SA7AVI2QK9b9GlQiSAUsVA3NP2wNCvRhiuUAHZ69ZAfdatbMfIy331/Uf57GtcC/gYu/
         qnewXjp1Q10TImuV7ocyXjeFsjPt1Kv7TsZrOYiMjfMElqVJEyeIkAXmHmP+wGFaD/CG
         50Fjw2vPbkiEFNjcCEOmR9uAsfVtJxUnPsV4qvNC3/E6pqDy59dOMFDH0zrm8Twt6EzW
         L7JxY79CyPpPjohtilotXrvzEnJjQSgyt/FbMIyLWbCBwuao2CTBepA65BF+SnLN2pJB
         dKmg==
X-Forwarded-Encrypted: i=1; AFNElJ8BhK0FXS65Gi4SNfX7vpVi/H9tB1EZYabTVan3chGdHazcP6CfXMDxtp1vkUeaSnT1nVE9dK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkV2SC9pDf1ZAo0N7ZLZckRf5D+py4wofg9K478asc2kok60Pq
	pMSI4XxQ+QKvGGAXlBmDnqpEBrB3ac5HOXz82Ilm+znqYPbm5PwzIKvl/cFKNB+KvHudcgcu8Rs
	DxWeM0k0iB9/z+TOYZ9rXQXcvFASoLrPf98QAASvH7YdkUKwuPmpUTrbIX6I=
X-Gm-Gg: Acq92OHjy7+NOCkQj7+1zvovYTcNPqh8WsSZhVjSC/13spIorXjD6gNHb0LNVDDBriK
	zW5nPTb730dadldgSVXLX9MbTDoMJhpX5GbV38/f0qXSgK519NoOgrwMu1/62x8+m7iqh6vozs+
	r2TeenarOZB6dU9jwnFcNL43SbeCAk6Jzx7DwTE5WDorDaqKCT2W0+I7XvDq/b52lrkfzckeKXz
	JaHZpKwbOqqk3NrV8q7SIdxARky6KF7SF892Y+QJg3rcZKIW+6k5CxTRJF1IyBrf485npYxqQK7
	lGrEiuoxr5i5hU5mggz8CO5bSzPcBpwelmjn9Z1F0iUosk3d0ilC/0e4ZqXVF6Qr62GYOVYQErD
	W8+6/z5GFPZFrgoj++VwyrOs57jLS4iydEAp4eEF6WGmVYV8Cr4U=
X-Received: by 2002:a05:620a:1a1a:b0:915:1359:fc5f with SMTP id af79cd13be357-917f03a447dmr1728338085a.14.1781538615906;
        Mon, 15 Jun 2026 08:50:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1a:b0:915:1359:fc5f with SMTP id af79cd13be357-917f03a447dmr1728332385a.14.1781538615498;
        Mon, 15 Jun 2026 08:50:15 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:7fe3:eaf0:5a0b:2610])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f450sm38643032f8f.10.2026.06.15.08.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:50:14 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/8] crypto: qce - Fix crypto self-test failures
Date: Mon, 15 Jun 2026 17:49:51 +0200
Message-Id: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB8fMGoC/x2M0QpGUBAGX0V7bevYULyKXIhv2RL/f1ZS8u5OL
 qdm5iZHNDi12U0Rp7ntWwLJMxqXYZvBNiUmCVKHugj8H8FqFztW5QN+OJeNqE4CbaqKUviLSMY
 37frneQHlyoYGZAAAAA==
X-Change-ID: 20260610-qce-fix-self-tests-492ffd2ef955
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2299;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ISiRgivrUNgXOhGrRFrPfm9qU6CKJwmw7F3QXOx8h3Q=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqMB8knXSBoChoC0KUGmOGyvXEwxpwsKvxGgwjs
 H1GtGd1/YOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajAfJAAKCRAFnS7L/zaE
 w/kRD/9lMC0E/LMqNvFfT5gMTbuEpqOs5YKPBoDR60vOhptFBhbGfYbVuIdpYUG3i/wPM6Jvazu
 uHmnXklFdYCGMd9T6VLMzcKpZTbzG5BTayxpX7xfpYRStZUQEKBLNQ/tq4t8iko8E6pdkmM9cgj
 0nYI7iEdwrNxLUo6pbVEpb8Ue+KeboMzJLxS89aEJTeorNvPu2d9myOpbzczDrJ61NVR61Z+dUb
 uo7IvcabJD7tDUD1giN1cJH2DFDi5XURUMiik8RZgntAcx9vN8V/Y3jMxVkz30hsfftzGhovMsI
 pxzVggkw/UDPvFSI+lelg7SxXM5f0zb5jMRCq0H9hEyh60/hXIdhzJSvcjaQ3tOl9I3uSwzDGNU
 h2b5zOhLz3HoxvuXFiUSLELATwmMKrQozztF62rYTHUCJGUmag3jMDskNNYvEH59UNhIK8F/19e
 7g8fODVGqjo31LC0GcxOEUITbLt7D0habQEJv1VVX9tA66Mu2kdCwIfqY7K0+/Xcd0sA/bXQnqd
 QfyrHtA7zcE4ovAjOrnsrS56qJpKE5DfNGt/itMskdn0NZHLYmP3zNUDFaVimgfAcZa0Hpw073p
 KF4SyisQ+cvU7TzpIDSHhyunnzi90nJr3w86n5BrMI5n0bDifGryfJCIa+qahB1CKPKHrg3lLsH
 I8yluytD8zAmIWQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: g5RDuQSGJGr6bUebmpFruZ-Q5k3EOsBw
X-Proofpoint-GUID: g5RDuQSGJGr6bUebmpFruZ-Q5k3EOsBw
X-Authority-Analysis: v=2.4 cv=UPzt2ify c=1 sm=1 tr=0 ts=6a301f38 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=5rERACauPDyaBIpbJ_EA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfXy+JxYP//rl8o
 xiMrGSl0kMLii3cq5BGYbk0VN7QuivVFN2g7ypLgKBQ+pKQBgHXSnqi6+Z0taeZr/EAWZk0TnrW
 b4eISntJFOLT34bfMPXasaOUKiLxNVaVEqdtgSB8jJIhIOwbcwVe3/R8mKJJOWCqHNnEmiGg7j9
 OnifkTEzFMO1NKZeq42MkxubvgxvSpPTQCuvyzhXz6tfVsn4QTgD/QnNvVeAQfIAZPkoYkE+CQd
 F/9Q+SsTruiN0vTCZTGOUv7P1yLGmiCNpOZ7Ulh1m1vAZRW2z9DNhQl4P5b7BUKUJsP4G8Q21jW
 s01FqURR9saF5NcpIioTcJDa9yTkrmn7JcMJUTc8vGjlvsPKnvzEd3C8MLs5NczdAYPEuP5swnk
 dzRxGAzoiz2OcpwgkiwsqK4REhUcUcDYlz24swtDb2oAWU1lilW77ULom7JjrFgpEeHM1ZyaXEe
 h1Q0xXH0AEuN4TKZBpA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfX7np8I/CdrH6r
 uAFoZzhelFt2pXV+BRXkxyjPZ3jEfZAeOCYsH2iso5VDNXEsjUmfU/XRPyPkxow97bEwj47dVm+
 pjafz18SpvTy1ObGVNSqJ3QGbYrT4tU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150167
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263338-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,mm-sol.com,oss.qualcomm.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:svarbanov@mm-sol.com,m:cotequeiroz@gmail.com,m:kuldeep.singh@oss.qualcomm.com,m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:brgl@kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:stable@vger.kernel.org,m:tharagopinath@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7384B68801A

This extends the initial submission from Kuldeep.

The QCE hardware crypto engine has several limitations that cause it to
produce incorrect results or stall on certain inputs. This series fixes
several bugs and adds workaround allowing the deiver to pass crypto
self-tests.

The failures addressed are:

- HMAC self-test failures for empty messages
- AES-XTS returning success on zero-length input (should be -EINVAL)
- AES-CTR: partial final block causes the engine to stall, output IV
  derivation was incorrect
- AES-XTS with key1 == key2 is not supported by the CE
- AES-CCM: partial final block and fragmented payload both stall the
  engine

All fixes were tested on an SM8650 QRD board with
CONFIG_CRYPTO_SELFTESTS=y and CONFIG_CRYPTO_SELFTESTS_FULL=y.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Add fixes for the full suite of crypto self-tests
- Add Fixes and Cc tags
- Link to v1: https://patch.msgid.link/20260610-qce_selftest_fix-v1-0-1b0504783a46@oss.qualcomm.com/

---
Bartosz Golaszewski (6):
      crypto: qce - Remove unsafe/deprecated algorithms
      crypto: qce - Fix HMAC self-test failures for empty messages
      crypto: qce - Reject empty messages for AES-XTS
      crypto: qce - Use a fallback for AES-CTR with a partial final block
      crypto: qce - Use a fallback for CCM with a partial final block
      crypto: qce - Use fallback for CCM with a fragmented payload

Kuldeep Singh (2):
      crypto: qce - Fix CTR-AES for partial block requests
      crypto: qce - Fix xts-aes-qce for weak keys

 drivers/crypto/qce/aead.c     |  72 +++++++++++---------------
 drivers/crypto/qce/cipher.h   |   1 +
 drivers/crypto/qce/common.c   |  27 +++-------
 drivers/crypto/qce/common.h   |   7 +--
 drivers/crypto/qce/regs-v5.h  |   1 -
 drivers/crypto/qce/sha.c      |  93 +++++++++++++++++++++++++++++----
 drivers/crypto/qce/sha.h      |   1 +
 drivers/crypto/qce/skcipher.c | 116 ++++++++++++++----------------------------
 8 files changed, 162 insertions(+), 156 deletions(-)
---
base-commit: 7f5e2941e7dccc9dfaaa23d0548a40039772a284
change-id: 20260610-qce-fix-self-tests-492ffd2ef955

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>


