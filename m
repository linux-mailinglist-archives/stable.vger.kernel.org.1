Return-Path: <stable+bounces-225732-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0bVgD6G8uGmxigEAu9opvQ
	(envelope-from <stable+bounces-225732-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 03:29:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8040E2A2D1C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 03:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7CDE73012840
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 02:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB4314B93;
	Tue, 17 Mar 2026 02:29:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from ag.fintek.com.tw (mail.fintek.com.tw [59.120.186.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5452C19AD8B
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 02:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=59.120.186.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773714588; cv=none; b=UPhxwJphVELfYwXQ3FJB2GRrkFAucRdacv0LHWWFR5XKSQwcWBerDis5hbmPejxrEx3v8Isupr4MgsiyPIyfi6mX5x6y3cq+iogyu5gus6/PmiyMNWA+6r6QxBPnhnChqrJTaIUtQsnJNMTvgnL+H4dB2nTbxBnk+CWGlyJgFdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773714588; c=relaxed/simple;
	bh=vVXj8M3RTPKsVCHO5gn2jrb8NkZ8ygs5bd0QH1fGXHQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=LJAukJE2edXJRTt0sYa5BJz3593nt6G0Ehvv2KYv4Y1ytubuGsN9tU0UUKocw2ClqNjQX+PrJdldKfCzELJbVcDlUIf9Fch8Ccq+mnpmnmn81GojpWMQZhTdzg7t0LezbU1YNVzqlil4dr5BzMQDg4WIXfGPY5yIDNL16a4Pok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw; spf=pass smtp.mailfrom=fintek.com.tw; arc=none smtp.client-ip=59.120.186.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintek.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintek.com.tw
Authenticated-By: peter_hong
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62H2LGUr81690392, This message is accepted by code: ctloc85258
Received: from [192.168.1.132] ([192.168.1.132])
	(authenticated bits=0)
	by ag.fintek.com.tw (8.15.2/3.23/5.94) with ESMTPSA id 62H2LGUr81690392
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 17 Mar 2026 10:21:16 +0800
Message-ID: <5bcf02b5-3fe5-466e-a1da-0e5a2e62fd5f@fintek.com.tw>
Date: Tue, 17 Mar 2026 10:21:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, johan@kernel.org
From: "=?UTF-8?B?UFMxMCBQRVRFUiBIT05HIOa0que5vOa+pA==?="<peter_hong@fintek.com.tw>
Subject: Post-facto backport request: USB: serial: f81232: fix incomplete
 serial port generation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_NO_SPACE_IN_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[fintek.com.tw];
	TAGGED_FROM(0.00)[bounces-225732-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter_hong@fintek.com.tw,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.899];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8040E2A2D1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Stable Team,

I would like to request a backport for the following commit to the
currently supported stable trees 6.1.y, 6.6.y, 6.12.y and 6.18.y

   cd644b805da8 ("USB: serial: f81232: fix incomplete serial port 
generation")

Reason:
   This patch fixes a stability issue where Fintek F81532A/534A/535/536
   devices fail to initialize all serial ports during fast load/unload 
cycles.
   The fix involves a dummy read to clear the device's stale internal state.

The patch should apply cleanly to most recent stable branches.

Best regards,
Peter
-- 

*洪繼澤 **Peter Hong*

精拓科技股份有限公司

Feature Integration Technology

Address: 302新竹縣竹北市台元二街10號7樓

TEL: 03-5600168 #813

FAX: 03-5600166

E-Mail﹕peter_hong@fintek.com.tw




