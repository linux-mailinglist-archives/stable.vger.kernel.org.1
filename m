Return-Path: <stable+bounces-211176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UESZLLlHcWn2fgAAu9opvQ
	(envelope-from <stable+bounces-211176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 22:40:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E6A5E28A
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 22:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65BA3845FFC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A3536828B;
	Wed, 21 Jan 2026 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YFto5k+3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592731ED76;
	Wed, 21 Jan 2026 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029922; cv=none; b=lpsNCdtNshooF5KbTbaKHq21g8a7gcnZt+Lnt018cPDNChWfdd7BqJqfToWfrwXQLixo8iX3B/SMgkTcbjBOPF4+UoA+8Um8/dXzvvwFiQgt9HDsyw87C7vYnTPCfjV4i1HSUIez3FFJtHYwIHfABfO5AbgS6kvlgkmNTz/IC8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029922; c=relaxed/simple;
	bh=cKkDGToA2WsvYKCVW5FMEWKTgWM39uetqLmO4hz0nRU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r/x9QQ1cBMDIVnGshAU4vZwdxDPCe/m4ZVVJGtQHr+6stDcjwl/fqZAjaNjSIe04MxnHF2kvUjKSBzKYlMP12VjVwtc3xu8gZ4nqRjAGx42wkGAsodh4Exc/ioqCo060DnJMurM8RCp/M0Dagn2NFY9y+QjyXC/MNgFopGWdMYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YFto5k+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED05C4CEF1;
	Wed, 21 Jan 2026 21:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769029922;
	bh=cKkDGToA2WsvYKCVW5FMEWKTgWM39uetqLmO4hz0nRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YFto5k+3a9v4ShCqV4I4yR3g7oN9rtseaiTzC3PhdDwIiB5PpfGHuVVyZilATRAYq
	 IqtE7aNlv7SE2LazfkF3h5rcjG5apfWZFMDh5yyu2NnQzoqblIfNGF/qb8vJBJC0JC
	 YCqaCdf1O8Gg4Yjui09wCQQN8WYR2h+BiTyirsv0=
Date: Wed, 21 Jan 2026 13:12:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: mporter@kernel.crashing.org, alex.bou9@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] rapidio: replace rio_free_net() with kfree() in
 rio_scan_alloc_net()
Message-Id: <20260121131201.488ea7fa63f576f22db026b6@linux-foundation.org>
In-Reply-To: <20260121013508.195836-1-lihaoxiang@isrc.iscas.ac.cn>
References: <20260121013508.195836-1-lihaoxiang@isrc.iscas.ac.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211176-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.crashing.org,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,iscas.ac.cn:email,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 53E6A5E28A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 09:35:08 +0800 Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn> wrote:

> When idtab allocation fails, net is not registered with rio_add_net()
> yet, so kfree(net) is sufficient to release the memory.
> Set mport->net to NULL to avoid dangling pointer.
> 
> ...
>
> --- a/drivers/rapidio/rio-scan.c
> +++ b/drivers/rapidio/rio-scan.c
> @@ -854,7 +854,8 @@ static struct rio_net *rio_scan_alloc_net(struct rio_mport *mport,
>  
>  		if (idtab == NULL) {
>  			pr_err("RIO: failed to allocate destID table\n");
> -			rio_free_net(net);
> +			kfree(net);
> +			mport->net = NULL;

Sure.  Might not have any effect, but it's defensive.

>  			net = NULL;
>  		} else {
>  			net->enum_data = idtab;

I'll add this to the 6.20(?)-rcX queue soon, unless someone stops me.


