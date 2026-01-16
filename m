Return-Path: <stable+bounces-210017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E4AD2F31A
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 11:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECA4A3045F65
	for <lists+stable@lfdr.de>; Fri, 16 Jan 2026 10:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4301335EDB0;
	Fri, 16 Jan 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGK3lrnZ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ECD35CBCA
	for <stable@vger.kernel.org>; Fri, 16 Jan 2026 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768557638; cv=none; b=Mhpef3qXGMZL8UeUmdlw/R2w/5DgrQhKNdREJYajnRWDnzCx777XpctYI08E1z+rGiP7pYWEZoyvbLfktfMxgqBRFtZbx9oNrkKuMm+u2PkSIQCzkga9esgv6iGCbK8RFmihkEtPbHEG1PNboYWGXty/itwdm4l4RBGsqJfRNLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768557638; c=relaxed/simple;
	bh=I6A95o/X8CnpKTzVzO2Pol4dwHL7tCqE/EtUysH7gMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwOz+1xqSGdw5rP0xnC2Sw65GZ98qVW3Kc88w1IvWY0lKDra8d68cc6dmqJheWA0sL/L7A3/gycoZmQrL/EapV5YtzxBxwmg1G7gQCDiVxtKsz9W0c2mqQPPI5rSD2/n/WkJ2flbh1ST1x7rlQMFsNdSB1UvXzJ+b39PsqneRp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGK3lrnZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768557636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Po7NdxSsWJ6IgzY3QAl2TCrwhNLQTMDrhioZSMRdL0Q=;
	b=JGK3lrnZvZzudVUAwpXfEq5aZNEPzvPyUFXKJxGElIfNlzeoDm9hK6gFENq1rYp89JO+SY
	LoJD6KEGwjSlI5kQD1/WTDnIiQJ/Tq3pb//dDJk4qgZVsw6RPAaNNac9VmGaXqJxghyLY5
	EDfd6/rdv3RzUnq0fzpyqXQFqbIloyw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-h9t6nH2QOG6MeT1JcigFXw-1; Fri,
 16 Jan 2026 05:00:31 -0500
X-MC-Unique: h9t6nH2QOG6MeT1JcigFXw-1
X-Mimecast-MFC-AGG-ID: h9t6nH2QOG6MeT1JcigFXw_1768557629
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E5F219560AD;
	Fri, 16 Jan 2026 10:00:29 +0000 (UTC)
Received: from fedora (unknown [10.44.33.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C28161955F22;
	Fri, 16 Jan 2026 10:00:25 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 16 Jan 2026 11:00:28 +0100 (CET)
Date: Fri, 16 Jan 2026 11:00:23 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: tip-bot2 for Oleg Nesterov <tip-bot2@linutronix.de>
Cc: linux-tip-commits@vger.kernel.org, Paulo Andrade <pandrade@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	stable@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [tip: perf/core] x86/uprobes: Fix XOL allocation failure for
 32-bit tasks
Message-ID: <aWoMN5oCPIl2M2DP@redhat.com>
References: <aWO7Fdxn39piQnxu@redhat.com>
 <176851343815.510.11862479025865189952.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176851343815.510.11862479025865189952.tip-bot2@tip-bot2>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 01/15, tip-bot2 for Oleg Nesterov wrote:
>
> The following commit has been merged into the perf/core branch of tip:

Damn!

thanks Peter, but...

> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -1823,3 +1823,27 @@ bool is_uprobe_at_func_entry(struct pt_regs *regs)
>
>  	return false;
>  }
> +
> +#ifdef CONFIG_IA32_EMULATION
> +unsigned long __weak arch_uprobe_get_xol_area(void)

Oh, but x86 version should not be __weak. Copy-and-paste error, sorry :/

What do you want me to do now,

	- send V2 ?

	- send another s/__weak// patch on top of this hack?

	- or perhaps you can fix this yourself?

Oleg.


