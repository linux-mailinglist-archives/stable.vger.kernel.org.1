Return-Path: <stable+bounces-200833-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EF2CB7924
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 02:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85F313051622
	for <lists+stable@lfdr.de>; Fri, 12 Dec 2025 01:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E81DF24F;
	Fri, 12 Dec 2025 01:45:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14C145A1F;
	Fri, 12 Dec 2025 01:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765503940; cv=none; b=LNUZHkuyL3sPy5RqDqYtqoAOzii7K3JhoUThq0Y9iKOZPQ6uI/HhS6VVQRHO2D9nCQU5VTqxRq/tZpdphXjfz3WGJkbowg0kz1oduTrj6tGScxUNfgnLoixu4ZGsNJTUYOYNpZlEIimA3cSr6r2J/uz53FvjvYyOFAizLF01GCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765503940; c=relaxed/simple;
	bh=QfBPUcKT9I+Nw29HxanyALmZIWjPdGzyrsLwGbDbwUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCqcUoLdAsQY7kX3jiiWH7xXkfV1NvXXkLQRHbRAGDZ7/G18nIbJ/oa/gEAi35R9uQGw4DUlS+qxvJciMXry3ZhlwT7hNJeQ1kRpRQ8/+9pnupLoa3LuCR46inAxAeWhER+LqtlOqINAi7t58thN3zwpWGsPlgACo1aCW9+mROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 64D48C0283;
	Fri, 12 Dec 2025 01:45:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 1CF782000D;
	Fri, 12 Dec 2025 01:45:25 +0000 (UTC)
Date: Thu, 11 Dec 2025 20:45:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix error handling in event_hist_trigger_parse
Message-ID: <20251211204520.0f3ba6d1@fedora>
In-Reply-To: <20251211100058.2381268-1-linmq006@gmail.com>
References: <20251211100058.2381268-1-linmq006@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1CF782000D
X-Stat-Signature: gj8ajiizoxnubawozm1tbyakyjgfqjtc
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Zglo2jJCielK/en7hEYRkYGWG9/YzCRM=
X-HE-Tag: 1765503925-69920
X-HE-Meta: U2FsdGVkX18mgUeQCYOYyseZA9/yuzUD/piInrSmUqpHfr/v1ZEOE06eR5PGSec0r4G+etUn61PyIk8x1ucvE4j8Kzi/KOgOjh9L/78K2N6FYSVXEPq7DtB+JrJMXih34cLd196zyCxMXTqIoBhmcxQNa9BFvARSGox2CNRKGzun9JKF+YTvkdhTXl3nb+s4nYKyLv4vEfsTcJ7lXW2sK0vfDDb7x7Sr3NCAdVtikx4axElp8uGckapstRGcmw9PZyQXT+liwE7GApnvo2I7QQjquOZYdBuaDKmEXwjOYsnius+6mZZFWZqbt3kTKyw57fg0G7ntyJ/bcPx8ugkSMaNxhWFggsBd

On Thu, 11 Dec 2025 14:00:58 +0400
Miaoqian Lin <linmq006@gmail.com> wrote:

> @@ -6902,7 +6902,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
>  
>  	remove_hist_vars(hist_data);
>  
> -	kfree(trigger_data);
> +	trigger_data_free(trigger_data);
>  
>  	destroy_hist_data(hist_data);
>  	goto out;

The above code has this:

 out_free:
	event_trigger_reset_filter(cmd_ops, trigger_data);

	remove_hist_vars(hist_data);

	kfree(trigger_data);

	destroy_hist_data(hist_data);
	goto out;

Where we have;

void event_trigger_reset_filter(struct event_command *cmd_ops,
				struct event_trigger_data *trigger_data)
{
	if (cmd_ops->set_filter)
		cmd_ops->set_filter(NULL, trigger_data, NULL);
}

And trigger_data_free() starts with:

void trigger_data_free(struct event_trigger_data *data)
{
	if (data->cmd_ops->set_filter)
		data->cmd_ops->set_filter(NULL, data, NULL);


thus it looks like the current code is an open coded version of
trigger_data_free() without synchronization (as it isn't needed here).

Thus, I believe this is more of a clean up and not a fix (something to
go into the next merge window and not the current -rc release).

And the code can be changed to also remove the event_trigger_reset_filter()
call.

-- Steve

