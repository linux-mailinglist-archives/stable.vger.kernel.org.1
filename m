Return-Path: <stable+bounces-241772-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cP6VAK0d8WlmdgEAu9opvQ
	(envelope-from <stable+bounces-241772-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:50:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C4748C002
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 22:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F6AC3041457
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3ACA4A35;
	Tue, 28 Apr 2026 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="GDMIFfX4"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1742237C902
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 20:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777409247; cv=none; b=MDxTlyx+ihX59aw4uYkq8MqNFq0ZRxqezFIJqPqtrEAbjLGQ15Gmt+xnU4Pudh5dew2fmEMBdlXXRRqkGP1ivQ7cagRbHbs+nUHvWyGGNnw6IKd7Kbgt5PIl4L9J1k1WTXq7Nj+8ughQnIPQICQteV+6N2dTlRzPAFX67jzoczg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777409247; c=relaxed/simple;
	bh=erg5zNfh3oU0adnBdJNBSlhQGXri9NWB86EOox+oF8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJMFvpGOdB3dq2lyKZ4vVMNS61UUmWQ9d8RIGJ7X8Dw0P3zFvHzfUw1o1qwPLojdQGaZ+mjmIG/8yTN9sF4V/AbU9WvwkZmjBvSnuBpBSBBoXoRARwhwZqm1bjcMSkucN2yEZYtAn4TgyEF/swFNyNPgEOmxzvWWb0kUnEjfJA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=GDMIFfX4; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E7F18C0238;
	Tue, 28 Apr 2026 23:47:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:761::1:11] (unknown [2a02:6bf:8080:761::1:11])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA id Blg13Q1LDuQ0-I09BYi5b;
	Tue, 28 Apr 2026 23:47:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1777409233;
	bh=erg5zNfh3oU0adnBdJNBSlhQGXri9NWB86EOox+oF8A=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=GDMIFfX4JYY35VyLKXvLaTqB2uJjb84eXo1HLUwkxakxOe3ipCKKFj0R6v1//Secj
	 HJDtQ0LRvf/Q/NcHR3frUyPJQsAQJrwR1SGrwGMLmMliVUwrZogC/tvp5kEffrSdw9
	 LQo8LOnglf3zpRxmWphQ3NlfjQmOmPLuu3RfY+6A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Message-ID: <3b2f6d2e-bac9-4373-9e1e-4d3729141389@yandex-team.ru>
Date: Tue, 28 Apr 2026 23:47:10 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6.y 5/5] x86/bugs: KVM: Add support for SRSO_MSR_FIX
To: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tom Lendacky <thomas.lendacky@amd.com>, Sasha Levin <sashal@kernel.org>,
 "Xin Li (Intel)" <xin@zytor.com>,
 Daniel Sneddon <daniel.sneddon@linux.intel.com>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Nikunj A Dadhania <nikunj@amd.com>
References: <20260428120545.1970058-1-d-tatianin@yandex-team.ru>
 <20260428120545.1970058-6-d-tatianin@yandex-team.ru>
 <afDtCg-8DyaPb-0s@google.com>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <afDtCg-8DyaPb-0s@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 84C4748C002
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[yandex-team.ru:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yandex-team.ru,none];
	R_DKIM_ALLOW(-0.20)[yandex-team.ru:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241772-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[yandex-team.ru:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[d-tatianin@yandex-team.ru,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]


On 4/28/26 8:23 PM, Sean Christopherson wrote:
> On Tue, Apr 28, 2026, Daniil Tatianin wrote:
>> [ Upstream commit 8442df2b49ed9bcd67833ad4f091d15ac91efd00 ]
> This shouldn't be backported without also grabbing upstream commit e3417ab75ab2
> ("KVM: SVM: Set/clear SRSO's BP_SPEC_REDUCE on 0 <=> 1 VM count transitions"),
> otherwise non-KVM workloads will get hit with performance regressions without
> any benefit (to them).

Indeed, thanks for catching that! Will resend with that commit applied.


