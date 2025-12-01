Return-Path: <stable+bounces-197990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6846DC993C8
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 22:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595E13A5C4A
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 21:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F24286409;
	Mon,  1 Dec 2025 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EHHPZjfp"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E69284880;
	Mon,  1 Dec 2025 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625450; cv=none; b=beiwkONUq/gjaMKKTRVzoG+xlVUVM7i32tzO2BfNuRfYBrvN+gsFVDWpDNUYBqqKyWBZjOAUFhbmeWnkpsxjVIkiyWIOo/EPLLNDv+tgpQjXJU9Zb5RRgN0t/jSRPD1zlqeUzisPMPZJY10zP5nfYDtmoa8F4crXEqAoYCGeFfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625450; c=relaxed/simple;
	bh=E6Rhv/tJ2hEDgz7yTm0pFAHOKDxma4OuIU7aHxubNMA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fcdYCMpZKoW8bK5R9PLoTcORxEt6TrWThafctYbXOw8MyFn28yzEvJO3MJxZix/o3JpaatoqGHYPS2z4iuZaAz2kWy+H9BXMnPOULuLlwaZFxYcD6cyGwVPbjfdgpczniwXsJx9QV7EVwZ7iLzMq1fgJZYpSvDO7yjfw6DA6uF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EHHPZjfp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1CRia5016310;
	Mon, 1 Dec 2025 21:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sFnTlL
	VHUMVDwA5Qhit+E1JxCZEgDKtreNNYyq5PeuU=; b=EHHPZjfppdPq5zcFUeYT/I
	ypj0xTM1RZ1CZfHOlLcyCrsyfUVj7b1MMAbcQakhZ+Y/ojUAsJc6W/EpgzQK93Ky
	n8RJXtOoYZFYDS9yuGte+88ZQIWps9n0Z7j26nYhKiRLzqcEf9s72MiqkHha7VH5
	S7u6GHKioze3SgbEOAuK+B30ewm0nDiliPBPHPoglzkwM1ibo5ZbSXl/e9/qiujO
	ySSFs8lMet+GZrJSI1j7behheWlTJCVKUA/xx6C3h2o9AJW8+cCBBHa2LncV7rGy
	s29RxcFSrncONhrSVfC9N6N/EqhXoY52Px/W2Mr7cpPKSKiCB5gApMXWvYKKnksw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg59ds6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 21:43:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5B1Lhbp7028957;
	Mon, 1 Dec 2025 21:43:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aqrg59ds4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 21:43:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B1I32rw024111;
	Mon, 1 Dec 2025 21:43:36 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4arb5s90a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Dec 2025 21:43:36 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B1LhaMZ31785516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 21:43:36 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F0BB58055;
	Mon,  1 Dec 2025 21:43:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0109D58043;
	Mon,  1 Dec 2025 21:43:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Dec 2025 21:43:34 +0000 (GMT)
Message-ID: <ec3c1b29004d1be28563b20765d6a06ccdf18db5.camel@linux.ibm.com>
Subject: Re: [PATCH] x86/kexec: Add a sanity check on previous kernel's ima
 kexec buffer
From: Mimi Zohar <zohar@linux.ibm.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        henry.willard@oracle.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar
	 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen	
 <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin"
 <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Mike Rapoport
 (Microsoft)" <rppt@kernel.org>,
        Jiri Bohac	 <jbohac@suse.cz>,
        Sourabh Jain
 <sourabhjain@linux.ibm.com>,
        Guo Weikang	 <guoweikang.kernel@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Joel Granados	
 <joel.granados@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Sohil Mehta	
 <sohil.mehta@intel.com>,
        Jonathan McDowell <noodles@fb.com>, linux-kernel@vger.kernel.org
Cc: yifei.l.liu@oracle.com, stable@vger.kernel.org,
        Paul Webb
	 <paul.x.webb@oracle.com>
In-Reply-To: <633a35b8-207b-4494-9a4e-24706abd3990@oracle.com>
References: <20251112193005.3772542-1-harshit.m.mogalapalli@oracle.com>
	 <633a35b8-207b-4494-9a4e-24706abd3990@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 01 Dec 2025 16:43:34 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EGXTxdRBb7VpO2d8-s12I1AjKsXX57ye
X-Authority-Analysis: v=2.4 cv=Ir0Tsb/g c=1 sm=1 tr=0 ts=692e0c0a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8 a=T2lyslEfkrqj0XkuWYIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDAyMCBTYWx0ZWRfX3MbjJj7A9V7S
 UMiv+OJ/4ZdXlSS4g9vzLrORDo1JYF6gSOCz2c0CjouGRUiYW5S61NkykL6l2jy96Hb3+Y2dEaV
 pZ0Wt2lL5iBsDShluQ6HODOHqN0aIEFmhpFgjBgGo5v2LMGJF3vGCMOxUOYHMr5Z1N27w/F/nuu
 596RbFSPoqI0Gdau7DFIaDUmd309hYHgTE0hVfl2z4vsjboNbj1QalGhhyCrHGLCaTOvkrZhh26
 33T51BnsIeGfyID+omfgxOzks8fPmeg3bLHAjxoDMCImh8eYIib30dBn9+dbQvYMCp/VRAB6Nzk
 Y2KnfZZqMUU7Uzd4nemztntT6MrQrSYtwUXI4ZIJVT8HE7F2FOO/kml/SvgNnRYQyNeOAKvPXbG
 2H7G4Mr83E9ECL/oYQlTVAG4zoHHsg==
X-Proofpoint-GUID: Hg1-WYaEZPM9FHjyRCSFyFzs4EravIky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511290020

On Mon, 2025-12-01 at 15:03 +0530, Harshit Mogalapalli wrote:
> Hi all,
>=20
> On 13/11/25 01:00, Harshit Mogalapalli wrote:
> > When the second-stage kernel is booted via kexec with a limiting comman=
d
> > line such as "mem=3D<size>", the physical range that contains the carri=
ed
> > over IMA measurement list may fall outside the truncated RAM leading to
> > a kernel panic.
> >=20
> >      BUG: unable to handle page fault for address: ffff97793ff47000
> >      RIP: ima_restore_measurement_list+0xdc/0x45a
> >      #PF: error_code(0x0000) =E2=80=93 not-present page
> >=20
> > Other architectures already validate the range with page_is_ram(), as
> > done in commit: cbf9c4b9617b ("of: check previous kernel's
> > ima-kexec-buffer against memory bounds") do a similar check on x86.

It should be obvious that without carrying the measurement list across kexe=
c,
that attestation will fail.  Please mentioned it here in the patch descript=
ion.

> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on k=
exec")
> > Reported-by: Paul Webb <paul.x.webb@oracle.com>
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Tested-by: Mimi Zohar <zohar@linux.ibm.com>
>=20

