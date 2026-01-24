Return-Path: <stable+bounces-211454-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD97G0WjdGkH8QAAu9opvQ
	(envelope-from <stable+bounces-211454-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:47:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8C47D49F
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 11:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD724301105A
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0531A9F87;
	Sat, 24 Jan 2026 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FvuM82jL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF0AD24
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769251650; cv=none; b=Wg1j/rA+AfuRsq6Xqls8xa1C5nS1QjkGRqhga4uy8MudyUgU3LqxHdxpPae25NDNwVSbBOTZbHtXyC7tZAYW6qBB/vGNVtAXMqswZN13gJdFrMnXxUyGCRDdfotVmDIa8VrI1BqzkbRdEb0FgOBLGFtAXw351lV6SHZs/GlNF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769251650; c=relaxed/simple;
	bh=4Mjk+fF40ceI4R/t2q+AJEgfmjjYtKHo0c/kooa25vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfmaoE544Id60ktLkjn8vkNWBEnNp/dYbeqyLk5HiFoVIcar8BIrNeYls9qKuBISWADDVj4sUNvH2RaXmlYzoUKNTtlvABLZu2ifSWh9IHC54Olm0xeU3QrMZaXwLj53lqH1BnzOnDK9vvIy15byU0SiYEGi56YtqvCFDrgo4JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FvuM82jL; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fbc544b09so2241595f8f.1
        for <stable@vger.kernel.org>; Sat, 24 Jan 2026 02:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769251648; x=1769856448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PDUcuGLtSATdOwWmJYbA7S8LzZRTPKGXoW+hiKHosIk=;
        b=FvuM82jLjmKeL4riRNGE1lH1pAGbka2uEynczkk/S/2glH3NkDNuT77D3lYZFKKXae
         rnN415PJQFxWPa/ehgMkUWArJ6CJZUxMIKROuKnNf7cIM5jkaObUtQkWY/FIotchkyCO
         gXXxjNdEnOmHl16LbcMdYKIXuS86GqiI4naJ8XKVkUQKxVjdfpfz7E1K1pSX8Z0tUuLi
         NaVqtU9ZLLCAF0C2cWXv9YQdHkCrgx5oC+5lA3ZTPdCjhCGC4YMvc5NBuf7aQab3WFf4
         AhW40x8ADwIYibHPk2G9YhP4pErAk8Rp1ucBrTp8PcSMgNy2y/5NssLmQ2Hm6lETNb8J
         oJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769251648; x=1769856448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PDUcuGLtSATdOwWmJYbA7S8LzZRTPKGXoW+hiKHosIk=;
        b=dd0sc2IsZ/289ptOxZwhiWziKVYPKndZjGz8TY6f5FJon8aB/qoFc140m+4nl3djWa
         JJ73JnErs/r2K0yAOYYz/Gtniakdo1BdL6Y8TWVC5OnarVZ0xbZHZtDFlwQS+7zx7bAF
         fGzE03U7x5fhrqKcNvmY26fEuEp1CAVqrRXtD4aOHS3l9wTbVFkZMfXv7imgGWjohQDo
         4OAljg+CuBLa96hWzNnqBavEOOWFNRC5CGtdLpJLO5ychkmsnDu5se985q9haurzCgWd
         A9hxOYGZRKms7wttwbPzoq/ae3s/z25B+o9b/vijSQXN9FyaF93H/hCmUXpQQMAi3uMa
         2NVA==
X-Forwarded-Encrypted: i=1; AJvYcCU5OKV92MOalswZrYw6PI7q/ZSORfF7WYW2gLedlLpCtUuwOC7CWp58e2Tfj+a92nsTZjf/2ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMr1IQJCztkOhSeno6MIfw5KGIzKUXYd44XAYwdqR1tW5Jcwfe
	gIZaE2WeLOUTm0LlXwWDBUBjfQUyzvWRwmPqUqvNGeWl7cMhcHgRPystejSwR8j3NXU=
X-Gm-Gg: AZuq6aIw9E5h9zZlS6zvp/1nGB/RxwPhBGDsjoLTEa3HOwc+ZvzHcYzAIiFJjwyiDJI
	cbISmFIFwGO9KeGRyyk8t+/LvGoO5cNgg0ZvwU7X0+GwHzmWFey0ANsVVMHOzAeOsbmo3g6hf59
	q5soyuEME2IhBfq+XyUrhYnxbrOx4UiqORduFL6UyNVgeLo6X+j9ljQDfJddMSgZBmHkAb0ZX6W
	0tsYccWPUb33cotPAVcJQTftU58RJ8daJmSlYOj+8993VNSKAB52/bcD2ztEeTCEm9Uwf6OkrSq
	pULmCBljEWKN3dTsHeQy+8i8MzD8xdLTswUCsj1BX/deoz4NhfAbAXiufeyOSS+Trc/QzMiTqvf
	afPZLALCiHYpAfHIn34uQ5NOGENqk6brDxXHO9ZN2Xf1AhlbeDkbP5hRWArYkNS++lYFM00ZQCl
	Sf3O+V5Mw6fKSCX1KK2ZzGO5nzUSM=
X-Received: by 2002:a05:6000:40dd:b0:435:a2f8:1515 with SMTP id ffacd0b85a97d-435b1587983mr9884751f8f.10.1769251647634;
        Sat, 24 Jan 2026 02:47:27 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1e7156dsm13469488f8f.20.2026.01.24.02.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 02:47:27 -0800 (PST)
Date: Sat, 24 Jan 2026 13:47:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Haoxiang Li <lihaoxiang@isrc.iscas.ac.cn>
Cc: ioana.ciornei@nxp.com, stuart.yoder@freescale.com, agraf@suse.de,
	German.Rivera@freescale.com, gregkh@linuxfoundation.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Su Hui <suhui@nfschina.com>,
	Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH v3] bus: fsl-mc: fix an error handling in
 fsl_mc_device_add()
