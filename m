Return-Path: <stable+bounces-25747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C1086E329
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 15:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10B81C21CF7
	for <lists+stable@lfdr.de>; Fri,  1 Mar 2024 14:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D15B6E5EB;
	Fri,  1 Mar 2024 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="nFIBZhEu"
X-Original-To: stable@vger.kernel.org
Received: from relay-us1.mymailcheap.com (relay-us1.mymailcheap.com [51.81.35.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8C6D1A3
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.35.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709302685; cv=none; b=Ov3PUOyZYI4tmV4s58RdKVCVEzkjKJDo05Y3tDk5g/4jtWI4j39TvHV4Lc1nQffEQGZK+SHZYiJqG1fmNlSGFun+HXMCEMfBcLvpm6MXVRNbBO7NlRF+iKjAwjnuFpxyim/rgVAu1w/gYio7SaCgIiL6XLdJLPTqYBpfRfi+TMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709302685; c=relaxed/simple;
	bh=eRHjrkdrsJg43/9heYvQDxEKsE5N6/ROvqRBnivHrb8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=CSZIS8FFcU8uwZnVok8t07EklZpy5WRfJl2S3V2JJOe7axXvl7nN4r3L2rmnkbHaZNJrSybV5YwgS/3QEuOX+oThNZIRBPnsWOsr996YADDozheaBgFOpQch/TR04y2dKnfPeaccRg1NLyFrzHhGX8VhFGfUm9ymfJP3BfQJ9f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=nFIBZhEu; arc=none smtp.client-ip=51.81.35.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	by relay-us1.mymailcheap.com (Postfix) with ESMTPS id 6A640217AA
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 14:10:30 +0000 (UTC)
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id B99CF2009A
	for <stable@vger.kernel.org>; Fri,  1 Mar 2024 14:10:21 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 6EB6C203D6;
	Fri,  1 Mar 2024 14:10:14 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id 5E79F4007F;
	Fri,  1 Mar 2024 14:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1709302213;
	bh=eRHjrkdrsJg43/9heYvQDxEKsE5N6/ROvqRBnivHrb8=;
	h=Date:To:Cc:From:Subject:From;
	b=nFIBZhEujakHkeU1+NlkID5+4hvTFQLvIGv4elPMwOIuQiRAXsiLssb/qOPudCqg3
	 IB+IS7rF73O/3/Wu1U9+MrVu13X2GrrVosV/oIU5I5U0bEfq+VieKkAjpbP86O09U2
	 mOZiGsaMbTjG1Niy/lHWGsqOIN4c3gtEwHtO02rY=
Received: from [10.66.66.8] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 12D0B40CE5;
	Fri,  1 Mar 2024 14:10:11 +0000 (UTC)
Message-ID: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
Date: Fri, 1 Mar 2024 19:40:09 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev
From: Pavin Joseph <me@pavinjoseph.com>
Subject: [REGRESSION] kexec does firmware reboot in kernel v6.7.6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5E79F4007F

Hello everyone,

#regzbot introduced v6.7.5..v6.7.6

I'm experiencing an issue where kexec does a full firmware reboot 
instead of kexec reboot.

Issue first submitted at OpenSuse bugzilla [0].

OS details as follows:
Distributor ID:	openSUSE
Description:	openSUSE Tumbleweed-Slowroll
Release:	20240213

Issue has been reproduced by building kernel from source.

kexec works as expected in kernel v6.7.5.
kexec does full firmware reboot in kernel v6.7.6.

I followed the docs here [1] to perform git bisect and find the culprit, 
hope it's alright as I'm quite out of my depth here.

Git bisect logs:
git bisect start
# status: waiting for both good and bad commits
# bad: [b631f5b445dc3379f67ff63a2e4c58f22d4975dc] Linux 6.7.6
git bisect bad b631f5b445dc3379f67ff63a2e4c58f22d4975dc
# status: waiting for good commit(s), bad commit known
# good: [004dcea13dc10acaf1486d9939be4c793834c13c] Linux 6.7.5
git bisect good 004dcea13dc10acaf1486d9939be4c793834c13c

Let me know if there's anything else I can do to help troubleshoot the 
issue.

[0]: https://bugzilla.suse.com/show_bug.cgi?id=1220541
[1]: https://docs.kernel.org/admin-guide/bug-bisect.html

Kind regards,
Pavin Joseph.

