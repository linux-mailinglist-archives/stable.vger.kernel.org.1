Return-Path: <stable+bounces-272279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k/ykJ13YS2pEbQEAu9opvQ
	(envelope-from <stable+bounces-272279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 18:31:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 909ED7134BF
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 18:31:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ErDesEsz;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jw0OsGhz;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272279-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272279-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B4DF31B4E3D
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 15:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C55432BDA;
	Mon,  6 Jul 2026 15:47:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92103E8C6F
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 15:47:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352869; cv=pass; b=jT00vvFFX8b8yDVesiHbbkNyPxof2tQSZbx5RUtSExZW6jMEPkDCBtu/EJaObqBNY5blS37/2WjwR5TtJUKwJ7+5ZlYpaJQFCCQc5W+aynyeEDBcbp3AO/WYIqV5qw2my1qWQjE7ecW1GEvcFfMmhPRNUZ0Gq00wwJx9pH86sso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352869; c=relaxed/simple;
	bh=RKcq82o+IatSlpbgbrVf1lQcaa7ltx+vix63gvV+M4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUD0ASi8P2ZqZneH97vGlDebQBI23Y/yMXjFQlHlUeg/wF21hkBxDozfvMcOQ5qkYpByZgBHA3xMpBKstUXsvfh2uYfD38BcVjaQAqNAKMH77cvmheYTDQtTTxblfuAVu2sjE2LSB1G5FCJAbtASB3SmbEhwdlB26pkLZuoxN0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ErDesEsz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jw0OsGhz; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FF71I833058
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 15:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aB+/IM/FHaAjTb1Q4NNCYcOveXeSruZofTueHVwJOeY=; b=ErDesEszR03MGw5d
	zYUoc7iSaLjFtyM/iUV3KX526SOPJAe7dsNLiIpfz8FF133C0yduRIQzvnDGn9oN
	Zi8qGhzu86kMoL72R4daHYlYA6G2iZZS/MVuT2HHNJulRBfFJRXQsxK4dNeWrM8d
	8Wo+KVKoSwEOn7YpsWFMPXfSCAMkTFv9FHSdUBSpXZUsRQCxMrL6aESWXxcvEZIV
	Py61iOFd85zy4aDaTBCvambabJ1JbDPvF/iC2IqUV3WKccSrhrL/DiEzMKpsjNje
	Ko6+EtEGNe0wNC+bVea59J/Tg7p39LCzrnHI/eIaLEwf+lQcpaM+bO30PPAOy29e
	QOoSHQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98hh7a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 15:47:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8eb8914e651so63243026d6.3
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 08:47:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352866; cv=none;
        d=google.com; s=arc-20260327;
        b=R8Kkctcz9ulnXxe7N99QeuUzLZBAJ2EPzfgaWGY8Tv+wIv/Fclu6oUQIttrNFQ6Agw
         LcEhitdGjbR20cdkwghu/hPawEK/cG6vb9Ejk7oI87XqG3C93aB/p3iKVmfjkr+3mNmk
         az32nUufN/FiTt2F/vgi3/4Cx6pt12l0jZvafXB5QEbA0ogFyhqAWgnKJasnJb8ofME9
         048VBqz2C28vSx90cPddEVgwJj43e+rFaegy0QoSL8DOw6RjeaAycQvx/rxS8gp8FioJ
         6MYNynzs6PVgUSg+dANpYCfqnG8wytjwysiHYet66tx9lhnwp0yuRiD/qN95ctJS0qBi
         vAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aB+/IM/FHaAjTb1Q4NNCYcOveXeSruZofTueHVwJOeY=;
        fh=Mrl8cdc3fUL5EhI4OOjPbfNOYvnP4xo4JxSz1xbggjY=;
        b=qazrr2/6SIFOD7FGVCLMB25/0co0lrE42A2buakuu0GaU4KhY+yhXtLTWRTH6F2O8a
         scrE6h4pt1O3g3AtxTd8etQwmMTnqVHSxzAaSH3vYSp043R3AHKAA1pUp5JFFgobU+wP
         Owu5xh0jUUel9BkrIEGl92g373GNl5BB1RUKkPr5Zx0M0HdIiszkRyI5tEzgV8f9pUdA
         kV90UovL7Bw48/3ZPj9/ndtxA9vTHSeQX4DXJlfmdIT9RKeSb178Qb4IBBX7Cs0jxsmv
         GjWQlVPhrChuaa5ynNHazMoHMx/TTPXXCqjarF7jDP397FyOGCriH4nG3pqFHpJ8ICIs
         6XNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352866; x=1783957666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aB+/IM/FHaAjTb1Q4NNCYcOveXeSruZofTueHVwJOeY=;
        b=jw0OsGhzg5FZ5gDM9B1npzKnXAjj+jW6kOKssetxqScjWmTYE/VbT59EwITKdSCm/9
         tkho9TowzSVUdVI72poc4dlJHywRRX/5CRG61Hf1Cww/Pee6rVXS0K74v8gpPA8PvaA+
         ytsNKpsqPCX8D7CYKg0K0Fc6riOMFfpb5pdB2s7BwJIXaOfLOkJb0gso8tk+krCdtSDp
         1uhiDw6Zv4ZpSLBW6NexhPThqCodhyYIODvQ+ghix7YRFzg0L2sOpOOwzXrIEgz8czj1
         N9Ucs1e41SIwFSXDx7hXNfgcfkvSySMykEOJMjA96bhdVO5Y5nerbYEXzWuGdkiNJjy3
         AgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352866; x=1783957666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aB+/IM/FHaAjTb1Q4NNCYcOveXeSruZofTueHVwJOeY=;
        b=EYRC4MEMnvlNwaqEXBqWubP4aGyzQzXfqsFs/rQlwcTwcQDMcGnfLi5jK6Xs1wClp+
         GFTZdK+JmOaz9V01jXieQHjOIbx8YNRGNNCT14j5x9A3Md7zPWqogHzcUzFjQsutZI5J
         UxenrJoxAj3WoIqRxdG19TU3TdoLc8f91oabWSLKoScCxdrR6K5NMFNuL3ASFuwyi9QK
         pZMIMnFTYdFOHk+ZN+jXO8jk7gujaq/wBiZa8XLHhSa850C1iqg68KFzGYF01G/4koWH
         BG85wPjVQ18mmVMLtada/At0wfJ9mXCv9OHyyUtGWDYvErcfyxGuIH4aUU1x5oyaGLFF
         ctyg==
X-Forwarded-Encrypted: i=1; AHgh+Rp3DmrfwOGNZ6cOzubiHZPMoj0sKoQ/YqTRciYuriWl/pWJY4jPbxpGxLkFVchzNVA8KRtDBVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoKmjA9TO5gZQ7stwhZZtL1bWpIiP+JAWPjLQvlAXdyyrlLDoP
	szkYotPas0AlAxfBF2jWUjmBV7igJdARF8OUIS2KDtzhjKAL+bzt+Zlg+JS3WdgAIZp189bC6DO
	Vu5s+GqZ18Z4765pos3++O8FQc2wlhb6LGMQvL7XDTm992MbhsbnWi+TuqZS46dyxzXwbFBjhQg
	T1o92Ct6OWtUXOjz8IcaqGnOkmyBxFPtZRlg==
X-Gm-Gg: AfdE7cl49bvs+WHYJndLiMwPIG0ZHw0XFaRi3px0uFQvlidvnDBaN/TKGVW05J//W1g
	TRqaL/pmmhSMVuTniwxyk++AayJ/lQl9uAp5EapQ/OpCXYv7X8nHcGt2SMhXV/fIJ3KJJ0aRNHK
	P7oLl1bh0+Rj5/moltiWrI4kDgDGpB58u12l9DWGG/+vQvjm4qgPbZLbVl1OELllqBxv87
X-Received: by 2002:a05:6214:19c9:b0:8e1:6c6e:9612 with SMTP id 6a1803df08f44-8fcb2a85d71mr13055696d6.22.1783352866093;
        Mon, 06 Jul 2026 08:47:46 -0700 (PDT)
X-Received: by 2002:a05:6214:19c9:b0:8e1:6c6e:9612 with SMTP id
 6a1803df08f44-8fcb2a85d71mr13055186d6.22.1783352865595; Mon, 06 Jul 2026
 08:47:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706114218.907-1-ao.sun@transsion.com>
In-Reply-To: <20260706114218.907-1-ao.sun@transsion.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:47:34 +0200
X-Gm-Features: AVVi8CeAnDa519BBIGFgvcJJMaeYsdKC8qNJU7WmqIK1pBgl7ciC_41RXpYlJpM
Message-ID: <CAPx+jO-oC9eBuejURDanXi8nxeuUAxQcZWJeBRuaqMhoSoKAoQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: block: fix RPMB device unregister ordering
To: Ao Sun <ao.sun@transsion.com>
Cc: "ulfh@kernel.org" <ulfh@kernel.org>,
        "avri.altman@sandisk.com" <avri.altman@sandisk.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "jenswi@kernel.org" <jenswi@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hongyan Xia <hongyan.xia@transsion.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jiazi Li <jiazi.li@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4bce23 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=3xJz9W2bAAAA:8 a=VwQbUJbxAAAA:8 a=InJrZTXqAAAA:8
 a=znh_XOoVjrxqlL3qVLcA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=amiGZ1mxdzcEAW_x1qlF:22 a=WwJ7OKCui7YMbFU4sWpb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MSBTYWx0ZWRfX9vTN2KPRYz7F
 pWpDVLJt2NZ/z9bwMgXvKZOXwwcQHGyfC30MN7IWR+BnKYpuMcNjYNySpUe++XMM3uRrK926krX
 aOQybFEqhvz+wFamIQSHdy70GjrZjVFk9U6FP+MDMPwLFBw4ayWhbi/hDFaebimvZBGfAToTmXx
 NR/jYtTKz6hqqiGV96t9n4UrSNFJGdBFw4MWC1ivYrDbI+R9QtC5NIbBoL90aFAkwcxBb/Ioock
 /0lFSzMULoSQS9urz+nYbOIfuE3vsjlKyjVy5vlOwhptqN7W4YObO/i5mlkHy21c9IJ4a4EfYqf
 NlZOdE02bky2hNTH70yqYiY07mn1AqgM9CTBeNRpjVnwF+3vpzR9v/J0dTOAVEkpzVGH5XwVGl7
 +AgklXaxXYXvwbZhr9Tvaq1UT3liGeckHGAbqshQnUfNwYuBKmzfeRqYwMtRAX5Fqz2ndo5AWa0
 cMuIWYqS8DsSLrg+euw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MSBTYWx0ZWRfX7t6RC+UUKe26
 cpgHc+3h4S2r0UR5GNGiom3QZE8Q534W2Zcc3OJ/gVvPPi6+Oaf/S6qwbbyifKW6WqCal59Xm+3
 2KVb2VAW5aivAvjmLeY8Z06OfStBgBw=
X-Proofpoint-GUID: r9pGoQ3cm1he_NHYAJmEnpyN6zZ68By2
X-Proofpoint-ORIG-GUID: r9pGoQ3cm1he_NHYAJmEnpyN6zZ68By2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060161
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272279-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ao.sun@transsion.com,m:ulfh@kernel.org,m:avri.altman@sandisk.com,m:shawn.lin@rock-chips.com,m:beanhuo@micron.com,m:jenswi@kernel.org,m:linux-mmc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hongyan.xia@transsion.com,m:stable@vger.kernel.org,m:jiazi.li@transsion.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ulf.hansson@oss.qualcomm.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@oss.qualcomm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sandisk.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,mail.gmail.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 909ED7134BF

On Mon, Jul 6, 2026 at 1:43=E2=80=AFPM Ao Sun <ao.sun@transsion.com> wrote:
>
> From: Ao Sun <ao.sun@transsion.com>
>
> Since commit 7852028a35f0 ("mmc: block: register RPMB partition with
> the RPMB subsystem"), each mmc RPMB partition is represented by two
> device objects:
>  - the mmc-owned device (`rpmb->dev`, backing the legacy /dev/mmcblkXrpmb
>    char device) and
>  - the rpmb-core device (`rdev`, backing /dev/rpmbN).
>
> The child RPMB device holds a reference to its parent, so the
> parent's release callback cannot be invoked if the child device
> is still registered.
>
> Remove rpmb_dev_unregister() from the parent release handler and
> unregister the child RPMB device in the remove path before tearing
> down the parent device.
>
> Also delete the extra blank line between mmc_blk_remove_rpmb_part()
> and {.
>
> Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB s=
ubsystem")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiazi Li <jiazi.li@transsion.com>
> Signed-off-by: Ao Sun <ao.sun@transsion.com>
> Reviewed-by: Avri Altman <avri.altman@sandisk.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
>   - add background describing the two RPMB device objects
>   - add Fixes and Cc
>   - collect Reviewed-by
> ---
>  drivers/mmc/core/block.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 0274e8d07660..54a923ba4f1e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2715,7 +2715,6 @@ static void mmc_blk_rpmb_device_release(struct devi=
ce *dev)
>  {
>         struct mmc_rpmb_data *rpmb =3D dev_get_drvdata(dev);
>
> -       rpmb_dev_unregister(rpmb->rdev);
>         mmc_blk_put(rpmb->md);
>         ida_free(&mmc_rpmb_ida, rpmb->id);
>         kfree(rpmb);
> @@ -2930,8 +2929,8 @@ static int mmc_blk_alloc_rpmb_part(struct mmc_card =
*card,
>  }
>
>  static void mmc_blk_remove_rpmb_part(struct mmc_rpmb_data *rpmb)
> -
>  {
> +       rpmb_dev_unregister(rpmb->rdev);
>         cdev_device_del(&rpmb->chrdev, &rpmb->dev);
>         put_device(&rpmb->dev);
>  }
> --
> 2.34.1
>

