Return-Path: <stable+bounces-242613-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GC4I2Ap9mkmSwIAu9opvQ
	(envelope-from <stable+bounces-242613-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 18:42:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E313B4B2D9B
	for <lists+stable@lfdr.de>; Sat, 02 May 2026 18:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D1CC300EAB9
	for <lists+stable@lfdr.de>; Sat,  2 May 2026 16:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE4A37FF70;
	Sat,  2 May 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L39iCl2/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA37296BC8;
	Sat,  2 May 2026 16:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777740124; cv=none; b=EaLklwiY8FqBzE332CmHFkajxNlzrodE6+3DvtR1Ig7okCyclv0UIhk0RAsnMRBTisnw0TYchrazQki6KvLrnaYLqhoOZOwmODy9nT4q34LUD/BlihSy9CrXIsk0RJ3BSdFmNeppKVzKxh3JGDWhca0EsM7ljsYJJfdlVNQuJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777740124; c=relaxed/simple;
	bh=h/94Mx3HuJnQMsGzdpfcgAvBXvPkJZJfkUbauyL60BM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgg6WAYZfhrV6bcEyG86g0O5ZtzVn1aR7W5LJECGWiS/+ge4ckes5p2fYDzD56SQAu9LZh9QfRLhr4gJCg25CjaRdCWcQ86ADgwPGRzW9/PybONPuOBofywFwltg7DYjbZZmdigxCIeTzHjiOcnyt0ypPsvv2WxHJN5Zj7huaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L39iCl2/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105A4C19425;
	Sat,  2 May 2026 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777740123;
	bh=h/94Mx3HuJnQMsGzdpfcgAvBXvPkJZJfkUbauyL60BM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L39iCl2/xhUSDcB4CozdnnLaqU/fZhcdlxXfJlaH9/YfDv3gL+fmHwzDuESl8wzNx
	 rP1K3n4jJmskN8qean1Dhe1irHpF4ACL5kUGnuGUDLJEixdB1WkN60jMj3/ghXUzKI
	 p62TFoa7qHVJQEUEeEQp1Cakc3ctiv9JNkkjwQ+xJC+3maHAkKqIXYcrmvcvUW0Y+K
	 O24fhpSifWEJrDuNXQmk0XQ1Bp8NEmlAZ+swerPkfsQu0GrOYploJYzElIBbL/O8bd
	 diEsyGBBoT8ZEoINyG2vHBUqnV1sfa20C9q9xlonAxzyLQKAVWJdPv9OsvJN2WghaZ
	 SXe+hSamAeNPw==
Date: Sat, 2 May 2026 09:42:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "SnailSploit | Kai Aizen" <kai.aizen.dev@gmail.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jmaloy@redhat.com,
 ying.xue@windriver.com, pabeni@redhat.com,
 tipc-discussion@lists.sourceforge.net, tung.q.nguyen@dektech.com.au,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev,
 syzkaller-bugs@googlegroups.com, "SnailSploit | Kai Aizen"
 <95986478+SnailSploit@users.noreply.github.com>, syzbot ci
 <syzbot+ci779e8ed86620f383@syzkaller.appspotmail.com>
Subject: Re: [PATCH net v3] tipc: fix UAF race in
 tipc_mon_peer_up/down/remove_peer vs bearer teardown
Message-ID: <20260502094202.42ccedd1@kernel.org>
In-Reply-To: <80ae67e96de2f702028e5bacc89db4575e1531ca.1777559945.git.kai.aizen.dev@gmail.com>
References: <CALynFi5d0DuGW50xq7xQnsDPdEuN5jBGTqh8bcsUwxk6L-FAdA@mail.gmail.com>
	<80ae67e96de2f702028e5bacc89db4575e1531ca.1777559945.git.kai.aizen.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E313B4B2D9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242613-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,SnailSploit,ci779e8ed86620f383];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 18:40:55 +0300 SnailSploit | Kai Aizen wrote:
> From: "SnailSploit | Kai Aizen" <95986478+SnailSploit@users.noreply.github.com>

We need a real email address. 
The correct way to include your company / sponsor name is in round
brackets, eg

	Kai Aizen (SnailSploit) <email...

please refer to the process docs for more info if necessary.
-- 
pw-bot: cr

