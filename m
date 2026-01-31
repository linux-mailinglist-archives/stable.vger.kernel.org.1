Return-Path: <stable+bounces-212934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPJzGd2wfWnoTAIAu9opvQ
	(envelope-from <stable+bounces-212934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 08:35:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08869C117B
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 08:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E8E83010D87
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82D32ED2B;
	Sat, 31 Jan 2026 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gZOY13HI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iEsvYsz8"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14682307AD5
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769844946; cv=none; b=hUqqcf5HMtMz0sVYfgJI0Joyd07pUCKYMZcHwU+w3X0W9grWj07fOo71IidIBT4GBxsB6rRc8psT2Fl45XknCdZvdJCfOQc9Bf3yY6d0Ko50awY1Bg+4+7dwtyInUgBGBtzC7h6RY6zdcl4QpLTYo3Rszr1mOVaMGJJhprR3kf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769844946; c=relaxed/simple;
	bh=hvVnxPOrZIbUtHJz7oves9pDbzDR3Que2PqHawVoVZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGStRnvBWq6OT/YvD/dJSal9YqhZidd7SlPo9GHgWGRELl3JxS9X7ffbXZOBxSn8tQtgxUkuwvwUEav3cqFmQ1penVml88g0IYncjU8OKwkTbGDcgoge8eds+6Dng3flnCagAwmCOHv1dX2qgXqwkidhP4kmXLbSfPj0KgmwA34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gZOY13HI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iEsvYsz8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60V4SiG31510045
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 07:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SUqzqLvgto+ebNJM8P3jaMfV
	gKVElHQyD3m2HQJHmkE=; b=gZOY13HIhKlknlRFc9Py5Rje7e39U5LQJNlrToYk
	CXPQ7X6R3U7Fz4kGIZA2tOuFK22bmJXk7ebGs7beGLx/iieBEP6KNBYU2SaJiPB8
	OL9peJSU09SDGH52fQf8OVJxjVyk9G6QXKo5GLWyYNqE5iz5kUlmkT/3hUF372u1
	4Cj3/cA2EUUaMJO74sCgRbj+bHXBtlD34i3kurF22P/e1Z11wKV/Arjo3a+FdVkJ
	qmPflA7Vvjx7wR7lBxd1HbOX86tIgNDi22ja+7+7aqvjnD+bok6tpFeevwhy6y4+
	O+oUg+H48hfnfuWv9t9AH2vbE7CbR83HxnH8ylowRpa+9A==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1ard0d37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 07:35:44 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-5f58f90f83aso8092848137.0
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 23:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769844943; x=1770449743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SUqzqLvgto+ebNJM8P3jaMfVgKVElHQyD3m2HQJHmkE=;
        b=iEsvYsz80K+q5GtHtWHWmFCCekriSgW1/ff0sIjMmbM+G2pYdkVrwHTic4LuIg1JGC
         zP3sLSkHVtextlPsex5+vAAITO657+Eho22Kir0D303gRIx/Gv1SVJeYn2ARgi6+Kn+4
         Ri6pXKePT33wnXIxKY3uFoeH7ua8i/X23F71eSUOAVm1LFJ++8jtWl0zmtpAUa4/IS4y
         HMc6wHY5JME5wJWGJOhukTIhkz4s/QGHsOyFM9hSAq/yOR5kx7KNqN5OyLPVIupA92fn
         YEhgIxhjQNp/3iQclts0jxiQvza0dQRyUa1vjN5Eg8i+kj/qTOOF53CPnANNhXOY9qg3
         H+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769844943; x=1770449743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUqzqLvgto+ebNJM8P3jaMfVgKVElHQyD3m2HQJHmkE=;
        b=RBiedoDq/mjxBY1+jTr5XuVwtetWNZsFZQ04Vjh1Q2dBjklvbILlW0o63auNHp8aIX
         0xAgEv0biJ3Wpp9QYquY4O3K547/bts++0FxxFP6ftz6z2Bx56JxsD5JT9Svt7F42iMY
         NJn6P98IYayNWmNsQ893f8AQrPBa8L7lygDS6EIsT73q3uBXSNiDPfQZSBxryr/SaT0x
         cCOt797uAvZAnoBXZ9S8LlgQLVHYSwOne6FyhxYu+YllOxGkKN2DjWv3jwixcTBD+7IB
         /vP2LCPu9klx60JW5Cio+n/8ToPyQohkFloKSK39tlYL5Z9F32lZnX81XdJH2Dt+RoQ/
         jZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCWrO7cIA/TDloTpGTp6WRaTwIBxJd8UzqFajm5T5qTgc5+cHNAWW90qigR+4ooPK9n5uJf3jNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOtLCNP630xLGwngpZtuMXFX2QGvbKrUPAyruindoanByCqCK
	wPDLrsgM6G0McMzYtwTQkal+TNmMVgwzamAXYR+nX+BGySto0uIuVt/eTq1YGTxJBNU48kr6gez
	pISYeV1oTJ2LXF/LhYUGEVQfZQRchmhh3Qc/P2Dyy25YjXYIHobua5rSsg0hCQ5kG6I0=
X-Gm-Gg: AZuq6aLyExNOWI2QAwfEL0c146iovEWSgRWxQxo3CPLcPPICmC75U3+Geijye1c2Pg9
	pwmYEZhZZgpnNmXTbG0tz7fsZM9u9nd9aP0RQ+kbFUZI5W61SrgQt3XXCpPK6A9vcHTK+gNxu2v
	aSasWydrvBHvXNLkqWT6SOCP8MzaZW3WjZyI6o38nsX3mAFdrZnT3nt8BHT2F6biDv8vLU98jdS
	G7H1HTLTMr89Td9i5gpFq/lBnPQDysusFbDzfAyCwbxDUIBCWfXTr9wkICJazPD8EVeECabgr1t
	ePCBlpGVIkTuSUFSwa6o0EvVyZPcwHZtKyLK/HPfMrDEmkwXWYxBEo3w5Ml5EKdmYvPxZiowi/D
	RerURlRzUA1gxZ/UjGUbD4u3ZsThW3fj8toWvBvYRtquSjns7HwlQpjPdniQXTnH9ifo3nkPWAK
	sEgxB9JnYYP1HcRNWvpcJMDJ4=
X-Received: by 2002:a05:6102:d87:b0:5f5:3c96:983f with SMTP id ada2fe7eead31-5f8e236d78emr1957067137.1.1769844942942;
        Fri, 30 Jan 2026 23:35:42 -0800 (PST)
X-Received: by 2002:a05:6102:d87:b0:5f5:3c96:983f with SMTP id ada2fe7eead31-5f8e236d78emr1957059137.1.1769844942560;
        Fri, 30 Jan 2026 23:35:42 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e074beadcsm2216555e87.95.2026.01.30.23.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 23:35:40 -0800 (PST)
Date: Sat, 31 Jan 2026 09:35:38 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xingjing Deng <micro6947@gmail.com>
Cc: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xingjing Deng <xjdeng@buaa.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v8] misc: fastrpc: check qcom_scm_assign_mem() return in
 rpmsg_probe
