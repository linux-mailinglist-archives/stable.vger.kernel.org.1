Return-Path: <stable+bounces-105384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCC49F8967
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 02:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7317A5030
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 01:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8D2594AE;
	Fri, 20 Dec 2024 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C6SoAWux"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012AB2594A6
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 01:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734658068; cv=none; b=RFYRGjVda4fpYQXaOFMjpGmaRFj1YYwgXbesbCYEcaAh9g3w/eC8afiaP4di8nDOWy8Jos/maBrVmJzgpwp1DAI8wwgeq01nyy+JgETpkLQHfgx4M7As+djnvbCxFE1bpSuA9CoIb56BSw43M1gxxl3Glabxua20StyBwexlot4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734658068; c=relaxed/simple;
	bh=KGS7K+MoAkqBkwktSTaBbbM4h8SUhCHXW1uXvxvnwTA=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=hYa2WOoXU+ZdU6Hp155mTv13P5Uv6RFGGfSCfCxdCTXb1hLYlqViiDKB/fWWysFWOGzonLHcWemQQA46aVekMOCtwOwGSODYecDfpcDUEOJd0MW5AXfwju5evvuUzCA3O5WHr1XhBzwjPaT49HrQF5L/+MZBX2AUbQJXmwgeorM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C6SoAWux; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Mime-Version:Message-ID:
	Content-Type; bh=KGS7K+MoAkqBkwktSTaBbbM4h8SUhCHXW1uXvxvnwTA=;
	b=C6SoAWuxwn5ld16qIStgar2AvEWxNYuQXRhB4q88vZtmqEXPIwdMJDBQlkZ98C
	lRWmlVZLHSPfTkrOAY/ay6Cm0jjUEXvo45ZQZR3wqLqxMIDDvwYh+F6BGIXT1riH
	QkJ8X0sFX4/Mrcq3J1XvOiiHW5OZA1hE1BJObO3F3GXbk=
Received: from ccc-pc (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wDHZKHpx2Rn2EJ8AQ--.50828S2;
	Fri, 20 Dec 2024 09:27:06 +0800 (CST)
Date: Fri, 20 Dec 2024 09:27:06 +0800
From: "ccc194101@163.com" <ccc194101@163.com>
To: jpoimboe <jpoimboe@kernel.org>
Cc: peterz <peterz@infradead.org>, 
	stable <stable@vger.kernel.org>, 
	chenchangcheng <chenchangcheng@kylinos.cn>
Subject: Re: [PATCH] objtool: add bch2_trans_unlocked_error to bcachefs noreturns.
References: <20241218212707.zjli7be5qtamdfkx@jpoimboe>, 
	<20241219055157.2754232-1-ccc194101@163.com>, 
	<20241219225859.fw6qugbyoagrx63a@jpoimboe>, 
	<20241219225937.7jjii4kg4hc3d5rm@jpoimboe>
X-Priority: 3
X-GUID: 4B2E06D4-1168-4D2C-9A09-60E2545702AD
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.317[cn]
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202412200927046763162@163.com>
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: base64
X-CM-TRANSID:_____wDHZKHpx2Rn2EJ8AQ--.50828S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUUMKuDUUUU
X-CM-SenderInfo: 5fffimiurqiqqrwthudrp/1tbiwh273mdkw5KkvwAAsz

PkFsc28sIGlmIGl0J3MgZm9yIHVwc3RyZWFtLCBwbGVhc2UgY2MgbGttbC4KCgpNYXkgSSBhc2sg
d2hhdCBpcyBMS01MJ3MgZW1haWwgYWRkcmVzcwoKLS0KQ2hhbmdjaGVuZyBDaGVuCgo=


