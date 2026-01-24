Return-Path: <stable+bounces-211437-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cN14JTwYdGmQ2AAAu9opvQ
	(envelope-from <stable+bounces-211437-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 01:54:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 408287BD10
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 01:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5827A3019171
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 00:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA6E1531C8;
	Sat, 24 Jan 2026 00:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i0PDKtu6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X9oJ+h48"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E203A823DD
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 00:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769216057; cv=pass; b=ZWA4KsPitD1PJPDuDVM9tko8HkTXg9BddfY50oEmYiCnqYLUv7aLX+IZc9UM1l/c6fDgGeKSfLSXlzdmgYUUscTHi7sp0GKXywSEII81jrtow9+yST2TpnV9sl/lVF/nwKmSebn/yit2YU+rKXmE9xhS6ct5wQnIBDZ6oji8thw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769216057; c=relaxed/simple;
	bh=/psSTzl/zugWR/YfBzE0v+7mfQXW9IlvaUYxzo1OIfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvQPlNhZe4FMuW7zuEphQzjsaj24erzhs2uFSv3+PXvlXMUsCV4v1b1ORuZSuxNLTJkX1wjCCr+097pC3UjBi5imC4zyNqjhcWJ0O3baFjir0dKAWiLm/E+XLJlwhkkv7Zif7JYc3WAavVUSEbunv4ijzL6iR8u8vUYrQA3doYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i0PDKtu6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X9oJ+h48; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60NFPJ0c2209353
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 00:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=
	qcppdkim1; bh=ypT2ScJN5jRu324D8R3Gm5Zq8pTI726Gt53mcp0XdfE=; b=i0
	PDKtu6xakoZ4UTDxvtVoxkX8S0nFL9D0WtLVBqCHHMZlY2BsHdrxNWhezHe5apiL
	5rc+1oH0EDiR/Sl5L9CEyUeOtOOmksLw49oL7y4yAMBxn1NjDKMZ+U8YtFTJ0qiy
	Df81JDhUJoiQokaHCkQDLOEJYhDVMNCvO7QeaTvqsPPn2EdplkFxcTHJ0tcGdT/+
	2js9L1OB++qs4LVg2g2VAlKZiUZZ7sCP/qfwELh4GNa+u9OnDIhGXwGQFr2UgK3G
	8iPlPmia2jum1uc1wtVGLuRhLi/QsRpceMuIU1m1XbyW8K6SHuYWBlG7fwsroV5w
	+EP2mjdVQ22uL6SG5mEw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bvbm6hc6r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 00:54:14 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-121b1cb8377so5473567c88.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 16:54:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769216053; cv=none;
        d=google.com; s=arc-20240605;
        b=P+n0xCB7Af/7e9+BcbUdGboRwCKlxe5eR0AjUDFBPImP7cfxcze/kBnoU+z1O/JfQ6
         UrIz1qMbKuTLi7r0auTZchv0o3rfJs4p9FNRUXMNS+uPZxeVSiz3FzddM/7WS0tQa3OP
         bQL97zpH/JJEpHttvLreyctJjxqeDhkbKDBW6sOnmCvn71rUD4lO4fanuikSeROMcMF+
         EBVBwJ7gyHT2kHsJvXiNv1LGsHO9CGRLG/4JqZ9lZrRoR0sNAsudbEQrqk8te8QD541O
         j23YgBDado3HL6mYzmMChiMT+QnrVgO6jhu1ixVuEimzMPM0zbGklx5jPNVagPmvXF3c
         eccQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=ypT2ScJN5jRu324D8R3Gm5Zq8pTI726Gt53mcp0XdfE=;
        fh=gnVt1i2syJMBshIFNhIANjFnM1rylhYOexS8Vlv4m+E=;
        b=VlhHmZJHt6w3+aSNKBg1YTaJK0LDJb7USy+kRzwB21PEvpjlj+tTc6uSqVp9rKp5xC
         g3u+bTcNIUBY2dsvNWUqxqMw0mOGUj1os+l7mGawg9ugJ2UJXX/eSW83mhJXYd0INpjZ
         nXIMNLH+6k0oycKafIkLHJ8w6fYJCpW6LqnFD5O9KrXKPpyi1YGmE05OzwtwaQS9gB8R
         RtIkhNTeEImkpPj0dOF9q8z7J1tjdbkjkj8PeybkUG96IezAbur0Xn0DR+a2JU0Rguy5
         nqOvtx/OHUhHgbuOU8+IUOPmNOme8kNnYk/1YKz0C2GqCqhma1dukI44hAShxFWcJh/o
         j5BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769216053; x=1769820853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ypT2ScJN5jRu324D8R3Gm5Zq8pTI726Gt53mcp0XdfE=;
        b=X9oJ+h48V4arB9nLabDFCY98FrI4pLoO382ZwPui3P3D2W/ypOoVkzbZT2WwuPkSLl
         GLUYFmk/Hgg0gLvk8s5AyJRwsNG3lpZxsi1KldYRFoseQNXkyicm2nQuGRpEW9eN1YvL
         gTxt8ZKqUE9IS90QENS4MDRpOPh6zxEgVf9QxBacB0Q+Q5W9Guc+jW4/KBijAarB7KXi
         u4e5W0M8c12sXzHvxSC62AsTKqmgFWGRZRjgf/moM7ck2HztxkzvjbhYsuuAhjDCgSvn
         HvSsiVptyyExos5xpi9DYDJu2BD9JrY2prOkySygClKmta6QoY/zaeLFN7WeI4tnNLCp
         z62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769216053; x=1769820853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypT2ScJN5jRu324D8R3Gm5Zq8pTI726Gt53mcp0XdfE=;
        b=ROd5BGATM0tMysSmIQw/1AfGU+zLb84FrXMURnCQ+qxZcV/AMUmhyv2GkLLIbpoLe2
         Sy/EJGzmiYYsUWyXylB26GzB/gNZutLavcBEtuEoCRcVPs6fDWeEY5/OENURdJXUz4a/
         nT8404SzoaQ53vU9FR2K6d6aCP7vwa6SUKCe6vp0xX9u2Tw0CLoOwISBRndHB3B4qOWi
         r8s1ndHZ0m6BXqumhBAK39urWJwj6RDjGOmS9D+/osOXsijmR1CevxdZ7r2658SjYx4N
         6wUldAZ0d0wMm1fHxImGdP1fY8VRjkX1gfk4S94IDdktwpvDXOI1biHUgtzgyPhVBdFQ
         eDIg==
X-Forwarded-Encrypted: i=1; AJvYcCUdYmu/jwxff+NnzWBy1/HHwGKCLYNRQe4nxXJd+3SnQV/nP/PZ1qRb0dk8aZ0/Y07roxUvk2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXwnGTsSzErqDsFH1hpK8hulNRI3zfWJaXfJRHcTqVOK1x7YE4
	yErUQ+gg5BBZjXQYQTXTrUXiWn1S4nKld/eZzj8rHaueCKJ9Mr1uSP7/rVGhN4UcFc+Ers35Wvt
	kZSOe+MC/cX1CoGxBVREo+QrqCyzckmmVwW0CaqaqnvSIyFwpSxV+v+N2PAiHPjRrcvdeaOp7eK
	MdMlZ6fnZN061uFjGAYVD/0WabBlrWMUi2gg==
X-Gm-Gg: AZuq6aLrsMRTq6sOsAh3zGiL9fioaHaWXJ0Qym5mEXvGZN+ZCeqokoeeheFdgQUTgT8
	J0p8IiurwuQPovyl/+UIrvHldKl2qhxsyEEeA5youjRAF4xqU3JZ6y6Yrpyncoo0ke8BID8ushi
	pklLZoSx/99wCKotV9wRqMfuA8dKmBlmccSo+YdlPZQwI3ZvKORVyWbxuEIV6/djD5DH0zbfTEa
	SgIUS/Zah8d6sKVlSZCBIacIw==
X-Received: by 2002:a05:7022:660a:b0:11b:9386:a38c with SMTP id a92af1059eb24-1247dc1d3c2mr2254082c88.47.1769216053137;
        Fri, 23 Jan 2026 16:54:13 -0800 (PST)
X-Received: by 2002:a05:7022:660a:b0:11b:9386:a38c with SMTP id
 a92af1059eb24-1247dc1d3c2mr2254058c88.47.1769216052652; Fri, 23 Jan 2026
 16:54:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221164552.19990-1-johan@kernel.org> <aWdaLF_A5fghNZhN@hovoldconsulting.com>
 <aXDt6v_iO4EFCqyw@hovoldconsulting.com> <CACSVV039g9CcAKhtMAwn=hH4hMT2nV77vxiasgUSFF-sn=+JgA@mail.gmail.com>
 <aXHwrnMS2aj_PYRj@hovoldconsulting.com> <CACSVV00vk95aYZPrVThoAnHzBUsCHXxnSoEHJNaoLdyJJBOZzw@mail.gmail.com>
 <gofqva7heojs5d7hi2naihqlpkfttjocdazdg4yjqrkeqew5tw@bp57c7rvycpa>
In-Reply-To: <gofqva7heojs5d7hi2naihqlpkfttjocdazdg4yjqrkeqew5tw@bp57c7rvycpa>
Reply-To: rob.clark@oss.qualcomm.com
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Fri, 23 Jan 2026 16:53:59 -0800
X-Gm-Features: AZwV_QjZSDbfsgVXlqFUWImTwV-kCK27tq9V8fSTEX_IRAyz8vlv3X-k5-2yZDg
Message-ID: <CACSVV00_FbOuihnFYwda8xxEdtaBEDZ75dtSBPg9oOXTzzR6gg@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/a6xx: fix bogus hwcg register updates
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Johan Hovold <johan@kernel.org>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: F6yTIfcxFJUdt-eLeKJ0f_YU5yn-Mpk9
X-Authority-Analysis: v=2.4 cv=LvSfC3dc c=1 sm=1 tr=0 ts=69741836 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=51pYYRa9bS4eTvwAioYA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDAwNCBTYWx0ZWRfX4orPI2yLGsRC
 KMzFb10JCzZLTXVmkGUsiXw+I4WW/bp/SJ42dA7/WNREaV9Q64BEM5B1vjLDUPD2KXwW06Wirio
 05bcwp23cJHxXoERx5rrIfte7X8NPE6nLyYW035GatfWR8NAjwt58LIsnhyj95bmqOPFUOG161t
 Wg+xt3nEab4MCfUnPACuoepffg8MX2Znl8/a5DCkoIeiLb9UtCs01f0CW2judfAeLItZJstqJSn
 L5OCSRaIXB1dUPVWTI0939VzqIjmsVojGWfB9pQm/6pexNlFT7+XJ0OP/iRJjY6tCOmSStxNhSd
 0AoVc+Z8Kp6H1kI/XDCjzNXNUaC84msfg98IIVomF8gsMmSz3eo/c+nhTJTcFhZ3y3bdRLHOk+1
 JhGts9QUS3owkT9rBO0Dn6FVKg2pyda3Na2Nk07F2+MK0nsS1ZlGVXfRt/b1i1WUOdio5HxkjXI
 dMvTMd+apFBA0RpmmVA==
X-Proofpoint-GUID: F6yTIfcxFJUdt-eLeKJ0f_YU5yn-Mpk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601240004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211437-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,kernel.org,poorly.run,oss.qualcomm.com,linux.dev,gmail.com,somainline.org,vger.kernel.org,lists.freedesktop.org,ffwll.ch];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rob.clark@oss.qualcomm.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	HAS_REPLYTO(0.00)[rob.clark@oss.qualcomm.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:replyto,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim]
X-Rspamd-Queue-Id: 408287BD10
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 12:01=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Thu, Jan 22, 2026 at 06:48:58AM -0800, Rob Clark wrote:
> > On Thu, Jan 22, 2026 at 1:41=E2=80=AFAM Johan Hovold <johan@kernel.org>=
 wrote:
