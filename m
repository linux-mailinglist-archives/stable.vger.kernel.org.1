Return-Path: <stable+bounces-237622-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKiMCW8z3Wl9agkAu9opvQ
	(envelope-from <stable+bounces-237622-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:18:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E753F1E79
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 20:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B47183024A4C
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0473C33FE09;
	Mon, 13 Apr 2026 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kmYqSFmx"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDADA3B6BF9
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 18:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103993; cv=none; b=VSuWp9FY9xGBXIPoIVAaOOUJFX8OiNBw9D4K17+lhpP/MKiqnYkL6fdN+R/jnHYzxlpklll8CpWQnBTiFvUHyXCOSUj4iFucgnucofDf1hrXJpDvQMep/fDD4voDHMZYhxuXadtSXKZySWTeoNfVo5w2hI2p/LarzU4Tik+okhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103993; c=relaxed/simple;
	bh=4m29Qla/nqsKkYR0+ivzGRPwHkXykqnCwmqvh7dFXiA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SP1cYXKXpK+8Erq5FX7klf+dEiweO0rL+qAj9Pwvxd+hxctKcvOCYrwiJ+5ln8P0Oh8XJJ5jhJ7wQebAta+8NbPVhRaIst7PxmZRAUn5/7jOkKH4dy216c+OJUVsP4WukCvwiBDQnxcDM9F1Srg7yEz1MQkYUetlHbrwKkivHmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kmYqSFmx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id AE7EF20B6F01; Mon, 13 Apr 2026 11:13:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE7EF20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776103992;
	bh=4m29Qla/nqsKkYR0+ivzGRPwHkXykqnCwmqvh7dFXiA=;
	h=Date:From:To:Cc:Subject:From;
	b=kmYqSFmxI0FoSnQaju3yyGvSbBl0lcXFpuGqeNzgG5BDwpP/6LiMZWCfbpzzHvWnn
	 VFC8AqB24ibZYmTeOgA+YfVSFS2KOmRHAzouEIPKRcwnWgMQ2zlo67vLj7+p1U264N
	 6fMuYDcytMsYFP7RN7XGgsR69Q4h2mnv7sebVecw=
Date: Mon, 13 Apr 2026 11:13:12 -0700
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Allen Pais <apais@linux.microsoft.com>
Subject: [REQUEST] objtool backport for 6.6+
Message-ID: <ad0yOO1ec24fjJCC@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237622-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 93E753F1E79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Please include commit f404a58dcf0c ("objtool: Remove max symbol name
length limitation") in kernel 6.6+, as it resolves a build failure
for us.

BR,
Hamza

