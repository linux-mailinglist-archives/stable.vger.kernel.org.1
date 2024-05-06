Return-Path: <stable+bounces-43137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C559B8BD50A
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 20:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D5BB2442E
	for <lists+stable@lfdr.de>; Mon,  6 May 2024 18:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADAB158D9B;
	Mon,  6 May 2024 18:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="QROozGPc"
X-Original-To: stable@vger.kernel.org
Received: from mr85p00im-ztdg06011901.me.com (mr85p00im-ztdg06011901.me.com [17.58.23.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813EB158D9D
	for <stable@vger.kernel.org>; Mon,  6 May 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021956; cv=none; b=JSDE8bXtlRttvYWrZOg2mO40foui5wwbCFNN4zAobndooeAAeLL0T3u8UH6k8G2wf0cVgw/NAGABY/cXUBwgVFHLX64EVr+VRLI6PwUW681nHQTzR84DRB7H71+3kJXTaaDkEz2xXkN0MVY0JOOYon5H7K2zrRcB44UX+gYcVTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021956; c=relaxed/simple;
	bh=5IIESbR3d7PDTj2PZkx/M3SXR6EBw4Yas+xIOzHKpLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGTvspH7yphYvYRdJ7l7qeORN/rVrjcKxZVjMbD8QGgnTJIH22pVhelNKWy2Jwf9Q3mZo03bcMOf9OJPnfvwOeRppWx0XioiUNceHwgyWOlPsystxAELod38Ys8FrxQQivfrEpaPppHMaCdGMFIhzef5S6BKCmzdR/y4Ms1WjBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=QROozGPc; arc=none smtp.client-ip=17.58.23.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1715021953; bh=5IIESbR3d7PDTj2PZkx/M3SXR6EBw4Yas+xIOzHKpLQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QROozGPcQ1BDbPD4y28JbBRKN8LWKB27xIcPMiaIEh+VN6WaolzSOcdjbnDSIukAL
	 t6vMVFJukvGFtLxk8qgKXEeAgaTPfGZoGgBi+TcXLL8hJq/SDyCx2N+uLjwbwkSgmT
	 QnER8wQqp//NHU/DPf//zMscGt/buGwifowkoi5xdc2irEjFK8Lz4PP4Zzgn9aYmRF
	 ZzQCPbI3zsqY/itae2MjQ9r2LIJDSKEf03n+whJHakELkm4ejMtPRK501D1pqXwhnF
	 DvCMxnbYiigPoKJnM3GkcG8XFZXpbKHhv0uuvc3mQmXxCMxVLZFjHeZwgw0EI5RMwj
	 YNKT6MShzmirQ==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011901.me.com (Postfix) with ESMTPSA id 47DD61349F79;
	Mon,  6 May 2024 18:59:12 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: dan@danm.net
Cc: airlied@redhat.com,
	dakr@redhat.com,
	kherbst@redhat.com,
	lyude@redhat.com,
	nouveau@lists.freedesktop.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] v6.9-rc7: nouveau: init failed, no display output from kernel; successfully bisected
Date: Mon,  6 May 2024 12:59:10 -0600
Message-ID: <20240506185910.17917-1-dan@danm.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506182331.8076-1-dan@danm.net>
References: <20240506182331.8076-1-dan@danm.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: a1gJzvlb2jdxZFrF5r8DGOtd09gwGmcs
X-Proofpoint-GUID: a1gJzvlb2jdxZFrF5r8DGOtd09gwGmcs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_13,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1030
 mlxlogscore=563 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2405060137

CC'ing regressions list and looping in regzbot (both of which I
accidentally left out in my initial regression report).

#regzbot introduced: 52a6947bf576

