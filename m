Return-Path: <stable+bounces-192206-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69EC2C185
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 14:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4637F1893D08
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 13:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38BC15E5C2;
	Mon,  3 Nov 2025 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="LrpAneyB"
X-Original-To: stable@vger.kernel.org
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298613B5AE;
	Mon,  3 Nov 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176666; cv=none; b=hKFoGKX2EJnAAu/pc14qOejNjw+djeoUNDqNvucEEFrvPRUPPN16yvctzuh50U/AGUSotK4JeMUAnuIa3k3tXOQM8lmh9qY23sWCn24+0KPf7x+5Mob7xBe72CN5uydk/V9HEYQKcyTehIgF24lYFtc+IkAA/pfY23EhKn8c21w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176666; c=relaxed/simple;
	bh=cuf+/7Thz4o4dkUx69f6+UrYRgnQJ4miRs1xW5MUwkg=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=o2G93/cNKJX18R1g9Pm9BYKE9iKHm7MOtSg3NxxESAlUEwPcoUrTLB2gVEiaU8H4N+Upcwa1PKWy8zEkMeHzKyJsM0BpttxBthWAg/DygDmHSnmiYn5btb93LS5JT0zcJqSOYVzMf7d5AGUocDWSsHJ5CNz1SKEVizALqKH9GUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=LrpAneyB; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A36s30f1265134;
	Mon, 3 Nov 2025 13:30:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=p
	ha4iqzjLRhIK14Ep3HX/+oxy73O9OJMBOJe+Wnyn98=; b=LrpAneyBQgmlSXaAC
	6PgP4rS0pAlg52uKttIUkxS6DYWtgB87AMyGhZTBeEvc2ShPOleCvDTYl965wjAh
	Fr6mKJhBp5vYDd9w9XQtPCSet0Nfx4GtrNQMHRyq9hxTbbUxBKGtoDFksb+gkHNb
	p0mJ/po+vSGwGUVaA4sbnv3aZR9iJaYmNcMcnuTRXypr99aZc83TT0f4OWtzzfmn
	5pAgB/zTX7PD+WfY5EVUf7uqD+fy0mCdonRwD1Uniwd1x9w98olAjGwVCyYwyHoj
	l2u1kcwEH/IbHBl+YhAEf0Q6z7AuBD9I3l9GCoMR3Uk9P6iZSDzdjiy9U0/MSZTC
	Uov1g==
Received: from hhmail01.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4a59bss9px-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Nov 2025 13:30:28 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Mon, 3 Nov
 2025 13:30:27 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.134) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Nov 2025 13:30:26 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Michal Wilczynski
	<m.wilczynski@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matt Coster
	<matt.coster@imgtec.com>
CC: Frank Binns <frank.binns@imgtec.com>,
        Alessio Belle
	<alessio.belle@imgtec.com>,
        Alexandru Dadu <alexandru.dadu@imgtec.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, kernel test robot <lkp@intel.com>
In-Reply-To: <20251014-pwrseq-dep-v1-1-49aabd9d8fa1@imgtec.com>
References: <20251014-pwrseq-dep-v1-1-49aabd9d8fa1@imgtec.com>
Subject: Re: [PATCH] drm/imagination: Optionally depend on POWER_SEQUENCING
Message-ID: <176217662645.4491.9524914948435472872.b4-ty@imgtec.com>
Date: Mon, 3 Nov 2025 13:30:26 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 2Mi1LMmksvkuRAg5rwahs4ajV7TIH27v
X-Proofpoint-ORIG-GUID: 2Mi1LMmksvkuRAg5rwahs4ajV7TIH27v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEyMiBTYWx0ZWRfX5+T0LQ50f6gI
 Xov8i3k16qnn4LrK2wyPsYui34gX2dRw7luzWgTfl+bBkSQAMNm6ulew6bNP7oGAsaP8ybcrsfN
 96dg24+PgMR/UqBR8BwW8DzUH7UhX5ao19hPnLlArcgbMi6yDTSWWjaMnoyb2FNwyeyHbk80i1H
 gsIv18mOcKZ6Nq1CUGtm9FWPUljY8pvQDICLHzJUQPCCFtJiMf4P6RyJKAFZi25bvAroFPW4GvI
 ZttMUJ4NiI/MbAZPEHfvCPxg/F3DsrPWFiZxiFVgJjbFPxB8UondVCHiyvEJBe7/B/AYhyMDkMg
 LjSkZ8ERXidMdJi49pdODn+biogHkr4yG0Uj3kfB2Kg25g9W57QQv2qwYHmAZYwY3IV4uHNJWdP
 NnYygmRjiZGK85DOP8UGMuZqdq/o4A==
X-Authority-Analysis: v=2.4 cv=Yb2wJgRf c=1 sm=1 tr=0 ts=6908ae74 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=0einROue838A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8
 a=IMCeZBfq-HFVmF8d6oMA:9 a=QEXdDO2ut3YA:10 a=t8nPyN_e6usw4ciXM-Pk:22
 a=cPQSjfK2_nFv0Q5t_7PE:22


On Tue, 14 Oct 2025 12:57:31 +0100, Matt Coster wrote:
> When the change using pwrseq was added, I nixed the dependency on
> POWER_SEQUENCING since we didn't want it pulled in on platforms where
> it's not needed [1]. I hadn't, however, considered the link-time
> implications of this for configs with POWER_SEQUENCING=m.
> 
> [1]: https://lore.kernel.org/r/a265a20e-8908-40d8-b4e0-2c8b8f773742@imgtec.com/
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: Optionally depend on POWER_SEQUENCING
      (no commit info)

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


