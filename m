Return-Path: <stable+bounces-244948-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGdaIvMs/2mT3AAAu9opvQ
	(envelope-from <stable+bounces-244948-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:47:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0EA4FFA68
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 14:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A20DF300D4D6
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F7E363C48;
	Sat,  9 May 2026 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FV/YmYW2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4D735CB6F
	for <stable@vger.kernel.org>; Sat,  9 May 2026 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778330855; cv=none; b=MaYDwGhML4+reobTy0cKHmyd4y38habLARCml5m56Wuxy7iRcsrs6AlCC0i8qvNadIuRuGNylnSPXXV1dsZmD/3sEUJtyrM5krW/FFGwH0iEd1nL8EC0v3Gk8syzOgFqkNRoSVwmuofljetjBE9tLvkXYe6AI32xOYbCykYUiuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778330855; c=relaxed/simple;
	bh=zAxomcLG1evawPY4O8wJgxeWsFaTTqxg//LHvMqyKc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDqfAiN7Ah5fIaSDurQ+xLCX0PjpMHTffzuhlZYgdENJ9CwnfefIf9pAT9vN6tyPLI780eBGepAU5PIc/GuoSax+REVRrRRwg92c18DSb0qNviND9ocpNJUQlIrJKMi2UED82Ruywlj1Pn6M6y+jXtg9ib0OQdnFoK7bXWBaZkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV/YmYW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD76C2BCC9;
	Sat,  9 May 2026 12:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778330854;
	bh=zAxomcLG1evawPY4O8wJgxeWsFaTTqxg//LHvMqyKc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FV/YmYW2NVnz210GpL81rZjmzmcld0pjtZyn+rByY7I8mVMUq7trYAFacM/hPSU3J
	 ZCMf9JWxfDPIOI0lnj74mpnL1/W7Dk5OrnEi+29hOj2q3mAxJff/mQdwqVNBCEfqU0
	 9GVwiKnBcTQsHwRpETF7D6+JAl4Be60hiXZGBZ/CLsVl5/+Jqh4v216XPEkoYhsoQ+
	 W4uxviL7q7ZK/xYg/VOM3DEE8apGiBWR2oqTCC8sky9QUjQshCXQS6yLAfYLgR3Dkl
	 9cdZg8x1+OG/TzwY4ECsAMk+Y9RPKLbesyURT87RY2h78+AOXT+nCj23Fdx3avOeqF
	 M4VS6V8maLpaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.6.y] net: txgbe: fix RTNL assertion warning when remove module
Date: Sat,  9 May 2026 08:46:58 -0400
Message-ID: <20260509122858.a582d0ebd559.re-txgbe-rtnl-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <FAAC012B43535C92+20260506063000.658745-1-jiawenwu@trustnetic.com>
References: <2026050105-ascent-escalate-2044@gregkh> <FAAC012B43535C92+20260506063000.658745-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1B0EA4FFA68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244948-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> [PATCH 6.6.y] net: txgbe: fix RTNL assertion warning when remove module

Queued for 6.6.y, thanks.

--
Sasha

