Return-Path: <stable+bounces-248886-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHspB5xiB2q90wIAu9opvQ
	(envelope-from <stable+bounces-248886-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:14:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80710555FCD
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D64D530F990F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1053E403139;
	Fri, 15 May 2026 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R0WMHqfm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IY10G1Rx"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80540312E
	for <stable@vger.kernel.org>; Fri, 15 May 2026 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866518; cv=none; b=quP69g4Tm0Rp2i80Rkx5WWd2SqurU5bMrrM68U2lG4UDVxPWeXAJH1bV2Nf937dpx1UXxQOnDIZou47eY9kZWQXQu+WFheri5+01w6R5oU7frChbwNcPmBs+S4Nu+4ikW9y/zTzg+VdeJMjCoYbb0wpLwfeWzIt/qQOH+Yx3GoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866518; c=relaxed/simple;
	bh=2Ms9LKBYlkLnR1V6x6N/rtohrsuCHkzR5zq3JPtxcMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=F6udTaFjNeMf72O3I24dHSLp65tkfmhWPZ5U5C+3y9XpKmVXcNs4rDYdLUIW59TUr07ZHFw0TUkbfTw738wyrk/nXw6Qy8dZYYxfusN6fRizcYEw/rxODvuuCiADFw8U9vx8V12fKRQgJDZC7I0ejxOlvEwfQHiAQmkiaSf5Pg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R0WMHqfm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IY10G1Rx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBF1ai3219672
	for <stable@vger.kernel.org>; Fri, 15 May 2026 17:35:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HIMgbIkwZny+Am8robZUok9MDTrk6g2bqyG82g0rB+w=; b=R0WMHqfmaRzS+/FZ
	QQMKxbLgvEpAC9YN4flY7ZOCYcRtv+9opi4/1D8gXPORin8KBYmRgxijNNWl5UPX
	oXxboF9sptvRFRYGfLu1BBJdkdGuFSV166mz29gFHhgJLtlxjjsHapwqF9BsZnSI
	DMR9JFkVdz9O21euSHgXu93tGSNAVkC/FFeG3FsIEys1IBV2RBoeTuXQqayC/Hfa
	TWczXQzTzvghA+XvSoRTmnpeiE2BS6/vsDd/mcrYRgubOl2DCdH+6m4AHQhNR+7D
	1Je+9Gt2Vy8naJzYWspokzLrf6DtYUWRR3ldQB0wukBYE64/2RpLULSygTXQDclt
	SnnVeQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1s488s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 15 May 2026 17:35:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ba115ab6bbso2234115ad.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778866515; x=1779471315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HIMgbIkwZny+Am8robZUok9MDTrk6g2bqyG82g0rB+w=;
        b=IY10G1RxDBFNW9ocOwK1gRHPJdFyHz5iNC6I6Tpdq4PMwuMgqi/QtVQPjQpKE2z4xh
         tGljccQQqHQ2BWONcvY/WthpnevDDeOgyEAHfKFDlhVI/+RNSwTOgYlydsNivguJePXg
         j/y+WHaw/myIiA7Q4MryF6JxRiSqMPnf82Q/0ArtziESvIKVttDl/ddXqlTRPsmCwndc
         dQZ18lWw1hlYrP+IiwMpqHxFlXIgWp30tbXg3uexHqU2Y+IXujLiw/rebD9iXw+A9wjC
         xLFSIFhqTUSfdnNsJn13H5ie5CsW7+A4NIMQlLCPiVSTQ7Nqyk9Oc2tJvRnipAAJ7rqS
         gp0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866515; x=1779471315;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HIMgbIkwZny+Am8robZUok9MDTrk6g2bqyG82g0rB+w=;
        b=Ff/6klRMU1MFl25dE/KWyU2nsehVkI2Vt92o/NiCYd9mfeSc3WM6EocJa8R0LF74zY
         +89FB1YHBdN0DdSOhtB1tDgG07agqd83zwAs64cEetCX5DlAXxhMa/u9rEG759BdAM8P
         ZtFnCz0IkmSN1rWJ/L3E4QdzxMn987dqJLmUhr3iMktVtwG2/St0HzKeAA6sspd1QVyi
         Rgi054u9h9nA/Tc/LvMZRxuPvWRsxV2y+3rBTu4FXb6whHOIF5otBSZDq+SYzX4B1+wY
         gjYoKRePqb71nwE0iT1OG3YmnL7S5mNGJlfp8XUzJPOdZUTbamiGipuCPaaHZEPL4Ovg
         87CA==
X-Forwarded-Encrypted: i=1; AFNElJ8JqYaMg6HFBHto7sMpYKYAGPaONfoD9Qzu2PLHBO8pbe/H1ASVkG06kdsJFR82SUlX+qLp3TU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb0b5WDu6CPIoCCLY0FNDOw5prWBc9ERJ/lj2OKq1OQ1wif6wu
	umabXPh68eaRie4eYbEsCfsgDHbKE5Cnkz0cEZf7ai4Ip/pEY2BXTIfFrf7PTIaoCIU5jtsXrB6
	CAFiIrosbpvHKZWFueIuG2Oyy+2406Fm87QA39DMqY5xRMe/wYkcHPSl8LT4=
X-Gm-Gg: Acq92OHcIt8RoGfBeS1sFo77ix+mm2hNLGZrtcWKUTMWjuL0KIlNgvUqNkLdOffAEeS
	S1IXeF6QXoqvgkjrqYZsWV3cmYKBYV9Ys3qvYFfvd2DHOwf63/0D9PbQZhgWju/W5KBlAbFCJNP
	V2MQY6mtnl4AR50zhJq11N2+05AzuHi8R1Uu/twBUeT/Rj8bNRbmTVUzw8mxs0a6PuPofHX7GdZ
	e4KysDGd7KuQ2IwC3YY7tYibgILa1QKHdQtB5L7GZ/grh8PYKnRfXKCRLPB1QWj73bsoVkB06rs
	lRWOwV6uRQ2GjtvbfHnMprBPLXFarvQGLrthi3lxYjcDJHm/HPSOCWCRQM08WA+kbaK10QlYEnY
	mNyE1//bHw8b07BipYhOX
X-Received: by 2002:a17:903:3c6e:b0:2bd:8c9a:a684 with SMTP id d9443c01a7336-2bd8c9aa6famr36789995ad.4.1778866515378;
        Fri, 15 May 2026 10:35:15 -0700 (PDT)
X-Received: by 2002:a17:903:3c6e:b0:2bd:8c9a:a684 with SMTP id d9443c01a7336-2bd8c9aa6famr36789675ad.4.1778866514870;
        Fri, 15 May 2026 10:35:14 -0700 (PDT)
Received: from [192.168.1.11] ([120.60.141.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600b4sm67266915ad.28.2026.05.15.10.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:35:14 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: joyce.ooi@intel.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
        robh@kernel.org, bhelgaas@google.com, ley.foon.tan@intel.com,
        dinguyen@kernel.org, Mahesh Vaidya <mahesh.vaidya@altera.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        subhransu.sekhar.prusty@altera.com, preetam.narayan@altera.com,
        cheryl.bansal@altera.com, stable@vger.kernel.org
In-Reply-To: <20260430204330.3121003-1-mahesh.vaidya@altera.com>
References: <20260430204330.3121003-1-mahesh.vaidya@altera.com>
Subject: Re: [PATCH v2 0/2] PCI: altera: Fix IRQ cleanup on probe failure
Message-Id: <177886651035.12875.14264722458696413101.b4-ty@kernel.org>
Date: Fri, 15 May 2026 23:05:10 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3OSBTYWx0ZWRfX3ddasTZMsq/A
 svui7oCMyXDNfy7mYhoC2YeM6TOJISpyPRDD9Ky5i2WRn2GLjyD2CMxYrzGv05xTm/rPqTodX/a
 btXBISp697lVRbitbAEB4LzNE8gG23Zo9Ycf0Upd7DPkREWFFVORcMKl1PBjXfbYYGGCkEarPMe
 Tlf8Fk8YPlp/OmcNs8tLEMtJ4bvHdPN5NNN3lQTEbOPc3bLLy3bDIv+kgPdSXQWwR117F2p9dCN
 Egqd0Z8zSEGaqUEuaFISomPQYBb+UhdDSg/5u2ZmXwPpcc/B7+YvmoIytZdHGAWxas63zAaX3ly
 0367ySWV0L9M159hItAk0wqGzaWD+S83HfJOvOcgsa9muOwVplA77BoZ+NalNJEURPpexzVh50m
 nsVZZzmc+IyvjvfMwKXdwvLy5fjeSkORI5VIRkgtpOgmKEFcYbYZt4/t7gN/657z7EFvJsrcfGd
 A65/jEh9sJfLLlSZ7yA==
X-Proofpoint-GUID: bXKiQdRA1wSJwVrKrSj9Ns0p6QX2EfCD
X-Proofpoint-ORIG-GUID: bXKiQdRA1wSJwVrKrSj9Ns0p6QX2EfCD
X-Authority-Analysis: v=2.4 cv=HJ7z0Itv c=1 sm=1 tr=0 ts=6a075954 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=8TBCxnFsifAbGBbxUCxq8g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=Kp4qGauEggbYy1kLNhMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150179
X-Rspamd-Queue-Id: 80710555FCD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248886-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manivannan.sadhasivam@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Thu, 30 Apr 2026 13:43:28 -0700, Mahesh Vaidya wrote:
> This series addresses review feedback from v1 of the Altera PCIe probe
> failure cleanup fix.
> 
> Patch 1 removes irq_dispose_mapping(pcie->irq) from the IRQ teardown
> path. pcie->irq is the parent IRQ returned by platform_get_irq(), not an
> IRQ created by the Altera INTx irq_domain, so the driver should detach
> the chained handler but not dispose the parent IRQ mapping.
> 
> [...]

Applied, thanks!

[1/2] PCI: altera: Do not dispose parent IRQ mapping
      commit: 5ef4bac02189bee0b7c170e352d7a38e13fe9678
[2/2] PCI: altera: Fix resource leaks on probe failure
      commit: 7a94138caeb27f3c49c1dbd93bf422098925bb28

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


