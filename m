Return-Path: <stable+bounces-255088-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lJzmL6mKGGrlkwgAu9opvQ
	(envelope-from <stable+bounces-255088-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:34:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C525E5F65C9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AA457301EB3F
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593B432B13E;
	Thu, 28 May 2026 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBolM2Jh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4581232B126;
	Thu, 28 May 2026 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779993248; cv=none; b=UApfe+bHUkea938ZZ34gz+j3izRPoOmv6ykr5+SbgkX1XalDwezItvAlgaAuzvTcMMXwj4rAq3O3FyeB1UPDQfPprpfH3QBL6p69LI7u6mmZC67Q2/80ZgHWCSX9wgEOHJvcbXsYVVfhek6Wm+shZySidwYZbawxaUltGapyrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779993248; c=relaxed/simple;
	bh=zOMYPUQVHW4t4sGkcjtMhdQdnMt80//KjZAO1KFNhJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8+4vRweX/ba5OrDCUBkdVyNIARMxC+27SY4KfXNRvDa7lsrJwZioQhGjInQguUc+8QLh3WD+uf03TIY8ranOzELhWU6dl7BUw65lW45ETYzpU6rdj6h0MN9Wc6g6Y0PYZh0j7OKKvXYJmrXWP/v7h6zOLOfTNydAlVDmBhuubU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBolM2Jh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864271F00A3D;
	Thu, 28 May 2026 18:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779993246;
	bh=1qy10XGAAa5iZJHi6FU1ig07Wgyq9EcxUSf7QXsyTeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JBolM2JhtK0IJ1MgtlMs1uZWH+IC7y7NgSF9Q0d9iajbJoz/o8KSI9vlEzt4Nv2O1
	 I/2x5ZT+7xjojQuVyfNVjhr7Lb5AzIehzMS6GNuh/3fVeuF5TzPwEbJ3e/3cXADppR
	 hj6vh7rh4X5SzR586b01xm/p00w5oHFVG+pjZxW6GrzRPCyIfN27XNSePEVIXaX1d7
	 7ysfYFwT+p5IDZ+dAkfk8K1K+DQAmsza5FQqoxu0mH0wUhE6h68iN/S26kv7bQbKik
	 htfSlBq0abxo4oHVO2h9Cff2xLr9uPc3gdaYIgQsMYBUA+Cu3LRW3ak7ftWK2R3xrc
	 tslK38INBMTBQ==
Date: Thu, 28 May 2026 11:34:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: shaper: use kfree_rcu() in net_shaper_flush()
Message-ID: <20260528113405.34a87c54@kernel.org>
In-Reply-To: <20260528160845.2636043-1-tristan@talencesecurity.com>
References: <20260528160845.2636043-1-tristan@talencesecurity.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-255088-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C525E5F65C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 16:08:45 +0000 Tristan Madani wrote:
> net_shaper_flush() frees shaper objects with plain kfree() after
> xa_erase(), but net_shaper_nl_get_doit() and net_shaper_nl_get_dumpit()
> read shaper objects under rcu_read_lock() via xa_load().  This creates a
> use-after-free window where an RCU reader may still hold a pointer to a
> shaper object that has been freed.
> 
> The race is:
> 
>   CPU 0 (reader)                    CPU 1 (flush/unregister)
>   rcu_read_lock()
>   shaper = xa_load(...)             xa_lock()
>   // shaper points to valid obj     __xa_erase(...)
>                                     kfree(shaper)  <- frees immediately
>   net_shaper_fill_one(shaper)       xa_unlock()
>   // use-after-free
>   rcu_read_unlock()
> 
> Other code paths in the same file already use kfree_rcu() correctly
> (net_shaper_pre_insert error path, net_shaper_notify_down,
> net_shaper_cap_pair_update, and net_shaper_rollback as of commit
> b8d7519352ba).  The struct net_shaper already contains an rcu_head field.
> 
> Fix by replacing kfree() with kfree_rcu() in net_shaper_flush() to
> defer freeing until after the RCU grace period.
> 
> Found by source code audit.

No, the device is fully invisible at this point.

Please don't send fixes unless you can actually trigger the crash.
-- 
pw-bot: reject
pv-bot: slop