> > >
> > > [ +CC: Dave and Simona ]
> > >
> > > On Wed, Jan 21, 2026 at 08:59:51AM -0800, Rob Clark wrote:
> > > > On Wed, Jan 21, 2026 at 7:17=E2=80=AFAM Johan Hovold <johan@kernel.=
org> wrote:
> > > > >
> > > > > On Wed, Jan 14, 2026 at 09:56:12AM +0100, Johan Hovold wrote:
> > > > > > On Sun, Dec 21, 2025 at 05:45:52PM +0100, Johan Hovold wrote:
> > > > > > > The hw clock gating register sequence consists of register va=
lue pairs
> > > > > > > that are written to the GPU during initialisation.
> > > > > > >
> > > > > > > The a690 hwcg sequence has two GMU registers in it that used =
to amount
> > > > > > > to random writes in the GPU mapping, but since commit 188db3d=
7fe66
> > > > > > > ("drm/msm/a6xx: Rebase GMU register offsets") they trigger a =
fault as
> > > > > > > the updated offsets now lie outside the mapping. This in turn=
 breaks
> > > > > > > boot of machines like the Lenovo ThinkPad X13s.
> > > > > > >
> > > > > > > Note that the updates of these GMU registers is already taken=
 care of
> > > > > > > properly since commit 40c297eb245b ("drm/msm/a6xx: Set GMU CG=
C
> > > > > > > properties on a6xx too"), but for some reason these two entri=
es were
> > > > > > > left in the table.
> > > > > > >
> > > > > > > Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support=
")
> > > > > > > Cc: stable@vger.kernel.org  # 6.5
> > > > > > > Cc: Bjorn Andersson <andersson@kernel.org>
> > > > > > > Cc: Konrad Dybcio <konradybcio@kernel.org>
> > > > > > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > > > > > ---
> > > > > >
> > > > > > This one does not seem to have been applied yet despite fixing =
a
> > > > > > critical regression in 6.19-rc1. I guess I could have highlight=
ed that
> > > > > > further by also including:
> > > > > >
> > > > > > Fixes: 188db3d7fe66 ("drm/msm/a6xx: Rebase GMU register offsets=
")
> > > > > >
> > > > > > I realise some delays are expected around Christmas, but can yo=
u please
> > > > > > try to get this fix to Linus now that everyone should be back a=
gain?
> > > > >
> > > > > I haven't received any reply so was going to send another reminde=
r, but
> > > > > I noticed now that this patch was merged to the msm-next branch l=
ast
> > > > > week.
> > > > >
> > > > > Since it fixes a regression in 6.19-rc1 it needs to go to Linus t=
his
> > > > > cycle and I would have assumed it should have be merged to msm-fi=
xes.
> > > > >
> > > > > (MSM) DRM works in mysterious ways, so can someone please confirm=
 that
> > > > > this regression fix is heading into mainline for 6.19-final?
> > > >
> > > > Sorry, mesa 26.0 branchpoint this week so I've not had much time fo=
r
> > > > kernel for last few weeks and didn't have time for a 2nd msm-fixes =
PR.
> > > > But with fixes/cc tags it should be picked into 6.19.y
> > >
> > > I'm afraid that's not good enough as this is a *regression* breaking =
the
> > > display completely on machines like the X13s.
> > >
> > > Regression fixes should go to mainline this cycle since we don't
> > > knowingly break users' setups (and force them to debug/bisect when th=
ey
> > > update to 6.19 while the fix has been available since before Christma=
s).
> > >
> > > Can't you just send a PR with this single fix? Otherwise, perhaps Dav=
e
> > > or Simona can pick up the fix directly?
> >
> > Maybe someone can cherry-pick to drm-misc-fixes?
>
> I know that there is some process for cherry-picking into
> drm-misc-fixes, but I think the end result was frowned upon. Neil?

I'll send a pull request with the cherry-pick

BR,
-R

