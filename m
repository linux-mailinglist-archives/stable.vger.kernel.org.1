Return-Path: <stable+bounces-246857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO8yCf6ABGrmKwIAu9opvQ
	(envelope-from <stable+bounces-246857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:47:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8564453453B
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD78130E159D
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F0B2EA171;
	Wed, 13 May 2026 13:24:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083373F4128
	for <stable@vger.kernel.org>; Wed, 13 May 2026 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678678; cv=none; b=ZeS2OcdMJKm+0EoxUDnmnVKPeIGCFY+APJlXP2eo25CBuyqMQFE4RTPgYp7k/qh3oG+1kBSJGkZPgQBjsfJfuO99ZSkyuzQt2earhxOOX55X3Oc1cQPzto8d5Tw1F9xbJOuMKywfJInQDg8BFZfwFJsZxPm77w1fchUr38A2aI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678678; c=relaxed/simple;
	bh=MqoFmTwrvH+mo1WqmW7lECGd8obLUv7J4XGMpXvGLRY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Cu6aWFaPlhArksK/sMuqOWLVqIJxNzcJEBvtKB/EyZwVBrd45FgmaVToHpY3cz5gu3G2nswN7EyHCVaKe/EBSWqOPrx8m5mYwPbTl/n9iQC3vUjgkxSjs9q0w2j7msDYehsu+imrRorarCC09IIzAI7bUCcxcOqZBdjEoSTPlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7F1324C4019BA7;
	Wed, 13 May 2026 15:24:29 +0200 (CEST)
Message-ID: <35e9c59e-6e54-4683-9751-175d425fbc37@molgen.mpg.de>
Date: Wed, 13 May 2026 15:24:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: manish1@arista.com
From: Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Please backport b8e753128ed074 (exit: Sleep at TASK_IDLE when waiting
 for application core dump) to < 6.12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8564453453B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246857-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mpg.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmenzel@molgen.mpg.de,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Dear Linux folks,


I am forwarding a backport request from SONiC Linux kernel [1]. It’d be 
great if you could apply commit b8e753128ed074fcb48e9ceded940752f6b1c19f 
[2] to Linux 6.1 and older.

> On Linux 6.1, coredump_task_exit() parks sibling threads in 
> TASK_UNINTERRUPTIBLE|TASK_FREEZABLE while one thread of the group
> writes the core file. Under sustained memory pressure the dump can
> take longer than kernel.hung_task_timeout_secs, at which point
> khungtaskd flags the parked siblings and (with hung_task_panic=1)
> panics the box.
> 
> Backport mainline v6.12 commit b8e753128ed0 ("exit: Sleep at
> TASK_IDLE when waiting for application core dump") which switches
> that wait to TASK_IDLE|TASK_FREEZABLE so the watchdog skips it.


Kind regards,

Paul


[1]: https://github.com/sonic-net/sonic-linux-kernel/pull/575/
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b8e753128ed074fcb48e9ceded940752f6b1c19f

