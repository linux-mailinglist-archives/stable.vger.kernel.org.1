Return-Path: <stable+bounces-244985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBlANIGT/2nz7wAAu9opvQ
	(envelope-from <stable+bounces-244985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 22:05:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC395014E2
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 22:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93FC030125C7
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FAF322A2E;
	Sat,  9 May 2026 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UkGavg8T"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5366F3AC00
	for <stable@vger.kernel.org>; Sat,  9 May 2026 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778357111; cv=none; b=nDlqcNnWVDnml/HFHwMhkcqDlDkgAKwQ4qoTQqzPftrKICVJeG7Doxj0lDiVXA1l7vGx3kq1tThI/vUVvfxE5y7PSBltZ8pTK+7UzZdb36jnjBcVRDyo4Tb0KsVswyNhbhYgyk99aNiyPu7yVEYZ6+l28UxgyWY2cglF4nWN5ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778357111; c=relaxed/simple;
	bh=FUvArasXWYvrtFwTMRtVYK0ORykQndxP+wwelXrMhz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gbyqDX0B6kMrL0NqFpOoVYfz2KfXntav857TQ2q9/D0fKuWh6LbEKl4KQthh4k4ym+tbS0qnxkT/fTe8wuKeS2QR8pSB65lP6uXbXHv5xQaMyNnTSmrV3ddAshmALtH8grJCIzZKWLovY1AoYviMBnKbLyAD/MKuCyzlE4EwceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UkGavg8T; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778357014;
	bh=M4GUuYODCu+LO5POtXeV2wUoNNb37AUm8VPQ7anOphc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=UkGavg8TOIqFBVXHyBY0BccG+lglFVRgMlrmBmlsm0w8AynVKA/6BTM3LU94jFgMh
	 2+q6g5oHGtFhfqLtT2htP+ROSfBizYrYK0Y2XGBTb12+4JSErX0Zi+CC4Qh3I+lYyo
	 f6O+J+L9CX2WZcZwmidzYXTQ2+JsrK4IuyTWLZlo=
X-QQ-mid: zesmtpip3t1778356994t9b00d6ec
X-QQ-Originating-IP: ri9udWC3UoNv+bYpQPuP+3b6+lU4XDDmqsE6FyA6Uc4=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 10 May 2026 04:03:12 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 5925246369997625860
EX-QQ-RecipientCnt: 10
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: dhowells@redhat.com,
	guanwentao@uniontech.com,
	horms@kernel.org,
	jaltman@auristor.com,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	marc.dionne@auristor.com,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Backport RXRPC for 6.1.y from 6.2
Date: Sun, 10 May 2026 04:01:57 +0800
Message-Id: <20260509200157.191683-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <939b8e49da80ebac-sashal@kernel.org>
References: <939b8e49da80ebac-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MZ9fszcLiRfa0oX08vTE/EZ1JOD7p8Dku2nZIgJ6vyEn69/0I9fIoIAh
	ZiP7vQ2HxR14iwQsnc8D77V8vaGaTubjD4D4j3opLzk+zFYR2rZr1DotLjxhO2XQOPtPRtp
	MF2h0fA1FKXwBux0L1cdc4KcPK2dHSJmXQ38R4+MksKi6T8a/hnt7VyK0MANaF+wLAvoXnH
	9iM/oeTx8rpL0Rjd5memCWA7ZgZoV6mtECin5kEhO1yhFOf2QlEx+KPEwEmm2xitrkpfdKg
	h5Bfn+sCQUNSbqz79DDdOgUQQPBftU1X3xo1CVYsvvdJE7i7W8JR9Z6zslho3reEjXGrhAH
	yaq51X8+nSlaQalTc3CmouVSmvj1+n1XDcqAkiE5VNsMpmb4aq54jh7uwkjOXDlI84NNaqq
	nEgkPDcRTLy+a2J7UaUdAv4KNqeP7Q6iGjmOJQZzxBLdR1gYYU8WNe+hy+bSMQS/ien4zkT
	TNRZyS54RzzDnUCjnZ36BZ/dZj3w9KkIrF4a8TdQvCEWRMk6OF2D9x2K1JiSZhe5JxJN3fR
	6jvf/EuL2MlUCUQptvnVyMe5ro4y6aqYnXSStZ8Bk1D02z2v87uxxlcXzEwOl0tjU9EIK5U
	wHCUajxVUCkip+QssC5oWtt7QL/OT/IfoI+HRpGIZtKzL5H7GT1p8R5dDJFUth6q0FNRwna
	dl10CGJEP8AoIAsqaUVbje1cPtqbjVNvqoTC+/LykWuxKPlD/MnRsJPI6dmEbGBfhx4O0zZ
	Npy0xYyPYBQao25hUOTnDC4SPhZOTXQbMyBoOTKvw0xTK+Uoy0jaFQ4pfPX8KmAkyHFGzcK
	kd3oLeoXEiuFXXojbqoQumcYfrpFweygfEIrkmaMMcdTK/aAbvNQJg9KD64s0SZ5DCLNpVR
	KodBQOVRCSlY1fQh28VD4E/v2M4Q9TYb9Mx7RFvEmdqqcSROw13PZoWbJClreJ1a9o+4IUU
	uHn7+C0GOx1U2xpvt9Hh0Dl60r8MMkRLz+6uOSTzEG3ksUkKDUPVXxChaQpvaka6Mbh3r1b
	RDS9PByrJsp22DtyIkhwPpouAvymulfCKeuydGt83XuAQcwo4/
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 2FC395014E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244985-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

Hello All,

FYI, I found the commit list from v6.1..v6.2 mainline, with the refactor RXRPC 
commit list, it will possible for v6.1.172 to clean apply for the becoming fix
patches for AF_RXRPC in higher kernel version, but it a bit large...

BRs
Wentao Guan

commit list:
(usage: git checkout v6.1.172; git cherry-pick $(cat thepatchlistfile))
(from git log --oneline v6.1..v6.2 | grep rxrpc )
4d843be56ba6a8c0e566afd58775742d9e721505
334dfbfc5a7187c99761df2392dd4cc49c453bea
589a0c1e0ac31ccba49b214762e444dc015ee1e2
b015424695f03a9fa5862d09c267ed458e256300
f2a676d10038e8f3913dc576397b9c9efb190afd
f7fa52421f76309c574f2575701660bc3ea3a705
42fb06b391ace2aec5cdb1ebb8ff668f0a34332f
b6c66c4324e7dd66a06a6a034204ae7d4e95c28c
ed472b0c8783e7e3896a8fb4382f2187aae427e1
23b237f3259299b75dd2ffefc7a4af889ba308c8
27f699ccb89d65165175525254fec3d9d6b8d500
a11e6ff961a01884482b2a70ced74a5c62d96801
02a1935640f8f8539b8f2dbd6eeb539de93b2ce4
72f0c6fb057971864fe4d42b289b8e6ede836ef1
530403d9ba1c3f51c721a394f642e56309072295
faf92e8d53f5f03842da25af971a3f0ef88ffba2
d4d02d8bb5c412d977af7ea7c7ea91977a6a64dc
5d7edbc9231ec6b60f9c5b7e7980e9a1cd92e6bb
a4ea4c47761943d90cd5d1688b3c3c65922ff2b1
4e76bd406d6e9208ea558953862a47524829688c
d57a3a151660902091491ac2633134e1be92557f
6869ddb87d475bde2da0dbd4d71270996d65cd47
1fc4fa2ac93dcf3542f2dc6f7ff88fb022da5116
30d95efe06e18bd55691902bb4ec873e4b21a754
41cf3a9156ba8e13e557e7908f9e22563b1f2828
6423ac2eb31ec33f8526dc48f1e541b665333970
66f6fd278c6780ea8c8bb7dac839132d8e76dd53
101c1bb6c55691d01c73915c118828f7ca17a049
38461894838bbbebab54cbd5a5459cc8d1b6dd9b
84924aac08a43169811b4814c67994a9154a6a82
75bfdbf2fca372e2709bcaa43e8cf1147766ae96
49df54a6b2953195243d037682cffb9038f9456a
30efa3ce109d9e852a1a7bb9be19a414e633b1f0
2ebdb26e6abd2a773ab5f009ac38a6de973a2bcf
e969c92ce597baf6aeff3f619d6c082d736575e0
2cc800863c49a1f4be1b10b756c09a878d3a3f00
f14febd8df5a490acc40b919808f163e997d7f03
0fde882fc9ee9cc2e66e8c5a5a93c83932d7ca95
47c810a79844462d3468d831edc00971757693e0
7fa25105b2d32fcb0f38668bc20d0adf6508322f
cb0fc0c9722c0c001510e2a6d9b0a78b80421487
fa3492abb64b93b2b5d6fdf7a5b687a1fa810d74
9a36a6bc22ca1c0a9d82228171e05dc785fa1154
3feda9d69c83983b530cea6287ba4fea0e5c3b87
3cec055c56958c5498eeb3ed9fb2aef2d28c030f
96b2d69b43a075a38df600597133f17d28525f24
a275da62e8c111b897b9cb73eb91df2f4e475ca5
446b3e14525b477e441a6bb8ce56cea12512acc2
ff7348254e704b6d0121970e311a6b699268e1ac
4041a8ff653ec4e4d9e6395802cb3f4fca59f7f3
81f2e8adc0fd10847637873dafe8610f3fb4cdff
15f661dc95daec9b38e8e4cc931c95afe0ae0cef
f3441d4125fc98995858550a5521b8d7daf0504a
cf37b5987508878647161ec3cdba0bb00a1b607a
29fb4ec385f18db98d9188c2173a0b07d2de6917
2d1faf7a0ca3c0b327cf064c80e4e775532c9319
cd21effb0552d666b2f8609560be764a1a56adbe
393a2a2007d13df7ae54c94328b45b6c2269b6a9
5e6ef4f1017c7f844e305283bbd8875af475e2fc
3dd9c8b5f09fd24652729a3da5c5efa3ec2c4590
32cf8edb079a6a687a2b5dba39a813a0bbd0ddf9
5086d9a9dfec4866806da303115489b0606decb7
a2cf3264f331acfeb7e463ad7b7fe1ac647a829d
b0346843b1076b34a0278ff601f8f287535cb064
fdb99487b0189f0ef883e353ad7484c78a8bd425
eaa02390adb03b82f04babebf0cdd233793aecf5
8fbcc83334a7b5b42b6bc1fae2458bf25eb57768
608aecd16a31269485e2980898029dd01b03a73e
c838f1a73d77abadb0810eff0e150ac88fef3da5
743d1768a008c8eae56ead497c9ba8237b14ee81
11e1706bc84f60040578056f8cef3d0139b92dda
31d35a02ad5b803354fe0727686fcbace7a343fe
0e50d999903c009b6a9cd2277c82d6798d982e31
8a758d98dba380a7d32a98b0840ad707e3036233
5040011d073d3acdeb58af2b64f84e33bb03abd2
30df927b936b2ef21eb07dce9c141c7897609643
a343b174b4bdde851033996960bca5ad1394d04b
03fc55adf8761c546d72798264b019c9f672c578
f2cce89a074e6d2991dddc94f6b6ebe1576b8459
a00ce28b1778fa3576575b43bdb17f60ded38b66
57af281e5389b6fefedb3685f86847cbb0055f75
f06cb29189361353e9ed12df936c8e1d7f69b730
2953d3b8d8fd1188034c54862b74402b0b846695
1bab27af6b88b5c811f99de4812b5590f20d1cb7
0b9bb322f13d486d5b8630264ccbfb4794bb43a9
d41b3f5b96881809c73f86e3ca436c9426610b7a
2d689424b6184535890c251f937ccf815fde9cd2
93368b6bd58ac49d804fdc9ab041a6dc89ebf1cc
96b4059f43ce69e9c590f77d6ce3e99888d5cfe6
0d6bf319bc5aba4535bb46e1b607973688a2248a
9d35d880e0e4a3ab32d8c12f9e4d76198aadd42d
42f229c350f57a8e825f7591e17cbc5c87e50235
01644a1f98ff45a4044395ce2bbfd534747e0676

