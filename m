Return-Path: <stable+bounces-227282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAw2ICDtu2liqQIAu9opvQ
	(envelope-from <stable+bounces-227282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:33:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D256B2CB325
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 13:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A656130528B7
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 12:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D001C38F250;
	Thu, 19 Mar 2026 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VRYLePfg"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB7A3C276F;
	Thu, 19 Mar 2026 12:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923589; cv=none; b=dzFNPALYQiREFc+yEH78pvc7JuDwOPmBpuBB9a512/fSzZmTN+BvuA9nq/GEyr838diGSw4+kaM9qJaRk1ZiXRyU9/bx9XHGqsJT7975R3BucxehVIHZQ7vLqVFJYkGy00QYEB1rrQihZTF1XPHHYBmgTxNpn//33Zvqn4G1mGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923589; c=relaxed/simple;
	bh=N27ahFw1ZBizl0h7Zwjm0dpCzmOeXXzbYldsUFXquQs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=l2HcWV+5vmCGwZhyvYOKuNoZOydew21lQ6HLwQyla8riVAZKLOSg6/UdlwYhb/qnyPd2zcq8CFvdkdFpJUgcBvH3NSiEXpbTV5fkVMbYHh5LQaEbIkavlhfZ9rj34LJSq+sXF/+gDBFQBjB9gROTNC1JcSE2lQfYFjV/VsigG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VRYLePfg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J7e4h34126484;
	Thu, 19 Mar 2026 12:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mcG1cM
	n+x4FAYugSHz4ekqP1VrokLHlPvJh6XHSfTOE=; b=VRYLePfgVRm8yobs5NYLL/
	49oQX8X2I8VnBmEqlBpBKOeRXOGj3IA/oyQg0aIXjZEjqZ0RoM8758b+dQjb9h2Q
	bN5xwfof5Ws3ByWTjjptd20yMU2kUgv09F/y+LTF9eodMfYDLcJosQ+EZN89IuKj
	liIKCE+inwKbuI11ZJN0ioht/b0Dlf6geUramXv/r71A5dcQPDXTIjFyCNyZaQ68
	ajOFFcGuY76WzpPh4j+HbY0Dol4dNRKb3Ge+vkKWYKZJ+6rznlwgW91RGvSFAdxP
	F9+XJPJ4iiM4WSNk3YQl2n2m7HwqzCY5Ybd82rzffsVQCkJjEP9GhNJGlT85x1DQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64xyeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:32:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62J9VDom028765;
	Thu, 19 Mar 2026 12:32:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgkjdek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:32:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JCWiZM57409830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 12:32:44 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 429A458058;
	Thu, 19 Mar 2026 12:32:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E50E58057;
	Thu, 19 Mar 2026 12:32:40 +0000 (GMT)
Received: from [9.52.215.169] (unknown [9.52.215.169])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 12:32:40 +0000 (GMT)
Message-ID: <f17b03652a84be73c1d3a2cfea8a016dab99f8e0.camel@linux.ibm.com>
Subject: Re: [PATCH v10 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA
 deadlock
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
        linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, bblock@linux.ibm.com,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, mani@kernel.org, lukas@wunner.de,
        kbusch@kernel.org, linux@roeck-us.net, ionut_n2001@yahoo.com,
        sunlightlinux@gmail.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, intel-xe@lists.freedesktop.org,
        matthew.brost@intel.com, michal.wajdeczko@intel.com,
        piotr.piorkowski@intel.com
In-Reply-To: <20260318210316.61975-1-ionut.nechita@windriver.com>
References: <20260318210316.61975-1-ionut.nechita@windriver.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=mQINBGHm3M8BEAC+MIQkfoPIAKdjjk84OSQ8erd2OICj98+GdhMQpIjHXn/RJdCZLa58k
 /ay5x0xIHkWzx1JJOm4Lki7WEzRbYDexQEJP0xUia0U+4Yg7PJL4Dg/W4Ho28dRBROoJjgJSLSHwc
 3/1pjpNlSaX/qg3ZM8+/EiSGc7uEPklLYu3gRGxcWV/944HdUyLcnjrZwCn2+gg9ncVJjsimS0ro/
 2wU2RPE4ju6NMBn5Go26sAj1owdYQQv9t0d71CmZS9Bh+2+cLjC7HvyTHKFxVGOznUL+j1a45VrVS
 XQ+nhTVjvgvXR84z10bOvLiwxJZ/00pwNi7uCdSYnZFLQ4S/JGMs4lhOiCGJhJ/9FR7JVw/1t1G9a
 UlqVp23AXwzbcoV2fxyE/CsVpHcyOWGDahGLcH7QeitN6cjltf9ymw2spBzpRnfFn80nVxgSYVG1d
 w75ksBAuQ/3e+oTQk4GAa2ShoNVsvR9GYn7rnsDN5pVILDhdPO3J2PGIXa5ipQnvwb3EHvPXyzakY
 tK50fBUPKk3XnkRwRYEbbPEB7YT+ccF/HioCryqDPWUivXF8qf6Jw5T1mhwukUV1i+QyJzJxGPh19
 /N2/GK7/yS5wrt0Lwxzevc5g+jX8RyjzywOZGHTVu9KIQiG8Pqx33UxZvykjaqTMjo7kaAdGEkrHZ
 dVHqoPZwhCsgQARAQABtChOaWtsYXMgU2NobmVsbGUgPHNjaG5lbGxlQGxpbnV4LmlibS5jb20+iQ
 JXBBMBCABBAhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAhkBFiEEnbAAstJ1IDCl9y3cr+Q/Fej
 CYJAFAmmAWs8FCQl6sYAACgkQr+Q/FejCYJAn2g//UKzlXOgizdk0wudLooRbGzDo23ktGSPK5Oj9
 9o5z6v4Jz5+qOHo5835683cqkMLM9//udA1ZcKV88LVwyfmoHChPW24cWBmOEy7RJOWCR4WeEINaO
 pZUGF5YOx7oKTkPs511ky2FR0Heg35754pgTuTMEpYzRXr5pNMPS8mHXcXSARFPDPaCF+uBJ9BafO
 L7XbpSwKRttePsWAlPHbSbloeDApBfHUhcF/pbuM9GNs+c/8V9NK+SwwqNK214t7jaSq9k+19/hfE
 jvU45nbiYQM4VqGCelxVFRWol93JnwPFp/JaMgxgV1VYFH9Ijtgh+qNVVBqO8bbTjioFKy1bHdprN
 9GyPLDxoaI/lBg+5CwKewzazUjFd0xaqZbTXSgNK4ev/IuNI3qZV8tpvZZWwIgZU1K0Bhplt8Sku+
 O9Yl2H54erq9zuzwXjqBJtoW0+MaKbe+1gZ/v2/AVE2VeQMugPUWDg+2bpJaApRkeA4xQ9XfeW6Bp
 It7xYrwwbVhQtWRC0sRh+QNlU9HI28wPSnLWn7HFBeWupaIrxSp4IEL3eHUn8xv4aA8lpdNsHXD/X
 vqOSUwy5jlTPTlemvwaC9mNHagNdVXng8C6+hxiDLhZ6xH2P4qNHTKmjW61NsdF6Y/HfWP+lmbi8/
 474UNCltDt/fP01ajqogfWZKFymoH0O0KU5pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNjaG5lbGxlQ
 GlibS5jb20+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAAstJ1IDCl9y
 3cr+Q/FejCYJAFAmmAWusFCQl6sYAACgkQr+Q/FejCYJAtIw//WmQW/Z+SLdfrlDH5J2bvixzFNnO
 TOvp8uM8vcNZsxZwPXem4AeCXHayCqipxpa0iXWufEIvdMxkBxWvvM//V+rTUgQnJe6nhDxfLGklx
 5Mb2H+K/ndS73ElCuA30MPYq7mHr8i3gEmi2ZFX1W47JecJ8hno/DQxhHRG7bd+GFsiKCbsjLWXNq
 s/VaAK9uyOTQx7m6/2nR8L+Mvl1BrRXwkj7Qp0qxfQSd4r+IVNBzNFOcrGagBqsyHrN7Is7IICktH
 9VFl/G8P+hfviHQLnlxw9ltzpM1Dy6N1+BM3kbqD59gX+L6wqiLJI42eh+SHCiy35FvD3AFlYx4jZ
 MWE6qIgFnbwcL1kvcA7nnwfr3ZizCYPm8e334xXxslXBoRGsvjXSbAeAyZo2dvJXffNHdcDdUbJSl
 CfOixNGGKiQvs00X9ekfq9WmmRFvmYHu/m3lg1OXnMjFFIO41O51ZdhbEYJiqZEki7jA8Hd9xuWwQ
 nFDHhacU3xxivZ4BKQGQc+4XZ3yp/q6+7ux9prepRy/LeRyoaAmE67oxEsAgj+qyA3Tfy5nRTDdRQ
 E//gpaIt9H1VEx+68dRWHroxBQeozpnFPi25AlX3k4/EtVZjcItPWgE9iru1qT4DH3BBrz7Kd1zUw
 NnQC77zDJyZD2WUj1E+5bftO0aeE+7HZXj3tM/ea0K05pa2xhcyBTY2huZWxsZSA8bmlrbGFzLnNj
 aG5lbGxlQGdtYWlsLmNvbT6JAlQEEwEIAD4CGwEFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQSds
 ACy0nUgMKX3Ldyv5D8V6MJgkAUCaYBa6wUJCXqxgAAKCRCv5D8V6MJgkF/TEACOY2kL4NGFIbWeM5
 TUhatxqe8c3RT6jvNjq32CkvaK/cSZzBkS0smddyOzxt2WnsvMgkr9cM7P+CevoMwhT3e0lgQbqBD
 /vXZJjWKddC+iKXeqWkjMVcgCOsWNZ7PWEzRUT5X1AEFq2zzxQAQ/bCWEYNqIbHN4b6G1Wk+2Y598
 +KypZ3FS0bwiItnPQOWzOOqJCGxDxaEUuXFx4ah8HtVdtIev8jPS/5uzQO9iG2vZQUWeMEYZtfMHW
 sbFWqo2A3lxB+KPzNIYFhul4Lyx1CwvKUAGSHOx7FZuc2xI5DYt/Wdh2QyKFYr7xVzv3uwJjeS1+3
 6gvyB7DJaQuY+PziNPv4GPr5wy0cRkJ6Ps15fgC6y6wNwoNdNXKlwiuclIsBzJKa7A0pZMIfpCpIJ
 bEHP7oy3drBRAhIrBx7Lx1lyqqodDqc+ok5IQ5WcKG/TOrH732mTmJX6fxYTiCVxcU4WLJSNZbrZ/
 pjF0AWXs7E+onAkQy6RLg/XU1iiU5QdMvug+fTA6TpPSUMdujWtGWUt3/4nC+69AVc8tXtRQTZ7gP
 t7uIcQFwPqUuJGS26vl0w/6dIABQAyU9acvE3adCZra+/PBKFZi/yxT1WgV1T2mexKSWwQgLcR57J
 Yp5oWnQRgi/S6fAoskIWkp9UVcfAQPY0p45NwO5cZR9/g06JZmyrQhTmlrbGFzIFNjaG5lbGxlIDx
 uaWtzQGtlcm5lbC5vcmc+iQJUBBMBCAA+AhsBBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEnbAA
 stJ1IDCl9y3cr+Q/FejCYJAFAmmAWusFCQl6sYAACgkQr+Q/FejCYJAz4A/9F+dMhzu7YonagL4qh
 WDz5IpRD4vzYKOBZ+qwYp1ugJz1BIUppN9i68HKoS4ARfgP97Sv9GpOy9g7L0lymH2MPF8hRPK0Yn
 7DKIkeu/r28YWEoWfoVm5reC+gpxMgmxBz4JScE4f6xfa7+Nw0bbTDl+nxftJD7lf/dTiruNJsXph
 HQnZ5wPXmxeH6XVJikfpyrGe8iJZALbtHtjlx6Omu7NvRGikenB8trrWS5W0F60ZdbqH1HdmDDcrZ
 pDq6LtAARHK5tGRm0SK6sZpKe3nULFeeCt7T/edk2FC6KVh4sL1jw1kyceX4DjiMffqYBPrhK5gz5
 cDIixLBF9C6Wt1ObvuDBrIQf1/3q6EZrUrUuf6qtaXDMuC6cSlShm47qaPEvVYh67O9JZQ7vzvaea
 UI74DJUb8Pjnz7mTOmMOzsS1gUhCue4n2YSSM6ythioCGb/3bgMGTpuer3JhvZG5s5uKD9yyj8s8x
 35qJkCFfjmjVx9s3vSUS48X+cUpYcMispErKzFu7C0YgKoxvJ4XTfXlDBiMFMPYcN67hsb2jeYHVJ
 wzE+fIZiDx9JLh1oQW2krwjweisE+3glOaKXZKi0fBtkxyH41iemLtLNYZRJopv6ykdl3hiI+Nh+a
 3FZJPTo/OpqchMm8XIeDxC4NFFiPMpyLeYzIxO7eZpiGrAjVTE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Mar 2026 13:31:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: eVP1vqJOyEtMGwcLW5h6xIaWlOGbJnIw
X-Proofpoint-GUID: L3Pp6SlIPl_E7clyvTFa6lV4-zt8vJm6
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69bbecf0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c92rfblmAAAA:8 a=t7CeM3EgAAAA:8 a=YXg4lgfTRo1lIok0YF8A:9
 a=QEXdDO2ut3YA:10 a=GvGzcOZaWPEFPQC_NcjD:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5OCBTYWx0ZWRfX/aASoHBg888c
 G8H6plp1hrK+U2KWktpLY0cfuM33cQTaW65CidKLlEB3qXnAwVr7AtKSiE5a1yRYqWvCX595MqW
 vsx4VAQKPoTZcutd5T0sO9/S1eWt0OMSiop2UBQUVNgcF4cN6tUCamgavGWcmMq/jMElVfMh9Fp
 GQ1LzlAxLuBEh7V4jcY7FVKa4P0JFWAQvWsMTHQ+GuGoXVMSY854isNDjgLyvWQ0zHLmzqkosHM
 fPv0kUEc+HZGZTxlSccEy+JvTO7u6Hyz4M61o8cVE6M73h69E6bQGAXSgJN9j3p35pU1yaSFQ9I
 WPgc9+Oj5ewjGunQlCPCzfYFiPMdti0847k5TDeAOHXxGC5cHPn5EiLRIPFwn4NxKnA8RDfq6Xq
 EiR7N6ykXr/bqObgt73zVKJQvF4sJkLHIFaKnYlXUq5IXOJFSM8SMiT9/tpXsPlTXk9vzjpk/gP
 NIVDXNjqFDA12b/aPXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190098
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,mageta.org,nvidia.com,wunner.de,roeck-us.net,yahoo.com,gmail.com,vger.kernel.org,lists.freedesktop.org,intel.com];
	TAGGED_FROM(0.00)[bounces-227282-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schnelle@linux.ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: D256B2CB325
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-18 at 23:03 +0200, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
>=20
> Hi Bjorn,
>=20
> This is v10 of the fix for the SR-IOV race between driver .remove()
> and concurrent hotplug events.  v10 adds a second patch to fix the
> AB-BA deadlock between device_lock and pci_rescan_remove_lock that
> was reported by Guenter Roeck (via Google's AI review agent) and
> confirmed by Benjamin Block.
>=20
> The AB-BA deadlock:
>=20
>   CPU0 (remove_store)               CPU1 (unbind_store)
>   --------------------              --------------------
>   pci_lock_rescan_remove()
>                                     device_lock()
>                                     driver .remove()
>                                       sriov_del_vfs()
>                                         pci_lock_rescan_remove()  <-- WAI=
TS
>   pci_stop_bus_device()
>     device_release_driver()
>       device_lock()                                               <-- WAI=
TS
>=20
> Patch 2/2 fixes this by calling device_release_driver() in
> remove_store() before pci_stop_and_remove_bus_device_locked(), so
> that the driver is already unbound when pci_rescan_remove_lock is
> acquired. Both paths then take locks in the same order: device_lock
> first, then pci_rescan_remove_lock.
>=20
> Note: the concurrent unbind_store + hotplug-event case (where the
> hotplug handler takes pci_rescan_remove_lock before device_lock)
> remains a known limitation.  This is a pre-existing issue that
> Benjamin Block is addressing separately in:
>   https://lore.kernel.org/linux-pci/354b9e4a54ced67f3c89df198041df19434fe=
4c8.1773235561.git.bblock@linux.ibm.com/
>=20
--- snip ---
>=20
> Ionut Nechita (2):
>   PCI/IOV: Make pci_lock_rescan_remove() reentrant and protect
>     sriov_add_vfs/sriov_del_vfs
>   PCI: Fix AB-BA deadlock between device_lock and
>     pci_rescan_remove_lock in remove_store
>=20
>  drivers/pci/iov.c       |  9 +++++----
>  drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
>  drivers/pci/probe.c     | 11 +++++++++--
>  3 files changed, 33 insertions(+), 7 deletions(-)
>=20
> --
> 2.43.0

Hi Ionut,

For your awareness, I saw that this series has some findings on
Google's new Sashiko AI reviewing tool[0]. At a quick glance the
findings seem like at least reasonable concerns to me. I'm still
looking at this independently also of course.

Thanks,
Niklas

[0]
https://sashiko.dev/#/patchset/20260318210316.61975-1-ionut.nechita%40windr=
iver.com

