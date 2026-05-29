Return-Path: <stable+bounces-256504-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qM8zLBMjGWqVqwgAu9opvQ
	(envelope-from <stable+bounces-256504-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:24:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EC55FD50F
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 07:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B7C03055DD4
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 05:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589B3A0E85;
	Fri, 29 May 2026 05:24:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out198-178.us.a.mail.aliyun.com (out198-178.us.a.mail.aliyun.com [47.90.198.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C103947AC;
	Fri, 29 May 2026 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780032269; cv=none; b=tk249RxVo2zK8xWV0KUo0PA2cJIt7JKQU/h/4hcaSnnfd/8NiuvjxRk6/YcJXN0iL18T7F3iiiAbFMBnYijtVqv037ytDCYZNzZwn8LpprCzANeNoPLBEcp9ut45sdClbjeS2AIUcrJ5LSTIYjDE2sFug9/qZ8KoVlPJSBcqJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780032269; c=relaxed/simple;
	bh=dwPaoRuKnn6F023WiP00aPI9QCyqcBXouimUVXI7+cg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=Io7VbJ9fqs/sK81ImZYGxGtO/6F6ZUz+FkrViywZcGAeZ6N+gQIUCTlu6/3YjVnCrIYd71ziDQNf7z5BVC0aHGAuUSkNKOJNXa5sE3F2YO8Vrecr6wXEtU5vkTik9YKr2EuAg/fxS+cIdZunYXRSxcMpXkQ8zOm24cah1VxhrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.05499221|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.00340558-0.000142392-0.996452;FP=16069560358890763747|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045018182;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.hjcfqn-_1780031925;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.hjcfqn-_1780031925 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 29 May 2026 13:18:46 +0800
Date: Fri, 29 May 2026 13:18:46 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: Linux 6.12.91 - perf build break: undefined parse_events__term_type_str / first_wildcard_match
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org,
 torvalds@linux-foundation.org,
 stable@vger.kernel.org,
 lwn@lwn.net,
 jslaby@suse.cz
In-Reply-To: <20260527-agent5-item001-perf@kernel.org>
References: <20260525231000.agent5-0005@kernel.org> <20260527-agent5-item001-perf@kernel.org>
Message-Id: <20260529131845.70D6.409509F4@e16-tech.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[e16-tech.com];
	FROM_NEQ_ENVFROM(0.00)[wangyugui@e16-tech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-256504-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 18EC55FD50F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

> > > 1, undefined reference to parse_events__term_type_str.
> > >    Could we backport "perf parse-events: Expose/rename
> > >    config_term_name" (d2f3ecb0ca20)?
> 
> Queued d2f3ecb0ca20 for 6.12.y, thanks.
> 
> > > 2, undefined first_wildcard_match.
> > >    Could we revert the patch (perf cgroup: Update metric leader in
> > >    evlist__expand_cgroup)?
> 
> Still looking into this one - could you share the failing build log
> (and the .config) so we can confirm the right fix?
> 

with the flowing 4 patches of queue-6.12 on the 6.12.91,  the kernel packages
are build without any errror.
 revert-perf-cgroup-update-metric-leader-in-evlist__e.patch
 revert-perf-python-add-parse_events-function.patch
 revert-perf-tool_pmu-fix-aggregation-on-duration_tim.patch
 revert-perf-tool_pmu-factor-tool-events-into-their-o.patch

Sorry to reply to this too later.


Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2026/05/29


