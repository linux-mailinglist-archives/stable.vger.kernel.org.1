Return-Path: <stable+bounces-215748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI/aAgkQjGkwfwAAu9opvQ
	(envelope-from <stable+bounces-215748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 06:13:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F6E1214D9
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 06:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CA33301DBA6
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 05:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D424D2F6586;
	Wed, 11 Feb 2026 05:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="bcHT3loQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE326290
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770786817; cv=none; b=fqzDW5qrdQAm21Qf0xJv2vzWh6HJKNQVrIWV87wz8/o+296t8qS8zgO+Buxxa+s8HwOEIJ1OyMTBi+9kosoSwNE0BkMWVlp4wYi3aoJMm2bt4YK6YN5F+4Yk6LjD12pk1PssTcVo8bWejqlPl7QtqhSYPv1KcjJZc71XHdVhku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770786817; c=relaxed/simple;
	bh=mpwt0ndPqahhQ+biKm2WQQtfkBxEVnR1vz7RDE5Yo5I=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOMvM0cyAHHo+86T99qbNUD4FRDfPQk1LV9lA+JghlQakokaps5DBy6xHAQ68KZkT1ycjz0iqDJLLaBNnteo22TLP7F03ERAb7CcpXRE2XYLrCm6L9DO0LRv/AUxGSXklSH9L2KSgPOwkwMrJIa90ddvrcflIzH21rY4DQ6Qadk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=bcHT3loQ; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1770786806; x=1771046006;
	bh=mpwt0ndPqahhQ+biKm2WQQtfkBxEVnR1vz7RDE5Yo5I=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bcHT3loQUDOvH15cxpL25OTe6ftVf15kI+qd0A4xbwreoVpCUCLydOq+A0f38j4E9
	 U5qkYmZg0VmpITI42OGQAjHVoTUqVnkiH5au2daME7NwHF/+G/XCYhVXS047N3U49y
	 0gdtbG5YsjPa2v0ZaW+rX4ODa5vd6VmxIhAkXOivoulJ6lzekLeQ2yTFFrY800rvdf
	 vtvWmFLPlgkK7SXF4A6/xukbjBDfPrMOhuHPQeoiK5BOCEGcijNyg8BZhgSSebgBSW
	 04MFUMP7iD7owWfdi3WdeOs5XfWBN/jwVXd79l64rNP6Jf6XG/CqJ4+96D6tR373GS
	 lNyd/3jq9rgUg==
Date: Wed, 11 Feb 2026 05:13:20 +0000
To: Eric Dumazet <edumazet@google.com>, stable@vger.kernel.org
From: Tj <tj.iam.tj@proton.me>
Subject: Re: Regression: v6.12.67 ip6_tunnel: ip6gre decapsulation fails
Message-ID: <5e2ddfcf-a853-435b-ae73-a607973d324f@proton.me>
In-Reply-To: <handler.1127597.B1127597.1770760247113066.ackinfo@bugs.debian.org>
References: <177076023892.578113.8206759777477389796.reportbug@sunny> <handler.1127597.B1127597.1770760247113066.ackinfo@bugs.debian.org>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: d5e5b5c0a198dbce7000196a144a6c065a1cf2fa
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-215748-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj.iam.tj@proton.me,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,proton.me:mid,proton.me:dkim]
X-Rspamd-Queue-Id: 86F6E1214D9
X-Rspamd-Action: no action

Apologies for not including more information for upstream in my original=20
report.

I replied to the Debian bug that has all the information and logs and=20
forgot there was no link included:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1127597



