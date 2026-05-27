Return-Path: <stable+bounces-254629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HgaEwUZF2pR4QcAu9opvQ
	(envelope-from <stable+bounces-254629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:17:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C96B5E79A8
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71331301A2A9
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFA83D8104;
	Wed, 27 May 2026 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B+cTT3I9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F905382F01;
	Wed, 27 May 2026 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898624; cv=none; b=qWr1BpO/PYtib9eVcD+C2KPZ+ttCNHHYUP9ozh/uUtyClotaZw6hycnTYCXW27DP/UAFIHhva5iJ2q3CvSuK6re6VXIWB3dek0cOGhVIeiEXJPEfa/cHrdAsF8q4FOwMhyeL1M/SXKup5wnQyaYgjlTxSMUxY8ldZsDrxiSc3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898624; c=relaxed/simple;
	bh=mZT0P/zwaX51RtEUsi0fOiyR3kTC/n5FTEuynXi8sSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ADAxtmBEvZT4pZQaAh6jCnYVQtRvh8nivU/aRXN+D8RkfJycbHSfKrw8fWtuwtfyo17C3wpZPtRAx1IQvychRV85awyGiam5HxF2PdYGSkMAoKl36cUMvHYE4TjWyqrin5ANVeg6Ua6dLpKwfqpNb4uIxCm2p1OoDoSI+usiWAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B+cTT3I9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RC0gSF272240;
	Wed, 27 May 2026 16:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=b9F+AmgWvYDlJzmEdke60GpHwUtQVz
	Dqf0WjOaCEDh0=; b=B+cTT3I9cHjb6BNxLlOprt9Z+T973dcNKzaK5AOiECzjIr
	manQXwCv1j2GW2sL7WZcIRv6Yi0lt6gjtNZ9OknuAzzuGNrhWDRxD1jxysFQ8Why
	GnKDcwVLGWwsgWUG0NMtT53WZ1cu0I8tDkQ/WtxS/ZWugiMOKPX8dldJmEQxssL/
	Omax6bdFYMejZpIbYYz85HChlDfA7PZ9bEEuf2qFCD8oQGrhM2guaTyLQ9xXP0PE
	weiUsw0wp9EbxiajT34+3BZc67bDMhlmPrg77aUDLLSUXkLN461O8+gVGaWZb5kE
	IPwT3M+ImY08HMtRuBqPgcU88hfB2jbfxMJ6JU1g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq91d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 16:16:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RG96gu002888;
	Wed, 27 May 2026 16:16:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb3tt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 16:16:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RGGfTI47907136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 16:16:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDDE020043;
	Wed, 27 May 2026 16:16:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09AF520040;
	Wed, 27 May 2026 16:16:40 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.117.77])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 May 2026 16:16:39 +0000 (GMT)
Date: Wed, 27 May 2026 21:46:33 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, atrajeev@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
Message-ID: <ahcY4S7shzG_kDt6@Gautams-MacBook-Pro.local>
References: <20260518044150.34632-1-gautam@linux.ibm.com>
 <agu2UAi6lWclxFYh@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agu2UAi6lWclxFYh@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Xu6BugMKoIkhkjlN9TsXGZnUcHw_o0Aa
X-Proofpoint-ORIG-GUID: b4h-zIYe_oohMh7MgSS0yqDDW51hSHfT
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a1718ee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=kH-xMUQrV69S-q4FAwAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE2MiBTYWx0ZWRfX2QhgFulZW/6g
 Hy7Sug3x7czsigDCKgOh/cCVjtkTjghZP+Dz/ef744228AR1+LwgPyGw7dsgss2fBD1Cz6AqKgO
 A/Qr25KvlfSitOv9ndVQacMFGfWA1PvBqNCad0OdoVIH9VWr/oklw1B2uHcIshV5B3iXJG6IyET
 TtR/Y55rm5e8ypHl0w8i+rG7TfF4TX85HEcXVQ6Ny4ZbtAMt9QHzs3eKNbP4M1XjGf9UUbwxX56
 6bg7UyZymYshjdD4/UMye7nw6k/kplm5t6jZAC0ZstDFYkfSzWhDFkbvVeo5uS988VdjTz6wU7a
 OdPHAoNvhY7kZZ9eJ9GTCiK/9+cA2tend9bHw3itshzDh9zPsMzycuKi7nlTfdq2jnsPUPioof2
 UqUgEkoM+sk1yzN6JSn11CHdCn4lx6ZScHfjfxHwggMX2olJIEV6KStSYurHyDP0q6MGsfeWKlJ
 EDpY9n0DTI+AIVsGxyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270162
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_CC(0.00)[linux.ibm.com,gmail.com,ellerman.id.au,kernel.org,lists.ozlabs.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-254629-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gautam@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 0C96B5E79A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 06:01:04PM -0700, Sean Christopherson wrote:
> On Mon, May 18, 2026, Gautam Menghani wrote:
> > Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
> > vpa-pmu driver cannot be used since it is not enabled in distro configs.
> 
> That seems like a problem to take up with distros, no?

Rather than enabling individually for different distros, wouldn't it be
better if it is enabled with KVM automatically? I can rephrase the
commit log to emphasize that this config option is only relevant for
KVM (similar to CONFIG_KVM_BOOK3S_HV_PMU).


Thanks,
Gautam

