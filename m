Return-Path: <stable+bounces-163413-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA968B0AE22
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 07:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742E93B1ADD
	for <lists+stable@lfdr.de>; Sat, 19 Jul 2025 05:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6417F9E8;
	Sat, 19 Jul 2025 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="S/TxsSbq"
X-Original-To: stable@vger.kernel.org
Received: from outbound.mr.icloud.com (p-west2-cluster5-host1-snip4-10.eps.apple.com [57.103.71.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44079221FC9
	for <stable@vger.kernel.org>; Sat, 19 Jul 2025 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.71.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752904226; cv=none; b=uu1id6UC7SHpv4UN6cOk+jjm2FxIshFhRLLbLMNMNn/TdIoyXBVOxMmJ4C1GuzLvz20DImw+dc/mouObVE9BwEvBNkGr/oultdpXuNHExWKmGA4V0BUzDwYwqnbi5779mFhlg1N4p7ymMsVsoXUtvTFYONSLAQJjNZ1sXx5xQho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752904226; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=o0Z9AKIRKgVE6eLp0nOJJB2j5EfMrN1R5jAgYUMrUX5/XYXViDa/Uva9K/GN1kmiCqAsJ9iibLXaDC8LtDg11H7BpDljWueryJVT4HVqhnDqEF+Yp3F6DTzRih029AKwV61nLM4n/1SsFrhmx4JRb8TxbMR/UZ2Q/z3uRlLdlc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=S/TxsSbq; arc=none smtp.client-ip=57.103.71.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPS id AE7E718000AC;
	Sat, 19 Jul 2025 05:50:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=; h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme; b=S/TxsSbqeGSJf9flHaAPnIpX97SAKndQLyNbCyCO7WdJ9ZsOkH94mbR8L61wZ3LnSm+gWWL3uaaOIbAVhAhg9+OU13BmMVw4qonk/MNYPX3KU1N4c123OC8LPuw7NL6zuVGt70rccJjOpHbfEM/u5s2WtAoqiGMAyiXy/TpDMEIxTIydzukgU6lsiLKBwQPLQB8Hf3JDZ0qf7kC9+QB+tOAZODuzq6FDQdZ6SwaZHtEhztlNVq6TjozYnVdLRsURgrddjZM0Kh15PocJQyXfeuZ9RQqhSMNcZ+jHIwKTb1jgCmFkkO1PGbK88fuxBddJ+3zevzqzH7U8e59ELmlnjg==
Received: from smtpclient.apple (mr-asmtp-me-k8s.p00.prod.me.com [17.57.152.38])
	by p00-icloudmta-asmtp-us-west-2a-60-percent-1 (Postfix) with ESMTPSA id 7EDE9180018E;
	Sat, 19 Jul 2025 05:50:21 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Logan Matthews <matthews_logan@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 19 Jul 2025 15:50:07 +1000
Subject: Re: [tip: x86/urgent] cacheinfo: Allocate memory during CPU hotplug if not done from the primary CPU
Message-Id: <9793089C-DC0B-45C8-8E2A-51A1AB89D486@icloud.com>
Cc: #@tip-bot2.tec.linutronix.de, 6.3+@tip-bot2.tec.linutronix.de,
 aherrmann@suse.de, bp@alien8.de, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, nik.borisov@suse.com,
 ricardo.neri-calderon@linux.intel.com, rrendec@redhat.com,
 stable@vger.kernel.org, sudeep.holla@arm.com, x86@kernel.org
To: tip-bot2@linutronix.de
X-Mailer: iPhone Mail (22F76)
X-Proofpoint-ORIG-GUID: l9VyhONhGYzhs8Wyjb5icWg2FVHGtFKd
X-Proofpoint-GUID: l9VyhONhGYzhs8Wyjb5icWg2FVHGtFKd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE5MDA1NSBTYWx0ZWRfXxEbN+IAhz12s
 eIZZCooizB8n75AozvXdkVqdWMCH9ewsJsQxGjpmScNbcJJJr06Gpj9nUSoDdh6sJyx/owdVFdq
 2FLlDELSI3PnTp34XU2xkbylZViTtieJ+XzyXngHOOvmk1yCXxwZ5Ev9jehfUGSPS1yTpaZ8VMt
 vHRE8coRqOe7in8Zq3f3sggQDcGdB0N2Aas7hmF07jvWfVWDXdlKpzI55rFTiOuLPBfDrYM805e
 FYlaaULSA0X4wpeJ5BwnvWg4aqGm7qJRFo5mhEJXcUum1gw2ZXSVTNlKkGUxf7HDU8sjZ2SYU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_01,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=993 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507190055


Sent from my iPhone

