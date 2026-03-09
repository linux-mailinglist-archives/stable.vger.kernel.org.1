Return-Path: <stable+bounces-223680-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNRXM5jgrmmoJgIAu9opvQ
	(envelope-from <stable+bounces-223680-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:00:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B9123B29F
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 16:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF93230333E6
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D69A3D648B;
	Mon,  9 Mar 2026 14:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF2Ov3kg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA593D646B;
	Mon,  9 Mar 2026 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068244; cv=none; b=U6Yzeuw+kNvaUSu9MrMO04QZ+CZej8CHuBfOMyBD66x3KdSDevXUvYxwxBGNLEx1p40AksI1dUmDJtTXerYneOfWfoVOzgmmECBiahsPNAwNJK3Mq5jywbFhgCyi6Fm3DZJYa+0EmYkqIc/hgnQ8+LTVZN/kp+W8oYwBDRqWkys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068244; c=relaxed/simple;
	bh=SgAKIGd1iyjSqOuc5m1IuxF0zoIDLNEjC+79iZslBeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAA6izS9qKdWLucv54bygQJuzxNdTP0ZAlEEWWam7DbB8hjBKoFwQUN35IGmUBPhJEWF5rmqFcAI4JSQTMzJA7dodwSkEhMJ8cuu2bt3rJN2Hpn6EZJ9KE1S44cTuVmZC6FDEVGDiJ1+ANzQveerzjVM1+fSj+ZU11A2TvxauJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF2Ov3kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C518C2BCB5;
	Mon,  9 Mar 2026 14:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773068243;
	bh=SgAKIGd1iyjSqOuc5m1IuxF0zoIDLNEjC+79iZslBeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CF2Ov3kgsHeC08FnPBZF3KmDxdgBTG4A5A0X8R8eZ9JMfaHW9V79VlS22JtO677Wo
	 qq5IkoqzHqjxPcGrkNAebjswbWx/lO7NjD7Q+fMTdXYCQS+J8XHRE6w6Px+K8+cKXk
	 mrRUHsMqkMkRsPiL1KMdc+kRx8SeIxK6ceXgRPmBXPvP1ncLL/pUd9CWRzLv315Q9I
	 rz2G+XYy2011Gpgi+6RVoYHOepnoAg5jW0qYWIV/tI3eg3qO+re1rv8zOZxMpJ3KNL
	 Z7CdSci9eeH2FHWs20eSyyevRAbrYEx8O/CqP7GbKFhLtn1F3tAmmxCBG6kg4OkW2T
	 k38OGNSgVOoTA==
Date: Mon, 9 Mar 2026 10:57:22 -0400
From: Sasha Levin <sashal@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Leo Yan <leo.yan@arm.com>, Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 6.19 027/844] perf metricgroup: Don't early exit if no
 CPUID table exists
Message-ID: <aa7f0sRAJW3RyIPK@laps>
References: <20260228173244.1509663-1-sashal@kernel.org>
 <20260228173244.1509663-28-sashal@kernel.org>
 <072e2a07-5c6f-47b5-9695-0a3ffe854ac8@kernel.org>
 <2026030924-recount-halved-605d@gregkh>
 <CAP-5=fW6Rz14GszEm+bnh_qAFrLwf51khzfUzDapHyYJ2dpdkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW6Rz14GszEm+bnh_qAFrLwf51khzfUzDapHyYJ2dpdkA@mail.gmail.com>
X-Rspamd-Queue-Id: 44B9123B29F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223680-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.938];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 07:53:10AM -0700, Ian Rogers wrote:
>On Mon, Mar 9, 2026 at 6:40 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Mon, Mar 09, 2026 at 08:40:33AM +0100, Jiri Slaby wrote:
>> > On 28. 02. 26, 18:19, Sasha Levin wrote:
>> > > From: Ian Rogers <irogers@google.com>
>> > >
>> > > [ Upstream commit cee275edcdb1acfdc8270f80e96f30750b633220 ]
>> >
>> > This breaks (userspace) perf:
>> > $ ./perf stat -a -d -p 1 sleep 5
>> > PID/TID switch overriding SYSTEM
>> > Error:
>> > No supported events found.
>> >
>> > Any ideas?
>>
>> Is it also broken in 7.0-rc3?  Or is this only a 6.19.y issue?
>
>There was a fix:
>https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/tools/perf/util/metricgroup.c?h=perf-tools-next&id=c5a244bf17caf2de22f9e100832b75f72b31d3e6
>was that applied to 6.19.y?

It's not even upstream yet :)

-- 
Thanks,
Sasha