Message-ID: <aXSjPNWzsEPhYhv6@stanley.mountain>
References: <20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124102054.1613093-1-lihaoxiang@isrc.iscas.ac.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211454-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dan.carpenter@linaro.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stanley.mountain:mid]
X-Rspamd-Queue-Id: CC8C47D49F
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 06:20:54PM +0800, Haoxiang Li wrote:
> In fsl_mc_device_add(), device_initialize() is called first.
> put_device() should be called to drop the reference if error
> occurs. And other resources would be released via put_device
> -> fsl_mc_device_release. So remove redundant kfree() in
> error handling path.
> 

It is true that we shouldn't free things directly after calling
device_initialize().  I don't know the impact of this bug in
real life.  Is it a leak?

> Fixes: bbf9d17d9875 ("staging: fsl-mc: Freescale Management Complex (fsl-mc) bus driver")
> Cc: stable@vger.kernel.org
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/b767348e-d89c-416e-acea-1ebbff3bea20@stanley.mountain/

Heh.  What was I even talking about when I wrote this???

In my head I remember the code as looking like this:
https://lore.kernel.org/all/20251222074958.992911-1-lihaoxiang@isrc.iscas.ac.cn/
But that's not the version of the code that I copy and pasted into my
email.

The release function looks like this:

drivers/bus/fsl-mc/fsl-mc-bus.c
   757  static void fsl_mc_device_release(struct device *dev)
   758  {
   759          struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
   760  
   761          kfree(mc_dev->regions);
   762  
   763          if (is_fsl_mc_bus_dprc(mc_dev))
   764                  kfree(to_fsl_mc_bus(mc_dev));
   765          else
   766                  kfree(mc_dev);
   767  }

The problem is that if this function call fails:

	mc_dev->dev.type = fsl_mc_get_device_type(obj_desc->type);

Then the is_fsl_mc_bus_dprc() check might not work.  In the current
code the to_fsl_mc_bus() pointer math is a no-op because mc_dev is
the first struct member of mc_bus.  So it works for now, but it
feels wrong.

The fsl_mc_get_device_type() function can't really fail in real
life.

regards,
dan carpenter


