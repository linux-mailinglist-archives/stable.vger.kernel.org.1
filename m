Return-Path: <stable+bounces-125884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE6EA6D99E
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BA2A1888B95
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD37B25E453;
	Mon, 24 Mar 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CNOYkmr+"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA42BA53;
	Mon, 24 Mar 2025 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742817385; cv=none; b=LxMhzAyes2055THEpN5fWFld1k/xfSvRbqe7VzbNlALV3FTPUwDSJqVWLhomTeRHvGVQ3M0U/HqYJVqd7keELzaq7zsECEadvLMHRzJM1G5TdMBlAx5AtIXzHdryzFzr86heSFGYRZyZWaOXBkShfFiHUIlp0Kunj0U9mq2zrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742817385; c=relaxed/simple;
	bh=J9q5/4scy6kn1TygtUSXvAe4e5iF9WBAkzy7kqTWp14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2DlxFCaroq9Esru481O9QYQ9U71Mh7HbLCfqxl6MrUoDFUAw6ontMJY2mI/KF1Hsw/9xUfNAnOFFwJmhmHyyKJIhvIcX7mWkQgIWCQcoRKXpxAJm+k4+bKRAx0b/gmLS+/BXQWdh0XLSn672YQS+2VTOtONlQcvvRDmi1SmXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CNOYkmr+; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lGxJjqthPFxv5zjZw6mg4SKFplIL29l3gQ4hoQnCdaE=; b=CNOYkmr+qNhgUz1mwC0VVTERaO
	5O2j3na1cFLYhGRnL6+kVSYjkkgZFbvbCpQS8NONq0Pn39b8nr+SpIDCEc6ZfFHrPi6hVfkJSzTJj
	2dpxsjlK/Nni2ETWazM538v4kD1tMwVO2q9hZCcKJiTm7TJ/6ZoDSOts2QRGruahLWFAxU1iaVFsH
	xwsrFXM+ZkVdKSLHQAvStMuoQv2uWOYgfjyK+7Vb27eghfraAMVlYCsomX1dxLlQmBjrNYJIviXBW
	5ItLDNYZMd3xKex6leLf/ZNrV5xFMvQ43g1N+Yhc6JZCp36c+4f2nnPBZ3KJSkIJobykiXnsSg6+U
	y4hKUGsw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1twgPe-00000005E3u-27Bi;
	Mon, 24 Mar 2025 11:56:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 00D9E3004AF; Mon, 24 Mar 2025 12:56:13 +0100 (CET)
Date: Mon, 24 Mar 2025 12:56:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Pat Cody <pat@patcody.io>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	riel@surriel.com, patcody@meta.com, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Add null pointer check to pick_next_entity()
Message-ID: <20250324115613.GD14944@noisy.programming.kicks-ass.net>
References: <20250320205310.779888-1-pat@patcody.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320205310.779888-1-pat@patcody.io>

On Thu, Mar 20, 2025 at 01:53:10PM -0700, Pat Cody wrote:
> pick_eevdf() can return null, resulting in a null pointer dereference
> crash in pick_next_entity()

If it returns NULL while nr_queued, something is really badly wrong.

Your check will hide this badness.

Does something like:

  https://lkml.kernel.org/r/20250128143949.GD7145@noisy.programming.kicks-ass.net

help?

