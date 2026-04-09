Return-Path: <stable+bounces-235497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKzsObv/12kDWAgAu9opvQ
	(envelope-from <stable+bounces-235497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:36:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F7D3CF0F6
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 667663009B18
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8F2F745D;
	Thu,  9 Apr 2026 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="rWWqLrjS"
X-Original-To: stable@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster1-host4-snip4-10.eps.apple.com [57.103.76.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAC1DC1AB
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 19:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775763381; cv=none; b=uMrZjiTJvJXmtwAiq3liSJbJCcxW7Qyu0sZicz/B1P8GosRHi8ll7D0Ts7UtHVT1ouJYid+K715T5jMjL8VC3IxAOd5RHQtkHV6homMwM/zgkiMBLM64kC3pT/vd+RTHo+lfOqIcAeirsHZAjZ34c4mavEwnbJDIeZniIuvNkoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775763381; c=relaxed/simple;
	bh=BUKvuc2Nb6RV3qZ8bD5mi8DAxjzqjja1ya7SIU/WrhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZ/jZoeYncxY6LwA6F2h0T6fWDNSHQ/u77t68DLonpLwtabDFKiAZxse/gz+fdLllpEQVsLoMnQfc/b/S8aNkxXY1B98Ali/V4WvbEoc3ONXFVOhDSo00zTldMprJIb7jW1rltURPLhJKoxZ1f8jgPG2mgu76pX3LEroPTzw/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=rWWqLrjS; arc=none smtp.client-ip=57.103.76.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-8 (Postfix) with ESMTPS id 735BA18001DA;
	Thu, 09 Apr 2026 19:36:16 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775763379; x=1778355379; bh=2JhQQEFawK7tebpx0rSbiCWos0awHKnWIfLSkfuU6iU=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=rWWqLrjSstCb/HhVRnufnBXqUbOvIRBjnd0u3jxLPALfWiSa1/iBjBIOVJSLRTo4rOf72EcAap/q9yIITaYh8AaBD7f9gqMqTbOrAjJMqJHJRzOmqJc4Lv6LN9vj9mFzhuXosQo8aD/byjDaFmxKLyhmfKfX/xx9Cd/NeOUizTqBLLZFXWOb+4uWt7kbg0LN/ajrNzsw9Ic2/SgPiHMdqg3GjVeU9A6G0qVpEIXDWsapSbvm2j9pMojodmbmoxvLh6cPrAjMxjBBum28xHxAZfH4ms81N4TNkEvH5fhhLZL5Z6JH1jI2oJ0W43MVDo6iCoLkFISzX6hrWNW6TPaD5g==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-8 (Postfix) with ESMTPSA id EC3F1180053D;
	Thu, 09 Apr 2026 19:36:13 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: horms@kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	linux-nfc@lists.01.org,
	kuba@kernel.org,
	krzysztof.kozlowski@linaro.org,
	stable@vger.kernel.org,
	framemain@outlook.com
Subject: Re: [PATCH] nfc: llcp: fix missing return after LLCP_CLOSED check in recv_hdlc and recv_disc
Date: Thu,  9 Apr 2026 21:34:40 +0200
Message-ID: <20260409193552.1826407-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260409164527.GP469338@kernel.org>
References: <20260409164527.GP469338@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE4MCBTYWx0ZWRfX6MmbZlSwpXKG
 N0dpA+z8o28LWPqyfdg8DCuq6NKKXSvkNvj9BYytsEOWlBGd01Hmf7HUyJXVYvJE25/KNlgKxHI
 DQ9IwpeyvtPBP090qA2VfnFA2vaCsByoqHfImdKudSNGqiY9qcQHj8fMXPQvFGQbKs6Pps+UTRx
 QOEiY7lMnfHu73jKEW/bgujw8/bGW0z6DmmfBaXuHMCjOrVMkvMfJmjjIunxOqLLISCBS7Dkl/7
 T+O7NHFo8dDfhFA4f1jJeuxu9CRfOtu1QmX+IbHvnZA6axAKxu+2Vb33ErJRTz9bupegn936uhz
 LQqk8sbc/RBzuzVp0Z4aAAZp9tvNajMRYba9sqjxB1U16MJayHuECV3Ob2SjTI=
X-Authority-Info-Out: v=2.4 cv=U9WfzOru c=1 sm=1 tr=0 ts=69d7ffb1
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=Im72piG3SYOM60AsYe8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=d8Ku6tdDt9gA:10 a=JKcXVnpmuwdQ7RL0mgk_:22 a=NDDgNl8OaFIu1Hag6_vS:22
X-Proofpoint-ORIG-GUID: ABVW4LJNy0M1X4AYtoYVXoJiQjY8i8uX
X-Proofpoint-GUID: ABVW4LJNy0M1X4AYtoYVXoJiQjY8i8uX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1015 mlxlogscore=506 lowpriorityscore=0 adultscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090180
X-Spamd-Result: default: False [-0.57 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lists.01.org,kernel.org,linaro.org,outlook.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[icloud.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-235497-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:mid]
X-Rspamd-Queue-Id: 95F7D3CF0F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the pointer. Withdrawing this patch — the existing
submission at:
  https://lore.kernel.org/all/20260408081006.3723-1-qjx1298677004@gmail.com/
covers the same fix.

Lekë

