Return-Path: <stable+bounces-40553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DEB8ADD39
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 07:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51379282E5E
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 05:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E665F20DE8;
	Tue, 23 Apr 2024 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="M7XtftBq"
X-Original-To: stable@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7446D1F94C
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713851612; cv=none; b=TsUlgrUEtyphC4X6IKg/wmSwNI4cVAwd+BOO8pKjrcrGtP93wRMFiADIpaX5L8PnSbOpWxkgBb9IjVLZrZnvWPYhIyobs3+IzJX1l75f67hSj+fAVJyIFiibxtSMghb9HCcLey+PbZcF3HMDAWokUfGS3OzRVxR7yefVHtNZlrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713851612; c=relaxed/simple;
	bh=rOz93lr2GW5Hc7hQ2lkvmue1lB2A46lzRjrkSFIJtjw=;
	h=Date:From:To:Cc:Subject:Content-Type:MIME-Version:Message-ID; b=gpoESryMs607z20n3k3THZbGZlj2OQ+i2wqs2h5saQhI36t/a6u9BOI82d4Ucl8XEKwv9ECpdN/i2tJ9ZtFI8lTVHHR0R9llIorKNurHxHG7JqYHO5RN1IIS9FHH+B6Qz8T1ymqoDMB693r8NSc+0dr6/G+DRPab16/Gldtp7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=M7XtftBq reason="signature verification failed"; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=uFAiPgUlLvoeJ+JRyv2DUqF9d8lNGbClpwU8ulVo78Y=; b=M
	7XtftBqjcmPqtCrUxXteAVtQAKvkqlNvb3SaHKxFTYvZL2Rsn7VcGH7Nn7fFI0X5
	D63yFpT5W/zfC0uDqS4yzS3meQcERybqiR2tFMrw2B52z3xSL0sYJCQC1yao3C2T
	4RHVv2O3x9NgdIp35JtroU1g840g5KHMQsWXC1bBU0=
Received: from zhulei_szu$163.com ( [116.128.244.171] ) by
 ajax-webmail-wmsvr-40-107 (Coremail) ; Tue, 23 Apr 2024 13:52:40 +0800
 (CST)
Date: Tue, 23 Apr 2024 13:52:40 +0800 (CST)
From: zhulei <zhulei_szu@163.com>
To: ap420073@gmail.com
Cc: davem@davemloft.net, jbenc@redhat.com, sashal@kernel.org, 
	stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: 4.19 stable kernel crash caused by vxlan testing
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2aAfSevk0t5iadZekWkkYagew/X8u3uv4k1IVePZE0uST9whorekBJN0Lv39yyDAGdjyesVAhnyMdFYqJFY68Rro/wto5Xm1nx20AVWo3b
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <715eaf46.7523.18f098372d3.Coremail.zhulei_szu@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3nwqpTCdmn4sTAA--.5541W
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/1tbiRRjITWXAlyIRSAAFsU
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

SGV5IGFsbCwKCkkgcmVjZW50bHkgdXNlZCBhIHRlc3RpbmcgcHJvZ3JhbSB0byB0ZXN0IHRoZSA0
LjE5IHN0YWJsZSBicmFuY2gga2VybmVsIGFuZCBmb3VuZCB0aGF0IGEgY3Jhc2ggb2NjdXJyZWQg
aW1tZWRpYXRlbHkuIFRoZSB0ZXN0IHNvdXJjZSBjb2RlIGxpbmsgaXM6Cmh0dHBzOi8vZ2l0aHVi
LmNvbS9CYWNrbXloZWFydC9zcmMwMzU4L2Jsb2IvbWFzdGVyL3Z4bGFuX2ZkYl9kZXN0cm95LmMK
ClRoZSB0ZXN0IGNvbW1hbmQgaXMgYXMgZm9sbG93czoKZ2NjIHZ4bGFuX2ZkYl9kZXN0cm95LmMg
LW8gdnhsYW5fZmRiX2Rlc3Ryb3kgLWxwdGhyZWFkCgpBY2NvcmRpbmcgdG8gaXRzIHN0YWNrLCB1
cHN0cmVhbSBoYXMgcmVsZXZhbnQgcmVwYWlyIHBhdGNoLCB0aGUgY29tbWl0IGlkIGlzIDdjMzFl
NTRhZWVlNTE3ZDEzMThkZmMwYmRlOWZhN2RlNzU4OTNkYzYuCgpNYXkgaSBhc2sgaWYgdGhlIDQu
MTkga2VybmVsIHdpbGwgcG9ydCB0aGlzIHBhdGNoID8=

