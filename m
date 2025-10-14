Return-Path: <stable+bounces-185649-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E7479BD95B7
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 14:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF57E4FB4F0
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6020311968;
	Tue, 14 Oct 2025 12:34:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A661307ACC
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760445294; cv=none; b=XE9INPDpJ4OoOfIc4sD+pnJkTs6DqxTa+nkOQauR37aM/TlpkNgFuEw9jLe+SwuYrn+tDk5cwWGK6UNn02YL6rY4SJba/lKHV1xt6AjibkXi6MClFZbiR7FXSQbKOxlfzNpO1hZfr8FAAlB2ovHyNZ6PICwvyIYsDt42szDWLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760445294; c=relaxed/simple;
	bh=Q7ApbViSbZxT55NIMBJovMrAt1ZiztiCtjjkU0yeZPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euqdM+opkwAA+KepWHSrHu6J6TVbSKJxD3gCO18stffuViS3nz129jY+PO0KRmDVjB7Oq2yB7DXQOsTWBD/PCBuTzHPuFNQN7D9nxDddsGSdoFbHG2Sn+ef+B47JsOVUgIhuFw3Zg0k9YKOIDgswMUVHF+aH/u7ZYDn81+FJgtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 29F4EC08F4;
	Tue, 14 Oct 2025 12:34:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id EB33C40;
	Tue, 14 Oct 2025 12:34:46 +0000 (UTC)
Date: Tue, 14 Oct 2025 08:34:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Saravana Kannan <saravanak@google.com>, luogengkun@huaweicloud.com,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, runpinglai@google.com,
 torvalds@linux-foundation.org, wattson-external@google.com,
 stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] tracing: Have trace_marker use per-cpu
 data to read user" failed to apply to 6.12-stable tree
Message-ID: <20251014083452.10235c41@gandalf.local.home>
In-Reply-To: <2025101418-buckle-morally-2eb9@gregkh>
References: <2025101354-eject-groove-319c@gregkh>
	<CAGETcx_6c_wMbBWTOEzJ-uX2o8-dodPDAsjmsJyvNd+dp1zoUw@mail.gmail.com>
	<2025101418-buckle-morally-2eb9@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EB33C40
X-Stat-Signature: nqkyn7tkaduzo8m4k836dzk65cthix65
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/nfLCN585RQ2LkdZWsMD2YvOiU4mn/GLE=
X-HE-Tag: 1760445286-665913
X-HE-Meta: U2FsdGVkX18p0qaHXp00D8LAa8D4UrYTb8S2GWGyWk7ZG718UfwkMr2NtrqZbR2mOeoCy3Ygn98TY4VH6BASX4C1rl8k4Vg94u5hCHkxCIy3iXJRLYIdQ6Wr/YqTzpLoBY0IUF7stb3ESykLHSNTge82qu8FxaD9Q5qd7drZt6rjgeOtrKBmN1upNqVSCEo56giaAJXhbmi4Z52rQq0Ik8hXcFlkhbFXPXeaatCppP/iGmE7j3Vfuic584BredKRePYjNGLBqmdOIpG0poFDfhTZldKZ/+dzC1iV+ulMKj6sZunvhIzvHLnZ9DjBl7h1eRZdzRr1m31/46BpjrYiMT7X2ZEXloxZPRQcSKDi2Zlg6RWzEVOQqtTN4A9q/lSpTAuP2gvEzZ3xt+53i2Zlyi3Bsq2M2Srn

On Tue, 14 Oct 2025 07:10:48 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> > 
> > IIRC, this is a fix for something that went in after 6.12. So, don't
> > need to backport it 6.12 or older.  
> 
> The "Fixes:" tag references a commit that is in the following releases
> already:
> 	5.10.245 5.15.194 6.1.153 6.6.107 6.12.48 6.16.8 6.17
> so that's what triggered this message.
> 

Correct. The bug has been there "forever", but because it required
PREEMPT_NONE to trigger, and most people don't use that, it hasn't been
reported.

The fix to the PREEMPT_NONE issue had a regression, thus both fixes
technically need to go back to the beginning.

If I get time, I could work on backporting these patches.

-- Steve