Message-ID: <f5p4fdxannhvqmbwj3e45rnoew4vcs5cczlf54honfqpotkxen@4f7hqhexcrin>
References: <20260131065539.2124047-1-xjdeng@buaa.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131065539.2124047-1-xjdeng@buaa.edu.cn>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDA2MSBTYWx0ZWRfX/wnvD8YXYMex
 x613nRrJdmgdbmODlg7OPMn0K7hzM9I2ED0aLx6qJIbKs4yXvHCOPC8CyhWFV7wUCR9nbKLhor+
 5GRMxgNiGSx6TDhqeIgiEnJMBuBrSYR/trlFptw5L3fBG1oG74JsEbkD4KROH5SloMi4NKhlXZ9
 znqnghDwFRPm6CnkKUAnquaGrNmYxsziTmJ1lyyYH0H0mbEi9E11FZ+vE7Fy/vk4494iUGdEKYb
 fh6bNVmWsi607jkw6COOd2XXsjMCl27kDqux04ltESNFWTbgdL+yzgtbXrOckHWpszmRnfZ/hRX
 z5GuY74jt3+v/aCl2faR8rfavL1beF02bwezvzEUHse5My7BOtkN6VUsqz/f2G11KicOrM02zyb
 uS3TMgjn03sJ/5iorFO7oWMqNMS/RogbrDGu7hiFL4FD7rLBRZ+rPTmSvBh7bON+vVJsdiPch8c
 PrkWGqn6vWdOfX3ClFw==
X-Authority-Analysis: v=2.4 cv=J6anLQnS c=1 sm=1 tr=0 ts=697db0d0 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gt7TBnWFjOhXHAj3EKgA:9 a=CjuIK1q_8ugA:10
 a=zZCYzV9kfG8A:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: KZTwFxD5DI4P2gFfF0RNTLMBafw1C_Y8
X-Proofpoint-GUID: KZTwFxD5DI4P2gFfF0RNTLMBafw1C_Y8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601310061
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212934-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,buaa.edu.cn:email,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 08869C117B
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 02:55:39PM +0800, Xingjing Deng wrote:
> In the SDSP probe path, qcom_scm_assign_mem() is used to assign the
> reserved memory to the configured VMIDs, but its return value was not checked.
> 
> Fail the probe if the SCM call fails to avoid continuing with an
> unexpected/incorrect memory permission configuration.
> 
> This issue was found by an in-house analysis workflow that extracts AST-based
> information and runs static checks, with LLM assistance for triage, and was
> confirmed by manual code review.
> No hardware testing was performed.
> 
> Fixes: c3c0363bc72d4 ("misc: fastrpc: support complete DMA pool access to the DSP")
> Cc: stable@vger.kernel.org # 6.11-rc1
> Signed-off-by: Xingjing Deng <xjdeng@buaa.edu.cn>
> ---
> v8:
> - Remove the redundant brace.
> - Link to v7: https://lore.kernel.org/linux-arm-msm/20260129233703.407404-1-xjdeng@buaa.edu.cn/
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

