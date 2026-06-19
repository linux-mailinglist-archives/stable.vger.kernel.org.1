Return-Path: <stable+bounces-267302-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WbwYGgW9NGqsfwYAu9opvQ
	(envelope-from <stable+bounces-267302-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 05:52:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAAF6A3B42
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 05:52:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nabladev.com header.s=dkim header.b=B4WbqqPn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267302-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267302-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nabladev.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90CC330078F5
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 03:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F21386C9;
	Fri, 19 Jun 2026 03:52:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC7306743
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 03:52:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841154; cv=none; b=jMzui3Ic25mTzBvPwvAUbrYrG3PMfpodsFEgH54kodbbnZpHQkmKVX1DtuV+rqwJspwFfagaxBUjjDX96k+gfjRd7WxHqdX/Xr2wEGQwA800RSOwelDABxZrcX+OquRhjNHy9hoYORNr2C2zJezq9O656tgcmNshleH7kZPqFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841154; c=relaxed/simple;
	bh=W1L6RapybPqU3GszpreGeXxLT+BoTY53RWrH5Olo6M4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=WA8On+EWr2zbryZvdHKl5qNPmc2LshTUkadgBJGssdg3ZTLKqblRp38PiPXBZ9+kO2Sj0nWLLqTxaqFHWbu5Nn6N9H83BZI8TeYF2085GD2kMwRJQhv2eLukCzlo0YxTa6nwyc5zJCqfhzr3pAD1LVVo5X2GE9Fbwad6rXE64UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=B4WbqqPn; arc=none smtp.client-ip=178.251.229.89
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 724BD113315
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 05:52:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781841150; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=kbd+As49J161UDsoIgPxhFKSYbEO7uz3p2NHD0MBp9o=;
	b=B4WbqqPnSPWK7Fvkxp22YyzwtSkNgXR8mwGlcWksuAJc29frFkeMqeP5ffW3TNtZH1+A4y
	CY9S/VWrxKFVrB3D/MWXq332zYxY35+N53LM0HH1CB3J1PefE/Mbxf3RljMgYVSvq8dkmH
	0RKKGRIxcvOExsJUoLr/dpsUEcw2aLr2McTmLFpwyATopvXe0Lz44++baP8B8mGaNHblH2
	LaXF3Sd3xnmQEM39Kyq6hWZkAO4R7DY+F4f3eTG4KRu1AYN4cv9uwDLwgzWEtD25LV6URf
	3gmZGTq7jZxu+eGLni3q34VqQt0KlHPMFvCbKHjwgBr1ImEJQ62zqaF82FZfVg==
Message-ID: <6b4fb2b3-8af4-4963-aef3-ff55797b9954@nabladev.com>
Date: Fri, 19 Jun 2026 05:52:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-stable <stable@vger.kernel.org>
From: Marek Vasut <marex@nabladev.com>
Subject: dbbec8c5a79f ("net: stmmac: fix stm32 (and potentially others) resume
 regression")
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-267302-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAAAF6A3B42

Hello,

Please backport dbbec8c5a79f4c7aa8d07da8c0b5a34d76c50699 to Linux 6.18.y .

The commit
dbbec8c5a79f ("net: stmmac: fix stm32 (and potentially others) resume 
regression")
fixes clock enable/disable unbalance on suspend/resume, where it 
generates a warning as follows. This was fixed in mainline already, it 
is missing in Linux 6.18.y LTS though.

"
ck_ker_eth2stp already unprepared
WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1047 
clk_core_unprepare+0x1d0/0x218
"

Thank you for your help.

-- 
Best regards,
Marek Vasut

