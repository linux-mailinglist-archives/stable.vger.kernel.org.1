Return-Path: <stable+bounces-233073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFuSGT2jzmlZpAYAu9opvQ
	(envelope-from <stable+bounces-233073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:11:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD738C66E
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C5E330013AE
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 16:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643F13DA7E6;
	Thu,  2 Apr 2026 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Bf26WH+/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IcTyj9ba"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85773DA7C6
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149091; cv=none; b=ous9pDoTlZrZ+uwu9cvl/HjjalPz4QoLDwT3Nx1l2ANZgEkS1jkPQfRJ/aacV0Tzmti7Kw0jJjcBbp8ofyNaEfO8h6RR2n7yDlTzFJMyHpZMh+F2FefL1CFfrLYZmhwedl6R8tbdtr2ScfrDh+avFOzeFqu9LGxkOPIStmd4XKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149091; c=relaxed/simple;
	bh=iVO6CClRzCDCdn9sT/whLwtwO1UaSpLvldz8M7JrZ60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FFVNHLFvFe91Idv764WjkWX3J3N4vRP+ukNuu/zAXtTFU5+li1OZl1arbUa3WUNOclRdd6CJxDHYmCZ2i342Ph2a9BW/xJoJPeApkay1cGdLt7YqmZXmdOIGpsJp8Ty9pVtUQN6F72TBPiwGfjgvsk6BbxxR/8J6TIGYr+n7ipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Bf26WH+/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IcTyj9ba; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632G4lGu2528211
	for <stable@vger.kernel.org>; Thu, 2 Apr 2026 16:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hFJkuoa7ytoLT1UO6Pac5qwA/yzIHHAaZ9JrTM5bhGc=; b=Bf26WH+/dBfUSx3V
	tP2v+J4ciOrokkWLfCXaLAhUJJLbLcXurHv0PNuPz4p3/qhtOi2ycFQCI4OIZPIn
	AmXTTvMY57lGOJr1x6jVC6sU19Dtp1+jV5HbGgtKthH6gECVzjwjqJM25/r9VP/P
	JEIYvnTvC4E6b+G36a2rzMChKKNo1Ugrgh5FF+sIw2D7eoUO0wunrsLoL9WGfPFW
	D4QiquEpKupq/dKcoh0Iva+/il+iRmFvvNlNjBkcMMwYKejhLtkiqXW8NvYv58Oc
	ZiYrp0fhJTwcFR1VCPb80v19P//GghsHJpK8+sS6qKzyr/k7EdJf9x0Hq/2nBmqv
	hs5Ywg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9txc8cqc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 02 Apr 2026 16:58:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c769e2b1bd0so549960a12.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 09:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775149086; x=1775753886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFJkuoa7ytoLT1UO6Pac5qwA/yzIHHAaZ9JrTM5bhGc=;
        b=IcTyj9baAD1Uqqds/Uhs/qxwoXUsUMurymsnrD/zNlQOh6CNMUz5/SupU6ExF4ATfQ
         D0D9K5eHzUw60rMRM6Ufc7/5t5fT7LmknhzqGlEnV0CXpRyujnIafE8h/OR573PmQ5re
         0Qy8AugJJydCf6SHRcvzCfpy2b/0l14u1SGaoSbECdT8+r/rsoprxhdFjghq31uTVOfF
         uHwAhZTtMMqcSVvVzVbJJvJixXLR3Mwm3KzJoeXeE3FUDcibAC1hTVIGAPoipWBwfoVm
         c+07cWFg/5EAdyjwtfj8SglRH6e5wbJMnUVmhX3uIf9O3e4PsckY518kslQxF3jLsQQd
         m3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149086; x=1775753886;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hFJkuoa7ytoLT1UO6Pac5qwA/yzIHHAaZ9JrTM5bhGc=;
        b=jIhn/qfbCtdf3xGo0G8vQbcGNd5gBgXv6oste3vXxTgImG1iOoiC9G5N5rjZ8XXrNn
         ysNHWnRQtQFsCbQyGcDX3aOavQHHp9ftX+EytCH137YW3iZ7u7HThE+dZSIwNep00Gqm
         53YYgaEqhGNtASkBKL3sqSBavUD8Pnki0T6RFjWDOV6wZjnP6zs5WIaPVJg0LiX0FGDm
         LCdjhvAj7MpqY1ErgxJFQQjOCoZSMWBB6xe4UPAYUnqQcevxGnxo3ZhoUq+vKZz90Ftj
         5qB1j5I3YeT2c3Kr+0hYt1eRtWxc62cCvS7BGcj3TDNo1qXGpNNaw5URZivVoRN7GncF
         Y51w==
X-Forwarded-Encrypted: i=1; AJvYcCUIfos85oycTXmN/hkl9pIvVUTzOWyIGZ1IremRlQwpCI2cZ/nx9W/o04gyEY88z9c3AP956nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKWCvJiUz4io2+v7sL9rZR2r50+VbD79jELW+ePtnVpqIkuttC
	67kvEwuNI9NYSS2ulJQp82NT6JikY36D8T5sScCtHy1kJtRxH2JTUxjIi//Eu1rWi15v11uYXQa
	nyygYaSMkO3EoGp615sntZzIwOHolQrJBdw03dNPaCzovBx7zWytaijja74k=
X-Gm-Gg: ATEYQzzbYjD7/Ah2v6Q8yvIC8/A7PFVKxQ6DrjUcq6GkAiHVndqjIjxerN8VRnEY8T+
	J1Abl1nb7NvJ1rbT9qiGapGu1WOop5nVTQDPQ2nPMVafsy8Me7bUjtT+ruzkLvod3pBwo/glbGT
	7z0ERNnAWjnon1TCAUx/X/ZWY2qJXQNcj6Gr8wG2OpLrowWj/CCpqiUMEyj11fBcBu4doqBbhVo
	mDGm5sOG9n0g5vW9D06qN2vfEk1kykZWpN9wqmBGPnuAzRTAYrp/xIn8Qtv3MPET3v7b+hFQg31
	1ThFNZ41tZ7dwIonjd8kqGNH/ns+bRO8dVldRdf1qEQIwtClsI8dauBEjyNdn3zdTa6lL2EVSm3
	kkL4qLIM2YuiXONosDSU=
X-Received: by 2002:a05:6a20:7288:b0:39b:d5f1:4ff with SMTP id adf61e73a8af0-39ef73de98bmr9045357637.20.1775149086041;
        Thu, 02 Apr 2026 09:58:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:7288:b0:39b:d5f1:4ff with SMTP id adf61e73a8af0-39ef73de98bmr9045314637.20.1775149085388;
        Thu, 02 Apr 2026 09:58:05 -0700 (PDT)
Received: from [192.168.1.102] ([120.60.79.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65a3f08sm3262932a12.31.2026.04.02.09.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:58:04 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
        kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <20260331085252.1243108-1-hongxing.zhu@nxp.com>
References: <20260331085252.1243108-1-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v3] PCI: imx6: Don't remove MSI capability for
 i.MX7D/i.MX8M
Message-Id: <177514907977.11779.10857136002766145178.b4-ty@b4>
Date: Thu, 02 Apr 2026 22:27:59 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: ZeAbuC3KByANZhuu92sD8vXNT-w436CC
X-Proofpoint-ORIG-GUID: ZeAbuC3KByANZhuu92sD8vXNT-w436CC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDE1MCBTYWx0ZWRfX5WVII5YU9+fk
 zUkeg7p88cOWndUyX6sMEttd42yEUm7lhvMOgrWGty8d71R/h471yPO8F1mfuKQwbzqjKIEyaC6
 Euv/HRyLisQqxNq5/ZCFCNdweFq7mEdYnX3v0l+OJ6YKDnDmANnCBjutDNB/5l6gYCfbA+AlDDC
 EZeorPRdIX9ls2msLDEbZJRFKtVUsvJU4vjy64gg2wN8lJTnQVrX/rGy1bK87cZ8fOeoAMKofE1
 1wQ/mdW/F4zm9NIE3RV759jna2WXItlcHKN/NhRr03tR+CcxElAqlfihMS3u7jQv5a5TZ1RI1A0
 sNLgRhbRPLdt7v1qkssGN4nOkaGobDXMTTVSCpOc1Jlv5CDglOMpOQoNWJ59P/dY7cYJ2pU8DYd
 QY6ZuzzYJHuQ+3Cj8nrCYjZjLP9yGkGDqdpCHNUChvj6H6knKj5MBPi8D7Ypp/BMalWC1DRJcui
 AOYK5semC3qDFplqg5Q==
X-Authority-Analysis: v=2.4 cv=HKXO14tv c=1 sm=1 tr=0 ts=69cea01e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=+KsUAYeLG1mN9JXONzlAbw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=kxgfuGgQFWlVBPJi97AA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020150
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,pengutronix.de,kernel.org,google.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233073-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5ACD738C66E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 31 Mar 2026 16:52:52 +0800, Richard Zhu wrote:
> The MSI trigger mechanism for endpoint devices connected to i.MX7D,
> i.MX8MM, and i.MX8MQ PCIe root complex ports depends on the MSI
> capability register settings in the root complex. Removing the MSI
> capability breaks MSI functionality for these endpoints.
> 
> Add keep_rp_msi_en flag to indicate platforms (i.MX7D, i.MX8MM, i.MX8MQ)
> that should preserve the MSI capability during initialization.
> 
> [...]

Applied, thanks!

[1/1] PCI: imx6: Don't remove MSI capability for i.MX7D/i.MX8M
      commit: a9de12c04779729f6d404192a5320c2e4dac0968

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


