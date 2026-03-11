Return-Path: <stable+bounces-224624-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK04ESvIsGk8nAIAu9opvQ
	(envelope-from <stable+bounces-224624-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:40:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC65725A71C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 02:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C74B3145721
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 01:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FDC36EA82;
	Wed, 11 Mar 2026 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RkAkIWNH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QJaYViwR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7837D28D830
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773193254; cv=none; b=S0XVr980l+mWPzpwNj52hcLAvsDWRDv8Efv56N5KQLOkdcg4UNKqLTXvrcafeSiiqeXWi1NXTzfSm5fut2C1mcmp733v9qMGncNXU0c9pC3Th2uQAInphU/xT3ESt82q009CnNWE1hD2V9ayzJw+f/dzpz8EDrC6q6VJooUVSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773193254; c=relaxed/simple;
	bh=vCiAKWhCgsidC7oek9Ay9QTc4sCKED8hU7eeL5sj4jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hq6zKkf08lr/UqqGY027IUCRcqMLv0wwQKwcWhGFMJB2PDVNtE2AZyUVL5Q4kFi3Mq8FMbOGqcQgySFpiBfktsTngG12aW2fMHy7cdBoVQnCrOyI+rse5F9qDbCEztXyZ7hYEeRhOeQURlJ6hF+Y0cy9SdOR7lHg84lVDDFghHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RkAkIWNH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QJaYViwR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHcnrx2179276
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Udn45LWFERaEd0YZfIKTTQo5
	P/rO0L2SyvgS5xb5cQk=; b=RkAkIWNHggzFlCsmUHBWOtt0Fg5XOY8XPhTqjKQn
	TCfnuInl1Dqk1FOxv77nzqCcyXKdlNbvDbynoOVOjGpkTO0KEUScG5AkjiAMIuHr
	MIxKE5Qf4ldLo3p1k5p6xFmy/Rk5EPLTMjKz4pK4OFYxGXfvvxeteY6MaS39GQ9t
	XoA0LccKZYAl9p2hqJoLtvecrV9o1qJyQlqST6dNqLaAIYn3aEbYzPNmpzoUaBjs
	/hEXnJ0FnT6XnrhIaS0IunDfkT7wYTudN7wNPh1zjuQ9E9EbsvDl+UXHGA6L8Hjh
	J3YYTMwC2AGY2l+Ynp1taxOLUJ8TE7zZrPSst+x8VqoxnQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvssd2u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 11 Mar 2026 01:40:52 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5ffa63f874aso43312590137.0
        for <stable@vger.kernel.org>; Tue, 10 Mar 2026 18:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773193252; x=1773798052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Udn45LWFERaEd0YZfIKTTQo5P/rO0L2SyvgS5xb5cQk=;
        b=QJaYViwR2jWpBak0+cMybVGtjU2viiplTApMwRMJj0eX+WAv81JYgQmzbzb3muvKH7
         7pR2oGNZVMv/Ll23reZKOKFgw+XyUUEDHEalI2fb+k56Dzmm3QaxUN8Iadtw/8wj7CRt
         FqZdUSNd7Cqe52ssnh2+gYSvVp22VXzLQMeGLFuvhmhiRSubbW4m31pSy2sryNG+VWE1
         DNqrFcqf1IAG/Zqfm/hj+6/awjBqfazJKnk4l1YqBdN+3C9ApBJWO6MKZsn8KicfMNYm
         +rb0HQgzCqbG4Q3uGqJwEcbha3s4cXFAvEzfqEQ6zW9z5196o7ogcFBXj72ql2RQrgcT
         Q63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773193252; x=1773798052;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Udn45LWFERaEd0YZfIKTTQo5P/rO0L2SyvgS5xb5cQk=;
        b=vv5h4OWYTErpOL33x9JgHe2Rpq2sl/wZnt2blY7X5EujT80LUqxa7Wl7DSgtEWCJcK
         xRIPmJVcrEmk+C5G8XBP1799ZME50gyVk62m0C/syoBI1tXqp29bK/zYEBDcmqjhDNFW
         6NfLgEXf+aeTL5xJCtN/xxeVlEoLOx9+7/BxymUIgq1553IPjQhQHJzNz1XNYhQrTxTk
         lgIXn+aeeqPyyw5VIyJpSVFn7hUPIgbRoVQ80PZkymCBaoelja8h6xZTMa+0p/W2wnbu
         zI+VjJkKkP3eO2V2wlCWgcekZvbsxh/IDquXLKhkFN602UiZ7zT89Pgkd5Ih9AVc4ulf
         NpFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWez7ylm8fPuk2RkpJCcNrMbEm2A1fxytWBoYFgRG3dPrgvREMB/TIt1hMd6DfyB6psHsEZ1LA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpNtuSd0vC22gGBPwEQhrOsj3a3BMMRzTfYVzYftuw4Ez/fFp0
	rsPWSMI3f/vcqUzEyc6OAgY5h5/tBZPE4C70Nf8xqNhxd4PNf8cGrW2MXkGQNgYbdfTHp15QSaX
	0c9Pf4X1AECSCQOjrzVCj4HqFiY+7bNt5xSZznG1H4KlbXkvQtNZAqK4995o=
X-Gm-Gg: ATEYQzz0ybNDVC3dWY4e0J+y5zq14Zfi1b3dJGJPqHlsLOEwu/WvKtKchSoCGclOM59
	4nBnHTyrwdUcb4BAb+tGq5YpScHdZI2rTLUtGD5GT8vUliiXApn397EVUF37v3nuTznYgEMni3M
	N0HX5N4nGOWp84JUUG+/gHrd3KVA4s49UqusZWFPiF1rLZGUxR6X/RqcPHjhP4zH2dKM7Kxtr3M
	4+cGf1449wic7WVJyYE+jzXXxmW8QfTYkBkU8zGf0OFP1U4rNFgl3RvZiN+1+wnWcUdA7bS11Id
	AOKN5z0shdIjlJgOcCeFUqnRlgSHCzQ2uLDz3ejvWpsbobQqX5Nj6j0hu/zFNcR+OJSjL0hysbK
	D1lAX8q0w1lDjfDvvfxc2vz1t1juVx1nf2lNUykZDmffRWQyZZgXuxQjJqqB6m4P4zgDHFwJAVO
	T20HLsCdEnOENzpjF0/vlUA7HQ9Es9c6b6NJw=
X-Received: by 2002:a05:6102:5113:b0:5ff:fbe4:8a8 with SMTP id ada2fe7eead31-601def30c8bmr363079137.25.1773193251735;
        Tue, 10 Mar 2026 18:40:51 -0700 (PDT)
X-Received: by 2002:a05:6102:5113:b0:5ff:fbe4:8a8 with SMTP id ada2fe7eead31-601def30c8bmr363067137.25.1773193251329;
        Tue, 10 Mar 2026 18:40:51 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a67e5ec94sm1001861fa.22.2026.03.10.18.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 18:40:49 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:40:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 0/7] slimbus: qcom-ngd-ctrl: Fix some race conditions and
 deadlocks
