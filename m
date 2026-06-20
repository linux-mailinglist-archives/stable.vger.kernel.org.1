Return-Path: <stable+bounces-267469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ooUMIJozNmoS8gYAu9opvQ
	(envelope-from <stable+bounces-267469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 08:30:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C7A6A86C8
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 08:30:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=mkkebgvnmfe4la4nux266pqxeq.protonmail header.b=XTeltrEy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267469-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267469-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D56E53033099
	for <lists+stable@lfdr.de>; Sat, 20 Jun 2026 06:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9142236FD;
	Sat, 20 Jun 2026 06:30:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2501A683E
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 06:30:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781937041; cv=none; b=pAbVbMqnfOaV/uNpzbnOwgGT+mcel/csFNJvRpDZ1UOvx7gEroG7K25NKOhIqa8P/4PEJSGor1olEVCWrKruDKkKAe4PRX4h7KzUj+ycAr91wMk+42S3ggv5D2Pr3Rb1AjElr6cPpLubx/c4S5HodPvVDZD1rgUm/GJkBjA8dEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781937041; c=relaxed/simple;
	bh=lhNi6gxuKrETGAYB5wjE3ei8Gfjvv95AAKzm5vG71FA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EaNG+u1nkOrk5a4IyGhrsTfRUHxxwtQL7uzQKvGzAUth+orgvIK6eg19br2xNmPdiG+AdofSMHY7T2c7msJzfN5mhk5nxECK8U1GSMmiWaSvRrOA8uoBgRU6TpdInV3nenIwifgHYZnPAy28fAThY+KfecDh/tX73AkfKxwN2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XTeltrEy; arc=none smtp.client-ip=85.9.210.45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=mkkebgvnmfe4la4nux266pqxeq.protonmail; t=1781937030; x=1782196230;
	bh=lhNi6gxuKrETGAYB5wjE3ei8Gfjvv95AAKzm5vG71FA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XTeltrEyt+N9tcBJhKqSTn+brG5yJl8uurMOg+1I/ZOreBCM7ZpO9aOc/cyeniERS
	 1cfitiLyvlCtgn7S0hWAMRlahG0UZWbesiaPwd31RFKAF/17/Tl42Y2HdGfP0p36FL
	 cbiwU/MFJFVzRjOv7V5kUU/xFJ7/1owZfH96GObDVmw9HwBP/ZhjISlJX5rZBigOhq
	 5aR2tPu6K146Tqakl7V23kZJfB6yeIdfUIwUZIpe16jxcHLetB/U5WxQFsv+3c27Lu
	 3Nkuahu7fiy/+wLOJH+N3nY9OgRmk+JOTvAecIRXnZC4qXfrvjY8EwMKAL/72mdJdl
	 tCVDOIn/EUCAg==
Date: Sat, 20 Jun 2026 06:30:28 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Cyber_black <Cyberblackk@proton.me>
Cc: "gabriel@krisman.be" <gabriel@krisman.be>, "axboe@kernel.dk" <axboe@kernel.dk>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: [BUG] io_uring: possible CQE32 overflow flush inconsistency in __io_cqring_overflow_flush()
Message-ID: <M9uVHmN1uFTdPdbQOITkChFjcJWO_U-BCOz4466zskh0n8rukyrE2nK4vlBcEQ8JBMyGZFPqBKCPyfZxYa0LdG5nkfxFBIcIOcSlAjrn1pU=@proton.me>
Feedback-ID: 117998405:user:proton
X-Pm-Message-ID: ac5d682972be787bdbc45cf1320ef4f250d087fd
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=mkkebgvnmfe4la4nux266pqxeq.protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267469-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:gabriel@krisman.be,m:axboe@kernel.dk,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[Cyberblackk@proton.me,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Cyberblackk@proton.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:dkim,proton.me:mid,proton.me:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06C7A6A86C8

Hi Greg,

Thank you for your honest feedback. You are absolutely right that testing i=
s essential.

I was able to compile the kernel without issues, but I cannot test it prope=
rly at the moment due to lack of a suitable test environment (no KVM/QEMU s=
etup, limited hardware resources, and financial constraints).

If this means the report is considered invalid or cannot be accepted in its=
 current form, please let me know clearly. I will revisit this when I have =
the appropriate infrastructure and resources to test it properly.

I don't want to waste maintainers' time with untested patches. Thank you fo=
r your understanding.

Best regards,
Eneshan Erdogan Karaca

