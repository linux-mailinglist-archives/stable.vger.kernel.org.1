Return-Path: <stable+bounces-253988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3krJHVdpEmqVzAYAu9opvQ
	(envelope-from <stable+bounces-253988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:58:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8335C12EB
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5ABBC3006100
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 02:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C3F25C80E;
	Sun, 24 May 2026 02:58:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out28-87.mail.aliyun.com (out28-87.mail.aliyun.com [115.124.28.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9BA3438B5;
	Sun, 24 May 2026 02:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779591505; cv=none; b=eThY2QAtyL9AJoBGNWQWqnlNrqfhx8S6ievrj4K0fkNB0Eod/afpwIcwFFXPJ4MhDTaN0d+rCFrfOfC1keuwj+Axk+ZM8hc/11J5sioHPN7HwA5ugoMklXrsczVuHh4afIsbJMXAtpwBF6HmrhbbLAr1wp7lcOSuHiJPv2glAYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779591505; c=relaxed/simple;
	bh=c+TlJL2sPrybwMXjB2fT8eXEP6oZ97pV4RVcDazy/tk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=VAhiqj5/I+QCjpu+2qCpM8y4Pi/2qS7Uebp01rY2n08X3lHEvNj6F8eZZyU/n8GnRuJv4L5xDojEfKCxh/8HiaVYQbXre+40cSjhPmGMlX/eu8PLsJAEbkieJ03f8k6uG53u7yYTrPFXij9IeZcJIbZvBo4y/rV97CqI4nAptOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=115.124.28.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.08529732|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0035679-0.00048309-0.995949;FP=17798995806383871403|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.hfBqM--_1779584200;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.hfBqM--_1779584200 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 24 May 2026 08:56:41 +0800
Date: Sun, 24 May 2026 08:56:41 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.91
Cc: linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org,
 torvalds@linux-foundation.org,
 stable@vger.kernel.org,
 lwn@lwn.net,
 jslaby@suse.cz
In-Reply-To: <2026052319-chastity-viper-7530@gregkh>
References: <2026052319-chastity-viper-7530@gregkh>
Message-Id: <20260524085640.88D0.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.83.02 [en]
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangyugui@e16-tech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253988-lists,stable=lfdr.de];
	DMARC_NA(0.00)[e16-tech.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6B8335C12EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

> I'm announcing the release of the 6.12.91 kernel.
> 
> All users of the 6.12 kernel series must upgrade.
> 
> The updated 6.12.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

2 regression of 6.12.91 are found here.  Both of them are in perf tool

1, undefined reference to `parse_events__term_type_str'
Could we add a patch
   d2f3ecb0ca2099d13bf8bf69219214c1425dc453  perf parse-events: Expose/rename config_term_name
or do some funcation rename(parse_events__term_type_str->config_term_name)?

2, undefined first_wildcard_match
Could we revert the patch (perf cgroup: Update metric leader in evlist__expand_cgroup)?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2026/05/24


