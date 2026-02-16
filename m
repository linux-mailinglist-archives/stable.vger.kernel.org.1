Return-Path: <stable+bounces-216689-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JjSBjj7kmlx0gEAu9opvQ
	(envelope-from <stable+bounces-216689-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 12:10:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC43142B81
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 12:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49AEA3019FFD
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 11:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75B2FE593;
	Mon, 16 Feb 2026 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hw4zS3Dx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="imQGysDy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D53016E5
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771240230; cv=none; b=SrxtIotnH7op4jQqBmE0voQXZZo6XODzjJuiLAWF+lsXg6JAxVrsJiWHoewsCSpstymsVUnm/VrmFpo4HI8E2yDT9rFoL5/wGjoThxmNtgygune3sTauBQmOnX7E7aLNhlkG+g9QtaAVppVjnrUY8idpKL1b0a94lTlSszk3hMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771240230; c=relaxed/simple;
	bh=zsYehVzhZe3JF9Ogz9BE23uA4xdaFzCX34fyhLCVDro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+MDqOr3aZ/oYz91QzWarnu06djhvvjRnXEw7ANrKp1D3Et3SM1nLFZmtin9cWXCQUgJxFoaVPlIgYLckJpkR0dGLO3lAcBuO3FQCJzk+3mA+zY4CMFpelWxaLJRlwdB/NOsGsxA/7J9Vv2iorbov9dB3VMOJKDK1bSwfOl9gNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hw4zS3Dx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=imQGysDy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61G8h7x42804570
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 11:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DnM6XrAsEbnpMV3CBb9OYkpwrCnXQYBrThDvOpySTPg=; b=Hw4zS3Dx+FYDKKtV
	NKVVtXiLKIsinVKLGYjWOJ+HDxHubw/hZonHmGOEg2kK7q+O97mbXtNaZXLiWhZi
	+JiFI+ICgf8Ylq5uDtreELSukeTyPYqChtpEdwV6XpfNt2GP1S4u4zcPoCNouhp3
	L+WhwVW+dS5FTqeFmLamL1rF+///uTCN6PUmFg/d6hTkryJtGKceC70nHejjraGR
	nWNHTODd2yZuCagXgrNQJ3BaON7S/uO22kWU4lAFZmOqCb+Ky+TfQXADDaHQ5aO/
	DWEu/tpvsB1gR39uyIzXs6hKQOWkxkD6cqOChBpBskTaC0P8XMZjKi/3zxueYCTT
	u/9EXg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbyxugc6k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 11:10:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70ab7f67fso2990242785a.3
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 03:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771240227; x=1771845027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnM6XrAsEbnpMV3CBb9OYkpwrCnXQYBrThDvOpySTPg=;
        b=imQGysDy+s/IpCecd62HzkJYuSmBKF70zAaagQZasCo4YOmQg4hbj47/6GIRDhCMhK
         gxFq+/7P3Ief3IHCkU7ZHG6doy980s14kjJ/+BGcCZdZX4/3xYoac8CuyHf9xswFskrt
         f8hZXZ4cm2P+qZ3ZBZdPskG3AUu9l4h4HYLW22VVwLUKebubjdJOzCDJmv4SXeTju9bu
         6kC4KAl8IVchpKAGfebKt9fYyqpcyur+AUaRKfA3lijIIyyotLuwKYS7quWjVcQqx0su
         fDa7+oj95VPDwugrHfM4/IBcOzi8tbVVUPyJvRCn/iC3Rp3b9jUEMc9xHOp7eo4XXkEg
         39GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771240227; x=1771845027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DnM6XrAsEbnpMV3CBb9OYkpwrCnXQYBrThDvOpySTPg=;
        b=Tg2T3CaqxT97APe6dgcbXEo97dKFl3W7hm6wUs4rUAfrYbu+HGkXgT26km2V8FGNRs
         nk1Q0rnWjN9PTf6CUNJB4AReT2exGTPcvzB/ki8JLBSDPGecLZ4kyToXhuhIsQyCmNkM
         8pag9dEpJCMLQrzYLTAEInj36MaYP2xATlP6qHCiCqOaCAPoyFxy3TWtCB+UeISl/mFs
         Fns+Q3XmNppjjbAdJZgAID94mTePhe4+YokOjMd8yE5hNOBtrPp6YmGKag8dRVunAhX8
         3btxs2LXeEbsv+34YR/k3w7aT4y4+LnZVibS3fmpAul8O9BmbSGHM/HJefyMAPXZa8nZ
         DPmw==
X-Forwarded-Encrypted: i=1; AJvYcCWIoTX11ZBIdpiMU7IKTXMmpHHJNunjgRkK1NZpDdU2bkOabKBPfbf33cdnlOJ+XFmtHhpF/Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfC//sRZ4otuDvbMQvfRtyjHomBk0z+7/4ICEhPxP3KBBYcDRr
	5rcfZgF1viLhYuUNhhNS3Nqwq+gvRcbyGAZTv7rXEAMrnQpOZq8vZIXYucLKt6FXjpy60JmkR8V
	oR5atRVxGIaSCt1CtkbtSEFKU7vuLwdVXcTdD4g6tWUCHdSCJN+gc9Tl4L+M=
X-Gm-Gg: AZuq6aIJsi8387BlF+XTP8kxrxWo8Ei2mPRAleJFJ0YhGQv/2dgTgww2PN872FaKvOz
	rYIIb9VVuP3Ht+fly7J3L49YnN3K5HY+QNXmzDjd1Eryhj2DVj/Qqw3XRgA0eQQpJuAReRdepwN
	ENDuFAixAYcRAoF2P83CrDINoE6dyW6Ag+Conav6Lzyk7mfok5+MIIwqcqdokj0hCgI9xejJE+3
	orheO28d/Nf/lgbivpUSBV3UTZLAeuSR5iYGyPxo5lMh4bpkE6l1ixngfLu9SeuQo97dcWYKFGT
	W1c5qnxr4r9B/HjD/vtywsKSUnqDvstPXuTKtTaIpNMrQILN8Y7c/fXPGt0+Y1OVkuvRB+E+aoq
	YMXzHMh+IOU5q5O6ZlFkNI/I/unJBHyX6juy6itoPjG85joVib/g=
X-Received: by 2002:a05:620a:6c86:b0:8c7:33:cc97 with SMTP id af79cd13be357-8cb4bf9740emr943812385a.13.1771240227203;
        Mon, 16 Feb 2026 03:10:27 -0800 (PST)
X-Received: by 2002:a05:620a:6c86:b0:8c7:33:cc97 with SMTP id af79cd13be357-8cb4bf9740emr943809085a.13.1771240226739;
        Mon, 16 Feb 2026 03:10:26 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dc34:5caa:d44e:375d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1bfsm27851016f8f.13.2026.02.16.03.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 03:10:26 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpio: nomadik: Add missing IS_ERR() check
Date: Mon, 16 Feb 2026 12:10:24 +0100
Message-ID: <177124022115.18156.4939160850575737621.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260214044531.43539-1-ethantidmore06@gmail.com>
References: <20260214044531.43539-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: nqOGN7EJ9eYQctVxmhjX91CFxYLKEzos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA5NCBTYWx0ZWRfX9dnXkO6YiJLt
 jLX7hPjSreKF8003KCr+wgQKUeBcTXYeQM+NhRI4wBrdHSsb91e9fBL1sGW8bqlEk1qOgQwnxjd
 U6ZRQahykkKkN/QHRJQe24s8+9ahmB1y4YARmOcevAl+rlqZ1V4AUxsg7aNhPLZxm+Xucm/iuFP
 p5FJPHXOGI4QYMFIYn5tyyyhO5HefByseDjO9ErGKMnXtsw84pF9LH7VXEAP+FVXzJro8cCiiCd
 CnztSOsoOhVrrm1V7bZ+J8eH1Fh6Ara8zp2ou0Bg9596RIb9Jwoy6GbJGThv+CBxsUKqu3EgoZg
 zZJXBuO+vl6Gi6Fbsku2XuZSTAtYmmQMjTNSxq9LQcVZqgvRtmyKdoA1bRu6Dc+/AX6hpIE7l5I
 7R+qgzRnns+HYvYhfFET+XdwHKnDsWFMkAC/iE12aRejfX/dRYFpjf+w3gLq+ip14bK6FcnxIZD
 ZTYPKVzzu0c5rLdco2Q==
X-Authority-Analysis: v=2.4 cv=BpuQAIX5 c=1 sm=1 tr=0 ts=6992fb23 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=iOnWDBcTrPUp0QyIlJAA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: nqOGN7EJ9eYQctVxmhjX91CFxYLKEzos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160094
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-216689-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CFC43142B81
X-Rspamd-Action: no action


On Fri, 13 Feb 2026 22:45:31 -0600, Ethan Tidmore wrote:
> The function gpio_device_get_desc() can return an error pointer and is
> not checked for one. Add check for error pointer.
> 
> 

Applied, thanks!

[1/1] gpio: nomadik: Add missing IS_ERR() check
      https://git.kernel.org/brgl/c/58433885ee99e8c96757e82ccf6d50646c4dfe09

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

