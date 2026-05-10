Return-Path: <stable+bounces-245063-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH8mLoPOAGqdMwEAu9opvQ
	(envelope-from <stable+bounces-245063-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:29:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A53505A01
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 20:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 357F4300AB05
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 18:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAB03093A6;
	Sun, 10 May 2026 18:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HECGgpvd"
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82C2255F2D
	for <stable@vger.kernel.org>; Sun, 10 May 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778437760; cv=none; b=LqR+EsuAJUuv4wO3ew85ddhGzqGndp96rA8z7pH4vkLlKbhckxqfA8FMbHRo2v95sYaTJNT022dTX8aIY/3gCasmv+oxl/b81A8EOWGXRPyxHoezLoZvjvcmFys37cKbwokvXS1uoDV4RIlmASoQ6mUkl8W7mUMVZoLurwb8AcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778437760; c=relaxed/simple;
	bh=1mampsZsyMlKptLKO6oucCzdYZPOi0OHFTAIa/Floyg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KR1KS5wFmJXWB7CLyHz0YKmA+8vjAp5PK/IAiv1y4FYGyxH4PNdB6oxUtEtovIHW3ZF06W5aMHPX0iUECYOsuWU17xj7HQaSbPfj8WYL0FymAN+xTczUfoAtukkXiu6IHAoI480a7H3d14k90zyJiYIGUfVT4cHfroSDD7SOpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HECGgpvd; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778437689;
	bh=bMNuUh4/ol3YrMk/amsRMAwgGdXXz87hGVqICAzlwIE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HECGgpvddlFS3N0PEk7kAwCTGYHMcdGq5sU1F0vR3pmenjC85WwRO9NFTIHmdrso1
	 ZJC35Ssy3isO0V67QwvuQpWsI61dfWgoX+H7P4hLivNlWbsuz6JiaqLbhrde1i1IxJ
	 ZaKy+a7rWAx+rByJZSDVKPj1oSIEEn09H2s0NKuc=
X-QQ-mid: zesmtpip2t1778437683tb4d8570b
X-QQ-Originating-IP: 5CNZObwwTFSQ+YObACzxjlrY33NuRkBe4ePDeJDagro=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 May 2026 02:28:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 816576861715774102
EX-QQ-RecipientCnt: 11
From: Wentao Guan <guanwentao@uniontech.com>
To: jaltman@auristor.com
Cc: dhowells@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-afs@lists.infradead.org,
	marc.dionne@auristor.com,
	sashal@kernel.org,
	stable@kernel.org,
	stable@vger.kernel.org
Subject: Re: Backport RXRPC for 6.1.y from 6.2
Date: Mon, 11 May 2026 02:26:46 +0800
Message-Id: <20260510182646.267145-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <b42ca28c-b276-4850-8e46-807ab8f45fa8@auristor.com>
References: <b42ca28c-b276-4850-8e46-807ab8f45fa8@auristor.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N8tT1W7MFzrwK3eyzMGw7dqUCF+vXZ3gVstjrQQKhSpE9kP/CAtziDP0
	VzHrMdPnLwKGxKFMLnfDO3Qd6Wf+UFOde/zTgflqvwcy0GQkCviatra8/jOpVZPsoiV7V0y
	tH21u7rNVfUSkxUKv4NE75GP0NqylLzmlW1v181wq1gUHWNXXbM2jcaA0hZft6goUk2UNsK
	0uy5AfYRg9rIUjSiCgMCgdnHAOIeenD6jikvZ50TJmZ+GdajOOY+daIYz0iZAqkYQWIr5/g
	qf1mmA8GvG0767pyiG4+Ab4MhNOnTvztGaKk4aMe7G9BAWvILMureyRDVGGQjfyKbDjQFsO
	Pye8vX+3Q9qm8z4Z7yMfDYLhYtE75OwZw9XLqBRrJukDoRQhvXhR8+V/ZL4rXaJzsH9HV6g
	K2wFfqA6bvQOykkkthZZRWYI31ieDhC2FUmqzZ9tOmtvGtHoBHqxdCk8kWmFmkMrPBtX4s5
	/cawhLk9l3efMYUyye5zCifUvvxgvtmozrS5/E0ncXy/mpwWAe0w3ncJyafmw3f9lVqwJve
	of3UlOZYkRos9cMvTupZkdw/eYrr3t5pv6MyrY4pdhYWUfhIrODkWZE7KHuT/qh49Qi1Ynr
	f7Su7PMEnhTTO4NNiu7PLpmZlvNceV6wPIds8Kua0C83xLkkkewu9E+TCoXAbOAa7TK/pq1
	npv9BgPrXeQ0eQV421kBOm1zf1GMLw79LUEJhaRKm0F1EksmDupMVPw/S663wl1JxAr39Ig
	TfTdkUuzVOZcGmbV10fO2JFSJKXnMNOo1syHFMychHxwdXVj28S3YAadH9Y8d8MI9iV8fOL
	QI6kS6D0b7UdquteDDfEFHHJDOvApfZMWmWeI/pDcBAD6vu4thdTT5zLpA+VF12RoQYHUTs
	u6ut47NfPS3MuSIHhulTx7XG7pNTR6LSNWzG239OqFxBHxbnU5/mT4HalJ/7wewXUzM43Qp
	lxCC7jCqpY4ZyihXiIshyIMA1/LlN0V9C0UV26I10aXH7pK3FgJytT1Yvj/fCCY/0FnVb7C
	qd9lOik44aKlODgPPLtzc70a9YM3SbK9VVjEprgWcB656kSqlpX/IwLmG1iR4gNcgtof5KS
	bkvmazYvQaVrvHbtl2KEUc=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: E2A53505A01
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
	TAGGED_FROM(0.00)[bounces-245063-lists,stable=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[uniontech.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,uniontech.com:mid,uniontech.com:dkim]
X-Rspamd-Action: no action

> I cannot easily check but it doesn't look like 6.1.179 is vulnerable to 
6.1.179-> seem 6.1.172
> CVE-2026-43500.
FYI, to reproduce it, just runing a POC with CONFIG_AF_RXRPC + CONFIG_RXKAD,
i am sure without CONFIG_RXKAD it is not affected in v6.1.172 with my test.
POC: https://github.com/V4bel/dirtyfrag/blob/master/exp.c
(run it with '--force-rxrpc' or remove CONFIG_INET_ESP)

> Please check.
I will recheck it, i do many tests these days so I am 100% sure now,
i will reply when i finish my tests with 6.1.172.

> Please check.
I am sure that some 5.10 or 6.1 version are vulnerable with our tests.

BRs
Wentao Guan

