Return-Path: <stable+bounces-49911-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818C88FF098
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 17:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F711C22EC3
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60AF19750B;
	Thu,  6 Jun 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="f6LE7G9J"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2193B195FC4;
	Thu,  6 Jun 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717687452; cv=none; b=H3CMHlLdi4TSBZ3h6FoBARdXfv3nYjOHmFPEpWoTviKlvv3fQletkBXDEiI4HL5QyHsiX7n1Fdp2WltByI1FDwspGLNg13nDARNBMdM4sIx5KSf/biGkVDCCA5XeQb2/D52Klbte/UiwX16j92I8c+TjnustEeDyqAxw5Ly+wR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717687452; c=relaxed/simple;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=lgggtE++19xcmYvMEqSzyq6Jd7SCdPdbAHR/HSwMIohEMgj2hUfmptC3JJGaPs36tupGoVvSIs22akWUHN66UiO7/u3DHq/mac0U7tej4Jq2Oo79veBWEOJF19RfbCNSmSS5mxg2h8asg9JTPapDA64Eua0aiFKCZO/o2asymfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=f6LE7G9J; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717687447; x=1718292247; i=rwarsow@gmx.de;
	bh=dmMdDLN3YgL1qMEqV22WwccWKGPvTDnUyQtKaq9KA84=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f6LE7G9J51x7ZNPzr/qbXfyfG4I2b+iCi35jN/KhEF7P9njurWsu5aINj9KJdK7n
	 jtsLPoxvytwSMZ3MD9fj8Alj/AJ+26MIbYcmLby0GWps1Fv0diEE54kJgtk8gzgRb
	 D5siftXrQaBenp2nEhHBvgnTk5rFVcMQYYiot7reSmp+EQjgd4M72J6Snwojm6NSd
	 EYrUKTtoBTz/kJFzBamUl3e5CVUGXPT3Db8YL8U1Kqomoes8xuA3tCu6C3ogHHdTb
	 e7rdAX2TmJKssomsYnhPpqCLSDjVNFqOwUn40hItnat8IHzbE0DKeCj/cyiCExgif
	 GBckdDCynXrskK3FEA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([87.122.70.213]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8hV5-1sJLhW2jYn-00Bt54; Thu, 06
 Jun 2024 17:24:07 +0200
Message-ID: <1be3f6b5-097e-4021-b2eb-b82658047c33@gmx.de>
Date: Thu, 6 Jun 2024 17:24:07 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TFn5+pAQ9qs1rYEiLy6WJ5wI8sO1kB9yYoyxWNzNcWYWZwdLg8l
 dyH/1JJGGFPMuK9OaO/XKxeONVJnHcfoWCHVEjx/cHiTrFCVTLCWRvfGjg37Thriagn7EWA
 0oZ1wsiW9XI5O+uohZWk50VN1GhYPp40DgwrmkLxh7EElcBmXBNAp3A1SbgDIZrknjFN9xX
 lXy3CsteRoLNfZTvz+fmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ovm+qdVJBG4=;V/+QDTg3fv/U3ewQ0WvB7iXHNP9
 0vzZB2im2yfd/I8g3s7RwDwyE7uLTHVr2Ih9taeiZSPTTYAYassAEB5GsntAnDcAPmHGYo6JL
 N0ThxVhjIkcDScv3lC7MwesH6RGry8ruS5uyQndK7AJob2sfqUBKjisKGu/B4jzqw/jBVp3BN
 60/31I4684EykCL7uHqX+dTsOxsUj206Lgucs9JoAYlW9U/wjFNI8+BBVvdR9+AmDM1+9AspM
 gyX4vEiBcfq49A7zZJU087TdMR0oxV6DJhWQfGnLzVSl09aSKMyS05Pvp4Q8fWKbncmxKbABI
 5S0Emk/3EgoqZLpwW8nUUKq9ZyyBRmDBOrl3ecQQcazaOdX8+1ugvX6CtVSD+rb6Jc62Oo0JE
 A8vvRJoCVYk2kK4ZqFG3XtKKp7U1hOI1YaZke3EZW/cLXnJ9wK/IBKLFr3zJCXt0wySz2J04A
 y74x5GMjjzQT42yns1M3mQth46SeMvztAjzKhEkB/J+gIfgOILiPzjz7gSoy4ZqThiqlPUl3P
 fM3IcddLjKa4uV97hMmeK2HEjmxVRcQs7veuST5fLn2oqmj5ffvMV13/wgq7mgJU0UMb8ehDt
 0S4KfuA1XuP97RNKvL7aOB4fX+BA2anxMBUouwPcH1/syJuHVobV0u9enP/QI8eGCmHsZtwZo
 ET70ZB8xf89TEk4MPrMk8g82QUKDcxpcAmMy5GRhX28yBMLH2F7p1z2V1LqWpjK3XKUeNd/d7
 hJQFnIZMOOplSkPuDNEAeOKK1EhpSAx/ZNZcmhse50lAmst0sTFcu/2DmW3eR2xcWDp1LmxsS
 I5zqZW8iGu9Tir7G0C6cr6tmXXkdy3yAiyTYtk3UyECxM=

Hi Greg

*no* regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


