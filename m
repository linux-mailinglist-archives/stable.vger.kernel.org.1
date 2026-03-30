Return-Path: <stable+bounces-231285-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNp7ATbrymkkBQYAu9opvQ
	(envelope-from <stable+bounces-231285-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:29:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 205AC361779
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 23:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 06FA5301071B
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 21:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CD539EF1A;
	Mon, 30 Mar 2026 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IAov1hn8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534823AE62;
	Mon, 30 Mar 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906151; cv=none; b=gVSG6FcROWNCbncXzWHBV8LHB+WXd70esQli+U6Xs0kZFxIZcIvPbKTCnCX4ANVj2YsYvcEfs9VjqQNdU9z+PGqWTcve9VoSJiMXW5GwmBn+tYkcRaxXIk0Dx2pkuTVvwc+AlU3nAz4oID/rN6Zx4+8OIdHKworwcjuTt7yKT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906151; c=relaxed/simple;
	bh=7YXvq1MsfQHE3SrFhAi3vCgluhob3a3rWMvitZkC0fM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ah70nXLLJL09eem0hVxcz+6hlsZtcpHVvDUEgpBr6qLjW+uIOQyNUfcc8WdzCPIvSQMiTUulQEdI9sOe4hPMI4bcC1aUFo/gxhhZkfXKPgLFP7sWsvkYKS+OSeLvKrUhBud+WktrCeYyeSTsBGtw0UqP/CmQQ0LsBB3qCqn1u8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IAov1hn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DEAC4CEF7;
	Mon, 30 Mar 2026 21:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774906150;
	bh=7YXvq1MsfQHE3SrFhAi3vCgluhob3a3rWMvitZkC0fM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IAov1hn81U6kG0aCTcncnSjiJRArpiMQrTaBVIw8QyU9tvjmvb/+CNfXk++EXW+D2
	 FTG0N/F4ica+PuIMkTUCCtKPXWN0khQ49JsfEnReJMwzVjpPIuLjFU8fDL0nwG/EH5
	 aDWhT2cuJlF3wxpdI9I+4EveV4YxYFjkVGd+L4iY=
Date: Mon, 30 Mar 2026 14:29:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yiyang Chen <cyyzero16@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org, Wang
 Yaxin <wang.yaxin@zte.com.cn>, Fan Yu <fan.yu9@zte.com.cn>,
 "Dr . Thomas Orgis" <thomas.orgis@uni-hamburg.de>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] taskstats: set version in TGID exit notifications
Message-Id: <20260330142909.3a5fe0ce22798a8cc34a8abe@linux-foundation.org>
In-Reply-To: <ba83d934e59edd431b693607de573eb9ca059309.1774810498.git.cyyzero16@gmail.com>
References: <cover.1774810498.git.cyyzero16@gmail.com>
	<ba83d934e59edd431b693607de573eb9ca059309.1774810498.git.cyyzero16@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231285-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,zte.com.cn,uni-hamburg.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 205AC361779
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 03:00:40 +0800 Yiyang Chen <cyyzero16@gmail.com> wrote:

> delay accounting started populating taskstats records with a valid
> version field via fill_pid() and fill_tgid().
> 
> Later, commit ad4ecbcba728 ("[PATCH] delay accounting taskstats
> interface send tgid once") changed the TGID exit path to send the
> cached signal->stats aggregate directly instead of building the outgoing
> record through fill_tgid(). Unlike fill_tgid(), fill_tgid_exit() only
> accumulates accounting data and never initializes stats->version.
> 
> As a result, TGID exit notifications can reach userspace with
> version == 0 even though PID exit notifications and
> TASKSTATS_CMD_GET replies carry a valid taskstats version.
> 
> Set stats->version = TASKSTATS_VERSION after copying the cached TGID
> aggregate into the outgoing netlink payload so all taskstats records are
> self-describing again.
> 
> Fixes: ad4ecbcba728 ("[PATCH] delay accounting taskstats interface send tgid once")

Thanks, lol, 20 years ago.

Can you explain how others can trigger this?  Some combination of
steps which results in the bad output?

> Cc: stable@vger.kernel.org

Is there a chance of breaking existing userspace here?  Some existing
userspace code which is expecting 0 here and will get surprised by this
change?

> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -649,6 +649,7 @@ void taskstats_exit(struct task_struct *tsk, int group_dead)
>  		goto err;
>  
>  	memcpy(stats, tsk->signal->stats, sizeof(*stats));
> +	stats->version = TASKSTATS_VERSION;
>  
>  send:
>  	send_cpu_listeners(rep_skb, listeners);


