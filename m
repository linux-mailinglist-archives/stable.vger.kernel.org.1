Return-Path: <stable+bounces-247401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKjjFPa/BmqMnQIAu9opvQ
	(envelope-from <stable+bounces-247401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:40:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1444454A120
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EBD0304F034
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024FD383C6F;
	Fri, 15 May 2026 06:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gh5kY4th";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NHMYkBkS"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36D3803E0
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827221; cv=none; b=Q2y6jET8a4vHR/R0emlAP3gzZnVAz7VLdB3mA2jZsfAI1nRhLTCeaUZVxv4m0tk6iQXS+33OrFSdtml7qs0vdr2LcZ4RkLhm8MeIqo3+vPiv6FgP9C8/MQmr2wHlr6J4mSOCNbYxf5RSxtV49WIjRlaxHl5T4hcpIEudJFEJVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827221; c=relaxed/simple;
	bh=Q0fR+h+Ny0trHoJYIyqcs81BVJuRY9SId0Fq0KRsxkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEMSdn59pV4t6RJ3H4m0ZGSDml7J4XVOJZSwD7dpc53gUXn+sXAMYkq34mbP6wotmON/sPBiaspEUe2VTyw+/HPijbjFJw4Mk6oi1auVR/JJ6bN3iQXNci8GfEokjY8FcCR8R35vYoWNu6UFZhQBBTqdrSv2+MOsAlpVAF7gw24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gh5kY4th; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NHMYkBkS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5USYU3198357
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GaiA6uNOJPCPDvEvr38gVo7es41f1RVtqIB66QY5CDQ=; b=Gh5kY4thgyjLnnH5
	u7sikvnlHnCPBmEf9Dzyskw9qwVVuDlL956K/pD6UBldN3c2UMhw46RrshvPqLkJ
	iNQbPhF+q4HZDOs3hUljWAXpTdnb1lcxW+1Sj3UdB8JUHrrKWLl8RDvUWJZRR+Z5
	xfX+IQnXHH7k58LvIbvnuhGjjeKkMLQVawn7eFm8pOGtABKIBc43C0F7FDp0K1cd
	AddqmGdJwJpWh17TlpgvnN3j/m0fsrGTE6lucJx+W0dp4+jwIUbsSQt1yW1rRjnq
	l5O+3wO4IcFOcwsRzZxT+N6fBhU/g2Zw+HWZJezY//dQ5IRfFEhhn1NMdwhqyPUm
	VPD5Vw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1q9xh2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:40:19 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8386367b23cso6939801b3a.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778827219; x=1779432019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GaiA6uNOJPCPDvEvr38gVo7es41f1RVtqIB66QY5CDQ=;
        b=NHMYkBkSY4dp4AxaDxLC1jVwwYluzpGGO4w2hLWRlZ0lhnmYiG2CaLjYgozRnr9lbP
         2SMvVj7CSqkJNX/DZF+HORM7DFCv8yGDPXw3TvlNXSjx7whZk1/F8NM1iRlTW2vDQ8vj
         JFTBZ4ooFYKouwn4Bj/oactZ38XwP2YkH1A663NLY5C+dUnt5CXlAi+oXHzIcuakxZZg
         IYrhSWJ0w9z4g0ySqYihCf5WxKHPryPGwe4TB+jhFcd3AV6DW7FWHlWlVvpFQhWFnOtv
         S4nrS5r2GB8rBv2haZL6Z0GkSBmdrI222CcL68nuvLVFtsWjSmFpI/TshCDKdN7vIkOT
         qX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778827219; x=1779432019;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaiA6uNOJPCPDvEvr38gVo7es41f1RVtqIB66QY5CDQ=;
        b=dTARKsF9tnCe3BvmsSiK0/nO3EMjKbrd4VpS+onwk/hCHG69KsvpnSucsvotzeaJGx
         nV1zMtIbAQNLhWKTYAycJ9FitdJFSUSvqLRVnmVcFBDuzMCt/9oLcfxmqVvUqr8b3UaS
         QU5lM/6oJ07gB5p32TIDeyghAISHHR9nghAXbLR5klnj5sronn8iPwtSU20zVUN2h9Y7
         qZ8fP1d/5FdmZe6e73cxEpxhaOTLU0LHgpqFOxPwzbi6QDxfCuCMtevTjL9ArnkUb+LS
         QIrytlkwLTyENqCyTLIxVzYr2/f7AkNizurZxgEQPsMt7efs8CWiNDvMCqkZ03K1Qz2j
         WCkw==
X-Forwarded-Encrypted: i=1; AFNElJ+YksfuF1Ut0F1Ae9D31AUwH6SXeKmmdkyc7iPnDtrz+Z+ZztoV+aBLlHrCN1LExi27f4h8iWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhF7ikzJ/iod864Tl/HaFwTm1zOklyRzhDg6awhMdtf5aOttZb
	TFbodx3fcYEJ/tSoW8hjfrQgKG2H8/a9kBq9UtAShuiA71lzEuEeqOFjnU6/e/ekaQRHvGQcKeO
	ha4S9EQmqXG8hmE4HTc5u3N6IoEROkvaDDt+3KVRVDBRxgmf50aEH1/y91xw=
X-Gm-Gg: Acq92OFrwIe8w1glMVdiVwVBFCx4AlOKw/IfNKiJvVTF/pUO14H/JzTP/B5ibYb0SdC
	p3VQmVeLiwhTvHko9AkB95nqynVCJfeTIGhW0zcrAuVe8KfpMDYGUocvXOIWtw3KhzV9Zcjsvoq
	9mtEhxPK4DnX/MLWYL63ceoJeWFZW4yMFSOp+d3Y72CPf9e8NGFp9k37CwwIaBM8WgHLDR3XuYl
	QvJQtga6gPJY8wE7znei89Ynm0Z8mury6YcpihN/u46B4bghqdZqSy7me9+iEmdilaRvNtfaGqj
	h33KF9cAxKhBOEtJFuO3yL1Caa0KwbvXnIbGWUQ+euasvO3hdA0n6pr/D6kbzEQelnUOFL33H5Y
	8QFJfdAZA0CRGtEApWLNkKs+TlynsD6BQDd/k99rDohOpNpAtd2RWH3ihu1DCS8Xsd0lZHAb8++
	DwPNB96e5UfeyCycSbsw==
X-Received: by 2002:a05:6a00:32cd:b0:83f:250d:5ab with SMTP id d2e1a72fcca58-83f33bc8888mr3191653b3a.7.1778827218608;
        Thu, 14 May 2026 23:40:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:32cd:b0:83f:250d:5ab with SMTP id d2e1a72fcca58-83f33bc8888mr3191629b3a.7.1778827218116;
        Thu, 14 May 2026 23:40:18 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1979a0b2sm4965276b3a.26.2026.05.14.23.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 23:40:17 -0700 (PDT)
Message-ID: <a587a83a-8b72-4e93-8050-654932cdffea@oss.qualcomm.com>
Date: Fri, 15 May 2026 14:40:14 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix warning when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260420110130.509670-1-jtornosm@redhat.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260420110130.509670-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Vj48hg8CACct31fIPYTir2w-nNixvJ1a
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a06bfd3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=qhnAyV4-s4WfS2nNwg8A:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDA2NCBTYWx0ZWRfX7XU02YwD2rXW
 BTkK1uAHtkiK1D7aCgPnbRgoP1LGMbVjcBn/Cxqx97+fR2MGw1Il3juHlF3ZrSRgkLzc67WI4br
 czEo6Mpfw4eKRjWZxs4K8CzIkZggs34SvZhWq/F2+znfkNcdw3vLn7o1kXArLYPLqso2L8lRSvD
 XwEdAo4ZuprM1JsOdGCTPt8oMDQzU+Qa7kN7m498NkcCllcmuoAswul1YJS2r/7Rnxr/DnogHXE
 Pjpx2j6pqztLH0erA1Wez6HPZmopUlrgtDCXyMlBwM4ZGbyG7xMj/SinnRVcSqmEcqLGcwH+EnU
 RUNnU4NVWWsJAoYx+E/CpOZNpsTnpm9rrQ/cARSU3OIBLsOJ4Qyr0WPNpGLooZ5Q2Dwme4VJMmv
 UsXvrn8t0Rjpa1c8tbJzIvZFLNSUJvTkHJtc+fu4RnHexf4mvThBrEN4F0mh5BMZv+tewbD7YPM
 faJ9w+P5ljhTQrIeU5w==
X-Proofpoint-ORIG-GUID: Vj48hg8CACct31fIPYTir2w-nNixvJ1a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150064
X-Rspamd-Queue-Id: 1444454A120
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-247401-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 4/20/2026 7:01 PM, Jose Ignacio Tornos Martinez wrote:
> If there is an error during some initialization related to firmware,
> the buffers dp->tx_ring[i].tx_status are released.
> However this is released again when the device is unbinded (ath11k_pci),
> and we get:
> WARNING: CPU: 0 PID: 6231 at mm/slub.c:4368 free_large_kmalloc+0x57/0x90
> Call Trace:
> free_large_kmalloc
> ath11k_dp_free
> ath11k_core_deinit
> ath11k_pci_remove
> ...
> 
> The issue is always reproducible from a VM because the MSI addressing
> initialization is failing.
> 
> In order to fix the issue, just set the buffers to NULL after releasing in
> order to avoid the double free.
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


