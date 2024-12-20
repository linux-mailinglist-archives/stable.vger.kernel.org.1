Return-Path: <stable+bounces-105409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620FB9F8F34
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 10:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BC161897650
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 09:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335BC1BD00A;
	Fri, 20 Dec 2024 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LRSy3nJ4"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A91ABEA8
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734687747; cv=none; b=WdFZlK51woNrcYi7e3Ke3j/zHqNo0YyL/hO2HDVsS+uDTatm+1Jqwsqu7Ql+AeZ2/86tpLwMFbM9bC8idFBPLEBCbB50jYw+9vWps2eP173ir7CK82bdcIY3AmNQIpiMnwx755WoYBWsRNWx2GYxpKF38zPmmiV1cjFGghMy7d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734687747; c=relaxed/simple;
	bh=Srb/IMApP0AmNywP55aONUjmWy3LzpeEFQ6056YKF3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TCeP6L4trwlaSlDPWZuK98udkTOz4egCBxdoaZUP4mUH1RKW2vWJeb6C2wsZblQ+ReT1EY6iZ2ZRmJ+YNj/zFSfZ0qPDl1xGn2cpIGMsfF5crL6EiI1YjHb+prmwTIKzznUmOTT2AEWDH2gTSBAa3lGK3sOvINFbp2+Zrx+q9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LRSy3nJ4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK7Li6b029674
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Srb/IMApP0AmNywP55aONUjmWy3LzpeEFQ6056YKF3E=; b=LRSy3nJ47eVv1x/r
	RYcMFHq4QDGUTLr91PB1Tcx3UhnVVQhxqaLKe6bKqNPkQC7zSaiVo9njvksGR3PV
	Ec9SYzXUZZdG96+N5E6l6hrMTpC107YsVG220PXuPtxxvuNz77sCZlBMLq3cTwpB
	saQEH4ilPtHjz1fQ8WslLvjLeEI/fu0PA5l3XcAD5OWJkTbREtz9wWS73kFCjlh4
	kYXXAVyJ5wBNLGmXCVbxFyUKrMjev2dGIiFfvkwK9F5MdEaMqO06Vzjot/gZcGvo
	g5PSkuZazzLAZ+3cK5QnKLcAGCADdtUI/h8JSNXbXwLTaslaDB0yXr/zaD6Vxjyo
	ayRuOQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43n44fgdgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:42:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d8f15481bbso5069506d6.1
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 01:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734687743; x=1735292543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Srb/IMApP0AmNywP55aONUjmWy3LzpeEFQ6056YKF3E=;
        b=wmPAXAWtkU8zz7M482+R8P+7M3jjKwoJm+pfucE76vNBk105qFa4eNY6Qb1drYbPkM
         eWPepSch7a0ThZnPqQ2xnh9Jcl/ALc06N1QmNA1KxBwLE6LYeQ9GRaWgHAM2kfUIAe0V
         CvgYZA1BuNVEDP0X8g95XGkQ4JFg7e57PCMt7DaXI7UgvrqANyqKels7GUfutOCu8sSV
         S04A3w5F8WOqy4TOg6H0+Qu1mpDQciiQe6MhcQJC6HQeUpv5dAQ8LsvZpcDoxnkbFrDH
         LbToErp/jvMJFG2IhNJ9SBFgeZbXn64Y3rCJXjOOHi/G1va+V5P+92cW4wpkz2w4sFYE
         CISA==
X-Forwarded-Encrypted: i=1; AJvYcCWwdCSWE1BzaqdeaA9WGZMKU70Ml0WHbnzdBCbw0SsWDz0y/kI3eq7VYVeXfyMr8ldacmdogmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoI7TZGvv4Tz33dL/m1MOlsaGFDS8vyoMrXQy7ow5ry3xqqYek
	w+F56xFmNDklDaiTfr4Qz+oKZvasy5nY9OCtOhfacUv7ySLhi4CulWwXNTbquWMIyAqmjAAoLR1
	Oh5dfuCFpMuJXlyA66+F1ixEuUeyzgHzZ+6panFqxFxLh8ErJZDMK8Ac=
X-Gm-Gg: ASbGnctmxeJ4bW/SGWsgjrXiJVFLIAzS5EJok4Poff1vz6dSbrXNvU/Iuhk9bWDQ9Mm
	wnEsz1vSm1qGIMChufTA8P3f2xlvS5cXdwx39+r/rjS5MV2viEplqcXz+Dwp16skr4+O5i2e94n
	agX7UMvW+9ALnch7Fy0SY5hANWWmtq+wSpAyTz7/qubc7XWTU3Wfz0SRI8gsdH5baoeOGCFK5/D
	qDkrwLfmtUxcYaFnupovLskBfKyKWjgJzTmiuARxL5tSDhbrti1cc1wkS47GqzHG1nwEbQK02vH
	dbjazCeTg8SrPKg7PhL0km/S+QEL1F4j2Gk=
X-Received: by 2002:ac8:7f14:0:b0:464:af83:ba34 with SMTP id d75a77b69052e-46a4a989db9mr14370641cf.10.1734687743642;
        Fri, 20 Dec 2024 01:42:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtVFYoZr8OVyUkQYL9m/mvQSFGgdGO3w4czfWfr5Bk2uAOQJsU+lMK0vdweVrYuEj46G9JVA==
X-Received: by 2002:ac8:7f14:0:b0:464:af83:ba34 with SMTP id d75a77b69052e-46a4a989db9mr14370531cf.10.1734687743313;
        Fri, 20 Dec 2024 01:42:23 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a41esm1545415a12.1.2024.12.20.01.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 01:42:22 -0800 (PST)
Message-ID: <d9309db7-e208-4dbe-b408-e637566ece4c@oss.qualcomm.com>
Date: Fri, 20 Dec 2024 10:42:20 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] clk: qcom: dispcc-sm6350: Add missing parent_map for
 a clock
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241220-sm6350-parent_map-v1-0-64f3d04cb2eb@fairphone.com>
 <20241220-sm6350-parent_map-v1-2-64f3d04cb2eb@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241220-sm6350-parent_map-v1-2-64f3d04cb2eb@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 9b12WV19mdDCIQ3ofj7OqkUpxSHKjy--
X-Proofpoint-ORIG-GUID: 9b12WV19mdDCIQ3ofj7OqkUpxSHKjy--
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=784 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200080

On 20.12.2024 10:03 AM, Luca Weiss wrote:
> If a clk_rcg2 has a parent, it should also have parent_map defined,
> otherwise we'll get a NULL pointer dereference when calling clk_set_rate
> like the following:

Same as patch 1

Konrad

