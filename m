Return-Path: <stable+bounces-211976-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCtFLh0demlS2QEAu9opvQ
	(envelope-from <stable+bounces-211976-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:28:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAF4A2C57
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 021453017FD6
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 14:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5BE274FF5;
	Wed, 28 Jan 2026 14:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hCXhy1SD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KHqQN+Px"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844CC27FD72
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610328; cv=none; b=B2hlHV6i9TT3QlVfEXVTrqtJ4eRz/QuVEYEjvmJfIZhXz/R71K9FdDUIKuLobijL/L8151VpoKD6WQng+uNaxhthvCzxaHTGUcKh2zOoWkTDUMDTgeuiUsZArkivfl6tYClOn1kVAFfLgPcMmvYt4zoYRnFWgPw88H0lPFy+TOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610328; c=relaxed/simple;
	bh=7V4HQtOkz41OGOFquTkbM425i1iovXA+x8PQcHz4N/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcjD8zgLjXGe55piM8aE2D58lN05Uz44jjyA2f/izFOxn9Q56pkXWI5WC6vE+F5U8p01rPg0QJTOWNafCDXaFovXT43zUWjPTfMei00mliWHJMAmXUTKIFSUKo70Vdymy+RraScJxNSKUVW+iox5wsQa8IrvO2x2/A7WV3hNKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hCXhy1SD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KHqQN+Px; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S92WFi4008386
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 14:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X5hgkW2bSVd1Mx/8GXAEHEQ6N+Ima9Z/9XSmGYMt1Sg=; b=hCXhy1SDlREu5KTS
	DY0AC2WBr6KGlU3qoDmBl8xd+NwGGUkwyBmn72W9mttx4QSUhIqdsu+mYRODo+RA
	9zbA+YGE2pSnl2oitkNpclRNMuXO7uSs2MwEDUDvZF2brNV3lBm5fCBBvVHWPw10
	iHE3cIXoYgMPfsYyjbCNgZftnz0C8gzuPmnS0U6pk5kDJNzMzGopB4kKjQ/FqBUB
	D2QQpCA1DxOACMG5IE4Degfs+f+JxUf8hOYeL8bYCxHzTNCaoJqHfavINtsOReA9
	ekoJLViQbTHqjalxHtxjj2W5q3ikLkC9Nl9jO0qxmZfm4fi/DSUOmhqg6I9TfYr5
	J7P14g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by1jx3uxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 14:25:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c5e166fb75so1760346785a.0
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 06:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769610325; x=1770215125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X5hgkW2bSVd1Mx/8GXAEHEQ6N+Ima9Z/9XSmGYMt1Sg=;
        b=KHqQN+PxNGM+bUcsvhi2Kp3e67ff+yhYP+1O1IRx5SxI7rpRzqjLewuJAIhFRhpOQF
         Un8H2k/MyJ0ScT5VJ5I5M1fU6iXMkn5/tu1zb4f5CpFlQYAs6lo75636COJJKrgJBaGA
         AJbA5x+StWWPtSfLZKs34yGiyB81fZiN08/wGtN3NRKxSNnEFWnXpiIpD1270/yx7emH
         7eNLJsp4AulwTZdpzh2k2DPFT8NXAGCHRY6efqmvIMuHU9Tks8T7iVWeTvoN2mL4bFfm
         DmFk7TPaZI+/ds5ql/L3c+mExB+Z6TSA+RBOTXByGkTCaKTlHmQbQ2trkxt8Gt28zpcx
         Mf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769610325; x=1770215125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X5hgkW2bSVd1Mx/8GXAEHEQ6N+Ima9Z/9XSmGYMt1Sg=;
        b=QYaLKvXhvl1d0BiGhZ1yrwEildE9Gvdjce5zKIewJQ0Wd9NohrNkGOcai3GRln//Xq
         O2cdW/Qxqms40I7xK4hhM1n/48hsD8R0VKgkHK8D0J0RgggeoTNSCjRjWba69O0J0a9v
         gHxxzyNEsxX0cfi/+MeGojd5pkwUkivV1X8aVS5+I/RwrXuO8LoLVRA2p8AigH5fjWCE
         +yy/df/7jGlOmQGtc1037NhWvmUNB4pIu69pKKItrOzpGVOqGg8FXzaRzcddvlGDRXnh
         OU6hjR67KbelUZktCBcHJG8/6k+CqXwLtHeYC5lB1fuzsdztPdjD+MH1AbP2FayMKrAR
         pTNg==
X-Forwarded-Encrypted: i=1; AJvYcCUko6N0Xx2haaewJvrUtP9jxRMGdgdV1KpHQ37LOL+XlxiRGwjTC5IxBihm1SALgIAGOVVWaZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWmj3uiAcZZb/pGMne9IemZrpX1cCEC/pcP1bi8kzEqY/Mrb9W
	vnjGC4KCXoYhJx95jJqjRGxi/vqWY7tAmoU9a6ac/KHjtuM7f7G1E+HjqweKMR92+XZOrFWBUl5
	tS7H24xOKw8lBsaVy94meG6N3YU38dpLo7gluq4qkNoDzuTg2l49Ov/z7tMg=
X-Gm-Gg: AZuq6aJlKNzGi2LMOKkiegFA5Dd3QPMCo6wFcl8ILkacl6Gl5f5q29YOe3sQ6/NrPaU
	U0waDa4chOnc6xy5QFLlfav1GkpL4F943ynL9UCdbsCvO1f4Ka7MV547+W/ctqqV2ZT3PwCrHIt
	I+POHoKZPLc0e+TZXtILP2duj2X26lo1H0OCPd55F+FDRHFUrYwBJ4UbRDS9nOQPKB8umNlqlEa
	Jhe5QWVQ9qpfo5ikfTFc0uPpoqBpViLojnozYvw+SdP+rBYgzU06KiePnedJ3Mink3gvoJg16+U
	ZUPVeqsj9bxeIPfjeGvo+JkRKVtSTFKlT6pOnDMY0LzI3ovKc7hTK6OicuY/2TqtyrGteJ0HyP7
	9s2yvF5ZtiqIqAzXR2uZSNS2N3+/Zm2lZ21HDuQ==
X-Received: by 2002:a05:620a:1a90:b0:8c6:a628:8608 with SMTP id af79cd13be357-8c70b8215dbmr626348085a.6.1769610324742;
        Wed, 28 Jan 2026 06:25:24 -0800 (PST)
X-Received: by 2002:a05:620a:1a90:b0:8c6:a628:8608 with SMTP id af79cd13be357-8c70b8215dbmr626345885a.6.1769610324311;
        Wed, 28 Jan 2026 06:25:24 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:944b:d841:b24c:3a72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce5ec6bsm75827575e9.15.2026.01.28.06.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 06:25:23 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Mika Westerberg <westeri@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/1] gpiolib: acpi: Fix potential out-of-boundary left shift