Message-ID: <noodhyin3en2l5xravmt5l6dslcz74na5akin24zod2zhmsevo@pqtxi5ydbidx>
References: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-slim-ngd-dev-v1-0-5843e3ed62a3@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxMiBTYWx0ZWRfX+3wAVyWmNylG
 yPNtJH2r9f7Qo4GR/DVSAS1SciZ59FXqDZ6VAfPZArRxGfqvwqbwVH3t2wBIAkw53Pqv30hMr1m
 OIx0641j3FGQI6Nl3tZJIj/GNQyAgImohJE4EpQwVWferNawCvN2e/k7zJA5w+mIORsk8QckX7L
 sG7x9+g3/5g089UeBl8GBNMUKIAdrKmsw+GQFu/W7yjbmhMQNdRtnHY/YhVG1dOsgJSwm9dWQIG
 yVohBF5w+ySEEJhaRXtPDgdSpN0AM9v1awv7JVTwibPyOwR6otMy82wwNgjPUoJQ3sp+R/nw6B9
 dtbiGLZ6QzBkqI2p5c4sfJe90LRqzJ7ujy7l/HuTlJw+D+Mg9JLMiSyfplfK9ftkxtyUDQ8TDF3
 FRQoLWukcFzju4ldaUgiDKxSb3rT5h2XEHU+36rDVHQr+FgYHvFOlBP8+bHo+Wze/lnaA6EQMDm
 4qbVfHZ5PXogod/1pFA==
X-Proofpoint-ORIG-GUID: _JhSC4dIpTa80dxJdUken1UH1swhtwOX
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b0c824 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=yjtLm6vEFEQHtkmbwRkA:9 a=CjuIK1q_8ugA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: _JhSC4dIpTa80dxJdUken1UH1swhtwOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110012
X-Rspamd-Queue-Id: AC65725A71C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224624-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:09:01PM -0500, Bjorn Andersson wrote:
> When the qcom-ngd-ctrl driver is probed after the ADSP remoteproc, the
> SSR notifier will fire immediately, which results in
> qcom_slim_ngd_ssr_pdr_notify() attempting to schedule_work() on an
> unitialized work_struct.
> 
> The concrete result of this is that my db845c/RB3 now fails to boot 100%
> of the time.
> 
> In reviewing the problematic code, a few other problems where
> discovered, such that platform_driver_unregister() is used to unregister
> the child device.
> 
> Lastly, with the db845c booting, it was determined that attempting to
> stop the ADSP remoteproc causes the slimbus driver to deadlock.
> 
> Note that while this solves the problems described above, and unblock
> boot as well as restart of the remoteproc, this stack needs more love.
> 
> Upon tearing down the slimbus controller (when the ADSP goes down), the
> slimbus devices attempts to access their slimbus devices - which is
> prevented by the controller being runtime suspended. This results in a
> wall of errors in the log, about failing transactions.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
> Bjorn Andersson (7):
>       slimbus: qcom-ngd-ctrl: Fix up platform_driver registration
>       slimbus: qcom-ngd-ctrl: Fix probe error path ordering
>       slimbus: qcom-ngd-ctrl: Correct PDR and SSR cleanup ownership
>       slimbus: qcom-ngd-ctrl: Register callbacks after creating the ngd
>       slimbus: qcom-ngd-ctrl: Initialize controller resources in controller
>       slimbus: qcom-ngd-ctrl: Balance pm_runtime enablement for NGD
>       slimbus: qcom-ngd-ctrl: Avoid ABBA on tx_lock/ctrl->lock
> 
>  drivers/slimbus/qcom-ngd-ctrl.c | 127 +++++++++++++++++++++++++---------------
>  1 file changed, 80 insertions(+), 47 deletions(-)
> ---
> base-commit: a0ae2a256046c0c5d3778d1a194ff2e171f16e5f
> change-id: 20260211-slim-ngd-dev-74166f29f035
> 
> Best regards,
> -- 
> Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

Bjorn,

While you are at it, it looks like there is another possible issue:
ngd->base is set after platform_device_add(), possibly letting NGD
driver to use uninitialized base.

-- 
With best wishes
Dmitry

