Return-Path: <stable+bounces-230564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJhdD8PaxWneCQUAu9opvQ
	(envelope-from <stable+bounces-230564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:17:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AB56A33DC71
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 02:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82D79303DF51
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 01:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25E29DB88;
	Fri, 27 Mar 2026 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8wbJjBq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45232475CE;
	Fri, 27 Mar 2026 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574270; cv=none; b=SmT0pZBxt7CVEqIuqbfUHLF7FlE2pJ9GhlJcIFfjOXkuMEH/7rrl87XhAzCyIQW8HyKZ4DgTEx53EQai1HYrqaNNuOg0xamIUzo7M0KA3/ZxKnqArGyo2XuS4TeP0zccWr3pjC9gXrRq3yD3ra1Sq+aKa9FIkDtRhKEe4EeqbLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574270; c=relaxed/simple;
	bh=Fj+wzq/6iKYICFkTGU/r8tL7mIACYw3BRf1GTOTNh94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jfavmm0WUsPFhMrVWKo5gdrHxG8eGRoSlUaHOMvkjCoTPIMrvCv7z+HA77eC4yBZZk3gSbz+MYv7fw254xKEF+DWAv6gs+3X29X7JxjT5akC0LaHjWO+0He3KTWftrzBMGKy7mf+EM4grC7jzTylSvcNVCz3vLr5jxl1FtKQbUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8wbJjBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622C3C116C6;
	Fri, 27 Mar 2026 01:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774574269;
	bh=Fj+wzq/6iKYICFkTGU/r8tL7mIACYw3BRf1GTOTNh94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N8wbJjBqfUz1iZ2pyro304QYGXMLlo329AaeIw2pH/rYmSXhksT98yYQxIsqmd/md
	 hSCuS1AclGoRsOQIWSn67Xp/JXgSdsXyMQ8WQkQATgKC9sb5DNhFEYcpcM5z0K48Dh
	 YUXQ57CH0WqKbdty5tYJDAn0+5Oq8vf6mtQ7au+iYM9i3g/+SjN48XvPjzmJTSymbj
	 cnFWpHCq4IWFJqPPquXDsSRd/F3uhzxqfXO87YO7nYFZK3VaYvrYApCH1zlAtfIAvI
	 9tEY3RuglpzUiojnhamHfDdVxRImwkuhqWcaMWYVF3m4QNFvKD9sG9bzVNKdFnTVaI
	 orhB8UPMLOUbg==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko review) [PATCH] mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails
Date: Thu, 26 Mar 2026 18:17:47 -0700
Message-ID: <20260327011747.66127-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327003224.55752-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230564-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: AB56A33DC71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Forwarding Sashiko review for doing discussions via mails.

# review url: https://sashiko.dev/#/patchset/20260327003224.55752-1-sj@kernel.org
# start of sashiko.dev inline review
commit aba7f94d0accfda5ab9b573157f691de9e9acf00
Author: SeongJae Park <sj@kernel.org>

mm/damon/sysfs: dealloc repeat_call_control if damon_call() fails

This commit attempts to fix a memory leak where repeat_call_control is
not deallocated if damon_call() fails because the kdamond stopped before
the invocation. It adds a check to free repeat_call_control when
damon_call() returns an error.

Link: https://lore.kernel.org/20260320020630.962-1-sj@kernel.org

> diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> index 6a44a2f3d8fc..eefa959aa30a 100644
> --- a/mm/damon/sysfs.c
> +++ b/mm/damon/sysfs.c
> @@ -1670,7 +1670,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
>  	repeat_call_control->data = kdamond;
>  	repeat_call_control->repeat = true;
>  	repeat_call_control->dealloc_on_cancel = true;
> -	damon_call(ctx, repeat_call_control);
> +	if (damon_call(ctx, repeat_call_control))
> +		kfree(repeat_call_control);

Does this fully resolve the leak of repeat_call_control?

If a sysfs writer thread calls damon_call() during kdamond shutdown,
after the worker thread in kdamond_fn() flushes pending controls but
before it sets ctx->kdamond = NULL:

kdamond_fn()
   kdamond_call(ctx, true);
   ...
   // Before ctx->kdamond = NULL

Would damon_call() add the new request to ctx->call_controls and return 0
since ctx->kdamond is not yet NULL and repeat is true?

If so, does this leave repeat_call_control in the queue and leaked since
the worker is already exiting and this check is bypassed?

Could this same window also cause a deadlock for synchronous commands like
DAMON_SYSFS_CMD_UPDATE_SCHEMES_STATS?

If a synchronous command with repeat = false is added to the queue during
this same window, would the caller hang indefinitely on
wait_for_completion() since the worker thread will never process the queue
again?

>  	return err;
>  }


# end of sashiko.dev inline review
# review url: https://sashiko.dev/#/patchset/20260327003224.55752-1-sj@kernel.org
#
# hkml [1] generated a draft of this mail.  It can be regenerated
# using below command:
#
#     hkml patch sashiko_dev --for_forwarding \
#             20260327003224.55752-1-sj@kernel.org
#
# [1] https://github.com/sjp38/hackermail

Sent using hkml (https://github.com/sjp38/hackermail)