Date: Wed, 28 Jan 2026 15:25:22 +0100
Message-ID: <176961025524.87868.1711246943742090995.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128095918.4157491-1-andriy.shevchenko@linux.intel.com>
References: <20260128095918.4157491-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UjvebuP_2v1F1F7tle0ILDXQpP8rXf5O
X-Authority-Analysis: v=2.4 cv=duPWylg4 c=1 sm=1 tr=0 ts=697a1c56 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=PYnRuAIEoPxac9fn36YA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDExOSBTYWx0ZWRfX7RI0iwTFGxne
 GCHxfNLwEaZPDlFM/yyUDXc3RCTEl2PalozY954UKX4zbQ4+Jmvl2HWk+uQ1If7O0t42Ge1AuEj
 DcruE8IqjRiaWbrfNFTD5gsQgIsJdYa0KGt1RcrrNtkKSO1daVqlc4QIOH9MkZ39VPgn2jAN+t8
 PeOUWIE0caWQ+cbBMS1GSWX5xQ+Pm7KaBt7oSCnlDj15oa0e3typo6CUpeW7i2XxLIQx5hCGIL1
 /6hHlFM/rMmcpWQqSGV1vSS8lBfWNQ7afaXV6KTss1rhzIsBDPIZdsBv1VzIpMcB412Lh9Nvhkd
 XDlgoQkmcn1OIYzIwTNlb2uKdrnjPVx+Uzd9Nuj7vWhxAoie2VDXL8HIYt2a1ByoHELOYq+O7Ce
 fgneGHwC1WR86igqKIreHCMA1Xaods1aHYX5uRWVHY+jwic1nXx0vChSSCdPyGfMVihyZDMkflE
 hRRrvsj1i77P4WCeZGw==
X-Proofpoint-GUID: UjvebuP_2v1F1F7tle0ILDXQpP8rXf5O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280119
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211976-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2CAF4A2C57
X-Rspamd-Action: no action


On Wed, 28 Jan 2026 10:58:54 +0100, Andy Shevchenko wrote:
> GPIO Address Space handler gets a pointer to the in or out value.
> This value is supposed to be at least 64-bit, but it's not limited
> to be exactly 64-bit. When ACPI tables are being parsed, for
> the bigger Connection():s ACPICA creates a Buffer instead of regular
> Integer object. The Buffer exists as long as Namespace holds
> the certain Connection(). Hence we can access the necessary bits
> without worrying. On the other hand, the left shift, used in
> the code, is limited by 31 (on 32-bit platforms) and otherwise
> considered to be Undefined Behaviour. Also the code uses only
> the first 64-bit word for the value, and anything bigger than 63
> will be also subject to UB. Fix all this by modifying the code
> to correctly set or clear the respective bit in the bitmap constructed
> of 64-bit words.
> 
> [...]

Applied, thanks!

[1/1] gpiolib: acpi: Fix potential out-of-boundary left shift
      https://git.kernel.org/brgl/c/e64d1cb21a1c6ecd51bc1c94c83f6fc656f7c94d

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

