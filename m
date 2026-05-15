Return-Path: <stable+bounces-248881-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBulEPFcB2pa0QIAu9opvQ
	(envelope-from <stable+bounces-248881-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:50:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F465559D2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA3EB314A14B
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FC34E3765;
	Fri, 15 May 2026 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e489gtb8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J6CAWmsp"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8320530567B
	for <stable@vger.kernel.org>; Fri, 15 May 2026 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778864420; cv=pass; b=KxBhE0DVu3NQ9CIRxHGJaIURHtkrLE163SGjOAWL47S5UcA04MnQpWNpDu9r7m08aU2pDsC2NscfFbNPpzz1EY5zEb4TzuBrumQT4R/ohEQ2frvVCBHt3YVUdG4bBlAxKW0MmH/SClRZTc8aW+IlTBgAEHBrboczghd4Md+YZt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778864420; c=relaxed/simple;
	bh=YfftEC+wk0bDFNqO4MMUfGIPA5XntqSnbPuk35oLoeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lntB4+dmeA2PcaafoQ/sjLaEdK29qNc6xo8/h8Z9xrapo7MOoZEKvfNpx6WKfrgreAW9o1e0wTytF5NZpFSZfk5OQ/pSVK7zsjFOVZM9LLj/S09cuDlNyACORDUbVe0t08DzNmGWb7enzNMCogUHmN5y6OVIZTsPFS+fCg6QZAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e489gtb8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J6CAWmsp; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FGR2ow1831334
	for <stable@vger.kernel.org>; Fri, 15 May 2026 17:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=gEQuph5mrSxtOht+wEEil2qGcAWnLTsZ9WH58wSoVTg=; b=e4
	89gtb8Bp9RN0Sywu0uixaS6IdgOXP8h8d6sPvc4jRrKzPFdaFwgYrXBTx1yj8Y4s
	4Cmoa4HOTgPR7+tWglVUsYyFVeL6ZftnWCSxJx52hV9W3538tSf+YLMTxSbfZTbj
	0CjP2VlPXunOQIBQ6jc6QmKqHAVWuhNddjiLy+c9LvELmbnd2Zt+EqU6xDokXIuL
	jFwo5bfA+icL1AGLsK5Z5TiKjdz54dfdrJ2kLnQUYtCW/KVZ8CgK1zDyFTvuPkm/
	teia6Imb3EcKGnXh4rV7ZlOSXPyZRHXIQ50ol/Kwmw74LIvudWARw0Rem0aZBoHG
	uzURPaSKoH/WVdDdIpZQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e671503ha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 15 May 2026 17:00:18 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dbbb806e10so10343a34.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 10:00:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778864418; cv=none;
        d=google.com; s=arc-20240605;
        b=GD7NEfjPCwn9z347B4ZsagRFS0SB7h7dbewtUDBiJJYdjZD+iApbpO261rbz1V944G
         +NsuIPcXoAbk3e1WusyOlzV8JWwpNq/1pG/aZ++S/sqMwFUKqlEeZJThg//170Q8HEZn
         uOvvZ1xlIvNjAtqsIghNa71zD8uHkmvI8uzNCMJ0FueB4MzPzbMkHJcs/UClO8k2UWpG
         vgp25M774Z+oN13Ozp46Dm4QpkqMAPiM9ivTz3vaHNOLNB98QzBwT389GDvP58JbHgxJ
         a0F7bSAS1L1D4C1QY8rnjBmO5Eat68+wUTROYiyI2a2hKicl3UZJSW70qaApUKyRAJfE
         kLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=gEQuph5mrSxtOht+wEEil2qGcAWnLTsZ9WH58wSoVTg=;
        fh=KxwTWontuV1hY7EI0DYL3DoVep9bY72S8vRtU4zQhE8=;
        b=bm1p2wy8tkuzYN1QehXTkIe+5KgSXHpwXK3r+xn5Ehqjk7TgXDQNjCmZHp4LIWEpIf
         X0rMK0596jkR2A9A0JlnwF79l0V86kr/rrFJm0J6mtFowHbeWTZcfnlBw4S+AkDwH5bP
         c1H8wNY4kk7Kd5duEMcLePSMFiQusrAawBAQ4aA2lyQqBppcC2dzb8j+rUQvBUNejjIc
         oHWCvBEg0ZYZsAZt9oRfCtpgZsGhMOrL6ksTz075FQynyjEfHEmR0aMIxj0MGE/navKl
         Wikyl/ouq+OFIhwj/LxhBRIg5sjBJUzWuoqo4vzwF6cRjeq5I4ZN0HKVxLvEHAm3iJxc
         30eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778864418; x=1779469218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gEQuph5mrSxtOht+wEEil2qGcAWnLTsZ9WH58wSoVTg=;
        b=J6CAWmsp5AnllA7oOMwf0SA3GidQdHrdJa+ahUHk7cjNjRc6Tp4qi8ep4UJw/PtGLb
         CiwQOee7qnn6AqXgJLpAdiCEl/u5k4VqYBBgqWz6oM+XWW4i9/LsX6uE/DuoSq058woC
         cmGHMjDIbuUSjTDhfXQJ7/7hY5NlZGxs/ORcNPXNBU5oqtoYtmYMjUfd+Wr1GNXnPH6a
         QbWmREq63nw6z7Y2yCvKE6emoH8x1RXI0OGpg0oUrqeWqDVXhCe9l+NmmpOKytJjyAj8
         cXJiHCVa6C9iuIjInxsDdQzjdgOU0VO3gfe0JX+3mDCcffwfvD6jz2gk61ylnVXLXiAA
         cyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778864418; x=1779469218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gEQuph5mrSxtOht+wEEil2qGcAWnLTsZ9WH58wSoVTg=;
        b=RGR0rDvgtgm4+1bQgdq4gYTTR+qZLjI46N9XpVhDh3/PVUpiJjTBdbivf9WXsq9Cdx
         QWSd+Nv8PtRcp7OOkm493MviBh+NH/FPpg2UWAJasIyu/XrGc4X/kwUwn1Z3jJ/baFfI
         wxQOFLEpqbcPPF4hr5frzGeP2Iu8vcg83mFYKg29dOmw+wUkYFg9uZfqLR/j3GD16fRU
         zVjD9P5hJr00DPiS3kguTmmN5E16t5ifNGyQgVxbBG6j76hnxB4LhSkv1jAURWZ5k+j8
         rIWICXXcafzDfdnTGXVIjANAudFuBXClD+RKTB/vSDWbrvmV5CLwIvlklN0F61z80Byz
         HLeg==
X-Forwarded-Encrypted: i=1; AFNElJ/XIL6hdIKj4yBq5o4RjeGZdWkJc6lQTzqrVAuyD2x5aiao+WpaenoOyCa2SznZhvZT+S1GYnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/njeitqXRFFoPoEiJ6iNcC7z9H49oHmpHPuDIRZk7rlBDalg
	48/z9UUcgtHnCD+zhd9+X0C41w6dq/N82T/FHgcqn9Y2CGvv6qldiOLcLKhX4WY0an2bs0R42Ul
	Gq79cUGB9bSarPhIXcIRhw0A96P8qHtv5seNyRbITlKHRqh7Af10ZhBVhXA0yxeSrRsASWVYSwK
	6oj9qD8jERVafMy5vosFLbNbPAvPzz5bbIoQ==
X-Gm-Gg: Acq92OETLIRDP/nGDYsbg9N3nE4PbcLkdvos9d2a+B5cm/3S+wzSWdZs/DMaQvj1pCc
	uFtJ1/L7jBGYBGihB9I2GXusN0yYvXqMma/xdJoBCF7diYowf9EHQCCJftabz3TZJYkH+H57CXv
	UpyYpn7da1cnHRciyhs3MgyV5A8dvkrJdmzHXKqn3cs060wcYVwV6q0IVakyt70VRnzzum4/0qm
	p99iPmROxtfLkU7tKXJ2U81pwTFddEcZPB1pg==
X-Received: by 2002:a05:6830:34a2:b0:7dc:e53a:638 with SMTP id 46e09a7af769-7e4f2a36b52mr3247347a34.8.1778864417702;
        Fri, 15 May 2026 10:00:17 -0700 (PDT)
X-Received: by 2002:a05:6830:34a2:b0:7dc:e53a:638 with SMTP id
 46e09a7af769-7e4f2a36b52mr3247315a34.8.1778864417079; Fri, 15 May 2026
 10:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508065722.18785-1-daniel@quora.org> <CACSVV02t99r2JpT9EUar_YRs+zgpzjNYgNvvB9BGLLnpssY4BA@mail.gmail.com>
 <20260511093325.74e2777f@fedora> <CACSVV03ZMuVEK6OegD8YKg4RwHWTU_CbWcwdWKSeyiaU=yV1Fg@mail.gmail.com>
In-Reply-To: <CACSVV03ZMuVEK6OegD8YKg4RwHWTU_CbWcwdWKSeyiaU=yV1Fg@mail.gmail.com>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:00:05 -0700
X-Gm-Features: AVHnY4Jj1ZoXxcHVpYJNicpNIWF6MookH-kkJjYTzQBGu41KOZjcqQvgcCazWp8
Message-ID: <CACSVV03eU737as7PTL6mCJm7PetY6wd6v0Up5H7P08oOQiDQZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Fix shrinker deadlock
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Daniel J Blueman <daniel@quora.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Antonino Maniscalco <antomani103@gmail.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3MyBTYWx0ZWRfX2hD4iXGxeekV
 xkDBf7jpu0rE/YxG5YxOudf4pdJQEjWeViZLralR2EaD0XdJY8J1oMRUb/87PuKXihpFQJn6po0
 K5743Aw2DJbRGKsMvrRJ9hngVU0/TP9qxRDROTILF1vwL2I+FWstHeCgMDkxgUOKDIUNVWOeFq5
 EjrnAeTM7fwPBw/n/vziLMRIRfX20f68T4GLJAMTBgknnm+WlgPDDPysCZNWLEV/sL+iqtE8FUJ
 L7GsI8RI7L7yHhKL8lTbexYfdN3Kt7p1TFFHt07o433YuF+VzxTDTaKPQ39p0AmhPLlZQ0G9+Hr
 qYOaJpNxzmNLyqm+eocM74IqQCoQ9lQQt7+WGLBG6uSZCjyCNA4k+ZMZO3PcuPD2S2I86q/Zy8g
 W1QPIgpPjDOkC1wYhet/wZhWGXiy5+QNRp9tH9P0sguG7h9H+VxZfxD4TpeAxb72S3vZjniBg9r
 rFXuFYE/u2Ib8g9ChWQ==
X-Proofpoint-GUID: H-txbXs0d46tzx3cMQtloqH6yn8rBugo
X-Authority-Analysis: v=2.4 cv=I+ZVgtgg c=1 sm=1 tr=0 ts=6a075122 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=QX4gbG5DAAAA:8
 a=t9ty7G3lAAAA:8 a=Dq4ky0DoUOac6QxOf6oA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22 a=Vxmtnl_E_bksehYqCbjh:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: H-txbXs0d46tzx3cMQtloqH6yn8rBugo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605150173
X-Rspamd-Queue-Id: 88F465559D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248881-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[quora.org,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch,vger.kernel.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob.clark@oss.qualcomm.com,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[rob.clark@oss.qualcomm.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,collabora.com:email,oss.qualcomm.com:replyto,oss.qualcomm.com:dkim,quora.org:email]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 6:16=E2=80=AFAM Rob Clark <rob.clark@oss.qualcomm.c=
om> wrote:
>
> On Mon, May 11, 2026 at 12:37=E2=80=AFAM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> > Hi,
> >
> > On Sat, 9 May 2026 08:34:15 -0700
> > Rob Clark <rob.clark@oss.qualcomm.com> wrote:
> >
> > > On Thu, May 7, 2026 at 11:57=E2=80=AFPM Daniel J Blueman <daniel@quor=
a.org> wrote:
> > > >
> > > > With PROVE_LOCKING on an Snapdragon X1 and VM reclaim pressure, we =
see:
> > > >
> > > > """
> > > > kswapd0/121 is trying to acquire lock:
> > > > ffff800080ed3800 (reservation_ww_class_acquire){+.+.}-{0:0}, at:
> > > >   msm_gem_shrinker_scan (drivers/gpu/drm/msm/msm_gem_shrinker.c:189=
)
> > > >
> > > > but task is already holding lock:
> > > > ffffbf4ddb44ca40 (fs_reclaim){+.+.}-{0:0}, at:
> > > >   balance_pgdat (mm/vmscan.c:7236 (discriminator 2))
> > > >
> > > > which lock already depends on the new lock.
> > > >
> > > > the existing dependency chain (in reverse order) is:
> > > >
> > > > -> #2 (fs_reclaim){+.+.}-{0:0}:
> > > > lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.=
c:5825)
> > > > fs_reclaim_acquire (mm/page_alloc.c:4325 mm/page_alloc.c:4339)
> > > > dma_resv_lockdep (drivers/dma-buf/dma-resv.c:798)
> > > > do_one_initcall (init/main.c:1392)
> > > > kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.=
c:1470
> > > >   (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:=
1703
> > > >   (discriminator 1))
> > > > kernel_init (init/main.c:1593)
> > > > ret_from_fork (arch/arm64/kernel/entry.S:858)
> > > >
> > > > -> #1 (reservation_ww_class_mutex){+.+.}-{4:4}:
> > > > lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.=
c:5825)
> > > > dma_resv_lockdep (./include/linux/ww_mutex.h:164 (discriminator 1)
> > > >   drivers/dma-buf/dma-resv.c:791 (discriminator 1))
> > > > do_one_initcall (init/main.c:1392)
> > > > kernel_init_freeable (init/main.c:1454 (discriminator 1) init/main.=
c:1470
> > > >   (discriminator 1) init/main.c:1490 (discriminator 1) init/main.c:=
1703
> > > >   (discriminator 1))
> > > > kernel_init (init/main.c:1593)
> > > > ret_from_fork (arch/arm64/kernel/entry.S:858)
> > > >
> > > > -> #0 (reservation_ww_class_acquire){+.+.}-{0:0}:
> > > > check_prev_add (kernel/locking/lockdep.c:3165)
> > > > __lock_acquire (kernel/locking/lockdep.c:3284
> > > >   kernel/locking/lockdep.c:3908 kernel/locking/lockdep.c:5237)
> > > > lock_acquire (kernel/locking/lockdep.c:5868 kernel/locking/lockdep.=
c:5825)
> > > > drm_gem_lru_scan (./include/linux/ww_mutex.h:163 (discriminator 1)
> > > >   drivers/gpu/drm/drm_gem.c:1681 (discriminator 1))
> > >
> > > Your line #s don't quite match mine, but AFAICT this is from the
> > > ww_acquire_init()
> > >
> > > What I'm unsure about is if this could cause live-lock against anothe=
r
> > > operation which requires obtaining both obj and vm locks in a
> > > potentially different order (which would also be using a
> > > ww_acquire_ctx ticket to backoff in case of conflicting locking
> > > order).  It wouldn't deadlock because we don't sleep forever if we do
> > > sleep, but...
> > >
> > > Possibly we should also be using trylock to also acquire the vm lock,
> > > but lockdep would still complain as it doesn't know the ticket will b=
e
> > > only used w/ trylock (unless we did something hacky by using a
> > > different ww_class?)
> >
> > FWIW, we started using a ticket in the initial version of the Panthor
> > shrinker, and ditched it at some point because of these unsolvable lock
> > ordering issues. It also seems to me that trylock-all-the-way is the
> > right solution, and if we trylock and back off + immediately move to
> > the next BO if any lock is already held, the ticket approach is not as
> > useful, because we're not going to use the retry mechanism provided by
> > ww_mutex anyway.
> >
> > It's true that it does the bookkeeping, which simplifies the rollback
> > procedure, but if you look at the other locks taken in the shrinker
> > path, they are static (one per-component involved in reclaim) for most
> > of them, meaning the rollback is pretty straightforward. The only
> > exception is the VM lock (one per vm_bo in case of shared BOs). In
> > panthor, we just decided to open-code this rollback logic (see
> > panthor_gem_try_evict_no_resv_wait() [1]) instead of teaching ww_mutex
> > about non-blocking locks when a ticket is provided. Not saying this is
> > the best option, but it works...
>
> hmm, ok.. and if we block waiting for BO that is before grabbing the
> vm locks so no live-lock concern (sry, been a while since I've looked
> at this)..  So I guess trylock is maybe the better approach.  In this
> case we should drop the ticket arg (basically revert commit
> 02070f049875 ("drm/gem: Add ww_acquire_ctx support to
> drm_gem_lru_scan()"))

I'll pull this into msm-fixes.  I've fixed a compile error with the
original patch (and replaced the lockdep splat with something
legible... somehow whitespace was swallowed with the original).

For next cycle I'll send a cleanup to drop the now unused ticket arg
for drm_gem_lru_scan()

BR,
-R

> BR,
> -R
>
> > Regards,
> >
> > Boris
> >
> > [1]https://gitlab.freedesktop.org/drm/misc/kernel/-/blob/drm-misc-next/=
drivers/gpu/drm/panthor/panthor_gem.c?ref_type=3Dheads#L1425

