Return-Path: <stable+bounces-254664-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOffNL9KF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254664-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:49:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A455E9A53
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 375B130280B9
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225803B19AE;
	Wed, 27 May 2026 19:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4Li1h55"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34723B19B6;
	Wed, 27 May 2026 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911357; cv=none; b=ClGXU47xPSGzQebqLkD2jCTWw5BiuCv8e+taT8gCU9kSAnybjydVhr4t2BkamqKVSLnlseOIvf2LZEBMInadLdF4AGDcewUjsvzuRG7Q5WOs44wS4LR4fguNzkTVX7IZhkbtXZjKLpWGRlENFRwwaU8kYHmiCLiKO3CY+q26b4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911357; c=relaxed/simple;
	bh=KPEkDSy4BQI30I02VucFHi0vmhFymEtouAHcGDrnZU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Br7zlO21h/SnSX7XpapHp+8rwgYlYNoJzglW5phsW6vYUl9glla+ijK4z0/TSeqW6nQZOl69vVDeDxSp4+Fv67DBk1x2TT5B5X+hER+aCOAaUc6kxDc2VsW+VEgdMrn5Fv2nGYN9G5bZcLhnb/4OTXMuL0S7yg44YE18OrmWHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4Li1h55; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2AD1F000E9;
	Wed, 27 May 2026 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911356;
	bh=SpaQdlRfsY3idaKHRlpfsF4dvBXONV6cyz/atrXViXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4Li1h55AVQIbcvVc/4JzI2AzNxIuq1W8Z783+NKWo04AAT64HOr0WZsBW2AcPBqc
	 ruTXboa5IURLxJb+UANl0CWpuvCdnxnjRf2Lf3H9Ey2xceQmtnAwbb/DrQc5s8Gohh
	 jGKrAwe8rTC6LZ9GBQSy4oX4I3jz9o69shwhZo8zzUyIyjsFaekVFfKkS18TW3ysP0
	 /RDXhfWftPULS0PldJdLwxTByDDzKqQ4iWN+aALbRLvC7gkp1xRa3BrQEe3n+UZBIb
	 726faK2PyNr8kzvFtSbno98klNGj0bU7ulUpQbyvXscCFery4LyIRnujf/6crGDayr
	 nDJOaWQileP6A==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wang Yugui <wangyugui@e16-tech.com>
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org,
	lwn@lwn.net,
	jslaby@suse.cz
Subject: Re: Linux 6.12.91 - perf build break: undefined parse_events__term_type_str / first_wildcard_match
Date: Wed, 27 May 2026 15:48:56 -0400
Message-ID: <20260527-agent5-item001-perf@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525231000.agent5-0005@kernel.org>
References: <2026052319-chastity-viper-7530@gregkh> <20260524085640.88D0.409509F4@e16-tech.com> <20260525231000.agent5-0005@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254664-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B9A455E9A53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > 1, undefined reference to parse_events__term_type_str.
> >    Could we backport "perf parse-events: Expose/rename
> >    config_term_name" (d2f3ecb0ca20)?

Queued d2f3ecb0ca20 for 6.12.y, thanks.

> > 2, undefined first_wildcard_match.
> >    Could we revert the patch (perf cgroup: Update metric leader in
> >    evlist__expand_cgroup)?

Still looking into this one - could you share the failing build log
(and the .config) so we can confirm the right fix?

--
Thanks,
Sasha

