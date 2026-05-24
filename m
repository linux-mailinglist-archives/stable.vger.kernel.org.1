Return-Path: <stable+bounces-254024-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEA2NqzqEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254024-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:10:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DDB5C24D2
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BFB730039AB
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462933C1B7;
	Sun, 24 May 2026 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYeBpfXX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD12D6409
	for <stable@vger.kernel.org>; Sun, 24 May 2026 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624618; cv=none; b=J6Yv5vOTT//9kTNmVPUeahUxmtdy7fFi0xPguffX3kesNnxfRGdi2tWHfUZfKMbnJ+ZlXtcPT6ERCi4tjV9NqpekbpJ0DrK7bQDRCyUpJIRMHq/+NK/C8b4ELtNo7P1r/O7wczf8WoVt1EjMmbiCwlGW3DJamy+JB2R/0Usle0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624618; c=relaxed/simple;
	bh=IfzhtYOedGSjoatkdkGxhn7N/mpWTGdAGstC2y/P7Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+xidKMc6imAk7zmXuvYofO//PbzjQdqX0qeGM03TdvTqRkzR+J8TapZ9obktxUpTuaV4V/wy6R09QsQkSiEgz0VCCG8yI6ylCf+JivHnMZ5b/Cj4CDYblNwq3SZvVIe7+M4wfe7z/miSwPXyYzGYfUoTVGBYzZjEctpBiH80OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYeBpfXX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A51A1F000E9;
	Sun, 24 May 2026 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624616;
	bh=B/QylLt9HVKlK8T1JVIaY7wYcc2y4/ntSZS0rGmUiwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EYeBpfXXR7k1/jUaPKbu8eLvcQuitsd1O8v1POif2eWOLR3uc8ymrF998qcpiJcq/
	 KmK7KQ6pKW0XnKExmi+NKcU7p4gOlunRPrrBDijZol+PyabKORvA0VgiZZqB0O4JMg
	 trzScaFPLnK1q7ocdVd4UNjDzte34M0U4snumJ0+hQzeVjEVBZIk50Hhtoe1QKCXml
	 d4to7QiWxBATJgqANmHd90s5E2gEkAmk3Gk5M9wS4yzVGP8p1CTYePawSW9rCtNVIW
	 JqHi++8lXyPypZV1EjeIivRKlxfnr+OIUZ2WPltmyKbrE4ApxBM+fr4ziBa+V3Otiv
	 BdAaQz0mn53Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Benjamin Block <bblock@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 5.15.y] s390/debug: Reject zero-length input before trimming a newline
Date: Sun, 24 May 2026 08:10:13 -0400
Message-ID: <20260524-stable-item013d-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521022844.38817-1-pengpeng@iscas.ac.cn>
References: <20260521022844.38817-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254024-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 84DDB5C24D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Queued for 5.15, thanks.

-- 
Thanks,
Sasha

